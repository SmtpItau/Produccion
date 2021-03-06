USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MD_SETTLEMENT]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_SETTLEMENT](
	[rut] [numeric](10, 0) NOT NULL,
	[codigo] [numeric](5, 0) NOT NULL,
	[plazo_ini] [int] NULL,
	[plazo_fin] [int] NULL,
	[productos] [char](10) NULL,
	[monto_asignado] [float] NULL,
	[dia0_ocupado] [float] NULL,
	[dia1_ocupado] [float] NULL,
	[dia2_ocupado] [float] NULL,
	[dia3_ocupado] [float] NULL,
	[dia4_ocupado] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MD_SETTLEMENT] ADD  CONSTRAINT [DF__md_settle__plazo__43794DE0]  DEFAULT (0) FOR [plazo_ini]
GO
ALTER TABLE [dbo].[MD_SETTLEMENT] ADD  CONSTRAINT [DF__md_settle__plazo__446D7219]  DEFAULT (0) FOR [plazo_fin]
GO
ALTER TABLE [dbo].[MD_SETTLEMENT] ADD  CONSTRAINT [DF__md_settle__produ__45619652]  DEFAULT (' ') FOR [productos]
GO
ALTER TABLE [dbo].[MD_SETTLEMENT] ADD  CONSTRAINT [DF__md_settle__monto__4655BA8B]  DEFAULT (0) FOR [monto_asignado]
GO
ALTER TABLE [dbo].[MD_SETTLEMENT] ADD  CONSTRAINT [DF__md_settle__dia0___4749DEC4]  DEFAULT (0) FOR [dia0_ocupado]
GO
ALTER TABLE [dbo].[MD_SETTLEMENT] ADD  CONSTRAINT [DF__md_settle__dia1___483E02FD]  DEFAULT (0) FOR [dia1_ocupado]
GO
ALTER TABLE [dbo].[MD_SETTLEMENT] ADD  CONSTRAINT [DF__md_settle__dia2___49322736]  DEFAULT (0) FOR [dia2_ocupado]
GO
ALTER TABLE [dbo].[MD_SETTLEMENT] ADD  CONSTRAINT [DF__md_settle__dia3___4A264B6F]  DEFAULT (0) FOR [dia3_ocupado]
GO
ALTER TABLE [dbo].[MD_SETTLEMENT] ADD  CONSTRAINT [DF__md_settle__dia4___4B1A6FA8]  DEFAULT (0) FOR [dia4_ocupado]
GO
