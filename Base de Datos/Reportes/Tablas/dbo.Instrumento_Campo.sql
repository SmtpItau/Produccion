USE [Reportes]
GO
/****** Object:  Table [dbo].[Instrumento_Campo]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instrumento_Campo](
	[Id] [int] NOT NULL,
	[InstrumentoId] [int] NOT NULL,
	[CampoId] [int] NOT NULL
) ON [PRIMARY]
GO
