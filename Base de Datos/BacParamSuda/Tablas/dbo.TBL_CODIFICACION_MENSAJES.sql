USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[TBL_CODIFICACION_MENSAJES]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TBL_CODIFICACION_MENSAJES](
	[Codigo] [varchar](5) NOT NULL,
	[Mensaje] [varchar](255) NOT NULL,
 CONSTRAINT [Pk_TBL_CODIFICACION_MENSAJES] PRIMARY KEY CLUSTERED 
(
	[Codigo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[TBL_CODIFICACION_MENSAJES] ADD  CONSTRAINT [df_TBL_CODIFICACION_MENSAJES_Codigo]  DEFAULT ('') FOR [Codigo]
GO
ALTER TABLE [dbo].[TBL_CODIFICACION_MENSAJES] ADD  CONSTRAINT [df_TBL_CODIFICACION_MENSAJES_Mensaje]  DEFAULT ('') FOR [Mensaje]
GO
