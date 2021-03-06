USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[det_pag_borr]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[det_pag_borr](
	[Id_Detalle_Pago] [int] IDENTITY(1,1) NOT NULL,
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
	[iSecuencia] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
