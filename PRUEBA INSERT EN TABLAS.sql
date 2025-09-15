-- Insertar en la tabla de cabecera

delete ingreso_comprobantes_compras_asiento
delete ingreso_comprobantes_compras_items
delete ingreso_comprobantes_compras_cabecera
INSERT INTO dbo.ingreso_comprobantes_compras_cabecera (
    codigo, letra, sucursal, numero, denominacion, cuit, fecha_comprobante, 
    fecha_iva, fecha_vencimiento, moneda, valor_dolar, monto_bonificacion, 
    monto_descuento, monto_financiacion, monto_impuesto, monto_impuesto_no_computable, 
    importe_perc_canje, monto_percepcion_iva, monto_percepcion_ganancia, 
    monto_percepcion_ingbru, monto_percepcion_rg3337, concepto_gravado, 
    importe_iva, concep_no_gravado, total_general, codigo_rubro_gasto, 
    codigo_lugar_pago, observaciones_1, contrato, cod_regimen_ganancias, 
    fecha_hora_ingreso, tipo_comprobante
) VALUES (
    1, 'A', 998, 998, 'Proveedor Ejemplo', '20245869712', '2025-01-01', 
    '2025-01-01', '2025-01-01', 1, 350.75, NULL, 
    NULL, NULL, NULL, NULL, 
    NULL, NULL, NULL, 
    NULL, NULL, 4000.00, 
    840.00, 160.00, 5000.00, NULL, 
    NULL, 'Observaciones de prueba', NULL, NULL, 
    GETDATE(), 'FC'
);

-- Obtener el ID de la cabecera insertada
DECLARE @id_cabecera INT = SCOPE_IDENTITY();

-- Insertar en la tabla de items
INSERT INTO dbo.ingreso_comprobantes_compras_items (
    id_cabecera, codigo_articulo, denominacion_articulo, cantidad, precio, 
    porc_descuento, alicuota_iva, concepto_gravado, importe_iva, concep_no_gravado, 
    obra, fecha_hora_ingreso
) VALUES (
    @id_cabecera, -- id_cabecera (clave foránea)
    1001, -- código del artículo
    'Artículo de Ejemplo', -- denominación del artículo
    10.0000, -- cantidad
    500.0000, -- precio
    10.00, -- porcentaje de descuento
    21.00, -- alícuota de IVA
    4500.00, -- concepto gravado
    945.00, -- importe de IVA
    55.00, -- concepto no gravado
    1, -- obra
    GETDATE() -- fecha y hora de ingreso
);

-- Obtener el ID del ítem insertado
DECLARE @id_item INT = SCOPE_IDENTITY();

-- Insertar en la tabla de asientos contables
INSERT INTO dbo.ingreso_comprobantes_compras_asiento (
    id_cabecera, cuenta_contable, importe_debe, importe_haber, concepto, 
    detalle_comprobante, sector, actividad, subactividad, centro_costo
) VALUES (
    @id_cabecera, -- id_cabecera (clave foránea)
    '41104', -- cuenta contable
    5000.00, -- importe debe
    0.00, -- importe haber
    'DEBE', -- concepto
    'Detalle DEBE Comprobante Ejemplo', -- detalle del comprobante
    1, -- sector
    101, -- actividad
    5, -- subactividad
    10 -- centro de costo
);


-- Insertar en la tabla de asientos contables
INSERT INTO dbo.ingreso_comprobantes_compras_asiento (
    id_cabecera, cuenta_contable, importe_debe, importe_haber, concepto, 
    detalle_comprobante, sector, actividad, subactividad, centro_costo
) VALUES (
    @id_cabecera, -- id_cabecera (clave foránea)
    '11101', -- cuenta contable
    0.00,  -- importe debe
    4000.00,-- importe haber
    'HABER', -- concepto
    'Detalle HABER Comprobante Ejemplo', -- detalle del comprobante
    1, -- sector
    101, -- actividad
    5, -- subactividad
    10 -- centro de costo
);


-- Insertar en la tabla de asientos contables
INSERT INTO dbo.ingreso_comprobantes_compras_asiento (
    id_cabecera, cuenta_contable, importe_debe, importe_haber, concepto, 
    detalle_comprobante, sector, actividad, subactividad, centro_costo
) VALUES (
    @id_cabecera, -- id_cabecera (clave foránea)
    '21405', -- cuenta contable
    0.00,  -- importe debe
    1000.00,-- importe haber
    'IVA', -- concepto
    'Detalle IVA de Comprobante Ejemplo', -- detalle del comprobante
    1, -- sector
    101, -- actividad
    5, -- subactividad
    10 -- centro de costo
);

