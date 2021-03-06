USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LINEA_SISTEMA]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LINEA_SISTEMA](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[FechaAsignacion] [datetime] NOT NULL,
	[FechaVencimiento] [datetime] NOT NULL,
	[FechaFinContrato] [datetime] NOT NULL,
	[RealizaTraspaso] [char](1) NOT NULL,
	[Bloqueado] [char](1) NOT NULL,
	[Compartido] [char](1) NOT NULL,
	[ControlaPlazo] [char](1) NOT NULL,
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
	[Id_Sistema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Fecha__08D87656]  DEFAULT (' ') FOR [FechaAsignacion]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Fecha__09CC9A8F]  DEFAULT (' ') FOR [FechaVencimiento]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Fecha__0AC0BEC8]  DEFAULT (' ') FOR [FechaFinContrato]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Reali__0BB4E301]  DEFAULT (' ') FOR [RealizaTraspaso]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Bloqu__0CA9073A]  DEFAULT (' ') FOR [Bloqueado]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Compa__0D9D2B73]  DEFAULT (' ') FOR [Compartido]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Contr__0E914FAC]  DEFAULT (' ') FOR [ControlaPlazo]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Total__0F8573E5]  DEFAULT (0) FOR [TotalAsignado]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Total__1079981E]  DEFAULT (0) FOR [TotalOcupado]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Total__116DBC57]  DEFAULT (0) FOR [TotalDisponible]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Total__1261E090]  DEFAULT (0) FOR [TotalExceso]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Total__135604C9]  DEFAULT (0) FOR [TotalTraspaso]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__Total__144A2902]  DEFAULT (0) FOR [TotalRecibido]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__SinRi__153E4D3B]  DEFAULT (0) FOR [SinRiesgoAsignado]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__SinRi__16327174]  DEFAULT (0) FOR [SinRiesgoOcupado]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__SinRi__172695AD]  DEFAULT (0) FOR [SinRiesgoDisponible]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__SinRi__181AB9E6]  DEFAULT (0) FOR [SinRiesgoExceso]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__ConRi__190EDE1F]  DEFAULT (0) FOR [ConRiesgoAsignado]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__ConRi__1A030258]  DEFAULT (0) FOR [ConRiesgoOcupado]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__ConRi__1AF72691]  DEFAULT (0) FOR [ConRiesgoDisponible]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] ADD  CONSTRAINT [DF__LINEA_SIS__ConRi__1BEB4ACA]  DEFAULT (0) FOR [ConRiesgoExceso]
GO
ALTER TABLE [dbo].[LINEA_SISTEMA]  WITH CHECK ADD FOREIGN KEY([Id_Sistema])
REFERENCES [dbo].[SISTEMA_CNT] ([id_sistema])
GO
ALTER TABLE [dbo].[LINEA_SISTEMA]  WITH CHECK ADD  CONSTRAINT [FK__LINEA_SISTEMA__1CDF6F03] FOREIGN KEY([Rut_Cliente], [Codigo_Cliente])
REFERENCES [dbo].[LINEA_GENERAL] ([Rut_Cliente], [Codigo_Cliente])
GO
ALTER TABLE [dbo].[LINEA_SISTEMA] CHECK CONSTRAINT [FK__LINEA_SISTEMA__1CDF6F03]
GO
