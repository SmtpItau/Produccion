USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FUSION_Contrato_CondicionesGenerales_migracionClientes]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FUSION_Contrato_CondicionesGenerales_migracionClientes](
	[partyAgreementName] [varchar](50) NULL,
	[extPartyRut] [int] NULL,
	[extPartyDv] [char](1) NULL,
	[estadoPartyAgreement] [int] NULL,
	[estadoPartyAgreementInfo] [int] NULL,
	[excepcion] [varchar](10) NULL,
	[fechaEmitido] [date] NULL,
	[fechaRecibido] [date] NULL,
	[fechaCustodia] [date] NULL,
	[codigo_cliente] [int] NULL,
	[party_agreement_grace_period] [int] NULL,
	[party_agreement_threshold] [float] NULL,
	[party_agreement_haircut] [float] NULL,
	[party_agreement_min_transfer_amount] [float] NULL,
	[party_agreement_currency_id] [int] NULL,
	[party_agreement_collateral_value] [float] NULL
) ON [PRIMARY]
GO
