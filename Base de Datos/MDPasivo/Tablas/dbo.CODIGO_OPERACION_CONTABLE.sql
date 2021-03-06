USE [MDPasivo]
GO
/****** Object:  Table [dbo].[CODIGO_OPERACION_CONTABLE]    Script Date: 16-05-2022 11:41:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CODIGO_OPERACION_CONTABLE](
	[codigo_operacion] [char](3) NOT NULL,
	[id_sistema] [char](3) NOT NULL,
	[codigo_producto] [char](5) NOT NULL,
	[evento] [char](3) NOT NULL,
	[tipo_cuenta] [char](1) NOT NULL,
	[moneda1] [int] NOT NULL,
	[moneda2] [int] NOT NULL,
	[instrumento] [int] NOT NULL,
	[descripcion] [char](50) NOT NULL,
	[glosa_corta] [char](15) NOT NULL,
	[Relacion_Bcch] [numeric](1, 0) NOT NULL,
	[Reversa] [numeric](1, 0) NOT NULL,
	[mercado] [int] NOT NULL
) ON [PRIMARY]
GO
