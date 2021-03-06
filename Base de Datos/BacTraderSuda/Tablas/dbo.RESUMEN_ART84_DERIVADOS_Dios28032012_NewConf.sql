USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[RESUMEN_ART84_DERIVADOS_Dios28032012_NewConf]    Script Date: 13-05-2022 12:16:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RESUMEN_ART84_DERIVADOS_Dios28032012_NewConf](
	[Fecha_Proc] [datetime] NOT NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Categoria_Cliente] [numeric](5, 0) NOT NULL,
	[Modulo] [char](10) NOT NULL,
	[Tot_Gen_Equiv_Credito] [float] NOT NULL,
	[Tot_Gen_Categ3] [float] NOT NULL,
	[Tot_Gen_Categ5] [float] NOT NULL
) ON [PRIMARY]
GO
