USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[SADP_VALORDEFAULT]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SADP_VALORDEFAULT](
	[Id_ValorDefault] [int] IDENTITY(1,1) NOT NULL,
	[Origen] [char](5) NOT NULL,
	[Mercado] [varchar](15) NOT NULL,
	[Moneda] [int] NOT NULL,
	[Rut_Cliente] [numeric](10, 0) NOT NULL,
	[Codigo_Cliente] [int] NOT NULL,
	[Forma_Pago] [varchar](20) NOT NULL,
	[Rut_Banco] [numeric](10, 0) NOT NULL,
	[Cod_Banco] [smallint] NOT NULL,
	[sBeneficiario] [varchar](30) NOT NULL,
	[id_FormaPago] [smallint] NOT NULL
) ON [PRIMARY]
GO
