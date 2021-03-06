USE [Reportes]
GO
/****** Object:  Table [dbo].[Campo]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campo](
	[IdCampo] [int] NOT NULL,
	[NombreCampo] [varchar](30) NULL,
	[IdCampoDesc] [int] NULL,
	[IdTabla] [int] NULL,
	[Id] [int] NULL,
	[FLUJO] [int] NULL,
 CONSTRAINT [PKCampo] PRIMARY KEY NONCLUSTERED 
(
	[IdCampo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Campo]  WITH CHECK ADD  CONSTRAINT [Tiene] FOREIGN KEY([IdTabla])
REFERENCES [dbo].[Tablas_Wizard] ([IdTabla])
GO
ALTER TABLE [dbo].[Campo] CHECK CONSTRAINT [Tiene]
GO
