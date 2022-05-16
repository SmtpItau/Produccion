USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[MDAC0414]    Script Date: 13-05-2022 12:16:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MDAC0414](
	[acrutprop] [numeric](9, 0) NULL,
	[acdigprop] [char](1) NULL,
	[acnomprop] [char](40) NULL,
	[acfecante] [datetime] NULL,
	[acfecproc] [datetime] NULL,
	[acfecprox] [datetime] NULL,
	[acnumoper] [numeric](10, 0) NULL,
	[acsw_pd] [char](1) NULL,
	[acsw_rc] [char](1) NULL,
	[acsw_rv] [char](1) NULL,
	[acsw_co] [char](1) NULL,
	[acsw_dv] [char](1) NULL,
	[acsw_cm] [char](1) NULL,
	[acsw_ptw] [char](1) NULL,
	[acsw_trd] [char](1) NULL,
	[acsw_btw] [char](1) NULL,
	[acsw_mesa] [char](1) NULL,
	[acsw_pc] [char](1) NULL,
	[acsw_fd] [char](1) NULL,
	[acsw_finmes] [char](1) NULL,
	[acfecsbif1] [datetime] NULL,
	[acfecsbif2] [datetime] NULL,
	[ac_maxpap] [numeric](2, 0) NULL,
	[acnom_resoma] [char](40) NULL,
	[acfon_resoma] [char](15) NULL,
	[acdirprop] [char](40) NULL,
	[accomprop] [char](15) NULL,
	[acfecvmer] [datetime] NULL,
	[accomision] [numeric](7, 4) NULL,
	[aciva] [numeric](7, 4) NULL,
	[acrutcomi] [numeric](9, 0) NULL,
	[acdigcomi] [char](1) NULL,
	[acnumlogs] [int] NULL,
	[acpatrimonio] [float] NULL,
	[acsw_mm] [char](1) NULL,
	[acsw_dvprop] [char](1) NOT NULL,
	[acsw_dvci] [char](1) NOT NULL,
	[acsw_dvvi] [char](1) NOT NULL,
	[acsw_dvib] [char](1) NOT NULL,
	[acdirinterfaz] [varchar](60) NOT NULL,
	[ac_ipcmes] [float] NOT NULL,
	[acint_c8] [char](1) NOT NULL,
	[acint_cte] [char](1) NOT NULL,
	[acint_cteii] [char](1) NOT NULL,
	[acint_p17] [char](1) NOT NULL,
	[acint_d3] [char](1) NOT NULL,
	[acint_cli] [char](1) NOT NULL,
	[acint_col] [char](1) NOT NULL,
	[acint_c14] [char](1) NOT NULL,
	[acint_rcc] [char](1) NOT NULL,
	[acint_ges] [char](1) NOT NULL,
	[acsw_ges] [char](1) NOT NULL,
	[acticketmesa] [numeric](10, 0) NOT NULL,
	[acRutBCCH] [numeric](9, 0) NOT NULL,
	[acFPagoBCCH] [numeric](3, 0) NOT NULL,
	[acTipArchUltCargaSOMA] [numeric](1, 0) NOT NULL,
	[NumeroSimulaciones] [float] NOT NULL,
	[acyTotCint] [float] NOT NULL,
	[acyTotVint] [float] NOT NULL,
	[acyUtPeVta] [float] NOT NULL,
	[acyDifPre] [float] NOT NULL,
	[acyCodPro] [float] NOT NULL,
	[acxTotCint] [float] NOT NULL,
	[acxTotVint] [float] NOT NULL,
	[acxUtPeVta] [float] NOT NULL,
	[acxDifPre] [float] NOT NULL,
	[acxCosPro] [float] NOT NULL,
	[Int_Gan] [numeric](18, 0) NOT NULL,
	[Rea_Gan] [numeric](18, 0) NOT NULL,
	[Dif_pre] [numeric](18, 0) NOT NULL,
	[Int_Pag] [numeric](18, 0) NOT NULL,
	[Ut_Per] [numeric](18, 0) NOT NULL,
	[Inter] [numeric](18, 0) NOT NULL,
	[acInt_Gan] [numeric](18, 0) NOT NULL,
	[acRea_Gan] [numeric](18, 0) NOT NULL,
	[acdif_pre] [numeric](18, 0) NOT NULL,
	[acint_pag] [numeric](18, 0) NOT NULL,
	[acut_per] [int] NOT NULL,
	[ac_inter] [int] NOT NULL,
	[ac_swcctb] [numeric](18, 0) NOT NULL,
	[acintraday] [float] NOT NULL,
	[acovernight] [float] NOT NULL,
	[AcPlazoAfs] [numeric](5, 0) NOT NULL,
	[acplazoresidualC8] [int] NOT NULL,
	[acMotorPagoActivo] [char](1) NOT NULL,
	[Int_Gan_Usd] [numeric](18, 2) NOT NULL,
	[accodigobic] [char](15) NOT NULL,
	[servidor_correo] [varchar](100) NOT NULL,
	[emial_logon] [varchar](50) NOT NULL,
	[pass_logon] [varchar](50) NOT NULL,
	[ruta_contrato] [varchar](800) NOT NULL,
	[USD_acyTotCint] [float] NOT NULL,
	[USD_acyTotVint] [float] NOT NULL,
	[USD_acyUtPeVta] [float] NOT NULL,
	[USD_acyDifPre] [float] NOT NULL,
	[USD_acyCodPro] [float] NOT NULL,
	[Rea_Gan_Usd] [numeric](18, 2) NOT NULL,
	[Dif_pre_Usd] [numeric](18, 2) NOT NULL,
	[Int_Pag_Usd] [numeric](18, 2) NOT NULL,
	[Ut_Per_Usd] [numeric](18, 2) NOT NULL,
	[Inter_Usd] [numeric](18, 2) NOT NULL,
	[acInt_Gan_Usd] [numeric](18, 2) NOT NULL,
	[acRea_Gan_Usd] [numeric](18, 2) NOT NULL,
	[acdif_pre_Usd] [numeric](18, 2) NOT NULL,
	[acint_pag_Usd] [numeric](18, 2) NOT NULL,
	[acut_per_Usd] [numeric](18, 2) NOT NULL,
	[ac_inter_usd] [numeric](18, 1) NOT NULL
) ON [PRIMARY]
GO
