USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDCONCL]    Script Date: 13-05-2022 12:16:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDCONCL](
	[CL_RUT] [float] NULL,
	[CL_NOMBRE] [nvarchar](30) NULL,
	[CL_LINEA] [float] NULL,
	[CL_TRADER] [float] NULL,
	[CL_CAMBIO] [float] NULL,
	[CL_FUTURO] [float] NULL,
	[CL_TOTAL] [float] NULL,
	[CL_TIPO] [float] NULL,
	[CL_CODIFCL] [float] NULL,
	[DISPONIBLE] [float] NULL,
	[CL_TIPVENC] [float] NULL,
	[CL_FECVENC] [smalldatetime] NULL
) ON [PRIMARY]
GO
