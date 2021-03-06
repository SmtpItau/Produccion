USE [MDParPasivo]
GO
/****** Object:  Table [dbo].[CON_PLAN_CUENTAS]    Script Date: 16-05-2022 11:12:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CON_PLAN_CUENTAS](
	[Cuenta] [char](12) NOT NULL,
	[Descripcion] [char](70) NOT NULL,
	[Tipo_Cuenta] [char](3) NOT NULL,
	[Cuenta_Imputable] [char](1) NOT NULL,
	[Con_Correccion] [char](1) NOT NULL,
	[Con_Centro_Costo] [char](1) NOT NULL,
	[cod_mon] [numeric](3, 0) NOT NULL,
	[interfaz] [char](1) NULL,
	[interfaz_fwd] [char](1) NOT NULL,
	[codigo_mb1] [numeric](5, 0) NOT NULL,
	[partida_mb1] [numeric](5, 0) NOT NULL,
	[TipoPosiciónC17] [numeric](3, 0) NOT NULL
) ON [PRIMARY]
GO
