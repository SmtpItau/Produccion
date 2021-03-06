USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[TBL_TICKERS_BOLSA]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_TICKERS_BOLSA](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[codigo_ticker] [char](2) NULL,
	[hora_ticker] [char](16) NULL,
	[codigo_accion] [char](1) NULL,
	[hora_transaccion] [char](20) NULL,
	[folio] [int] NULL,
	[nemotecnico] [char](10) NULL,
	[codigo_isn] [char](12) NULL,
	[cantidad] [numeric](17, 2) NULL,
	[codigo_corredor_comprador] [int] NULL,
	[codigo_corredor_vendedor] [int] NULL,
	[codigo_operador_comprador] [int] NULL,
	[codigo_operador_vendedor] [int] NULL,
	[condicion_codificada] [char](10) NULL,
	[codicion_desplegable] [char](10) NULL,
	[monto] [decimal](17, 2) NULL,
	[plazo] [int] NULL,
	[plazo_bonos] [int] NULL,
	[precio] [decimal](15, 4) NULL,
	[remate] [char](2) NULL,
	[tir] [decimal](8, 4) NULL,
	[tipo_calculo] [char](1) NULL,
	[estado] [int] NULL,
	[codigo_bac] [int] NULL,
	[usuario] [char](50) NULL,
	[operador_interno_comprador] [char](3) NULL,
	[operador_interno_vendedor] [char](3) NULL,
	[ind_dcv] [char](1) NULL,
	[moneda] [char](3) NULL,
	[monto_moneda_liquidacion] [decimal](15, 2) NULL,
	[emisor] [char](10) NULL,
	[familia] [char](2) NULL,
	[fecha_vencimiento] [char](8) NULL,
	[lugar] [char](1) NULL,
	[lamina] [char](1) NULL,
	[madurez] [char](1) NULL,
	[tiporeajuste] [char](2) NULL,
	[val_resc] [decimal](15, 4) NULL,
	[hora_recepcion] [datetime] NULL,
 CONSTRAINT [PK_tbl_tickes_bolsa] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
