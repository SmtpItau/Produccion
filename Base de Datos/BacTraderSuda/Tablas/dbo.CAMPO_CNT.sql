USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CAMPO_CNT]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAMPO_CNT](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[codigo_campo] [numeric](3, 0) NOT NULL,
	[descripcion_campo] [char](60) NOT NULL,
	[nombre_campo_tabla] [char](40) NOT NULL,
	[tipo_administracion_campo] [char](1) NOT NULL,
	[tabla_campo] [char](20) NOT NULL,
	[campo_tabla] [varchar](100) NOT NULL,
	[campos_tablas] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sistema] ASC,
	[tipo_movimiento] ASC,
	[tipo_operacion] ASC,
	[codigo_campo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
