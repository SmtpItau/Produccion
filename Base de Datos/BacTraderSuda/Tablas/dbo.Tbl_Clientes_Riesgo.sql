USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[Tbl_Clientes_Riesgo]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Clientes_Riesgo](
	[Rut] [numeric](13, 0) NOT NULL,
	[Clasificacion_Fitch] [varchar](10) NOT NULL,
	[Clasificacion_SBIF] [int] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tbl_Clientes_Riesgo] ADD  CONSTRAINT [df_Tbl_Clientes_Riesgo_Rut]  DEFAULT ((0)) FOR [Rut]
GO
ALTER TABLE [dbo].[Tbl_Clientes_Riesgo] ADD  CONSTRAINT [df_Tbl_Clientes_Riesgo_Clasificacion_Fitch]  DEFAULT ('') FOR [Clasificacion_Fitch]
GO
ALTER TABLE [dbo].[Tbl_Clientes_Riesgo] ADD  CONSTRAINT [df_Tbl_Clientes_Riesgo_Clasificacion_SBIF]  DEFAULT ((0)) FOR [Clasificacion_SBIF]
GO
