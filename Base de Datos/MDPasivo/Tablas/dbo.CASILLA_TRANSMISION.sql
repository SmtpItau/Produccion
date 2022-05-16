USE [MDPasivo]
GO
/****** Object:  Table [dbo].[CASILLA_TRANSMISION]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CASILLA_TRANSMISION](
	[Codigo_Interfaz] [char](30) NOT NULL,
	[Nombre_host] [char](30) NOT NULL,
	[Direccion_host] [char](30) NOT NULL,
	[Usuario_host] [char](20) NOT NULL,
	[Clave_host] [char](20) NOT NULL,
	[Path_inical_host] [char](50) NOT NULL
) ON [PRIMARY]
GO
