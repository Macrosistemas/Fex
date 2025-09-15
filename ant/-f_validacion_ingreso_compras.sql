
ALTER FUNCTION [dbo].[f_validacion_ingreso_compras]
(@id INT,
    @codigo NUMERIC(4, 0),
    @letra VARCHAR(4),
    @sucursal NUMERIC(4, 0),
    @numero NUMERIC(8, 0),
    @orden NUMERIC(8, 0),
    @cuenta NUMERIC(8, 0))
RETURNS NUMERIC (12,2)
AS
BEGIN
	
	DECLARE @ls_sigo varchar(1)
	DECLARE @ll_encontrado NUMERIC(2)

	

		set @ls_sigo  = 'S';

 
 ---- VALIDACIÓN DE COMPROBANTE 
		select @ll_encontrado = count(numero)
		from  compras2 
		where codigo = @codigo AND
			letra =   @letra AND
			sucursal =   @sucursal AND
			numero = @numero AND
			orden = @orden AND
			cuenta = @cuenta 

		IF @ll_encontrado > 0 begin			
			set @ls_sigo  = 'N';
		end 
---- VALIDACIÓN DE COMPROBANTE 

	RETURN @ls_sigo

END



