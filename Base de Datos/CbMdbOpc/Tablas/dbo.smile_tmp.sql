USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[smile_tmp]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[smile_tmp](
	[SmlFecha] [datetime] NOT NULL,
	[SmlParFor] [varchar](7) NOT NULL,
	[SmlEstructura] [varchar](10) NOT NULL,
	[SmlDelta] [numeric](3, 0) NOT NULL,
	[SmlDias] [numeric](10, 0) NOT NULL,
	[SmlBid] [float] NULL,
	[SmlAsk] [float] NULL,
	[SmlMid] [float] NULL
) ON [PRIMARY]
GO
