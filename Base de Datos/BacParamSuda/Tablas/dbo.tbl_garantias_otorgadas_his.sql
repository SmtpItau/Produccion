USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[tbl_garantias_otorgadas_his]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_garantias_otorgadas_his](
	[Fecha] [datetime] NOT NULL,
	[Folio] [numeric](10, 0) NOT NULL,
	[RutCliente] [numeric](10, 0) NOT NULL,
	[CodCliente] [numeric](10, 0) NOT NULL,
	[TipoGarantia] [tinyint] NOT NULL,
	[FechaVigencia] [datetime] NOT NULL,
	[FechaRespaldo] [datetime] NULL,
	[FactorAditivo] [numeric](18, 4) NULL
) ON [PRIMARY]
GO
