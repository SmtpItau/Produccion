USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[OPERACION_PRODUCTO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OPERACION_PRODUCTO](
	[id_sistema] [varchar](5) NULL,
	[descripcion] [varchar](255) NULL,
	[codigo] [varchar](20) NULL
) ON [PRIMARY]
GO
