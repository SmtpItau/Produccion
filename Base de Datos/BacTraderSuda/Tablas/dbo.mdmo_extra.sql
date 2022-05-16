USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[mdmo_extra]    Script Date: 13-05-2022 12:16:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[mdmo_extra](
	[mofecpro] [datetime] NULL,
	[morutcart] [numeric](9, 0) NULL,
	[motipcart] [numeric](5, 0) NULL,
	[monumdocu] [numeric](10, 0) NULL,
	[mocorrela] [numeric](3, 0) NULL,
	[monumdocuo] [numeric](10, 0) NULL,
	[mocorrelao] [numeric](3, 0) NULL,
	[monumoper] [numeric](10, 0) NULL,
	[motipoper] [char](3) NULL,
	[motipopero] [char](3) NULL,
	[moinstser] [char](12) NULL,
	[momascara] [char](12) NULL,
	[mocodigo] [numeric](3, 0) NULL,
	[moseriado] [char](1) NULL,
	[mofecemi] [datetime] NULL,
	[mofecven] [datetime] NULL,
	[momonemi] [numeric](3, 0) NULL,
	[motasemi] [numeric](9, 4) NULL,
	[mobasemi] [numeric](3, 0) NULL,
	[morutemi] [numeric](9, 0) NULL,
	[monominal] [numeric](19, 4) NULL,
	[movpresen] [numeric](19, 4) NULL,
	[momtps] [numeric](19, 4) NULL,
	[momtum] [float] NULL,
	[momtum100] [float] NULL,
	[monumucup] [numeric](3, 0) NULL,
	[motir] [numeric](19, 4) NULL,
	[mopvp] [numeric](7, 2) NULL,
	[movpar] [real] NULL,
	[motasest] [numeric](9, 4) NULL,
	[mofecinip] [datetime] NULL,
	[mofecvenp] [datetime] NULL,
	[movalinip] [numeric](19, 4) NULL,
	[movalvenp] [numeric](19, 4) NULL,
	[motaspact] [numeric](9, 4) NULL,
	[mobaspact] [numeric](3, 0) NULL,
	[momonpact] [numeric](3, 0) NULL,
	[moforpagi] [numeric](5, 0) NULL,
	[moforpagv] [numeric](5, 0) NULL,
	[motipobono] [char](1) NULL,
	[mocondpacto] [char](3) NULL,
	[mopagohoy] [char](1) NULL,
	[morutcli] [numeric](9, 0) NULL,
	[mocodcli] [numeric](9, 0) NULL,
	[motipret] [char](1) NULL,
	[mohora] [char](15) NULL,
	[mousuario] [char](15) NULL,
	[moterminal] [char](15) NULL,
	[mocapitali] [numeric](19, 4) NULL,
	[mointeresi] [numeric](19, 4) NULL,
	[moreajusti] [numeric](19, 4) NULL,
	[movpreseni] [numeric](19, 4) NULL,
	[mocapitalp] [numeric](19, 4) NULL,
	[mointeresp] [numeric](19, 4) NULL,
	[moreajustp] [numeric](19, 4) NULL,
	[movpresenp] [numeric](19, 4) NULL,
	[motasant] [numeric](19, 4) NULL,
	[mobasant] [numeric](19, 4) NULL,
	[movalant] [numeric](19, 4) NULL,
	[mostatreg] [char](1) NULL,
	[movpressb] [numeric](19, 4) NULL,
	[modifsb] [numeric](19, 4) NULL,
	[monominalp] [numeric](19, 4) NULL,
	[movalcomp] [numeric](19, 4) NULL,
	[movalcomu] [numeric](19, 4) NULL,
	[mointeres] [numeric](19, 4) NULL,
	[moreajuste] [numeric](19, 4) NULL,
	[mointpac] [numeric](19, 4) NULL,
	[moreapac] [numeric](19, 4) NULL,
	[moutilidad] [numeric](19, 4) NULL,
	[moperdida] [numeric](19, 4) NULL,
	[movalven] [numeric](19, 4) NULL,
	[mocontador] [numeric](19, 0) NULL,
	[monsollin] [numeric](19, 0) NULL,
	[moobserv] [char](70) NULL,
	[moobserv2] [char](70) NULL,
	[movvista] [numeric](19, 0) NULL,
	[movviscom] [numeric](19, 0) NULL,
	[momtocomi] [numeric](19, 0) NULL,
	[mocorvent] [numeric](5, 0) NULL,
	[modcv] [char](1) NULL,
	[moclave_dcv] [char](10) NULL,
	[mocodexceso] [int] NULL,
	[momtoPFE] [float] NULL,
	[momtoCCE] [float] NULL,
	[mointermesc] [numeric](19, 4) NULL,
	[moreajumesc] [numeric](19, 4) NULL,
	[mointermesvi] [numeric](19, 4) NULL,
	[moreajumesvi] [numeric](19, 4) NULL,
	[fecha_compra_original] [datetime] NULL,
	[valor_compra_original] [numeric](19, 4) NULL,
	[valor_compra_um_original] [float] NULL,
	[tir_compra_original] [numeric](19, 4) NULL,
	[valor_par_compra_original] [numeric](19, 6) NULL,
	[porcentaje_valor_par_compra_original] [numeric](8, 4) NULL,
	[codigo_carterasuper] [char](1) NULL,
	[Tipo_Cartera_Financiera] [char](1) NULL,
	[Mercado] [char](1) NULL,
	[Sucursal] [varchar](5) NULL,
	[Id_Sistema] [char](3) NULL,
	[Fecha_PagoMañana] [datetime] NULL,
	[Laminas] [char](1) NULL,
	[Tipo_Inversion] [char](1) NULL,
	[Cuenta_Corriente_Inicio] [char](15) NULL,
	[Cuenta_Corriente_Final] [char](15) NULL,
	[Sucursal_Inicio] [varchar](5) NULL,
	[Sucursal_Final] [varchar](5) NULL,
	[motipoletra] [char](1) NULL,
	[moreserva_tecnica1] [numeric](19, 4) NULL,
	[movalvenc] [numeric](19, 4) NULL,
	[movaltasemi] [numeric](19, 4) NULL,
	[moprimadesc] [numeric](19, 4) NULL,
	[SwImpresion] [numeric](1, 0) NULL,
	[MtoCompraPM] [numeric](21, 4) NULL,
	[MtoVentaPM] [numeric](21, 4) NULL,
	[PagoMañana] [char](1) NULL,
	[SorteoLchr] [char](1) NULL,
	[Dcrp_Confirmador] [char](1) NULL,
	[Dcrp_Codigo] [numeric](9, 0) NULL,
	[Dcrp_Glosa] [varchar](100) NULL,
	[Dcrp_HoraConfirm] [char](8) NULL,
	[Dcrp_OperConfirm] [char](15) NULL,
	[Dcrp_OpeCnvConfirm] [char](30) NULL,
	[id_libro] [char](6) NULL,
	[moTirTran] [numeric](19, 4) NULL,
	[moPvpTran] [numeric](19, 4) NULL,
	[moVPTran] [numeric](19, 4) NULL,
	[moDifTran_MO] [numeric](19, 4) NULL,
	[moDifTran_CLP] [numeric](19, 0) NULL,
	[moDigitador] [char](15) NULL
) ON [PRIMARY]
GO
