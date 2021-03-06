USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_REL_USUARIO_NORMATIVO_201809]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_REL_USUARIO_NORMATIVO_201809](
	[Ucn_Usuario] [char](15) NOT NULL,
	[Ucn_Sistema] [char](5) NOT NULL,
	[Ucn_Producto] [char](5) NOT NULL,
	[Ucn_Codigo_Lib] [char](10) NOT NULL,
	[Ucn_Codigo_CartN] [char](10) NOT NULL,
	[Ucn_Codigo_SubCartN] [char](10) NOT NULL,
	[Ucn_Default] [char](1) NOT NULL
) ON [PRIMARY]
GO
