create or alter function dbo.f_sql_trae_codigo_cc
(
    @codigo numeric(8,0),
    @sistema_origen numeric(8,0),
    @sistema_destino numeric(8,0)
)returns numeric(8,0)
as
    begin
    declare @codigoRtn numeric(8,0)

    select @codigoRtn = codigo_cc
    from comprobante_cc
    where codigo_comprobante = @codigo AND
        sistema_origen = @sistema_origen AND
        sistema_destino = @sistema_destino 

    return @codigoRtn
end;

go

select dbo.f_sql_trae_codigo_cc(2,7,2) as CodigoCC;
