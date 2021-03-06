USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_cartera_garantia_his]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_cartera_garantia_his](
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[Instrumento] [varchar](12) NOT NULL,
	[Mascara] [varchar](12) NOT NULL,
	[Nominal] [numeric](21, 4) NOT NULL,
	[TIR] [numeric](9, 6) NOT NULL,
	[VPAR] [numeric](9, 6) NOT NULL,
	[Vpvp] [numeric](9, 6) NOT NULL,
	[ValorPresente] [numeric](21, 0) NOT NULL,
	[ValorPresenteAyer] [numeric](21, 4) NOT NULL,
	[Duration] [float] NOT NULL,
	[DurationMod] [float] NOT NULL,
	[Convexidad] [float] NOT NULL,
	[FechaRespaldo] [datetime] NULL
) ON [PRIMARY]
GO
