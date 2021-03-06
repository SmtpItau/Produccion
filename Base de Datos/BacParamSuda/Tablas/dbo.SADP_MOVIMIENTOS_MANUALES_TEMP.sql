USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_MOVIMIENTOS_MANUALES_TEMP]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_MOVIMIENTOS_MANUALES_TEMP](
	[id_Transaccion] [numeric](15, 0) IDENTITY(1,1) NOT NULL,
	[dFechaCarga] [datetime] NOT NULL,
	[dFechaMovto] [datetime] NOT NULL,
	[idTX_Carga] [numeric](15, 0) NOT NULL,
	[sOrigen] [varchar](10) NOT NULL,
	[Movimiento] [varchar](1) NOT NULL,
	[Tipo_Operacion] [varchar](25) NOT NULL,
	[RutCliente] [int] NOT NULL,
	[sNombreCliente] [varchar](60) NOT NULL,
	[iFormadPago] [smallint] NOT NULL,
	[Monto] [numeric](21, 4) NOT NULL,
	[sMoneda] [smallint] NOT NULL,
	[iBanco] [int] NOT NULL,
	[sCuenta] [varchar](40) NOT NULL,
	[iRutBeneficiario] [int] NULL,
	[sDvBeneficiario] [varchar](1) NULL,
	[sBeneficiario] [varchar](40) NOT NULL,
	[idNumeroSistema] [numeric](15, 0) NOT NULL,
	[sUserNT] [varchar](20) NOT NULL,
	[sUserAutoriza] [varchar](15) NOT NULL,
	[iOperOriginal] [numeric](10, 0) NULL
) ON [PRIMARY]
GO
