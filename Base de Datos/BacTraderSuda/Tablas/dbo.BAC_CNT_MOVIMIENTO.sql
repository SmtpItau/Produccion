USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_MOVIMIENTO]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_MOVIMIENTO](
	[id_sistema] [char](3) NULL,
	[tipo_movimiento] [char](3) NULL,
	[glosa_movimiento] [char](40) NULL,
	[tipo_operacion] [char](5) NULL,
	[glosa_operacion] [char](40) NULL,
	[tipo_voucher_contab] [int] NULL,
	[tipo_movimiento_caja] [char](1) NULL,
	[control_instrumento] [char](1) NOT NULL,
	[control_moneda] [char](1) NOT NULL,
	[genera_docto] [char](1) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAC_CNT_MOVIMIENTO] ADD  CONSTRAINT [DF__BAC_CNT_M__contr__748F2482]  DEFAULT ('N') FOR [control_instrumento]
GO
