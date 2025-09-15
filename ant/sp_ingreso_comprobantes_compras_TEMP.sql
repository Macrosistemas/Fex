ALTER PROCEDURE [dbo].[sp_ingreso_comprobantes_compras]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Crear tabla temporal para almacenar los datos
        CREATE TABLE #TempComprobantes (
            id INT,
            codigo NUMERIC(4,0),
            letra VARCHAR(4),
            sucursal NUMERIC(4,0),
            numero NUMERIC(8,0),
            orden NUMERIC(8,0),
            cuenta NUMERIC(8,0),
            denominacion VARCHAR(255),
            fecha_comprobante DATETIME,
            deposito NUMERIC(8,0),
            subtotal DECIMAL(18,2),
            bonificacion_general DECIMAL(18,2),
            monto_bonificacion DECIMAL(18,2),
            descuento_general DECIMAL(18,2),
            monto_descuento DECIMAL(18,2),
            financiacion DECIMAL(18,2),
            tipo_impuesto NUMERIC(1),
            impuesto DECIMAL(18,2),
            impuesto_no_computable DECIMAL(18,2),
            iva_1 DECIMAL(18,2),
            monto_iva1 DECIMAL(18,2),
            iva_2 DECIMAL(18,2),
            monto_iva2 DECIMAL(18,2),
            tipo_exento VARCHAR(1),
            concep_no_g DECIMAL(18,2),
            importe_perc_canje DECIMAL(18,2),
            fecha_iva DATETIME,
            fecha_vencimiento DATETIME,
            rubro_gasto NUMERIC(8,0),
            lugar_pago NUMERIC(2,0),
            observaciones_1 VARCHAR(200),
            contrato VARCHAR(20),
            retencion_iva DECIMAL(18,2),
            retencion_ganancia DECIMAL(18,2),
            retencion_ingbru DECIMAL(18,2),
            retencion_rg3337 DECIMAL(18,2),
            provincia VARCHAR(1),
            cod_regimen_ib NUMERIC(4,0),
            cuenta_contable_banco VARCHAR(15),
            errores_importacion VARCHAR(5000),
            cuit VARCHAR(255)
        );

        -- Insertar los datos de origen en la tabla temporal
        INSERT INTO #TempComprobantes
        SELECT *
        FROM ingreso_comprobantes_compras_cabecera
        WHERE errores_importacion IS NULL;

        -- Procesar los registros en la tabla temporal
        DECLARE @id INT, @cuit VARCHAR(255);
        DECLARE @ls_numero_cuenta NUMERIC(8,0), @ls_deno_cuenta VARCHAR(100);

        WHILE EXISTS (SELECT 1 FROM #TempComprobantes)
        BEGIN
            SELECT TOP 1 
                @id = id,
                @cuit = cuit
            FROM #TempComprobantes;

            -- Obtener cuenta y denominación
            SET @ls_numero_cuenta = NULL;
            SELECT @ls_numero_cuenta = numero FROM proveedores WHERE cuit = @cuit;

            IF @ls_numero_cuenta IS NOT NULL
            BEGIN
                SELECT @ls_deno_cuenta = denominacion FROM proveedores WHERE numero = @ls_numero_cuenta;

                -- Llamar a procedimientos para insertar los datos
                EXEC sp_inserta_compras2 @id, @ls_numero_cuenta, @ls_deno_cuenta;
                EXEC sp_inserta_moviprov1 @id, @ls_numero_cuenta;

                -- Marcar como importado
                UPDATE ingreso_comprobantes_compras_cabecera
                SET errores_importacion = 'Importado correctamente'
                WHERE id = @id;
            END
            ELSE
            BEGIN
                -- Marcar con error si no se encuentra la cuenta
                UPDATE ingreso_comprobantes_compras_cabecera
                SET errores_importacion = 'No se encontró la cuenta'
                WHERE id = @id;
            END;

            -- Eliminar el registro procesado de la tabla temporal
            DELETE FROM #TempComprobantes WHERE id = @id;
        END;

        -- Limpiar tabla temporal
        DROP TABLE #TempComprobantes;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;

        IF OBJECT_ID('tempdb..#TempComprobantes') IS NOT NULL
            DROP TABLE #TempComprobantes;

        THROW;
    END CATCH;
END;
