CREATE TABLE [dbo].[ingreso_comprobantes_compras_ib](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[id_cabecera] [int] NOT NULL,
	[provincia] [varchar](3) NOT NULL,
	[importe_ib] [numeric](16, 2) NULL,
	[importe_perc_ib] [numeric](16, 2) NULL,
	[participacion] [numeric](6, 2) NULL,
 CONSTRAINT [PK_ingreso_comprobantes_compras_ib] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ingreso_comprobantes_compras_ib]  WITH CHECK ADD  CONSTRAINT [FK_IdCabecera_ib] FOREIGN KEY([id_cabecera])
REFERENCES [dbo].[ingreso_comprobantes_compras_cabecera] ([id])
GO

ALTER TABLE [dbo].[ingreso_comprobantes_compras_ib] CHECK CONSTRAINT [FK_IdCabecera_ib]
GO

