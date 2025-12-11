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