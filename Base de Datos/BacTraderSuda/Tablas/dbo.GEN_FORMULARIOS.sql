USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_FORMULARIOS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_FORMULARIOS](
	[entidad] [char](3) NULL,
	[nombre_formulario] [char](30) NULL,
	[formulario] [char](20) NULL,
	[nombre_opcion] [char](30) NULL,
	[opcion] [char](20) NULL
) ON [PRIMARY]
GO
