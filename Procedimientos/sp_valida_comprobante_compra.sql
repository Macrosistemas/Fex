USE [msgestion01]
GO

/****** Object:  StoredProcedure [dbo].[sp_valida_comprobante_compra]    Script Date: 04/02/2026 9:32:48 ******/
DROP PROCEDURE [dbo].[sp_valida_comprobante_compra]
GO

/****** Object:  StoredProcedure [dbo].[sp_valida_comprobante_compra]    Script Date: 04/02/2026 9:32:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE  PROCEDURE [dbo].[sp_valida_comprobante_compra]
(
    @codigo            INT,
    @letra             VARCHAR(4),
    @sucursal          INT,
    @numero            INT,
    @cuit              VARCHAR(20),
    @fecha_comprobante DATETIME,
    @total_general     NUMERIC(18,2),

    @orden   INT OUTPUT,
    @ls_sigo CHAR(1) OUTPUT
)
AS
BEGIN
    SET NOCOUNT ON;

    ------------------------------------------------------------
    -- Grupo de código
    ------------------------------------------------------------
    DECLARE @grupo_codigo INT;

    SET @grupo_codigo =
        CASE
            WHEN @codigo IN (1,30,201,230) THEN 1
            WHEN @codigo IN (2,42,202,242) THEN 2
            WHEN @codigo IN (3,4,203,204)  THEN 3
            ELSE 0
        END;

    -- defaults
    SET @ls_sigo = 'S';
    SET @orden   = 0;

    ------------------------------------------------------------
    -- Buscar coincidencias UNA sola vez
    ------------------------------------------------------------
    DECLARE
        @hay_mismo_proveedor INT = 0,
        @hay_otro_proveedor  INT = 0;

    SELECT
        @hay_mismo_proveedor = MAX(CASE WHEN numero_cuit = @cuit THEN 1 ELSE 0 END),
        @hay_otro_proveedor  = MAX(CASE WHEN numero_cuit <> @cuit THEN 1 ELSE 0 END)
    FROM compras2 WITH (NOLOCK)
    WHERE
        (
            (@grupo_codigo = 1 AND codigo IN (1,30,201,230))
         OR (@grupo_codigo = 2 AND codigo IN (2,42,202,242))
         OR (@grupo_codigo = 3 AND codigo IN (3,4,203,204))
        )
        AND letra = @letra
        AND sucursal = @sucursal
        AND numero = @numero
        AND CONVERT(date, fecha_comprobante) = CONVERT(date, @fecha_comprobante)
        AND monto_general = @total_general;

    ------------------------------------------------------------
    -- 1) Duplicado real
    ------------------------------------------------------------
    IF @hay_mismo_proveedor = 1
    BEGIN
        SET @ls_sigo = 'N';
        RETURN;
    END;

    ------------------------------------------------------------
    -- 2) Mismo comprobante, otro proveedor
    ------------------------------------------------------------
    IF @hay_otro_proveedor = 1
    BEGIN
        SELECT
            @orden = ISNULL(MAX(orden), 0) + 99
        FROM compras2 WITH (NOLOCK)
        WHERE
            (
                (@grupo_codigo = 1 AND codigo IN (1,30,201,230))
             OR (@grupo_codigo = 2 AND codigo IN (2,42,202,242))
             OR (@grupo_codigo = 3 AND codigo IN (3,4,203,204))
            )
            AND letra = @letra
            AND sucursal = @sucursal
            AND numero = @numero
            AND CONVERT(date, fecha_comprobante) = CONVERT(date, @fecha_comprobante);

        RETURN;
    END;

    ------------------------------------------------------------
    -- 3) Comprobante nuevo
    ------------------------------------------------------------
    SET @orden = 0;
END

GO

