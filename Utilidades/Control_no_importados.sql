
USE [msgestion01]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_ingreso_comprobantes_compras]

SELECT	'Return Value' = @return_value

GO

--Cotnrol de comprobantes que no tiene compras2
 SELECT 
            id,										codigo,							letra,							sucursal,								numero,
            denominacion,							fecha_comprobante,				fecha_iva,						fecha_vencimiento,						moneda,
            valor_dolar,							monto_bonificacion,				monto_descuento,				monto_financiacion,						monto_impuesto,
            monto_impuesto_no_computable,			importe_perc_canje,				monto_percepcion_iva,			monto_percepcion_ganancia,				monto_percepcion_ingbru,
			monto_percepcion_rg3337,				concepto_gravado,				importe_iva,					concep_no_gravado,						total_general, 
			codigo_rubro_gasto,						codigo_lugar_pago,				observaciones_1,				contrato,								cod_regimen_ganancias, 
			fecha_hora_ingreso,						fecha_hora_procesado_macrogest, tipo_comprobante,				errores_importacion,					cuit,
			estado_stock
        FROM ingreso_comprobantes_compras_cabecera i
        WHERE (select top 1 c.numero from compras2 c where c.sucursal = i.sucursal and c.numero = i.numero and c.letra = i.letra ) is null;


--llena errores de importacion en null de los no encontrados en el compras2
update ingreso_comprobantes_compras_cabecera
  set errores_importacion = null 
  where id in ( SELECT       id
        FROM ingreso_comprobantes_compras_cabecera i
        WHERE (select top 1 c.numero from compras2 c where c.sucursal = i.sucursal and c.numero = i.numero and c.letra = i.letra ) is null);


    --para borrar un comprobante especifico y volver a procesarlo
  DELETE from compras2 where sucursal = 9 and numero = 80263 and codigo = 1 ;
  DELETE from compras1 where sucursal = 9 and numero = 80263and codigo = 1 ;
  DELETE  from moviprov1 where sucursal_comprobante = 9 and numero_comprobante = 80263  ;
  DELETE from compras5 where sucursal= 9 and numero= 80263 and codigo = 1 ;


  select * from parametros ;