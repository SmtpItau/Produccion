USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_INVERSIONES]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_INVERSIONES] (@cFecRep CHAR(08))
AS
BEGIN
	SET NOCOUNT ON ;

	DECLARE @nCont INTEGER,
  		    @nn		    INTEGER,
		    @FechaRep	DATETIME,
		    @Folio_Perfil	INTEGER,
		    @xnumdocu	NUMERIC(10),
            @xcorrela	NUMERIC(05),
            @xcodigo	NUMERIC(5),
	  	    @xinstser	CHAR(12),
            @xmonemi	NUMERIC(3),
	  	    @xfecemi  	DATETIME,
            @xFecVcto	DATETIME, 
            @ntasemi	NUMERIC(9,4),
            @nbasemi	INTEGER, 
	  	    @ntasest	NUMERIC(9,4),
	  	    @xNomiTot	NUMERIC(28,4),
	  	    @nTirComp	NUMERIC(9,4),
		    @nInst		VARCHAR(30),
		    @xRutEmi	NUMERIC(10),
		    @CodCamCond	NUMERIC(3),
		    @cCuentAlt	CHAr(12),
		    @cCuentAlt_2	CHAr(12),
		    @cCtaCosif	CHAR(12),
		    @cCtaCosif_g	CHAR(10),
		    @cCond		CHAR(03),
		    @cTipCart	NUMERIC(05),
		    @anno		INTEGER,
		    @dFecCalc	DATETIME,
		    @cFecComp	DATETIME,
		    @xrutcart	NUMERIC(10),
		    @nReajAnno	FLOAT,
		    @nIntAnno	FLOAT,
		    @nValComu	FLOAT,
		    @ValCapitalUm	FLOAT,
		    @ValCapital	FLOAT,
		    @nUf_Hoy	FLOAT,
	        @nUf_Pag	FLOAT,
		    @nUf_comp	FLOAT,
		    @nTasCont	FLOAT,
		    @cMascara	CHAR(10),	
  		    @nPervcup	INTEGER,
			@nMtoCortes	NUMERIC(19,4),
		    @sSeriado	CHAR(1),
		    @dFecAnoAnt	DATETIME,
		    @dFecMcdo	DATETIME,
		    @ValMcdo	NUMERIC(19,4),
		    @dFecPm		DATETIME,
		    @nFlujo		NUMERIC(19,4),
		    @ValVcto	NUMERIC(19,4),
		    @nCupon		INTEGER,
		    @dUltFecCup	DATETIME,
		    @Fecpcup	DATETIME,
		    @dFeccal	DATETIME,
		    @nIntereses	NUMERIC(19,4),
		    @cFecVta	DATETIME

  	DECLARE @fPvp  FLOAT  ,
	  	    @fMT  FLOAT  ,
	  	    @fMTUM  FLOAT  ,
	  	    @fMT_cien FLOAT  ,
	  	    @fVan  FLOAT  ,
	  	    @fVpar  FLOAT  ,
	  	    @nNumucup INTEGER  ,
	  	    @fIntucup FLOAT  ,
	  	    @fAmoucup FLOAT  ,
	  	    @fSalucup FLOAT  ,
	  	    @nNumpcup INTEGER  ,
	  	    @fIntpcup FLOAT  ,
	  	    @fAmopcup FLOAT  ,
	  	    @fSalpcup FLOAT  ,
	  	    @fDurat  FLOAT  ,
	  	    @fConvx  FLOAT  ,
	  	    @fDurmo  FLOAT  ,
	  	    @nError  INTEGER,
	  	    @cProg CHAR(10),
  	  	    @dFecucup DATETIME,
		    @dFecpcup DATETIME,
		    @nNominalAnt NUMERIC(28,4),
		    @nReajustesDev NUMERIC(19,4),
		    @tc_rep_cnt         CHAR(01),
	    	@DO_TC              FLOAT



CREATE TABLE #TblRelacionPCtasContables(
	[idCodigo] [smallint] NOT NULL,
	[sFamilia] [varchar](6) NOT NULL,
	[iMoneda] [smallint] NOT NULL,
	[idCartera] [varchar](2) NOT NULL,
	[CtaIBS] [varchar](15) NOT NULL,
	[CtaSUPER] [varchar](40) NOT NULL,
	[CtaCOSIF] [varchar](40) NOT NULL,
	[CtaGLCODE] [varchar](40) NOT NULL,
	[CtaCOSIF_GER] [varchar](40) NOT NULL,
	[CtaOTRA1] [varchar](40) NOT NULL,
	[CtaOTRA2] [varchar](40) NOT NULL,
	[CtaOTRA3] [varchar](40) NOT NULL
	) 



INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BCD','998','P','170102006','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BCD','998','T','170102006','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','BONOEX','13',' ','170100011',' ','131854000141',' ',' ',' ',' ','  ');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','BCD','998',' ','170100011','','131854000141','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','BCP','999','','170101002','','131854000301','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','BCU','998','','170101003','','131854000141','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','BTP','999','','170101011','','131854000301','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','BTU','998','','170102007','','131854000141','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','BONOS','999','','170101009','','131854000301','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','BONOS','998','','170102019','','131854000301','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','BONOS','994','','170203007','','131854000101','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','LCHR','999','','170101005','','131854000101','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','LCHR','998','','170102011','','131854000101','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','LCHR','997','','170102012','','131854000101','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','DPF','999','','170101006','','131854000301','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','DPR','998','','170102013','','131854000301','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','DPD','994','','170104009','','131854000301','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('1','BR','999','','170100011',' ','131854000141','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BCP','999','T','170201004','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BCU','998','T','170202006','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BTP','999','T','170201019','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BCX','994','T','170201011','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','PDBC','999','T','170201003','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','PRC','998','T','170202004','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','PRD','994','T','170203004','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','PCX','13','T','170201012','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','CERO','998','T','170202005','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','ZERO','994','T','170203005','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','XERO','13','T','170201013','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BONOS','999','T','170201010','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BONOS','998','T','170202020','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BONOS','994','T','170203008','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','DPF','999','T','170203010','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','DPR','998','P','170201008','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','LCHR','999','T','170202018','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','LCHR','997','T','170203030','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','LCHR','994','T','170201007','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','LCHR','998','T','170202015','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BR','999','P','170201015','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BTU','998','T','170202010','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BONOS','998','A','170302001','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BONOEX','13','T','170201016','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','DPE','142','T','170201020','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','FMUTUO','999','T','170101016','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BCP','999','P','170101004','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BCU','998','P','170102006','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BTP','999','P','170101012','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BCX','994','P','170104004','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','PDBC','999','P','170101003','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','PRC','998','P','170102004','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','PRD','994','P','170103004','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','PCX','13','P','170104005','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','CERO','998','P','170102005','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','ZERO','994','P','170103005','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','XERO','13','P','170104006','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BONOS','999','P','170101010','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BONOS','998','P','170102020','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BONOS','994','P','170103008','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','DPF','999','P','170101008','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','DPR','998','T','170102017','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','LCHR','999','P','170101007','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','LCHR','997','P','170102016','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','LCHR','998','P','170102015','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','LCHR','994','P','170102016','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BR','999','T','170102010','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BTU','998','P','170102008','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BONOS','13','P','170104012','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','BONOEX','13','P','170104014','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','DPE','142','P','170104016','','','','','','','');
INSERT INTO #TblRelacionPCtasContables([idCodigo],[sFamilia],[iMoneda],[idCartera],[CtaIBS],[CtaSUPER],[CtaCOSIF],[CtaGLCODE],[CtaCOSIF_GER],[CtaOTRA1],[CtaOTRA2],[CtaOTRA3])
VALUES('5','FMUTUO','999','P','170101014','','','','','','','');




    SELECT @DO_TC   = isnull(Tipo_Cambio,0)     /* Dolar T/C Rep. Contable */
    FROM  BacParamSuda..VALOR_MONEDA_CONTABLE,MDAC WITH (NOLOCK)
    WHERE Codigo_Moneda = 994 AND Fecha = ACFECPROC
   -- FIN 01
	DECLARE @bFinAno		BIT 
		SET @bFinAno		= 0		
	
	DECLARE @dFecProx		DATETIME
		SET @dFecProx		= (SELECT acfecprox FROM BacTraderSuda.dbo.mdac);
		
	DECLARE @dFecProc		DATETIME
		SET @dFecProc		= (SELECT acfecproc FROM BacTraderSuda.dbo.mdac);		  
/*
		SET @dFecProc		= '20151230' ;
		SET @dFecProx		= '20160102' ;
		
	*/	
		
		IF YEAR(@dFecProc) != YEAR(@dFecProx)		  
		BEGIN
			SET @bFinAno	= 1
			SET @dFecProx	= CONVERT(DATETIME,Str(DATEPART(YEAR,@dFecProc),4)+'1231') 		
		END  
		
	IF @DO_TC=0 
	  BEGIN
         SELECT @tc_rep_cnt = 'N'   /* SE OCUPA T/C OBS */
      END 
	ELSE 
	  BEGIN
		  SELECT @tc_rep_cnt = 'S'   /* SE OCUPA T/C REP CONTABLE */
	  END


    SELECT @FechaRep = CONVERT(DATETIME,@cFecRep)
	DECLARE @contable NUMERIC(19,4)
	SELECT @contable = vmc.Tipo_Cambio
	  FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vmc WHERE vmc.Fecha =@dFecProc  AND vmc.Codigo_Moneda = 994
	   
  /* ________________________________________________________________________________________________________________
     Conformacion de tabla de cartera en base a fecha de solicitud de informacion
     ================================================================================================================  
   */
    DECLARE @tabla varCHAR(100)
    DECLARE @query NVARCHAR(4000)
	  
	IF OBJECT_ID('tempdb..##mdcp') IS NOT NULL
	BEGIN 		    
		DELETE FROM ##mdcp;
	END ELSE BEGIN  
  		SELECT * INTO ##mdcp FROM BacTraderSuda.dbo.mdcp WHERE 1=2;
	END   		

	IF OBJECT_ID('tempdb..##mdvi') IS NOT NULL
	BEGIN 		    
		DELETE FROM ##mdvi;
	END ELSE BEGIN  
  		SELECT * INTO ##mdvi FROM BacTraderSuda.dbo.mdvi WHERE 1=2;
	END   		

	IF OBJECT_ID('tempdb..##mddi') IS NOT NULL
	BEGIN 		    
		DELETE FROM ##mddi;
	END ELSE BEGIN  
  		SELECT * INTO ##mddi FROM BacTraderSuda.dbo.mddi WHERE 1=2;
	END
	

	IF OBJECT_ID('tempdb..##text_ctr_inv') IS NOT NULL
	BEGIN 		    
		DELETE FROM ##text_ctr_inv;
	END ELSE BEGIN  
  		SELECT * INTO ##text_ctr_inv FROM BacBonosExtSuda.dbo.text_ctr_inv WHERE 1=2;
	END
  		 

-->/*	
IF @FechaRep = (SELECT acfecproc FROM BacTraderSuda.dbo.mdac )
	BEGIN
		INSERT INTO ##mdcp  
		SELECT * FROM BacTraderSuda.dbo.mdcp
		
		
		INSERT INTO ##mddi
		([dirutcart],[ditipcart],[dinumdocu],[dicorrela],[dinumdocuo],[dicorrelao],[ditipoper],[diserie],[diinstser],[digenemi],[dinemmon],[dinominal],[ditircomp],[dipvpcomp],[divptirc],[dipvpmcd],[ditirmcd],[divpmcd100],[divpmcd],[divptirci],[difecsal]
		,[dinumucup],[dicapitalc],[diinteresc],[direajustc],[dicapitaci],[diintereci],[direajusci],[dibase],[dimoneda],[diintermes],[direajumes],[codigo_carterasuper],[Tipo_Cartera_Financiera],[Mercado],[Sucursal],[Id_Sistema]
		,[Fecha_PagoMañana],[Laminas],[Tipo_Inversion],[Estado_Operacion_Linea],[ditcinicio],[id_libro],[Tasa_Contrato],[Valor_Contable],[Fecha_Contrato],[Numero_Contrato],[Tipo_Rentabilidad],[Ejecutivo],[Tipo_Custodia],[disenala],[dinomigarantia],[diTasCFdo])
		SELECT 
		[dirutcart],[ditipcart],[dinumdocu],[dicorrela],[dinumdocuo],[dicorrelao],[ditipoper],[diserie],[diinstser],[digenemi],[dinemmon],[dinominal],[ditircomp],[dipvpcomp],[divptirc],[dipvpmcd],[ditirmcd],[divpmcd100],[divpmcd],[divptirci],[difecsal]
		,[dinumucup],[dicapitalc],[diinteresc],[direajustc],[dicapitaci],[diintereci],[direajusci],[dibase],[dimoneda],[diintermes],[direajumes],[codigo_carterasuper],[Tipo_Cartera_Financiera],[Mercado],[Sucursal],[Id_Sistema]
		,[Fecha_PagoMañana],[Laminas],[Tipo_Inversion],[Estado_Operacion_Linea],[ditcinicio],[id_libro],[Tasa_Contrato],[Valor_Contable],[Fecha_Contrato],[Numero_Contrato],[Tipo_Rentabilidad],[Ejecutivo],[Tipo_Custodia],[disenala],[dinomigarantia],[diTasCFdo]
		FROM BacTraderSuda.dbo.mddi
		
		INSERT INTO ##mdvi
		SELECT * FROM BacTraderSuda.dbo.mdvi

		INSERT INTO ##text_ctr_inv 
		SELECT * FROM BacBonosExtSuda.dbo.text_ctr_inv
		
	END 
	ELSE BEGIN
-->	*/	
		SET @tabla = 'bactradersuda.dbo.mdcp' + SUBSTRING(CONVERT(CHAR(8),@FechaRep,112),5,4)
		SET @query =''
		SET @query = @query + 'INSERT INTO ##mdcp('
		SET @query = @query + '[cprutcart],[cptipcart],[cpnumdocu],[cpcorrela],[cpnumdocuo],[cpcorrelao],[cprutcli],[cpcodcli],'
		SET @query = @query + '[cpinstser],[cpmascara],[cpnominal],[cpfeccomp],[cpvalcomp],[cpvalcomu],[cpvcum100],[cptircomp],'
		SET @query = @query + '[cptasest],[cppvpcomp],[cpvpcomp],[cpnumucup],[cpfecemi],[cpfecven],[cpseriado],[cpcodigo],'
		SET @query = @query + '[cpvptirc],[cpcapitalc],[cpinteresc],[cpreajustc],[cpcontador],[cpfecucup],[cpfecpcup],[cpvcompori],'
		SET @query = @query + '[cpdcv],[cpdurat],[cpdurmod],[cpconvex],[cpintermes],[cpreajumes],[fecha_compra_original],[valor_compra_original],'
		SET @query = @query + '[valor_compra_um_original],[tir_compra_original],[valor_par_compra_original],[porcentaje_valor_par_compra_original],'
		SET @query = @query + '[codigo_carterasuper],[Tipo_Cartera_Financiera],[Mercado],[Sucursal],[Id_Sistema],[Fecha_PagoMañana],'
		SET @query = @query + '[Laminas],[Tipo_Inversion],[Estado_Operacion_Linea],[cptipoletra],[cpforpagi],[cpreserva_tecnica],[cpvalvenc],[cpvaltasemi],'
		SET @query = @query + '[cpprimadesc],[cpprimdescacum],[id_libro],[Tasa_Contrato],[Valor_Contable],[Fecha_Contrato],[Numero_Contrato],[Tipo_Rentabilidad],[Ejecutivo],[Tipo_Custodia],[cpsenala],[cpvptasemi],[Valor_a_Diferir],[Capital_Tasa_Emi],[Intereses_Tasa_Emi],[Reajustes_Tasa_Emi],[volcker_rule]) '
		SET @query = @query + 'SELECT '
		SET @query = @query + '[cprutcart],[cptipcart],[cpnumdocu],[cpcorrela],[cpnumdocuo],[cpcorrelao],[cprutcli],[cpcodcli],'
		SET @query = @query + '[cpinstser],[cpmascara],[cpnominal],[cpfeccomp],[cpvalcomp],[cpvalcomu],[cpvcum100],[cptircomp],'
		SET @query = @query + '[cptasest],[cppvpcomp],[cpvpcomp],[cpnumucup],[cpfecemi],[cpfecven],[cpseriado],[cpcodigo],'
		SET @query = @query + '[cpvptirc],[cpcapitalc],[cpinteresc],[cpreajustc],[cpcontador],[cpfecucup],[cpfecpcup],[cpvcompori],'
		SET @query = @query + '[cpdcv],[cpdurat],[cpdurmod],[cpconvex],[cpintermes],[cpreajumes],[fecha_compra_original],[valor_compra_original],'
		SET @query = @query + '[valor_compra_um_original],[tir_compra_original],[valor_par_compra_original],[porcentaje_valor_par_compra_original],'
		SET @query = @query + '[codigo_carterasuper],[Tipo_Cartera_Financiera],[Mercado],[Sucursal],[Id_Sistema],[Fecha_PagoMañana],'
		SET @query = @query + '[Laminas],[Tipo_Inversion],[Estado_Operacion_Linea],[cptipoletra],[cpforpagi],[cpreserva_tecnica],[cpvalvenc],[cpvaltasemi],'
		SET @query = @query + '[cpprimadesc],[cpprimdescacum],[id_libro],[cptircomp],[cpvalcomp],[cpfeccomp],0,' + CHAR(39) +' '+CHAR(39)+ ' ,0,0,0,0,0,0,0,0,0 '
		
		SET @query = @query + 'FROM '+ @tabla
		EXECUTE sp_executesql @query

		
		SET @tabla = 'bactradersuda.dbo.mdvi' + SUBSTRING(CONVERT(CHAR(8),@FechaRep,112),5,4)
		SET @query =''
		SET @query = @query + 'INSERT INTO ##mdvi'
		SET @query = @query + '([virutcart],[vinumdocu],[vicorrela],[vinumoper],[vitipoper],[virutcli],[vicodcli],[viinstser],[vinominal],[vifecinip],[vifecvenp],[vivalinip],[vivalvenp],[vitaspact]'
		SET @query = @query + ',[vibaspact],[vimonpact],[vivptirc],[vivptirci],[vivptirv],[vivptirvi],[vivalcomu],[vivalcomp],[vicapitalv],[viinteresv]'
		SET @query = @query + ',[vireajustv],[viintermesv],[vireajumesv],[vicapitalvi],[viinteresvi],[vireajustvi],[viintermesvi],[vireajumesvi],[vivalvent],[vivvum100]'
		SET @query = @query + ',[vivalvemu],[vitirvent],[vitasest],[vipvpvent],[vivpvent],[vinumucupc],[vinumucupv],[virutemi],[vimonemi],[vifecemi],[vifecven],[vifecucup]'
		SET @query = @query + ',[vicodigo],[vitircomp],[vifeccomp],[viseriado],[vimascara],[vivalinipci],[vivalvenpci],[vifecinipci],[vifecvenpci],[vitaspactci]'
		SET @query = @query + ',[vibaspactci],[viinteresci],[vicorvent],[vinominalp],[viforpagi],[viforpagv],[vicorrvent],[vifecpcup],[vivcompori],[vivpcomp],[vidurat],[vidurmod]'
		SET @query = @query + ',[viconvex],[viintacumcp],[vireacumcp],[viintacumvi],[vireacumvi],[viintacumci],[vireacumci],[fecha_compra_original],[valor_compra_original],[valor_compra_um_original]'
		SET @query = @query + ',[tir_compra_original],[valor_par_compra_original],[porcentaje_valor_par_compra_original],[codigo_carterasuper],[Tipo_Cartera_Financiera],[Mercado],[Sucursal]'
		SET @query = @query + ',[Id_Sistema],[Fecha_PagoMañana],[Laminas],[Tipo_Inversion],[Cuenta_Corriente_Inicio],[Cuenta_Corriente_Final],[Sucursal_Inicio],[Sucursal_Final]'
		SET @query = @query + ',[vivalvenc],[vitcinicio],[id_libro],[Tasa_Contrato],[Valor_Contable],[Fecha_Contrato],[Numero_Contrato],[Tipo_Rentabilidad]'
		SET @query = @query + ',[Ejecutivo],[Tipo_Custodia],[vivptasemi],[vimtoadif],[Capital_Tasa_Emi],[Intereses_Tasa_Emi],[Reajustes_Tasa_Emi],[viTasCFdo])'
		SET @query = @query + ' SELECT '
		SET @query = @query + ' [virutcart],[vinumdocu],[vicorrela],[vinumoper],[vitipoper],[virutcli],[vicodcli],[viinstser],[vinominal],[vifecinip],[vifecvenp],[vivalinip],[vivalvenp],[vitaspact]'
		SET @query = @query + ',[vibaspact],[vimonpact],[vivptirc],[vivptirci],[vivptirv],[vivptirvi],[vivalcomu],[vivalcomp],[vicapitalv],[viinteresv]'
		SET @query = @query + ',[vireajustv],[viintermesv],[vireajumesv],[vicapitalvi],[viinteresvi],[vireajustvi],[viintermesvi],[vireajumesvi],[vivalvent],[vivvum100]'
		SET @query = @query + ',[vivalvemu],[vitirvent],[vitasest],[vipvpvent],[vivpvent],[vinumucupc],[vinumucupv],[virutemi],[vimonemi],[vifecemi],[vifecven],[vifecucup]'
		SET @query = @query + ',[vicodigo],[vitircomp],[vifeccomp],[viseriado],[vimascara],[vivalinipci],[vivalvenpci],[vifecinipci],[vifecvenpci],[vitaspactci]'
		SET @query = @query + ',[vibaspactci],[viinteresci],[vicorvent],[vinominalp],[viforpagi],[viforpagv],[vicorrvent],[vifecpcup],[vivcompori],[vivpcomp],[vidurat],[vidurmod]'
		SET @query = @query + ',[viconvex],[viintacumcp],[vireacumcp],[viintacumvi],[vireacumvi],[viintacumci],[vireacumci],[fecha_compra_original],[valor_compra_original],[valor_compra_um_original]'
		SET @query = @query + ',[tir_compra_original],[valor_par_compra_original],[porcentaje_valor_par_compra_original],[codigo_carterasuper],[Tipo_Cartera_Financiera],[Mercado],[Sucursal]'
		SET @query = @query + ',[Id_Sistema],[Fecha_PagoMañana],[Laminas],[Tipo_Inversion],[Cuenta_Corriente_Inicio],[Cuenta_Corriente_Final],[Sucursal_Inicio],[Sucursal_Final]'
		SET @query = @query + ',[vivalvenc],[vitcinicio],[id_libro],[vitircomp],[vivalcomp],[vifeccomp],0,'+ CHAR(39)+' ' + CHAR(39)
		SET @query = @query + ',0,0,0,0,0,0,0,0 '
		
		
		SET @query = @query + 'FROM '+ @tabla
		EXECUTE sp_executesql @query


		SET @tabla = 'bactradersuda.dbo.mddi' + SUBSTRING(CONVERT(CHAR(8),@FechaRep,112),5,4)
		SET @query =''
		SET @query = @query + 'INSERT INTO ##mddi'
		SET @query = @query + '([dirutcart],[ditipcart],[dinumdocu],[dicorrela],[dinumdocuo],[dicorrelao],[ditipoper],[diserie],[diinstser],[digenemi],[dinemmon],[dinominal],[ditircomp],[dipvpcomp],[divptirc],[dipvpmcd],[ditirmcd],[divpmcd100],[divpmcd],[divptirci],[difecsal]'
		SET @query = @query + ',[dinumucup],[dicapitalc],[diinteresc],[direajustc],[dicapitaci],[diintereci],[direajusci],[dibase],[dimoneda],[diintermes],[direajumes],[codigo_carterasuper],[Tipo_Cartera_Financiera],[Mercado],[Sucursal],[Id_Sistema]'
		SET @query = @query + ',[Fecha_PagoMañana],[Laminas],[Tipo_Inversion],[Estado_Operacion_Linea],[ditcinicio],[id_libro],[Tasa_Contrato],[Valor_Contable],[Fecha_Contrato],[Numero_Contrato],[Tipo_Rentabilidad],[Ejecutivo],[Tipo_Custodia],[disenala],[dinomigarantia],[diTasCFdo])'
		SET @query = @query + ' SELECT '
		SET @query = @query + ' [dirutcart],[ditipcart],[dinumdocu],[dicorrela],[dinumdocuo],[dicorrelao],[ditipoper],[diserie],[diinstser],[digenemi],[dinemmon],[dinominal],[ditircomp],[dipvpcomp],[divptirc],[dipvpmcd],[ditirmcd],[divpmcd100],[divpmcd],[divptirci],[difecsal]'
		SET @query = @query + ',[dinumucup],[dicapitalc],[diinteresc],[direajustc],[dicapitaci],[diintereci],[direajusci],[dibase],[dimoneda],[diintermes],[direajumes],[codigo_carterasuper],[Tipo_Cartera_Financiera],[Mercado],[Sucursal],[Id_Sistema]'
		SET @query = @query + ',[Fecha_PagoMañana],[Laminas],[Tipo_Inversion],[Estado_Operacion_Linea],[ditcinicio],[id_libro],[ditircomp],[divptirc],Fecha_PagoMañana,0,0,0,1,0,0,0 '
		
		
		SET @query = @query + 'FROM '+ @tabla
		EXECUTE sp_executesql @query
		
		
		INSERT INTO ##text_ctr_inv
		([cprutcart],[cpnumdocu],[cpcorrelativo],[cprutcli],[cpcodcli],[cpcodemi],[cod_familia],[cod_nemo],[id_instrum],[cpnominal]
		,[cpnomi_vta],[cpvalvenc],[cpfecneg],[cpfecpago],[cpfeccomp],[cpint_compra],[cpprincipal],[cpvalcomp],[cpvalcomu],[cptircomp],[cppvpcomp],[cpvpcomp]
		,[cpfecemi],[cpfecven],[cptasemi],[cpbasemi],[cprutemi],[cpmonemi],[cpmonpag],[cpvptirc],[cpcapital],[cpinteres],[cpreajust],[cpnumucup],[cpnumpcup],[cpfecucup]
		,[cpfecpcup],[cptirmerc],[cppvpmerc],[cpvalmerc],[basilea],[tipo_tasa],[encaje],[monto_encaje],[codigo_carterasuper],[tipo_cartera_financiera]
		,[sucursal],[calce],[tipo_inversion],[para_quien],[nombre_custodia],[forma_pago],[confirmacion],[base_tasa],[operador_contra],[operador_banco]
		,[monto_emision],[corr_cli_nombre],[corr_cli_cta],[corr_cli_aba],[corr_cli_pais],[corr_cli_ciud],[corr_cli_swift],[corr_cli_ref],[cpfectraspaso],[cpajuste_traspaso]
		,[cusip],[princdia],[ValorPresentAnt],[mousuario],[Hora],[DurMacaulay],[DurModificada],[Convexidad],[Id_Area_Responsable],[Id_Libro])

		SELECT 
		 [rsrutcart],[rsnumdocu],[rscorrelativo],[rsrutcli],[rscodcli],[rscodemi],cc.cod_familia,cc.cod_nemo,cc.id_instrum,[rsnominal]
		,[rsnominal],[rsvalvenc],[rsfecneg],[rsfecpago],[rsfeccomp],[rsint_compra],[rsprincipal],[rsvalcomu],[rsvalcomu], tmd.motir, tmd.mopvp,tmd.mopvp
		,tmd.mofecemi,tmd.mofecven,[rstasemi],[rsbasemi],tmd.morutemi,[rsmonemi],tmd.momonpag, cc.rsvppresenx, [rsvalcomu],[rsinteres],0,[rsnumucup],[rsnumpcup],[rsfecucup]
		,tmd.mofecucup,0,0,0,tmd.basilea,cc.tipo_tasa,cc.encaje,0,cc.codigo_carterasuper,cc.tipo_cartera_financiera
		,CC.sucursal,cc.calce,[tipo_inversion],[para_quien],[nombre_custodia],[forma_pago],[confirmacion],[base_tasa],0,cc.operador_banco
		,0,cc.corr_cli_nombre,cc.corr_cli_cta,cc.corr_cli_aba,cc.corr_cli_pais,cc.corr_cli_ciud,cc.corr_cli_swift,cc.corr_cli_ref,0,0
		,[cusip],0,cc.rsvppresen [ValorPresentAnt],[mousuario],[Hora],cc.DurMacaulay,cc.DurModificada,cc.Convexidad,[Id_Area_Responsable], tmd.Id_Libro
		FROM BacBonosExtSuda.dbo.text_rsu cc
		 INNER JOIN BacBonosExtSuda.dbo.text_mvt_dri tmd 
		 ON tmd.monumdocu =  cc.rsnumdocu
		AND tmd.monumoper = cc.rsnumoper
		AND tmd.mocorrelativo = cc.rscorrelativo
	   AND tmd.motipoper ='CP'	 
		WHERE rsfecpro = @FechaRep
END 

	
	
--> SELECT '1'	

	-- QUERY I - ***
	SELECT   'fechaProceso'	        = @FechaRep 	
		   , 'Sistema'	            = 'BTR' 
		   ,  'cprutcart'	        = cprutcart 
	       , 'cpnumdocu'	        = cpnumdocu
		   , 'cpcorrela'	        = cpcorrela
		   , 'cptipcart'	        = cptipcart
		   , 'Fecproc'              = @FechaRep
		   , 'CodOrigen'            = 'RNIII'
		   , 'inserie'              =  CONVERT(VARCHAR(30), b.inserie) 
		   , 'CodEmpresa'           = '0769'
		   , 'FecEmi'               = CASE WHEN cpseriado = 'S' THEN (SELECT ISNULL(sefecemi, '19000101') FROM VIEW_SERIE    WITH (NOLOCK) Where   semascara =  MDCP.cpmascara)
		    				      	 					        ELSE (SELECT ISNULL(nsfecemi, '19000101') FROM VIEW_NOSERIE  WITH (NOLOCK) Where nsrutcart = cprutcart AND nsnumdocu =  MDCP.cpnumdocu AND nscorrela = MDCP.cpcorrela)
							          END
	       , 'cpfeccomp'            = cpfeccomp
		   , 'fecvenc'              = CASE WHEN cpseriado = 'S' THEN cpfecpcup
							                                    ELSE (SELECT nsfecven FROM VIEW_NOSERIE  WITH (NOLOCK) WHERE nsrutcart = MDCP.cprutcart AND nsnumdocu = MDCP.cpnumdocu AND nscorrela = MDCP.cpcorrela)
				   		              END
		   , 'mnnemo'		        =  d.mnnemo
		   , 'TasEmi'		        = CASE WHEN cpseriado = 'S' THEN (SELECT setasemi FROM VIEW_SERIE  WITH (NOLOCK) WHERE semascara = MDCP.cpmascara )
		   					      	 						 ELSE cptircomp
		   				              END
	      ,  'Emisor'		        = (SELECT Emnombre from view_emisor WHERE emrut = (CASE WHEN cpseriado = 'S' THEN ( SELECT serutemi 
							    																					    FROM VIEW_SERIE WITH (NOLOCK)
							    																					    WHERE  semascara = cpmascara) 
							    																			     ELSE (SELECT nsrutemi 
							    																			            FROM VIEW_NOSERIE WITH (NOLOCK)
							    																			    		WHERE nsrutcart = MDCP.cprutcart AND nsnumdocu = MDCP.cpnumdocu AND nscorrela = MDCP.cpcorrela) 
							    													 END))
		   , 'CodEmisor'            = '0000'
		   , 'Rutemi'               = CASE WHEN cpseriado = 'S' THEN (SELECT serutemi FROM VIEW_SERIE    WITH (NOLOCK) WHERE  semascara = MDCP.cpmascara )
							      	 						    ELSE (SELECT nsrutemi FROM VIEW_NOSERIE  WITH (NOLOCK) WHERE nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela)
		                              END
		                              
		  , 'CalJur'                = '  '
		  , 'Pais'                  = CONVERT(VARCHAR(50),'')
		  , 'Cartera'               = CASE WHEN mdcp.codigo_carterasuper = 'P' THEN 'AV'
									       WHEN mdcp.codigo_carterasuper = 'A' THEN 'HD'
									       WHEN mdcp.codigo_carterasuper = 'T' THEN 'TR'
										   ELSE 'TR'										    
							          END
		   , 'Valcomp'		        = ISNULL(MDCP.Valor_Contable,0) -- VGS 03/01/2008 cpvalcomp,
		   , 'ValCapital'		    = ISNULL(MDCP.Valor_Contable,0) -- VGS 03/01/2008 cpvalcomp,
		   , 'InteresDev'	        = ISNULL(CONVERT(FLOAT,0),0)
		   , 'Cosif'		        = SPACE(12)
		   , 'Cosif_Ger'	        = SPACE(12)
		   , 'ValMdo'	            = CONVERT(NUMERIC(19,4),0)
		   , 'Util_Mercado'         = CONVERT(NUMERIC(19,4),0)
		   , 'Perd_Mercado'         = CONVERT(NUMERIC(19,4),0)
		   , 'InteresDevAno'	    = ISNULL(CONVERT(NUMERIC(19,4),0),0)
		   , 'ReajustesDevAno'      = CONVERT(NUMERIC(19,4),0)
		   , 'DifMercano'		    = CONVERT(NUMERIC(19,4),0)
		   , 'ValcompAno'           = CASE WHEN YEAR(cpfeccomp) = YEAR(@FechaRep) THEN ISNULL(MDCP.Valor_Contable,0) ELSE ISNULL(CONVERT(NUMERIC(19,4),0),0) END
		   , 'ValorVenta'		    = CONVERT(NUMERIC(19,4),0)
		   , 'InteresesporVenta'    = CONVERT(NUMERIC(19,4),0)
		   , 'UtilporVenta'         = CONVERT(NUMERIC(19,4),0)
		   , 'monedaor'             = 'CLP'
		   , 'CtaAltamira'          = SPACE(12)
		   , 'cpinstser'		    = CONVERT(VARCHAR(30),cpinstser)
		   , 'dimoneda'			    = dimoneda
		   , 'Flag'				    = IDENTITY(INT,1,1)
		   , 'Prog'                 = 'SP_'+ b.inprog
		   , 'cpcodigo'             = cpcodigo
		   , 'difecsal'             = MDDI.difecsal
		   , 'BasEmi'               = CASE WHEN MDCP.cpseriado = 'S' THEN (SELECT sebasemi FROM VIEW_SERIE   WHERE cpmascara = semascara)
		   											  	             ELSE (SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsrutcart = MDCP.cprutcart AND nsnumdocu = MDCP.cpnumdocu AND nscorrela = MDCP.cpcorrela)
		   						      END
		   , 'cpnominal'            = cpnominal
		   , 'cptircomp'            = cptircomp
		   , 'cpvalcomu'            = cpvalcomu
		   , 'Valor_Contable'       = mdcp.Valor_Contable
		   , 'Tasa_Contrato'        = mdcp.Tasa_Contrato	
		   , 'cpmascara'            = CONVERT(VARCHAR(20),cpmascara)
		   , 'cpseriado'            =  cpseriado
		   , 'Fecha_PagoMañana'     = CASE WHEN mdcp.cpfeccomp < CONVERT(DATETIME,'20070115') THEN MDCP.Fecha_PagoMañana ELSE MDCP.cpfeccomp END
		   , 'cpfecpcup'		    = cpfecpcup
		   , 'cpFecucup'		    = cpFecucup
		   , 'Pendiente_Pago'       = CASE WHEN mdcp.Fecha_PagoMañana <= @FechaRep THEN 'N' ELSE 'S' END
		   , 'Codigo_Producto'      = CASE WHEN cpcodigo = 98 THEN 33 ELSE 29 END   
		   , 'Monto_Pago'           = CASE WHEN mdcp.Fecha_PagoMañana <= @FechaRep THEN CONVERT(NUMERIC(17,2),0) ELSE MDCP.cpnominal END
		   , 'Rut_Cliente'          = CASE WHEN mdcp.Fecha_PagoMañana <= @FechaRep  THEN CONVERT(NUMERIC(30),0)
																				   ELSE (CASE WHEN cpseriado = 'S' THEN (SELECT serutemi
																												 FROM VIEW_SERIE WHERE  semascara = MDCP.cpmascara)
		                																						   ELSE (SELECT nsrutemi
																														 FROM VIEW_NOSERIE 
																														 WHERE nsrutcart = MDCP.cprutcart AND nsnumdocu = MDCP.cpnumdocu AND nscorrela = MDCP.cpcorrela)
																												   END)
																					      END
		   ,'PERIODICIDAD'          = CASE WHEN b.inserie = 'BCP'  THEN 'SEMESTRAL' 
						     			   WHEN b.inserie = 'BCU'  THEN 'SEMESTRAL' 					
						     			   WHEN b.inserie = 'BTP'  THEN 'SEMESTRAL' 
						     			   WHEN b.inserie = 'BTU'  THEN 'SEMESTRAL' 
						     			   WHEN b.inserie = 'PRC'  THEN 'SEMESTRAL'
						     			   WHEN b.inserie = 'LCHR' THEN 'TRIMESTRAL'
						     			   WHEN b.inserie = 'BONOS'THEN 'SEMESTRAL'
						     			   WHEN b.inserie = 'BR'   THEN 'OUTRO'
						     			   WHEN b.inserie = 'CERO' THEN 'OUTRO'
						     			   WHEN b.inserie = 'DPF'  THEN 'OUTRO'
						     			   WHEN b.inserie = 'DPR'  THEN 'OUTRO'
						     			   WHEN b.inserie = 'PDBC' THEN 'OUTRO'
						     			   WHEN b.inserie = 'DPX'  THEN 'OUTRO'
						     			   ELSE 'OUTRO'
		                              END
			,'dvEmisor' = ' ' 					                              
	INTO #PASO 			
	FROM 	##MDCP mdcp WITH (NOLOCK),  ##MDDI mddi WITH (NOLOCK), view_instrumento b WITH (NOLOCK) , view_moneda d WITH (NOLOCK)
	WHERE   cpcodigo = b.incodigo
		AND cpnumdocu = dinumdocu
		AND cpcorrela = dicorrela
		AND cprutcart = dirutcart
		AND d.mncodmon = MDDI.dimoneda



	UPDATE #PASO
	SET	 CalJur = 
			CASE 
			WHEN cltipcli = 8 THEN 'PF'
			WHEN cltipcli = 1 THEN 'IF'
			WHEN cltipcli = 2 THEN 'IF'
			WHEN cltipcli = 3 THEN 'IF'
			WHEN cltipcli = 4 THEN 'IF'
			WHEN cltipcli = 5 THEN 'IF'
			WHEN cltipcli = 6 THEN 'IF'
			WHEN cltipcli = 7 THEN 'PJ'
			WHEN cltipcli = 9 THEN 'PJ'
			WHEN cltipcli = 10 THEN 'PJ'
			WHEN cltipcli = 11 THEN 'PJ'
			WHEN cltipcli = 12 THEN 'PJ'
			WHEN cltipcli = 13 THEN 'PJ'
			ELSE  'PJ'
		END 
		, Pais   = COD_ITAU
		,dvEmisor = cldv
	FROM VIEW_CLIENTE,BACPARAMSUDA.DBO.PAIS 
	WHERE clrut = Rutemi AND clpais = codigo_pais

	
	SELECT   'virutcart' = virutcart
		    ,'vinumdocu' = vinumdocu
		    ,'vicorrela' = vicorrela
		    ,'vivalcomp' = SUM(ISNULL(vivalcomp,0))
		    ,'vivalcomu' = SUM(ISNULL(vivalcomu,0))
		    ,'vinominal' = SUM(ISNULL(vinominal,0))
		    ,'VContable' = SUM(ISNULL(VContable,0))
	INTO #TmpVi
	FROM 	
		(SELECT   'virutcart' = virutcart
				,'vinumdocu' = vinumdocu
				,'vicorrela' = vicorrela
				,'vivalcomp' = case when Valor_Contable =0 THEN vivalcomp ELSE Valor_Contable  END  
				,'vivalcomu' = case when Valor_Contable =0 THEN vivalcomp ELSE Valor_Contable  END
				,'vinominal' = vinominal
				,'VContable' = case when Valor_Contable =0 THEN vivalcomp ELSE Valor_Contable  END
		FROM 	##MDVI 
		UNION  all
		SELECT   'virutcart' = rsrutcart
				,'vinumdocu' = rsnumdocu
				,'vicorrela' = rscorrela
				,'vivalcomp' = case when Valor_Contable = 0 THEN rsvalcomp ELSE Valor_Contable   END 
				,'vivalcomu' = case when Valor_Contable = 0 THEN rsvalcomp ELSE Valor_Contable END 
				,'vinominal' = rsnominal
				,'VContable' = case when Valor_Contable = 0 THEN rsvalcomp ELSE Valor_Contable END 
		FROM BacTraderSuda.dbo.mdrs 
		WHERE rscartera=159 AND rsfecha = @dFecProx --@FECHAREP
		) AS Tbl
	GROUP BY virutcart,vinumdocu,vicorrela 



	
	
	UPDATE #PASO
	SET     Valcomp    = ISNULL(Valcomp    + vivalcomp,0)
		   ,ValCapital = ISNULL(ValCapital + vivalcomu,0)
		   ,ValcompAno = ValcompAno + (CASE WHEN YEAR(cpfeccomp) = YEAR(@FechaRep) THEN ISNULL(Valor_Contable,0) ELSE 0 END)
		   ,cpnominal  = ISNULL(cpnominal  + vinominal,0)
		   ,cpvalcomu  = ISNULL(cpvalcomu  + vivalcomu,0)
		   ,Valor_Contable = Valor_Contable + VContable
	FROM	#TmpVi WITH (NOLOCK)
	WHERE 	cprutcart = virutcart AND cpnumdocu = vinumdocu AND cpcorrela = vicorrela 
	
	DELETE #PASO WHERE cpnominal=0
	
	SELECT  'rmrutcart'  = rmrutcart
		   ,'rmnumdocu'  = rmnumdocu
		   ,'rmcorrela'  = rmcorrela
		   ,'rmvalmcdo'  = SUM(valor_mercado)
		   ,'rmdifmcdop' = SUM(CASE WHEN diferencia_mercado > 0 THEN diferencia_mercado ELSE 0 END)
		   ,'rmdifmcdon' = SUM(CASE WHEN diferencia_mercado < 0 THEN ABS(diferencia_mercado) ELSE 0 END)
	INTO   #TmpViMtm
	FROM 	VALORIZACION_MERCADO vm WITH (NOLOCK)
	WHERE 	Fecha_Valorizacion = @FECHAREP --CASE WHEN @bFinAno=0 THEN @FechaRep ELSE @dFecProx END /*@FECHAREP*/ 
	AND
		    tipo_operacion IN ( 'VI','CG') 
	GROUP BY rmrutcart,rmnumdocu,rmcorrela

	

	UPDATE #PASO
	SET ValMdo        = valor_mercado,
		Util_Mercado  = CASE WHEN diferencia_mercado > 0 THEN diferencia_mercado ELSE 0 END,
		Perd_Mercado  = CASE WHEN diferencia_mercado < 0 THEN Abs(diferencia_mercado) ELSE 0 END
	FROM VALORIZACION_MERCADO vm WITH (NOLOCK)
	WHERE Fecha_Valorizacion = @FechaRep --> @FECHAREP--CASE WHEN @bFinAno=0 THEN @FechaRep ELSE @dFecProx END /*@FECHAREP*/ 
	AND
		  rmrutcart = cprutcart AND
		  rmnumdocu = cpnumdocu AND
		  rmnumoper = cpnumdocu AND
		  rmcorrela = cpcorrela AND
		  tipo_operacion = 'CP'

	UPDATE #PASO
	SET  ValMdo       = ValMdo + rmvalmcdo ,
		 Util_Mercado = Util_Mercado + rmdifmcdop,
		 Perd_Mercado = Perd_Mercado + rmdifmcdon
	FROM #TmpViMtm WITH (NOLOCK)
	WHERE 	rmrutcart = cprutcart AND
		rmnumdocu = cpnumdocu AND
		rmcorrela = cpcorrela


 
  	SELECT @nCont = Max(Flag) From #PASO
  	SELECT @nn    = Min(Flag) From #PASO
	
   	WHILE @nn <= @nCont
   	BEGIN
		SELECT 	@xnumdocu = cpnumdocu,
          		@xcorrela = cpcorrela,
          		@cProg    = Prog,
          		@xcodigo  = cpcodigo,
	  		    @xinstser = cpinstser,
          		@xmonemi  = dimoneda,
	  		    @xfecemi  = FecEmi,
          		@xFecVcto = difecsal, 
          		@ntasemi  = TasEmi,
          		@nbasemi  = BasEmi, 
	  		    @ntasest  = 0,
	  		    @xNomiTot = cpnominal,
	  		    @nTirComp = cptircomp,
			    @nInst	  = inserie,
			    @xRutEmi  = Rutemi,
			    @cTipCart = cptipcart,
			    @cFecComp = cpfeccomp,
			    @nValComu = cpvalcomu,
			    @xrutcart = cprutcart,
			    @ValCapital = Valor_Contable,
			    @nTasCont   = Tasa_Contrato,
			    @cMascara   = cpmascara,
			    @sSeriado   = cpseriado,
			    @dFecPm	    = Fecha_PagoMañana,
			    @Fecpcup    = cpFecpcup,
			    @dFecucup   = cpfecucup
		FROM #PASO WITH (NOLOCK)
		WHERE Flag = @nn



		/* Rescata Cuentas Contables Brasil*/
/********************************************************************************************		
   	    	SELECT 	@Folio_Perfil	   = 0
   	    	
			 SELECT @Folio_Perfil      = Folio_Perfil
    	     FROM  	VIEW_PERFIL_CNT WITH (NOLOCK)
   	    	 WHERE 	ID_Sistema		   = 'BTR'   AND
   		  			Tipo_Movimiento    = 'TMF'   AND
   	 	  			Tipo_Operacion     = 'TMCP'    AND
   	 	  			Codigo_Instrumento = @nInst  AND
   	  	  			Moneda_Instrumento = @xmonemi

   	    	SELECT @CodCamCond = 0
   	    	SET ROWCOUNT 1
   	    	SELECT @CodCamCond = ISNULL(Codigo_Campo_Condicion,0) FROM view_tabla_glcode WHERE Codigo_Transaccion = @Folio_Perfil   
  	    	SET ROWCOUNT 0
*********************************************************************************************/
   	    	SELECT  @cCuentAlt   = ''
			      , @cCtaCosif   = ''
				  , @cCtaCosif_g = ''


			SELECT @cCuentAlt   = tCC.CtaIBS,
				   @cCtaCosif   = tCC.CtaCOSIF,
				   @cCtaCosif_g = tCC.CtaCOSIF_GER,
				   @cCuentAlt_2 = tcc.CtaOTRA1
			  FROM #TblRelacionPCtasContables tCC
			WHERE tCC.idCodigo = 1
			 AND tCC.sFamilia =@nInst
			 AND tCC.iMoneda =  @xmonemi  
			 -->AND tCC.idCartera = @cTipCart
		
/********************************************************************************************
			IF @CodCamCond > 0 
			BEGIN
   	  			SELECT   @cCuentAlt    = Cuenta_Altamira
				       , @cCuentAlt_2  = Cuenta_Altamira_per
					   , @cCtaCosif    = Cuenta_Cosif
					   , @cCtaCosif_g  = Cuenta_Cosif_Ger
   	  			FROM    view_tabla_glcode   WITH (NOLOCK)
   	  			WHERE 	Codigo_Transaccion     = @Folio_Perfil AND 
	              		Codigo_Campo_Condicion = @CodCamCond AND
	              		Codigo_Condicion       = @cTipCart
   	        END
********************************************************************************************/			

		UPDATE #PASO
		SET	Cosif	    = @cCtaCosif,
			Cosif_Ger   = @cCtaCosif_g,
			CtaAltamira = CASE WHEN Perd_Mercado > 0 THEN ISNULL(@cCuentAlt_2,0) ELSE ISNULL(@cCuentAlt,0) END
		WHERE Flag = @nn

		/*Calculo de Intereses Devengados en el año o desde la fecha de compra si el instrumento fuen comprado en el año */
		IF YEAR(@cFecComp) = YEAR(@cFecRep) 
		  BEGIN
			SELECT @dFecCalc = @cFecComp
		  END 
		 ELSE 
		  BEGIN
			SELECT @anno = YEAR(@cFecRep)-1
			SELECT @dFecCalc = CONVERT(DATETIME,Str(@anno,4)+'1231')
		  END

		IF @tc_rep_cnt = 'S' AND @xmonemi= 994	
		BEGIN
					SELECT @nUf_Hoy  =  Tipo_Cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK) WHERE Codigo_Moneda = @xmonemi and Fecha = @cFecRep
	            	SELECT @nUf_Pag  =  Tipo_Cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK) WHERE Codigo_Moneda = @xmonemi and Fecha = @dFecCalc
	            	SELECT @nUf_comp = Tipo_Cambio  FROM BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK) WHERE Codigo_Moneda  = (CASE WHEN @cFecComp < CONVERT(DATETIME,'20070115') THEN @dFecPm 
																																										ELSE @cFecComp END) and Codigo_Moneda = @xmonemi
	     END 
		 ELSE 
		 BEGIN 

					SELECT @nUf_Hoy  =  vmvalor FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) WHERE vmcodigo = @xmonemi and Vmfecha = @cFecRep
        	    	SELECT @nUf_Pag  =  vmvalor FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) WHERE vmcodigo = @xmonemi and Vmfecha = @dFecCalc
            		SELECT @nUf_comp =  CASE WHEN @xmonemi in(999,13) THEN 1 ELSE ISNULL((SELECT vmvalor 
																						  FROM BacParamSuda..VALOR_MONEDA
																						  WHERE vmfecha =(CASE WHEN @cFecComp < CONVERT(DATETIME,'20070115') THEN @dFecPm 
																																							 ELSE @cFecComp END) and vmcodigo=@xmonemi),1) END
		 END
	 
	     	IF @xmonemi = 13 OR @xmonemi = 999 
			 BEGIN
		   		SELECT @nUf_Hoy  = 1
				SELECT @nUf_Pag  = 1
				SELECT @nUf_comp = 1
		    END	

		SELECT @ValCapitalUm = ROUND(@ValCapital/@nUf_comp,4)

		SELECT @nIntAnno     = ROUND( (@ValCapitalUm * (@nTasCont/36000) * DATEDIFF(dd,@dFecCalc,@cFecRep))* @nUf_Hoy,0)
		SELECT @nReajAnno    = CASE WHEN (@xmonemi <> 999 AND @xmonemi <> 13)  THEN ROUND(( @nUf_Hoy - @nUf_Pag ) * @ValCapitalUm, 0) ELSE 0.0 END


		/* Intereses y Reajustes Devengados Acumulados */
		SELECT @nIntereses = 0
		      ,@nReajustesDev = 0
		SELECT @nCupon     = 0
		SELECT @dUltFecCup = CONVERT(DATETIME,'')


	   	IF @sSeriado = 'S' 
			BEGIN
				IF @nInst <> 'LCHR' 
				 BEGIN
					SET ROWCOUNT 1
			     		SELECT  @nCupon     = ISNULL(tdcupon,0)
							  ,	@dUltFecCup = ISNULL(Tdfecven,'')
			     		FROM  VIEW_TABLA_DESARROLLO
			     		WHERE tdmascara = @cMascara AND tdfecven < @Fecpcup
						ORDER BY tdfecven DESC
				   SET ROWCOUNT 0

				END 
				ELSE
				 BEGIN
					SELECT @dUltFecCup = @dFecucup
				END

				SELECT @dUltFecCup = CASE WHEN @dFecPm > @dUltFecCup THEN @dFecPm ELSE @dUltFecCup END

				SELECT @dFeccal = (CASE WHEN (CHARINDEX('&',@xinstser)>0 Or CHARINDEX('*',@xinstser)>0) THEN @dFecPm
				  																						ELSE @dUltFecCup END )
			END 
		ELSE 
			BEGIN
				SELECT @dFeccal = @dFecPm
	   		END


		IF 	@xmonemi<>13
			SELECT @nIntereses = ROUND((((@ValCapitalUm*(@nTasCont/100)) / 360) * (DATEDIFF(dd,@dFeccal,@cFecRep)+1)) * @nUf_Hoy , 0)
		ELSE
			SELECT @nIntereses = ROUND((((@ValCapitalUm*(@nTasCont/100)) / 360) * (DATEDIFF(dd,@dFeccal,@cFecRep)+1)) * @nUf_Hoy , 2)

		SELECT @nReajustesDev = CASE WHEN (@xmonemi <> 999 AND @xmonemi <> 13)  THEN ROUND(( @nUf_Hoy - @nUf_comp ) * @ValCapitalUm, 0) ELSE 0.0 END
		

		/* Valor mercado Año anterior o Fecha Compra*/
		SELECT @anno       = YEAR(@cFecRep)
		SELECT @dFecAnoAnt = STR(YEAR(@cFecRep)-1,4)+'1231'

		IF YEAR(@cFecComp) = @anno
			SELECT @dFecMcdo = CASE WHEN @cFecComp < @dFecPm and @cFecComp < @cFecRep THEN @dFecPm ELSE @cFecComp END
		ELSE
			SELECT @dFecMcdo = @dFecAnoAnt


		SELECT 	 @ValMcdo     = 0
		SELECT 	 @ValMcdo     = ISNULL(SUM(valor_mercado),0)
			   , @nNominalAnt = SUM(valor_nominal)
		FROM    VALORIZACION_MERCADO WITH (NOLOCK)
		WHERE 	fecha_valorizacion = @FECHAREP--CASE WHEN @bFinAno=0 THEN @FechaRep ELSE @dFecProx END /*@FECHAREP*/ AND
			    and rmrutcart = @xrutcart AND
			    rmnumdocu = @xnumdocu AND
			    rmcorrela = @xcorrela
		GROUP BY rmrutcart,rmnumdocu,rmcorrela

		SELECT @ValMcdo = ROUND((@xNomiTot/@nNominalAnt) * @ValMcdo,0)

		SELECT @nMtoCortes = 0.0
		SELECT @nFlujo     = 0


	 
		IF @sSeriado = 'S' 
		BEGIN
         	   IF @tc_rep_cnt = 'S' AND @xmonemi = 994	
			     BEGIN
				  	EXECUTE Sp_Descuenta_Cupones_tcrc @xmonemi,@xNomiTot,@dFecMcdo,@cFecRep,@cMascara,@xfecemi,@xcodigo,@nMtoCortes OUTPUT  -- Se creo SP [Sp_Descuenta_Cupones_tcrc] **
			     END 
			   ELSE 
			     BEGIN
				    EXECUTE Sp_Descuenta_Cupones @xmonemi,@xNomiTot,@dFecMcdo,@cFecRep,@cMascara,@xfecemi,@xcodigo,@nMtoCortes OUTPUT
			     END
	   
			   SELECT @nFlujo = SUM(rsflujo)
			   FROM MDRS  WITH (NOLOCK)
			   WHERE rsnumdocu = @xnumdocu AND
					 rscorrela = @xcorrela AND
					 rscartera in('111','114') AND
					 rstipoper = 'VC' AND
					 rsfecha BETWEEN @dFecMcdo AND @cFecRep AND
					 rsfecvcto > @cFecRep
				GROUP BY rsnumdocu,rscorrela

		END

		UPDATE #PASO
		SET InteresDevAno 	  = ISNULL(@nIntAnno,0),
			ReajustesDevAno   = ISNULL(@nReajAnno,0),
			DifMercano 	      = ISNULL((ValMdo - (@ValMcdo-@nFlujo)),0),
			InteresesporVenta = ISNULL(InteresesporVenta + @nFlujo,0),
			InteresDev		  = ISNULL(@nIntereses + @nReajustesDev,0)
		WHERE 	Flag = @nn
	

		SELECT @nn = @nn +1

	END  -- FIN WHILE

	/*Insertar Registros de Ventas Definitivas*/

	-- QUERY II - *** 
	SELECT    'fechaProceso'	      = @FechaRep 
			, 'Sistema'	              = 'BTR' 
		    , 'RUT_CARTERA'	          = RUT_CARTERA
		    , 'NUMDOCU'		          = NUMDOCU
		    , 'CORRELA'		          = CORRELA
		    , 'TIPO_CARTERA'          = MIN(TIPO_CARTERA)
		    , 'Fecproc'	              = @FechaRep
		    , 'CodOrigen'	          = 'RNIII'
		    , 'inserie'		          = MIN(b.inserie)
		    , 'CodEmpresa'	          = '0769'
		    , 'FecEmi'		          = CASE WHEN MIN(SERIADO) = 'S' THEN (SELECT ISNULL(sefecemi,'19000101') FROM VIEW_SERIE WHERE MIN(MASCARA) = semascara)
		    				        								 ELSE (SELECT ISNULL(nsfecemi,'19000101') FROM VIEW_NOSERIE WHERE nsrutcart = RUT_CARTERA AND nsnumdocu = NUMDOCU AND nscorrela = CORRELA)
							            END
		    , 'fecha_compra_original' = MIN(FECCOMP)
		    , 'fecvenc'				  = CASE WHEN MIN(SERIADO) = 'S' THEN MIN(FECPCUP)
		    														ELSE (SELECT nsfecven FROM VIEW_NOSERIE Where nsrutcart = RUT_CARTERA AND nsnumdocu = NUMDOCU AND nscorrela = CORRELA)
									    END
		    , 'mnnemo'				  = MIN(c.mnnemo)
		    , 'TasEmi'				  = CASE WHEN MIN(SERIADO) = 'S' THEN (SELECT setasemi FROM VIEW_SERIE Where MIN(MASCARA) = semascara)
		    						 								ELSE MIN(TIRCOMP)
									    END
		    , 'Emisor'				  = (SELECT Emnombre from view_emisor WHERE emrut = MIN(RUTEMIS))
		    , 'CodEmisor'			  = '0000'
		    , 'Rutemi'				  = CASE WHEN MIN(SERIADO) = 'S' THEN (SELECT serutemi FROM VIEW_SERIE Where MIN(MASCARA) = semascara)
		    								ELSE (SELECT nsrutemi FROM VIEW_NOSERIE Where nsrutcart = RUT_CARTERA AND nsnumdocu = NUMDOCU AND nscorrela = CORRELA)
									    END
			, 'CalJur'				  = '  '
		    , 'Pais'			      = CONVERT(VARCHAR(80),'')
			, 'Cartera'				  = CASE WHEN MIN(TIPO_CARTERA) = 1 THEN 'TR'
		    								 WHEN MIN(TIPO_CARTERA) = 2 THEN 'AV'
		    								 WHEN MIN(TIPO_CARTERA) = 4 THEN 'HD'
		    								 ELSE							 'TR'
		    							 END 
		    , 'Valcomp'				  = SUM(ISNULL(VALORCONTABLE,0)) -- VGS 03/12/2008 SUM(VALCOMP),
		    , 'ValCapital'			  = SUM(ISNULL(VALORCONTABLE,0))
		    , 'InteresDev'			  = ISNULL(CONVERT(FLOAT,0),0)
		    , 'Cosif'				  = SPACE(12)
		    , 'Cosif_Ger'			  = SPACE(12)
		    , 'ValMdo'				  = SUM(ISNULL(VALMERCADO,0))
		    , 'Util_Mercado'          = SUM(ISNULL(UTIL_MCDO,0))
		    , 'Perd_Mercado'          = SUM(ISNULL(PER_MCDO,0))
		    , 'InteresDevAno'	      = SUM(ISNULL(INTDEVANNO,0))
		    , 'ReajustesDevAno'       = SUM(ISNULL(READEVANNO,0))
		    , 'DifMercano'            = SUM(ISNULL(DIFMCDOANNO,0))
		    , 'ValcompAno'            = SUM(ISNULL(VALCOMPANNO,0))
		    , 'ValorVenta'            = SUM(ISNULL(VENTAVALOR,0))
		    , 'InteresesporVenta'	  = SUM(ISNULL(INTERESVENTA,0))
		    , 'UtilporVenta'          = CASE WHEN SUM(UTIL_X_VENTA) > 0 THEN SUM(UTIL_X_VENTA) ELSE SUM(PERD_X_VENTA) END
		    , 'monedaor'			  = 'CLP'
		    , 'CtaAltamira'			  = SPACE(12)
		    , 'moinstser'			  = MIN(INSTSER)
		    , 'momonemi'			  = MIN(MONEMIS)
		    , 'Prog'				  = 'SP_'+Min(inprog)
		    , 'mocodigo'			  = MIN(CODIGO)
		    , 'mofecven'			  = MIN(FECVENC)
		    , 'BasEmi'				  = CASE WHEN Min(SERIADO) = 'S' THEN (SELECT sebasemi FROM VIEW_SERIE Where Min(MASCARA) = semascara)
		    								ELSE (SELECT nsbasemi FROM VIEW_NOSERIE Where nsrutcart = RUT_CARTERA AND nsnumdocu = NUMDOCU AND nscorrela = CORRELA)
										END
		    , 'monominal'			  = SUM(NOMINAL)
		    , 'tir_compra_original'   = MIN(TIRCOMP)
		    , 'movalcomu'			  = SUM(VALCOMU)
		    , 'fechavta'			  = MIN(VENTAFECHAREAL)
		    , 'Valor_Contable'		  = SUM(VALORCONTABLE)
		    , 'Tasa_Contrato'		  = MIN(TASACONTRATO)
		    , 'cpmascara'			  = MIN(ISNULL(MASCARA,0))
		    , 'cpseriado'			  = MIN(ISNULL(SERIADO,0))
		    , 'Fecha_PagoMañana'	  = CASE WHEN MIN(FECCOMP) < CONVERT(DATETIME,'20070115') THEN MIN(VENTAFECPAGO) ELSE MIN(FECCOMP) END
		    , 'cpfecpcup'             = MIN(FECPCUP)
		    , 'cpFecucup'             = MIN(FECUCUP)
		    , 'Pendiente_Pago'		  = CASE WHEN MIN(VENTAFECPAGO)<= @FechaRep   THEN CONVERT(VARCHAR(10),'N') ELSE CONVERT(VARCHAR(10),'S') END
		    , 'Codigo_Producto'		  = CASE WHEN MIN(CODIGO) = 98 THEN 33 ELSE 29 END
		    , 'Monto_Pago'			  = CASE WHEN MIN(VENTAFECPAGO)<= @FechaRep THEN CONVERT(NUMERIC(17,2),0) ELSE SUM(NOMINAL) END
		    , 'Rut_Cliente'			  = CASE WHEN MIN(VENTAFECPAGO)<= @FechaRep THEN CONVERT(NUMERIC(30),0)  
																				ELSE (CASE WHEN Min(SERIADO) = 'S' THEN (SELECT serutemi FROM VIEW_SERIE   WHERE MIN(MASCARA) = semascara)
		     																									   ELSE (SELECT nsrutemi FROM VIEW_NOSERIE WHERE nsrutcart = RUT_CARTERA AND nsnumdocu = NUMDOCU AND nscorrela = CORRELA)
																			   END) 
										END
		    , 'PERIODICIDAD'          = CASE WHEN MIN(b.inserie) =  'BCP'  THEN 'SEMESTRAL' 
		    								 WHEN MIN(b.inserie) =  'BCU'  THEN 'SEMESTRAL' 					
		    								 WHEN MIN(b.inserie) =  'BTP'  THEN 'SEMESTRAL' 
		    								 WHEN MIN(b.inserie) =  'BTU'  THEN 'SEMESTRAL' 
		    								 WHEN MIN(b.inserie) =  'PRC'  THEN 'SEMESTRAL' 
						     				 WHEN MIN(b.inserie) =  'LCHR' THEN 'TRIMESTRAL'
						     			     WHEN MIN(b.inserie)=  'BONOS'THEN 'SEMESTRAL' 
		    								 WHEN MIN(b.inserie) =  'CERO' THEN 'OUTRO'
		    								 WHEN MIN(b.inserie) =  'DPF'  THEN 'OUTRO'
		    								 WHEN MIN(b.inserie) =  'DPR'  THEN 'OUTRO'
		    								 WHEN MIN(b.inserie) =  'PDBC' THEN 'OUTRO'
		    								 WHEN MIN(b.inserie) =  'DPX'  THEN 'OUTRO'
		    						    ELSE 'OUTRO'
		                                END
			 ,'dvEmisor' = ' '		                                
		    ,'Flag'					 = IDENTITY(INT,1,1)
 	INTO #Ventas
	FROM mdvp WITH (NOLOCK), view_instrumento b WITH (NOLOCK), view_moneda c WITH (NOLOCK)
	WHERE YEAR(VENTAFECHAREAL) = @anno
		AND CODIGO = incodigo
		AND MONEMIS = mncodmon
		AND 1=2
	GROUP BY RUT_CARTERA,NUMDOCU,CORRELA

	UPDATE #Ventas
	SET	CalJur = 			CASE 
			WHEN cltipcli = 8 THEN 'PF'
			WHEN cltipcli = 1 THEN 'IF'
			WHEN cltipcli = 2 THEN 'IF'
			WHEN cltipcli = 3 THEN 'IF'
			WHEN cltipcli = 4 THEN 'IF'
			WHEN cltipcli = 5 THEN 'IF'
			WHEN cltipcli = 6 THEN 'IF'
			WHEN cltipcli = 7 THEN 'PJ'
			WHEN cltipcli = 9 THEN 'PJ'
			WHEN cltipcli = 10 THEN 'PJ'
			WHEN cltipcli = 11 THEN 'PJ'
			WHEN cltipcli = 12 THEN 'PJ'
			WHEN cltipcli = 13 THEN 'PJ'
			ELSE  'PJ'
		END 
		, Pais   = COD_ITAU
		,dvEmisor = cldv
	FROM VIEW_CLIENTE,BACPARAMSUDA.DBO.PAIS 
	WHERE clrut = Rutemi AND clpais = codigo_pais

  	SELECT @nCont = MAX(Flag) FROM #Ventas
  	SELECT @nn    = MIN(Flag) FROM #Ventas

   	WHILE @nn <= @nCont
   	BEGIN
		SELECT 	@xmonemi    = momonemi,
				@nInst	    = inserie,
				@cTipCart   = TIPO_CARTERA,
				@cFecComp   = fecha_compra_original,
				@cFecVta    = fechavta,
				@ValCapital = Valor_Contable,
				@sSeriado   = cpseriado,
				@cMascara   = cpmascara,
				@dFecucup   = cpFecucup,
				@dFecPm     = Fecha_PagoMañana  -- fecha_compra_original
		FROM #Ventas
		WHERE Flag = @nn


/******************************************************************************************************************************************************
		/* Rescata Cuentas Contables Brasil*/
   	    	SELECT 	@Folio_Perfil    = 0

   	    	SELECT 	@Folio_Perfil    = Folio_Perfil
    	    FROM  	VIEW_PERFIL_CNT
    	    WHERE 	ID_Sistema         = 'BTR'   AND
   		  			Tipo_Movimiento    = 'MOV'   AND
   	 	  			Tipo_Operacion     = 'TM'    AND
   	 	  			Codigo_Instrumento = @nInst  AND
   	  	  			Moneda_Instrumento = @xmonemi
   	  	  			
			SELECT @CodCamCond = 0
   	    	SET ROWCOUNT 1
   	    		SELECT @CodCamCond = ISNULL(Codigo_Campo_Condicion,0) FROM view_tabla_glcode WHERE Codigo_Transaccion = @Folio_Perfil -- ***
  	    	SET ROWCOUNT 0

   	    	SELECT  @cCuentAlt   = '' 
				  , @cCtaCosif   = ''
				  , @cCtaCosif_g = ''
				  , @cCuentAlt_2 = ''

   	
			IF @CodCamCond > 0
			BEGIN
   	  			SELECT    @cCuentAlt    =  Cuenta_Altamira
						, @cCuentAlt_2  =  Cuenta_Altamira_per
		       			, @cCtaCosif    =  Cuenta_Cosif
					    , @cCtaCosif_g  =  Cuenta_Cosif_Ger
   	  			FROM    view_tabla_glcode
   	  			WHERE 	Codigo_Transaccion     = @Folio_Perfil AND
	              		Codigo_Campo_Condicion = @CodCamCond AND
	              		Codigo_Condicion       = @cTipCart
   	   		END
******************************************************************************************************************************************************/			
   	    	SELECT  @cCuentAlt   = '' 
				  , @cCtaCosif   = ''
				  , @cCtaCosif_g = ''
				  , @cCuentAlt_2 = ''

			SELECT @cCuentAlt   = tCC.CtaIBS,
				   @cCtaCosif   = tCC.CtaCOSIF,
				   @cCtaCosif_g = tCC.CtaCOSIF_GER,
				   @cCuentAlt_2 = tcc.CtaOTRA1
			  FROM #TblRelacionPCtasContables tCC
			WHERE tCC.idCodigo = 1
			 AND tCC.sFamilia =@nInst
			 AND tCC.iMoneda =  @xmonemi  
			
			

		IF @tc_rep_cnt = 'S' AND @xmonemi = 994
		 BEGIN
			/* -- ITAU
		     	SELECT @nUf_Hoy  =  vmvalor_tcrc  FROM view_Valor_moneda WHERE vmcodigo = @xmonemi and Vmfecha = @cFecVta	            
				SELECT @nUf_comp =  vmvalor_tcrc  FROM view_Valor_moneda WHERE vmcodigo = @xmonemi and Vmfecha = @cFecComp
			*/
				SELECT @nUf_Hoy  =  Tipo_Cambio  FROM BacParamSuda..VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @xmonemi and Fecha = @cFecVta	            
				SELECT @nUf_comp =  Tipo_Cambio  FROM BacParamSuda..VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda = @xmonemi and Fecha = @cFecComp
		 END
		ELSE 
		 BEGIN
			/* -- ITAU
		     	SELECT @nUf_Hoy  =  vmvalor FROM view_Valor_moneda WHERE vmcodigo = @xmonemi and Vmfecha = @cFecVta
	            SELECT @nUf_comp =  vmvalor FROM view_Valor_moneda WHERE vmcodigo = @xmonemi and Vmfecha = @cFecComp
			*/
			SELECT @nUf_Hoy  =  vmvalor FROM view_Valor_moneda WHERE vmcodigo = @xmonemi and Vmfecha = @cFecVta
	        SELECT @nUf_comp =  vmvalor FROM view_Valor_moneda WHERE vmcodigo = @xmonemi and Vmfecha = @cFecComp
		 END            

	    IF  @xmonemi = 13 OR @xmonemi = 999 
		BEGIN
		   	SELECT @nUf_Hoy = 1
			SELECT @nUf_comp = 1
		END

		SELECT @ValCapitalUm = ROUND(@ValCapital/@nUf_comp,4)

		/* Intereses y Reajustes Devengados Acumulados sacado del anexo 6  DBO.Sp_Inforvalmercado*/
		SELECT  @nIntereses    = 0
		      , @nReajustesDev = 0

		SELECT  @nCupon     = 0

		SELECT  @dUltFecCup = CONVERT(DATETIME,'')

	   	IF @sSeriado = 'S' 
		 BEGIN
			IF @nInst <> 'LCHR'
			 BEGIN
				SET ROWCOUNT 1
			     	SELECT   @nCupon	  = ISNULL(tdcupon,0) 
					       , @dUltFecCup  = ISNULL(Tdfecven,'')
			     	FROM  view_tabla_desarrollo
			     	WHERE tdmascara = @cMascara AND tdfecven < @Fecpcup 
					ORDER BY tdfecven DESC
			     	SET ROWCOUNT 0

			END 
			ELSE 
			 BEGIN
				SELECT @dUltFecCup = @dFecucup
			 END

			SELECT @dUltFecCup = CASE WHEN @dFecPm > @dUltFecCup THEN @dFecPm ELSE @dUltFecCup END

			SELECT @dFeccal    = (CASE WHEN (CHARINDEX('&', @xinstser)>0 Or CHARINDEX('*',@xinstser) > 0) THEN @dFecPm ELSE @dUltFecCup END)
		 END 
		ELSE 
		 BEGIN
			SELECT @dFeccal = @dFecPm

	   	 END

		IF 	@xmonemi <> 13
			SELECT @nIntereses = ROUND((((@ValCapitalUm * (@nTasCont/100)) / 360) * (DATEDIFF(dd,@dFeccal,@cFecVta)+1)) * @nUf_Hoy , 0)
		ELSE										      
			SELECT @nIntereses = ROUND((((@ValCapitalUm * (@nTasCont/100)) / 360) * (DATEDIFF(dd,@dFeccal,@cFecVta)+1)) * @nUf_Hoy , 2)

		SELECT @nReajustesDev  = CASE WHEN (@xmonemi <> 999 AND @xmonemi <> 13)  THEN ROUND(( @nUf_Hoy - @nUf_comp ) * @ValCapitalUm, 0) ELSE 0.0 END

		UPDATE #Ventas
		SET	 Cosif	    = ISNULL(@cCtaCosif,0)
			,Cosif_Ger   = ISNULL(@cCtaCosif_g,0)
			,CtaAltamira = ISNULL(@cCuentAlt,0)
			,InteresDev  = ISNULL(InteresDev + @nReajustesDev,0)
		WHERE Flag = @nn

		SELECT @nn = @nn +1
	END

	-- QUERY III - #VCTO *** 
	/*Insertar Vencimiento de Titulos*/
	SELECT    'fechaProceso'	      = @FechaRep  
			, 'Sistema'	              = 'BTR' 
			, 'rsrutcart'		      = rsrutcart
			, 'rsnumdocu'		      = rsnumdocu
			, 'rscorrela'		      = rscorrela
			, 'TIPO_CARTERA'          = MIN(rstipcart)
			, 'Fecproc'		          = @FechaRep
			, 'CodOrigen'		      = 'RNIII'
			, 'inserie'			      = MIN(b.inserie)
			, 'CodEmpresa'		      = '0769'
			, 'FecEmi'			      = MIN(rsfecemis)
			, 'fecha_compra_original' = MIN(rsfeccomp)
			, 'fecvenc'				  = MIN(rsfecvcto)
			, 'mnnemo'				  = MIN(c.mnnemo)
			, 'TasEmi'				  = MIN(rstasemi)
			, 'Emisor'				  = (SELECT Emnombre FROM view_emisor WHERE emrut = Min(rsrutemis))
			, 'CodEmisor'			  = '0000'
			, 'Rutemi'				  = MIN(rsrutemis)
			, 'CalJur'				  = '  '
			, 'Pais'				  = CONVERT(VARCHAR(80),'')
		    , 'Cartera'               = CASE WHEN codigo_carterasuper = 'P' THEN 'AV'
									       WHEN codigo_carterasuper = 'A' THEN 'HD'
									       WHEN codigo_carterasuper = 'T' THEN 'TR'
										   ELSE 'TR'										    
							          END
			, 'Valcomp'				 = CONVERT(NUMERIC(19,4),0) -- VGS 03/12/2008 SUM(VALCOMP),
			, 'ValCapital'           = CONVERT(NUMERIC(19,4),0)
			, 'InteresDev'	         = ISNULL(CONVERT(FLOAT,0),0)
			, 'Cosif'	             = SPACE(12)
			, 'Cosif_Ger'            = SPACE(12)
			, 'ValMdo'				 = CONVERT(NUMERIC(19,4),0)
			, 'Util_Mercado'         = CONVERT(NUMERIC(19,4),0)
			, 'Perd_Mercado'         = CONVERT(NUMERIC(19,4),0)
			, 'InteresDevAno'		 = ISNULL(CONVERT(NUMERIC(19,4),0),0)
			, 'ReajustesDevAno'      = CONVERT(NUMERIC(19,4),0)
			, 'DifMercano'           = CONVERT(NUMERIC(19,4),0)
			, 'ValcompAno'           = ISNULL(CONVERT(NUMERIC(19,4),0),0)
			, 'ValorVenta'           = CONVERT(NUMERIC(19,4),0)
			, 'InteresesporVenta'	 = SUM(rsflujo)
			, 'UtilporVenta'         = CONVERT(NUMERIC(19,4),0)
			, 'monedaor'             = 'CLP'
			, 'CtaAltamira'			 = SPACE(12)
			, 'moinstser'			 = MIN(rsinstser)
			, 'momonemi'			 = MIN(rsmonemi)
			, 'Prog'				 = 'SP_'+ MIN(inprog)
			, 'mocodigo'			 = MIN(rscodigo)
			, 'mofecven'			 = MIN(rsfecvcto)
			, 'BasEmi'				 = MIN(rsbasemi)
			, 'monominal'			 = SUM(rsnominal)
			, 'tir_compra_original'  = MIN(rstir)
			, 'movalcomu'			 = CONVERT(NUMERIC(19,4),0)
			, 'fechavta'			 = MIN(rsfecvcto)
			, 'Valor_Contable'		 = CONVERT(NUMERIC(19,4),0)
			, 'Tasa_Contrato'		 = MIN(ISNULL(Tasa_Contrato,0))
			, 'cpmascara'			 = MIN(rsmascara)
			, 'cpseriado'			 = CASE WHEN MIN(b.inmdse) = 'S' THEN 'S' ELSE 'N' END
			, 'Fecha_PagoMañana'     = MIN(Fecha_PagoMañana)
			, 'cpfecpcup'			 = MIN(rsfecpcup)
			, 'cpFecucup'			 = MIN(rsfecucup)
			, 'Pendiente_Pago'		 = 'N'
			, 'Codigo_Producto'      = CASE WHEN MIN(rscodigo) = 98 THEN 33 ELSE 29 END
			, 'Monto_Pago'           = CONVERT(NUMERIC(17,2),0)
			, 'Rut_Cliente'          = CONVERT(NUMERIC(30),0) 
			, 'PERIODICIDAD'		 = CASE WHEN   MIN(b.inserie) =  'BCP'  THEN 'SEMESTRAL' 
											 WHEN  MIN(b.inserie) =  'BCU'  THEN 'SEMESTRAL' 					
											 WHEN  MIN(b.inserie) =  'BTP'  THEN 'SEMESTRAL' 
											 WHEN  MIN(b.inserie) =  'BTU'  THEN 'SEMESTRAL' 
											 WHEN  MIN(b.inserie) =  'PRC'  THEN 'SEMESTRAL' 

											 WHEN  MIN(b.inserie) =  'BONOS'THEN 'SEMESTRAL' 
											 WHEN  MIN(b.inserie) =  'LCHR' THEN 'TRIMESTRAL' 

											 
											 WHEN  MIN(b.inserie) =  'CERO' THEN 'OUTRO'
											 WHEN  MIN(b.inserie) =  'DPF'  THEN 'OUTRO'
											 WHEN  MIN(b.inserie) =  'DPR'  THEN 'OUTRO'
											 WHEN  MIN(b.inserie) =  'PDBC' THEN 'OUTRO'
											 WHEN  MIN(b.inserie) =  'DPX'  THEN 'OUTRO'
										ELSE 'OUTRO'
			                		   END
			,  'dvEmisor'		   = ' '			                		   
			, 'Flag'			   = IDENTITY(INT,1,1)
	INTO #VCTO
	FROM mdrs WITH (NOLOCK), view_instrumento b WITH (NOLOCK), view_moneda c WITH (NOLOCK)
	WHERE  YEAR(rsfecha)  = @anno
			AND rstipoper = 'VC' 
			AND rscartera in('111','114','159') 
			AND rsvppresenx = 0
			AND rscodigo = b.incodigo
			AND rsmonemi = c.mncodmon
	GROUP BY rsrutcart, rsnumdocu,rscorrela,mdrs.codigo_carterasuper

	UPDATE #VCTO
	SET	  CalJur = 			CASE 
			WHEN cltipcli = 8 THEN 'PF'
			WHEN cltipcli = 1 THEN 'IF'
			WHEN cltipcli = 2 THEN 'IF'
			WHEN cltipcli = 3 THEN 'IF'
			WHEN cltipcli = 4 THEN 'IF'
			WHEN cltipcli = 5 THEN 'IF'
			WHEN cltipcli = 6 THEN 'IF'
			WHEN cltipcli = 7 THEN 'PJ'
			WHEN cltipcli = 9 THEN 'PJ'
			WHEN cltipcli = 10 THEN 'PJ'
			WHEN cltipcli = 11 THEN 'PJ'
			WHEN cltipcli = 12 THEN 'PJ'
			WHEN cltipcli = 13 THEN 'PJ'
			ELSE  'PJ'
		END 

		, Pais   = COD_ITAU
		,dvEmisor = cldv
	FROM VIEW_CLIENTE,BACPARAMSUDA.DBO.PAIS 
	WHERE clrut = Rutemi AND clpais = codigo_pais

  	SELECT @nCont = MAX(Flag) FROM #VCTO
  	SELECT @nn    = MIN(Flag) FROM #VCTO

   	WHILE @nn <= @nCont
   	BEGIN
		SELECT 	@cFecComp = fecha_compra_original,
				@xrutcart = rsrutcart,
				@xnumdocu = rsnumdocu,
				@xcorrela = rscorrela,
          		@xcodigo  = mocodigo,
          		@xmonemi  = momonemi,
	  			@xNomiTot = monominal,
				@cMascara = cpmascara,
				@dFecPm	  = Fecha_PagoMañana,
				@ValVcto  = InteresesporVenta,
				@sSeriado = cpseriado,
				@nInst	  = inserie,
				@cTipCart = TIPO_CARTERA
		FROM #VCTO
		WHERE Flag = @nn

		SELECT @anno = YEAR(@cFecRep)
		SELECT @dFecAnoAnt = STR(YEAR(@cFecRep)-1,4)+'1231'

		IF YEAR(@cFecComp) = @anno
			SELECT @dFecMcdo = CASE WHEN @cFecComp < @dFecPm and @cFecComp < @cFecRep THEN @dFecPm ELSE @cFecComp END
		ELSE
			SELECT @dFecMcdo = @dFecAnoAnt

		SELECT 	@ValMcdo     = 0

		SELECT 	@ValMcdo     = ISNULL(SUM(valor_mercado),0),
			    @nNominalAnt = SUM(valor_nominal)
		FROM VALORIZACION_MERCADO
		WHERE 	fecha_valorizacion = @FECHAREP--CASE WHEN @bFinAno=0 THEN @FechaRep ELSE @dFecProx END /*@FECHAREP*/ AND
				and rmrutcart          = @xrutcart AND
				rmnumdocu          = @xnumdocu AND
				rmcorrela          = @xcorrela
		GROUP BY rmrutcart,rmnumdocu,rmcorrela

		SELECT @ValMcdo = ROUND((@xNomiTot/@nNominalAnt) * @ValMcdo,0)

		SELECT @nMtoCortes = 0.0
		IF @sSeriado = 'S'
		BEGIN
			IF @tc_rep_cnt = 'S' AND @xmonemi = 994	
			  BEGIN
				EXECUTE Sp_Descuenta_Cupones_tcrc @xmonemi,@xNomiTot,@dFecMcdo,@cFecRep,@cMascara,@xfecemi,@xcodigo,@nMtoCortes OUTPUT
			  END 
			 ELSE 
			  BEGIN
				EXECUTE Sp_Descuenta_Cupones @xmonemi,@xNomiTot,@dFecMcdo,@cFecRep,@cMascara,@xfecemi,@xcodigo,@nMtoCortes OUTPUT
			  END
		END
/******************************************************************************************************************************************
   	    	SELECT 	@Folio_Perfil      = 0

   	    	SELECT 	@Folio_Perfil      = Folio_Perfil
    		FROM  	VIEW_PERFIL_CNT
    		WHERE 	ID_Sistema         = 'BTR'   AND
   		  			Tipo_Movimiento    = 'MOV'   AND
   	 	  			Tipo_Operacion     = 'TM'    AND
   	 	  			Codigo_Instrumento = @nInst  AND
   	  	  			Moneda_Instrumento = @xmonemi

   	    	SELECT @CodCamCond = 0

   	    	SET ROWCOUNT 1
   	    		SELECT @CodCamCond  = ISNULL(Codigo_Campo_Condicion,0) FROM view_tabla_glcode WHERE Codigo_Transaccion = @Folio_Perfil -- ***
  	    	SET ROWCOUNT 0

   	    	SELECT  @cCuentAlt    = ''
				  , @cCtaCosif    = ''
				  , @cCtaCosif_g  = ''
				  , @cCuentAlt_2  = ''
   	   	
	
			IF @CodCamCond > 0 
			BEGIN
   	  			SELECT   @cCuentAlt    = Cuenta_Altamira
					   , @cCuentAlt_2  = Cuenta_Altamira_per
		       		   , @cCtaCosif    = Cuenta_Cosif
					   , @cCtaCosif_g  = Cuenta_Cosif_Ger
   	  			FROM  view_tabla_glcode WITH (NOLOCK)
   	  			WHERE 	Codigo_Transaccion = @Folio_Perfil AND
	              		Codigo_Campo_Condicion = @CodCamCond AND
	              		Codigo_Condicion = @cTipCart
	
			END
******************************************************************************************************************************************/			
			SELECT  @cCuentAlt   = '' 
				  , @cCtaCosif   = ''
				  , @cCtaCosif_g = ''
				  , @cCuentAlt_2 = ''

			SELECT @cCuentAlt   = tCC.CtaIBS,
				   @cCtaCosif   = tCC.CtaCOSIF,
				   @cCtaCosif_g = tCC.CtaCOSIF_GER,
				   @cCuentAlt_2 = tcc.CtaOTRA1
			  FROM #TblRelacionPCtasContables tCC
			WHERE tCC.idCodigo = 1
			 AND tCC.sFamilia =@nInst
			 AND tCC.iMoneda =  @xmonemi  


		UPDATE #VCTO
		SET	 DifMercano	= ISNULL((@ValVcto - (@ValMcdo-@nMtoCortes)),0)
			,Cosif	    = ISNULL(@cCtaCosif,0)
			,Cosif_Ger   = ISNULL(@cCtaCosif_g,0)
			,CtaAltamira = ISNULL(@cCuentAlt,0)
		WHERE Flag = @nn

		SELECT @nn = @nn +1
	END
	
--------------- BONES ----------------------------------------------------
	-- QUERY IV - #TMPBONOS_INV *** 
	SELECT	 'fechaProceso'	        =  @FechaRep 
		   , 'Sistema'	            =  'BTR' 
		   , 'cprutcart'	        =  cprutcart 
	       , 'cpnumdocu'	        =  cpnumdocu
		   , 'cpcorrela'	        =  cpcorrelativo
		   , 'cptipcart'              =  CASE WHEN codigo_carterasuper = 'P' THEN 1
									        WHEN codigo_carterasuper = 'A' THEN 2
									        WHEN codigo_carterasuper = 'H' THEN 4										  
									        ELSE 1 
							           END

		   , 'Fecproc'              =  @FechaRep
		   , 'CodOrigen'            =  'RNIII'
		   , 'inserie'              =  ISNULL((SELECT i.Nom_Familia FROM BacBonosExtSuda..text_fml_inm i  WITH (NOLOCK) WHERE c.cod_familia = i.Cod_familia),'') 
		   , 'CodEmpresa'           =  '0769' 
		   , 'FecEmi'               =  ISNULL((SELECT ISNULL(s.fecha_emis,'19000101') FROM BacBonosExtSuda..text_ser s  WITH (NOLOCK) WHERE  s.cod_nemo = c.cod_nemo),cpfecemi)		 		  
	       , 'cpfeccomp'            =  cpfeccomp 
		   , 'fecvenc'              =  ISNULL((SELECT s.fecha_vcto FROM BacBonosExtSuda..text_ser s  WITH (NOLOCK) WHERE  s.cod_nemo = c.cod_nemo),cpfecven)	 								
		   , 'mnnemo'		        =  ISNULL((SELECT mnnemo		FROM BacParamSuda.dbo.MONEDA  WITH (NOLOCK) WHERE mncodmon = c.cpmonemi),'')			 	
		   
		   , 'TasEmi'		        =  ISNULL((SELECT tasa_emis	FROM BacBonosExtSuda..text_ser		 WITH (NOLOCK)  WHERE cod_nemo = c.cod_nemo),0) 
	       , 'Emisor'		        =  ISNULL((SELECT substring(nom_emi,1,40)	FROM BacBonosExtSuda..text_emi_itl	 WITH (NOLOCK)  WHERE rut_emi	= c.cprutemi),'')
		   , 'CodEmisor'            =  '0000'
		   , 'Rutemi'               =  cprutemi
		   , 'CalJur'               =  '  '
		   , 'Pais'                 =  CONVERT(VARCHAR(50),'') 
		   , 'Cartera'               = CASE WHEN codigo_carterasuper = 'P' THEN 'AV'
									       WHEN codigo_carterasuper = 'A' THEN 'HD'
									       WHEN codigo_carterasuper = 'T' THEN 'TR'
										   ELSE 'TR'										    
							          END
		   , 'Valcomp'		        =  ISNULL(cpvalcomu,0) 
		   , 'ValCapital'		    =  ISNULL(cpvalcomu,0) 
		   , 'InteresDev'	        =  ISNULL(CONVERT(FLOAT,0),0)
		   , 'Cosif'		        =  SPACE(12)  
		   , 'Cosif_Ger'	        =  SPACE(12) 
		   , 'ValMdo'	            =  CONVERT(NUMERIC(19,4),0) 
		   , 'Util_Mercado'         =  CONVERT(NUMERIC(19,4),0) 
		   , 'Perd_Mercado'         =  CONVERT(NUMERIC(19,4),0) 
		   , 'InteresDevAno'	    =  ISNULL(CONVERT(NUMERIC(19,4),0),0)
		   , 'ReajustesDevAno'      =  CONVERT(NUMERIC(19,4),0) 
		   , 'DifMercano'		    =  CONVERT(NUMERIC(19,4),0) 
		   , 'ValcompAno'           =  CASE WHEN YEAR(cpfeccomp) = YEAR(@FechaRep) THEN ISNULL(cpvalcomu,0) ELSE ISNULL(CONVERT(NUMERIC(19,4),0),0) END 
		   , 'ValorVenta'		    =  CONVERT(NUMERIC(19,4),0)
		   , 'InteresesporVenta'    =  CONVERT(NUMERIC(19,4),0)
		   , 'UtilporVenta'         =  CONVERT(NUMERIC(19,4),0)
		   , 'monedaor'             = 'CLP' 
		   , 'CtaAltamira'          =  SPACE(12) 
		   , 'cpinstser'		    = id_instrum
		   , 'dimoneda'			    = cpmonemi   
		   , 'Flag'				    = IDENTITY(INT,1,1)
		   , 'Prog'                 = '_val_ins' --b.inprog	   											--PENDIENTE
		   , 'cpcodigo'             = c.cod_familia  
		   , 'difecsal'             = '' 
		   , 'BasEmi'               = ISNULL((SELECT s.base_tasa_emi FROM BacBonosExtSuda..text_ser s  WITH (NOLOCK) WHERE  s.cod_nemo = c.cod_nemo),0) 
		   , 'cpnominal'            = cpnominal 	
		   , 'cptircomp'            = cptircomp 	
		   , 'cpvalcomu'            = cpvalcomu 
		   , 'Valor_Contable'       = cpvalcomu 
		   , 'Tasa_Contrato'        = cptircomp
		   , 'cpmascara'            = id_instrum 
		   , 'cpseriado'            = 'S' 
		   , 'Fecha_PagoMañana'     = cpfecpago
		   , 'cpfecpcup'		    = cpfecpcup
		   , 'cpFecucup'		    = cpFecucup
		   , 'Pendiente_Pago'       = CASE WHEN cpfecpago <= @FechaRep THEN 'N' ELSE 'S' END 
		   , 'Codigo_Producto'      = 0																			       --PENDIENTE
		   , 'Monto_Pago'           = CASE WHEN cpfecpago <= @FechaRep THEN CONVERT(NUMERIC(17,2),0) ELSE cpnominal END
		   , 'Rut_Cliente'     = 0 																				--PENDIENTE
		   , 'PERIODICIDAD'         = CASE WHEN (SELECT ts.per_cupones 
												 FROM	BacBonosExtSuda..text_ser ts 
												 WHERE	ts.Cod_familia	= c.cod_familia
										 			 AND	ts.cod_nemo		= c.cod_nemo ) = 6 
										 	THEN 'SEMESTRAL'
										 	ELSE 'OUTRO' 
		                              END
		  , 'dvEmisor'		= ' '										
	INTO #TMPBONOS_INV
	FROM ##text_ctr_inv c WITH (NOLOCK)
	WHERE cpnominal > 0
	AND 1=2
	UPDATE #TMPBONOS_INV
	SET	  CalJur = 			CASE 
			WHEN cltipcli = 8 THEN 'PF'
			WHEN cltipcli = 1 THEN 'IF'
			WHEN cltipcli = 2 THEN 'IF'
			WHEN cltipcli = 3 THEN 'IF'
			WHEN cltipcli = 4 THEN 'IF'
			WHEN cltipcli = 5 THEN 'IF'
			WHEN cltipcli = 6 THEN 'IF'
			WHEN cltipcli = 7 THEN 'PJ'
			WHEN cltipcli = 9 THEN 'PJ'
			WHEN cltipcli = 10 THEN 'PJ'
			WHEN cltipcli = 11 THEN 'PJ'
			WHEN cltipcli = 12 THEN 'PJ'
			WHEN cltipcli = 13 THEN 'PJ'
			ELSE  'PJ'
		END 
		,dvEmisor = cldv
		, Pais   = COD_ITAU
	FROM VIEW_CLIENTE,BACPARAMSUDA.DBO.PAIS 
	WHERE clrut = Rutemi AND clpais = codigo_pais


		-- QUERY V - #TMPBONOS_INV *** 
	SELECT	 'fechaProceso'	        = @FechaRep 
		   , 'Sistema'	            = 'BTR' 
		   , 'cprutcart'	        = rsrutcart 
	       , 'cpnumdocu'	        = rsnumdocu
		   , 'cpcorrela'	        = rscorrelativo
		   , 'cptipcart'              =  CASE WHEN codigo_carterasuper = 'P' THEN 1
									        WHEN codigo_carterasuper = 'A' THEN 2
									        WHEN codigo_carterasuper = 'H' THEN 4										  
									        ELSE 1 
							           END

		   , 'Fecproc'              = @FechaRep
		   , 'CodOrigen'            = 'RNIII'
		   , 'inserie'              = ISNULL((SELECT i.Nom_Familia FROM BacBonosExtSuda..text_fml_inm i  WITH (NOLOCK) WHERE c.cod_familia = i.Cod_familia),'')
		   , 'CodEmpresa'           = '0769'
		   , 'FecEmi'               = ISNULL((SELECT s.fecha_emis FROM BacBonosExtSuda..text_ser s  WITH (NOLOCK) WHERE  s.cod_nemo = c.cod_nemo),rsfecemis)						  
	       , 'cpfeccomp'            = rsfeccomp
		   , 'fecvenc'              = ISNULL((SELECT s.fecha_vcto FROM BacBonosExtSuda..text_ser s  WITH (NOLOCK) WHERE  s.cod_nemo = c.cod_nemo),rsfecvcto)								
		   , 'mnnemo'		        = ISNULL((SELECT mnnemo		 FROM BacParamSuda.dbo.MONEDA WITH (NOLOCK) WHERE mncodmon = c.rsmonemi),'') 
		   , 'TasEmi'		        = ISNULL((SELECT tasa_emis	 FROM BacBonosExtSuda..text_ser		 WITH (NOLOCK) WHERE cod_nemo = c.cod_nemo),0) 
	       , 'Emisor'		        = ISNULL((SELECT substring(nom_emi,1,40) FROM BacBonosExtSuda..text_emi_itl	WITH (NOLOCK) WHERE rut_emi=c.rsrutemis),'') 
		   , 'CodEmisor'            = '0000'
		   , 'Rutemi'               = rsrutemis
		   , 'CalJur'               = '  '
		   , 'Pais'                 = CONVERT(VARCHAR(50),'')
		  , 'Cartera'               = CASE WHEN codigo_carterasuper = 'P' THEN 'AV'
									       WHEN codigo_carterasuper = 'A' THEN 'HD'
									       WHEN codigo_carterasuper = 'T' THEN 'TR'
										   ELSE 'TR'										    
							          END
		   , 'Valcomp'		        = ISNULL(rsvalcomu,0) 
		   , 'ValCapital'		    = ISNULL(rsvalcomu,0) 
		   , 'InteresDev'	        = ISNULL(CONVERT(FLOAT,0),0)
		   , 'Cosif'		        = SPACE(12)
		   , 'Cosif_Ger'	        = SPACE(12)
		   , 'ValMdo'	            = CONVERT(NUMERIC(19,4), round(c.rsvalmerc*@contable,0) )
		   , 'Util_Mercado'         = CONVERT(NUMERIC(19,4),0)
		   , 'Perd_Mercado'         = CONVERT(NUMERIC(19,4),0)
		   , 'InteresDevAno'	    = ISNULL(CONVERT(NUMERIC(19,4),0),0)
		   , 'ReajustesDevAno'      = CONVERT(NUMERIC(19,4),0)
		   , 'DifMercano'		    = CONVERT(NUMERIC(19,4),0)
		   , 'ValcompAno'           = CASE WHEN YEAR(rsfeccomp) = YEAR(@FechaRep) THEN ISNULL(rsvalcomu,0) ELSE ISNULL(CONVERT(NUMERIC(19,4),0),0) END 
		   , 'ValorVenta'		    = CONVERT(NUMERIC(19,4),0)
		   , 'InteresesporVenta'    = CONVERT(NUMERIC(19,4),0)
		   , 'UtilporVenta'         = CONVERT(NUMERIC(19,4),0)
		   , 'monedaor'             = 'CLP'
		   , 'CtaAltamira'			= SPACE(12)
		   , 'cpinstser'		    = id_instrum 
		   , 'dimoneda'			    = rsmonemi 
		   , 'Flag'				    = IDENTITY(INT,1,1)
		   , 'Prog'                 = '_val_ins' --b.inprog						--PENDIENTE
		   , 'cpcodigo'             = c.cod_familia 
		   , 'difecsal'             = '' 
		   , 'BasEmi'               = ISNULL((SELECT s.base_tasa_emi FROM BacBonosExtSuda..text_ser s  WITH (NOLOCK) WHERE  s.cod_nemo = c.cod_nemo),0)
		   , 'cpnominal'            = rsnominal
		   , 'cptircomp'            = rstir										--REVISAR
		   , 'cpvalcomu'            = rsvalcomu
		   , 'Valor_Contable'       = rsvalcomu 
		   , 'Tasa_Contrato'        = rstir 
		   , 'cpmascara'            = id_instrum
		   , 'cpseriado'            = 'S' 
		   , 'Fecha_PagoMañana'     = rsfecpago
		   , 'cpfecpcup'		    = rsfecpcup
		   , 'cpFecucup'		    = rsFecucup
		   , 'Pendiente_Pago'       = CASE WHEN rsfecpago <= @FechaRep THEN 'N' ELSE 'S' END  
		   , 'Codigo_Producto'      = 0											--PENDIENTE
		   , 'Monto_Pago'           = CASE WHEN rsfecpago <= @FechaRep THEN CONVERT(NUMERIC(17,2),0) ELSE rsnominal END
		   , 'Rut_Cliente'          = 0											--PENDIENTE
		   , 'PERIODICIDAD'         = CASE WHEN (SELECT ts.per_cupones 
		                                         FROM	BacBonosExtSuda..text_ser ts 
		                                         WHERE	ts.Cod_familia	= c.cod_familia
												 AND	ts.cod_nemo		= c.cod_nemo	) = 6 
											THEN 'SEMESTRAL'
											ELSE 'OUTRO' 
		                              END
		  , 'dvEmisor'			= ' ' 		                              
	INTO #TMPBONOS_RSU
	FROM BacBonosExtSuda.dbo.text_rsu c WITH (NOLOCK)
	WHERE  rsfecpro         =  @FechaRep
	AND    rstipoper        = 'DEV'
	AND    rscartera        = 333

	UPDATE #TMPBONOS_RSU
	SET	CalJur = 			CASE 
			WHEN cltipcli = 8 THEN 'PF'
			WHEN cltipcli = 1 THEN 'IF'
			WHEN cltipcli = 2 THEN 'IF'
			WHEN cltipcli = 3 THEN 'IF'
			WHEN cltipcli = 4 THEN 'IF'
			WHEN cltipcli = 5 THEN 'IF'
			WHEN cltipcli = 6 THEN 'IF'
			WHEN cltipcli = 7 THEN 'PJ'
			WHEN cltipcli = 9 THEN 'PJ'
			WHEN cltipcli = 10 THEN 'PJ'
			WHEN cltipcli = 11 THEN 'PJ'
			WHEN cltipcli = 12 THEN 'PJ'
			WHEN cltipcli = 13 THEN 'PJ'
			ELSE  'PJ'
		END 
		,dvEmisor = cldv
		, Pais   = COD_ITAU
	FROM VIEW_CLIENTE,BACPARAMSUDA.DBO.PAIS 
	WHERE clrut = Rutemi AND clpais = codigo_pais
	
	
	DELETE FROM #paso WHERE cpnominal =0
-->	select * from #paso 
-- ***********************************************************************************************************************
-- ***********************************************************************************************************************

	INSERT INTO #PASO
	SELECT    fechaProceso    -- QUERY I
		    , Sistema
			, RUT_CARTERA
			, NUMDOCU
			, CORRELA
			, TIPO_CARTERA
			, Fecproc
			, CodOrigen
			, inserie
			, CodEmpresa		--10
			, ISNULL(FecEmi, '19000101')
			, fecha_compra_original
			, ISNULL(fecvenc, '19000101')
			, mnnemo
			, TasEmi
			, Emisor
			, CodEmisor
			, Rutemi
			, CalJur
			, Pais   --20
			, Cartera
			, Valcomp
			, ValCapital
			, InteresDev
			, Cosif
			, Cosif_Ger
			, ValMdo
			, Util_Mercado
			, Perd_Mercado
			, InteresDevAno   -- 30
			, ReajustesDevAno  
			, DifMercano
			, ValcompAno
			, ValorVenta
			, InteresesporVenta
			, UtilporVenta
			, monedaor
			, CtaAltamira
			, moinstser
			, momonemi  --40			
			, Prog   
			, mocodigo
			, mofecven
			, BasEmi
			, monominal
			, tir_compra_original
			, movalcomu
			, Valor_Contable
			, Tasa_Contrato
			, cpmascara
			, cpseriado
			, Fecha_PagoMañana
			, ISNULL(cpfecpcup, '19000101')
			, ISNULL(cpfecpcup, '19000101')
			, Pendiente_Pago
			, Codigo_Producto
			, Monto_Pago
			, Rut_Cliente
			, PERIODICIDAD
			, dvEmisor
	FROM #Ventas WITH (NOLOCK)
	UNION
	SELECT 	fechaProceso  --  -- QUERY II
			, Sistema 
			, rsrutcart
			, rsnumdocu
			, rscorrela
			, TIPO_CARTERA
			, Fecproc
			, CodOrigen
			, inserie
			, CodEmpresa  --10
			, ISNULL(FecEmi, '19000101')
			, fecha_compra_original
			, fecvenc
			, mnnemo
			, TasEmi
			, Emisor
			, CodEmisor
			, Rutemi
			, CalJur
			, Pais   --20
			, Cartera
			, Valcomp
			, ValCapital
			, InteresDev
			, Cosif
			, Cosif_Ger
			, ValMdo     
			, Util_Mercado 
			, Perd_Mercado 
			, InteresDevAno  --30
			, ReajustesDevAno
			, DifMercano  
			, ValcompAno
			, ValorVenta
			, InteresesporVenta
			, UtilporVenta
			, monedaor
			, CtaAltamira
			, moinstser
			, momonemi    --40
			, Prog
			, mocodigo 
			, mofecven
			, BasEmi
			, monominal
     		, tir_compra_original
			, movalcomu
			, Valor_Contable
			, Tasa_Contrato
			, cpmascara
			, cpseriado
			, Fecha_PagoMañana
			, ISNULL(cpfecpcup, '19000101')  
			, ISNULL(cpfecpcup, '19000101')  
			, Pendiente_Pago
			, Codigo_Producto
			, Monto_Pago
			, Rut_Cliente
			, PERIODICIDAD
			, dvEmisor
	FROM #VCTO WITH (NOLOCK)
	UNION
	SELECT 	fechaProceso 	        -- QUERY III
            ,Sistema 	         
            ,cprutcart 	     
            ,cpnumdocu 	     
            ,cpcorrela 	     
            ,cptipcart 	 			    
            ,Fecproc            
            ,CodOrigen          
            ,inserie            
            ,CodEmpresa         --10
            ,ISNULL(FecEmi, '19000101')			             
            ,cpfeccomp          
            ,ISNULL(fecvenc, '19000101')	             
            ,mnnemo 		     
            ,TasEmi 		     
            ,Emisor 					     
            ,CodEmisor          
            ,Rutemi             
            ,CalJur             
            ,Pais 		 --20             
            ,Cartera                       			     
            ,Valcomp 		     
            ,ValCapital 		 
            ,InteresDev 	--24    		 
            ,Cosif 		     
            ,Cosif_Ger 	     
            ,ValMdo 	         
            ,Util_Mercado       
            ,Perd_Mercado       
            ,InteresDevAno 	 -- 30
            ,ReajustesDevAno    
            ,DifMercano 		 
            ,ValcompAno         
            ,ValorVenta 		 
            ,InteresesporVenta  
            ,UtilporVenta       
            ,monedaor           
            ,CtaAltamira        
            ,cpinstser 		 
            ,dimoneda 	 -- 40					 			 
            ,Prog               
            ,cpcodigo           
            ,difecsal           
            ,BasEmi             
            ,cpnominal          
            ,cptircomp          
            ,cpvalcomu       			   
            ,Valor_Contable     
            ,Tasa_Contrato 			     
            ,cpmascara        
            ,cpseriado          
            ,Fecha_PagoMañana   
            ,ISNULL(cpfecpcup, '19000101') 		 
            ,ISNULL(cpFecucup, '19000101') 					            
			,Pendiente_Pago     
            ,Codigo_Producto    
            ,Monto_Pago        			 
            ,Rut_Cliente        
            ,PERIODICIDAD
            , dvEmisor   
	FROM #TMPBONOS_INV WITH (NOLOCK)
	UNION
	SELECT    fechaProceso    -- QUERY IV
		    , Sistema
			, cprutcart 	     
			, cpnumdocu 	     
			, cpcorrela 	     
			, cptipcart 				     
			, Fecproc            
			, CodOrigen          
			, inserie            
			, CodEmpresa           --10
			, ISNULL(FecEmi, '19000101')
	        , cpfeccomp          
			, ISNULL(fecvenc, '19000101')            
			, mnnemo 		     
			, TasEmi 		     
			, Emisor 		    
			, CodEmisor          
			, Rutemi             
			, CalJur             
			, Pais	 --20   	            
			, Cartera            	     
			, Valcomp 		     
			, ValCapital 		 
			, InteresDev 	     
			, Cosif 		     
			, Cosif_Ger 	     
			, ValMdo 	         
			, Util_Mercado       
			, Perd_Mercado       
			, InteresDevAno 	 --30
			, ReajustesDevAno    
			, DifMercano 		 , ValcompAno         
			, ValorVenta 		 
			, InteresesporVenta  
			, UtilporVenta       
			, monedaor           
			, CtaAltamira        
			, cpinstser 		 
			, dimoneda 			 --40						 
			, Prog               
			, cpcodigo           
			, difecsal       			    
			, BasEmi             
			, cpnominal          
			, cptircomp          
			, cpvalcomu          
			, Valor_Contable     
			, Tasa_Contrato  
			, cpmascara          
			, cpseriado          
			, Fecha_PagoMañana   
			, ISNULL(cpfecpcup, '19000101')  					 
			, ISNULL(cpFecucup, '19000101')  		 
			, Pendiente_Pago      -- ***
			, Codigo_Producto    
			, Monto_Pago         
			, Rut_Cliente        
			, PERIODICIDAD
			, dvEmisor       
	  FROM  #TMPBONOS_RSU WITH (NOLOCK)

---- INSERT TABLA TEMP
IF EXISTS(SELECT 1 FROM [dbo].[INTERFAZ_INVERSIONES] WHERE fechaProceso = @cFecRep)
BEGIN
 DELETE INTERFAZ_INVERSIONES  WHERE fechaProceso = @cFecRep
end 

 --select * from bacparamsuda.dbo.TblRelacionPCtasContables trpc
UPDATE #paso SET CtaAltamira = trpc.CtaIBS, Perd_Mercado = Perd_Mercado *-1 
FROM #paso p 
inner join #TblRelacionPCtasContables trpc 
ON  trpc.idCodigo= 5 AND trpc.sFamilia = p.inserie
AND trpc.idCartera =  CASE	WHEN cartera	='AV'	THEN 'T'
							WHEN cartera	='HD'	THEN 'A'
							WHEN cartera	='TR'	THEN 'P'
							ELSE 'T' 
                      END
AND trpc.iMoneda = p.dimoneda
INNER JOIN BacTraderSuda.dbo.CLIENTE c ON c.Clrut = p.rutemi


UPDATE #paso SET CtaAltamira = trpc.CtaIBS  
FROM #paso p 
inner join #TblRelacionPCtasContables trpc 
ON  trpc.idCodigo= 1 AND trpc.sFamilia = p.inserie
AND trpc.iMoneda = p.dimoneda
where p.inserie='BONOEX'

 
 
 INSERT INTO [dbo].[INTERFAZ_INVERSIONES]
           ([fechaProceso]					-- 1
           ,[Sistema]						-- 2
           ,[cprutcart]						-- 3
           ,[cpnumdocu]						-- 4
           ,[cpcorrela]						-- 5
           ,[cptipcart]						-- 6
           ,[Fecproc]						-- 7
           ,[CodOrigen]						-- 8
           ,[inserie]						-- 9
           ,[CodEmpresa]					-- 10
           ,[FecEmi]						-- 11
           ,[cpfeccomp]						-- 12
           ,[fecvenc]						-- 13
		   ,[mnnemo]						-- 14
           ,[TasEmi]						-- 15
           ,[Emisor]						-- 16
           ,[CodEmisor]						-- 17
           ,[Rutemi]						-- 18
           ,[CalJur]						-- 19
           ,[Pais]							-- 20
           ,[Cartera]						-- 21
           ,[Valcomp]						-- 22 
           ,[ValCapital]					-- 23
           ,[InteresDev]					-- 24
           ,[Cosif]							-- 25
           ,[Cosif_Ger]						-- 26
           ,[ValMdo]						-- 27
           ,[Util_Mercado]					-- 28 
           ,[Perd_Mercado]					-- 29 
           ,[InteresDevAno]					-- 30 
           ,[ReajustesDevAno]				-- 31 
           ,[DifMercano]					-- 32 
           ,[ValcompAno]					-- 33 
           ,[ValorVenta]					-- 34  
           ,[InteresesporVenta]				-- 35  
           ,[UtilporVenta]					-- 36  
           ,[monedaor]						-- 37
           ,[CtaAltamira]					-- 38
		   ,[cpinstser]						-- 39
           ,[dimoneda]						-- 40
           ,[Flag]							-- 41
           ,[Prog]							-- 42
           ,[cpcodigo]						-- 43  
           ,[difecsal]						-- 44
           ,[BasEmi]						-- 45 
           ,[cpnominal]						-- 46  
           ,[cptircomp]						-- 47  
           ,[cpvalcomu]						-- 48
           ,[Valor_Contable]				-- 49  **
		   ,[Tasa_Contrato]					-- 50
           ,[cpmascara]        				-- 51
           ,[cpseriado]						-- 52
           ,[Fecha_PagoManana]				-- 53
           ,[cpfecpcup]						-- 54
           ,[cpFecucup]						-- 55
           ,[Pendiente_Pago]				-- 56
           ,[Codigo_Producto]				-- 57
           ,[Monto_Pago]					-- 58
           ,[Rut_Cliente]					-- 59
           ,[Periodicidad]					-- 60 
		   )
	SELECT  fechaProceso						 -- 1
			, Sistema							 -- 2
		    , cprutcart						     -- 3
		    , cpnumdocu						     -- 4
		    , cpcorrela						     -- 5
		    , cptipcart							 -- 6
			, Fecproc							 -- 7
			, CodOrigen							 -- 8
			, inserie							 -- 9
			, CodEmpresa						 -- 10
			, FecEmi							 -- 11
			, cpfeccomp							 -- 12
			, fecvenc 							 -- 13
			, mnnemo 							 -- 14
			, TasEmi 							 -- 15
			, Emisor							 -- 16
			, CodEmisor							 -- 17
			, ISNULL(Rutemi,0)							 -- 18
			, CalJur							 -- 19
			, Pais								 -- 20
			, ISNULL(Cartera,0)							 -- 21
			, Valcomp							 -- 22 
			, ValCapital						 -- 23
			, InteresDev						 -- 24
			, Cosif								 -- 25
			, Cosif_Ger							 -- 26
			, ValMdo							 -- 27
			, Util_Mercado						 -- 28 
			, Perd_Mercado						 -- 29 
			, InteresDevAno						 -- 30 
			, ReajustesDevAno					 -- 31 
			, DifMercano						 -- 32 
			, ValcompAno						 -- 33 
			, ValorVenta						 -- 34  
			, InteresesporVenta					 -- 35  
			, UtilporVenta						 -- 36  
			, monedaor							 -- 37
			, CtaAltamira						 -- 38
			, cpinstser							 -- 39
			, dimoneda							 -- 40
			, Flag								 -- 41
			, Prog								 -- 42
			, cpcodigo							 -- 43  
			, difecsal							 -- 44
			, isnull(BasEmi,0)							 -- 45 
			, cpnominal							 -- 46  
			, cptircomp							 -- 47  
			, cpvalcomu							 -- 48
			, Valor_Contable					 -- 49  **
			, Tasa_Contrato						 -- 50
			, cpmascara							 -- 51
			, cpseriado							 -- 52
			, Fecha_PagoMañana					 -- 53
			, cpfecpcup							 -- 54
			, cpFecucup							 -- 55
			, Pendiente_Pago					 -- 56
			, Codigo_Producto					 -- 57
			, Monto_Pago						 -- 58
			, Rut_Cliente						 -- 59
			, PERIODICIDAD                       -- 60 
	FROM #PASO WITH (NOLOCK)
 	ORDER BY Flag


 	   
-- -- Select Final : 
	SELECT   cprutcart             -- 1
		   , cpnumdocu 			   -- 2
		   , cpcorrela 			   -- 3
		   , cptipcart 			   -- 4
		   , Fecproc 			   -- 5
		   , CodOrigen 			   -- 6
		   , inserie 			   -- 7dd
		   , CodEmpresa 		   -- 8
		   , FecEmi 			   -- 9
		   , cpfeccomp 			   -- 10
		   , fecvenc 			   -- 11
		   , mnnemo 			   -- 12
		   , TasEmi 			   -- 13
		   , Emisor 			   -- 14
		   , CodEmisor 			   -- 15
		   ,  convert(varchar(20),convert(numeric(12),Rutemi)) + '-'+ ISNULL(vc.Cldv,'') AS Rutemi			   -- 16
		   , CalJur 			   -- 17
		   , Pais 				   -- 18
		   , Cartera 			   -- 19
		   , CASE WHEN Valcomp =0 THEN  ValCapital ELSE  Valcomp END 			   -- 20
		   , ValCapital 		   -- 21
		   , InteresDev 		   -- 22
		   , Cosif 				   -- 23
		   , Cosif_Ger 			   -- 24
		   , CASE WHEN ValMdo=0 THEN ValCapital ELSE  ValMdo END 			   -- 25
		   , Util_Mercado 		   -- 26
		   , Perd_Mercado	   -- 27
		   , InteresDevAno 		   -- 28
		   , ReajustesDevAno 	   -- 29
		   , DifMercano 		   -- 30
		   , ValcompAno 		   -- 31
		   , ValorVenta 		   -- 32
		   , InteresesporVenta 	   -- 33
		   , UtilporVenta 		   -- 34
		   , monedaor 			   -- 35
		   , CtaAltamira 		   -- 36
		   , cpinstser 			   -- 37
		   , dimoneda 			   -- 38
		   , Flag
		   , Prog 				   -- 39
		   , cpcodigo 			   -- 40
		   , difecsal 			   -- 41
		   , BasEmi 			   -- 42
		   , cpnominal			   -- 43
		   , cptircomp			   -- 44
		   , cpvalcomu			   -- 45
		   , Valor_Contable 	   -- 46
		   , Tasa_Contrato 		   -- 47
		   , cpmascara 			   -- 48
		   , cpseriado 			   -- 49
		   , Fecha_PagoManana 	   -- 50
		   , cpfecpcup 			   -- 51
		   , cpFecucup 			   -- 52
		   , Pendiente_Pago 	   -- 53
		   , Codigo_Producto 	   -- 54
		   , Monto_Pago 		   -- 55
		   , Rut_Cliente 		   -- 56
		   , PERIODICIDAD		   -- 57
		 FROM dbo.INTERFAZ_INVERSIONES c  WITH (NOLOCK)
		left JOIN VIEW_CLIENTE vc ON vc.Clrut = c.Rutemi		 
	WHERE fechaProceso = @FechaRep
		 ORDER BY Flag

	SET NOCOUNT OFF 
END
GO
