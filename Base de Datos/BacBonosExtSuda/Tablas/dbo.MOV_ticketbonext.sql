USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[MOV_ticketbonext]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MOV_ticketbonext](
	[mofecpro] [datetime] NOT NULL,
	[morutcart] [numeric](9, 0) NOT NULL,
	[monumoper] [numeric](10, 0) NOT NULL,
	[monumdocu] [numeric](10, 0) NOT NULL,
	[mocorrelativo] [numeric](18, 0) NOT NULL,
	[motipoper] [char](3) NOT NULL,
	[cod_nemo] [char](20) NOT NULL,
	[cod_familia] [numeric](4, 0) NOT NULL,
	[id_instrum] [char](20) NOT NULL,
	[morutcli] [numeric](9, 0) NOT NULL,
	[mocodcli] [numeric](9, 0) NOT NULL,
	[mofecemi] [datetime] NOT NULL,
	[mofecven] [datetime] NOT NULL,
	[mofecneg] [datetime] NOT NULL,
	[momonemi] [numeric](3, 0) NOT NULL,
	[momonpag] [numeric](3, 0) NOT NULL,
	[momontoemi] [numeric](19, 4) NOT NULL,
	[motasemi] [numeric](19, 7) NOT NULL,
	[mobasemi] [numeric](3, 0) NOT NULL,
	[morutemi] [numeric](9, 0) NULL,
	[mofecpago] [datetime] NOT NULL,
	[monominal] [numeric](19, 4) NOT NULL,
	[movpresen] [numeric](19, 4) NOT NULL,
	[movalvenc] [numeric](19, 4) NOT NULL,
	[momtps] [numeric](19, 4) NOT NULL,
	[momtum] [numeric](19, 4) NOT NULL,
	[motir] [numeric](19, 7) NOT NULL,
	[mopvp] [numeric](19, 7) NOT NULL,
	[movpar] [numeric](19, 7) NOT NULL,
	[moint_compra] [numeric](19, 4) NOT NULL,
	[moprincipal] [numeric](19, 4) NOT NULL,
	[movalcomp] [float] NOT NULL,
	[movalcomu] [float] NOT NULL,
	[mointeres] [numeric](19, 4) NOT NULL,
	[moreajuste] [numeric](19, 4) NOT NULL,
	[moutilidad] [numeric](19, 4) NOT NULL,
	[moperdida] [numeric](19, 4) NOT NULL,
	[movalven] [numeric](19, 4) NOT NULL,
	[monumucup] [numeric](3, 0) NOT NULL,
	[monumpcup] [numeric](3, 0) NOT NULL,
	[mousuario] [char](12) NULL,
	[mostatreg] [char](1) NOT NULL,
	[moobserv] [char](70) NOT NULL,
	[basilea] [numeric](1, 0) NOT NULL,
	[tipo_tasa] [numeric](3, 0) NOT NULL,
	[encaje] [char](1) NOT NULL,
	[monto_encaje] [numeric](19, 4) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[tipo_cartera_financiera] [char](1) NOT NULL,
	[sucursal] [smallint] NULL,
	[operador_Banco] [char](30) NOT NULL,
	[tipo_inversion] [char](1) NOT NULL,
	[forma_pago] [numeric](3, 0) NOT NULL,
	[base_tasa] [char](20) NOT NULL,
	[cod_emi] [numeric](1, 0) NULL,
	[mofecucup] [datetime] NOT NULL,
	[mofecpcup] [datetime] NOT NULL,
	[mohoraop] [datetime] NOT NULL,
	[cusip] [char](12) NOT NULL,
	[CapitalPeso] [numeric](24, 0) NOT NULL,
	[InteresPeso] [numeric](24, 0) NOT NULL,
	[SwImpresion] [numeric](1, 0) NOT NULL,
	[movpressb] [float] NOT NULL,
	[modifsb] [float] NOT NULL,
	[Hora] [char](8) NOT NULL,
	[DurMacaulay] [float] NULL,
	[DurModificada] [float] NULL,
	[Convexidad] [float] NULL,
	[Id_Area_Responsable] [char](10) NULL,
	[Id_Libro] [char](10) NULL,
	[mesa_origen] [smallint] NULL,
	[mesa_destino] [smallint] NULL,
	[cartera_destino] [smallint] NULL,
	[operacion_relacionada] [smallint] NULL,
	[correl_relacion] [smallint] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mofecpro]  DEFAULT (' ') FOR [mofecpro]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_morutcart]  DEFAULT (0) FOR [morutcart]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_monumoper]  DEFAULT (' ') FOR [monumoper]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_monumdocu]  DEFAULT (' ') FOR [monumdocu]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mocorrelativo]  DEFAULT (1) FOR [mocorrelativo]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_motipoper]  DEFAULT (' ') FOR [motipoper]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_cod_nemo]  DEFAULT (' ') FOR [cod_nemo]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_cod_familia]  DEFAULT (0) FOR [cod_familia]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_id_instrum]  DEFAULT (' ') FOR [id_instrum]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mofecemi]  DEFAULT (' ') FOR [mofecemi]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mofecven]  DEFAULT (' ') FOR [mofecven]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mofecneg]  DEFAULT (' ') FOR [mofecneg]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_momontoemi]  DEFAULT (0) FOR [momontoemi]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_motasemi]  DEFAULT (0) FOR [motasemi]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mobasemi]  DEFAULT (0) FOR [mobasemi]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mofecpago]  DEFAULT (' ') FOR [mofecpago]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_monominal]  DEFAULT (0) FOR [monominal]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_movpresen]  DEFAULT (0) FOR [movpresen]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_movalvenc]  DEFAULT (0) FOR [movalvenc]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_momtps]  DEFAULT (0) FOR [momtps]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_momtum]  DEFAULT (0) FOR [momtum]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_motir]  DEFAULT (0) FOR [motir]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mopvp]  DEFAULT (0) FOR [mopvp]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_movpar]  DEFAULT (0) FOR [movpar]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_moint_compra]  DEFAULT (0) FOR [moint_compra]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_moprincipal]  DEFAULT (0) FOR [moprincipal]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_movalcomp]  DEFAULT (0) FOR [movalcomp]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_movalcomu]  DEFAULT (0) FOR [movalcomu]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mointeres]  DEFAULT (0) FOR [mointeres]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_moreajuste]  DEFAULT (0) FOR [moreajuste]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_moutilidad]  DEFAULT (0) FOR [moutilidad]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_moperdida]  DEFAULT (0) FOR [moperdida]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_movalven]  DEFAULT (0) FOR [movalven]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_monumucup]  DEFAULT (0) FOR [monumucup]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_monumpcup]  DEFAULT (0) FOR [monumpcup]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mostatreg]  DEFAULT (' ') FOR [mostatreg]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_moobserv]  DEFAULT (' ') FOR [moobserv]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_encaje]  DEFAULT (' ') FOR [encaje]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_monto_encaje]  DEFAULT (0) FOR [monto_encaje]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_tipo_cartera_financiera]  DEFAULT (' ') FOR [tipo_cartera_financiera]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_operador_Banco]  DEFAULT (' ') FOR [operador_Banco]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_tipo_inversion]  DEFAULT (' ') FOR [tipo_inversion]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_base_tasa]  DEFAULT (' ') FOR [base_tasa]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mofecucup]  DEFAULT (' ') FOR [mofecucup]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mofecpcup]  DEFAULT (' ') FOR [mofecpcup]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mohoraop]  DEFAULT (' ') FOR [mohoraop]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_cusip]  DEFAULT (' ') FOR [cusip]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_CapitalPeso]  DEFAULT (0) FOR [CapitalPeso]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_InteresPeso]  DEFAULT (0) FOR [InteresPeso]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_SwImpresion]  DEFAULT (0) FOR [SwImpresion]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_movpressb]  DEFAULT (0) FOR [movpressb]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_modifsb]  DEFAULT (0) FOR [modifsb]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_Hora]  DEFAULT ('00:00:00') FOR [Hora]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_DurMacaulay]  DEFAULT (0.0) FOR [DurMacaulay]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_DurModificada]  DEFAULT (0.0) FOR [DurModificada]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_Convexidad]  DEFAULT (0.0) FOR [Convexidad]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_Id_Area_Responsable]  DEFAULT ('') FOR [Id_Area_Responsable]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_Id_Libro]  DEFAULT ('') FOR [Id_Libro]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mesa_origen]  DEFAULT (0) FOR [mesa_origen]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_mesa_destino]  DEFAULT (0) FOR [mesa_destino]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_cartera_destino]  DEFAULT (0) FOR [cartera_destino]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_operacion_relacionada]  DEFAULT (0) FOR [operacion_relacionada]
GO
ALTER TABLE [dbo].[MOV_ticketbonext] ADD  CONSTRAINT [DF_MOV_ticketbonext_correl_relacion]  DEFAULT (1) FOR [correl_relacion]
GO
