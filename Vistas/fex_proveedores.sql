
CREATE  VIEW [dbo].[fex_proveedores]
AS SELECT *From proveedores  
WHERE  motivo_baja = 'A' or motivo_baja is null;
