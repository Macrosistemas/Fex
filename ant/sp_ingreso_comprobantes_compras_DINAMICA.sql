ALTER PROCEDURE [dbo].[sp_ingreso_comprobantes_compras]
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Declaración de variables para las consultas dinámicas
        DECLARE @sql NVARCHAR(MAX);
        DECLARE @params NVARCHAR(MAX);

        -- Cursor para iterar sobre los registros
        DECLARE cursor_comprobantes CURSOR FOR
        SELECT 
            id,						codigo,					letra,					sucursal,					numero,
            orden,					cuenta,					denominacion,			fecha_comprobante,			deposito,
            subtotal,				bonificacion_general,	monto_bonificacion,		descuento_general,			monto_descuento,
			financiacion,			tipo_impuesto,			impuesto,				impuesto_no_computable,		iva_1, 
			monto_iva1,				iva_2,					monto_iva2,				tipo_exento,				concep_no_g, 
			importe_perc_canje,		fecha_iva,				fecha_vencimiento,      rubro_gasto,				lugar_pago, 
			observaciones_1,		contrato,				retencion_iva,			retencion_ganancia,			retencion_ingbru, 
			retencion_rg3337,       provincia,				cod_regimen_ib,			cuenta_contable_banco,		errores_importacion, 
			cuit
        FROM ingreso_comprobantes_compras_cabecera
        WHERE errores_importacion IS NULL;

        -- Declaración de variables locales
		DECLARE 
            @id					INT,			@codigo				NUMERIC(4,0),	@letra					VARCHAR(4),			@sucursal				NUMERIC(4,0),		
			@numero				NUMERIC(8,0),   @orden				NUMERIC(8,0),	@cuenta					NUMERIC(8,0),		@denominacion			VARCHAR(255),
			@fecha_comprobante	DATETIME,		@deposito			NUMERIC(8,0),   @subtotal				DECIMAL(18,2),		@bonificacion_general	DECIMAL(18,2), 
			@monto_bonificacion DECIMAL(18,2),  @descuento_general	DECIMAL(18,2),	@monto_descuento		DECIMAL(18,2),		@financiacion			DECIMAL(18,2), 
            @tipo_impuesto		NUMERIC(1),		@impuesto			DECIMAL(18,2),	@impuesto_no_computable DECIMAL(18,2),      @iva_1					DECIMAL(18,2),
			@monto_iva1			DECIMAL(18,2),	@iva_2				DECIMAL(18,2),	@monto_iva2				DECIMAL(18,2),      @tipo_exento			VARCHAR(1), 
			@concep_no_g		DECIMAL(18,2),	@importe_perc_canje DECIMAL(18,2),  @fecha_iva				DATETIME,			@fecha_vencimiento		DATETIME, 
			@rubro_gasto		NUMERIC(8,0),	@lugar_pago			NUMERIC(2,0),   @observaciones_1		VARCHAR(200),		@contrato				VARCHAR(20),
            @retencion_iva		DECIMAL(18,2),	@retencion_ganancia DECIMAL(18,2),	@retencion_ingbru		DECIMAL(18,2),		@retencion_rg3337		DECIMAL(18,2),
            @provincia			VARCHAR(1),		@cod_regimen_ib		NUMERIC(4,0),	@cuenta_contable_banco	VARCHAR(15),        @errores_importacion	VARCHAR(5000), 
			@cuit				VARCHAR(255);

        
        OPEN cursor_comprobantes;

         FETCH NEXT FROM cursor_comprobantes INTO 
			@id,					@codigo,					@letra,					@sucursal,					@numero,
            @orden,					@cuenta,					@denominacion,			@fecha_comprobante,			@deposito,
            @subtotal,				@bonificacion_general,		@monto_bonificacion,	@descuento_general,			@monto_descuento,
            @financiacion,			@tipo_impuesto,				@impuesto,				@impuesto_no_computable,    @iva_1, 
			@monto_iva1,			@iva_2,						@monto_iva2,			@tipo_exento,		        @concep_no_g, 
			@importe_perc_canje,	@fecha_iva,					@fecha_vencimiento,     @rubro_gasto,				@lugar_pago, 
			@observaciones_1,		@contrato,			        @retencion_iva,			@retencion_ganancia,		@retencion_ingbru, 
			@retencion_rg3337,      @provincia,					@cod_regimen_ib,		@cuenta_contable_banco,		@errores_importacion, 
			@cuit;

        WHILE @@FETCH_STATUS = 0
        BEGIN
            -- Declaración de variables adicionales
            DECLARE @ls_numero_cuenta NUMERIC(8,0) = 0;
            DECLARE @ls_deno_cuenta VARCHAR(100);

            -- Consulta dinámica para obtener el número de cuenta
            SET @sql = N'SELECT @ls_numero_cuenta = numero FROM proveedores WHERE cuit = @cuit';
            SET @params = N'@ls_numero_cuenta NUMERIC(8,0) OUTPUT, @cuit VARCHAR(255)';
            EXEC sp_executesql @sql, @params, @ls_numero_cuenta OUTPUT, @cuit;

            -- Si se encuentra el número de cuenta, buscar la denominación
            IF @ls_numero_cuenta > 0
            BEGIN
                SET @sql = N'SELECT @ls_deno_cuenta = denominacion FROM proveedores WHERE numero = @ls_numero_cuenta';
                SET @params = N'@ls_deno_cuenta VARCHAR(100) OUTPUT, @ls_numero_cuenta NUMERIC(8,0)';
                EXEC sp_executesql @sql, @params, @ls_deno_cuenta OUTPUT, @ls_numero_cuenta;

                -- Insertar compras con el número de cuenta y denominación
                EXEC sp_inserta_compras2 @id, @ls_numero_cuenta, @ls_deno_cuenta;
                EXEC sp_inserta_moviprov1 @id, @ls_numero_cuenta;

                -- Actualizar como importado correctamente
                SET @sql = N'UPDATE ingreso_comprobantes_compras_cabecera
                             SET errores_importacion = @mensaje
                             WHERE id = @id';
                SET @params = N'@mensaje VARCHAR(5000), @id INT';
                EXEC sp_executesql @sql, @params, N'Importado correctamente', @id;
            END
            ELSE
            BEGIN
                -- Actualizar con error si no se encontró la cuenta
                SET @sql = N'UPDATE ingreso_comprobantes_compras_cabecera
                             SET errores_importacion = @mensaje
                             WHERE id = @id';
                SET @params = N'@mensaje VARCHAR(5000), @id INT';
                EXEC sp_executesql @sql, @params, N'No se encontró la cuenta', @id;
            END;


            FETCH NEXT FROM cursor_comprobantes INTO 
				@id,					@codigo,					@letra,					@sucursal,					@numero,
				@orden,					@cuenta,					@denominacion,			@fecha_comprobante,			@deposito,
				@subtotal,				@bonificacion_general,		@monto_bonificacion,	@descuento_general,			@monto_descuento,
				@financiacion,			@tipo_impuesto,				@impuesto,				@impuesto_no_computable,    @iva_1, 
				@monto_iva1,			@iva_2,						@monto_iva2,			@tipo_exento,		        @concep_no_g, 
				@importe_perc_canje,	@fecha_iva,					@fecha_vencimiento,     @rubro_gasto,				@lugar_pago, 
				@observaciones_1,		@contrato,			        @retencion_iva,			@retencion_ganancia,		@retencion_ingbru, 
				@retencion_rg3337,      @provincia,					@cod_regimen_ib,		@cuenta_contable_banco,		@errores_importacion, 
				@cuit;
        END;


        CLOSE cursor_comprobantes;
        DEALLOCATE cursor_comprobantes;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH;
END;
