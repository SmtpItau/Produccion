USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[Brecha]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Brecha](
	[codigo] [char](7) NOT NULL,
	[glosa] [char](40) NOT NULL,
	[Saldo] [numeric](19, 2) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Brecha] ADD  CONSTRAINT [DF__Brecha__codigo__645CB56C]  DEFAULT (' ') FOR [codigo]
GO
ALTER TABLE [dbo].[Brecha] ADD  CONSTRAINT [DF__Brecha__glosa__6550D9A5]  DEFAULT (' ') FOR [glosa]
GO
ALTER TABLE [dbo].[Brecha] ADD  CONSTRAINT [DF__Brecha__Saldo__6644FDDE]  DEFAULT (0) FOR [Saldo]
GO
