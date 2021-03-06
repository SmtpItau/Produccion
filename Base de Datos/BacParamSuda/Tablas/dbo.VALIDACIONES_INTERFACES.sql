USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[VALIDACIONES_INTERFACES]    Script Date: 13-05-2022 10:58:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[VALIDACIONES_INTERFACES](
	[Id_interfaz] [numeric](4, 0) NOT NULL,
	[Nombre_interfaz] [varchar](20) NOT NULL,
	[Sistema] [char](3) NOT NULL,
	[Tipo] [varchar](1) NOT NULL,
	[Id_campo] [numeric](3, 0) NOT NULL,
	[Descripcion_campo] [varchar](100) NULL,
	[Tipo_Dato] [varchar](20) NULL,
	[Largo] [numeric](4, 0) NULL,
	[Desde] [numeric](4, 0) NULL,
	[Hasta] [numeric](4, 0) NULL,
	[Definicion_campo] [varchar](300) NULL,
	[Validacion] [varchar](20) NULL,
	[Inicio1] [numeric](4, 0) NULL,
	[Largo1] [numeric](4, 0) NULL,
	[Operador] [varchar](3) NULL,
	[Id_campo2] [numeric](3, 0) NULL,
	[Inicio2] [numeric](4, 0) NULL,
	[Largo2] [numeric](4, 0) NULL,
	[Resultado_esperado] [varchar](100) NULL,
	[Habilita_CampoACampo] [int] NULL,
 CONSTRAINT [PK_VALIDACIONES_INTERFACES] PRIMARY KEY CLUSTERED 
(
	[Id_interfaz] ASC,
	[Sistema] ASC,
	[Tipo] ASC,
	[Id_campo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
