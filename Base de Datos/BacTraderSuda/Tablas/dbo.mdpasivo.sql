USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[mdpasivo]    Script Date: 13-05-2022 12:16:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdpasivo](
	[cprutcart] [numeric](9, 0) NOT NULL,
	[cptipcart] [numeric](5, 0) NOT NULL,
	[cpnumdocu] [numeric](10, 0) NOT NULL,
	[cpcorrela] [numeric](3, 0) NOT NULL,
	[cpnumdocuo] [numeric](10, 0) NOT NULL,
	[cpcorrelao] [numeric](3, 0) NOT NULL,
	[cpinstser] [char](12) NOT NULL,
	[cpmascara] [char](12) NOT NULL,
	[cpnominal] [numeric](19, 4) NOT NULL,
	[cpnominal_R] [numeric](19, 4) NOT NULL,
	[cpfeccol] [datetime] NOT NULL,
	[cpvalcol] [numeric](19, 4) NOT NULL,
	[cpvalcomu] [float] NOT NULL,
	[cptircol] [numeric](9, 4) NOT NULL,
	[cptasest] [numeric](9, 4) NOT NULL,
	[cppvpcolc] [numeric](19, 4) NOT NULL,
	[cpvalemis] [numeric](19, 4) NOT NULL,
	[cpvalemimu] [float] NOT NULL,
	[cpnumucup] [numeric](3, 0) NOT NULL,
	[cpfecven] [datetime] NOT NULL,
	[cpseriado] [char](1) NOT NULL,
	[cpcodigo] [numeric](5, 0) NOT NULL,
	[cpinteres_emis] [numeric](19, 4) NOT NULL,
	[cpreajust_emis] [numeric](19, 4) NOT NULL,
	[cpinteres_col] [numeric](19, 4) NOT NULL,
	[cpreajust_col] [numeric](19, 4) NOT NULL,
	[cpcontador] [numeric](19, 0) NOT NULL,
	[cpfecucup] [datetime] NULL,
	[cpfecpcup] [datetime] NULL,
	[cpdurat] [float] NOT NULL,
	[cpdurmod] [float] NOT NULL,
	[cpconvex] [float] NOT NULL,
	[fecha_colocacion_original] [datetime] NOT NULL,
	[valor_colocacion_original] [numeric](19, 0) NOT NULL,
	[valor_colocacion_um_original] [float] NOT NULL,
	[tir_colocacion_original] [numeric](8, 4) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[cpmonemi] [char](3) NULL,
	[cpfecemi] [datetime] NULL,
	[cpvptircol] [numeric](19, 4) NULL,
	[cpvpemis] [numeric](19, 4) NULL,
 CONSTRAINT [PK__mdpasivo__5115A225] PRIMARY KEY CLUSTERED 
(
	[cprutcart] ASC,
	[cptipcart] ASC,
	[cpnumdocu] ASC,
	[cpcorrela] ASC,
	[cpnumdocuo] ASC,
	[cpcorrelao] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[mdpasivo] ADD  CONSTRAINT [DF_mdpasivo_cpfecucup]  DEFAULT ('') FOR [cpfecucup]
GO
ALTER TABLE [dbo].[mdpasivo] ADD  CONSTRAINT [DF_mdpasivo_cpfecpcup]  DEFAULT ('') FOR [cpfecpcup]
GO
ALTER TABLE [dbo].[mdpasivo] ADD  CONSTRAINT [DF_mdpasivo_cpmonemi]  DEFAULT ('') FOR [cpmonemi]
GO
ALTER TABLE [dbo].[mdpasivo] ADD  CONSTRAINT [DF_mdpasivo_cpfecemi]  DEFAULT ('') FOR [cpfecemi]
GO
ALTER TABLE [dbo].[mdpasivo] ADD  CONSTRAINT [DF_mdpasivo_cpvptircol]  DEFAULT (0) FOR [cpvptircol]
GO
ALTER TABLE [dbo].[mdpasivo] ADD  CONSTRAINT [DF_mdpasivo_cpvpemis]  DEFAULT (0) FOR [cpvpemis]
GO
