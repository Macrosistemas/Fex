IF dbo.f_existe('ingreso_comprobantes_compras_cabecera.estado_stock') = 'N' BEGIN         
    ALTER TABLE ingreso_comprobantes_compras_cabecera ADD estado_stock VARCHAR(1) 
END;

IF dbo.f_existe('ingreso_comprobantes_compras_cabecera.deposito') = 'N' BEGIN     
    ALTER TABLE ingreso_comprobantes_compras_cabecera ADD deposito NUMERIC(8) 
END;

IF dbo.f_existe('ingreso_comprobantes_compras_items.serie') = 'N' BEGIN     
    ALTER TABLE ingreso_comprobantes_compras_items ADD serie VARCHAR(50) NULL 
END;
------------------------------------------------------------------------------------------------------
IF dbo.f_existe('ingreso_comprobantes_compras_items.renglon_vinc') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_items ADD renglon_vinc numeric(4,0) null 
END;

IF dbo.f_existe('ingreso_comprobantes_compras_items.deposito') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_items ADD deposito numeric(8,0) null 
END;

IF dbo.f_existe('ingreso_comprobantes_compras_cabecera.tipo_impresion') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_cabecera alter column tipo_impresion char(1) null 
END;


IF dbo.f_existe('ingreso_comprobantes_compras_cabecera.tipo_impuesto') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_cabecera ADD tipo_impuesto numeric(2,0) null 
END;

IF dbo.f_existe('ingreso_comprobantes_compras_cabecera.tipo_no_grabado') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_cabecera ADD tipo_no_grabado numeric(2,0) null 
END;


IF dbo.f_existe('ingreso_comprobantes_compras_items.codigo_vinc') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_items ADD codigo_vinc numeric(4,0) null 
END;

IF dbo.f_existe('ingreso_comprobantes_compras_items.letra_vinc') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_items ADD letra_vinc char(3)  null 
END;

IF dbo.f_existe('ingreso_comprobantes_compras_items.sucursal_vinc') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_items ADD sucursal_vinc numeric (5,0) null 
END;

IF dbo.f_existe('ingreso_comprobantes_compras_items.numero_vinc') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_items ADD numero_vinc numeric(8,0) null 
END;

IF dbo.f_existe('ingreso_comprobantes_compras_items.orden_vinc') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_items ADD orden_vinc numeric(4,0) null 
END;

IF dbo.f_existe('ingreso_comprobantes_compras_items.renglon_vinc') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_items ADD renglon_vinc numeric(4,0) null 
END;

IF dbo.f_existe('ingreso_comprobantes_compras_items.deposito') = 'N' BEGIN 
    ALTER TABLE dbo.ingreso_comprobantes_compras_items ADD deposito numeric(8,0) null 
END;    