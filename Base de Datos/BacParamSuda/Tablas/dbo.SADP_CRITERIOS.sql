USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_CRITERIOS]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_CRITERIOS](
	[Id_Criterio] [int] NOT NULL,
	[Nombre_Criterio] [varchar](25) NOT NULL,
	[Modulo_Origen] [char](5) NOT NULL,
	[Tipo_Mercado] [varchar](15) NOT NULL,
	[Moneda] [int] NOT NULL,
	[Forma_Pago] [int] NOT NULL,
	[Rut_Cliente] [numeric](10, 0) NOT NULL,
	[Codigo_Cliente] [int] NOT NULL
) ON [PRIMARY]
GO
