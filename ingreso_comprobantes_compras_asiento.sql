DROP TABLE DBO.INGRESO_COMPROBANTES_COMPRAS_ASIENTO ;

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
