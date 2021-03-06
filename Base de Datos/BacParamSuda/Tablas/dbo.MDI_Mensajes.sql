USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MDI_Mensajes]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDI_Mensajes](
	[Fecha] [datetime] NOT NULL,
	[Hora] [char](8) NOT NULL,
	[IdModulo] [int] NOT NULL,
	[IdEvento] [int] NOT NULL,
	[IdEstado] [int] NOT NULL,
	[Mensaje] [varchar](50) NOT NULL,
 CONSTRAINT [Pk_MDI_Mensajes_IdProducto_IdEvento] PRIMARY KEY CLUSTERED 
(
	[Fecha] ASC,
	[IdModulo] ASC,
	[IdEvento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MDI_Mensajes] ADD  CONSTRAINT [df_MDI_Mensajes_Hora]  DEFAULT ('') FOR [Hora]
GO
ALTER TABLE [dbo].[MDI_Mensajes] ADD  CONSTRAINT [df_MDI_Mensajes_IdModulo]  DEFAULT ((-1)) FOR [IdModulo]
GO
ALTER TABLE [dbo].[MDI_Mensajes] ADD  CONSTRAINT [df_MDI_Mensajes_IdEvento]  DEFAULT ((-1)) FOR [IdEvento]
GO
ALTER TABLE [dbo].[MDI_Mensajes] ADD  CONSTRAINT [df_MDI_Mensajes_IdEstado]  DEFAULT ((-1)) FOR [IdEstado]
GO
ALTER TABLE [dbo].[MDI_Mensajes] ADD  CONSTRAINT [df_MDI_Mensajes_Mensaje]  DEFAULT ('') FOR [Mensaje]
GO
