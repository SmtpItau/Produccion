USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[TBL_TRXCOMEX_PUNTOS]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_TRXCOMEX_PUNTOS](
	[Banda] [numeric](3, 0) NOT NULL,
	[Moneda] [numeric](3, 0) NOT NULL,
	[Fecha] [datetime] NOT NULL,
	[Plazo] [numeric](3, 0) NOT NULL,
	[Bid] [float] NOT NULL,
	[Ask] [float] NOT NULL,
	[SpreadCom_Compra] [float] NOT NULL,
	[SpreadCom_Venta] [float] NOT NULL,
	[SpreadTra_Compra] [float] NOT NULL,
	[SpreadTra_Venta] [float] NOT NULL,
	[clase] [char](2) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_TRXCOMEX_PUNTOS] ADD  DEFAULT (0) FOR [Banda]
GO
ALTER TABLE [dbo].[TBL_TRXCOMEX_PUNTOS] ADD  DEFAULT (0) FOR [Moneda]
GO
ALTER TABLE [dbo].[TBL_TRXCOMEX_PUNTOS] ADD  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[TBL_TRXCOMEX_PUNTOS] ADD  DEFAULT (0) FOR [Plazo]
GO
ALTER TABLE [dbo].[TBL_TRXCOMEX_PUNTOS] ADD  DEFAULT (0) FOR [Bid]
GO
ALTER TABLE [dbo].[TBL_TRXCOMEX_PUNTOS] ADD  DEFAULT (0) FOR [Ask]
GO
ALTER TABLE [dbo].[TBL_TRXCOMEX_PUNTOS] ADD  DEFAULT (0) FOR [SpreadCom_Compra]
GO
ALTER TABLE [dbo].[TBL_TRXCOMEX_PUNTOS] ADD  DEFAULT (0) FOR [SpreadCom_Venta]
GO
ALTER TABLE [dbo].[TBL_TRXCOMEX_PUNTOS] ADD  DEFAULT (0) FOR [SpreadTra_Compra]
GO
ALTER TABLE [dbo].[TBL_TRXCOMEX_PUNTOS] ADD  DEFAULT (0) FOR [SpreadTra_Venta]
GO
ALTER TABLE [dbo].[TBL_TRXCOMEX_PUNTOS] ADD  DEFAULT (' ') FOR [clase]
GO
