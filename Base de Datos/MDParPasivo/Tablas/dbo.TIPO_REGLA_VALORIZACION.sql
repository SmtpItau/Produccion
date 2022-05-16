USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[TIPO_REGLA_VALORIZACION]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIPO_REGLA_VALORIZACION](
	[id_tipo_regla] [int] NOT NULL,
	[descripcion] [varchar](50) NOT NULL,
	[tipo_grupo] [char](1) NOT NULL,
	[SpEjecucionVal] [varchar](50) NOT NULL,
	[SpBusquedaVal] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
