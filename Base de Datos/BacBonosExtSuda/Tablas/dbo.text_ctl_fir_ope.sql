USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_ctl_fir_ope]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_ctl_fir_ope](
	[orden] [numeric](1, 0) NOT NULL,
	[Menor] [numeric](25, 0) NOT NULL,
	[Mayor] [numeric](25, 0) NOT NULL,
	[autoriza1] [char](40) NOT NULL,
	[autoriza2] [char](40) NOT NULL,
	[autoriza3] [char](40) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_ctl_fir_ope] ADD  CONSTRAINT [DF__text_ctl___orden__43D61337]  DEFAULT (0) FOR [orden]
GO
ALTER TABLE [dbo].[text_ctl_fir_ope] ADD  CONSTRAINT [DF__text_ctl___Menor__44CA3770]  DEFAULT (0) FOR [Menor]
GO
ALTER TABLE [dbo].[text_ctl_fir_ope] ADD  CONSTRAINT [DF__text_ctl___Mayor__45BE5BA9]  DEFAULT (0) FOR [Mayor]
GO
ALTER TABLE [dbo].[text_ctl_fir_ope] ADD  CONSTRAINT [DF__text_ctl___autor__46B27FE2]  DEFAULT (' ') FOR [autoriza1]
GO
ALTER TABLE [dbo].[text_ctl_fir_ope] ADD  CONSTRAINT [DF__text_ctl___autor__47A6A41B]  DEFAULT (' ') FOR [autoriza2]
GO
ALTER TABLE [dbo].[text_ctl_fir_ope] ADD  CONSTRAINT [DF__text_ctl___autor__489AC854]  DEFAULT (' ') FOR [autoriza3]
GO
