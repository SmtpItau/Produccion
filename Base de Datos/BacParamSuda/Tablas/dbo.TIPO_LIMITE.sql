USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TIPO_LIMITE]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_LIMITE](
	[Codigo_Grupo_Limite] [decimal](18, 0) NOT NULL,
	[Codigo_Limite] [decimal](18, 0) NOT NULL,
	[Descripcion] [char](30) NOT NULL,
	[Excepcion] [char](1) NOT NULL
) ON [PRIMARY]
GO
