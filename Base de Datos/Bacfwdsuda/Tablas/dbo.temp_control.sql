USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[temp_control]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[temp_control](
	[NOMBRE ] [char](70) NOT NULL,
	[NUMEROR] [numeric](10, 0) NOT NULL,
	[RUT] [numeric](9, 0) NOT NULL,
	[codigo] [numeric](9, 0) NOT NULL
) ON [PRIMARY]
GO
