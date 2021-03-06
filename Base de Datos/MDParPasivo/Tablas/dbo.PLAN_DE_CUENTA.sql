USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PLAN_DE_CUENTA]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLAN_DE_CUENTA](
	[cuenta] [char](16) NOT NULL,
	[descripcion] [char](70) NULL,
	[glosa] [char](30) NULL,
	[tipo_cuenta] [char](3) NULL,
	[cuenta_imputable] [char](1) NULL,
	[con_correccion] [char](1) NULL,
	[con_centro_costo] [char](3) NULL,
	[tipo_moneda] [char](1) NULL,
	[prod_asoc] [numeric](5, 0) NULL,
	[cta_sbif] [char](40) NULL,
	[tipo_saldo] [numeric](3, 0) NULL,
	[tipo_relacion] [numeric](3, 0) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_cuenta]  DEFAULT ('') FOR [cuenta]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_descripcion]  DEFAULT ('') FOR [descripcion]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_glosa]  DEFAULT ('') FOR [glosa]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_tipo_cuenta]  DEFAULT ('') FOR [tipo_cuenta]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_cuenta_imputable]  DEFAULT ('') FOR [cuenta_imputable]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_con_correccion]  DEFAULT ('') FOR [con_correccion]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_con_centro_costo]  DEFAULT ('') FOR [con_centro_costo]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_tipo_moneda]  DEFAULT ('') FOR [tipo_moneda]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_prod_asoc]  DEFAULT ((0)) FOR [prod_asoc]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_cta_sbif]  DEFAULT ('') FOR [cta_sbif]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_tipo_saldo]  DEFAULT ((0)) FOR [tipo_saldo]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_tipo_relacion]  DEFAULT ((0)) FOR [tipo_relacion]
GO
