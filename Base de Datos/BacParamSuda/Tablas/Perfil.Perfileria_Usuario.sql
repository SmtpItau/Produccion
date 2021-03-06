USE [BacParamSuda]
GO
/****** Object:  Table [Perfil].[Perfileria_Usuario]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Perfil].[Perfileria_Usuario](
	[ID_Usuario] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [nvarchar](50) NULL,
	[Guid] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Usuario] PRIMARY KEY CLUSTERED 
(
	[ID_Usuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Perfil].[Perfileria_Usuario] ADD  CONSTRAINT [DF_Perfileria_Usuario_Guid]  DEFAULT (newid()) FOR [Guid]
GO
