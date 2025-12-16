CREATE PROCEDURE dbo.sp_calcula_iva_compras
    @id_cabecera INT,

    @neto21     DECIMAL(18,2) OUTPUT,
    @iva21      DECIMAL(18,2) OUTPUT,

    @neto105    DECIMAL(18,2) OUTPUT,
    @iva105     DECIMAL(18,2) OUTPUT,

    @neto27     DECIMAL(18,2) OUTPUT,
    @iva27      DECIMAL(18,2) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        @neto21  = SUM(CASE WHEN alicuota_iva = 21   THEN ISNULL(concepto_gravado,0) ELSE 0 END),
        @iva21   = SUM(CASE WHEN alicuota_iva = 21   THEN ISNULL(importe_iva,0)      ELSE 0 END),

        @neto105 = SUM(CASE WHEN alicuota_iva = 10.5 THEN ISNULL(concepto_gravado,0) ELSE 0 END),
        @iva105  = SUM(CASE WHEN alicuota_iva = 10.5 THEN ISNULL(importe_iva,0)      ELSE 0 END),

        @neto27  = SUM(CASE WHEN alicuota_iva = 27   THEN ISNULL(concepto_gravado,0) ELSE 0 END),
        @iva27   = SUM(CASE WHEN alicuota_iva = 27   THEN ISNULL(importe_iva,0)      ELSE 0 END)
    FROM ingreso_comprobantes_compras_items
    WHERE id_cabecera = @id_cabecera;

    SET @neto21  = ISNULL(@neto21, 0);
    SET @iva21   = ISNULL(@iva21, 0);
    SET @neto105 = ISNULL(@neto105, 0);
    SET @iva105  = ISNULL(@iva105, 0);
    SET @neto27  = ISNULL(@neto27, 0);
    SET @iva27   = ISNULL(@iva27, 0);
END
GO
