USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LINEA_PRODUCTO]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_PRODUCTO](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo_Producto] [char](5) NOT NULL,
	[Codigo_Instrumento] [numeric](5, 0) NOT NULL,
	[TotalAsignado] [numeric](19, 4) NOT NULL,
	[TotalOcupado] [numeric](19, 4) NOT NULL,
	[TotalDisponible] [numeric](19, 4) NOT NULL,
	[TotalExceso] [numeric](19, 4) NOT NULL,
	[TotalTraspaso] [numeric](19, 4) NOT NULL,
	[TotalRecibido] [numeric](19, 4) NOT NULL,
	[SinRiesgoAsignado] [numeric](19, 4) NOT NULL,
	[SinRiesgoOcupado] [numeric](19, 4) NOT NULL,
	[SinRiesgoDisponible] [numeric](19, 4) NOT NULL,
	[SinRiesgoExceso] [numeric](19, 4) NOT NULL,
	[ConRiesgoAsignado] [numeric](19, 4) NOT NULL,
	[ConRiesgoOcupado] [numeric](19, 4) NOT NULL,
	[ConRiesgoDisponible] [numeric](19, 4) NOT NULL,
	[ConRiesgoExceso] [numeric](19, 4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Rut_Cliente] ASC,
	[Codigo_Cliente] ASC,
	[Id_Sistema] ASC,
	[Codigo_Producto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__Total__20AFFFE7]  DEFAULT (0) FOR [TotalAsignado]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__Total__21A42420]  DEFAULT (0) FOR [TotalOcupado]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__Total__22984859]  DEFAULT (0) FOR [TotalDisponible]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__Total__238C6C92]  DEFAULT (0) FOR [TotalExceso]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__Total__248090CB]  DEFAULT (0) FOR [TotalTraspaso]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__Total__2574B504]  DEFAULT (0) FOR [TotalRecibido]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__SinRi__2668D93D]  DEFAULT (0) FOR [SinRiesgoAsignado]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__SinRi__275CFD76]  DEFAULT (0) FOR [SinRiesgoOcupado]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__SinRi__285121AF]  DEFAULT (0) FOR [SinRiesgoDisponible]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__SinRi__294545E8]  DEFAULT (0) FOR [SinRiesgoExceso]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__ConRi__2A396A21]  DEFAULT (0) FOR [ConRiesgoAsignado]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__ConRi__2B2D8E5A]  DEFAULT (0) FOR [ConRiesgoOcupado]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__ConRi__2C21B293]  DEFAULT (0) FOR [ConRiesgoDisponible]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO] ADD  CONSTRAINT [DF__LINEA_PRO__ConRi__2D15D6CC]  DEFAULT (0) FOR [ConRiesgoExceso]
GO
ALTER TABLE [dbo].[LINEA_PRODUCTO]  WITH CHECK ADD FOREIGN KEY([Codigo_Producto])
REFERENCES [dbo].[PRODUCTO] ([codigo_producto])
GO
