USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PivotalProductoFlow]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PivotalProductoFlow](
	[Clasificacion] [nvarchar](50) NOT NULL,
	[Negocio] [nvarchar](25) NOT NULL,
	[Familia] [nvarchar](50) NOT NULL,
	[CodigoProducto] [nvarchar](25) NOT NULL
) ON [PRIMARY]
GO
