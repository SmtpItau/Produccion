USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[SWIFT_MENSAJE]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SWIFT_MENSAJE](
	[codigo_mensaje_swift] [varchar](6) NOT NULL,
	[campo_nombre] [varchar](5) NOT NULL,
	[campo_descripcion] [varchar](50) NOT NULL,
	[campo_opcion] [char](1) NOT NULL,
	[campo_tipo] [char](1) NOT NULL,
	[campo_activo] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_mensaje_swift] ASC,
	[campo_nombre] ASC,
	[campo_opcion] ASC,
	[campo_tipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SWIFT_MENSAJE] ADD  CONSTRAINT [DF__SWIFT_MEN__campo__5B50D771]  DEFAULT (' ') FOR [campo_descripcion]
GO
ALTER TABLE [dbo].[SWIFT_MENSAJE] ADD  CONSTRAINT [DF__SWIFT_MEN__campo__5C44FBAA]  DEFAULT ('F') FOR [campo_opcion]
GO
ALTER TABLE [dbo].[SWIFT_MENSAJE] ADD  CONSTRAINT [DF__SWIFT_MEN__campo__5D391FE3]  DEFAULT ('A') FOR [campo_tipo]
GO
ALTER TABLE [dbo].[SWIFT_MENSAJE] ADD  CONSTRAINT [DF__SWIFT_MEN__campo__5E2D441C]  DEFAULT ('N') FOR [campo_activo]
GO
