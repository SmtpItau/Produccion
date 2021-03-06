USE [BacLineas]
GO
/****** Object:  Table [dbo].[POSICION_GRUPO_DETALLE]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[POSICION_GRUPO_DETALLE](
	[codigo_grupo] [varchar](5) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[tipo_operacion] [char](1) NOT NULL,
	[montooriginal] [numeric](19, 4) NOT NULL,
	[tipocambio] [numeric](10, 4) NOT NULL,
	[montooperacion] [numeric](19, 4) NOT NULL,
	[fechainicio] [datetime] NOT NULL,
	[fechavencimiento] [datetime] NOT NULL,
	[plazooperacion] [numeric](5, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[codigo_grupo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[POSICION_GRUPO_DETALLE] ADD  CONSTRAINT [DF__POSICION___Tipo___2E9D6134]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[POSICION_GRUPO_DETALLE] ADD  CONSTRAINT [DF__POSICION___Monto__2F91856D]  DEFAULT (0) FOR [montooriginal]
GO
ALTER TABLE [dbo].[POSICION_GRUPO_DETALLE] ADD  CONSTRAINT [DF__POSICION___TipoC__3085A9A6]  DEFAULT (0) FOR [tipocambio]
GO
ALTER TABLE [dbo].[POSICION_GRUPO_DETALLE] ADD  CONSTRAINT [DF__POSICION___Monto__3179CDDF]  DEFAULT (0) FOR [montooperacion]
GO
ALTER TABLE [dbo].[POSICION_GRUPO_DETALLE] ADD  CONSTRAINT [DF__POSICION___Fecha__326DF218]  DEFAULT ('') FOR [fechainicio]
GO
ALTER TABLE [dbo].[POSICION_GRUPO_DETALLE] ADD  CONSTRAINT [DF__POSICION___Fecha__33621651]  DEFAULT ('') FOR [fechavencimiento]
GO
ALTER TABLE [dbo].[POSICION_GRUPO_DETALLE] ADD  CONSTRAINT [DF__POSICION___Plazo__34563A8A]  DEFAULT (0) FOR [plazooperacion]
GO
