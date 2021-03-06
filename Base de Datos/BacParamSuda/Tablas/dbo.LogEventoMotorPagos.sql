USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[LogEventoMotorPagos]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogEventoMotorPagos](
	[FechaSistema] [datetime] NOT NULL,
	[Usuario] [varchar](15) NOT NULL,
	[Terminal] [varchar](25) NOT NULL,
	[Sistema] [char](3) NOT NULL,
	[Numero] [numeric](9, 0) NOT NULL,
	[Moneda] [varchar](3) NOT NULL,
	[Estado] [varchar](20) NOT NULL,
	[Proceso] [varchar](20) NOT NULL,
	[Mensaje] [varchar](100) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[LogEventoMotorPagos] ADD  CONSTRAINT [dfLogEventoMotorPagos_FechaSistema]  DEFAULT ('') FOR [FechaSistema]
GO
ALTER TABLE [dbo].[LogEventoMotorPagos] ADD  CONSTRAINT [dfLogEventoMotorPagos_Usuario]  DEFAULT ('') FOR [Usuario]
GO
ALTER TABLE [dbo].[LogEventoMotorPagos] ADD  CONSTRAINT [dfLogEventoMotorPagos_Terminal]  DEFAULT ('') FOR [Terminal]
GO
ALTER TABLE [dbo].[LogEventoMotorPagos] ADD  CONSTRAINT [dfLogEventoMotorPagos_Sistema]  DEFAULT ('') FOR [Sistema]
GO
ALTER TABLE [dbo].[LogEventoMotorPagos] ADD  CONSTRAINT [dfLogEventoMotorPagos_Numero]  DEFAULT (0) FOR [Numero]
GO
ALTER TABLE [dbo].[LogEventoMotorPagos] ADD  CONSTRAINT [dfLogEventoMotorPagos_Moneda]  DEFAULT ('') FOR [Moneda]
GO
ALTER TABLE [dbo].[LogEventoMotorPagos] ADD  CONSTRAINT [dfLogEventoMotorPagos_Estado]  DEFAULT ('') FOR [Estado]
GO
ALTER TABLE [dbo].[LogEventoMotorPagos] ADD  CONSTRAINT [dfLogEventoMotorPagos_Proceso]  DEFAULT ('') FOR [Proceso]
GO
ALTER TABLE [dbo].[LogEventoMotorPagos] ADD  CONSTRAINT [dfLogEventoMotorPagos_Mensaje]  DEFAULT ('') FOR [Mensaje]
GO
