USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[MOVIMIENTO_CNT]    Script Date: 13-05-2022 10:58:10 ******/
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
	[genera_docto] [char](1) NULL,
PRIMARY KEY CLUSTERED 
(
	[id_sistema] ASC,
	[tipo_movimiento] ASC,
	[tipo_operacion] ASC,
	[glosa_movimiento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MOVIMIENTO_CNT] ADD  CONSTRAINT [DF__MOVIMIENT__Glosa__5DE26002]  DEFAULT ('') FOR [glosa_operacion]
GO
ALTER TABLE [dbo].[MOVIMIENTO_CNT] ADD  CONSTRAINT [DF__MOVIMIENT__Tipo___5ED6843B]  DEFAULT (0) FOR [tipo_voucher_contab]
GO
ALTER TABLE [dbo].[MOVIMIENTO_CNT] ADD  CONSTRAINT [DF__MOVIMIENT__Tipo___5FCAA874]  DEFAULT ('') FOR [tipo_movimiento_caja]
GO
ALTER TABLE [dbo].[MOVIMIENTO_CNT] ADD  CONSTRAINT [DF__MOVIMIENT__Contr__60BECCAD]  DEFAULT ('') FOR [control_instrumento]
GO
ALTER TABLE [dbo].[MOVIMIENTO_CNT] ADD  CONSTRAINT [DF__MOVIMIENT__Contr__61B2F0E6]  DEFAULT ('') FOR [control_moneda]
GO
ALTER TABLE [dbo].[MOVIMIENTO_CNT] ADD  CONSTRAINT [DF__MOVIMIENT__Gener__62A7151F]  DEFAULT ('') FOR [genera_docto]
GO
