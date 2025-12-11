

ALTER PROCEDURE [dbo].[sp_inserta_movi_stock](
  @al_codigo numeric(4,0),
  @as_letra varchar(4),
  @al_sucursal numeric(4,0),
  @al_numero numeric(8,0),
  @al_orden numeric(4,0),
  @ad_fechor datetime,
  @ls_numero_cuenta NUMERIC(8,0),
  @id INT)
AS
BEGIN
    BEGIN TRY
        DECLARE @ll_articulo numeric(8,0),
                @le_cantidad numeric(16,4),


                @ll_producto numeric(8,0),

                @ll_control numeric(8,0),
                @le_kgs numeric(16,4),
                @ls_operacion char(1),
                @ls_contrato varchar(60),
                @ls_deno_pro char(1),
                @ls_deposito varchar(8),
                @ld_fechor datetime,
                @RC int,
                @ll_codigo NUMERIC(4,0),
                @ls_tabla VARCHAR(100),
                @ls_insert VARCHAR(5000),
                @ls_oper CHAR(1),
                @err_state INT,
                @ver_state varchar(100)
                


		        -- Establecer la fecha
        SELECT @ld_fechor = dia_actual.fecha
        FROM dia_actual


        -- Determinar la operación
        SELECT @ls_oper = ISNULL(dbo.comprobante.stock_com, '+')
        FROM comprobante
        WHERE comprobante.codigo = @al_codigo 


        
        -- Verificar control
        SET @ll_control = 0
        SELECT @ll_control = dbo.movi_stock.codigo_comprobante
        FROM movi_stock
        WHERE (codigo_comprobante = @al_codigo) AND
              (letra_comprobante = @as_letra) AND
              (movi_stock.sucursal_comprobante = @al_sucursal) AND
              (movi_stock.numero_comprobante = @al_numero) AND
              (movi_stock.orden = @al_orden)


        
-- Construir la consulta de inserción
SET @ls_insert = 'INSERT INTO ' + 'movi_stock ( ' +
     'deposito, ' +
     'articulo, ' +
     'fecha, ' +
     'codigo_comprobante, ' +
     'letra_comprobante, ' +
     'sucursal_comprobante, ' +
     'numero_comprobante, ' +
     'orden, ' +
     'operacion, ' +
     'cantidad, ' +
     'precio, ' +
     'cuenta, ' +
     'vta_anticipada, ' +
     'sistema, ' +
     'serie, ' +
     'cultivo, ' +
     'unidades, ' +
     'codigo_sinonimo, ' +
     'valor_dolar, ' +
     'centro_costo, ' +
     'partida, ' +
     'fecha_contable, ' +
     'fecha_proceso, ' +
     'usuario, ' +
     'moneda, ' +
     'tipo, ' +
     'formula ) ' +
'SELECT DISTINCT ingreso_comprobantes_compras_cabecera.deposito, ' +
'       ingreso_comprobantes_compras_items.codigo_articulo, ' +
'       ingreso_comprobantes_compras_cabecera.fecha_comprobante, ' +
'       ingreso_comprobantes_compras_cabecera.codigo, ' +
'       ingreso_comprobantes_compras_cabecera.letra, ' +
'       ingreso_comprobantes_compras_cabecera.sucursal, ' +
'       ingreso_comprobantes_compras_cabecera.numero, ' +
'       ' + CONVERT(varchar(8), @al_orden) + ', ' +
'       ''' + @ls_oper + ''', ' +
'       CONVERT(varchar(21), ingreso_comprobantes_compras_items.cantidad), ' +
'       (CASE WHEN ingreso_comprobantes_compras_cabecera.letra = ''B'' THEN CONVERT(varchar(21), ingreso_comprobantes_compras_items.precio + (ingreso_comprobantes_compras_items.precio * ingreso_comprobantes_compras_items.alicuota_iva / 100)) ELSE CONVERT(varchar(21), ingreso_comprobantes_compras_items.precio) END), ' +
'       ' + CONVERT(varchar(8), @ls_numero_cuenta) + ', ' +
'       ''N'', ' +
'       7, ' +
'		ISNULL(ingreso_comprobantes_compras_items.serie,'''') ,'+--serie,
'       NULL, ' +
'       CONVERT(varchar(21), ingreso_comprobantes_compras_items.cantidad), ' +
'       articulo.codigo_sinonimo, ' +
'       ingreso_comprobantes_compras_cabecera.valor_dolar, ' + 
'       0, ' +
'       '''', ' +
'       ingreso_comprobantes_compras_cabecera.fecha_comprobante, ' + 
'       ''' + CONVERT(varchar(10), @ld_fechor, 120) + ''', ' +
'       ''IMPORT'', ' +
'       ingreso_comprobantes_compras_cabecera.moneda, ' + 
'       NULL, ' +
'       NULL ' +
' FROM ingreso_comprobantes_compras_cabecera ' +
' JOIN ingreso_comprobantes_compras_items ON ingreso_comprobantes_compras_items.id_cabecera = ingreso_comprobantes_compras_cabecera.id ' +
' JOIN articulo ON articulo.codigo = ingreso_comprobantes_compras_items.codigo_articulo ' +
' WHERE ingreso_comprobantes_compras_cabecera.id = ' + CONVERT(varchar(5), @id) + ' ' +
' AND CONVERT(numeric(4,0), ingreso_comprobantes_compras_cabecera.codigo) = ' + CONVERT(varchar(4), @al_codigo) + ' ' +
' AND ingreso_comprobantes_compras_cabecera.letra = ''' + @as_letra + ''' ' +
' AND articulo.stock <> ''N'' ' +
' AND CONVERT(numeric(4,0), ingreso_comprobantes_compras_cabecera.sucursal) = ' + CONVERT(varchar(4), @al_sucursal) + ' ' +
' AND ingreso_comprobantes_compras_cabecera.numero = ' + CONVERT(varchar(8), @al_numero) + ''


		print(@ls_insert)

        INSERT INTO dbo.script_control VALUES (@ls_insert)
        EXECUTE (@ls_insert)
        
        -- Comprobar errores
        SET @err_state = @@ERROR
        IF @err_state <> 0 
        BEGIN

            SET @ver_state = ERROR_MESSAGE()

        END
    END TRY
BEGIN CATCH
    DECLARE @errorMessage NVARCHAR(4000);
    SET @errorMessage = ERROR_MESSAGE();
    INSERT INTO dbo.script_control VALUES (@ls_insert);
    INSERT INTO dbo.script_control  VALUES ('Error: ' + @errorMessage);
    THROW;
END CATCH
END
