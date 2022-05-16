USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[view_ejecutivo]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[view_ejecutivo](
	[Codigo] [int] NOT NULL,
	[Nombre] [char](30) NULL,
	[Sucursal] [int] NULL,
	[Monto_Linea] [numeric](18, 0) NULL
) ON [PRIMARY]
GO
