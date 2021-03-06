USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_AGENTES]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_AGENTES](
	[codigo_agente] [char](5) NOT NULL,
	[nombre] [char](40) NOT NULL,
	[sucursal] [numeric](4, 0) NOT NULL,
	[tipo_banca] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GEN_AGENTES] ADD  CONSTRAINT [DF__GEN_AGENT__Nombr__4FBCC72F]  DEFAULT (' ') FOR [nombre]
GO
ALTER TABLE [dbo].[GEN_AGENTES] ADD  CONSTRAINT [DF__GEN_AGENT__Sucur__50B0EB68]  DEFAULT (0) FOR [sucursal]
GO
ALTER TABLE [dbo].[GEN_AGENTES] ADD  CONSTRAINT [DF__GEN_AGENT__Tipo___51A50FA1]  DEFAULT (' ') FOR [tipo_banca]
GO
