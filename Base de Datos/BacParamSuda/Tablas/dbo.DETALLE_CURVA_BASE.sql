USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[DETALLE_CURVA_BASE]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_CURVA_BASE](
	[fecha_curva_base] [datetime] NOT NULL,
	[codigo_curva] [decimal](3, 0) NOT NULL,
	[desde_curva_base] [numeric](10, 0) NULL,
	[hasta_curva_base] [numeric](10, 0) NULL,
	[tasa_curva_base] [decimal](19, 6) NOT NULL
) ON [PRIMARY]
GO
