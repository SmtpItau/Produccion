USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MECAR]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MECAR](
	[carrutcli] [numeric](9, 0) NOT NULL,
	[carcodigo] [numeric](9, 0) NOT NULL,
	[carmonto] [numeric](12, 0) NOT NULL,
	[carfeclib] [datetime] NOT NULL,
	[carfecha] [datetime] NOT NULL,
	[caruser] [char](10) NOT NULL,
	[carhora] [char](10) NOT NULL,
	[carterm] [char](10) NOT NULL,
	[carauto] [char](50) NOT NULL,
	[carnumope] [numeric](9, 0) NOT NULL,
	[carrentab] [numeric](3, 0) NOT NULL,
	[carrecib] [numeric](2, 0) NOT NULL,
	[carejecut] [char](7) NOT NULL
) ON [PRIMARY]
GO
