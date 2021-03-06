USE [MDPasivo]
GO
/****** Object:  Table [dbo].[BIDASK]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BIDASK](
	[moneda] [numeric](5, 0) NOT NULL,
	[fecha] [datetime] NOT NULL,
	[periodo] [numeric](3, 0) NOT NULL,
	[bid] [float] NOT NULL,
	[ask] [float] NOT NULL,
	[factor] [float] NOT NULL
) ON [PRIMARY]
GO
