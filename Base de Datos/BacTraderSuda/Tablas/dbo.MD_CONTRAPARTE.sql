USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MD_CONTRAPARTE]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_CONTRAPARTE](
	[rut] [numeric](10, 0) NOT NULL,
	[codigo] [numeric](5, 0) NOT NULL,
	[producto] [char](1) NOT NULL,
	[plazo_desde] [numeric](5, 0) NOT NULL,
	[plazo_hasta] [numeric](5, 0) NOT NULL,
	[monto] [float] NOT NULL
) ON [PRIMARY]
GO
