USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_RELACION_PRODUCTO_LIBRO]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_RELACION_PRODUCTO_LIBRO](
	[Rpl_IdSistema] [char](10) NOT NULL,
	[Rpl_IdProducto] [char](10) NOT NULL,
	[Rpl_IdLibro] [char](10) NOT NULL
) ON [PRIMARY]
GO
