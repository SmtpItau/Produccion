USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ValoresDefecto]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ValoresDefecto](
	[moneda] [nchar](10) NOT NULL,
	[compra_desde] [nchar](10) NULL,
	[compra_donde] [nchar](10) NULL,
	[venta_desde] [nchar](10) NULL,
	[venta_donde] [nchar](10) NULL,
	[producto] [nchar](10) NOT NULL,
	[venta_corresponsal] [nchar](10) NULL,
	[compra_corresponsal] [nchar](10) NULL,
 CONSTRAINT [PK_ValoresDefecto] PRIMARY KEY CLUSTERED 
(
	[moneda] ASC,
	[producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
