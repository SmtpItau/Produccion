USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LINEA_TRANSACCION]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_TRANSACCION](
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[NumeroDocumento] [numeric](10, 0) NOT NULL,
	[NumeroCorrelativo] [numeric](10, 0) NOT NULL,
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Tipo_Operacion] [varchar](2) NOT NULL,
	[Tipo_Riesgo] [varchar](1) NOT NULL,
	[FechaInicio] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[MontoOriginal] [numeric](19, 4) NOT NULL,
	[TipoCambio] [numeric](8, 4) NOT NULL,
	[MatrizRiesgo] [numeric](8, 4) NOT NULL,
	[MontoTransaccion] [numeric](19, 4) NOT NULL,
	[Operador] [char](15) NOT NULL,
	[Activo] [char](1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NumeroOperacion] ASC,
	[NumeroDocumento] ASC,
	[NumeroCorrelativo] ASC,
	[Rut_Cliente] ASC,
	[Codigo_Cliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION] ADD  CONSTRAINT [DF__LINEA_TRA__Tipo___3B63F623]  DEFAULT ('') FOR [Tipo_Operacion]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION] ADD  CONSTRAINT [DF__LINEA_TRA__Tipo___3C581A5C]  DEFAULT ('') FOR [Tipo_Riesgo]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION] ADD  CONSTRAINT [DF__LINEA_TRA__Fecha__3D4C3E95]  DEFAULT ('') FOR [FechaInicio]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION] ADD  CONSTRAINT [DF__LINEA_TRA__Fecha__3E4062CE]  DEFAULT ('') FOR [FechaVencimiento]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION] ADD  CONSTRAINT [DF__LINEA_TRA__Monto__3F348707]  DEFAULT (0) FOR [MontoOriginal]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION] ADD  CONSTRAINT [DF__LINEA_TRA__TipoC__4028AB40]  DEFAULT (0) FOR [TipoCambio]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION] ADD  CONSTRAINT [DF__LINEA_TRA__Matri__411CCF79]  DEFAULT (0) FOR [MatrizRiesgo]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION] ADD  CONSTRAINT [DF__LINEA_TRA__Monto__4210F3B2]  DEFAULT (0) FOR [MontoTransaccion]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION] ADD  CONSTRAINT [DF__LINEA_TRA__Activ__430517EB]  DEFAULT ('') FOR [Activo]
GO
ALTER TABLE [dbo].[LINEA_TRANSACCION]  WITH CHECK ADD FOREIGN KEY([Rut_Cliente], [Codigo_Cliente], [Id_Sistema])
REFERENCES [dbo].[LINEA_SISTEMA] ([Rut_Cliente], [Codigo_Cliente], [Id_Sistema])
GO
