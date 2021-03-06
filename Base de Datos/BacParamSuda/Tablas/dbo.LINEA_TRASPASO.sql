USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LINEA_TRASPASO]    Script Date: 13-05-2022 10:58:10 ******/
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
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[SistemaRecibio] [char](3) NOT NULL,
	[TipoOperacion] [varchar](2) NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[Operador] [char](15) NOT NULL,
	[MontoTraspasado] [numeric](19, 4) NOT NULL,
	[UsuarioAutorizo] [char](15) NOT NULL,
	[Activo] [varchar](1) NOT NULL,
	[Hora_Traspaso] [char](8) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NumeroTraspaso] ASC,
	[NumeroOperacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_TRASPASO] ADD  CONSTRAINT [DF__LINEA_TRA__TipoO__46D5A8CF]  DEFAULT ('') FOR [TipoOperacion]
GO
ALTER TABLE [dbo].[LINEA_TRASPASO] ADD  CONSTRAINT [DF__LINEA_TRA__Fecha__47C9CD08]  DEFAULT ('') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[LINEA_TRASPASO] ADD  CONSTRAINT [DF__LINEA_TRA__Fecha__48BDF141]  DEFAULT ('') FOR [FechaVencimiento]
GO
ALTER TABLE [dbo].[LINEA_TRASPASO] ADD  CONSTRAINT [DF__LINEA_TRA__Opera__49B2157A]  DEFAULT ('') FOR [Operador]
GO
ALTER TABLE [dbo].[LINEA_TRASPASO] ADD  CONSTRAINT [DF__LINEA_TRA__Monto__4AA639B3]  DEFAULT (0) FOR [MontoTraspasado]
GO
ALTER TABLE [dbo].[LINEA_TRASPASO] ADD  CONSTRAINT [DF__LINEA_TRA__Usuar__4B9A5DEC]  DEFAULT ('') FOR [UsuarioAutorizo]
GO
ALTER TABLE [dbo].[LINEA_TRASPASO] ADD  CONSTRAINT [DF__LINEA_TRA__Activ__4C8E8225]  DEFAULT ('') FOR [Activo]
GO
ALTER TABLE [dbo].[LINEA_TRASPASO] ADD  CONSTRAINT [DF__LINEA_TRA__Hora___4D82A65E]  DEFAULT ('') FOR [Hora_Traspaso]
GO
ALTER TABLE [dbo].[LINEA_TRASPASO]  WITH CHECK ADD FOREIGN KEY([Id_Sistema])
REFERENCES [dbo].[SISTEMA_CNT] ([id_sistema])
GO
