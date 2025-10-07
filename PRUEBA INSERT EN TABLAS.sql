USE [pruebasfex];
GO

INSERT INTO [dbo].[ingreso_comprobantes_compras_cabecera] (
    codigo, letra, sucursal, numero, denominacion, cuit,
    fecha_comprobante, fecha_iva, fecha_vencimiento,
    moneda, valor_dolar,
    monto_bonificacion, monto_descuento, monto_financiacion, monto_impuesto, monto_impuesto_no_computable,
    importe_perc_canje, monto_percepcion_iva, monto_percepcion_ganancia, monto_percepcion_ingbru, monto_percepcion_rg3337,
    concepto_gravado, importe_iva, concep_no_gravado, total_general,
    codigo_rubro_gasto, codigo_lugar_pago, observaciones_1, contrato,
    cod_regimen_ganancias, fecha_hora_ingreso, fecha_hora_procesado_macrogest, tipo_comprobante, errores_importacion, estado_stock, deposito
)
VALUES (
    1, 'A', 1, 12345, 'Proveedor Ejemplo S.A.', '20047167982',
    GETDATE(), GETDATE(), DATEADD(DAY, 30, GETDATE()),
    1, 1.0000,
    0, 0, 0, 21000, 0,
    0, 0, 0, 0, 0,
    100000, 21000, 0, 121000,
    null, null, null, null,
    78, GETDATE(), NULL, 'FC', NULL, 'N', 0
);


DECLARE @idCabecera INT = SCOPE_IDENTITY();


INSERT INTO [dbo].[ingreso_comprobantes_compras_items] (
    id_cabecera, codigo_articulo, denominacion_articulo, cantidad, precio,
    porc_descuento, alicuota_iva, concepto_gravado, importe_iva,
    concep_no_gravado, obra, fecha_hora_ingreso, fecha_hora_procesado_macrogest,
    errores_importacion, SERIE
)
VALUES
(@idCabecera, 1001, 'Tornillos galvanizados 1/2"', 100, 1000.0000, 0, 21.00, 100000, 21000, 0, NULL, GETDATE(), NULL, NULL, 'SER-0001'),
(@idCabecera, 1002, 'Arandelas acero inoxidable', 50, 200.0000, 0, 21.00, 10000, 2100, 0, NULL, GETDATE(), NULL, NULL, 'SER-0002');



INSERT INTO [dbo].[ingreso_comprobantes_compras_asiento] (
    id_cabecera, cuenta_contable, importe_debe, importe_haber, concepto,
    detalle_comprobante, sector, actividad, subactividad, centro_costo,
    errores_importacion, CODIGO_OBJETO_COSTO
)
VALUES
(@idCabecera, '500101', 121000.00, 0.00, 'Compra de mercaderías', 'Factura A 0001-000012345', 1, 1, 0, 10, NULL, 100),
(@idCabecera, '200201', 0.00, 121000.00, 'Proveedores a pagar', 'Factura A 0001-000012345', 1, 1, 0, 10, NULL, 100);

