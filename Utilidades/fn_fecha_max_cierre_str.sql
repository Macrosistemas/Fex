CREATE OR ALTER FUNCTION dbo.fn_fecha_comprobante_ajustada
(
    @fecha_comprobante DATETIME
)
RETURNS VARCHAR(30)
AS
BEGIN
    DECLARE 
        @fecha_cierre7   DATETIME,
        @fecha_cierre50  DATETIME,
        @fecha_max       DATETIME,
        @fecha_resultado DATETIME;

    SELECT @fecha_cierre7 = fecha_cierre
    FROM sistemas
    WHERE codigo = 7;

    SELECT @fecha_cierre50 = fecha_cierre
    FROM sistemas
    WHERE codigo = 50;

    SELECT @fecha_max = MAX(f)
    FROM (VALUES (@fecha_cierre7), (@fecha_cierre50)) AS Fechas(f);

    SET @fecha_max = ISNULL(@fecha_max, '1900-01-01');

    SET @fecha_resultado =
        CASE 
            WHEN @fecha_comprobante < @fecha_max
                THEN DATEADD(DAY, 1, @fecha_max)
            ELSE @fecha_comprobante
        END;

    RETURN CONVERT(VARCHAR(30), @fecha_resultado, 121);
END;
GO
