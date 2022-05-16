USE [MDPasivo]
GO
/****** Object:  Table [dbo].[AYUDA_SISTEMA]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AYUDA_SISTEMA](
	[id_sistema] [char](3) NOT NULL,
	[nombre_formulario] [char](100) NOT NULL,
	[ruta_archivo] [char](255) NOT NULL,
	[id_contexto] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
