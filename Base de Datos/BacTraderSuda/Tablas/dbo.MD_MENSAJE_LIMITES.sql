USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MD_MENSAJE_LIMITES]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_MENSAJE_LIMITES](
	[codigo] [numeric](5, 0) NOT NULL,
	[mensaje] [char](60) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MD_MENSAJE_LIMITES] ADD  CONSTRAINT [DF__md_mensaj__codig__67C0CFF7]  DEFAULT (0) FOR [codigo]
GO
