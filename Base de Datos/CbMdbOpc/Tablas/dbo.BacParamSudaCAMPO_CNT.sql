USE [CbMdbOpc]
GO
/****** Object:  Table [dbo].[BacParamSudaCAMPO_CNT]    Script Date: 16-05-2022 10:16:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BacParamSudaCAMPO_CNT](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[codigo_campo] [numeric](3, 0) NOT NULL,
	[descripcion_campo] [char](60) NULL,
	[nombre_campo_tabla] [char](80) NULL,
	[tipo_administracion_campo] [char](1) NULL,
	[tabla_campo] [char](80) NULL,
	[campo_tabla] [varchar](100) NULL,
	[campos_tablas] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sistema] ASC,
	[tipo_movimiento] ASC,
	[tipo_operacion] ASC,
	[codigo_campo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
