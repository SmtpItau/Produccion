USE [Reportes]
GO
/****** Object:  Table [dbo].[Instrumento]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Instrumento](
	[IdInstrumento] [int] NOT NULL,
	[NombreInstrumento] [varchar](20) NULL,
	[SISTEMA] [varchar](4) NOT NULL,
 CONSTRAINT [PK_Instrumento] PRIMARY KEY NONCLUSTERED 
(
	[IdInstrumento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
