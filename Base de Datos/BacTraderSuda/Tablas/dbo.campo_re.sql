USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[campo_re]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[campo_re](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[codigo_campo] [numeric](3, 0) NOT NULL,
	[descripcion_campo] [char](60) NULL,
	[nombre_campo_tabla] [char](40) NULL,
	[tipo_administracion_campo] [char](1) NULL,
	[tabla_campo] [char](40) NULL,
	[campo_tabla] [varchar](100) NULL,
	[campos_tablas] [varchar](100) NULL
) ON [PRIMARY]
GO
