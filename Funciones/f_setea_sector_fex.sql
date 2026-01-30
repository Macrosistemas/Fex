create function dbo.f_setea_sector_fex( 
@cuentaContable varchar(12),
@sector numeric(8,0))
returns numeric(8,0)
as
begin
	declare @valorEvento numeric(8,0),
			@rubroCuenta char(1),
			@sectorRtn numeric(8,0)

	set @sectorRtn = @sector --inicialimente el sector que retorna es el que viene pero si se cumplen las condiciones se asigna el nuevo

	--Regla: Si el evento sectcero esta activo con un valor numeico y el sector viene null y la cuenta contable pertenece al rubro gastos.. 
	--...se asigna el valor del evento

	set @valorEvento = convert(numeric(8,0),dbo.f_sql_evento('sectcero'))

	select @rubroCuenta = r.rubro
	   from co_rubros r
	   inner join co_cuentas c on c.rubro = r.codigo
	   where c.cuenta = @cuentaContable

	
	if isnumeric(@valorEvento ) = 1 and @sector is null and @rubroCuenta = 'E' begin	
		set @sectorRtn= @valorEvento
	end 

	return @sectorRtn
end;
