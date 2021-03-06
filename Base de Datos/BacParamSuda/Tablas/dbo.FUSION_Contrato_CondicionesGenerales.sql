USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FUSION_Contrato_CondicionesGenerales]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FUSION_Contrato_CondicionesGenerales](
	[rut] [varchar](30) NULL,
	[nombre] [varchar](100) NULL,
	[fecha_ccgEmitido] [date] NULL,
	[estado_ccg] [varchar](30) NULL,
	[fecha_recepcion] [date] NULL,
	[party_agreement_grace_period] [int] NULL,
	[party_agreement_threshold] [float] NULL,
	[party_agreement_haircut] [float] NULL,
	[party_agreement_min_transfer_amount] [float] NULL,
	[party_agreement_currency_id] [int] NULL,
	[party_agreement_collateral_value] [float] NULL
) ON [PRIMARY]
GO
