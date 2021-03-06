USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[SMILE]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SMILE](
	[SmlFecha] [datetime] NOT NULL,
	[SmlParFor] [varchar](7) NOT NULL,
	[SmlEstructura] [varchar](10) NOT NULL,
	[SmlDelta] [numeric](3, 0) NOT NULL,
	[SmlDias] [numeric](10, 0) NOT NULL,
	[SmlBid] [float] NULL,
	[SmlAsk] [float] NULL,
	[SmlMid] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[SmlFecha] ASC,
	[SmlParFor] ASC,
	[SmlEstructura] ASC,
	[SmlDelta] ASC,
	[SmlDias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
