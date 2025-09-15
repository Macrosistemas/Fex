USE [obring]
GO
/****** Object:  StoredProcedure [dbo].[sp_inserta_compras5]    Script Date: 06/02/2025 10:22:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_inserta_compras5]
@id NUMERIC(4,0),
@ls_cuenta_descripcion VARCHAR(50),
@ls_cuenta_contable_mg VARCHAR(12),
@renglon INT,
@id_asiento INT
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON;

        -- Declaración de variables
        DECLARE @ls_insert NVARCHAR(MAX),
                @ls_iselect NVARCHAR(MAX);


        SET @ls_insert = 'INSERT INTO compras5 (
            codigo,				            letra,				            sucursal,				            numero,				            orden,
            renglon,			            cuenta_contable,	            importe_debe,			            importe_haber,		            fecha_contable,
            sector,				            concepto,			            detalle_comprobante,	            tipo,				            actividad,
            subactividad,		            moneda,				            valor_dolar,			            fecha_proceso,		            usuario,
            asiento,						origen,							unidad_negocio,			            conciliado,			            libro,
            zona,				            fecha_vencimiento,	            partida,				            articulo,			            cantidad,
            unidad_medida,		            importeMF1,			            importeMF2,				            								importe_doc,
            centro_costo,		            serie,				            tipo_item,				            cuenta_contrapartida,           asiento_diario,
            objeto_costo1,		            objeto_costo2,		            objeto_costo3,			            objeto_costo4,		            objeto_costo5,
            objeto_costo6,		            region,				            codigo_objeto_costo,	            cantidad_referencia,            unidad_referencia,
            fecha_comprobante,	            autorizado,			            Motivo_autorizacion,	            fecha_gestion	) ';


        SET @ls_iselect = 'SELECT DISTINCT '+ 
            'cabecera.codigo, '+
            'cabecera.letra,'+
            'cabecera.sucursal,'+
            'cabecera.numero,'+
            '0,'+
			--'ROW_NUMBER() OVER (ORDER BY asiento.cuenta_contable),'+
			''+CONVERT(VARCHAR(4), @renglon)+''+','+ --'1 renglon
			--CONVERT(VARCHAR(12), @ls_cuenta_contable_mg)+','+
			'asiento.cuenta_contable,'+
            'asiento.importe_debe,'+
            'asiento.importe_haber,'+
            'cabecera.fecha_comprobante ,'+--fecha_contable,'+
            'asiento.sector,'+
			--'''@ls_cuenta_descripcion'''+','+
			''''+CONVERT(VARCHAR(120), @ls_cuenta_descripcion)+''''+','+
            'asiento.detalle_comprobante,'+
            '1 ,'+--tipo, '+-- Ejemplo: definir un valor por defecto
            'asiento.actividad,'+
            'asiento.subactividad,'+
            'cabecera.moneda,'+--moneda, '+-- Ejemplo: manejar valores NULL según necesidad
            'cabecera.valor_dolar,'+--valor_dolar,'+
            'GETDATE() ,'+--fecha_proceso,'+
            '''Sistema'' ,'+--usuario,'+
            'NULL ,'+--asiento,'+
            '''C'' ,'+--origen, '+-- Ejemplo: asignar un valor fijo
            'NULL ,'+--unidad_negocio,'+
            '''N'' ,'+--conciliado,'+
            'NULL ,'+--libro,'+
            'NULL ,'+--zona,'+
            'cabecera.fecha_vencimiento,'+
            'NULL ,'+--partida,'+
            'NULL ,'+--articulo,'+
            'NULL ,'+--cantidad,'+
            'NULL ,'+--unidad_medida,'+
            'NULL ,'+--importeMF1,'+
            'NULL ,'+--importeMF2,'+
            'NULL ,'+--importe_doc,'+
            'asiento.centro_costo,'+
            'NULL ,'+--serie,'+
            'NULL ,'+--tipo_item,'+
            'NULL ,'+--cuenta_contrapartida,'+
            'NULL ,'+--asiento_diario,'+
            'NULL ,'+--objeto_costo1,'+
            'NULL ,'+--objeto_costo2,'+
            'NULL ,'+--objeto_costo3,'+
            'NULL ,'+--objeto_costo4,'+
            'NULL ,'+--objeto_costo5,'+
            'NULL ,'+--objeto_costo6,'+
            'NULL ,'+--region,'+
            'NULL ,'+--codigo_objeto_costo,'+
            'NULL ,'+--cantidad_referencia,'+
            'NULL ,'+--unidad_referencia,'+
            'cabecera.fecha_comprobante,'+
            '''S'' ,'+--autorizado,'+
            '''Automático'' ,'+--Motivo_autorizacion,'+
           ' GETDATE() '+--fecha_gestion'+
        ' FROM ingreso_comprobantes_compras_cabecera cabecera'+
        ' LEFT JOIN ingreso_comprobantes_compras_items items'+
        '    ON cabecera.id = items.id_cabecera'+
'        LEFT JOIN ingreso_comprobantes_compras_asiento asiento'+
'            ON cabecera.id = asiento.id_cabecera '+
        ' WHERE cabecera.id = ' + CONVERT(VARCHAR(10), @id) +'AND '+
		' asiento.id = '+CONVERT(VARCHAR(10), @id_asiento);


        SET @ls_insert = @ls_insert + @ls_iselect;


        EXEC sp_executesql @ls_insert;

    END TRY
    BEGIN CATCH
        -- Manejo de errores
        DECLARE @errorMessage NVARCHAR(4000);
        SET @errorMessage = ERROR_MESSAGE();
        INSERT INTO dbo.script_control VALUES (@ls_insert);
        INSERT INTO dbo.script_control VALUES ('Error: ' + @errorMessage);
        THROW; -- Re-lanzar el error para propagarlo
    END CATCH
END;
