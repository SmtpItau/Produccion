USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_arc_ctl_dri]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_arc_ctl_dri](
	[acrutprop] [numeric](9, 0) NOT NULL,
	[acdigprop] [char](1) NOT NULL,
	[acnomprop] [char](40) NOT NULL,
	[acfecante] [datetime] NOT NULL,
	[acfecproc] [datetime] NOT NULL,
	[acfecprox] [datetime] NOT NULL,
	[acnumoper] [numeric](12, 0) NOT NULL,
	[acsw_pd] [char](1) NOT NULL,
	[acsw_co] [char](1) NOT NULL,
	[acsw_dv] [char](1) NOT NULL,
	[acsw_mesa] [char](1) NOT NULL,
	[acsw_fd] [char](1) NOT NULL,
	[acdirprop] [char](40) NOT NULL,
	[acdirinterfaz] [varchar](150) NOT NULL,
	[fondos_banco_c] [char](50) NOT NULL,
	[fondos_cta_c] [char](30) NOT NULL,
	[fondos_pais_c] [char](15) NOT NULL,
	[fondos_ciud_c] [char](15) NOT NULL,
	[fondos_banco_v] [char](50) NOT NULL,
	[fondos_cta_v] [char](30) NOT NULL,
	[fondos_pais_v] [char](15) NOT NULL,
	[fondos_ciud_v] [char](15) NOT NULL,
	[acsw_tm] [char](1) NOT NULL,
	[dolarObsFinMes] [numeric](18, 4) NOT NULL,
	[acnumticket] [numeric](10, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[acrutprop] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acrut__29221CFB]  DEFAULT (0) FOR [acrutprop]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acdig__2A164134]  DEFAULT (' ') FOR [acdigprop]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acnom__2B0A656D]  DEFAULT (' ') FOR [acnomprop]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acfec__2BFE89A6]  DEFAULT (' ') FOR [acfecante]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acfec__2CF2ADDF]  DEFAULT (' ') FOR [acfecproc]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acfec__2DE6D218]  DEFAULT (' ') FOR [acfecprox]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acnum__2EDAF651]  DEFAULT (0) FOR [acnumoper]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acsw___2FCF1A8A]  DEFAULT (' ') FOR [acsw_pd]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acsw___30C33EC3]  DEFAULT (' ') FOR [acsw_co]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acsw___31B762FC]  DEFAULT (' ') FOR [acsw_dv]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acsw___32AB8735]  DEFAULT (' ') FOR [acsw_mesa]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acsw___339FAB6E]  DEFAULT (' ') FOR [acsw_fd]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acdir__3493CFA7]  DEFAULT (' ') FOR [acdirprop]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acdir__3587F3E0]  DEFAULT (' ') FOR [acdirinterfaz]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___fondo__367C1819]  DEFAULT (' ') FOR [fondos_banco_c]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___fondo__37703C52]  DEFAULT (' ') FOR [fondos_cta_c]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___fondo__3864608B]  DEFAULT (' ') FOR [fondos_pais_c]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___fondo__395884C4]  DEFAULT (' ') FOR [fondos_ciud_c]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___fondo__3A4CA8FD]  DEFAULT (' ') FOR [fondos_banco_v]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___fondo__3B40CD36]  DEFAULT (' ') FOR [fondos_cta_v]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___fondo__3C34F16F]  DEFAULT (' ') FOR [fondos_pais_v]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___fondo__3D2915A8]  DEFAULT (' ') FOR [fondos_ciud_v]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___acsw___3E1D39E1]  DEFAULT (' ') FOR [acsw_tm]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  CONSTRAINT [DF__text_arc___dolar__5A254709]  DEFAULT (0) FOR [dolarObsFinMes]
GO
ALTER TABLE [dbo].[text_arc_ctl_dri] ADD  DEFAULT (1) FOR [acnumticket]
GO
