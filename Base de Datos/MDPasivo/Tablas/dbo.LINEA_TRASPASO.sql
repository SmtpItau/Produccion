USE [MDPasivo]
GO
/****** Object:  Table [dbo].[LINEA_TRASPASO]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_TRASPASO](
	[NumeroTraspaso] [numeric](10, 0) NOT NULL,
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[NumeroDocumento] [numeric](10, 0) NOT NULL,
	[NumeroCorrelativo] [numeric](10, 0) NOT NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[codigo_grupo] [char](10) NOT NULL,
	[GrupoRecibio] [char](10) NOT NULL,
	[TipoOperacion] [varchar](2) NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[Operador] [char](15) NOT NULL,
	[MontoTraspasado] [numeric](19, 4) NOT NULL,
	[UsuarioAutorizo] [char](15) NOT NULL,
	[Activo] [varchar](1) NOT NULL,
	[Hora_Traspaso] [char](8) NOT NULL,
	[tipo_riesgo] [char](1) NOT NULL
) ON [PRIMARY]
GO
