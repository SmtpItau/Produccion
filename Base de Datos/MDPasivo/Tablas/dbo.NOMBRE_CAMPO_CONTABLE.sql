USE [MDPasivo]
GO
/****** Object:  Table [dbo].[NOMBRE_CAMPO_CONTABLE]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NOMBRE_CAMPO_CONTABLE](
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[nombre_campo] [char](50) NOT NULL,
	[descripcion] [char](50) NOT NULL,
	[origen_moneda] [char](2) NULL
) ON [PRIMARY]
GO
