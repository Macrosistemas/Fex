
CREATE VIEW [dbo].[ventas1_pend] AS SELECT * FROM msgestion01.dbo.ventas1 
WHERE cantidad>(cantidad_facturada-cantidad_devuelta-cantidad_cancelada);
