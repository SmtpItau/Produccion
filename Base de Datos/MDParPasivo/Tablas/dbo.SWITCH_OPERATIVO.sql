USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[SWITCH_OPERATIVO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SWITCH_OPERATIVO](
	[Sistema] [char](3) NOT NULL,
	[Codigo_Control] [char](30) NOT NULL,
	[Reproceso] [char](1) NOT NULL,
	[Estado_Control] [char](1) NOT NULL,
	[Orden] [numeric](3, 0) NOT NULL,
	[Orden_Especial] [numeric](3, 0) NOT NULL,
	[Descripcion] [varchar](70) NOT NULL
) ON [PRIMARY]
GO
