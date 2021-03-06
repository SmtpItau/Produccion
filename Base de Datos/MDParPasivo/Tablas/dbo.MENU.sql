USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[MENU]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MENU](
	[entidad] [char](3) NOT NULL,
	[indice] [numeric](3, 0) NOT NULL,
	[nombre_opcion] [char](50) NOT NULL,
	[nombre_objeto] [char](30) NOT NULL,
	[posicion] [numeric](3, 0) NOT NULL,
	[entidadfox] [char](3) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MENU] ADD  CONSTRAINT [DF_MENU_entidad]  DEFAULT ('') FOR [entidad]
GO
ALTER TABLE [dbo].[MENU] ADD  CONSTRAINT [DF_MENU_indice]  DEFAULT ((0)) FOR [indice]
GO
ALTER TABLE [dbo].[MENU] ADD  CONSTRAINT [DF_MENU_nombre_opcion]  DEFAULT ('') FOR [nombre_opcion]
GO
ALTER TABLE [dbo].[MENU] ADD  CONSTRAINT [DF_MENU_nombre_objeto]  DEFAULT ('') FOR [nombre_objeto]
GO
ALTER TABLE [dbo].[MENU] ADD  CONSTRAINT [DF_MENU_posicion]  DEFAULT ((0)) FOR [posicion]
GO
ALTER TABLE [dbo].[MENU] ADD  CONSTRAINT [DF_MENU_entidadfox]  DEFAULT ('') FOR [entidadfox]
GO
