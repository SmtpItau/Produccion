USE [BacLineas]
GO
/****** Object:  Table [bacuser].[tmp_paso_tbl_modificaciones]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[tmp_paso_tbl_modificaciones](
	[FechaModificacion] [datetime] NOT NULL,
	[Modulo] [char](3) NOT NULL,
	[FolioContrato] [numeric](10, 0) NOT NULL,
	[FolioCotizacion] [numeric](10, 0) NOT NULL,
	[FolioModificacion] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](9, 0) NOT NULL,
	[Items] [varchar](20) NOT NULL,
	[DatosOriginales] [varchar](155) NOT NULL,
	[DatosNuevos] [varchar](155) NOT NULL
) ON [PRIMARY]
GO
