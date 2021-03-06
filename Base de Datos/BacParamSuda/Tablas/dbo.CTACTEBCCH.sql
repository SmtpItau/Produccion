USE [BacParamSuda]
GO
/****** Object:  Table [dbo].[CTACTEBCCH]    Script Date: 13-05-2022 10:58:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CTACTEBCCH](
	[fecha] [datetime] NOT NULL,
	[sistema] [char](3) NOT NULL,
	[tipo_operacion] [char](5) NOT NULL,
	[numero_operacion] [numeric](9, 0) NOT NULL,
	[tipo_mercado] [char](12) NOT NULL,
	[monto_operacion] [numeric](19, 0) NOT NULL,
	[rut_cliente] [numeric](9, 0) NOT NULL,
	[codigo_cliente] [numeric](9, 0) NOT NULL,
	[fecha_valuta_Ent] [datetime] NOT NULL,
	[fecha_valuta_Rec] [datetime] NOT NULL,
	[for_pag_entre] [numeric](5, 0) NOT NULL,
	[glosa_entre] [char](30) NOT NULL,
	[for_pag_recib] [numeric](5, 0) NOT NULL,
	[glosa_recib] [char](30) NOT NULL,
	[estado_Pago_Efect] [char](2) NOT NULL,
	[estado_operacion] [char](1) NOT NULL,
	[indica_mov_pesos] [char](1) NOT NULL,
	[moneda] [numeric](5, 0) NOT NULL,
	[forma_pago] [numeric](5, 0) NOT NULL,
	[fecha_efectiva] [datetime] NOT NULL,
 CONSTRAINT [PK_CTACTEBCCH] PRIMARY KEY NONCLUSTERED 
(
	[fecha] ASC,
	[sistema] ASC,
	[tipo_operacion] ASC,
	[numero_operacion] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_fecha]  DEFAULT (0) FOR [fecha]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_sistema]  DEFAULT ('') FOR [sistema]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_tipo_operacion]  DEFAULT ('') FOR [tipo_operacion]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_numero_operacion]  DEFAULT (0) FOR [numero_operacion]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_tipo_mercado]  DEFAULT ('') FOR [tipo_mercado]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_monto_operacion]  DEFAULT (0) FOR [monto_operacion]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_rut_cliente]  DEFAULT (0) FOR [rut_cliente]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_codigo_cliente]  DEFAULT (0) FOR [codigo_cliente]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_fecha_valuta_Ent]  DEFAULT ('') FOR [fecha_valuta_Ent]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_fecha_valuta_Rec]  DEFAULT ('') FOR [fecha_valuta_Rec]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_for_pag_entre]  DEFAULT (0) FOR [for_pag_entre]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_glosa_entre]  DEFAULT ('') FOR [glosa_entre]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_for_pag_recib]  DEFAULT (0) FOR [for_pag_recib]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_glosa_recib]  DEFAULT ('') FOR [glosa_recib]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_estado_envio]  DEFAULT ('') FOR [estado_Pago_Efect]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_estado_operacion]  DEFAULT ('') FOR [estado_operacion]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_indica_mov_pesos]  DEFAULT ('') FOR [indica_mov_pesos]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_moneda]  DEFAULT (0) FOR [moneda]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_forma_pago]  DEFAULT (0) FOR [forma_pago]
GO
ALTER TABLE [dbo].[CTACTEBCCH] ADD  CONSTRAINT [DF_CTACTEBCCH_fecha_efectiva]  DEFAULT ('') FOR [fecha_efectiva]
GO
