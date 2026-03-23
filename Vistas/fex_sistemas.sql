CREATE VIEW [dbo].[fex_sistemas](
codigo , 
sistema, 
fecha_cierre) 
AS
SELECT
sistemas.codigo , 
sistemas.sistema , 
sistemas.fecha_cierre 
From sistemas
WHERE  codigo = '7' ;
