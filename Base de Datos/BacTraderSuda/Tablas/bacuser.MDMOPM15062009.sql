USE [BacTraderSuda]
GO
/****** Object:  Table [bacuser].[MDMOPM15062009]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [bacuser].[MDMOPM15062009](
	[mofecpro] [datetime] NOT NULL,
	[morutcart] [numeric](9, 0) NOT NULL,
	[motipcart] [numeric](5, 0) NOT NULL,
	[monumdocu] [numeric](10, 0) NOT NULL,
	[mocorrela] [numeric](3, 0) NOT NULL,
	[monumdocuo] [numeric](10, 0) NOT NULL,
	[mocorrelao] [numeric](3, 0) NOT NULL,
	[monumoper] [numeric](10, 0) NOT NULL,
	[motipoper] [char](3) NOT NULL,
	[motipopero] [char](3) NOT NULL,
	[moinstser] [char](12) NOT NULL,
	[momascara] [char](12) NOT NULL,
	[mocodigo] [numeric](3, 0) NOT NULL,
	[moseriado] [char](1) NOT NULL,
	[mofecemi] [datetime] NOT NULL,
	[mofecven] [datetime] NOT NULL,
	[momonemi] [numeric](3, 0) NOT NULL,
	[motasemi] [numeric](9, 4) NOT NULL,
	[mobasemi] [numeric](3, 0) NOT NULL,
	[morutemi] [numeric](9, 0) NOT NULL,
	[monominal] [numeric](19, 4) NOT NULL,
	[movpresen] [numeric](19, 4) NOT NULL,
	[momtps] [numeric](19, 4) NOT NULL,
	[momtum] [float] NOT NULL,
	[momtum100] [float] NOT NULL,
	[monumucup] [numeric](3, 0) NOT NULL,
	[motir] [numeric](19, 4) NOT NULL,
	[mopvp] [numeric](7, 2) NOT NULL,
	[movpar] [real] NOT NULL,
	[motasest] [numeric](9, 4) NOT NULL,
	[mofecinip] [datetime] NOT NULL,
	[mofecvenp] [datetime] NOT NULL,
	[movalinip] [numeric](19, 4) NOT NULL,
	[movalvenp] [numeric](19, 4) NOT NULL,
	[motaspact] [numeric](9, 4) NOT NULL,
	[mobaspact] [numeric](3, 0) NOT NULL,
	[momonpact] [numeric](3, 0) NOT NULL,
	[moforpagi] [numeric](5, 0) NOT NULL,
	[moforpagv] [numeric](5, 0) NOT NULL,
	[motipobono] [char](1) NOT NULL,
	[mocondpacto] [char](3) NOT NULL,
	[mopagohoy] [char](1) NOT NULL,
	[morutcli] [numeric](9, 0) NOT NULL,
	[mocodcli] [numeric](9, 0) NOT NULL,
	[motipret] [char](1) NOT NULL,
	[mohora] [char](15) NOT NULL,
	[mousuario] [char](15) NOT NULL,
	[moterminal] [char](15) NOT NULL,
	[mocapitali] [numeric](19, 4) NOT NULL,
	[moINTeresi] [numeric](19, 4) NOT NULL,
	[moreajusti] [numeric](19, 4) NOT NULL,
	[movpreseni] [numeric](19, 4) NOT NULL,
	[mocapitalp] [numeric](19, 4) NOT NULL,
	[moINTeresp] [numeric](19, 4) NOT NULL,
	[moreajustp] [numeric](19, 4) NOT NULL,
	[movpresenp] [numeric](19, 4) NOT NULL,
	[motasant] [numeric](19, 4) NOT NULL,
	[mobasant] [numeric](19, 4) NOT NULL,
	[movalant] [numeric](19, 4) NOT NULL,
	[mostatreg] [char](1) NOT NULL,
	[movpressb] [numeric](19, 4) NOT NULL,
	[modifsb] [numeric](19, 4) NOT NULL,
	[monominalp] [numeric](19, 4) NOT NULL,
	[movalcomp] [numeric](19, 4) NOT NULL,
	[movalcomu] [numeric](19, 4) NOT NULL,
	[moINTeres] [numeric](19, 4) NOT NULL,
	[moreajuste] [numeric](19, 4) NOT NULL,
	[moINTpac] [numeric](19, 4) NOT NULL,
	[moreapac] [numeric](19, 4) NOT NULL,
	[moutilidad] [numeric](19, 4) NOT NULL,
	[moperdida] [numeric](19, 4) NOT NULL,
	[movalven] [numeric](19, 4) NOT NULL,
	[mocontador] [numeric](19, 0) NOT NULL,
	[monsollin] [numeric](19, 0) NOT NULL,
	[moobserv] [char](70) NOT NULL,
	[moobserv2] [char](70) NOT NULL,
	[movvista] [numeric](19, 0) NOT NULL,
	[movviscom] [numeric](19, 0) NOT NULL,
	[momtocomi] [numeric](19, 0) NOT NULL,
	[mocorvent] [numeric](5, 0) NOT NULL,
	[modcv] [char](1) NOT NULL,
	[moclave_dcv] [char](10) NOT NULL,
	[mocodexceso] [int] NOT NULL,
	[momtoPFE] [float] NOT NULL,
	[momtoCCE] [float] NOT NULL,
	[moINTermesc] [numeric](19, 4) NOT NULL,
	[moreajumesc] [numeric](19, 4) NOT NULL,
	[moINTermesvi] [numeric](19, 4) NOT NULL,
	[moreajumesvi] [numeric](19, 4) NOT NULL,
	[fecha_compra_original] [datetime] NOT NULL,
	[valor_compra_original] [numeric](19, 4) NOT NULL,
	[valor_compra_um_original] [float] NOT NULL,
	[tir_compra_original] [numeric](19, 4) NOT NULL,
	[valor_par_compra_original] [numeric](19, 6) NOT NULL,
	[porcentaje_valor_par_compra_original] [numeric](8, 4) NOT NULL,
	[codigo_carterasuper] [char](1) NOT NULL,
	[Tipo_Cartera_Financiera] [char](1) NOT NULL,
	[Mercado] [char](1) NOT NULL,
	[Sucursal] [varchar](5) NOT NULL,
	[Id_Sistema] [char](3) NOT NULL,
	[Fecha_PagoMañana] [datetime] NOT NULL,
	[Laminas] [char](1) NOT NULL,
	[Tipo_Inversion] [char](1) NOT NULL,
	[Cuenta_Corriente_Inicio] [char](15) NOT NULL,
	[Cuenta_Corriente_Final] [char](15) NOT NULL,
	[Sucursal_Inicio] [varchar](5) NOT NULL,
	[Sucursal_Final] [varchar](5) NOT NULL,
	[motipoletra] [char](1) NOT NULL,
	[moreserva_tecnica1] [numeric](19, 4) NOT NULL,
	[movalvenc] [numeric](19, 4) NOT NULL,
	[movaltasemi] [numeric](19, 4) NOT NULL,
	[moprimadesc] [numeric](19, 4) NOT NULL,
	[SwImpresion] [numeric](1, 0) NOT NULL,
	[MtoCompraPM] [numeric](21, 4) NOT NULL,
	[MtoVentaPM] [numeric](21, 4) NOT NULL,
	[PagoMañana] [char](1) NOT NULL,
	[SorteoLCHR] [char](1) NOT NULL,
	[Dcrp_Confirmador] [char](1) NOT NULL,
	[Dcrp_Codigo] [numeric](9, 0) NOT NULL,
	[Dcrp_Glosa] [varchar](100) NOT NULL,
	[Dcrp_HoraConfirm] [char](8) NOT NULL,
	[Dcrp_OperConfirm] [char](15) NOT NULL,
	[Dcrp_OpeCnvConfirm] [char](30) NOT NULL,
	[moid_libro] [char](6) NULL
) ON [PRIMARY]
GO
