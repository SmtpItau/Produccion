USE [BacLineas]
GO
/****** Object:  Table [dbo].[LINEA_AUTORIZACION]    Script Date: 13-05-2022 10:44:28 ******/
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
	[id_sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[TipoOperacion] [varchar](2) NOT NULL,
	[Operador] [char](15) NOT NULL,
	[MontoAutorizo] [numeric](19, 4) NOT NULL,
	[UsuarioAutorizo] [char](15) NOT NULL,
	[Activo] [varchar](1) NOT NULL,
	[Hora_Autorizacion] [char](8) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_AUTORIZACION] ADD  CONSTRAINT [DF__LINEA_AUT__Rut_C__1AC47E6C]  DEFAULT (0) FOR [Rut_Cliente]
GO
ALTER TABLE [dbo].[LINEA_AUTORIZACION] ADD  CONSTRAINT [DF__LINEA_AUT__Codig__1BB8A2A5]  DEFAULT (0) FOR [Codigo_Cliente]
GO
ALTER TABLE [dbo].[LINEA_AUTORIZACION] ADD  CONSTRAINT [DF__LINEA_AUT__Numer__1CACC6DE]  DEFAULT (0) FOR [NumeroTraspaso]
GO
ALTER TABLE [dbo].[LINEA_AUTORIZACION] ADD  CONSTRAINT [DF__LINEA_AUT__TipoO__1F893389]  DEFAULT ('') FOR [TipoOperacion]
GO
ALTER TABLE [dbo].[LINEA_AUTORIZACION] ADD  CONSTRAINT [DF__LINEA_AUT__Opera__207D57C2]  DEFAULT ('') FOR [Operador]
GO
ALTER TABLE [dbo].[LINEA_AUTORIZACION] ADD  CONSTRAINT [DF__LINEA_AUT__Monto__21717BFB]  DEFAULT (0) FOR [MontoAutorizo]
GO
ALTER TABLE [dbo].[LINEA_AUTORIZACION] ADD  CONSTRAINT [DF__LINEA_AUT__Usuar__2265A034]  DEFAULT ('') FOR [UsuarioAutorizo]
GO
ALTER TABLE [dbo].[LINEA_AUTORIZACION] ADD  CONSTRAINT [DF__LINEA_AUT__Activ__2359C46D]  DEFAULT ('') FOR [Activo]
GO
ALTER TABLE [dbo].[LINEA_AUTORIZACION] ADD  CONSTRAINT [DF__LINEA_AUT__Hora___244DE8A6]  DEFAULT ('') FOR [Hora_Autorizacion]
GO
