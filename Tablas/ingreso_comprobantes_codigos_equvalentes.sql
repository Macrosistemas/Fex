CREATE TABLE [dbo].[ingreso_comprobantes_codigos_equivalentes](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo_input] [int] NOT NULL,
	[codigo_mg] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]


go

INSERT INTO dbo.ingreso_comprobantes_codigos_equivalentes (codigo_input, codigo_mg) VALUES
	(1, 1),
	(1,30),
	(1,201),
	(1,230),
	(2, 2),
	(2,42),
	(2,202),
	(2,242),
	(3, 3),
	(3,4),
	(3,203),
	(3,204);
