USE [Reportes]
GO
/****** Object:  Table [dbo].[Mocartera]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mocartera](
	[IdCmov] [int] NOT NULL,
	[NombreCmov] [varchar](20) NOT NULL,
 CONSTRAINT [PkCmov] PRIMARY KEY NONCLUSTERED 
(
	[IdCmov] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
