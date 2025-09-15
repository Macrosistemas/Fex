DROP TABLE DBO.INGRESO_COMPROBANTES_COMPRAS_ITEMS ;

CREATE TABLE [dbo].[ingreso_comprobantes_compras_items](
                [id] [int] IDENTITY(1,1) NOT NULL,
                [id_cabecera] [int] NOT NULL,
                [codigo_articulo] [numeric](8, 0) NOT NULL,
                [denominacion_articulo] [varchar](160) NOT NULL,
                [cantidad] [numeric](16, 4) NOT NULL,
                [precio] [numeric](18, 4) NOT NULL,
                [porc_descuento] [numeric](6, 2) NULL,
                [alicuota_iva] [numeric](6, 2) NOT NULL,
                [concepto_gravado] [decimal](18, 2) NULL,
                [importe_iva] [decimal](18, 2) NULL,
                [concep_no_gravado] [decimal](18, 2) NULL,
                [obra] [numeric](8, 0) NULL,
                [fecha_hora_ingreso] [datetime] NOT NULL,
                [fecha_hora_procesado_macrogest] [datetime] NULL,
                [errores_importacion] [varchar](5000) NULL,
PRIMARY KEY CLUSTERED 
(
                [id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[ingreso_comprobantes_compras_items]  WITH CHECK ADD  CONSTRAINT [FK_IdCabecera] FOREIGN KEY([id_cabecera])
REFERENCES [dbo].[ingreso_comprobantes_compras_cabecera] ([id])
GO
ALTER TABLE [dbo].[ingreso_comprobantes_compras_items] CHECK CONSTRAINT [FK_IdCabecera]
GO
