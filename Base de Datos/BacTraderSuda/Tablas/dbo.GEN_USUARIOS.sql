USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[GEN_USUARIOS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GEN_USUARIOS](
	[usuario] [char](10) NULL,
	[clave] [char](15) NULL,
	[nombre] [char](40) NULL,
	[tipo_usuario] [char](15) NULL,
	[fecha_expira] [datetime] NULL,
	[cambio_clave] [char](1) NULL,
	[bloqueado] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GEN_USUARIOS] ADD  CONSTRAINT [DF__GEN_USUAR__Bloqu__389A360C]  DEFAULT ('0') FOR [bloqueado]
GO
