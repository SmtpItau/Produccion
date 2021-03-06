USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CARGACAPTATERCEROS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CARGACAPTATERCEROS](
	[Dfecpro] [datetime] NOT NULL,
	[Nrutcart] [numeric](10, 0) NOT NULL,
	[Dfecvcto] [datetime] NOT NULL,
	[Ftasa] [float] NOT NULL,
	[Ftasatran] [float] NOT NULL,
	[Idias] [int] NOT NULL,
	[Imoneda] [int] NOT NULL,
	[Iforpago] [int] NOT NULL,
	[Nrutcli] [numeric](9, 0) NOT NULL,
	[Ncodcli] [numeric](9, 0) NOT NULL,
	[Cretiro] [char](1) NOT NULL,
	[Nnumdocu] [numeric](10, 0) NOT NULL,
	[Ccustodia] [char](1) NOT NULL,
	[ctipo_deposito] [char](1) NOT NULL,
	[ncorrela_corte] [numeric](3, 0) NOT NULL,
	[ncorrela_oper] [numeric](5, 0) NOT NULL,
	[nmtoini] [numeric](19, 4) NOT NULL,
	[nmtoiniclp] [numeric](19, 0) NOT NULL,
	[nmontofin] [numeric](19, 4) NOT NULL,
	[susuari] [char](20) NOT NULL,
	[Ejecutivo] [int] NOT NULL,
	[Condicion] [char](1) NOT NULL,
	[pago_hoy] [char](1) NOT NULL,
	[dFecPmH] [char](10) NOT NULL,
	[observ] [char](70) NOT NULL,
	[sucursal] [char](5) NOT NULL,
	[Tipo_Emision] [int] NOT NULL,
	[cTerminal] [varchar](15) NOT NULL,
	[Numero_certificado_dcv] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
