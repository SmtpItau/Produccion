USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[papeleta_Fli]    Script Date: 13-05-2022 12:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[papeleta_Fli](
	[Fecha_Operacion] [datetime] NOT NULL,
	[Numero_Operacion] [numeric](10, 0) NOT NULL,
	[Pago] [tinyint] NOT NULL,
	[Instrumento] [varchar](12) NOT NULL,
	[Nominal] [numeric](21, 4) NOT NULL,
	[Tir] [numeric](21, 4) NOT NULL,
	[Valor_Referencial] [numeric](21, 0) NOT NULL,
	[Margen] [numeric](21, 4) NOT NULL,
	[Valor_Inicial] [numeric](21, 0) NOT NULL,
	[CarteraSuper] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[papeleta_Fli] ADD  CONSTRAINT [DF__papeleta___Fecha__07F4031F]  DEFAULT ('') FOR [Fecha_Operacion]
GO
ALTER TABLE [dbo].[papeleta_Fli] ADD  CONSTRAINT [DF__papeleta___Numer__08E82758]  DEFAULT (0) FOR [Numero_Operacion]
GO
ALTER TABLE [dbo].[papeleta_Fli] ADD  CONSTRAINT [DF__papeleta_F__Pago__09DC4B91]  DEFAULT (0) FOR [Pago]
GO
ALTER TABLE [dbo].[papeleta_Fli] ADD  CONSTRAINT [DF__papeleta___Instr__0AD06FCA]  DEFAULT ('') FOR [Instrumento]
GO
ALTER TABLE [dbo].[papeleta_Fli] ADD  CONSTRAINT [DF__papeleta___Nomin__0BC49403]  DEFAULT (0) FOR [Nominal]
GO
ALTER TABLE [dbo].[papeleta_Fli] ADD  CONSTRAINT [DF__papeleta_Fl__Tir__0CB8B83C]  DEFAULT (0) FOR [Tir]
GO
ALTER TABLE [dbo].[papeleta_Fli] ADD  CONSTRAINT [DF__papeleta___Valor__0DACDC75]  DEFAULT (0) FOR [Valor_Referencial]
GO
ALTER TABLE [dbo].[papeleta_Fli] ADD  CONSTRAINT [DF__papeleta___Marge__0EA100AE]  DEFAULT (0) FOR [Margen]
GO
ALTER TABLE [dbo].[papeleta_Fli] ADD  CONSTRAINT [DF__papeleta___Valor__0F9524E7]  DEFAULT (0) FOR [Valor_Inicial]
GO
ALTER TABLE [dbo].[papeleta_Fli] ADD  DEFAULT ('') FOR [CarteraSuper]
GO
