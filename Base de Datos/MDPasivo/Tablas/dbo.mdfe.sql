USE [MDPasivo]
GO
/****** Object:  Table [dbo].[mdfe]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdfe](
	[feano] [numeric](4, 0) NOT NULL,
	[feplaza] [numeric](3, 0) NOT NULL,
	[feene] [char](100) NOT NULL,
	[fefeb] [char](100) NOT NULL,
	[femar] [char](100) NOT NULL,
	[feabr] [char](100) NOT NULL,
	[femay] [char](100) NOT NULL,
	[fejun] [char](100) NOT NULL,
	[fejul] [char](100) NOT NULL,
	[feago] [char](100) NOT NULL,
	[fesep] [char](100) NOT NULL,
	[feoct] [char](100) NOT NULL,
	[fenov] [char](100) NOT NULL,
	[fedic] [char](100) NOT NULL
) ON [PRIMARY]
GO
