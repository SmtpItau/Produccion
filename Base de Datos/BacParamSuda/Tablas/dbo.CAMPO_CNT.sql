USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CAMPO_CNT]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAMPO_CNT](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[codigo_campo] [numeric](3, 0) NOT NULL,
	[descripcion_campo] [char](60) NULL,
	[nombre_campo_tabla] [char](40) NULL,
	[tipo_administracion_campo] [char](1) NULL,
	[tabla_campo] [char](40) NULL,
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
ALTER TABLE [dbo].[CAMPO_CNT] ADD  CONSTRAINT [DF__CAMPO_CNT__Descr__48FC51B5]  DEFAULT ('') FOR [descripcion_campo]
GO
ALTER TABLE [dbo].[CAMPO_CNT] ADD  CONSTRAINT [DF__CAMPO_CNT__Nombr__49F075EE]  DEFAULT ('') FOR [nombre_campo_tabla]
GO
ALTER TABLE [dbo].[CAMPO_CNT] ADD  CONSTRAINT [DF__CAMPO_CNT__Tipo___4AE49A27]  DEFAULT ('') FOR [tipo_administracion_campo]
GO
ALTER TABLE [dbo].[CAMPO_CNT] ADD  CONSTRAINT [DF__CAMPO_CNT__Tabla__4BD8BE60]  DEFAULT ('') FOR [tabla_campo]
GO
ALTER TABLE [dbo].[CAMPO_CNT] ADD  CONSTRAINT [DF__CAMPO_CNT__Campo__4CCCE299]  DEFAULT ('') FOR [campo_tabla]
GO
ALTER TABLE [dbo].[CAMPO_CNT] ADD  CONSTRAINT [DF__CAMPO_CNT__Campo__4DC106D2]  DEFAULT ('') FOR [campos_tablas]
GO
