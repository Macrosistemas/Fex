CREATE FUNCTION dbo.f_sql_numero_asiento (
    @empresa INT,
    @sucursal INT,
    @fecha DATE,
    @conta CHAR(1),          -- 'S' o 'N', resultado de f_evento('contabil')
    @nonumero CHAR(1),       -- 'S', 'N' o NULL, resultado de f_evento('conmindes')
    @contalin BIT            -- gb_contalin, para activar inserts, pero se ignora en esta versi�n
)
RETURNS INT
AS
BEGIN
    DECLARE 
        @asiento INT = 0,
        @tipo CHAR(1),
        @feci DATE,
        @fecf DATE,
        @fece DATE,
        @nro_normal INT,
        @nro_extensivo INT,
        @uso INT,
        @periodo CHAR(1)

    -- Obtener tipo de numeraci�n
    SELECT @tipo = tipo_numeracion_diario 
    FROM co_empresa 
    WHERE empresa = @empresa

    IF LEN(ISNULL(@tipo, '')) = 0 SET @tipo = 'D'

    IF @conta = 'S'
    BEGIN
        IF LEN(ISNULL(@nonumero, '')) = 0 SET @nonumero = 'N'

        IF @tipo = 'C'
        BEGIN
            SELECT @feci = fecha_inicio, @fecf = fecha_final, @fece = fecha_extensivo
            FROM co_empresa
            WHERE empresa = @empresa

            -- Determinar per�odo
            IF @nonumero = 'S' OR (@fecha >= @feci AND @fecha <= @fecf)
                SET @periodo = 'N'
            ELSE IF @fecha <= @fece
                SET @periodo = 'E'
            ELSE
                SET @periodo = 'P'

            -- Obtener n�meros actuales
            SELECT @nro_normal = numero_normal, @nro_extensivo = numero_extensivo
            FROM co_punmov
            WHERE empresa = @empresa AND sucursal = @sucursal

            IF @nro_normal IS NULL SET @nro_normal = 100
            IF @nro_extensivo IS NULL SET @nro_extensivo = 100

            IF @periodo = 'N'
                SET @asiento = @nro_normal + 1
            ELSE IF @periodo = 'E'
                SET @asiento = @nro_extensivo + 1
            ELSE
                SET @asiento = 999999 -- sin configuraci�n extensiva

            -- Validar que no est� usado
            WHILE EXISTS (
                SELECT 1 FROM co_uso_nro 
                WHERE numero = @asiento AND tipo = @periodo
            )
                SET @asiento += 1
        END
        ELSE
        BEGIN
            -- Tipo diario
            SELECT @asiento = numero 
            FROM co_nro_asiento
            WHERE fecha = @fecha

            IF @asiento IS NULL
            BEGIN
                SELECT @feci = fecha_inicio, @fecf = fecha_final, @fece = fecha_extensivo
                FROM co_empresa
                WHERE empresa = @empresa

                -- Determinar per�odo
                IF @nonumero = 'S' OR (@fecha >= @feci AND @fecha <= @fecf)
                    SET @periodo = 'N'
                ELSE IF @fecha <= @fece
                    SET @periodo = 'E'
                ELSE
                    SET @periodo = 'P'

                SELECT @nro_normal = numero_normal, @nro_extensivo = numero_extensivo
                FROM co_punmov
                WHERE empresa = @empresa AND sucursal = @sucursal

                IF @nro_normal IS NULL SET @nro_normal = 100
                IF @nro_extensivo IS NULL SET @nro_extensivo = 100

                IF @periodo = 'N'
                    SET @asiento = @nro_normal + 1
                ELSE IF @periodo = 'E'
                    SET @asiento = @nro_extensivo + 1
                ELSE
                    SET @asiento = 999999
            END
        END
    END

    RETURN @asiento
END
