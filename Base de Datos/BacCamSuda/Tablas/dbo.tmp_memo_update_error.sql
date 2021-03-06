USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[tmp_memo_update_error]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tmp_memo_update_error](
	[id] [bigint] NULL,
	[morutcli] [numeric](9, 0) NOT NULL,
	[mocodcli] [numeric](9, 0) NOT NULL,
	[motipope] [char](1) NOT NULL,
	[motipmer] [char](4) NOT NULL,
	[momonmo] [numeric](19, 4) NOT NULL,
	[moticam] [numeric](19, 4) NOT NULL,
	[moentre] [numeric](3, 0) NOT NULL,
	[morecib] [numeric](3, 0) NOT NULL,
	[movaluta1] [datetime] NOT NULL,
	[movaluta2] [datetime] NOT NULL,
	[moterm] [char](15) NOT NULL,
	[mohora] [char](8) NOT NULL
) ON [PRIMARY]
GO
