USE [BacBonosExtSuda]
GO
/****** Object:  Table [dbo].[text_ctr_inv]    Script Date: 11-05-2022 16:31:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[text_ctr_inv](
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
	[tipo_cartera_financiera] [char](2) NOT NULL,
	[sucursal] [smallint] NOT NULL,
	[calce] [char](1) NOT NULL,
	[tipo_inversion] [char](2) NULL,
	[para_quien] [char](1) NOT NULL,
	[nombre_custodia] [char](30) NOT NULL,
	[forma_pago] [numeric](3, 0) NOT NULL,
	[confirmacion] [numeric](1, 0) NOT NULL,
	[base_tasa] [char](20) NOT NULL,
	[operador_contra] [char](30) NOT NULL,
	[operador_banco] [char](30) NOT NULL,
	[monto_emision] [numeric](19, 4) NOT NULL,
	[corr_cli_nombre] [char](50) NOT NULL,
	[corr_cli_cta] [char](30) NOT NULL,
	[corr_cli_aba] [char](9) NOT NULL,
	[corr_cli_pais] [char](15) NOT NULL,
	[corr_cli_ciud] [char](15) NOT NULL,
	[corr_cli_swift] [char](30) NOT NULL,
	[corr_cli_ref] [char](30) NOT NULL,
	[cpfectraspaso] [datetime] NOT NULL,
	[cpajuste_traspaso] [numeric](19, 4) NOT NULL,
	[cusip] [char](12) NOT NULL,
	[princdia] [numeric](19, 4) NOT NULL,
	[ValorPresentAnt] [numeric](19, 7) NOT NULL,
	[mousuario] [char](20) NOT NULL,
	[Hora] [char](8) NOT NULL,
	[DurMacaulay] [float] NULL,
	[DurModificada] [float] NULL,
	[Convexidad] [float] NULL,
	[Id_Area_Responsable] [char](10) NULL,
	[Id_Libro] [char](10) NULL,
 CONSTRAINT [PK__text_ctr_inv__0F4D3C5F] PRIMARY KEY CLUSTERED 
(
	[cprutcart] ASC,
	[cpnumdocu] ASC,
	[cpcorrelativo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cprut__09746778]  DEFAULT ((0)) FOR [cprutcart]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpnum__0A688BB1]  DEFAULT (' ') FOR [cpnumdocu]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF_text_ctr_inv_cpcorrelativo]  DEFAULT ((1)) FOR [cpcorrelativo]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cod_f__0B5CAFEA]  DEFAULT ((0)) FOR [cod_familia]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cod_n__0C50D423]  DEFAULT (' ') FOR [cod_nemo]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___id_in__0D44F85C]  DEFAULT (' ') FOR [id_instrum]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpnom__0E391C95]  DEFAULT ((0)) FOR [cpnominal]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpnom__0F2D40CE]  DEFAULT ((0)) FOR [cpnomi_vta]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpval__10216507]  DEFAULT ((0)) FOR [cpvalvenc]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpfec__11158940]  DEFAULT (' ') FOR [cpfecneg]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpfec__1209AD79]  DEFAULT (' ') FOR [cpfecpago]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpfec__12FDD1B2]  DEFAULT (' ') FOR [cpfeccomp]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpint__13F1F5EB]  DEFAULT ((0)) FOR [cpint_compra]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cppri__14E61A24]  DEFAULT ((0)) FOR [cpprincipal]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpval__15DA3E5D]  DEFAULT ((0)) FOR [cpvalcomp]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpval__16CE6296]  DEFAULT ((0)) FOR [cpvalcomu]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cptir__17C286CF]  DEFAULT ((0)) FOR [cptircomp]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cppvp__18B6AB08]  DEFAULT ((0)) FOR [cppvpcomp]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpvpc__19AACF41]  DEFAULT ((0)) FOR [cpvpcomp]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpfec__1A9EF37A]  DEFAULT (' ') FOR [cpfecemi]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpfec__1B9317B3]  DEFAULT (' ') FOR [cpfecven]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cptas__1C873BEC]  DEFAULT ((0)) FOR [cptasemi]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpbas__1D7B6025]  DEFAULT ((0)) FOR [cpbasemi]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpvpt__1E6F845E]  DEFAULT ((0)) FOR [cpvptirc]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpcap__1F63A897]  DEFAULT ((0)) FOR [cpcapital]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpint__2057CCD0]  DEFAULT ((0)) FOR [cpinteres]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cprea__214BF109]  DEFAULT ((0)) FOR [cpreajust]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpnum__22401542]  DEFAULT ((0)) FOR [cpnumucup]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpnum__2334397B]  DEFAULT ((0)) FOR [cpnumpcup]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpfec__24285DB4]  DEFAULT (' ') FOR [cpfecucup]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpfec__251C81ED]  DEFAULT (' ') FOR [cpfecpcup]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cptir__2610A626]  DEFAULT ((0)) FOR [cptirmerc]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cppvp__2704CA5F]  DEFAULT ((0)) FOR [cppvpmerc]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpval__27F8EE98]  DEFAULT ((0)) FOR [cpvalmerc]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___encaj__28ED12D1]  DEFAULT (' ') FOR [encaje]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___monto__29E1370A]  DEFAULT ((0)) FOR [monto_encaje]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___tipo___2AD55B43]  DEFAULT (' ') FOR [tipo_cartera_financiera]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___calce__2BC97F7C]  DEFAULT (' ') FOR [calce]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___tipo___2CBDA3B5]  DEFAULT (' ') FOR [tipo_inversion]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___para___2DB1C7EE]  DEFAULT (' ') FOR [para_quien]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___nombr__2EA5EC27]  DEFAULT (' ') FOR [nombre_custodia]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF_text_ctr_inv_forma_pago]  DEFAULT ((0)) FOR [forma_pago]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___confi__2F9A1060]  DEFAULT ((0)) FOR [confirmacion]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___base___308E3499]  DEFAULT ((0)) FOR [base_tasa]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___opera__318258D2]  DEFAULT (' ') FOR [operador_contra]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___opera__32767D0B]  DEFAULT (' ') FOR [operador_banco]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___monto__336AA144]  DEFAULT ((0)) FOR [monto_emision]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___corr___345EC57D]  DEFAULT (' ') FOR [corr_cli_nombre]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___corr___3552E9B6]  DEFAULT (' ') FOR [corr_cli_cta]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___corr___36470DEF]  DEFAULT (' ') FOR [corr_cli_aba]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___corr___373B3228]  DEFAULT (' ') FOR [corr_cli_pais]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___corr___382F5661]  DEFAULT (' ') FOR [corr_cli_ciud]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___corr___39237A9A]  DEFAULT (' ') FOR [corr_cli_swift]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___corr___3A179ED3]  DEFAULT (' ') FOR [corr_cli_ref]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpfec__3B0BC30C]  DEFAULT (' ') FOR [cpfectraspaso]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___cpaju__3BFFE745]  DEFAULT ((0)) FOR [cpajuste_traspaso]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF_text_ctr_inv_cusip]  DEFAULT (' ') FOR [cusip]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF_text_ctr_inv_principaldia]  DEFAULT ((0)) FOR [princdia]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___Valor__4870AB22]  DEFAULT ((0)) FOR [ValorPresentAnt]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr___mousu__08AB2BC8]  DEFAULT ('') FOR [mousuario]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__text_ctr_i__Hora__099F5001]  DEFAULT ('00:00:00') FOR [Hora]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [df_textctrinv_DurMacaulay]  DEFAULT ((0.0)) FOR [DurMacaulay]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [df_textctrinv_DurModificada]  DEFAULT ((0.0)) FOR [DurModificada]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [df_textctrinv_Convexidad]  DEFAULT ((0.0)) FOR [Convexidad]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__TEXT_CTR___Id_Ar__615C547D]  DEFAULT ('') FOR [Id_Area_Responsable]
GO
ALTER TABLE [dbo].[text_ctr_inv] ADD  CONSTRAINT [DF__TEXT_CTR___Id_Li__625078B6]  DEFAULT ('') FOR [Id_Libro]
GO
ALTER TABLE [dbo].[text_ctr_inv]  WITH NOCHECK ADD  CONSTRAINT [FK__text_ctr___cod_f__407A839F] FOREIGN KEY([cod_familia])
REFERENCES [dbo].[text_fml_inm] ([Cod_familia])
GO
ALTER TABLE [dbo].[text_ctr_inv] CHECK CONSTRAINT [FK__text_ctr___cod_f__407A839F]
GO
ALTER TABLE [dbo].[text_ctr_inv]  WITH NOCHECK ADD  CONSTRAINT [FK__text_ctr___cprut__416EA7D8] FOREIGN KEY([cprutcart])
REFERENCES [dbo].[text_arc_ctl_dri] ([acrutprop])
GO
ALTER TABLE [dbo].[text_ctr_inv] CHECK CONSTRAINT [FK__text_ctr___cprut__416EA7D8]
GO
