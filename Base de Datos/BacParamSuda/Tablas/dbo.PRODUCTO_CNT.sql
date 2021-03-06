USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[PRODUCTO_CNT]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PRODUCTO_CNT](
	[id_sistema] [char](3) NOT NULL,
	[tipo_operacion] [char](3) NOT NULL,
	[origen_instrumentos] [varchar](60) NOT NULL,
	[datos_instrumentos] [varchar](60) NOT NULL,
	[cond_instrumentos] [varchar](60) NOT NULL,
	[origen_monedas] [varchar](60) NOT NULL,
	[datos_monedas] [varchar](60) NOT NULL,
	[cond_monedas] [varchar](60) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sistema] ASC,
	[tipo_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
