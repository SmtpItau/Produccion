USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[RENTABILIDAD_DINAMICA]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RENTABILIDAD_DINAMICA](
	[Fecha] [datetime] NOT NULL,
	[Hora] [datetime] NOT NULL,
	[DescalceInicio] [numeric](21, 4) NOT NULL,
	[HnfInicio] [numeric](21, 4) NOT NULL,
	[DescalceCierre] [numeric](21, 4) NOT NULL,
	[HnfCierre] [numeric](21, 4) NOT NULL,
	[TcInicio] [numeric](21, 4) NOT NULL,
	[TcCierre] [numeric](21, 4) NOT NULL,
	[UtilidadTrading] [numeric](21, 4) NOT NULL,
	[UtilidadDescalce] [numeric](21, 4) NOT NULL,
	[Hnf] [numeric](21, 4) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[RENTABILIDAD_DINAMICA] ADD  CONSTRAINT [df_RentabilidadDinamica_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[RENTABILIDAD_DINAMICA] ADD  CONSTRAINT [df_RentabilidadDinamica_Hora]  DEFAULT ('') FOR [Hora]
GO
ALTER TABLE [dbo].[RENTABILIDAD_DINAMICA] ADD  CONSTRAINT [df_RentabilidadDinamica_DescalceInicio]  DEFAULT (0.0) FOR [DescalceInicio]
GO
ALTER TABLE [dbo].[RENTABILIDAD_DINAMICA] ADD  CONSTRAINT [df_RentabilidadDinamica_HnfInicio]  DEFAULT (0.0) FOR [HnfInicio]
GO
ALTER TABLE [dbo].[RENTABILIDAD_DINAMICA] ADD  CONSTRAINT [df_RentabilidadDinamica_DescalceCierre]  DEFAULT (0.0) FOR [DescalceCierre]
GO
ALTER TABLE [dbo].[RENTABILIDAD_DINAMICA] ADD  CONSTRAINT [df_RentabilidadDinamica_HnfCierre]  DEFAULT (0.0) FOR [HnfCierre]
GO
ALTER TABLE [dbo].[RENTABILIDAD_DINAMICA] ADD  CONSTRAINT [df_RentabilidadDinamica_TcInicio]  DEFAULT (0.0) FOR [TcInicio]
GO
ALTER TABLE [dbo].[RENTABILIDAD_DINAMICA] ADD  CONSTRAINT [df_RentabilidadDinamica_TcCierre]  DEFAULT (0.0) FOR [TcCierre]
GO
ALTER TABLE [dbo].[RENTABILIDAD_DINAMICA] ADD  CONSTRAINT [df_RentabilidadDinamica_UtilidadTrading]  DEFAULT (0.0) FOR [UtilidadTrading]
GO
ALTER TABLE [dbo].[RENTABILIDAD_DINAMICA] ADD  CONSTRAINT [df_RentabilidadDinamica_UtilidadDescalce]  DEFAULT (0.0) FOR [UtilidadDescalce]
GO
ALTER TABLE [dbo].[RENTABILIDAD_DINAMICA] ADD  CONSTRAINT [df_RentabilidadDinamica_Hnf]  DEFAULT (0.0) FOR [Hnf]
GO
