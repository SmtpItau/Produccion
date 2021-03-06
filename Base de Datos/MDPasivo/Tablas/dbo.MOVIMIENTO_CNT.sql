USE [MDPasivo]
GO
/****** Object:  Table [dbo].[MOVIMIENTO_CNT]    Script Date: 16-05-2022 11:41:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOVIMIENTO_CNT](
	[id_sistema] [char](3) NOT NULL,
	[tipo_movimiento] [char](3) NOT NULL,
	[tipo_operacion] [char](15) NOT NULL,
	[glosa_movimiento] [char](40) NOT NULL,
	[glosa_operacion] [char](40) NULL,
	[tipo_voucher_contab] [int] NULL,
	[tipo_movimiento_caja] [char](1) NULL,
	[control_instrumento] [char](1) NULL,
	[control_moneda] [char](1) NULL,
	[genera_docto] [char](1) NULL
) ON [PRIMARY]
GO
