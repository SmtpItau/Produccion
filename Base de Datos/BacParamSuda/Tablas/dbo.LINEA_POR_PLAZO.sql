USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LINEA_POR_PLAZO]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_POR_PLAZO](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[PlazoDesde] [numeric](5, 0) NOT NULL,
	[PlazoHasta] [numeric](5, 0) NOT NULL,
	[Porcentaje] [numeric](8, 4) NOT NULL,
	[TotalAsignado] [numeric](19, 4) NOT NULL,
	[TotalOcupado] [numeric](19, 4) NOT NULL,
	[TotalDisponible] [numeric](19, 4) NOT NULL,
	[TotalExceso] [numeric](19, 4) NOT NULL,
	[TotalTraspaso] [numeric](19, 4) NOT NULL,
	[TotalRecibido] [numeric](19, 4) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Rut_Cliente] ASC,
	[Codigo_Cliente] ASC,
	[Id_Sistema] ASC,
	[PlazoDesde] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_POR_PLAZO] ADD  CONSTRAINT [DF__LINEA_POR__Porce__31DA8BE9]  DEFAULT (0) FOR [Porcentaje]
GO
ALTER TABLE [dbo].[LINEA_POR_PLAZO] ADD  CONSTRAINT [DF__LINEA_POR__Total__32CEB022]  DEFAULT (0) FOR [TotalAsignado]
GO
ALTER TABLE [dbo].[LINEA_POR_PLAZO] ADD  CONSTRAINT [DF__LINEA_POR__Total__33C2D45B]  DEFAULT (0) FOR [TotalOcupado]
GO
ALTER TABLE [dbo].[LINEA_POR_PLAZO] ADD  CONSTRAINT [DF__LINEA_POR__Total__34B6F894]  DEFAULT (0) FOR [TotalDisponible]
GO
ALTER TABLE [dbo].[LINEA_POR_PLAZO] ADD  CONSTRAINT [DF__LINEA_POR__Total__35AB1CCD]  DEFAULT (0) FOR [TotalExceso]
GO
ALTER TABLE [dbo].[LINEA_POR_PLAZO] ADD  CONSTRAINT [DF__LINEA_POR__Total__369F4106]  DEFAULT (0) FOR [TotalTraspaso]
GO
ALTER TABLE [dbo].[LINEA_POR_PLAZO] ADD  CONSTRAINT [DF__LINEA_POR__Total__3793653F]  DEFAULT (0) FOR [TotalRecibido]
GO
ALTER TABLE [dbo].[LINEA_POR_PLAZO]  WITH CHECK ADD FOREIGN KEY([Rut_Cliente], [Codigo_Cliente], [Id_Sistema])
REFERENCES [dbo].[LINEA_SISTEMA] ([Rut_Cliente], [Codigo_Cliente], [Id_Sistema])
GO
