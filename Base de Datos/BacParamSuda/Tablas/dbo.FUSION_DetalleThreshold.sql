USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FUSION_DetalleThreshold]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FUSION_DetalleThreshold](
	[contraparte] [varchar](100) NULL,
	[rut] [varchar](20) NULL,
	[party_agreement_grace_period] [varchar](20) NULL,
	[party_agreement_threshold] [varchar](20) NULL,
	[party_agreement_haircut] [varchar](20) NULL,
	[party_agreement_min_transfer_amount] [float] NULL,
	[party_agreement_currency_id] [varchar](20) NULL,
	[party_agreement_collateral_value] [float] NULL
) ON [PRIMARY]
GO
