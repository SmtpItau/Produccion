USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TASA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TASA](
	[codigotasa] [numeric](5, 0) NOT NULL,
	[codigomoneda] [numeric](5, 0) NOT NULL,
	[desde] [numeric](5, 0) NOT NULL,
	[hasta] [numeric](5, 0) NULL,
	[bid] [float] NULL,
	[offer] [float] NULL,
	[tasa] [float] NULL,
	[spread] [float] NULL,
	[tasafinal] [float] NULL,
	[tasazcr] [float] NULL,
	[base] [numeric](5, 0) NULL,
	[baseconv] [float] NULL,
	[fecha] [datetime] NOT NULL,
	[usuario] [char](10) NULL,
PRIMARY KEY CLUSTERED 
(
	[codigotasa] ASC,
	[codigomoneda] ASC,
	[desde] ASC,
	[fecha] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TASA] ADD  CONSTRAINT [DF__TASA__Hasta__12A04104]  DEFAULT (0) FOR [hasta]
GO
ALTER TABLE [dbo].[TASA] ADD  CONSTRAINT [DF__TASA__Bid__1394653D]  DEFAULT (0) FOR [bid]
GO
ALTER TABLE [dbo].[TASA] ADD  CONSTRAINT [DF__TASA__Offer__14888976]  DEFAULT (0) FOR [offer]
GO
ALTER TABLE [dbo].[TASA] ADD  CONSTRAINT [DF__TASA__Tasa__157CADAF]  DEFAULT (0) FOR [tasa]
GO
ALTER TABLE [dbo].[TASA] ADD  CONSTRAINT [DF__TASA__Spread__1670D1E8]  DEFAULT (0) FOR [spread]
GO
ALTER TABLE [dbo].[TASA] ADD  CONSTRAINT [DF__TASA__TasaFinal__1764F621]  DEFAULT (0) FOR [tasafinal]
GO
ALTER TABLE [dbo].[TASA] ADD  CONSTRAINT [DF__TASA__TasaZCR__18591A5A]  DEFAULT (0) FOR [tasazcr]
GO
ALTER TABLE [dbo].[TASA] ADD  CONSTRAINT [DF__TASA__Base__194D3E93]  DEFAULT (0) FOR [base]
GO
ALTER TABLE [dbo].[TASA] ADD  CONSTRAINT [DF__TASA__BaseConv__1A4162CC]  DEFAULT (0) FOR [baseconv]
GO
ALTER TABLE [dbo].[TASA] ADD  CONSTRAINT [DF__TASA__Usuario__1B358705]  DEFAULT ('') FOR [usuario]
GO
