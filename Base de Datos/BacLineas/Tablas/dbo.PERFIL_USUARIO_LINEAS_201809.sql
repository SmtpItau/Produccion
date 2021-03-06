USE [BacLineas]
GO
/****** Object:  Table [dbo].[PERFIL_USUARIO_LINEAS_201809]    Script Date: 13-05-2022 10:44:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PERFIL_USUARIO_LINEAS_201809](
	[Usuario] [varchar](15) NOT NULL,
	[Sistema] [char](3) NOT NULL,
	[Lin_Inst_Financiera] [int] NOT NULL,
	[Lin_Otra_Instirucion] [int] NOT NULL,
	[Impresion_Papelteas] [int] NOT NULL,
	[Monitor_Operaciones] [int] NOT NULL,
	[Liberacion_Operaciones] [int] NOT NULL,
	[Producto] [varchar](5) NOT NULL,
	[Tipo_Cliente] [int] NOT NULL,
	[Activado] [int] NOT NULL
) ON [PRIMARY]
GO
