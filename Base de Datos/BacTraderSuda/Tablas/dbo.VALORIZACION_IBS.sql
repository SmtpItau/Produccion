USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[VALORIZACION_IBS]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VALORIZACION_IBS](
	[Fecha] [datetime] NOT NULL,
	[Serie] [varchar](12) NOT NULL,
	[Codigo] [int] NOT NULL,
	[RutCartera] [numeric](10, 0) NOT NULL,
	[NumDocu] [numeric](10, 0) NOT NULL,
	[NumCorrela] [int] NOT NULL,
	[RutEmisor] [numeric](10, 0) NOT NULL,
	[Moneda] [int] NOT NULL,
	[Nominal] [numeric](21, 4) NOT NULL,
	[Tasa] [numeric](21, 4) NOT NULL,
	[vPresente] [numeric](21, 4) NOT NULL,
	[TasaMTM1] [numeric](21, 4) NOT NULL,
	[vMercado1] [numeric](21, 4) NOT NULL,
	[DifMTM1] [numeric](21, 4) NOT NULL,
	[TasaMTM2] [numeric](21, 4) NOT NULL,
	[vMercado2] [numeric](21, 4) NOT NULL,
	[DifMTM2] [numeric](21, 4) NOT NULL,
	[FechaEmision] [datetime] NOT NULL,
	[FechaVcto] [datetime] NOT NULL,
 CONSTRAINT [Pk_valorizacion_ibs] PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC,
	[Serie] ASC,
	[NumDocu] ASC,
	[NumCorrela] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_Serie]  DEFAULT ('') FOR [Serie]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_Codigo]  DEFAULT (0) FOR [Codigo]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_RutCartera]  DEFAULT (0) FOR [RutCartera]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_NumDocu]  DEFAULT (0) FOR [NumDocu]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_NumCorrela]  DEFAULT (0) FOR [NumCorrela]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_RutEmisor]  DEFAULT (0) FOR [RutEmisor]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_Moneda]  DEFAULT (0) FOR [Moneda]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_Nominal]  DEFAULT (0.0) FOR [Nominal]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_Tasa]  DEFAULT (0.0) FOR [Tasa]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_vPresente]  DEFAULT (0.0) FOR [vPresente]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_TasaMTM1]  DEFAULT (0.0) FOR [TasaMTM1]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_vMercado1]  DEFAULT (0.0) FOR [vMercado1]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_DifMTM1]  DEFAULT (0.0) FOR [DifMTM1]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_TasaMTM2]  DEFAULT (0.0) FOR [TasaMTM2]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_vMercado2]  DEFAULT (0.0) FOR [vMercado2]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_DifMTM2]  DEFAULT (0.0) FOR [DifMTM2]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_FechaEmision]  DEFAULT ('') FOR [FechaEmision]
GO
ALTER TABLE [dbo].[VALORIZACION_IBS] ADD  CONSTRAINT [df_valorizacion_ibs_FechaVcto]  DEFAULT ('') FOR [FechaVcto]
GO
