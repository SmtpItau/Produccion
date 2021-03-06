USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[Cetac]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cetac](
	[tac_codtx] [numeric](2, 0) NOT NULL,
	[tac_fecha] [datetime] NOT NULL,
	[tac_codmon] [char](3) NOT NULL,
	[tac_mtoori] [numeric](19, 4) NOT NULL,
	[tac_mtousd] [numeric](19, 4) NOT NULL,
	[tac_mtopes] [numeric](19, 4) NOT NULL,
	[tac_paridad] [numeric](19, 8) NOT NULL,
	[tac_cambio] [numeric](19, 4) NOT NULL,
	[tac_fpagpe] [numeric](2, 0) NOT NULL,
	[tac_fpagmx] [numeric](2, 0) NOT NULL,
	[tac_numope] [numeric](7, 0) NOT NULL,
	[tac_refer] [numeric](7, 0) NOT NULL,
	[tac_tipope] [char](1) NOT NULL,
	[tac_rutcli] [numeric](9, 0) NOT NULL,
	[tac_tipcli] [numeric](1, 0) NOT NULL,
	[tac_fecctb] [datetime] NOT NULL,
	[tac_tipop] [char](1) NOT NULL,
	[tac_difrev] [numeric](19, 0) NOT NULL,
	[tac_utirev] [numeric](19, 0) NOT NULL,
	[tac_perrev] [numeric](19, 0) NOT NULL,
	[tac_impuesto] [numeric](19, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[tac_numope] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cetac] ADD  CONSTRAINT [DF__Cetac__tac_mtoor__2D75C97F]  DEFAULT ('') FOR [tac_mtoori]
GO
ALTER TABLE [dbo].[Cetac] ADD  CONSTRAINT [DF__Cetac__tac_tipop__2E69EDB8]  DEFAULT ('') FOR [tac_tipope]
GO
ALTER TABLE [dbo].[Cetac] ADD  CONSTRAINT [DF__Cetac__tac_tipop__2F5E11F1]  DEFAULT ('') FOR [tac_tipop]
GO
