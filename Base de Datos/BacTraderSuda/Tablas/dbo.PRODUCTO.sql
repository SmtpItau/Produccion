USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[PRODUCTO]    Script Date: 13-05-2022 12:16:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO](
	[codigo_producto] [char](5) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[id_sistema] [char](3) NOT NULL
) ON [PRIMARY]
GO
