USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[OpcionEstructura]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OpcionEstructura](
	[OpcEstCod] [varchar](10) NOT NULL,
	[OpcEstDsc] [varchar](30) NOT NULL,
	[OpcEstOrden] [numeric](3, 0) NOT NULL,
	[OpcEstVisible] [varchar](1) NOT NULL,
	[OpcContabExterna] [char](1) NOT NULL,
	[OpcContabExternaTip] [varchar](18) NOT NULL,
	[OpcContabExternaProd] [varchar](5) NOT NULL,
	[OpcPagaPrima] [varchar](1) NOT NULL,
	[OpcLiquidaComoForward] [varchar](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OpcEstCod] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[OpcionEstructura] ADD  CONSTRAINT [DF_OpcionEstructura_OpcEstOrden]  DEFAULT ('0') FOR [OpcEstOrden]
GO
ALTER TABLE [dbo].[OpcionEstructura] ADD  CONSTRAINT [DF_OpcionEstructura_OpcEstVisible]  DEFAULT ('0') FOR [OpcEstVisible]
GO
ALTER TABLE [dbo].[OpcionEstructura] ADD  CONSTRAINT [DF_OpcionEstructura_OpcContabExterna]  DEFAULT ('N') FOR [OpcContabExterna]
GO
ALTER TABLE [dbo].[OpcionEstructura] ADD  CONSTRAINT [DF_OpcionEstructura_OpcContabExternaTip]  DEFAULT ('NA') FOR [OpcContabExternaTip]
GO
ALTER TABLE [dbo].[OpcionEstructura] ADD  CONSTRAINT [DF_OpcionEstructura_OpcContabExternaProd]  DEFAULT ('NA') FOR [OpcContabExternaProd]
GO
ALTER TABLE [dbo].[OpcionEstructura] ADD  CONSTRAINT [DF_OpcionEstructura_OpcPagaPrima]  DEFAULT ('S') FOR [OpcPagaPrima]
GO
ALTER TABLE [dbo].[OpcionEstructura] ADD  CONSTRAINT [DF_OpcionEstructura_OpcLiquidaComoForward]  DEFAULT ('N') FOR [OpcLiquidaComoForward]
GO
