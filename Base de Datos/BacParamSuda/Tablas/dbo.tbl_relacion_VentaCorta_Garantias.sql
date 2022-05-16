USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_relacion_VentaCorta_Garantias]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_relacion_VentaCorta_Garantias](
	[FolioVC] [numeric](18, 0) NOT NULL,
	[RutCliente] [numeric](9, 0) NOT NULL,
	[CodCliente] [numeric](5, 0) NOT NULL,
	[FolioGtia] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
