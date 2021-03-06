USE [BacLineas]
GO
/****** Object:  Table [dbo].[DETALLE_APROBACIONES]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DETALLE_APROBACIONES](
	[Id_Sistema] [char](3) NOT NULL,
	[Numero_Operacion] [numeric](18, 0) NOT NULL,
	[Fecha_Operacion] [datetime] NOT NULL,
	[Operador_Origen] [char](15) NOT NULL,
	[Operador_Autoriza] [char](15) NOT NULL,
	[Monto_Operacion] [float] NOT NULL,
	[Monto_Operador] [float] NULL,
	[Monto_Autoriza] [float] NULL,
	[Estado] [char](1) NOT NULL,
	[Firma1] [char](15) NOT NULL,
	[Firma2] [char](15) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[DETALLE_APROBACIONES] ADD  DEFAULT ('') FOR [Firma1]
GO
ALTER TABLE [dbo].[DETALLE_APROBACIONES] ADD  DEFAULT ('') FOR [Firma2]
GO
