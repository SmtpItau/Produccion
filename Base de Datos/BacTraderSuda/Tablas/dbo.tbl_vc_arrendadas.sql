USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[tbl_vc_arrendadas]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_vc_arrendadas](
	[Fecha] [datetime] NOT NULL,
	[Folio] [numeric](18, 0) NOT NULL,
	[Operador] [char](15) NOT NULL,
	[Usuario] [char](15) NOT NULL,
	[RutCliente] [numeric](10, 0) NOT NULL,
	[CodCliente] [numeric](18, 0) NOT NULL,
	[Objetivo] [char](1) NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaTermino] [datetime] NOT NULL,
	[Prima] [numeric](9, 4) NOT NULL,
	[Moneda] [numeric](5, 0) NOT NULL,
	[Base] [numeric](3, 0) NOT NULL,
	[MontoInicialUM] [numeric](19, 4) NOT NULL,
	[MontoFinalUM] [numeric](19, 4) NOT NULL,
	[MontoActualUM] [numeric](19, 4) NOT NULL,
	[CodigoCorredor] [numeric](10, 0) NOT NULL,
	[Codigo_CarteraSuper] [char](1) NULL,
	[Tipo_Cartera_Financiera] [char](1) NULL,
	[id_libro] [char](6) NULL,
	[NumeroCartera] [numeric](10, 0) NOT NULL,
	[Fecha_Anticipo] [datetime] NULL,
	[Estado] [char](1) NOT NULL,
	[FormaPagoIni] [int] NOT NULL,
	[FormaPagoFin] [int] NOT NULL
) ON [PRIMARY]
GO
