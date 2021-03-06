USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[CON_PLAN_CUENTAS]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CON_PLAN_CUENTAS](
	[cuenta] [char](12) NOT NULL,
	[descripcion] [char](70) NOT NULL,
	[tipo_cuenta] [char](3) NOT NULL,
	[cuenta_imputable] [char](1) NOT NULL,
	[con_correccion] [char](1) NOT NULL,
	[con_centro_costo] [char](1) NOT NULL
) ON [PRIMARY]
GO
