USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CURVA_BASE]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CURVA_BASE](
	[codigo_curva] [decimal](3, 0) NOT NULL,
	[nombre_curva] [char](50) NOT NULL
) ON [PRIMARY]
GO
