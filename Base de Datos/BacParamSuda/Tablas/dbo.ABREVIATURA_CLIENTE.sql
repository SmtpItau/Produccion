USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ABREVIATURA_CLIENTE]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ABREVIATURA_CLIENTE](
	[claglosa] [char](35) NULL,
	[clacodigo] [numeric](9, 0) NOT NULL,
	[clarutcli] [numeric](9, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[clarutcli] ASC,
	[clacodigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ABREVIATURA_CLIENTE] ADD  CONSTRAINT [DF__ABREVIATU__Clagl__424F5426]  DEFAULT ('') FOR [claglosa]
GO
