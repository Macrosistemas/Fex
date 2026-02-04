-- =============================================
-- Procedimiento: sp_marca_duplicados_comprobantes
-- Descripción: Detecta y marca registros duplicados en ingreso_comprobantes_compras_cabecera
--              basándose en la combinación de codigo, letra, sucursal, numero, cuit
--              Mantiene un registro válido (el de menor id) y marca los demás como 'duplicado'
-- =============================================
CREATE OR ALTER PROCEDURE sp_marca_duplicados_comprobantes
AS
BEGIN
    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION;
        
        -- Marcar como 'duplicado' todos los registros duplicados excepto el de menor id
        UPDATE c
        SET errores_importacion = 'duplicado'
        FROM ingreso_comprobantes_compras_cabecera c
        INNER JOIN (
            -- Subconsulta que identifica todos los duplicados
            SELECT 
                codigo, 
                letra, 
                sucursal, 
                numero, 
                cuit,
                MIN(id) as id_a_mantener
            FROM ingreso_comprobantes_compras_cabecera
            GROUP BY codigo, letra, sucursal, numero, cuit
            HAVING COUNT(*) > 1  -- Solo grupos con más de un registro (duplicados)
        ) duplicados 
            ON c.codigo = duplicados.codigo
            AND c.letra = duplicados.letra
            AND c.sucursal = duplicados.sucursal
            AND c.numero = duplicados.numero
            AND c.cuit = duplicados.cuit
            AND c.id <> duplicados.id_a_mantener  -- Excluir el registro a mantener
        WHERE c.errores_importacion IS NULL 
           OR c.errores_importacion <> 'duplicado';
        
        -- Asegurar que el registro con menor id quede con errores_importacion = NULL
        UPDATE c
        SET errores_importacion = NULL
        FROM ingreso_comprobantes_compras_cabecera c
        INNER JOIN (
            SELECT 
                codigo, 
                letra, 
                sucursal, 
                numero, 
                cuit,
                MIN(id) as id_a_mantener
            FROM ingreso_comprobantes_compras_cabecera
            GROUP BY codigo, letra, sucursal, numero, cuit
            HAVING COUNT(*) > 1
        ) duplicados 
            ON c.codigo = duplicados.codigo
            AND c.letra = duplicados.letra
            AND c.sucursal = duplicados.sucursal
            AND c.numero = duplicados.numero
            AND c.cuit = duplicados.cuit
            AND c.id = duplicados.id_a_mantener;
        
        COMMIT TRANSACTION;
        
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        
        -- Propagar el error
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
        DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
        DECLARE @ErrorState INT = ERROR_STATE();
        
        RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
    END CATCH
END;
GO
