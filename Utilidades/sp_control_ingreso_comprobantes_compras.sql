CREATE PROCEDURE [dbo].[sp_control_ingreso_comprobantes_compras] 
AS
BEGIN

    DECLARE @FechaMaxProcesado DATE;

    SELECT @FechaMaxProcesado = MAX(fecha_hora_procesado_macrogest) 
    FROM ingreso_comprobantes_compras_cabecera;

    SELECT
        i.codigo,
        i.letra,
        i.sucursal,
        i.numero,
        c.cuenta,
        i.total_general,

    
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM compras1 c1
            WHERE c1.codigo   = c.codigo
            AND c1.letra    = c.letra
            AND c1.sucursal = c.sucursal
            AND c1.numero   = c.numero
            and c1.orden = c.orden
        )
        AND NOT EXISTS (
            SELECT 1
            FROM compras1 c1
            WHERE c1.codigo   = c.codigo
            AND c1.letra    = c.letra
            AND c1.sucursal = c.sucursal
            AND c1.numero   = c.numero
            and c1.orden = c.orden
            AND c1.zona IS NULL
        )
        THEN 'ok'
        ELSE 'error'
    END AS ctrl_zona_compras1,


    
    CASE 
        WHEN EXISTS (
            SELECT 1
            FROM compras1 c1
            WHERE c1.codigo   = i.codigo
            AND c1.letra    = i.letra
            AND c1.sucursal = i.sucursal
            AND c1.numero   = i.numero
        )
        AND NOT EXISTS (
            SELECT 1
            FROM compras1 c1
            WHERE c1.codigo   = i.codigo
            AND c1.letra    = i.letra
            AND c1.sucursal = i.sucursal
            AND c1.numero   = i.numero
            AND c1.deposito IS NULL
        )
        THEN 'ok'
        ELSE 'error'
    END AS ctrl_deposito_compras1,


    

        CASE WHEN c.zona IS NOT NULL THEN 'ok' ELSE 'error' END AS ctrl_zona_compras2,
        CASE WHEN c.deposito IS NOT NULL THEN 'ok' ELSE 'error' END AS ctrl_deposito_compras2,
        CASE WHEN c.concepto_no_gravado IS NOT NULL THEN 'ok' ELSE 'error' END AS ctrl_concepto_no_gravado_compras2,

        CASE 
            WHEN CAST(c.fecha_contable AS date) = CAST(c.fecha_iva AS date)
            THEN 'ok' ELSE 'error'
        END AS ctrl_fecha_iva_compras2,


        CASE 
            WHEN CAST(c.fecha_contable AS date) = CAST(c.fecha_ingreso_brutos AS date)
            THEN 'ok' ELSE 'error'
        END AS ctrl_fecha_iibb_compras2,

        --CASE 
        --    WHEN CAST(c.fecha_comprobante AS date) = CAST(i.fecha_comprobante AS date)
        --    THEN 'ok' ELSE 'error'
        --END AS ctrl_fecha_proceso_compras2,


       CASE
    WHEN NOT EXISTS (
        SELECT 1
        FROM compras_ib cib
        WHERE cib.codigo   = i.codigo
          AND cib.letra    = i.letra
          AND cib.sucursal = i.sucursal
          AND cib.numero   = i.numero
    )
    THEN 'no controla'

    WHEN EXISTS (
        SELECT 1
        FROM compras_ib cib
        WHERE cib.codigo   = i.codigo
          AND cib.letra    = i.letra
          AND cib.sucursal = i.sucursal
          AND cib.numero   = i.numero
          AND CAST(cib.fecha_contable AS date) = CAST(c.fecha_contable AS date)
    )
    THEN 'ok'

    ELSE 'error'
END AS ctrl_fecha_contable_compras_ib,

        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM compras5 c5
                WHERE c5.codigo   = i.codigo
                AND c5.letra    = i.letra
                AND c5.sucursal = i.sucursal
                AND c5.numero   = i.numero
                AND CAST(c5.fecha_contable AS date) = CAST(c.fecha_contable AS date)
            )
            THEN 'ok'
            ELSE 'error'
        END AS ctrl_fecha_contable_compras5,

        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM compras5 c5
                WHERE c5.codigo   = i.codigo
                AND c5.letra    = i.letra
                AND c5.sucursal = i.sucursal
                AND c5.numero   = i.numero
                AND CAST(c5.fecha_proceso AS time) = '00:00:00.000'
            )
            THEN 'ok'
            ELSE 'error'
        END AS ctrl_fecha_proceso_sin_hora_compras5,



        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM moviprov1 mp
                WHERE mp.codigo_movimiento      = i.codigo
                AND mp.letra                  = i.letra
                AND mp.sucursal_comprobante   = i.sucursal
                AND mp.numero_comprobante     = i.numero
                AND CAST(mp.fecha_proceso AS time) = '00:00:00.000'
            )
            THEN 'ok'
            ELSE 'error'
        END AS ctrl_fecha_proceso_sin_hora_moviprov1,

        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM moviprov1 mp
                WHERE mp.codigo_movimiento      = i.codigo
                AND mp.letra                  = i.letra
                AND mp.sucursal_comprobante   = i.sucursal
                AND mp.numero_comprobante     = i.numero
                AND CAST(mp.fecha_hora AS time) = '00:00:00.000'
            )
            THEN 'ok'
            ELSE 'error'
        END AS ctrl_fecha_hora_sin_hora_moviprov1,

        CASE 
            WHEN EXISTS (
                SELECT 1
                FROM moviprov1 mp
                WHERE mp.codigo_movimiento      = i.codigo
                AND mp.letra                  = i.letra
                AND mp.sucursal_comprobante   = i.sucursal
                AND mp.numero_comprobante     = i.numero
                AND mp.hora IS NULL
            )
            THEN 'ok'
            ELSE 'error'
        END AS ctrl_hora_null_moviprov1,


        CASE 
            WHEN dbo.fn_fecha_comprobante_ajustada(i.fecha_comprobante)
                > i.fecha_comprobante
            THEN 'fecha un dia posterior a cierre'
            ELSE 'fecha real'
        END AS ctrl_fecha_cierre,
        i.fecha_comprobante,
        c.fecha_contable,
        dbo.fn_fecha_comprobante_ajustada(i.fecha_comprobante) as fecha_contable_cierre,


        CASE 
            WHEN c.estado_stock = 'N'  then 'no controla' 
            WHEN EXISTS (
                SELECT 1
                FROM compras1 c1
                INNER JOIN movi_stock ms 
                    ON ms.deposito              = c1.deposito
                AND ms.articulo              = c1.articulo
                AND ms.fecha                 = c1.fecha_hora
                AND ms.codigo_comprobante    = c1.codigo
                AND ms.letra_comprobante     = c1.letra
                AND ms.sucursal_comprobante  = c1.sucursal
                AND ms.numero_comprobante    = c1.numero
                AND ms.orden                 = c1.orden
                AND ms.serie                 = c1.serie
                WHERE c1.codigo   = i.codigo
                AND c1.letra    = i.letra
                AND c1.sucursal = i.sucursal
                AND c1.numero   = i.numero
            )
            THEN 'ok'
            ELSE 'error'
        END AS ctrl_fecha_movistock

    FROM ingreso_comprobantes_compras_cabecera i
    INNER JOIN compras2 c
        ON c.codigo   = i.codigo
    AND c.letra    = i.letra
    AND c.sucursal = i.sucursal
    AND c.numero   = i.numero
    INNER JOIN proveedores p
        ON p.cuit   = i.cuit
    AND p.numero = c.cuenta
    WHERE i.fecha_hora_procesado_macrogest  = @FechaMaxProcesado
    AND i.errores_importacion = 'Importado correctamente';


END;
GO
