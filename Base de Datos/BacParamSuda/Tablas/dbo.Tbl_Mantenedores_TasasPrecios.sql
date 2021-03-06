USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Tbl_Mantenedores_TasasPrecios]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tbl_Mantenedores_TasasPrecios](
	[codSistema] [char](3) NOT NULL,
	[codProducto] [varchar](5) NOT NULL,
	[codMonFam] [varchar](5) NULL,
	[tipoMonFam] [char](1) NULL,
	[RangoDesde] [numeric](19, 4) NULL,
	[RangoHasta] [numeric](19, 4) NULL,
	[PlazoDesde] [int] NULL,
	[PlazoHasta] [int] NULL,
	[codCurva] [varchar](20) NULL,
	[Volatilidad] [numeric](19, 4) NULL
) ON [PRIMARY]
GO
