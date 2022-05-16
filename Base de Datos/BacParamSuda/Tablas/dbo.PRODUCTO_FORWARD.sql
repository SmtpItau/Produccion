USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PRODUCTO_FORWARD]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO_FORWARD](
	[BfwCodigoProducto] [char](5) NOT NULL,
	[BfwDescripcion] [varchar](50) NOT NULL,
	[BfwIdSistema] [char](3) NOT NULL,
	[BfwIdentificaProducto] [char](5) NOT NULL
) ON [PRIMARY]
GO
