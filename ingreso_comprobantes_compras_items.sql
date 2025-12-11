
/****** Object:  Table [dbo].[ingreso_comprobantes_compras_items]    Script Date: 07/10/2025 8:44:21 ******/
DROP TABLE [dbo].[ingreso_comprobantes_compras_items]
GO

/****** Object:  Table [dbo].[ingreso_comprobantes_compras_items]    Script Date: 07/10/2025 8:44:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

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
	[SERIE] [char](50) NULL,
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


