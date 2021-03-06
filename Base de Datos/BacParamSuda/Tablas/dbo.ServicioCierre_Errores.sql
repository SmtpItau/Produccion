USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ServicioCierre_Errores]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServicioCierre_Errores](
	[Fecha] [datetime] NOT NULL,
	[Modulo] [char](3) NOT NULL,
	[IdTarea] [int] NOT NULL,
	[Descripcion] [varchar](255) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ServicioCierre_Errores] ADD  CONSTRAINT [df_ServicioCierre_Errores_Fecha]  DEFAULT ('') FOR [Fecha]
GO
ALTER TABLE [dbo].[ServicioCierre_Errores] ADD  CONSTRAINT [df_ServicioCierre_Errores_Modulo]  DEFAULT ('') FOR [Modulo]
GO
ALTER TABLE [dbo].[ServicioCierre_Errores] ADD  CONSTRAINT [df_ServicioCierre_Errores_IdTarea]  DEFAULT ((0)) FOR [IdTarea]
GO
ALTER TABLE [dbo].[ServicioCierre_Errores] ADD  CONSTRAINT [df_ServicioCierre_Errores_Descripcion]  DEFAULT ('') FOR [Descripcion]
GO
