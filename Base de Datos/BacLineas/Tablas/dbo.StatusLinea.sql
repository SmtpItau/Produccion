USE [BacLineas]
GO
/****** Object:  Table [dbo].[StatusLinea]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatusLinea](
	[SwStatus] [int] NOT NULL,
	[Started] [datetime] NOT NULL,
	[Finish] [datetime] NOT NULL,
 CONSTRAINT [Pk_StatusLinea] PRIMARY KEY CLUSTERED 
(
	[SwStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[StatusLinea] ADD  CONSTRAINT [df_StatusLinea_SwStatus]  DEFAULT ((-1)) FOR [SwStatus]
GO
ALTER TABLE [dbo].[StatusLinea] ADD  CONSTRAINT [df_StatusLinea_Started]  DEFAULT ('') FOR [Started]
GO
ALTER TABLE [dbo].[StatusLinea] ADD  CONSTRAINT [df_StatusLinea_Finish]  DEFAULT ('') FOR [Finish]
GO
