USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[BAC_CNT_VOUCHER]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BAC_CNT_VOUCHER](
	[Numero_Voucher] [numeric](10, 0) NOT NULL,
	[Fecha_Ingreso] [datetime] NOT NULL,
	[Glosa] [char](70) NOT NULL,
	[Tipo_Voucher] [char](1) NOT NULL,
	[Tipo_Operacion] [char](5) NOT NULL,
	[Operacion] [numeric](10, 0) NOT NULL,
	[Correlativo] [numeric](5, 0) NOT NULL,
	[instser] [char](12) NOT NULL,
	[Documento] [numeric](10, 0) NOT NULL,
	[codigo_producto] [char](7) NULL,
	[id_sistema] [char](3) NULL,
	[fpagoentre] [char](6) NULL,
	[fpago] [char](6) NULL,
	[plazo] [numeric](9, 0) NULL,
	[condicion_pacto] [char](3) NULL,
	[clasificacion_cliente] [char](6) NULL,
	[MonedaOperacion] [numeric](5, 0) NOT NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER] ADD  CONSTRAINT [DF_BAC_CNT_VOUCHER_Correlativo]  DEFAULT (0) FOR [Correlativo]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER] ADD  CONSTRAINT [DF_BAC_CNT_VOUCHER_instser]  DEFAULT ('') FOR [instser]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER] ADD  CONSTRAINT [DF_BAC_CNT_VOUCHER_Documento]  DEFAULT (0) FOR [Documento]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER] ADD  CONSTRAINT [DF__bac_cnt_v__codig__4F36AFFD]  DEFAULT (' ') FOR [codigo_producto]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER] ADD  CONSTRAINT [DF__bac_cnt_v__id_si__502AD436]  DEFAULT (' ') FOR [id_sistema]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER] ADD  CONSTRAINT [DF__bac_cnt_v__fpago__21469372]  DEFAULT ('0') FOR [fpagoentre]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER] ADD  CONSTRAINT [DF__bac_cnt_v__fpago__223AB7AB]  DEFAULT ('0') FOR [fpago]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER] ADD  CONSTRAINT [DF__bac_cnt_v__plazo__232EDBE4]  DEFAULT (0) FOR [plazo]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER] ADD  CONSTRAINT [DF__bac_cnt_v__condi__2423001D]  DEFAULT ('0') FOR [condicion_pacto]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER] ADD  CONSTRAINT [DF__bac_cnt_v__clasi__25172456]  DEFAULT ('0') FOR [clasificacion_cliente]
GO
ALTER TABLE [dbo].[BAC_CNT_VOUCHER] ADD  CONSTRAINT [DF__BAC_CNT_V__Moned__0B7289DA]  DEFAULT (0) FOR [MonedaOperacion]
GO
