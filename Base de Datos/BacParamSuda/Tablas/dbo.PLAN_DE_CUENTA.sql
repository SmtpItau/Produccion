USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PLAN_DE_CUENTA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLAN_DE_CUENTA](
	[cuenta] [char](12) NOT NULL,
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
	[tipo_relacion] [numeric](3, 0) NULL,
	[conversion] [numeric](3, 0) NOT NULL,
 CONSTRAINT [PK__PLAN_DE_CUENTA__793574BC] PRIMARY KEY CLUSTERED 
(
	[cuenta] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF__PLAN_DE_C__Descr__1DC7DAED]  DEFAULT ('') FOR [descripcion]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF__PLAN_DE_C__Glosa__1EBBFF26]  DEFAULT ('') FOR [glosa]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF__PLAN_DE_C__Tipo___1FB0235F]  DEFAULT ('') FOR [tipo_cuenta]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF__PLAN_DE_C__Cuent__20A44798]  DEFAULT ('') FOR [cuenta_imputable]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF__PLAN_DE_C__Con_C__21986BD1]  DEFAULT ('') FOR [con_correccion]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF__PLAN_DE_C__Con_C__228C900A]  DEFAULT ('') FOR [con_centro_costo]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF__PLAN_DE_C__Tipo___2380B443]  DEFAULT ('') FOR [tipo_moneda]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF__PLAN_DE_C__Prod___2474D87C]  DEFAULT (0) FOR [prod_asoc]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF__PLAN_DE_C__Cta_S__2568FCB5]  DEFAULT ('') FOR [cta_sbif]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF__PLAN_DE_C__Tipo___265D20EE]  DEFAULT (0) FOR [tipo_saldo]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF__PLAN_DE_C__Tipo___27514527]  DEFAULT (0) FOR [tipo_relacion]
GO
ALTER TABLE [dbo].[PLAN_DE_CUENTA] ADD  CONSTRAINT [DF_PLAN_DE_CUENTA_conversion]  DEFAULT (0) FOR [conversion]
GO
