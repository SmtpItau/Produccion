USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TMP_Tbl_Clientes_Riesgo]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMP_Tbl_Clientes_Riesgo](
	[Rut] [numeric](20, 0) NOT NULL,
	[Clasificacion_Fitch] [varchar](10) NOT NULL,
	[Clasificacion_SBIF] [int] NULL
) ON [PRIMARY]
GO
