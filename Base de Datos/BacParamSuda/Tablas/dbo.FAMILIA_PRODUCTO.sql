USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FAMILIA_PRODUCTO]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FAMILIA_PRODUCTO](
	[sistema] [char](3) NOT NULL,
	[codigo_bac] [char](4) NOT NULL,
	[codigo_bco] [char](4) NOT NULL,
	[descripcion] [char](30) NOT NULL
) ON [PRIMARY]
GO
