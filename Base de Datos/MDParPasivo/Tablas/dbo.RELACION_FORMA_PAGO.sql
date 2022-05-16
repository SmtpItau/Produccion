USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[RELACION_FORMA_PAGO]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RELACION_FORMA_PAGO](
	[Id_Sistema] [char](3) NOT NULL,
	[Codigo] [decimal](1, 0) NOT NULL,
	[Descripción] [char](30) NULL
) ON [PRIMARY]
GO
