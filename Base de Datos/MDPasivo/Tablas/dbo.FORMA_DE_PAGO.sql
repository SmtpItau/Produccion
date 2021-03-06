USE [MDPasivo]
GO
/****** Object:  Table [dbo].[FORMA_DE_PAGO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORMA_DE_PAGO](
	[codigo] [numeric](2, 0) NOT NULL,
	[glosa] [char](30) NOT NULL,
	[perfil] [char](9) NOT NULL,
	[codgen] [numeric](3, 0) NOT NULL,
	[glosa2] [char](8) NOT NULL,
	[cc2756] [char](1) NOT NULL,
	[afectacorr] [char](1) NOT NULL,
	[diasvalor] [numeric](3, 0) NOT NULL,
	[numcheque] [char](1) NOT NULL,
	[ctacte] [char](1) NOT NULL,
	[estado] [char](1) NOT NULL,
	[settlement] [char](1) NOT NULL,
	[Relacion_Bcch] [numeric](1, 0) NOT NULL,
	[FORMA_CENTRAL] [char](1) NULL,
	[Contable] [char](1) NOT NULL,
	[destino_contable] [char](2) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_codigo]  DEFAULT ((0)) FOR [codigo]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_glosa]  DEFAULT ('') FOR [glosa]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_perfil]  DEFAULT ('') FOR [perfil]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_codgen]  DEFAULT ((0)) FOR [codgen]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_glosa2]  DEFAULT ('') FOR [glosa2]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_cc2756]  DEFAULT ('') FOR [cc2756]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_afectacorr]  DEFAULT ('') FOR [afectacorr]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_diasvalor]  DEFAULT ((0)) FOR [diasvalor]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_numcheque]  DEFAULT ('') FOR [numcheque]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_ctacte]  DEFAULT ('') FOR [ctacte]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_estado]  DEFAULT ('') FOR [estado]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_settlement]  DEFAULT ('') FOR [settlement]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_Relacion_Bcch]  DEFAULT ((0)) FOR [Relacion_Bcch]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_FORMA_CENTRAL]  DEFAULT ('') FOR [FORMA_CENTRAL]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_Contable]  DEFAULT ('') FOR [Contable]
GO
ALTER TABLE [dbo].[FORMA_DE_PAGO] ADD  CONSTRAINT [DF_FORMA_DE_PAGO_destino_contable]  DEFAULT ('') FOR [destino_contable]
GO
