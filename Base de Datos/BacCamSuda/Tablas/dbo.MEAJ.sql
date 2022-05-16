USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEAJ]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEAJ](
	[ajfecha] [datetime] NOT NULL,
	[ajnumope] [numeric](7, 0) NOT NULL,
	[ajmerc01] [char](4) NOT NULL,
	[ajmerc02] [char](4) NOT NULL,
	[ajmonusd] [numeric](17, 4) NOT NULL,
	[ajtccomp] [numeric](9, 4) NOT NULL
) ON [PRIMARY]
GO
