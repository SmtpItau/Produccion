USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[Log_Socket]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Log_Socket](
	[id] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[fecha] [datetime] NULL,
	[mensaje] [nvarchar](max) NULL,
	[comentario] [nvarchar](50) NULL,
 CONSTRAINT [PK_Log_Socket] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Log_Socket] ADD  CONSTRAINT [DF_Log_Socket_fecha]  DEFAULT (getdate()) FOR [fecha]
GO
