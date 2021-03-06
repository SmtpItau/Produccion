USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_PRODUCTOS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_PRODUCTOS](
	[id_sistema] [char](3) NULL,
	[tipo_operacion] [char](3) NULL,
	[origen_instrumentos] [varchar](60) NULL,
	[datos_instrumentos] [varchar](60) NULL,
	[cond_instrumentos] [varchar](60) NULL,
	[origen_monedas] [varchar](60) NULL,
	[datos_monedas] [varchar](60) NULL,
	[cond_monedas] [varchar](60) NULL
) ON [PRIMARY]
GO
