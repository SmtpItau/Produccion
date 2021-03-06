USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[tmp_Detalle_vtas_con_pcto]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_Detalle_vtas_con_pcto](
	[Usuario] [varchar](15) NOT NULL,
	[Marca] [char](1) NOT NULL,
	[Documento] [numeric](9, 0) NOT NULL,
	[Correlativo] [numeric](9, 0) NOT NULL,
	[Serie] [varchar](20) NOT NULL,
	[Moneda] [char](3) NOT NULL,
	[Nominal_Compra] [float] NOT NULL,
	[Tasa_Compra] [float] NOT NULL,
	[Valor_Par] [float] NOT NULL,
	[Valor_Presente] [numeric](19, 4) NOT NULL,
	[Margen] [float] NOT NULL,
	[Valor_Inicial] [numeric](19, 4) NOT NULL,
	[Nominal_Venta] [float] NOT NULL,
	[Tasa_Venta] [float] NOT NULL,
	[vPar_Venta] [float] NOT NULL,
	[vPresente_Venta] [numeric](19, 4) NOT NULL,
	[vInicial_Venta] [numeric](19, 4) NOT NULL,
	[Plazo] [numeric](21, 0) NOT NULL,
	[Ventana] [numeric](9, 0) NOT NULL,
	[Fecha_Emision] [datetime] NOT NULL,
	[Fecha_Vence] [datetime] NOT NULL,
	[Fecha_UltCup] [char](10) NOT NULL,
	[Fecha_SigCup] [datetime] NOT NULL,
	[Numero_Cupon] [numeric](3, 0) NOT NULL,
	[Rut_Emisor] [numeric](9, 0) NOT NULL,
	[Mon_Emisor] [numeric](3, 0) NOT NULL,
	[Convexidad] [float] NOT NULL,
	[DurMod] [float] NOT NULL,
	[DurMac] [float] NOT NULL,
	[TasaEstimada] [float] NOT NULL,
	[CarteraSuper] [char](1) NOT NULL,
	[BloqueoPacto] [numeric](19, 4) NOT NULL,
	[HairCut] [float] NOT NULL,
	[TipOper] [char](3) NOT NULL,
	[FolioBCCH] [numeric](9, 0) NOT NULL,
	[CorrelaBCCH] [numeric](3, 0) NOT NULL,
	[inCodigo] [numeric](3, 0) NOT NULL,
	[MarcaVta] [char](1) NOT NULL,
	[cCustodia] [char](1) NOT NULL,
	[cClave] [char](15) NOT NULL
) ON [PRIMARY]
GO
