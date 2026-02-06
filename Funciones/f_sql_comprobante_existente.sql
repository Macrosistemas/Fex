create function dbo.f_sql_comprobante_existente(
@codigo numeric(4,0),
@letra varchar(4),
@sucursal numeric(4,0),
@numero numeric(8,0),
@cuit varchar(15)
)
returns int
as
begin
	declare @rtn int,
			@numero_encontrado numeric(8,0)

	select top 1 @numero_encontrado = c.numero 
	   from compras2 c
	  where c.codigo in (select eq.codigo_mg
						 from ingreso_comprobantes_codigos_equivalentes eq 
						 where eq.codigo_input = @codigo) and
			c.letra = @letra and
			c.sucursal = @sucursal and
			c.numero  = @numero and
			dbo.f_sql_limpia_cuit(c.numero_cuit) = dbo.f_sql_limpia_cuit(@cuit)

	set @rtn = 0
	if isnull(@numero_encontrado,0) > 0 begin
		set @rtn = 1 
	end

	return @rtn
end 