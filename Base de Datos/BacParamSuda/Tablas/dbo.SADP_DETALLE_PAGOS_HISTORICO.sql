USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_DETALLE_PAGOS_HISTORICO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO](
	[Id_Detalle_Pago] [int] IDENTITY(1,1) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[nContrato] [numeric](9, 0) NOT NULL,
	[cModulo] [char](5) NOT NULL,
	[iMoneda] [smallint] NOT NULL,
	[iFormaPago] [smallint] NOT NULL,
	[nMonto] [numeric](21, 4) NOT NULL,
	[iRutBeneficiario] [numeric](9, 0) NOT NULL,
	[sDigBeneficiario] [char](1) NOT NULL,
	[sNomBeneficiario] [varchar](50) NOT NULL,
	[sNomBanco] [varchar](50) NOT NULL,
	[sSwift] [varchar](20) NOT NULL,
	[sCtaCte] [varchar](40) NOT NULL,
	[sUsuario] [varchar](15) NOT NULL,
	[sFirma1] [varchar](15) NOT NULL,
	[sFirma2] [varchar](15) NOT NULL,
	[cEstado] [char](3) NOT NULL,
	[cObservaciones] [varchar](255) NOT NULL,
	[iRutCliente] [numeric](10, 0) NOT NULL,
	[iCodigo] [smallint] NOT NULL,
	[iRutBanco] [numeric](10, 0) NOT NULL,
	[sDvBanco] [varchar](1) NOT NULL,
	[vNumTransferencia] [varchar](20) NOT NULL,
	[sEnviadoPor] [varchar](15) NOT NULL,
	[iSecuencia] [numeric](10, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id_Detalle_Pago] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ((0)) FOR [nContrato]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [cModulo]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ((0)) FOR [iMoneda]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ((0)) FOR [iFormaPago]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ((0)) FOR [nMonto]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ((0)) FOR [iRutBeneficiario]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [sDigBeneficiario]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [sNomBeneficiario]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [sNomBanco]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [sSwift]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [sCtaCte]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [sUsuario]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [sFirma1]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [sFirma2]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [cEstado]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [cObservaciones]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [iRutCliente]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [iCodigo]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ((0)) FOR [iRutBanco]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [sDvBanco]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [vNumTransferencia]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ('') FOR [sEnviadoPor]
GO
ALTER TABLE [dbo].[SADP_DETALLE_PAGOS_HISTORICO] ADD  DEFAULT ((1)) FOR [iSecuencia]
GO
