USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[MFBROKER]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MFBROKER](
	[brokrut] [numeric](9, 0) NOT NULL,
	[brokdv] [char](1) NOT NULL,
	[broknombre] [char](40) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[brokrut] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MFBROKER] ADD  CONSTRAINT [DF__mfbroker__brokru__0A9D95DB]  DEFAULT (0) FOR [brokrut]
GO
ALTER TABLE [dbo].[MFBROKER] ADD  CONSTRAINT [DF__mfbroker__brokdv__0B91BA14]  DEFAULT (' ') FOR [brokdv]
GO
ALTER TABLE [dbo].[MFBROKER] ADD  CONSTRAINT [DF__mfbroker__brokno__0C85DE4D]  DEFAULT (' ') FOR [broknombre]
GO
