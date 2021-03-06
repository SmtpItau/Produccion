USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Log_Ejecucion_DTS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_Ejecucion_DTS](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ExecutionID] [uniqueidentifier] NOT NULL,
	[PackageName] [nvarchar](255) NOT NULL,
	[PackageID] [varchar](50) NOT NULL,
	[UserName] [nvarchar](100) NULL,
	[MachineName] [nvarchar](255) NULL,
	[StartDateTime] [datetime] NOT NULL,
	[EndDateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
