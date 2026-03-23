CREATE VIEW [dbo].[compras_pendientes]
(	
    codigo,
    letra,
    sucursal,
    numero,
    orden,
    renglon,
    articulo,
    serie,
    codigo_sinonimo,
    descripcion,
    precio,
    cantidad,
    deposito,
    fecha,
    cuenta,
	
	numero_cuit,

    cantidad_devuelta,
    cantidad_entregada,
    cantidad_facturada,
    cantidad_cancelada,
    cantidad_pendiente_entregar,
    cantidad_pendiente_facturar,
    porcentaje_iva
)
AS

-- PEDIDOS (pedico1 + pedico2)
SELECT 
    p1.codigo,
    p1.letra,
    p1.sucursal,
    p1.numero,
    p1.orden,
    p1.renglon,
    p1.articulo,
    p1.serie,
    p1.codigo_sinonimo,
    p1.descripcion,
    p1.precio,
    p1.cantidad,
    p1.deposito,
    p1.fecha,
    p1.cuenta,
	p2.numero_cuit,
    p1.cantidad_devuelta,
    p1.cantidad_entregada,
    p1.cantidad_facturada,
    p1.cantidad_cancelada,
    p1.cantidad - ( p1.cantidad_devuelta + p1.cantidad_entregada + p1.cantidad_cancelada )  AS cantidad_pendiente_entregar,
    p1.cantidad - ( p1.cantidad_devuelta + p1.cantidad_facturada + p1.cantidad_cancelada ) AS cantidad_pendiente_facturar,
    p1.iva1 AS porcentaje_iva    
FROM dbo.pedico1 p1
LEFT JOIN dbo.pedico2 p2
       ON p1.codigo = p2.codigo
      AND p1.letra = p2.letra
      AND p1.sucursal = p2.sucursal
      AND p1.numero = p2.numero
      AND p1.orden = p2.orden
WHERE p1.estado = 'V'
  AND (p1.cantidad - (p1.cantidad_devuelta + p1.cantidad_entregada + p1.cantidad_cancelada)) > 0

UNION ALL

-- COMPRAS (compras1 + compras2)
SELECT
    c1.codigo,
    c1.letra,
    c1.sucursal,
    c1.numero,
    c1.orden,
    c1.renglon,
    c1.articulo,
    c1.serie,
    c1.codigo_sinonimo,
    c1.descripcion,
    c1.precio,
    c1.cantidad,
    c1.deposito,
    c1.fecha,
    c1.cuenta,
	c2.numero_cuit,
    c1.cantidad_devuelta,
    c1.cantidad_entregada,
    c1.cantidad_facturada,
    0 AS cantidad_cancelada,
    c1.cantidad - ( c1.cantidad_devuelta + c1.cantidad_entregada  ) AS cantidad_pendiente_entregar,
    c1.cantidad - ( c1.cantidad_devuelta + c1.cantidad_facturada ) AS cantidad_pendiente_facturar,
    c1.iva1 AS porcentaje_iva
    
FROM dbo.compras1 c1
LEFT JOIN dbo.compras2 c2
       ON c1.codigo = c2.codigo
      AND c1.letra = c2.letra
      AND c1.sucursal = c2.sucursal
      AND c1.numero = c2.numero
      AND c1.orden = c2.orden
WHERE c1.estado = 'V'
  AND c1.codigo IN (7, 36)
  AND (c1.cantidad - (c1.cantidad_devuelta + c1.cantidad_entregada )) > 0;
