USE [Bacfwdsuda]
GO
/****** Object:  Table [dbo].[voucher_cnt]    Script Date: 13-05-2022 10:32:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[voucher_cnt](
	[Numero_Voucher] [numeric](10, 0) NULL,
	[Fecha_Ingreso] [datetime] NULL,
	[Glosa] [char](70) NULL,
	[Tipo_Voucher] [char](1) NULL,
	[Tipo_Operacion] [char](5) NULL,
	[Operacion] [numeric](10, 0) NULL,
	[Folio_Perfil] [numeric](5, 0) NULL
) ON [PRIMARY]
GO
