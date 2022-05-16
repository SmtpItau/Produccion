USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[MEAO]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MEAO](
	[aonumope] [numeric](7, 0) NOT NULL,
	[aocodoma] [numeric](3, 0) NOT NULL,
	[aomonmo] [numeric](17, 4) NOT NULL,
	[aomarca] [char](1) NOT NULL
) ON [PRIMARY]
GO
