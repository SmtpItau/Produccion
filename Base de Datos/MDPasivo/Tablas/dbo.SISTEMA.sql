USE [MDPasivo]
GO
/****** Object:  Table [dbo].[SISTEMA]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SISTEMA](
	[id_sistema] [char](3) NOT NULL,
	[nombre_sistema] [char](30) NOT NULL,
	[operativo] [char](1) NOT NULL,
	[gestion] [char](1) NOT NULL,
	[activo] [char](1) NOT NULL,
	[Orden] [numeric](3, 0) NOT NULL,
	[nombre_base_datos] [char](20) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[SISTEMA] ADD  CONSTRAINT [DF_SISTEMA_id_sistema]  DEFAULT ('') FOR [id_sistema]
GO
ALTER TABLE [dbo].[SISTEMA] ADD  CONSTRAINT [DF_SISTEMA_nombre_sistema]  DEFAULT ('') FOR [nombre_sistema]
GO
ALTER TABLE [dbo].[SISTEMA] ADD  CONSTRAINT [DF_SISTEMA_operativo]  DEFAULT ('') FOR [operativo]
GO
ALTER TABLE [dbo].[SISTEMA] ADD  CONSTRAINT [DF_SISTEMA_gestion]  DEFAULT ('') FOR [gestion]
GO
ALTER TABLE [dbo].[SISTEMA] ADD  CONSTRAINT [DF_SISTEMA_activo]  DEFAULT ('') FOR [activo]
GO
ALTER TABLE [dbo].[SISTEMA] ADD  CONSTRAINT [DF_SISTEMA_Orden]  DEFAULT ((0)) FOR [Orden]
GO
ALTER TABLE [dbo].[SISTEMA] ADD  CONSTRAINT [DF_SISTEMA_nombre_base_datos]  DEFAULT ('') FOR [nombre_base_datos]
GO
