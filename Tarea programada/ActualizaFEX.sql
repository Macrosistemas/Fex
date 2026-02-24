USE [msgestion01]
GO

DECLARE	@return_value int

EXEC	@return_value = [dbo].[sp_ingreso_comprobantes_compras]

SELECT	'Return Value' = @return_value

GO

update proveedores set motivo_baja = 'A' where motivo_baja is null ;
