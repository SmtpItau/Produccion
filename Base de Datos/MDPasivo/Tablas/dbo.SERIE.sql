USE [MDPasivo]
GO
/****** Object:  Table [dbo].[SERIE]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SERIE](
	[secodigo] [numeric](3, 0) NOT NULL,
	[semascara] [char](12) NOT NULL,
	[seserie] [char](12) NOT NULL,
	[serutemi] [numeric](9, 0) NOT NULL,
	[sefecemi] [datetime] NULL,
	[sefecven] [datetime] NULL,
	[setasemi] [numeric](8, 4) NOT NULL,
	[setera] [numeric](8, 4) NOT NULL,
	[sebasemi] [numeric](5, 0) NOT NULL,
	[semonemi] [numeric](5, 0) NOT NULL,
	[secupones] [numeric](5, 0) NOT NULL,
	[sediavcup] [numeric](5, 0) NOT NULL,
	[sepervcup] [numeric](5, 0) NOT NULL,
	[setipvcup] [char](1) NOT NULL,
	[seplazo] [numeric](5, 0) NOT NULL,
	[setipamort] [numeric](5, 0) NOT NULL,
	[senumamort] [numeric](5, 0) NOT NULL,
	[seffijos] [char](1) NOT NULL,
	[sebascup] [numeric](5, 0) NOT NULL,
	[sedecs] [numeric](5, 0) NOT NULL,
	[secorte] [numeric](19, 4) NOT NULL,
	[setotalemitido] [float] NOT NULL,
	[primer_vcto_variable] [char](1) NOT NULL,
	[primer_vencimiento] [datetime] NOT NULL,
	[tipo_letra] [char](1) NOT NULL,
	[control_amortizacion] [char](1) NOT NULL,
	[spread_tasa] [char](1) NOT NULL
) ON [PRIMARY]
GO
