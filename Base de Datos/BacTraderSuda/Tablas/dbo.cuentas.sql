USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[cuentas]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cuentas](
	[cuenta] [char](12) NOT NULL,
	[descripcion] [char](70) NULL,
	[glosa] [char](30) NULL,
	[tipo_cuenta] [char](3) NULL,
	[cuenta_imputable] [char](1) NULL,
	[con_correccion] [char](1) NULL,
	[con_centro_costo] [char](3) NULL,
	[tipo_moneda] [char](1) NULL,
	[prod_asoc] [numeric](5, 0) NULL,
	[cta_sbif] [char](40) NULL,
	[tipo_saldo] [numeric](3, 0) NULL,
	[tipo_relacion] [numeric](3, 0) NULL
) ON [PRIMARY]
GO
