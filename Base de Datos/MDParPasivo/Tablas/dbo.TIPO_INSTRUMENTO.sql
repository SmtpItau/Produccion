USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[TIPO_INSTRUMENTO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_INSTRUMENTO](
	[Codigo_Tipo_instrumento] [char](3) NOT NULL,
	[Nemotecnico] [char](3) NOT NULL
) ON [PRIMARY]
GO
