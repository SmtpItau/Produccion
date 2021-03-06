USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[InkCaEncContrato]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InkCaEncContrato](
	[CaNumFolio] [numeric](8, 0) NOT NULL,
	[CaTipoTransaccion] [varchar](10) NULL,
	[CaNumContrato] [numeric](8, 0) NULL,
	[CaFechaContrato] [datetime] NULL,
	[CaEstado] [varchar](1) NULL,
	[CaCarteraFinanciera] [varchar](6) NULL,
	[CaLibro] [varchar](6) NULL,
	[CaCarNormativa] [varchar](6) NULL,
	[CaSubCarNormativa] [varchar](6) NULL,
	[CaRutCliente] [numeric](9, 0) NULL,
	[CaCodigo] [numeric](9, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[CaNumFolio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
