USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_var_frm]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_var_frm](
	[tipo] [numeric](1, 0) NOT NULL,
	[variable] [char](10) NOT NULL,
	[texto] [char](100) NOT NULL,
	[Glosa] [char](100) NOT NULL,
	[orden] [int] NOT NULL,
	[Tipo_Variable] [char](1) NOT NULL,
	[Parametro1] [char](1) NOT NULL,
	[Parametro2] [char](1) NOT NULL,
	[Parametro3] [char](1) NOT NULL,
	[Parametro4] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_var_frm] ADD  CONSTRAINT [DF__text_var_f__tipo__7ABC33CD]  DEFAULT (0) FOR [tipo]
GO
ALTER TABLE [dbo].[text_var_frm] ADD  CONSTRAINT [DF__text_var___varia__7BB05806]  DEFAULT (' ') FOR [variable]
GO
ALTER TABLE [dbo].[text_var_frm] ADD  CONSTRAINT [DF__text_var___texto__7CA47C3F]  DEFAULT (' ') FOR [texto]
GO
ALTER TABLE [dbo].[text_var_frm] ADD  CONSTRAINT [DF__text_var___Glosa__7D98A078]  DEFAULT (' ') FOR [Glosa]
GO
ALTER TABLE [dbo].[text_var_frm] ADD  CONSTRAINT [DF__text_var___orden__7E8CC4B1]  DEFAULT (0) FOR [orden]
GO
ALTER TABLE [dbo].[text_var_frm] ADD  CONSTRAINT [DF__text_var___Tipo___7F80E8EA]  DEFAULT (' ') FOR [Tipo_Variable]
GO
ALTER TABLE [dbo].[text_var_frm] ADD  CONSTRAINT [DF__text_var___Param__00750D23]  DEFAULT (' ') FOR [Parametro1]
GO
ALTER TABLE [dbo].[text_var_frm] ADD  CONSTRAINT [DF__text_var___Param__0169315C]  DEFAULT (' ') FOR [Parametro2]
GO
ALTER TABLE [dbo].[text_var_frm] ADD  CONSTRAINT [DF__text_var___Param__025D5595]  DEFAULT (' ') FOR [Parametro3]
GO
ALTER TABLE [dbo].[text_var_frm] ADD  CONSTRAINT [DF__text_var___Param__035179CE]  DEFAULT (' ') FOR [Parametro4]
GO
