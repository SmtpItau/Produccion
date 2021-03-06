USE [BacCamSuda]
GO
/****** Object:  Table [dbo].[bac_cnt_detalle_voucher]    Script Date: 11-05-2022 16:44:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bac_cnt_detalle_voucher](
	[Numero_Voucher] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[Cuenta] [varchar](20) NOT NULL,
	[Tipo_Monto] [char](1) NOT NULL,
	[Monto] [float] NOT NULL,
	[Codigo_Corresponsal] [numeric](7, 0) NOT NULL,
	[Valor_Campo] [varchar](30) NOT NULL,
	[Tipo_Operacion] [char](5) NOT NULL,
	[Operacion] [numeric](10, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[bac_cnt_detalle_voucher] ADD  CONSTRAINT [DF__bac_cnt_d__Codig__6724137E]  DEFAULT (0) FOR [Codigo_Corresponsal]
GO
ALTER TABLE [dbo].[bac_cnt_detalle_voucher] ADD  DEFAULT ('') FOR [Tipo_Operacion]
GO
ALTER TABLE [dbo].[bac_cnt_detalle_voucher] ADD  DEFAULT (0) FOR [Operacion]
GO
