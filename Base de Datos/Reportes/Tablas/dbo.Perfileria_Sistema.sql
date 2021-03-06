USE [Reportes]
GO
/****** Object:  Table [dbo].[Perfileria_Sistema]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfileria_Sistema](
	[ID_Sistema] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](50) NULL,
	[Codigo] [nvarchar](50) NULL,
	[Guid] [uniqueidentifier] NOT NULL,
	[TimeStamp] [timestamp] NULL,
 CONSTRAINT [PK_Sistema] PRIMARY KEY CLUSTERED 
(
	[ID_Sistema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Perfileria_Sistema] ADD  DEFAULT (newid()) FOR [Guid]
GO
