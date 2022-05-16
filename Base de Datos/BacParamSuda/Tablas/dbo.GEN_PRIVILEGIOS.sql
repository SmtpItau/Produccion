USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[GEN_PRIVILEGIOS]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_PRIVILEGIOS](
	[tipo_privilegio] [char](1) NULL,
	[usuario] [char](15) NULL,
	[entidad] [char](3) NULL,
	[opcion] [char](50) NULL,
	[habilitado] [char](1) NULL
) ON [PRIMARY]
GO
