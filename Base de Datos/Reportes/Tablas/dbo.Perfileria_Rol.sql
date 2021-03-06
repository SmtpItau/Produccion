USE [Reportes]
GO
/****** Object:  Table [dbo].[Perfileria_Rol]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfileria_Rol](
	[ID_Rol] [int] IDENTITY(1,1) NOT NULL,
	[ID_Sistema] [int] NULL,
	[Nombre] [nvarchar](50) NULL,
	[Descripcion] [nvarchar](50) NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Rol] PRIMARY KEY CLUSTERED 
(
	[ID_Rol] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Perfileria_Rol] ADD  DEFAULT (newid()) FOR [Guid]
GO
ALTER TABLE [dbo].[Perfileria_Rol]  WITH CHECK ADD  CONSTRAINT [FK_Rol_Sistema] FOREIGN KEY([ID_Sistema])
REFERENCES [dbo].[Perfileria_Sistema] ([ID_Sistema])
GO
ALTER TABLE [dbo].[Perfileria_Rol] CHECK CONSTRAINT [FK_Rol_Sistema]
GO
