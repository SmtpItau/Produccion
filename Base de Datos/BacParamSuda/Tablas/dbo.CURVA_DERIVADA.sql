USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CURVA_DERIVADA]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CURVA_DERIVADA](
	[fecha_curva_derivada] [datetime] NOT NULL,
	[incodigo] [decimal](3, 0) NOT NULL,
	[mncodmon] [decimal](5, 0) NOT NULL,
	[codigo_curva] [decimal](3, 0) NOT NULL,
	[desde_curva_derivada] [numeric](10, 0) NULL,
	[hasta_curva_derivada] [numeric](10, 0) NULL,
	[tasa_curva_base] [decimal](19, 6) NOT NULL,
	[spread] [decimal](19, 4) NOT NULL,
	[factor_derivacion] [decimal](19, 4) NOT NULL,
	[tasa_derivada] [decimal](19, 6) NOT NULL
) ON [PRIMARY]
GO
