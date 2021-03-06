USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CORRESPONSAL]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CORRESPONSAL](
	[Rut_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Cliente] [numeric](9, 0) NOT NULL,
	[Codigo_Moneda] [numeric](5, 0) NOT NULL,
	[Codigo_Pais] [numeric](5, 0) NOT NULL,
	[Codigo_Plaza] [numeric](5, 0) NOT NULL,
	[Codigo_Swift] [varchar](20) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Cuenta_Corriente] [varchar](30) NOT NULL,
	[Swift_Santiago] [varchar](20) NOT NULL,
	[Banco_Central] [char](1) NOT NULL,
	[Fecha_Vencimiento] [datetime] NOT NULL,
	[Defecto] [char](1) NOT NULL,
	[codigo_corresponsal_contable] [char](5) NOT NULL
) ON [PRIMARY]
GO
