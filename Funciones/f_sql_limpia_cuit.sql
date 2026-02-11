create function dbo.f_sql_limpia_cuit(
@cuit varchar(15)
)
returns varchar(15)
as
begin
	declare @cuitRtn varchar(15)

	set @cuitRtn = ltrim(rtrim(@cuit)) --saco espacios
	set @cuitRtn = REPLACE(@cuitRtn,'-','')

	return @cuitRtn
end 
go