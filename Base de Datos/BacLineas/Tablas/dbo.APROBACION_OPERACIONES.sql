USE [BacLineas]
GO
/****** Object:  Table [dbo].[APROBACION_OPERACIONES]    Script Date: 13-05-2022 10:44:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[APROBACION_OPERACIONES](
	[FechaOperacion] [datetime] NULL,
	[NumeroOperacion] [numeric](10, 0) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Estado] [char](1) NOT NULL,
	[Operador_Ap_Lineas] [char](15) NOT NULL,
	[Operador_Ap_Limites] [char](15) NOT NULL,
	[Operador_Ap_Tasas] [char](15) NOT NULL,
	[Operador_Ap_Grp] [char](15) NOT NULL,
	[Operador_Ap_LimPrecio] [char](15) NOT NULL,
	[Operador_Ap_Bloqueos] [char](15) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[APROBACION_OPERACIONES] ADD  DEFAULT ('') FOR [Operador_Ap_LimPrecio]
GO
ALTER TABLE [dbo].[APROBACION_OPERACIONES] ADD  DEFAULT ('') FOR [Operador_Ap_Bloqueos]
GO
