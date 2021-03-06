USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TASA_MONEDA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TASA_MONEDA](
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
ALTER TABLE [dbo].[TASA_MONEDA] ADD  CONSTRAINT [DF__TASA_MONE__Hasta__702996C1]  DEFAULT (0) FOR [hasta]
GO
ALTER TABLE [dbo].[TASA_MONEDA] ADD  CONSTRAINT [DF__TASA_MONEDA__Bid__711DBAFA]  DEFAULT (0) FOR [bid]
GO
ALTER TABLE [dbo].[TASA_MONEDA] ADD  CONSTRAINT [DF__TASA_MONE__Offer__7211DF33]  DEFAULT (0) FOR [offer]
GO
ALTER TABLE [dbo].[TASA_MONEDA] ADD  CONSTRAINT [DF__TASA_MONED__Tasa__7306036C]  DEFAULT (0) FOR [tasa]
GO
ALTER TABLE [dbo].[TASA_MONEDA] ADD  CONSTRAINT [DF__TASA_MONE__Sprea__73FA27A5]  DEFAULT (0) FOR [spread]
GO
ALTER TABLE [dbo].[TASA_MONEDA] ADD  CONSTRAINT [DF__TASA_MONE__TasaF__74EE4BDE]  DEFAULT (0) FOR [tasafinal]
GO
ALTER TABLE [dbo].[TASA_MONEDA] ADD  CONSTRAINT [DF__TASA_MONE__TasaZ__75E27017]  DEFAULT (0) FOR [tasazcr]
GO
ALTER TABLE [dbo].[TASA_MONEDA] ADD  CONSTRAINT [DF__TASA_MONED__Base__76D69450]  DEFAULT (0) FOR [base]
GO
ALTER TABLE [dbo].[TASA_MONEDA] ADD  CONSTRAINT [DF__TASA_MONE__BaseC__77CAB889]  DEFAULT (0) FOR [baseconv]
GO
ALTER TABLE [dbo].[TASA_MONEDA] ADD  CONSTRAINT [DF__TASA_MONE__Usuar__78BEDCC2]  DEFAULT ('') FOR [usuario]
GO
