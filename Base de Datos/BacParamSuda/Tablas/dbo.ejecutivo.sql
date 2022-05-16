USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[ejecutivo]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ejecutivo](
	[codigo] [int] NOT NULL,
	[nombre] [char](30) NULL,
	[sucursal] [int] NULL,
	[Monto_linea] [numeric](18, 0) NULL
) ON [PRIMARY]
GO
