USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CLIENTE_RELACIONADO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CLIENTE_RELACIONADO](
	[clrut_padre] [numeric](9, 0) NOT NULL,
	[clcodigo_padre] [numeric](9, 0) NOT NULL,
	[clrut_hijo] [numeric](9, 0) NOT NULL,
	[clcodigo_hijo] [numeric](5, 0) NOT NULL,
	[clporcentaje] [float] NULL
) ON [PRIMARY]
GO
