USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Tbl_Mesa_Trader]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Mesa_Trader](
	[Mesa] [varchar](200) NOT NULL,
	[Productos] [varchar](50) NOT NULL,
	[SubGerencia] [varchar](50) NOT NULL,
	[SubGerenete] [varchar](2) NOT NULL,
	[Trader] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Tbl_Mesa_Trader] ADD  CONSTRAINT [df_Tbl_Mesa_Trader_Mesa]  DEFAULT ('') FOR [Mesa]
GO
ALTER TABLE [dbo].[Tbl_Mesa_Trader] ADD  CONSTRAINT [df_Tbl_Mesa_Trader_Productos]  DEFAULT ('') FOR [Productos]
GO
ALTER TABLE [dbo].[Tbl_Mesa_Trader] ADD  CONSTRAINT [df_Tbl_Mesa_Trader_SubGerencia]  DEFAULT ('') FOR [SubGerencia]
GO
ALTER TABLE [dbo].[Tbl_Mesa_Trader] ADD  CONSTRAINT [df_Tbl_Mesa_Trader_SubGerenete]  DEFAULT ('') FOR [SubGerenete]
GO
ALTER TABLE [dbo].[Tbl_Mesa_Trader] ADD  CONSTRAINT [df_Tbl_Mesa_Trader_Trader]  DEFAULT ('') FOR [Trader]
GO
