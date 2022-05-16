USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Fpago_canal_compensa]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fpago_canal_compensa](
	[Codigo_FormaPago] [decimal](9, 0) NOT NULL,
	[Codigo_Canal] [decimal](9, 0) NOT NULL,
	[Descripcion] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
