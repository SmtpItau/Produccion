USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PivotalProductoHabilitado]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PivotalProductoHabilitado](
	[RutCliente] [int] NOT NULL,
	[Producto] [nvarchar](50) NOT NULL,
	[Habilitado] [nvarchar](5) NOT NULL
) ON [PRIMARY]
GO
