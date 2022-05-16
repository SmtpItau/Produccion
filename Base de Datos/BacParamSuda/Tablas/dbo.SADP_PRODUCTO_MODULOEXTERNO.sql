USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_PRODUCTO_MODULOEXTERNO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_PRODUCTO_MODULOEXTERNO](
	[Modulo] [char](4) NOT NULL,
	[Codigo] [varchar](5) NOT NULL,
	[Producto] [varchar](50) NOT NULL,
	[CodInterno] [varchar](10) NOT NULL,
	[sMovimiento] [varchar](1) NULL
) ON [PRIMARY]
GO
