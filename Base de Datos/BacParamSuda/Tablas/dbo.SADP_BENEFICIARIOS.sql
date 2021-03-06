USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_BENEFICIARIOS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_BENEFICIARIOS](
	[nRutBeneficiario] [numeric](10, 0) NOT NULL,
	[cDvBeneficiario] [char](1) NOT NULL,
	[cNomBeneficiario] [varchar](50) NOT NULL,
	[nRutBanco] [numeric](10, 0) NOT NULL,
	[nCodBanco] [int] NOT NULL,
	[cCtaCte] [varchar](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[nRutBeneficiario] ASC,
	[nRutBanco] ASC,
	[cCtaCte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SADP_BENEFICIARIOS] ADD  DEFAULT ((0)) FOR [nRutBeneficiario]
GO
ALTER TABLE [dbo].[SADP_BENEFICIARIOS] ADD  DEFAULT ('') FOR [cDvBeneficiario]
GO
ALTER TABLE [dbo].[SADP_BENEFICIARIOS] ADD  DEFAULT ('') FOR [cNomBeneficiario]
GO
ALTER TABLE [dbo].[SADP_BENEFICIARIOS] ADD  DEFAULT ((0)) FOR [nRutBanco]
GO
ALTER TABLE [dbo].[SADP_BENEFICIARIOS] ADD  DEFAULT ((0)) FOR [nCodBanco]
GO
ALTER TABLE [dbo].[SADP_BENEFICIARIOS] ADD  DEFAULT ('') FOR [cCtaCte]
GO
