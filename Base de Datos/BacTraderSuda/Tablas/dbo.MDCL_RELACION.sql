USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDCL_RELACION]    Script Date: 13-05-2022 12:16:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDCL_RELACION](
	[clrut_padre] [numeric](9, 0) NOT NULL,
	[clcodigo_padre] [numeric](5, 0) NOT NULL,
	[clrut_hijo] [numeric](9, 0) NOT NULL,
	[clcodigo_hijo] [numeric](5, 0) NOT NULL,
	[clporcentaje] [float] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDCL_RELACION] ADD  CONSTRAINT [DF__MDCL_RELA__CLRUT__4F74451A]  DEFAULT (0) FOR [clrut_padre]
GO
ALTER TABLE [dbo].[MDCL_RELACION] ADD  CONSTRAINT [DF__MDCL_RELA__CLCOD__50686953]  DEFAULT (0) FOR [clcodigo_padre]
GO
ALTER TABLE [dbo].[MDCL_RELACION] ADD  CONSTRAINT [DF__MDCL_RELA__CLRUT__515C8D8C]  DEFAULT (0) FOR [clrut_hijo]
GO
ALTER TABLE [dbo].[MDCL_RELACION] ADD  CONSTRAINT [DF__MDCL_RELA__CLCOD__5250B1C5]  DEFAULT (0) FOR [clcodigo_hijo]
GO
ALTER TABLE [dbo].[MDCL_RELACION] ADD  CONSTRAINT [DF__MDCL_RELA__CLPOR__5344D5FE]  DEFAULT (0) FOR [clporcentaje]
GO
