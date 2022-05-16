USE [BacLineas]
GO
/****** Object:  Table [dbo].[LCRPARMDAGRUMDA]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LCRPARMDAGRUMDA](
	[LCRParMda1] [numeric](18, 0) NOT NULL,
	[LCRParMda2] [numeric](18, 0) NOT NULL,
	[LCRGruMdaCod] [char](8) NOT NULL,
 CONSTRAINT [Pk_LCRPARMDAGRUMDA] PRIMARY KEY NONCLUSTERED 
(
	[LCRParMda1] ASC,
	[LCRParMda2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LCRPARMDAGRUMDA] ADD  CONSTRAINT [df_LCRPARMDAGRUMDA_lcrparmda1]  DEFAULT (0) FOR [LCRParMda1]
GO
ALTER TABLE [dbo].[LCRPARMDAGRUMDA] ADD  CONSTRAINT [df_LCRPARMDAGRUMDA_lcrparmda2]  DEFAULT (0) FOR [LCRParMda2]
GO
ALTER TABLE [dbo].[LCRPARMDAGRUMDA] ADD  CONSTRAINT [df_LCRPARMDAGRUMDA_lcrgrumda]  DEFAULT ('') FOR [LCRGruMdaCod]
GO
