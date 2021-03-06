USE [BacParamSuda]
GO
/****** Object:  Table [Perfil].[Perfileria_Privilegio]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Perfil].[Perfileria_Privilegio](
	[ID_Privilegio] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Perfil].[Perfileria_Privilegio]  WITH CHECK ADD  CONSTRAINT [FK_Privilegio_Rol] FOREIGN KEY([ID_Rol])
REFERENCES [Perfil].[Perfileria_Rol] ([ID_Rol])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Perfil].[Perfileria_Privilegio] CHECK CONSTRAINT [FK_Privilegio_Rol]
GO
