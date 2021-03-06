USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[FORPAG]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORPAG](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[codigo_campo] [numeric](3, 0) NOT NULL,
	[descripcion_campo] [char](60) NOT NULL,
	[nombre_campo_tabla] [char](40) NOT NULL,
	[tipo_administracion_campo] [char](1) NOT NULL,
	[tabla_campo] [char](20) NOT NULL,
	[campo_tabla] [char](30) NOT NULL,
	[campos_tablas] [char](30) NOT NULL
) ON [PRIMARY]
GO
