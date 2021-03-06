USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MD_PFE_CCE]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MD_PFE_CCE](
	[rut] [numeric](9, 0) NOT NULL,
	[codigo] [numeric](9, 0) NOT NULL,
	[tipo_limite] [char](3) NOT NULL,
	[plazo_Ini] [int] NULL,
	[plazo_Fin] [int] NULL,
	[productos] [char](3) NULL,
	[monto_asignado] [float] NULL,
	[monto_ocupado] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MD_PFE_CCE] ADD  CONSTRAINT [DF__md_pfe_cc__tipo___7A93AD49]  DEFAULT (' ') FOR [tipo_limite]
GO
ALTER TABLE [dbo].[MD_PFE_CCE] ADD  CONSTRAINT [DF__md_pfe_cc__plazo__7B87D182]  DEFAULT (0) FOR [plazo_Ini]
GO
ALTER TABLE [dbo].[MD_PFE_CCE] ADD  CONSTRAINT [DF__md_pfe_cc__plazo__7C7BF5BB]  DEFAULT (0) FOR [plazo_Fin]
GO
ALTER TABLE [dbo].[MD_PFE_CCE] ADD  CONSTRAINT [DF__md_pfe_cc__produ__7D7019F4]  DEFAULT (' ') FOR [productos]
GO
ALTER TABLE [dbo].[MD_PFE_CCE] ADD  CONSTRAINT [DF__md_pfe_cc__monto__7E643E2D]  DEFAULT (0) FOR [monto_asignado]
GO
ALTER TABLE [dbo].[MD_PFE_CCE] ADD  CONSTRAINT [DF__md_pfe_cc__monto__7F586266]  DEFAULT (0) FOR [monto_ocupado]
GO
