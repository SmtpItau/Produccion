USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[tbl_Defecto_Corresponsal_FPago_OptExt_Fwd]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tbl_Defecto_Corresponsal_FPago_OptExt_Fwd](
	[Origen] [varchar](10) NOT NULL,
	[CodMon] [numeric](5, 0) NOT NULL,
	[TipoCV] [varchar](1) NOT NULL,
	[CodMon2] [numeric](5, 0) NOT NULL,
	[Forma_pagomn] [numeric](5, 0) NOT NULL,
	[Forma_pagomx] [numeric](5, 0) NOT NULL,
	[CodAreaResponable] [varchar](6) NOT NULL,
	[CodCartNorm] [varchar](6) NOT NULL,
	[CodSubCartNorm] [varchar](6) NOT NULL,
	[CodLibro] [varchar](6) NOT NULL,
	[CodCart] [numeric](9, 0) NOT NULL,
	[nBroker] [numeric](5, 0) NOT NULL,
	[TipRetiro] [numeric](5, 0) NOT NULL,
	[Operador] [varchar](15) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Origen] ASC,
	[CodMon] ASC,
	[TipoCV] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tbl_Defecto_Corresponsal_FPago_OptExt_Fwd] ADD  DEFAULT ('') FOR [Origen]
GO
