USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[memoej]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[memoej](
	[COD_EJEC] [nvarchar](10) NULL,
	[PFN01] [float] NULL,
	[PFN02] [float] NULL,
	[CV001] [float] NULL,
	[CV002] [float] NULL,
	[MON01] [float] NULL,
	[AR001] [float] NULL,
	[VB200] [float] NULL,
	[SUPER] [bit] NOT NULL,
	[CIERR] [bit] NOT NULL,
	[COSTO] [bit] NOT NULL,
	[INMIN] [float] NULL,
	[INMAX] [float] NULL,
	[OVMIN] [float] NULL,
	[OVMAX] [float] NULL
) ON [PRIMARY]
GO
