USE [Reportes]
GO
/****** Object:  Table [dbo].[CuadraturaContable_Reportes]    Script Date: 16-05-2022 10:19:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuadraturaContable_Reportes](
	[idReporte] [int] IDENTITY(1,1) NOT NULL,
	[nomReporte] [varchar](20) NULL,
 CONSTRAINT [PK_CuadraturaContable_Reportes] PRIMARY KEY CLUSTERED 
(
	[idReporte] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [Reportes_Data_01]
) ON [Reportes_Data_01]
GO
