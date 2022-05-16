USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[metb02]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[metb02](
	[CODIGO] [float] NULL,
	[GLOSA] [nvarchar](45) NULL,
	[TIPOPE] [nvarchar](1) NULL,
	[CANT_C] [float] NULL,
	[MONTO_C] [float] NULL,
	[CANT_V] [float] NULL,
	[MONTO_V] [float] NULL,
	[ORDEN] [float] NULL,
	[GLOSITA] [nvarchar](13) NULL,
	[TIPO] [float] NULL
) ON [PRIMARY]
GO
