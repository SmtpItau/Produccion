USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_ser]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_ser](
	[Cod_familia] [numeric](4, 0) NOT NULL,
	[cod_nemo] [char](20) NOT NULL,
	[fecha_vcto] [datetime] NOT NULL,
	[nom_nemo] [char](50) NOT NULL,
	[rut_emis] [numeric](9, 0) NULL,
	[tipo_tasa] [numeric](3, 0) NOT NULL,
	[indice_basilea] [numeric](1, 0) NOT NULL,
	[per_cupones] [numeric](2, 0) NOT NULL,
	[num_cupones] [numeric](3, 0) NOT NULL,
	[fecha_emis] [datetime] NOT NULL,
	[afecto_encaje] [char](1) NOT NULL,
	[tasa_emis] [float] NOT NULL,
	[base_tasa_emi] [numeric](3, 0) NOT NULL,
	[tasa_vigente] [float] NOT NULL,
	[fecha_primer_pago] [datetime] NOT NULL,
	[dias_reales] [char](1) NOT NULL,
	[base_flujo] [numeric](3, 0) NOT NULL,
	[tasa_fija] [char](1) NOT NULL,
	[monto_emision] [numeric](19, 4) NOT NULL,
	[monemi] [numeric](5, 0) NOT NULL,
	[monpag] [numeric](5, 0) NOT NULL,
	[tasas_bases] [char](15) NOT NULL,
	[per_capital] [numeric](2, 0) NOT NULL,
	[cod_emis] [numeric](1, 0) NULL,
	[dias_habiles_valor] [numeric](3, 0) NOT NULL,
	[valor_spread] [float] NOT NULL,
	[periodo_tasa] [numeric](5, 0) NOT NULL,
	[Tipo_Cartera] [numeric](3, 0) NOT NULL,
	[IdCurva] [varchar](50) NOT NULL,
	[coltes] [float] NULL,
 CONSTRAINT [PK__text_ser__131DCD43] PRIMARY KEY CLUSTERED 
(
	[Cod_familia] ASC,
	[cod_nemo] ASC,
	[fecha_vcto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__Cod_fa__52AE4273]  DEFAULT (0) FOR [Cod_familia]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__cod_ne__53A266AC]  DEFAULT (' ') FOR [cod_nemo]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__fecha___54968AE5]  DEFAULT (' ') FOR [fecha_vcto]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__nom_ne__558AAF1E]  DEFAULT (' ') FOR [nom_nemo]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__tipo_t__567ED357]  DEFAULT (0) FOR [tipo_tasa]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__indice__5772F790]  DEFAULT (0) FOR [indice_basilea]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__per_cu__58671BC9]  DEFAULT (0) FOR [per_cupones]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__num_cu__595B4002]  DEFAULT (0) FOR [num_cupones]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__fecha___5A4F643B]  DEFAULT (' ') FOR [fecha_emis]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__afecto__5B438874]  DEFAULT (' ') FOR [afecto_encaje]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__tasa_e__5C37ACAD]  DEFAULT (0) FOR [tasa_emis]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__base_t__5D2BD0E6]  DEFAULT (0) FOR [base_tasa_emi]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__tasa_v__5E1FF51F]  DEFAULT (0) FOR [tasa_vigente]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__fecha___5F141958]  DEFAULT (' ') FOR [fecha_primer_pago]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__dias_r__60083D91]  DEFAULT (' ') FOR [dias_reales]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__base_f__60FC61CA]  DEFAULT (0) FOR [base_flujo]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__tasa_f__61F08603]  DEFAULT (' ') FOR [tasa_fija]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__monto___62E4AA3C]  DEFAULT (0) FOR [monto_emision]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__tasas___63D8CE75]  DEFAULT (0) FOR [tasas_bases]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__per_ca__64CCF2AE]  DEFAULT (0) FOR [per_capital]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__dias_h__65C116E7]  DEFAULT (0) FOR [dias_habiles_valor]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF_text_ser_valor_spread]  DEFAULT (0) FOR [valor_spread]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF__text_ser__period__5145E845]  DEFAULT (0) FOR [periodo_tasa]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [DF_text_ser_Tipo_Cartera]  DEFAULT (0) FOR [Tipo_Cartera]
GO
ALTER TABLE [dbo].[text_ser] ADD  CONSTRAINT [dfTextSerBonos_RutUsuario]  DEFAULT ('') FOR [IdCurva]
GO
ALTER TABLE [dbo].[text_ser] ADD  DEFAULT ((0)) FOR [coltes]
GO
ALTER TABLE [dbo].[text_ser]  WITH NOCHECK ADD  CONSTRAINT [FK__text_ser__Cod_fa__4DD47EBD] FOREIGN KEY([Cod_familia])
REFERENCES [dbo].[text_fml_inm] ([Cod_familia])
GO
ALTER TABLE [dbo].[text_ser] CHECK CONSTRAINT [FK__text_ser__Cod_fa__4DD47EBD]
GO
