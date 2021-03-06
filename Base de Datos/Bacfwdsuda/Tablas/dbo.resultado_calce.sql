USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[resultado_calce]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[resultado_calce](
	[fecha] [datetime] NOT NULL,
	[tipo] [char](9) NOT NULL,
	[activo_saldo_usd] [numeric](21, 4) NOT NULL,
	[activo_variacion_tc] [numeric](21, 0) NOT NULL,
	[activo_variacion_uf] [numeric](21, 0) NOT NULL,
	[activo_devengo] [numeric](21, 0) NOT NULL,
	[activo_devengo_dolares] [numeric](21, 0) NOT NULL,
	[activo_devengo_pesos] [numeric](21, 0) NOT NULL,
	[activo_devengo_uf] [numeric](21, 0) NOT NULL,
	[activo_acumulado_tc] [numeric](21, 0) NOT NULL,
	[activo_acumulado_uf] [numeric](21, 0) NOT NULL,
	[activo_acumulado_devengo] [numeric](21, 0) NOT NULL,
	[activo_acumulado_devengo_dolares] [numeric](21, 0) NOT NULL,
	[activo_acumulado_devengo_pesos] [numeric](21, 0) NOT NULL,
	[activo_acumulado_devengo_uf] [numeric](21, 0) NOT NULL,
	[pasivo_saldo_usd] [numeric](21, 4) NOT NULL,
	[pasivo_variacion_tc] [numeric](21, 0) NOT NULL,
	[pasivo_variacion_uf] [numeric](21, 0) NOT NULL,
	[pasivo_devengo] [numeric](21, 0) NOT NULL,
	[pasivo_devengo_dolares] [numeric](21, 0) NOT NULL,
	[pasivo_devengo_pesos] [numeric](21, 0) NOT NULL,
	[pasivo_devengo_uf] [numeric](21, 0) NOT NULL,
	[pasivo_acumulado_tc] [numeric](21, 0) NOT NULL,
	[pasivo_acumulado_uf] [numeric](21, 0) NOT NULL,
	[pasivo_acumulado_devengo] [numeric](21, 0) NOT NULL,
	[pasivo_acumulado_devengo_dolares] [numeric](21, 0) NOT NULL,
	[pasivo_acumulado_devengo_pesos] [numeric](21, 0) NOT NULL,
	[pasivo_acumulado_devengo_uf] [numeric](21, 0) NOT NULL,
	[neto_dia] [numeric](21, 0) NOT NULL,
	[neto_acumulado] [numeric](21, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__fecha__244C51F8]  DEFAULT (' ') FOR [fecha]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado___tipo__25407631]  DEFAULT (' ') FOR [tipo]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__26349A6A]  DEFAULT (0) FOR [activo_saldo_usd]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__2728BEA3]  DEFAULT (0) FOR [activo_variacion_tc]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__281CE2DC]  DEFAULT (0) FOR [activo_variacion_uf]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__29110715]  DEFAULT (0) FOR [activo_devengo]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__2A052B4E]  DEFAULT (0) FOR [activo_devengo_dolares]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__2AF94F87]  DEFAULT (0) FOR [activo_devengo_pesos]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__2BED73C0]  DEFAULT (0) FOR [activo_devengo_uf]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__2CE197F9]  DEFAULT (0) FOR [activo_acumulado_tc]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__2DD5BC32]  DEFAULT (0) FOR [activo_acumulado_uf]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__2EC9E06B]  DEFAULT (0) FOR [activo_acumulado_devengo]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__2FBE04A4]  DEFAULT (0) FOR [activo_acumulado_devengo_dolares]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__30B228DD]  DEFAULT (0) FOR [activo_acumulado_devengo_pesos]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__activ__31A64D16]  DEFAULT (0) FOR [activo_acumulado_devengo_uf]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__329A714F]  DEFAULT (0) FOR [pasivo_saldo_usd]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__338E9588]  DEFAULT (0) FOR [pasivo_variacion_tc]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__3482B9C1]  DEFAULT (0) FOR [pasivo_variacion_uf]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__3576DDFA]  DEFAULT (0) FOR [pasivo_devengo]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__366B0233]  DEFAULT (0) FOR [pasivo_devengo_dolares]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__375F266C]  DEFAULT (0) FOR [pasivo_devengo_pesos]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__38534AA5]  DEFAULT (0) FOR [pasivo_devengo_uf]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__39476EDE]  DEFAULT (0) FOR [pasivo_acumulado_tc]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__3A3B9317]  DEFAULT (0) FOR [pasivo_acumulado_uf]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__3B2FB750]  DEFAULT (0) FOR [pasivo_acumulado_devengo]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__3C23DB89]  DEFAULT (0) FOR [pasivo_acumulado_devengo_dolares]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__3D17FFC2]  DEFAULT (0) FOR [pasivo_acumulado_devengo_pesos]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__pasiv__3E0C23FB]  DEFAULT (0) FOR [pasivo_acumulado_devengo_uf]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__neto___3F004834]  DEFAULT (0) FOR [neto_dia]
GO
ALTER TABLE [dbo].[resultado_calce] ADD  CONSTRAINT [DF__resultado__neto___3FF46C6D]  DEFAULT (0) FOR [neto_acumulado]
GO
