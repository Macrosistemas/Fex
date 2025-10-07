USE [pruebasfex]
GO

ALTER TABLE [dbo].[ingreso_comprobantes_compras_asiento] DROP CONSTRAINT [FK_IdCabecera_asiento]
GO

/****** Object:  Table [dbo].[ingreso_comprobantes_compras_asiento]    Script Date: 07/10/2025 8:44:07 ******/
DROP TABLE [dbo].[ingreso_comprobantes_compras_asiento]
GO

/****** Object:  Table [dbo].[ingreso_comprobantes_compras_asiento]    Script Date: 07/10/2025 8:44:07 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[ingreso_comprobantes_compras_asiento](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_cabecera] [int] NOT NULL,
	[cuenta_contable] [varchar](12) NULL,
	[importe_debe] [numeric](18, 2) NULL,
	[importe_haber] [numeric](18, 2) NULL,
	[concepto] [varchar](300) NULL,
	[detalle_comprobante] [varchar](120) NULL,
	[sector] [numeric](8, 0) NULL,
	[actividad] [numeric](8, 0) NULL,
	[subactividad] [numeric](8, 0) NULL,
	[centro_costo] [numeric](8, 0) NULL,
	[errores_importacion] [varchar](5000) NULL,
	[CODIGO_OBJETO_COSTO] [numeric](8, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ingreso_comprobantes_compras_asiento]  WITH CHECK ADD  CONSTRAINT [FK_IdCabecera_asiento] FOREIGN KEY([id_cabecera])
REFERENCES [dbo].[ingreso_comprobantes_compras_cabecera] ([id])
GO

ALTER TABLE [dbo].[ingreso_comprobantes_compras_asiento] CHECK CONSTRAINT [FK_IdCabecera_asiento]
GO


