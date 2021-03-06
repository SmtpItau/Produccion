USE [Reportes]
GO
/****** Object:  Table [dbo].[Tablas_Wizard]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tablas_Wizard](
	[IdTabla] [int] NOT NULL,
	[NombreTabla] [varchar](20) NULL,
	[IdInstrumento] [int] NULL,
	[IdCmov] [int] NULL,
	[BASEDATO] [varchar](20) NOT NULL,
 CONSTRAINT [PKTabla] PRIMARY KEY NONCLUSTERED 
(
	[IdTabla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tablas_Wizard]  WITH CHECK ADD  CONSTRAINT [Identifica] FOREIGN KEY([IdCmov])
REFERENCES [dbo].[Mocartera] ([IdCmov])
GO
ALTER TABLE [dbo].[Tablas_Wizard] CHECK CONSTRAINT [Identifica]
GO
ALTER TABLE [dbo].[Tablas_Wizard]  WITH CHECK ADD  CONSTRAINT [Pertenece] FOREIGN KEY([IdInstrumento])
REFERENCES [dbo].[Instrumento] ([IdInstrumento])
GO
ALTER TABLE [dbo].[Tablas_Wizard] CHECK CONSTRAINT [Pertenece]
GO
