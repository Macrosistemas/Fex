DROP TABLE DBO.INGRESO_COMPROBANTES_COMPRAS_CABECERA ;

CREATE TABLE [dbo].[ingreso_comprobantes_compras_cabecera](
                [id] [int] IDENTITY(1,1) NOT NULL,
                [codigo] [numeric](4, 0) NOT NULL,
                [letra] [varchar](4) NOT NULL,
                [sucursal] [numeric](5, 0) NOT NULL,
                [numero] [numeric](8, 0) NOT NULL,
                [denominacion] [varchar](255) NOT NULL,
                [cuit] [varchar](15) NULL,
                [fecha_comprobante] [datetime] NOT NULL,
                [fecha_iva] [datetime] NULL,
                [fecha_vencimiento] [datetime] NULL,
                [moneda] [numeric](1, 0) NOT NULL,
                [valor_dolar] [numeric](16, 4) NOT NULL,
                [monto_bonificacion] [decimal](18, 2) NULL,
                [monto_descuento] [decimal](18, 2) NULL,
                [monto_financiacion] [decimal](18, 2) NULL,
                [monto_impuesto] [decimal](18, 2) NULL,
                [monto_impuesto_no_computable] [decimal](18, 2) NULL,
                [importe_perc_canje] [decimal](18, 2) NULL,
                [monto_percepcion_iva] [decimal](18, 2) NULL,
                [monto_percepcion_ganancia] [decimal](18, 2) NULL,
                [monto_percepcion_ingbru] [decimal](18, 2) NULL,
                [monto_percepcion_rg3337] [decimal](18, 2) NULL,
                [concepto_gravado] [decimal](18, 2) NOT NULL,
                [importe_iva] [decimal](18, 2) NOT NULL,
                [concep_no_gravado] [decimal](18, 2) NOT NULL,
                [total_general] [decimal](18, 2) NOT NULL,
                [codigo_rubro_gasto] [numeric](8, 0) NULL,
                [codigo_lugar_pago] [numeric](2, 0) NULL,
                [observaciones_1] [varchar](200) NULL,
                [contrato] [varchar](20) NULL,
                [cod_regimen_ganancias] [numeric](4, 0) NULL,
                [fecha_hora_ingreso] [datetime] NOT NULL,
                [fecha_hora_procesado_macrogest] [datetime] NULL,
                [tipo_comprobante] [varchar](2) NULL,
                [errores_importacion] [varchar](5000) NULL,
PRIMARY KEY CLUSTERED 
([id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO