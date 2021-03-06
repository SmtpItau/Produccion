USE [Reportes]
GO
/****** Object:  Table [dbo].[Perfileria_Usuario]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfileria_Usuario](
	[ID_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Apellido] [nvarchar](50) NULL,
	[UserPassword] [nvarchar](50) NULL,
	[Correo] [nvarchar](50) NULL,
	[Telefono] [nvarchar](50) NULL,
	[UserName] [nvarchar](50) NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Perfileria_Usuario] ADD  DEFAULT (newid()) FOR [Guid]
GO
