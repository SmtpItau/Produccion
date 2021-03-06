USE [Reportes]
GO
/****** Object:  Table [dbo].[Perfileria_Privilegio]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfileria_Privilegio](
	[ID_Privilegio] [int] IDENTITY(1,1) NOT NULL,
	[ID_Usuario] [int] NULL,
	[ID_Rol] [int] NULL,
	[ID_Fechakey] [int] NULL,
	[isCreate] [bit] NULL,
	[isRead] [bit] NULL,
	[isUpdate] [bit] NULL,
	[isDelete] [bit] NULL,
	[isConfirm] [bit] NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Privilegio] PRIMARY KEY CLUSTERED 
(
	[ID_Privilegio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Perfileria_Privilegio]  WITH CHECK ADD  CONSTRAINT [FK_Privilegio_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [dbo].[Perfileria_Rol] ([ID_Rol])
GO
ALTER TABLE [dbo].[Perfileria_Privilegio] CHECK CONSTRAINT [FK_Privilegio_Rol]
GO
ALTER TABLE [dbo].[Perfileria_Privilegio]  WITH CHECK ADD  CONSTRAINT [FK_Privilegio_Usuario] FOREIGN KEY([ID_Usuario])
REFERENCES [dbo].[Perfileria_Usuario] ([ID_Usuario])
GO
ALTER TABLE [dbo].[Perfileria_Privilegio] CHECK CONSTRAINT [FK_Privilegio_Usuario]
GO
