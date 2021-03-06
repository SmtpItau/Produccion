USE [MDPasivo]
GO
/****** Object:  Table [dbo].[LINEA_AUTORIZACION]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_AUTORIZACION](
	[codigo_excepcion] [char](2) NOT NULL,
	[FechaAutorizo] [datetime] NOT NULL,
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[NumeroDocumento] [numeric](10, 0) NOT NULL,
	[NumeroCorrelativo] [numeric](10, 0) NOT NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[NumeroTraspaso] [numeric](10, 0) NOT NULL,
	[codigo_grupo] [char](10) NOT NULL,
	[TipoOperacion] [varchar](2) NOT NULL,
	[Operador] [char](15) NOT NULL,
	[MontoAutorizo] [numeric](19, 4) NOT NULL,
	[UsuarioAutorizo] [char](15) NOT NULL,
	[Activo] [varchar](1) NOT NULL,
	[Hora_Autorizacion] [char](8) NOT NULL,
	[Codigo_Sistema] [char](3) NOT NULL
) ON [PRIMARY]
GO
