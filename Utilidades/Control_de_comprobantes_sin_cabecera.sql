
--control ítem sin cabecera
select * 
  from compras1 a
  where 
		(select c.numero 
			from compras2 c
			where c.codigo		= a.codigo and
					c.letra		= a.letra and
					c.sucursal	= a.sucursal and
					c.numero	= a.numero and
					c.orden		= a.orden and
					c.fecha_comprobante = a.fecha) is null ;

--Control de movimientos de cuentas corrietnes sin cabecera
select p.denominacion, * 
from moviprov1 m 
inner join proveedores p on p.numero = m.numero_cuenta
where (select top 1 c.numero 
			from compras2 c
			where c.codigo		= (select cc.codigo_comprobante 
									 from comprobante_cc cc 
									 where cc.codigo_cc = m.codigo_movimiento and
										   cc.codigo_comprobante = c.codigo and
										   cc.sistema_destino = 2 and
										   cc.sistema_origen = 7 ) and
					c.letra		= m.letra and
					c.sucursal	= m.sucursal_comprobante and
					c.numero	= m.numero_comprobante and
					c.cuenta_cc  = m.numero_cuenta and
					c.fecha_proceso= m.fecha_proceso) is null  and
		m.codigo_movimiento = 1 and
		m.usuario = 'IMPORT';

--Control de asientos contables incongruentes
select * 
	from compras5 a
  where 
		(select c.numero 
			from compras2 c
			where c.codigo		= a.codigo and
					c.letra		= a.letra and
					c.sucursal	= a.sucursal and
					c.numero	= a.numero and
					c.orden		= a.orden and
					c.fecha_contable = a.fecha_contable) is null and
		a.codigo < 60 and
		fecha_proceso >= '2025-06-01' AND
		usuario in  ('Sistema','IMPORT') ;

--Control de Movimientos de stock sin cabecera
select * 
  from movi_stock a
  inner join comprobante co on co.codigo = a.codigo_comprobante
 where (select c.numero 
			from compras2 c
			where c.codigo		= a.codigo_comprobante and
					c.letra		= a.letra_comprobante and
					c.sucursal	= a.sucursal_comprobante and
					c.numero	= a.numero_comprobante and
					c.orden		= a.orden ) is null  and
	a.codigo_comprobante in (1,2,3,4,42) and
	co.operacion_com = a.operacion;

--Control de copras7 sin cabecerea (ORIGEN)
select * 
from compras7 a
where (select c.numero 
			from compras2 c
			where c.codigo		= a.codigo_o and
					c.letra		= a.letra_o and 
					c.sucursal	= a.sucursal_o and
					c.numero	= a.numero_o and
					c.orden		= a.orden_o ) is null  and
	a.codigo_o in (1,2,3,4,42);

--Control de copras7 sin cabecerea (DESTINO)
select * 
from compras7 a
where (select c.numero 
			from compras2 c
			where c.codigo		= a.codigo_d and
					c.letra		= a.letra_d and 
					c.sucursal	= a.sucursal_d and
					c.numero	= a.numero_d and
					c.orden		= a.orden_d ) is null  and
	a.codigo_d in (1,2,3,4,42);

--control de compras_ib sin cabecera
select * 
	from compras_ib a
  where 
		(select c.numero 
			from compras2 c
			where c.codigo		= a.codigo and
					c.letra		= a.letra and
					c.sucursal	= a.sucursal and
					c.numero	= a.numero and
					c.orden		= a.orden and
					c.fecha_contable = a.fecha_contable) is null and
		a.usuario in  ('Sistema','IMPORT') ;