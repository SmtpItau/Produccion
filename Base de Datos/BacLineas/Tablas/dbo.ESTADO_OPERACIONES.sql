USE [BacLineas]
GO
/****** Object:  Table [dbo].[ESTADO_OPERACIONES]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ESTADO_OPERACIONES](
	[codigo] [int] NULL,
	[identificador] [char](1) NULL,
	[estado] [char](15) NULL
) ON [PRIMARY]
GO
