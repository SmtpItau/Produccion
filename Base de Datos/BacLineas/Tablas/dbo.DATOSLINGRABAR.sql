USE [BacLineas]
GO
/****** Object:  Table [dbo].[DATOSLINGRABAR]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DATOSLINGRABAR](
	[dFecPro] [datetime] NULL,
	[cSistema] [char](3) NULL,
	[cProducto] [char](5) NULL,
	[nRutcli] [numeric](9, 0) NULL,
	[nCodigo] [numeric](9, 0) NULL,
	[nNumoper] [numeric](10, 0) NULL,
	[nNumdocu] [numeric](10, 0) NULL,
	[nCorrela] [numeric](10, 0) NULL,
	[dFeciniop] [datetime] NULL,
	[nMonto] [numeric](19, 4) NULL,
	[fTipcambio] [numeric](8, 4) NULL,
	[dFecvctop] [datetime] NULL,
	[cUsuario] [char](10) NULL,
	[cMonedaOp] [numeric](5, 0) NULL,
	[cTipo_Riesgo] [char](1) NULL,
	[incodigo] [numeric](5, 0) NULL,
	[formapago] [numeric](3, 0) NULL,
	[nContraMoneda] [numeric](3, 0) NOT NULL,
	[nMonedaOpera] [numeric](3, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DATOSLINGRABAR] ADD  CONSTRAINT [DF__DATOSLING__nCont__1B13F4C6]  DEFAULT (0) FOR [nContraMoneda]
GO
ALTER TABLE [dbo].[DATOSLINGRABAR] ADD  CONSTRAINT [DF__DATOSLING__nMone__1C0818FF]  DEFAULT (0) FOR [nMonedaOpera]
GO
