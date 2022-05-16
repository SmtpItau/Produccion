USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_OPCIONES_FORMULARIOS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_OPCIONES_FORMULARIOS](
	[entidad] [char](3) NULL,
	[formulario] [char](30) NULL,
	[nombre_opcion] [char](20) NULL,
	[opcion] [char](20) NULL
) ON [PRIMARY]
GO
