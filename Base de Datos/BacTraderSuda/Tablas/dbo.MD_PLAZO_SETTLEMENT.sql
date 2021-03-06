USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MD_PLAZO_SETTLEMENT]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PLAZO_SETTLEMENT](
	[dia] [numeric](5, 0) NOT NULL,
	[rut] [numeric](10, 0) NOT NULL,
	[codigo] [numeric](5, 0) NOT NULL,
	[sistema] [char](3) NOT NULL,
	[tipo_operacion] [char](4) NOT NULL,
	[operacion] [numeric](10, 0) NOT NULL,
	[correlativo] [numeric](5, 0) NOT NULL,
	[monto] [float] NOT NULL,
	[estado] [char](1) NOT NULL
) ON [PRIMARY]
GO
