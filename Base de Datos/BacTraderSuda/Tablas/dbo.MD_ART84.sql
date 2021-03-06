USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MD_ART84]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_ART84](
	[rut] [numeric](9, 0) NOT NULL,
	[codigo] [numeric](9, 0) NOT NULL,
	[patrimonio] [float] NOT NULL,
	[porcentaje] [float] NOT NULL,
	[monto_ocupado] [float] NOT NULL,
	[usa_garantias] [char](1) NOT NULL,
	[garantias] [float] NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MD_ART84] ADD  CONSTRAINT [DF__md_art84__rut__513C91FB]  DEFAULT (0) FOR [rut]
GO
ALTER TABLE [dbo].[MD_ART84] ADD  CONSTRAINT [DF__md_art84__codigo__5230B634]  DEFAULT (0) FOR [codigo]
GO
ALTER TABLE [dbo].[MD_ART84] ADD  CONSTRAINT [DF__md_art84__patrim__5324DA6D]  DEFAULT (0) FOR [patrimonio]
GO
ALTER TABLE [dbo].[MD_ART84] ADD  CONSTRAINT [DF__md_art84__porcen__5418FEA6]  DEFAULT (0) FOR [porcentaje]
GO
ALTER TABLE [dbo].[MD_ART84] ADD  CONSTRAINT [DF__md_art84__monto___550D22DF]  DEFAULT (0) FOR [monto_ocupado]
GO
ALTER TABLE [dbo].[MD_ART84] ADD  CONSTRAINT [DF__md_art84__usa_ga__56014718]  DEFAULT ('N') FOR [usa_garantias]
GO
ALTER TABLE [dbo].[MD_ART84] ADD  CONSTRAINT [DF__md_art84__garant__56F56B51]  DEFAULT (0) FOR [garantias]
GO
