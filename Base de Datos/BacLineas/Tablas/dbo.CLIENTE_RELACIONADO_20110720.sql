USE [BacLineas]
GO
/****** Object:  Table [dbo].[CLIENTE_RELACIONADO_20110720]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE_RELACIONADO_20110720](
	[clrut_padre] [numeric](9, 0) NOT NULL,
	[clcodigo_padre] [numeric](5, 0) NOT NULL,
	[clrut_hijo] [numeric](9, 0) NOT NULL,
	[clcodigo_hijo] [numeric](5, 0) NOT NULL,
	[clporcentaje] [float] NULL,
	[Afecta_Lineas_Hijo] [int] NOT NULL
) ON [PRIMARY]
GO
