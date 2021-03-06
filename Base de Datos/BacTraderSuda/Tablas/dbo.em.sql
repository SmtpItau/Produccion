USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[em]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[em](
	[emcodigo] [numeric](9, 0) NOT NULL,
	[emrut] [numeric](9, 0) NOT NULL,
	[emdv] [char](1) NOT NULL,
	[emnombre] [char](40) NOT NULL,
	[emgeneric] [char](10) NOT NULL,
	[emdirecc] [char](40) NULL,
	[emcomuna] [numeric](4, 0) NULL,
	[emtipo] [char](3) NOT NULL,
	[emglosa] [char](20) NULL,
	[embonos] [char](20) NULL
) ON [PRIMARY]
GO
