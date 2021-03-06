USE [MDPasivo]
GO
/****** Object:  Table [dbo].[INTERFAZ]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[INTERFAZ](
	[codigo_cartera] [numeric](10, 0) NOT NULL,
	[rut_entidad] [numeric](9, 0) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_Interfaz] [char](30) NOT NULL,
	[nombre] [varchar](20) NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[ruta_acceso] [varchar](100) NOT NULL,
	[tipo_interfaz] [char](1) NOT NULL,
	[Diaria] [numeric](1, 0) NOT NULL,
	[Dias] [char](40) NOT NULL,
	[Mensual] [numeric](2, 0) NOT NULL,
	[Casilla] [char](30) NOT NULL,
	[Nemotecnico] [numeric](1, 0) NOT NULL,
	[Path_Inicio] [char](100) NOT NULL,
	[Archivo_Inicio] [char](20) NOT NULL,
	[Fijo_Inicio] [char](15) NOT NULL,
	[Fecha_Inicio] [char](15) NOT NULL,
	[Extencion_Inicio] [char](15) NOT NULL,
	[Path_Final] [char](100) NOT NULL,
	[Archivo_Final] [char](20) NOT NULL,
	[Fijo_Final] [char](15) NOT NULL,
	[Fecha_Final] [char](15) NOT NULL,
	[Extencion_Final] [char](15) NOT NULL
) ON [PRIMARY]
GO
