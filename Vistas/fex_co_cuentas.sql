CREATE VIEW [dbo].[fex_co_cuentas] 
AS SELECT *
From co_cuentas
WHERE  rubro = 5 and imputable = 4 ;

