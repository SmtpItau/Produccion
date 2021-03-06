USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Log_Error_DTS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_Error_DTS](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ExecutionID] [uniqueidentifier] NOT NULL,
	[PackageName] [nvarchar](255) NOT NULL,
	[SourceName] [varchar](255) NOT NULL,
	[Message] [nvarchar](max) NOT NULL,
	[MessageCode] [int] NOT NULL,
	[LogDateTime] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
