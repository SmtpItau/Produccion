USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CARTERA_DEPOSITOS_IBS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARTERA_DEPOSITOS_IBS](
	[NumeroDeposito] [numeric](9, 0) NOT NULL,
	[Serie] [varchar](12) NOT NULL,
	[FechaApertura] [datetime] NOT NULL,
	[FechaEmisión] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[Moneda] [int] NOT NULL,
	[TasaInteres] [numeric](21, 4) NOT NULL,
	[Base] [int] NOT NULL,
	[Plazo] [int] NOT NULL,
	[MontoInicial] [numeric](21, 4) NOT NULL,
	[CapitalIniPesos] [numeric](21, 4) NOT NULL,
	[CapitalDia] [numeric](21, 4) NOT NULL,
	[CapitalMonOrig] [numeric](21, 4) NOT NULL,
	[CapitalMasUno] [numeric](21, 4) NOT NULL,
	[RutCliente] [numeric](10, 0) NOT NULL,
	[CodCliente] [int] NOT NULL,
	[Libro] [int] NOT NULL,
	[CarteraNormativa] [char](1) NOT NULL,
	[SubCartera] [int] NOT NULL,
	[CarteraFinanciera] [int] NOT NULL,
	[Area] [int] NOT NULL,
	[Relacionado] [char](1) NOT NULL,
 CONSTRAINT [Pk_CARTERA_DEPOSITOS_IBS] PRIMARY KEY CLUSTERED 
(
	[NumeroDeposito] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_NumeroDeposito]  DEFAULT (0) FOR [NumeroDeposito]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_Serie]  DEFAULT ('') FOR [Serie]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_FechaApertura]  DEFAULT ('') FOR [FechaApertura]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_FechaEmisión]  DEFAULT ('') FOR [FechaEmisión]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_FechaVencimiento]  DEFAULT ('') FOR [FechaVencimiento]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_Moneda]  DEFAULT (0) FOR [Moneda]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_TasaInteres]  DEFAULT (0.0) FOR [TasaInteres]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_Base]  DEFAULT (0) FOR [Base]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_Plazo]  DEFAULT (0) FOR [Plazo]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_MontoInicial]  DEFAULT (0.0) FOR [MontoInicial]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_CapitalIniPesos]  DEFAULT (0.0) FOR [CapitalIniPesos]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_CapitalDia]  DEFAULT (0.0) FOR [CapitalDia]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_CapitalMonOrig]  DEFAULT (0.0) FOR [CapitalMonOrig]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_CapitalMasUno]  DEFAULT (0.0) FOR [CapitalMasUno]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_RutCliente]  DEFAULT (0) FOR [RutCliente]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_CodCliente]  DEFAULT (0) FOR [CodCliente]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_Libro]  DEFAULT (0) FOR [Libro]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_CarteraNormativa]  DEFAULT ('') FOR [CarteraNormativa]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_SubCartera]  DEFAULT (0) FOR [SubCartera]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_CarteraFinanciera]  DEFAULT (0) FOR [CarteraFinanciera]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_Area]  DEFAULT (0) FOR [Area]
GO
ALTER TABLE [dbo].[CARTERA_DEPOSITOS_IBS] ADD  CONSTRAINT [df_cartdepibs_Relacionado]  DEFAULT ('N') FOR [Relacionado]
GO
