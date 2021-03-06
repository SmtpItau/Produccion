USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[FORMATO_INTERFACES]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FORMATO_INTERFACES](
	[Id_interfaz] [numeric](4, 0) NOT NULL,
	[Nombre_interfaz] [varchar](20) NOT NULL,
	[Nombre_largo] [varchar](100) NOT NULL,
	[Largo_encabezado] [numeric](4, 0) NULL,
	[Largo_cuerpo] [numeric](4, 0) NULL,
	[Largo_ultimo_registro] [numeric](4, 0) NULL,
	[Sistema] [char](3) NOT NULL,
	[Periodicidad] [int] NULL,
	[ValLargo] [int] NULL,
	[ValConsistencia] [int] NULL,
	[ValCampoACampo] [int] NULL,
 CONSTRAINT [PK_FORMATO_INTERFACES] PRIMARY KEY CLUSTERED 
(
	[Id_interfaz] ASC,
	[Sistema] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
