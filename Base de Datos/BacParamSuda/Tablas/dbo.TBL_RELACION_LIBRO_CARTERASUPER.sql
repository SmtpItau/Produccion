USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_RELACION_LIBRO_CARTERASUPER]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RELACION_LIBRO_CARTERASUPER](
	[Rlc_IdSistema] [char](10) NOT NULL,
	[Rlc_IdProducto] [char](10) NOT NULL,
	[Rlc_IdLibro] [char](10) NOT NULL,
	[Rlc_IdCarteraSuper] [char](10) NOT NULL
) ON [PRIMARY]
GO
