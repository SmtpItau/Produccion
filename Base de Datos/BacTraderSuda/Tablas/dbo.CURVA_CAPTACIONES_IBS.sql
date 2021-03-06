USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CURVA_CAPTACIONES_IBS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CURVA_CAPTACIONES_IBS](
	[IdCurva] [varchar](50) NOT NULL,
	[Moneda] [int] NOT NULL,
	[PlazoDesde] [int] NOT NULL,
	[PlazoHasta] [int] NOT NULL,
	[Tasa] [float] NOT NULL,
	[Indice] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [Pk_Cuervas_Captaciones_Ibs] PRIMARY KEY NONCLUSTERED 
(
	[IdCurva] ASC,
	[Moneda] ASC,
	[PlazoDesde] ASC,
	[PlazoHasta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CURVA_CAPTACIONES_IBS] ADD  CONSTRAINT [df_CurvaCaptaIbs_IdCurva]  DEFAULT ('') FOR [IdCurva]
GO
ALTER TABLE [dbo].[CURVA_CAPTACIONES_IBS] ADD  CONSTRAINT [df_CurvaCaptaIbs_Moneda]  DEFAULT (0) FOR [Moneda]
GO
ALTER TABLE [dbo].[CURVA_CAPTACIONES_IBS] ADD  CONSTRAINT [df_CurvaCaptaIbs_PlazoDesde]  DEFAULT (0) FOR [PlazoDesde]
GO
ALTER TABLE [dbo].[CURVA_CAPTACIONES_IBS] ADD  CONSTRAINT [df_CurvaCaptaIbs_PlazoHasta]  DEFAULT (0) FOR [PlazoHasta]
GO
ALTER TABLE [dbo].[CURVA_CAPTACIONES_IBS] ADD  CONSTRAINT [df_CurvaCaptaIbs_Tasa]  DEFAULT (0.0) FOR [Tasa]
GO
