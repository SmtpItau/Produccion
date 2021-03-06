USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[CAR_ticketbonext]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CAR_ticketbonext](
	[cprutcart] [numeric](9, 0) NOT NULL,
	[cpnumdocu] [char](12) NOT NULL,
	[cpcorrelativo] [numeric](18, 0) NOT NULL,
	[cprutcli] [numeric](9, 0) NOT NULL,
	[cpcodcli] [numeric](9, 0) NOT NULL,
	[cpcodemi] [numeric](1, 0) NULL,
	[cod_familia] [numeric](4, 0) NULL,
	[cod_nemo] [char](20) NOT NULL,
	[id_instrum] [char](20) NOT NULL,
	[cpnominal] [numeric](19, 4) NOT NULL,
	[cpnomi_vta] [numeric](19, 4) NOT NULL,
	[cpvalvenc] [numeric](19, 4) NOT NULL,
	[cpfecneg] [datetime] NOT NULL,
	[cpfecpago] [datetime] NOT NULL,
	[cpfeccomp] [datetime] NOT NULL,
	[cpint_compra] [numeric](19, 4) NOT NULL,
	[cpprincipal] [numeric](19, 4) NOT NULL,
	[cpvalcomp] [numeric](19, 4) NOT NULL,
	[cpvalcomu] [float] NOT NULL,
	[cptircomp] [numeric](19, 7) NOT NULL,
	[cppvpcomp] [numeric](19, 7) NOT NULL,
	[cpvpcomp] [numeric](19, 7) NOT NULL,
	[cpfecemi] [datetime] NOT NULL,
	[cpfecven] [datetime] NOT NULL,
	[cptasemi] [numeric](19, 7) NOT NULL,
	[cpbasemi] [numeric](3, 0) NOT NULL,
	[cprutemi] [numeric](9, 0) NULL,
	[cpmonemi] [numeric](3, 0) NOT NULL,
	[cpmonpag] [numeric](3, 0) NOT NULL,
	[cpvptirc] [numeric](19, 7) NOT NULL,
	[cpcapital] [numeric](19, 4) NOT NULL,
	[cpinteres] [numeric](19, 4) NOT NULL,
	[cpreajust] [numeric](19, 4) NOT NULL,
	[cpnumucup] [numeric](3, 0) NOT NULL,
	[cpnumpcup] [numeric](3, 0) NOT NULL,
	[cpfecucup] [datetime] NOT NULL,
	[cpfecpcup] [datetime] NOT NULL,
	[cptirmerc] [numeric](19, 7) NOT NULL,
	[cppvpmerc] [numeric](19, 7) NOT NULL,
	[cpvalmerc] [numeric](19, 4) NOT NULL,
	[basilea] [numeric](1, 0) NOT NULL,
	[tipo_tasa] [numeric](3, 0) NOT NULL,
	[encaje] [char](1) NOT NULL,
	[monto_encaje] [numeric](19, 4) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[tipo_cartera_financiera] [char](1) NOT NULL,
	[sucursal] [smallint] NULL,
	[tipo_inversion] [char](1) NOT NULL,
	[forma_pago] [numeric](3, 0) NOT NULL,
	[base_tasa] [char](20) NOT NULL,
	[operador_banco] [char](30) NOT NULL,
	[monto_emision] [numeric](19, 4) NOT NULL,
	[cpfectraspaso] [datetime] NOT NULL,
	[cpajuste_traspaso] [numeric](19, 4) NOT NULL,
	[cusip] [char](12) NOT NULL,
	[princdia] [numeric](19, 4) NOT NULL,
	[ValorPresentAnt] [numeric](19, 7) NULL,
	[mousuario] [char](20) NOT NULL,
	[Hora] [char](8) NOT NULL,
	[DurMacaulay] [float] NULL,
	[DurModificada] [float] NULL,
	[Convexidad] [float] NULL,
	[Id_Area_Responsable] [char](10) NULL,
	[Id_Libro] [char](10) NULL,
	[mesa_origen] [smallint] NULL,
	[mesa_destino] [smallint] NULL,
	[cartera_destino] [smallint] NULL,
	[operacion_relacionada] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cprutcart]  DEFAULT (0) FOR [cprutcart]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpnumdocu]  DEFAULT (' ') FOR [cpnumdocu]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpcorrelativo]  DEFAULT (1) FOR [cpcorrelativo]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cod_familia]  DEFAULT (0) FOR [cod_familia]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cod_nemo]  DEFAULT (' ') FOR [cod_nemo]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_id_instrum]  DEFAULT (' ') FOR [id_instrum]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpnominal]  DEFAULT (0) FOR [cpnominal]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpnomi_vta]  DEFAULT (0) FOR [cpnomi_vta]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpvalvenc]  DEFAULT (0) FOR [cpvalvenc]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpfecneg]  DEFAULT (' ') FOR [cpfecneg]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpfecpago]  DEFAULT (' ') FOR [cpfecpago]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpfeccomp]  DEFAULT (' ') FOR [cpfeccomp]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpint_compra]  DEFAULT (0) FOR [cpint_compra]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpprincipal]  DEFAULT (0) FOR [cpprincipal]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpvalcomp]  DEFAULT (0) FOR [cpvalcomp]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpvalcomu]  DEFAULT (0) FOR [cpvalcomu]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cptircomp]  DEFAULT (0) FOR [cptircomp]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cppvpcomp]  DEFAULT (0) FOR [cppvpcomp]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpvpcomp]  DEFAULT (0) FOR [cpvpcomp]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpfecemi]  DEFAULT (' ') FOR [cpfecemi]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpfecven]  DEFAULT (' ') FOR [cpfecven]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cptasemi]  DEFAULT (0) FOR [cptasemi]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpbasemi]  DEFAULT (0) FOR [cpbasemi]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpvptirc]  DEFAULT (0) FOR [cpvptirc]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpcapital]  DEFAULT (0) FOR [cpcapital]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpinteres]  DEFAULT (0) FOR [cpinteres]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpreajust]  DEFAULT (0) FOR [cpreajust]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpnumucup]  DEFAULT (0) FOR [cpnumucup]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpnumpcup]  DEFAULT (0) FOR [cpnumpcup]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpfecucup]  DEFAULT (' ') FOR [cpfecucup]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpfecpcup]  DEFAULT (' ') FOR [cpfecpcup]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cptirmerc]  DEFAULT (0) FOR [cptirmerc]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cppvpmerc]  DEFAULT (0) FOR [cppvpmerc]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpvalmerc]  DEFAULT (0) FOR [cpvalmerc]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_encaje]  DEFAULT (' ') FOR [encaje]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_monto_encaje]  DEFAULT (0) FOR [monto_encaje]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_tipo_cartera_financiera]  DEFAULT (' ') FOR [tipo_cartera_financiera]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_tipo_inversion]  DEFAULT (' ') FOR [tipo_inversion]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_forma_pago]  DEFAULT (0) FOR [forma_pago]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_base_tasa]  DEFAULT (0) FOR [base_tasa]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_operador_banco]  DEFAULT (' ') FOR [operador_banco]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_monto_emision]  DEFAULT (0) FOR [monto_emision]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpfectraspaso]  DEFAULT (' ') FOR [cpfectraspaso]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cpajuste_traspaso]  DEFAULT (0) FOR [cpajuste_traspaso]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cusip]  DEFAULT (' ') FOR [cusip]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_princdia]  DEFAULT (0) FOR [princdia]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_ValorPresentAnt]  DEFAULT (0) FOR [ValorPresentAnt]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_mousuario]  DEFAULT ('') FOR [mousuario]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_Hora]  DEFAULT ('00:00:00') FOR [Hora]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_DurMacaulay]  DEFAULT (0.0) FOR [DurMacaulay]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_DurModificada]  DEFAULT (0.0) FOR [DurModificada]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_Convexidad]  DEFAULT (0.0) FOR [Convexidad]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_Id_Area_Responsable]  DEFAULT ('') FOR [Id_Area_Responsable]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_Id_Libro]  DEFAULT ('') FOR [Id_Libro]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_mesa_origen]  DEFAULT (0) FOR [mesa_origen]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_mesa_destino]  DEFAULT (0) FOR [mesa_destino]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_cartera_destino]  DEFAULT (0) FOR [cartera_destino]
GO
ALTER TABLE [dbo].[CAR_ticketbonext] ADD  CONSTRAINT [DF_CAR_ticketbonext_operacion_relacionada]  DEFAULT (0) FOR [operacion_relacionada]
GO
