USE [MDPasivo]
GO
/****** Object:  Table [dbo].[ACTIVIDAD_ECONOMICA]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ACTIVIDAD_ECONOMICA](
	[Codigo_Actividad] [numeric](5, 0) NOT NULL,
	[Descripcion] [char](40) NOT NULL
) ON [PRIMARY]
GO
