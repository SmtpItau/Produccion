USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[UserOnline]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserOnline](
	[id] [int] NULL,
	[userid] [int] NULL,
	[usersession] [varchar](100) NULL,
	[status] [int] NULL
) ON [PRIMARY]
GO
