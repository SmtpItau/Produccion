USE [BacLineas]
GO
/****** Object:  Table [dbo].[LINEA_TASA]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_TASA](
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[codigo] [numeric](3, 0) NOT NULL,
	[mncodmon] [numeric](5, 0) NOT NULL,
	[Plazo_Desde] [numeric](5, 0) NOT NULL,
	[Plazo_Hasta] [numeric](5, 0) NOT NULL,
	[Porcentaje_Minima] [numeric](8, 4) NOT NULL,
	[Porcentaje_Maximo] [numeric](8, 4) NOT NULL,
	[TasaSuper] [float] NOT NULL,
 CONSTRAINT [PK__LINEA_TASA__117974A6] PRIMARY KEY CLUSTERED 
(
	[Id_Sistema] ASC,
	[Codigo_Producto] ASC,
	[codigo] ASC,
	[mncodmon] ASC,
	[Plazo_Desde] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_TASA] ADD  CONSTRAINT [DF__LINEA_TAS__Plazo__0E9D07FB]  DEFAULT (0) FOR [Plazo_Hasta]
GO
ALTER TABLE [dbo].[LINEA_TASA] ADD  CONSTRAINT [DF__LINEA_TAS__Tasa___0F912C34]  DEFAULT (0) FOR [Porcentaje_Minima]
GO
ALTER TABLE [dbo].[LINEA_TASA] ADD  CONSTRAINT [DF__LINEA_TAS__Tasa___1085506D]  DEFAULT (0) FOR [Porcentaje_Maximo]
GO
ALTER TABLE [dbo].[LINEA_TASA] ADD  CONSTRAINT [DF_LINEA_TASA_TasaSuper]  DEFAULT (0) FOR [TasaSuper]
GO
ALTER TABLE [dbo].[LINEA_TASA]  WITH NOCHECK ADD  CONSTRAINT [FK__LINEA_TASA__126D98DF] FOREIGN KEY([Id_Sistema], [Codigo_Producto])
REFERENCES [dbo].[PRODUCTO_SISTEMA] ([Id_Sistema], [Codigo_Producto])
GO
ALTER TABLE [dbo].[LINEA_TASA] CHECK CONSTRAINT [FK__LINEA_TASA__126D98DF]
GO
