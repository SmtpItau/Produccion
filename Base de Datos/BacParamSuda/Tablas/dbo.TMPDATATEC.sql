USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TMPDATATEC]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TMPDATATEC](
	[fdsd] [datetime] NOT NULL,
	[codigo] [numeric](19, 0) NOT NULL,
	[hora] [char](6) NOT NULL,
	[compraventa] [char](1) NOT NULL,
	[monto] [numeric](10, 0) NOT NULL,
	[precio] [numeric](6, 2) NOT NULL,
	[ctrpart_codigo] [char](4) NOT NULL,
	[ctrpart_usuario] [char](30) NOT NULL,
	[anula] [char](1) NOT NULL,
	[codigo_anulada] [numeric](8, 0) NOT NULL,
	[nomarchivo] [numeric](8, 0) NOT NULL,
	[marcado] [char](30) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatate__FECHA__780B7B02]  DEFAULT ('') FOR [fdsd]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatate__CODIG__78FF9F3B]  DEFAULT (0) FOR [codigo]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatatec__HORA__79F3C374]  DEFAULT ('') FOR [hora]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatate__COMPR__7AE7E7AD]  DEFAULT ('') FOR [compraventa]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatate__MONTO__7BDC0BE6]  DEFAULT (0) FOR [monto]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatate__PRECI__7CD0301F]  DEFAULT (0) FOR [precio]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatate__CTRPA__7DC45458]  DEFAULT ('') FOR [ctrpart_codigo]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatate__CTRPA__7EB87891]  DEFAULT ('') FOR [ctrpart_usuario]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatate__ANULA__7FAC9CCA]  DEFAULT ('') FOR [anula]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatate__CODIG__00A0C103]  DEFAULT (0) FOR [codigo_anulada]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatate__NOMAR__0194E53C]  DEFAULT (0) FOR [nomarchivo]
GO
ALTER TABLE [dbo].[TMPDATATEC] ADD  CONSTRAINT [DF__tmpdatate__MARCA__02890975]  DEFAULT ('') FOR [marcado]
GO
