USE [BacParamSuda]
GO
/****** Object:  Table [Perfil].[Perfileria_Sistema]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Perfil].[Perfileria_Sistema](
	[ID_Sistema] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Codigo] [nvarchar](50) NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[TimeStamp] [timestamp] NULL,
	[Vigencia] [bit] NULL,
 CONSTRAINT [PK_Sistema] PRIMARY KEY CLUSTERED 
(
	[ID_Sistema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [Perfil].[Perfileria_Sistema] ADD  CONSTRAINT [DF__Perfileria__Guid__7FD5EEA5]  DEFAULT (newid()) FOR [Guid]
GO
