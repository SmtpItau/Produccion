USE [BacSwapSuda]
GO
/****** Object:  Table [dbo].[res_voucher_28_09_2012]    Script Date: 13-05-2022 11:14:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[res_voucher_28_09_2012](
	[Numero_Voucher] [numeric](10, 0) NOT NULL,
	[Fecha_Ingreso] [datetime] NULL,
	[Glosa] [char](70) NULL,
	[Tipo_Voucher] [char](1) NULL,
	[Tipo_Operacion] [varchar](5) NOT NULL,
	[Operacion] [numeric](10, 0) NULL,
	[Folio_Perfil] [numeric](5, 0) NULL
) ON [PRIMARY]
GO
