USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[OpcionesResGeneral]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpcionesResGeneral](
	[entidad] [char](2) NOT NULL,
	[codigo] [char](3) NOT NULL,
	[nombre] [char](45) NOT NULL,
	[rut] [numeric](9, 0) NOT NULL,
	[direccion] [char](50) NOT NULL,
	[comuna] [char](20) NOT NULL,
	[ciudad] [char](20) NOT NULL,
	[telefono] [char](10) NOT NULL,
	[fax] [char](15) NOT NULL,
	[fechaant] [datetime] NOT NULL,
	[fechaproc] [datetime] NOT NULL,
	[fechaprox] [datetime] NOT NULL,
	[numero_Contrato] [numeric](10, 0) NOT NULL,
	[numero_Folio] [numeric](10, 0) NOT NULL,
	[rutbcch] [numeric](9, 0) NOT NULL,
	[iniciodia] [numeric](1, 0) NOT NULL,
	[findia] [numeric](1, 0) NOT NULL,
	[cierreMesa] [char](1) NOT NULL,
	[devengo] [numeric](1, 0) NOT NULL,
	[contabilidad] [numeric](1, 0) NOT NULL,
	[Vencimientos] [int] NOT NULL,
	[Fijacion] [int] NOT NULL,
	[VoucherNumero] [numeric](10, 0) NOT NULL,
	[RutaIntCon] [char](50) NOT NULL,
	[RutaIntSigir] [char](50) NOT NULL,
	[CargaParamSudaCierre] [numeric](3, 0) NOT NULL
) ON [PRIMARY]
GO
