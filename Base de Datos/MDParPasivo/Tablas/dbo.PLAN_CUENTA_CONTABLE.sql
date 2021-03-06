USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[PLAN_CUENTA_CONTABLE]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PLAN_CUENTA_CONTABLE](
	[ristra_contable] [char](69) NOT NULL,
	[cuenta_contable] [char](15) NOT NULL,
	[codigo_inversion] [numeric](5, 0) NOT NULL,
	[tipo_producto] [numeric](3, 0) NOT NULL,
	[codigo_consolidacion] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[PLAN_CUENTA_CONTABLE] ADD  CONSTRAINT [DF_PLAN_CUENTA_CONTABLE_ristra_contable]  DEFAULT ('') FOR [ristra_contable]
GO
ALTER TABLE [dbo].[PLAN_CUENTA_CONTABLE] ADD  CONSTRAINT [DF_PLAN_CUENTA_CONTABLE_cuenta_contable]  DEFAULT ('') FOR [cuenta_contable]
GO
ALTER TABLE [dbo].[PLAN_CUENTA_CONTABLE] ADD  CONSTRAINT [DF_PLAN_CUENTA_CONTABLE_codigo_inversion]  DEFAULT ((0)) FOR [codigo_inversion]
GO
ALTER TABLE [dbo].[PLAN_CUENTA_CONTABLE] ADD  CONSTRAINT [DF_PLAN_CUENTA_CONTABLE_tipo_producto]  DEFAULT ((0)) FOR [tipo_producto]
GO
ALTER TABLE [dbo].[PLAN_CUENTA_CONTABLE] ADD  CONSTRAINT [DF_PLAN_CUENTA_CONTABLE_codigo_consolidacion]  DEFAULT ((0)) FOR [codigo_consolidacion]
GO
