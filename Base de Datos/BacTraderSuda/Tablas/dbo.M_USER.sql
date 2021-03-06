USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[M_USER]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[M_USER](
	[usuario] [char](10) NOT NULL,
	[password] [char](16) NOT NULL,
	[nombre] [char](40) NOT NULL,
	[fec_off] [datetime] NOT NULL,
	[login] [char](10) NOT NULL,
	[aprueba] [char](1) NOT NULL,
	[codigoc] [numeric](3, 0) NOT NULL,
	[codigolc] [char](3) NOT NULL,
	[codigopago] [char](3) NOT NULL,
	[codigoemis] [char](3) NOT NULL,
	[codigotasa] [char](3) NOT NULL,
	[codigolinp] [char](3) NOT NULL,
	[codigobono] [char](3) NOT NULL,
	[codigoin] [char](3) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__USUARIO__1798699D]  DEFAULT (' ') FOR [usuario]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__PASSWORD__188C8DD6]  DEFAULT (' ') FOR [password]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__NOMBRE__1980B20F]  DEFAULT (' ') FOR [nombre]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__FEC_OFF__1A74D648]  DEFAULT (' ') FOR [fec_off]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__LOGIN__1B68FA81]  DEFAULT (' ') FOR [login]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__APRUEBA__1C5D1EBA]  DEFAULT (' ') FOR [aprueba]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__CODIGOC__1D5142F3]  DEFAULT (0) FOR [codigoc]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__CODIGOLC__1E45672C]  DEFAULT (' ') FOR [codigolc]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__CODIGOPA__1F398B65]  DEFAULT (' ') FOR [codigopago]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__CODIGOEM__202DAF9E]  DEFAULT (' ') FOR [codigoemis]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__CODIGOTA__2121D3D7]  DEFAULT (' ') FOR [codigotasa]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__CODIGOLI__2215F810]  DEFAULT (' ') FOR [codigolinp]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__CODIGOBO__230A1C49]  DEFAULT (' ') FOR [codigobono]
GO
ALTER TABLE [dbo].[M_USER] ADD  CONSTRAINT [DF__m_user__CODIGOIN__23FE4082]  DEFAULT (' ') FOR [codigoin]
GO
