@echo off
REM === Compilación FEX ===

REM Variables de conexión
set SQLSERVER=bases20
set SQLBASE=clementina
set SQLUSER=am
set SQLPASS=dl

REM 1. Crear Tablas
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Tablas\ingreso_comprobantes_compras_cabecera.sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Tablas\ingreso_comprobantes_compras_items.sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Tablas\ingreso_comprobantes_compras_asiento.sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Tablas\ingreso_comprobantes_compras_ib.sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Tablas\ingreso_comprobantes_codigos_equvalentes.sql"
REM VERSION.sql no suele ser de estructura, pero si es necesario, descomentar:
REM sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Tablas\VERSION.sql"

REM 2. Insertar datos iniciales (opcional)
REM sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Tablas\ingreso_comprobantes_compras_ib.sql"
REM sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Tablas\ingreso_comprobantes_codigos_equvalentes.sql"

REM 3. Crear Funciones
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Funciones\f_sql_comprobante_existente.sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Funciones\f_sql_limpia_cuit.sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Funciones\f_sql_numero_asiento.sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Funciones\f_sql_trae_codigo_cc.sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Funciones\f_setea_sector_fex.sql"


REM 4. Crear Procedimientos
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Procedimientos\[sp_inserta_compras5].sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Procedimientos\[sp_inserta_movi_stock].sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Procedimientos\[sp_inserta_moviprov1].sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Procedimientos\[sp_inserta_compras2].sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Procedimientos\[sp_ingreso_comprobantes_compras].sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Procedimientos\[sp_inserta_compras_ib].sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Procedimientos\[sp_inserta_compras1].sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Procedimientos\[sp_inserta_compras7].sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Procedimientos\sp_marca_duplicados_comprobantes.sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Procedimientos\sp_valida_comprobante_compra.sql"
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -i "Procedimientos\[sp_calcula_iva_compras].sql"


REM Puedes agregar más scripts según corresponda
REM === Verificar objetos instalados ===
sqlcmd -S %SQLSERVER% -d %SQLBASE% -U %SQLUSER% -P %SQLPASS% -Q "WITH ObjetosDeseados AS (SELECT 'Tabla' AS TipoDeseado, name AS nameDeseado FROM (VALUES ('ingreso_comprobantes_compras_cabecera'),('ingreso_comprobantes_compras_items'),('ingreso_comprobantes_compras_asiento'),('ingreso_comprobantes_compras_ib'),('ingreso_comprobantes_codigos_equivalentes')) AS T(name) UNION ALL SELECT 'Funcion', name FROM (VALUES ('f_setea_sector_fex'),('f_sql_comprobante_existente'),('f_sql_limpia_cuit'),('f_sql_numero_asiento'),('f_sql_trae_codigo_cc')) AS T(name) UNION ALL SELECT 'Procedimiento', name FROM (VALUES ('sp_calcula_iva_compras'),('sp_ingreso_comprobantes_compras'),('sp_inserta_compras_ib'),('sp_inserta_compras1'),('sp_inserta_compras2'),('sp_inserta_compras5'),('sp_inserta_compras7'),('sp_inserta_movi_stock'),('sp_inserta_moviprov1'),('sp_marca_duplicados_comprobantes'),('sp_valida_comprobante_compra')) AS T(name)) SELECT od.TipoDeseado AS Tipo, od.nameDeseado AS Objeto, CASE WHEN ex.name IS NULL THEN 'FALTANTE' ELSE 'OK' END AS Estado FROM ObjetosDeseados od LEFT JOIN (SELECT name, 'Tabla' AS Tipo FROM sys.tables UNION ALL SELECT name, 'Funcion' FROM sys.objects WHERE type IN ('FN','IF','TF') UNION ALL SELECT name, 'Procedimiento' FROM sys.objects WHERE type = 'P') ex ON od.nameDeseado = ex.name AND od.TipoDeseado = ex.Tipo ORDER BY od.TipoDeseado, od.nameDeseado;"

echo Instalación FEX finalizada.
pause
