USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CLIENTE_CLASIFICACION]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE_CLASIFICACION](
	[codigo_clasificacion] [varchar](5) NOT NULL,
	[descripcion] [varchar](40) NOT NULL
) ON [PRIMARY]
GO
