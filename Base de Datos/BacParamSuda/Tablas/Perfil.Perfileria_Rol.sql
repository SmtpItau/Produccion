USE [BacParamSuda]
GO
/****** Object:  Table [Perfil].[Perfileria_Rol]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Perfil].[Perfileria_Rol](
	[ID_Rol] [int] IDENTITY(1,1) NOT NULL,
	[ID_Sistema] [int] NULL,
	[Nombre] [nvarchar](50) NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[Vigencia] [bit] NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[ID_Rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Perfil].[Perfileria_Rol] ADD  CONSTRAINT [DF__Perfileria__Guid__7EE1CA6C]  DEFAULT (newid()) FOR [Guid]
GO
ALTER TABLE [Perfil].[Perfileria_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Rol_Sistema] FOREIGN KEY([ID_Sistema])
REFERENCES [Perfil].[Perfileria_Sistema] ([ID_Sistema])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [Perfil].[Perfileria_Rol] CHECK CONSTRAINT [FK_Rol_Sistema]
GO
