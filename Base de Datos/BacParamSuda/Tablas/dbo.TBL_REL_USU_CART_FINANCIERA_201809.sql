USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_REL_USU_CART_FINANCIERA_201809]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_REL_USU_CART_FINANCIERA_201809](
	[Ucf_Usuario] [char](15) NOT NULL,
	[Ucf_Sistema] [char](5) NOT NULL,
	[Ucf_Producto] [char](5) NOT NULL,
	[Ucf_Codigo_Cart] [char](10) NOT NULL,
	[Ucf_Default] [char](1) NOT NULL
) ON [PRIMARY]
GO
