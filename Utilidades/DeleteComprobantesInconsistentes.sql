
delete compras1
from ( 
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
		WHERE (select top 1 c.numero 
		from compras2 c 
		where c.sucursal = i.sucursal and 
		c.numero = i.numero and 
		c.letra = i.letra ) is null


		 ) as sincab
where compras1.codigo = sincab.codigo and
	  compras1.letra = sincab.letra and
	  compras1.numero = sincab.numero and
	  compras1.sucursal = sincab.sucursal and
	  compras1.fecha    = sincab.fecha_comprobante;



delete moviprov1
from   ( 
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
		WHERE (select top 1 c.numero 
		from compras2 c 
		where c.sucursal = i.sucursal and 
		c.numero = i.numero and 
		c.letra = i.letra ) is null


		 ) as sincab
where 
	  moviprov1.letra = sincab.letra and
	  moviprov1.numero_comprobante = sincab.numero and
	  moviprov1.sucursal_comprobante = sincab.sucursal and
	  moviprov1.fecha_contable    = sincab.fecha_comprobante;





select * 
from ventas5 c1, ( 
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
		WHERE (select top 1 c.numero 
		from compras2 c 
		where c.sucursal = i.sucursal and 
		c.numero = i.numero and 
		c.letra = i.letra ) is null


		 ) as sincab
where c1.codigo = sincab.codigo and
	  c1.letra = sincab.letra and
	  c1.numero = sincab.numero and
	  c1.sucursal = sincab.sucursal ;





select * 
from ventas7 c1, ( 
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
		WHERE (select top 1 c.numero 
		from compras2 c 
		where c.sucursal = i.sucursal and 
		c.numero = i.numero and 
		c.letra = i.letra ) is null


		 ) as sincab
where c1.codigo_o = sincab.codigo and
	  c1.letra_o = sincab.letra and
	  c1.numero_o = sincab.numero and
	  c1.sucursal_o = sincab.sucursal and
	  c1.fecha    = sincab.fecha_comprobante;



select * 
from ventas7 c1, ( 
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
		WHERE (select top 1 c.numero 
		from compras2 c 
		where c.sucursal = i.sucursal and 
		c.numero = i.numero and 
		c.letra = i.letra ) is null


		 ) as sincab
where c1.codigo_d = sincab.codigo and
	  c1.letra_d = sincab.letra and
	  c1.numero_d = sincab.numero and
	  c1.sucursal_d = sincab.sucursal and
	  c1.fecha    = sincab.fecha_comprobante;



select * 
from movi_stock c1, ( 
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
		WHERE (select top 1 c.numero 
		from compras2 c 
		where c.sucursal = i.sucursal and 
		c.numero = i.numero and 
		c.letra = i.letra ) is null


		 ) as sincab
where c1.letra_comprobante= sincab.letra and
	  c1.numero_comprobante = sincab.numero and
	  c1.sucursal_comprobante = sincab.sucursal ;