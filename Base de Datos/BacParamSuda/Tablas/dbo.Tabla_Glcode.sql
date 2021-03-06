USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[Tabla_Glcode]    Script Date: 13-05-2022 10:58:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tabla_Glcode](
	[Codigo_Transaccion] [numeric](5, 0) NOT NULL,
	[Codigo_Campo_Condicion] [numeric](3, 0) NOT NULL,
	[Codigo_Condicion] [varchar](30) NOT NULL,
	[Descripcion] [char](50) NULL,
	[Cuenta_Glcode] [char](8) NULL,
	[Cuenta_Supoer] [char](10) NULL,
	[Cuenta_Altamira] [char](12) NULL,
	[Cuenta_Cosif] [char](12) NULL,
	[Cuenta_Cosif_Ger] [char](12) NULL,
	[Cuenta_Glcode_INT] [char](12) NOT NULL,
	[Cuenta_Glcode_REA] [char](12) NOT NULL,
	[Cuenta_Altamira_per] [char](12) NULL,
	[cuentaGL_GRM] [char](12) NULL,
	[cuentaSbifGRM] [char](12) NULL
) ON [PRIMARY]
GO
