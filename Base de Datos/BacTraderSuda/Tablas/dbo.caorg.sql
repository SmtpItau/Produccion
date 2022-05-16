USE [BacTraderSuda]
GO
/****** Object:  Table [dbo].[caorg]    Script Date: 13-05-2022 12:16:01 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[caorg](
	[CAENTIDAD] [nvarchar](2) NULL,
	[CACARTERA] [nvarchar](3) NULL,
	[CANUMDOCU] [float] NULL,
	[CANUMOPER] [float] NULL,
	[CACORRELA] [float] NULL,
	[CAINSTSER] [nvarchar](10) NULL,
	[CAFECEMIS] [smalldatetime] NULL,
	[CARUTEMIS] [float] NULL,
	[CAGENEMIS] [nvarchar](5) NULL,
	[CAMONEMIS] [float] NULL,
	[CATASEMIS] [float] NULL,
	[CABTSEMIS] [float] NULL,
	[CAFECVCTO] [smalldatetime] NULL,
	[CAFECPCUP] [smalldatetime] NULL,
	[CANOMINAL] [float] NULL,
	[CANOMINALP] [float] NULL,
	[CAVALVENC] [float] NULL,
	[CARUTCLIC] [float] NULL,
	[CACODCLIC] [float] NULL,
	[CAFECCOMP] [smalldatetime] NULL,
	[CAVALCOMP] [float] NULL,
	[CATIRCOMP] [float] NULL,
	[CABTSCOMP] [float] NULL,
	[CAVALCOMU] [float] NULL,
	[CAFECVEND] [smalldatetime] NULL,
	[CARUTCLIV] [float] NULL,
	[CACODCLIV] [float] NULL,
	[CATIRVENT] [float] NULL,
	[CABTRVENT] [float] NULL,
	[CAVALVENP] [float] NULL,
	[CAVALVENU] [float] NULL,
	[CARUTCLIP] [float] NULL,
	[CACODCLIP] [float] NULL,
	[CAFECINIP] [smalldatetime] NULL,
	[CAFECVTOP] [smalldatetime] NULL,
	[CAVALINIP] [float] NULL,
	[CAVALVTOP] [float] NULL,
	[CATASPACT] [float] NULL,
	[CABTSPACT] [float] NULL,
	[CAMONPACT] [float] NULL,
	[CAFORPPCT] [float] NULL,
	[CARETDOCU] [float] NULL,
	[CACOMPROM] [float] NULL,
	[CAPRCVPAR] [float] NULL,
	[CACODIGO] [float] NULL,
	[CAPROG] [nvarchar](7) NULL,
	[CAVPRESEN] [float] NULL,
	[CAINDPAC] [nvarchar](1) NULL,
	[CANUMPAC] [float] NULL,
	[CAVALPARC] [float] NULL,
	[CAVALPARCP] [float] NULL,
	[CANOMIREAL] [float] NULL,
	[CAFORPAGO] [float] NULL,
	[CAFORPAG1] [float] NULL,
	[CASALDAMOR] [float] NULL,
	[CATIPOPER] [nvarchar](3) NULL,
	[CANETTERM] [nvarchar](12) NULL,
	[CANETUSER] [nvarchar](10) NULL,
	[CACOMQUIEN] [nvarchar](5) NULL,
	[CACOND_CI] [nvarchar](5) NULL,
	[CACOND_VI] [nvarchar](5) NULL,
	[CACOND_IT] [nvarchar](1) NULL,
	[CAINST] [nvarchar](6) NULL,
	[COUNT] [float] NULL,
	[RESTA] [float] NULL,
	[OLD_VPTE] [float] NULL,
	[CACODSUC] [nvarchar](3) NULL,
	[VPTE_27] [float] NULL,
	[NOMI_27] [float] NULL,
	[OLD_VCOMP] [float] NULL,
	[VPTE_31] [float] NULL,
	[NOMI_31] [float] NULL,
	[CALET_AST] [smalldatetime] NULL,
	[CAFG_VIV] [nvarchar](2) NULL,
	[CAMARCA] [nvarchar](3) NULL,
	[CARETDOCP] [nvarchar](2) NULL,
	[CATASFIN] [float] NULL,
	[CAEMISOR] [nvarchar](10) NULL,
	[CACODCALC] [nvarchar](10) NULL,
	[CANUMCOR] [nvarchar](3) NULL,
	[CAVALCOM1] [float] NULL,
	[CAOPERADR] [nvarchar](10) NULL,
	[CAPRIMERA] [bit] NOT NULL,
	[CARELAC] [nvarchar](2) NULL,
	[CATASREAL] [float] NULL,
	[CABTSREAL] [float] NULL,
	[CATIPCLI] [float] NULL,
	[CACTACTE] [nvarchar](8) NULL,
	[CAINTERES] [float] NULL,
	[CAREAJUSTE] [float] NULL,
	[CAVALEFEC] [float] NULL,
	[CAVALHOY] [float] NULL,
	[CAVALORIG] [float] NULL,
	[CASUCURSAL] [nvarchar](4) NULL,
	[CAINT_MES] [float] NULL,
	[CAREA_MES] [float] NULL,
	[CAFECCUP] [smalldatetime] NULL,
	[CACORRVENT] [float] NULL,
	[CAVALCOMO] [float] NULL,
	[CACARTORIG] [nvarchar](3) NULL,
	[CACUPCAP] [float] NULL,
	[CACUPINT] [float] NULL,
	[CAINTFINM] [float] NULL,
	[CAREAFINM] [float] NULL,
	[CACUPGAN] [float] NULL,
	[CACUPREA] [float] NULL,
	[CATIRTRAN] [float] NULL,
	[CADIFMCDOP] [float] NULL,
	[CACORRCLIC] [float] NULL,
	[CACORRCLIV] [float] NULL,
	[CACORRCLIP] [float] NULL,
	[CABONOS] [nvarchar](1) NULL,
	[CATC_SBIF] [float] NULL,
	[CADURAT] [float] NULL,
	[CADURAT_M] [float] NULL,
	[CACONVEX] [float] NULL,
	[CACORRES] [nvarchar](4) NULL
) ON [PRIMARY]
GO
