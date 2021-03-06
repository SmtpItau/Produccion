USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[BacParamSudaFERIADO]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacParamSudaFERIADO](
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
	[fedic] [char](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[feano] ASC,
	[feplaza] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
