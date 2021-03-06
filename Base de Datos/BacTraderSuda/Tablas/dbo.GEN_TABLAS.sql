USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_TABLAS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_TABLAS](
	[tipo_tabla] [char](4) NOT NULL,
	[codigo_tabla] [char](4) NOT NULL,
	[descripcion] [char](30) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GEN_TABLAS] ADD  CONSTRAINT [DF__GEN_TABLA__Codig__54817C4C]  DEFAULT (' ') FOR [codigo_tabla]
GO
ALTER TABLE [dbo].[GEN_TABLAS] ADD  CONSTRAINT [DF__GEN_TABLA__Descr__5575A085]  DEFAULT (' ') FOR [descripcion]
GO
