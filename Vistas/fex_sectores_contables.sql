CREATE VIEW [dbo].[fex_sectores_contables]  
AS SELECT *
From sectores_contables
WHERE  estado = 'V' ;

