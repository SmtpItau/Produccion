USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_CarteraTotal]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_CarteraTotal] (@nFinMes NUMERIC(01) )
AS
BEGIN
DECLARE @xRutEmi  CHAR(10),
	  @xNomEmi  CHAR(50),
	  @xInstser char(12),
	  @xUm	    CHAR(3),
	  @xTipoOpe CHAR(50),
	  @xFecVcto DATETIME,
	  @xTirComp numeric(9,4),
	  @xTasaMerc numeric(9,4),
	  @xNominal numeric(19,4),
	  @xVpresen numeric(19,4),
	  @xValMerc numeric(19,4),
@nOrden   INT,
@cxTipCar INT,
	  @cCuentgl Char(08),
	  @cCtaSup  Char(10),
	  @nn	    INT,
	  @nCont    INT


DECLARE @xSistema 	Char(03),
@xTipoMov 	Char(03),
@TipOpe   	Char(05),
	  @codins   	Char(12),
	  @xMoneda  	Numeric(3),
	  @TipoCartera 	Numeric(9),
	  @xRutCli     	Numeric(9),
	  @xCodCli     	Numeric(9),
	  @dFecini     	Datetime,
	  @dFecFin     	Datetime,
	  @xGarantia   	Char(01),
	  @NumDocu     	Numeric(10),
	  @Numoper     	Numeric(10),
	  @Correla     	Numeric(03),
	  @Folio_Perfil Numeric(05),
	  @CodCamCond   Numeric(03),
	  @cCond        Char(03),
	  @nReg     INT,
@nSuma    FLOAT,
	  @nMonpact CHAR(03),
	  @Una_Vez  INT,
	  @RutCli 	NUMERIC(09),
	  @nTasa  	FLOAT,
	  @cFini	DATETIME,
	  @xnPlazo 	INT,
	  @xnTasa  	DATETIME,
	  @xncodcli     NUMERIC(09)



DECLARE @cEstado CHAR(1),
	  @xTipCar NUMERIC(5),
	  @xmonemi NUMERIC(3),
	  @Um      CHAR(3),
	  @cSerie  CHAR(6),
	  @NomEmi  CHAR(50),
	  @xnumdocu NUMERIC(10),
	  @dFecpro DATETIME,
	  @cNemo CHAR(12),
	  @cGenerico CHAR(12),
	  @cLlave CHAR(70),
	  @nTasaMerc NUMERIC(9,4),
	  @xcodigo NUMERIC(5),
	  @xcorrela NUMERIC(3),
	  @xFecemi DATETIME,
	  @nTasemi NUMERIC(9,4),
	  @xNomiTot NUMERIC(19,4),
	  @xfecven DATETIME,
	  @nPlazo INTEGER,
	  @nbasemi INTEGER,
	  @ntasest NUMERIC(9,4),
	  @dFecpcup DATETIME,
@cTasEmision CHAR(7),
	  @dFecProx DATETIME
	

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
	  @cProg CHAR(14),
	  @dFecucup DATETIME,
@fecucup DATETIME,
@nNominal FLOAT

DECLARE	  @dFecpro_aux Datetime,
	  @dFecSalida  Datetime,
	  @dFecCierre  datetime,	
	  @dFecesp     datetime,	
	  @mes_esp     CHAR(1) ,
	  @tc_rep_cnt  CHAR(01),
	  @DO_TC FLOAT


SELECT @DO_TC   = isnull(TIPO_CAMBIO,0)     /* Dolar T/C Rep. Contable */
FROM BacParamSuda..VALOR_MONEDA_CONTABLE,MDAC
WHERE CODIGO_MONEDA = 994 AND FECHA = ACFECPROC


	IF @DO_TC=0 BEGIN
	 SELECT @tc_rep_cnt = 'N'   /* SE OCUPA T/C OBS */
END ELSE BEGIN
		 SELECT @tc_rep_cnt = 'S'   /* SE OCUPA T/C REP CONTABLE */
	END


	SELECT @dFecpro_aux = acfecproc From Mdac
	EXECUTE dbo.sp_TraeNexthabil @dFecpro_aux,6,@dFecSalida OUTPUT

SELECT @dFecCierre = @dFecpro_aux
	SELECT @dFecesp    = @dFecpro_aux
	SELECT @mes_esp = 'N'

If @nFinMes = 1 BEGIN
	   If Datepart(mm,@dFecpro_aux) <> Datepart(mm,@dFecSalida)BEGIN
	      SELECT @dFecCierre = Dateadd(day, datepart(day,@dFecSalida) * -1 ,@dFecSalida)
	      SELECT @dFecesp    = @dFecpro_aux
	      SELECT @mes_esp    = 'S'
	   END
End

CREATE TABLE #tmpmdcp ( xTipCar   CHAR(10), --NUMERIC(05),   
		xnumdocu  NUMERIC(10),
			xnumoper  NUMERIC(10),
	 		xcorrela  NUMERIC(3),
	 		xInstser  CHAR(12),
			xMascara  CHAR(12),
	 		xTipoOpe  CHAR(5),
	 		xFecVcto  DATETIME,
	 		xTirComp  NUMERIC(9,4),
	 		xNominal  NUMERIC(19,4),
	 		xVpresen  NUMERIC(19,4),
		xCodigo   NUMERIC(5),
	 		xFecemi   DATETIME,
	 		xrutemi   NUMERIC(9),
			xcodclie  NUMERIC(9),
		xmonemi   NUMERIC(3),
	 		nTasemi   FLOAT,

		nbasemi   NUMERIC(3),
	 		ntasest   NUMERIC(9,4),
		Um        CHAR(5),
		Serie     CHAR(10),
		NomEmi    CHAR(70),
		Plazo     NUMERIC(5),
	 		Nemo      CHAR(15),
		Llave     CHAR(100),
		Generico CHAR(15),
	 		TasaMerc  NUMERIC(9,4),
	 		Valmerc   NUMERIC(19,4),
	 		Prog      CHAR(15),
			Orden     NUMERIC(3),
			TotCl     FLOAT,
		   	xMontoOriginal FLOAT,
		   	xMontoOrigPacto FLOAT,
			Feccomp	  DATETIME,
			xFecAnt   Datetime,
			xFecPos	  Datetime,
			xMonPact  FLOAT,
			xValinip  FLOAT,
			xFecinip  DATETIME,
		Flag INT IDENTITY(1,1),
			VerVP     CHAR(01),
			FecPago   DATETIME,
			xRiesgo   varchar(05) )  --MMP 13-04-2011

/*  Proceso para cartera Propia  */
SET NOCOUNT ON
SELECT @dFecpro = acfecproc , @dFecProx = acfecprox FROM MDAC

INSERT #tmpmdcp (xTipCar,
				 xnumdocu,
				 xcorrela,
				 xInstser,
				 xMascara,
				 xTipoOpe,
				 xFecVcto,
				 xTirComp,
				 xNominal,
				 xVpresen,
				 xCodigo,
				 xFecemi,
				 xrutemi,
				 xcodclie,
				 xmonemi,
				 nTasemi,
				 nbasemi,
				 ntasest,
				 Um,
				 Serie,
				 NomEmi,
				 Plazo,
				 Nemo,
				 Llave,
				 Generico,
				 TasaMerc,
				 Valmerc,
				 Prog,
				 Orden,
				 xMontoOriginal,
				 xMontoOrigPacto,
				 Feccomp,
				 xFecAnt,
				 xFecPos,
				 VerVP,
				 FecPago,
		   xRiesgo ) --MMP 13-04-2011
SELECT DISTINCT
			MDCP.codigo_carterasuper,
cpnumdocu,
	     cpcorrela,
	     cpinstser,
	     CpMascara,
	     'CP',
	     cpfecven,
	     cptircomp,
	     cpnominal + Isnull( (SELECT sum(vinominal) FROM MDVI WHERE vinumdocu = cpnumdocu AND vicorrela = cpcorrela) ,0.0),
	     cpvptirc + Isnull( (SELECT sum(vivptirc) FROM MDVI WHERE vinumdocu = cpnumdocu AND vicorrela = cpcorrela) ,0.0),
cpcodigo,
	     cpfecemi,
	     CASE WHEN cpseriado = 'S' THEN Isnull((SELECT serutemi FROM view_serie WHERE semascara = cpmascara),0)
ELSE Isnull((SELECT nsrutemi FROM VIEW_NOSERIE WHERE nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela),0) END,
	     cpcodcli,
	     CASE WHEN cpseriado = 'S' THEN Isnull((SELECT semonemi FROM view_serie WHERE semascara = cpmascara),0)
ELSE Isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela),0) END,
	     CASE WHEN cpseriado = 'S' THEN Isnull((SELECT setasemi FROM view_serie WHERE semascara = cpmascara),0)
ELSE Isnull((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela),0) END,
	     CASE WHEN cpseriado = 'S' THEN Isnull((SELECT sebasemi FROM view_serie WHERE semascara = cpmascara),0)
ELSE Isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela),0) END,
	     0,
Space(5),
(SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo),
	     Space(50),
	     DATEDIFF(dd,@dFecpro,cpfecven),
Space(12),
Space(25),
Space(12),
	     isnull(tasa_mercado,0),--** 0,
	     0,
	     'sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo),
	     1,
	     Valor_Contable + Isnull( (SELECT sum(Valor_Contable) FROM MDVI WHERE vinumdocu = cpnumdocu AND vicorrela = cpcorrela) ,0),
	     0,
	     Cpfeccomp,
	     CASE WHEN (cpfecucup <= fecha_pagomañana Or charindex('*',cpinstser)>0 or charindex('&',cpinstser)>0) THEN fecha_pagomañana ELSE cpfecucup END,
	     cpfecpcup,
	     (CASE WHEN (EXISTS(Select top 1 vinumdocu from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) Or cpnominal > 0) THEN ' ' ELSE 'X' END),
	     Fecha_Pagomañana,
	     ID_NIVEL_DE_RIESGO = 0  -- MMP 13-04-2011
FROM MDCP LEFT JOIN  VALORIZACION_MERCADO ON  rmnumdocu = cpnumdocu 
                 AND  rmcorrela = cpcorrela 
                 AND  tipo_operacion IN ( 'CP' , 'VI')   
                 AND fecha_valorizacion = @dFecpro_aux  
WHERE  (cpnominal>0 or EXISTS(Select 1 from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela))



-- Fin de mes especial
	 IF @mes_esp = 'S' and @nFinMes = 1 begin

	   UPDATE	#tmpmdcp
	   SET		xVpresen = ( SELECT SUM(rsvppresenx) FROM mdrs
			WHERE	rsfecha=@dFecCierre
			AND	rscodigo<>98
			AND	rscartera in (111,114)
			AND	rstipoper='DEV'
			and	rsnumdocu = xnumdocu
			and	rscorrela = xcorrela )

	END	

/* Incluir Ventas Propias como CP */

INSERT #tmpmdcp (xTipCar,
	   xnumdocu,
	 	   xcorrela,
	 	   xInstser,
		   xMascara,
	 	   xTipoOpe,
	 	   xFecVcto,
	 	   xTirComp,
	 	   xNominal,
	 	   xVpresen,
	   xCodigo,
	 	   xFecemi,
	 	   xrutemi,
		   xcodclie,
	   xmonemi,
	 	   nTasemi,
	   nbasemi,
	 	   ntasest,
	   Um,
	   Serie,
	   NomEmi,
	   Plazo,
	 	   Nemo,
	   Llave,
	   Generico,
	 	   TasaMerc,
	 	   Valmerc,
	 	   Prog,
		   Orden,
		   xMontoOriginal,
		   xMontoOrigPacto,
		   Feccomp,
		   xFecAnt,
		   xFecPos,
		   VerVP,	
		   FecPago,
		   xRiesgo ) --MMP 13-04-2011
SELECT  Mdcp.codigo_carterasuper, -- TIPO_CARTERA,
NUMDOCU,
	     CORRELA,
	     INSTSER,
	     MASCARA,
	     'CP',
	     FECVENC,
	     TIRCOMP,
	     NOMINAL,
	     VPRESEN,
CODIGO,
	     FECEMIS,
	     RUTEMIS,
	     CODCLI,
	     MONEMIS,
	     TASEMIS,
	     BASEEMIS,
	     0,
Space(5),
INST,
	     Space(50),
	     DATEDIFF(dd,@dFecpro,FECVENC),
Space(12),
Space(25),
Space(12),
	    isnull(tasa_mercado,0),--** 0,
	     0,
	     'sp_' + PROG,
	     1,
	     VALORCONTABLE,
	     0,
	     FECCOMP,
	     CASE WHEN (FECUCUP <= FECHAPAGO Or CharIndex('*',INSTSER)>0 Or CharIndex('&',INSTSER)>0) THEN Mdcp.Fecha_Pagomañana ELSE FECUCUP END,
	     FECPCUP,
	     'S',
	     Mdcp.Fecha_Pagomañana,   -- FECHAPAGO ** En este campo deberia grabarce la fecha
				     -- pago del papel original, y en el campo VENTAFECHAPAGO se
				     -- debe grabar la fecha de pago de la venta
				     -- Esto influiria en el stock de cartera,ya que esta ocupando
				     -- el campo FECHAPAGO en las actualizaciones de las VENTAS
	     ID_NIVEL_DE_RIESGO = 0 --MMP 13-04-2011
FROM VIEW_TABLA_VENTAS 
INNER JOIN Mdcp ON numdocu = mdcp.cpnumdocu and correla = mdcp.cpcorrela
LEFT JOIN  VALORIZACION_MERCADO ON rmnumdocu = cpnumdocu 
     AND rmcorrela = cpcorrela 
     AND  tipo_operacion = 'CP'  
     AND fecha_valorizacion = @dFecpro_aux  
WHERE Tipo_Listado = 'S' 


--MMP 13-04-2011
/* Incluir Ventas Propias como Disponibilidad */
INSERT #tmpmdcp (xTipCar,
	   xnumdocu,
	 	   xcorrela,
	 	   xInstser,
		   xMascara,
	 	   xTipoOpe,
	 	   xFecVcto,
	 	   xTirComp,
	 	   xNominal,
	 	   xVpresen,
	   xCodigo,
	 	   xFecemi,
	 	   xrutemi,
		   xcodclie,
	   xmonemi,
	 	   nTasemi,
	   nbasemi,
	 	   ntasest,
	   Um,
	   Serie,
	   NomEmi,
	   Plazo,
	 	   Nemo,
	   Llave,
	   Generico,
	 	   TasaMerc,
	 	   Valmerc,
	 	   Prog,
		   Orden,
		   xMontoOriginal,
		   xMontoOrigPacto,
		   Feccomp,
		   xFecAnt,
		   xFecPos,
		   VerVP,	
		   FecPago,
		   xRiesgo ) --MMP 13-04-2011
SELECT TIPO_CARTERA,
NUMDOCU,
	     CORRELA,
	     INSTSER,
	     MASCARA,
	     'DI',
	     FECVENC,
	     TIRCOMP,
	     NOMINAL,
	     VPRESEN,
CODIGO,
	     FECEMIS,
	     RUTEMIS,
	     CODCLI,
	     MONEMIS,
	     TASEMIS,
	     BASEEMIS,
	     0,
Space(5),
INST,
	     Space(50),
	     DATEDIFF(dd,@dFecpro,FECVENC),
Space(12),
Space(25),
Space(12),
	    isnull(tasa_mercado,0),--** 0,
	     0,
	     'sp_' + PROG,
	     1,
	     VALORCONTABLE,
	     0,
	     FECCOMP,
CASE WHEN (FECUCUP <= FECHAPAGO Or CharIndex('*',INSTSER)>0 Or CharIndex('&',INSTSER)>0) THEN Mdcp.Fecha_Pagomañana ELSE FECUCUP END,
	     FECPCUP,
	     'S',
	     Mdcp.Fecha_Pagomañana,   -- FECHAPAGO ** En este campo deberia grabarce la fecha
				     -- pago del papel original, y en el campo VENTAFECHAPAGO se
				     -- debe grabar la fecha de pago de la venta
				     -- Esto influiria en el stock de cartera,ya que esta ocupando
				     -- el campo FECHAPAGO en las actualizaciones de las VENTAS PM
	     ID_NIVEL_DE_RIESGO = 0
FROM VIEW_TABLA_VENTAS
INNER JOIN Mdcp ON numdocu = mdcp.cpnumdocu and correla = mdcp.cpcorrela 
LEFT JOIN  VALORIZACION_MERCADO  ON rmcorrela = cpcorrela AND rmnumdocu = cpnumdocu  
AND  tipo_operacion = 'CP'
AND fecha_valorizacion = @dFecpro_aux  
WHERE Tipo_Listado = 'S' 

INSERT #tmpmdcp (xTipCar,
	   xnumdocu,
	 	   xcorrela,
	 	   xInstser,
		   xMascara,
	 	   xTipoOpe,
	 	   xFecVcto,
	 	   xTirComp,
	 	   xNominal,
	 	   xVpresen,
	   xCodigo,
	 	   xFecemi,
	 	   xrutemi,		
		   xcodclie,
	   xmonemi,
	 	   nTasemi,
	   nbasemi,
	 	   ntasest,
	   Um,
	   Serie,
	   NomEmi,
	   Plazo,
	 	   Nemo,
	   Llave,
	   Generico,
	 	   TasaMerc,
	 	   Valmerc,
	 	   Prog,
		   Orden,
		   xMontoOriginal,
		   xMontoOrigPacto,
		   Feccomp,
		   VerVP,
		   FecPago,
		   xRiesgo ) --MMP 13-04-2011
	
SELECT  mdci.codigo_carterasuper, -- citipcart,
cinumdocu,
	     cicorrela,
	     ciinstser,
	     ciMascara,
	     'CPI',
	     cifecven,
	     citircomp,
	     cinominal + Isnull( (SELECT sum(vinominal) FROM MDVI WHERE vinumdocu = cinumdocu AND vicorrela = cicorrela) ,0),
	     civptirc + Isnull( (SELECT sum(vivptirc) FROM MDVI WHERE vinumdocu = cinumdocu AND vicorrela = cicorrela) ,0),
cicodigo,
	     cifecemi,
	     CASE WHEN ciseriado = 'S' THEN Isnull((SELECT serutemi FROM view_serie WHERE semascara = cimascara),0)
ELSE Isnull((SELECT nsrutemi FROM VIEW_NOSERIE WHERE nsrutcart = cirutcart AND nsnumdocu = cinumdocu AND nscorrela = cicorrela),0) END,
	     cicodcli,
	     CASE WHEN ciseriado = 'S' THEN Isnull((SELECT semonemi FROM view_serie WHERE semascara = cimascara),0)
ELSE Isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsrutcart = cirutcart AND nsnumdocu = cinumdocu AND nscorrela = cicorrela),0) END,
	     CASE WHEN ciseriado = 'S' THEN Isnull((SELECT setasemi FROM view_serie WHERE semascara = cimascara),0)
ELSE Isnull((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsrutcart = cirutcart AND nsnumdocu = cinumdocu AND nscorrela = cicorrela),0) END,
	     CASE WHEN ciseriado = 'S' THEN Isnull((SELECT sebasemi FROM view_serie WHERE semascara = cimascara),0)
ELSE Isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsrutcart = cirutcart AND nsnumdocu = cinumdocu AND nscorrela = cicorrela),0) END,
	     0,
Space(5),
(SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cicodigo),
	     Space(50),
	     DATEDIFF(dd,@dFecpro,cifecven),
Space(12),
Space(25),
Space(12),
	     isnull(tasa_mercado,0),--**0,
	     0,
	     'sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = cicodigo),
	     1,
	     Valor_Contable, -- valor contable ????????????????????????????
	     0, -- valor contable Pactos
	     cifecinip,
	     ' ',
	     cifecinip,
	     ID_NIVEL_DE_RIESGO = 0 --MMP 14-04-2011
FROM MDCI 
LEFT JOIN VALORIZACION_MERCADO ON rmnumdocu = cinumdocu AND rmcorrela = cicorrela AND fecha_valorizacion = @dFecpro_aux 
WHERE cimascara <> 'ICOL' AND cimascara <> 'ICAP' 


	 IF @mes_esp = 'S' and @nFinMes = 1 begin

	   UPDATE	#tmpmdcp
	   SET		xVpresen = ( SELECT SUM(rsvppresenx) FROM mdrs
			WHERE	rsfecha=@dFecCierre
			AND	rscodigo<>98
			AND	rscartera in (112,114)
			AND	rstipoper='DEV'
			and	rsnumdocu = xnumdocu
			and	rscorrela = xcorrela
			and     rstipopero = 'CI')
	   WHERE  xTipoOpe ='CPI'
	END	
--

UPDATE #tmpmdcp
SET Um = Isnull((SELECT mnnemo FROM View_moneda WHERE mncodmon = xmonemi),''),
NomEmi = Isnull((SELECT emnombre from view_emisor WHERE emrut = xrutemi),''),
Nemo   = (CASE 	WHEN Serie = 'PCD' THEN (CASE WHEN xmonemi = 994 THEN 'PCDDO' ELSE 'PCDDA' END)
			WHEN Serie = 'LCHR' THEN ltrim(rtrim(Serie))+ CONVERT(CHAR(7),nTasemi)
		ELSE Serie END )

UPDATE #tmpmdcp
SET Generico = Isnull((SELECT Clasificacion FROM Tramo_Tasa WHERE Nemo = Nemotecnico_Instrumento AND Plazo Between Desde And Hasta and xRiesgo = ID_NIVEL_RIESGO),'')

UPDATE #tmpmdcp
SET Llave = (CASE WHEN CHARINDEX('LCHR',Nemo) > 0
THEN SUBSTRING(xinstser,1,3) + Ltrim(Rtrim(Generico)) + '  ' + CONVERT(CHAR(7),nTasemi)
		    ELSE (Isnull((SELECT Clasificacion FROM Tramo_Tasa WHERE Nemo = Nemotecnico_Instrumento AND Plazo Between Desde And Hasta and xRiesgo = ID_NIVEL_RIESGO),Nemo))
END)

/*  Proceso para Disponibilidad */
INSERT #tmpmdcp ( xTipCar,
	    xnumdocu,
	 	    xcorrela,
	 	    xInstser,
		    xMascara,
	 	    xTipoOpe,
	 	    xFecVcto,
	 	    xTirComp,
	 	    xNominal,
	 	    xVpresen,
	    xCodigo,
	 	    xFecemi,
	 	    xrutemi,
		    xcodclie,
	    xmonemi,
	 	    nTasemi,
	    nbasemi,
	 	    ntasest,
	    Um,
	    Serie,
	    NomEmi,
	    Plazo,
	 	    Nemo,
	    Llave,
	    Generico,
	 	    TasaMerc,
	 	    Valmerc,
	 	    Prog,
		    Orden,
		    xMontoOriginal,
		    xMontoOrigPacto,
		    Feccomp,
		    xFecAnt,
		    xFecPos,
		    VerVP,
		    Fecpago,
		    xRiesgo ) --MMP 13-04-2011

	SELECT      MDDI.codigo_carterasuper, --ditipcart,
dinumdocu,
	            dicorrela,
	   	    diinstser,
		    (CASE WHEN ditipoper = 'CP' THEN Isnull((SELECT cpmascara FROM mdcp WHERE cpnumdocu = dinumdocu AND cpcorrela=dicorrela ),'') ELSE Isnull((SELECT cimascara FROM mdci WHERE cinumdocu = dinumdocu AND cicorrela=dicorrela ),'') END),
	            (CASE WHEN ditipoper = 'CP' THEN 'DI' ELSE 'DII' END),
		    (CASE WHEN ditipoper = 'CP' THEN Isnull((SELECT cpfecven FROM mdcp WHERE cpnumdocu = dinumdocu AND cpcorrela=dicorrela ),'') ELSE Isnull((SELECT cifecven FROM mdci WHERE cinumdocu = dinumdocu AND cicorrela=dicorrela ),'') END),
	            --difecsal,
	            ditircomp,
	 	    dinominal,
(CASE WHEN ditipoper = 'CP' THEN divptirc ELSE Isnull((SELECT civptirc FROM mdci WHERE cinumdocu = dinumdocu AND cicorrela=dicorrela ),0) END),
	    0,   --  cpcodigo, ??????????????????????????????????????
	 	    '',  -- cpfecemi, ???????????????????????????????????????
	 	    0,  -- xrutemi   ?????????????????????????????????????
		    (SELECT cpcodcli From mdcp where cprutcart = dirutcart and cptipcart = ditipcart and cpnumdocu = dinumdocu and cpcorrela=dicorrela),
	    dimoneda,
	 	    0,    -- nTasemi  ?????????????????????????????????????
	    0,   -- nbasemi  ??????????????????????????????
	 	    0,   -- 'ntasest'
	    dinemmon,  -- 'Um'
	    diserie,   -- 'Serie'
	    '',       -- 'NomEmi'
		    DATEDIFF(dd,@dFecpro, (CASE WHEN ditipoper = 'CP' THEN difecsal ELSE (SELECT cifecven FROM Mdci Where cirutcart = dirutcart AND citipcart = ditipcart AND cinumdocu = dinumdocu AND cicorrela = dicorrela ) END)),
--         	    DATEDIFF(dd,@dFecpro,difecsal), -- ????????????????????????
	            '', -- 'Nemo'
'',   -- 'Llave'
	    '',   -- 'Generico'
	 	    isnull(tasa_mercado,0),--**0,    -- 'TasaMerc'
	 	    0,    -- 'Valmerc'
	            '',   -- 'Prog'
		    2,
		    Valor_Contable,
		    0,
		    Isnull((Select cpfeccomp from mdcp where cprutcart = dirutcart and cptipcart = ditipcart and cpnumdocu = dinumdocu And cpcorrela = dicorrela ),''),
		    '',
		    '',
		    (CASE WHEN (EXISTS(Select 1 from mdvi Where vinumdocu = dinumdocu and vicorrela = dicorrela) Or dinominal > 0) THEN ' ' ELSE 'X' END),
		    Fecha_PagoMañana,
	            ID_NIVEL_DE_RIESGO = 0 --MMP 14-04-2011
	FROM MDDI
	LEFT JOIN VALORIZACION_MERCADO ON rmnumdocu =dinumdocu  AND  rmcorrela =dicorrela  AND fecha_valorizacion = @dFecpro_aux AND tipo_operacion =ditipoper  
	WHERE DIFECSAL > @dFecpro and (dinominal>0 or (EXISTS(Select 1 from mdvi Where vinumdocu = dinumdocu and vicorrela = dicorrela) Or dinominal > 0))

--
	 IF @mes_esp = 'S' and @nFinMes = 1 begin

	   UPDATE	#tmpmdcp
			SET	xVpresen = rsvppresenx
			FROM	mdrs
			WHERE	rsfecha=@dFecCierre
			AND	rscodigo<>98
			AND	rscartera='111'
			AND	rstipoper='DEV'
			and	rsnumdocu = xnumdocu
			and	rscorrela = xcorrela
			and     left(xTipoOpe,2)  = 'DI'
	END	
--


DELETE #tmpmdcp WHERE VerVp = 'X'

UPDATE #tmpmdcp
SET xcodigo = (SELECT incodigo FROM view_instrumento WHERE inserie = Serie)
   ,xrutemi = ISNULL((SELECT serutemi FROM view_serie WHERE semascara = xMascara) ,ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE nsnumdocu = xnumdocu AND nscorrela = xcorrela),0))
   ,xmonemi = ISNULL((SELECT semonemi  FROM view_serie WHERE semascara = xMascara),ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsnumdocu = xnumdocu AND nscorrela = xcorrela),0))
   ,nTasemi = ISNULL((SELECT setasemi  FROM view_serie WHERE semascara = xMascara),ISNULL((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsnumdocu = xnumdocu AND nscorrela = xcorrela),0))
   ,nbasemi = ISNULL((SELECT sebasemi  FROM view_serie WHERE semascara = xMascara),ISNULL((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsnumdocu = xnumdocu AND nscorrela = xcorrela),0))
   ,xfecemi = ISNULL((SELECT sefecemi FROM view_serie WHERE semascara = xMascara) ,ISNULL((SELECT nsfecemi FROM VIEW_NOSERIE WHERE nsnumdocu = xnumdocu AND nscorrela = xcorrela),0))
   ,ntasest = 0
--      xFecAnt = Isnull((SELECT xFecant FROM #tmpmdcp WHERE xTipoOpe = 'CP' AND xnumdocu = xnumdocu AND xcorrela = xcorrela),'' ),
--      xFecPos = Isnull((SELECT xFecPos FROM #tmpmdcp WHERE xTipoOpe = 'CP' AND xnumdocu = xnumdocu AND xcorrela = xcorrela),'' )
WHERE (xTipoOpe = 'DI' OR xTipoOpe = 'DII')

UPDATE #tmpmdcp
SET Um = Isnull((SELECT mnnemo FROM View_moneda WHERE mncodmon = xmonemi),''),
NomEmi = (SELECT emnombre from view_emisor WHERE emrut = xrutemi),
Nemo   = (CASE WHEN Serie = 'PCD' THEN (CASE WHEN xmonemi = 994 THEN 'PCDDO' ELSE 'PCDDA' END)
		     WHEN Serie = 'LCHR' THEN ltrim(rtrim(Serie))+ CONVERT(CHAR(7),nTasemi)
		ELSE Serie END ),
Prog   = (CASE WHEN @tc_rep_cnt = 'S' AND xmonemi = 994 THEN 'sp_tcrc' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = xcodigo)
		     ELSE 'sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = xcodigo)
		     END)
WHERE (xTipoOpe = 'DI' OR xTipoOpe = 'DII')

UPDATE #tmpmdcp
SET Generico = Isnull(( SELECT Clasificacion 
						FROM Tramo_Tasa 
						WHERE Nemo = Nemotecnico_Instrumento AND Plazo Between Desde And Hasta and xRiesgo = ID_NIVEL_RIESGO),'')
WHERE (xTipoOpe = 'DI' OR xTipoOpe = 'DII')




UPDATE #tmpmdcp
SET Llave = (CASE WHEN CHARINDEX('LCHR',Nemo) > 0
THEN SUBSTRING(xinstser,1,3) + Ltrim(Rtrim(Generico)) + '  ' + CONVERT(CHAR(7),nTasemi)
	      	   ELSE (Isnull((SELECT Clasificacion FROM Tramo_Tasa WHERE Nemo = Nemotecnico_Instrumento AND Plazo Between Desde And Hasta and xRiesgo = ID_NIVEL_RIESGO),Nemo))
END)
WHERE (xTipoOpe = 'DI' OR xTipoOpe = 'DII')


SELECT @nCont = MAX(Flag) From #tmpmdcp -- Where xTipoOpe = 'DI' OR xTipoOpe = 'DII'
SELECT @nn    = MIN(Flag) From #tmpmdcp --Where xTipoOpe = 'DI' OR xTipoOpe = 'DII'

-- VMGS Se debe eliminar de este reporte las letras de credito hiopotecarias propia emision debido a la nueva normativa
-- contable (Octubre del 2002)

-- CROG Se reestablecen las letras de credito hiopotecarias propia emision  por ser un Reporte
-- casa matriz no contable
-- *******************************************************************************************
-- DELETE #tmpmdcp WHERE SUBSTRING (xInstser,1,3) = 'BOT' AND Serie = 'LCHR'
-- *******************************************************************************************




WHILE @nn <= @nCont
BEGIN

SELECT @xnumdocu = isnull(xnumdocu,0),
@xcorrela = xcorrela,
@cProg    = Prog,
@xcodigo  = xcodigo,
	  @xinstser = xinstser,
@xmonemi  = xmonemi,
	  @xfecemi  = xfecemi,
@xFecVcto = xFecVcto,
@ntasemi  = nTasemi,
@nbasemi  = nBasemi,
	  @ntasest  = ntasest,
	  @xNomiTot = xNominal,
	  @nTasaMerc = TasaMerc
FROM #tmpmdcp WHERE flag = @nn  

If @xnumdocu > 0 Begin
	Select @fPvp = 0
	Select @fMt = 0
	Select @fMtum = 0
	Select @fMt_cien = 0
	Select @fVan = 0
	Select @fVpar = 0
	Select @nNumucup = 0
	Select @dFecucup = ''
	Select @fIntucup = 0
	Select @fAmoucup = 0
	Select @fSalucup = 0
	Select @nNumpcup = 0
	Select @fIntpcup = 0
	Select @fAmopcup = 0
	Select @fSalpcup = 0
	Select @fDurat   = 0
	Select @fConvx   = 0
	Select @fDurmo   = 0
		
		
		EXECUTE @nError = @cProg 2, @dFecCierre, @xcodigo,@xinstser, @xmonemi, @xfecemi, @xFecVcto,
		@ntasemi, @nbasemi, @ntasest,@xNomiTot OUTPUT, @nTasaMerc OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
		@fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
	      		@fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
		@fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

	--INCORPORADO PARA FUSIÓN
	IF (@tc_rep_cnt = 'S' AND @xmonemi = 994)
	   BEGIN  
	        SET  @fMt = @fMTUM * @DO_TC
	   END  
	--INCORPORADO PARA FUSIÓN

	UPDATE #tmpmdcp
	SET ValMerc = @fMt
	WHERE flag = @nn
End

SELECT @nn = @nn + 1
END





/*  Proceso para Compras Con Pacto */
INSERT #tmpmdcp (	xTipCar,			-- 1
					xnumdocu,			-- 2
					xcorrela,			-- 3		
					xInstser,			-- 4
					xMascara,			-- 5
					xTipoOpe,			-- 6
					xFecVcto,			-- 7
					xTirComp,			-- 8
					xNominal,			-- 9
					xVpresen,			-- 10
					xCodigo,			-- 11
					xFecemi,			-- 12
					xrutemi,			-- 13
					xcodclie,			-- 14
					xmonemi,			-- 15
					nTasemi,			-- 16
					nbasemi,			-- 17
					ntasest,			-- 18
					Um,					-- 19
					Serie,				-- 20
					NomEmi,				-- 21
					Plazo,				-- 22
					Nemo,				-- 23
					Llave,				-- 24
					Generico,			-- 25
					TasaMerc,			-- 26
					Valmerc,			-- 27
					Prog,				-- 28
					Orden,				-- 29
					xMontoOriginal,		-- 30
					xMontoOrigPacto,	-- 31
					Feccomp,			-- 32
					xFecAnt,			-- 33
					xFecPos,			-- 34
					VerVp,				-- 35
					FecPago,			-- 36
		    xRiesgo ) --MMP 13-04-2011

SELECT  MDCI.codigo_carterasuper, --citipcart,
cinumdocu,
	  cicorrela,
	  ciinstser,
	  ciMascara,
	  'CI',
	  cifecvenp,
	  citaspact,
	  cinominal,
	  Round(civalvenp * CASE WHEN cimonpact in(999,13) Then 1
				 --**(ITAÚ)ELSE CASE WHEN @tc_rep_cnt = 'S' AND cimonpact = 994 THEN Isnull((Select vmvalor_tcrc From view_valor_moneda Where vmcodigo = cimonpact and vmfecha = @dFecesp ),0)  -- cifecinip
				 ELSE CASE WHEN @tc_rep_cnt = 'S' AND cimonpact = 994 THEN Isnull((Select Tipo_Cambio From bacparamsuda..VALOR_MONEDA_CONTABLE Where Codigo_Moneda = cimonpact and fecha = @dFecesp ),0)  -- cifecinip
					   ELSE Isnull((Select vmvalor From view_valor_moneda Where vmcodigo = cimonpact and vmfecha = @dFecesp ),0)  -- cifecinip
					   END
				 END,CASE WHEN cimonpact = 13 THEN 2 ELSE 0 END),
cicodigo,
	  cifecemi,
	  cirutcli,
	  cicodcli,
cimonemi,
ciTasCFdo, -- VGS 03/03/2008 Pactos en USD  0, -- Isnull((SELECT setasemi  FROM view_serie WHERE semascara = ciinstser),
-- Isnull((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsnumdocu = cinumdocu AND nscorrela = cicorrela),0)),
0, -- Isnull((SELECT sebasemi  FROM view_serie WHERE semascara = ciinstser),
-- Isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsnumdocu = cinumdocu AND nscorrela = cicorrela),0)),
	  0,    -- 'ntasest' ?????????????????????????????????
Isnull((SELECT mnnemo FROM View_moneda WHERE mncodmon = cimonpact),''),   -- 'Um' ???????????????????????
CONVERT(CHAR(10),cifecvenp,112), -- (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cicodigo),   -- 'Serie' ???????????????
(SELECT top 1 clnombre from view_cliente WHERE clrut = cirutcli),--** ANd clcodigo = 0),   -- 'NomEmi'  ????????????
DATEDIFF(dd,@dFecpro,cifecvenp), -- Plazo Pacto
	  '',   -- 'Nemo'
'',   -- 'Llave'
'',   -- 'Generico'
	  0,    -- 'TasaMerc'
	  0,    -- 'Valmerc'
	  'sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = cicodigo),   -- ''Prog''
	  4,
	  0, -- Valor Contable
	  Valor_Contable, -- Valor Contable Pactos
	  cifecinip,
	  '',
	  '',
	  ' ',
	  cifecinip,
	  ''
-- 'Flag'
FROM MDCI
WHERE cimascara <> 'ICOL' AND cimascara <> 'ICAP'

UPDATE #tmpmdcp
SET Llave = NomEmi + CONVERT(CHAR(15),xTirComp)
	-- , xTipCar = Plazo
WHERE xTipoOpe = 'CI'


/*  Proceso para Ventas Con Pacto  */
INSERT #tmpmdcp ( xTipCar,
	    xnumdocu,
		    xnumoper,
	 	    xcorrela,
	 	    xInstser,
		    xMascara,
	 	    xTipoOpe,
	 	    xFecVcto,
	 	    xTirComp,
	 	    xNominal,
	 	    xVpresen,
	    xCodigo,
	 	    xFecemi,
	 	    xrutemi,
		    xcodclie,
	    xmonemi,
	 	    nTasemi,
	    nbasemi,
	 	    ntasest,
	    Um,
	    Serie,
	    NomEmi,
	    Plazo,
	 	    Nemo,
	    Llave,
	    Generico,
	 	    TasaMerc,
	    	    Valmerc,
	 	    Prog,
		    Orden,
		    xMontoOriginal,
		    xMontoOrigPacto,
		    Feccomp,
		    xFecAnt,
		    xFecPos,
		    xMonPact,
		    xValinip,
		    xFecinip,
		    VerVp,
		    FecPago,
		    xRiesgo ) --MMP 13-04-2011

SELECT  MDVI.codigo_carterasuper,
vinumdocu,
	  vinumoper,
	  vicorrela,
	  viinstser,
	  viMascara,
	  'VI',
	  vifecvenp,
	  vitaspact,
	  vinominal,
	  round(vivalvenp * CASE WHEN vimonpact in(999,13) Then 1
				 --**(ITAÜ)ELSE CASE WHEN @tc_rep_cnt = 'S' AND vimonpact = 994 THEN Isnull((Select vmvalor_tcrc From view_valor_moneda Where vmcodigo = vimonpact and vmfecha = @dFecesp),0) --vifecvenp
				 ELSE CASE WHEN @tc_rep_cnt = 'S' AND vimonpact = 994 THEN Isnull((Select Tipo_Cambio From bacparamsuda..VALOR_MONEDA_CONTABLE Where codigo_moneda = vimonpact and fecha = @dFecesp),0) --vifecvenp
					   ELSE Isnull((Select vmvalor From view_valor_moneda Where vmcodigo = vimonpact and vmfecha = @dFecesp),0) --vifecvenp
					   END
				 END, CASE WHEN vimonpact = 13 THEN 2 ELSE 0 END ),
vicodigo,
	  vifecemi,
	  virutcli,
	  vicodcli,
vimonemi,
viTasCFdo, -- VGS 22/02/2008 Pactos en USD  0,-- Isnull((SELECT setasemi  FROM view_serie WHERE semascara = viinstser),
-- Isnull((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsnumdocu = vinumdocu AND nscorrela = vicorrela),0)),
0,-- Isnull((SELECT sebasemi  FROM view_serie WHERE semascara = viinstser),
-- Isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsnumdocu = vinumdocu AND nscorrela = vicorrela),0)),
	  0,    -- 'ntasest' ?????????????????????????????????
Isnull((SELECT mnnemo FROM View_moneda WHERE mncodmon = vimonpact),''),   -- 'Um' ???????????????????????
CONVERT(CHAR(10),vifecvenp,112), -- (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),   -- 'Serie' ???????????????
(SELECT TOP 1 clnombre from view_cliente WHERE clrut = virutcli),--** ANd clcodigo = 0),   -- 'NomEmi'  ???????????? select * from mdvi
DATEDIFF(dd,@dFecpro,vifecvenp), -- Plazo Pacto
	  '',   -- 'Nemo'
'',   -- 'Llave'
'',   -- 'Generico'
	  0,    -- 'TasaMerc'
	  0,    -- 'Valmerc'
	  'sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),   -- ''Prog''
	  3,
	  Valor_Contable,
	  Valor_Contable,
	  vifeccomp,
	  '',
	  '',
	  vimonpact,
	  Vivalinip,
	  vifecinip,
	  ' ',
	  vifecinip,
	 ''
FROM MDVI

UPDATE #tmpmdcp
SET Llave = NomEmi + CONVERT(CHAR(15),xTirComp)
--,xTipCar = Plazo
WHERE xTipoOpe = 'VI'


-- VMGS Se debe eliminar de este reporte las letras de credito hiopotecarias propia emision debido a la nueva normativa
-- contable (Octubre del 2002)
-- *******************************************************************************************
--DELETE #tmpmdcp WHERE SUBSTRING (xInstser,1,3) = 'BOT' AND Serie = 'LCHR'
-- *******************************************************************************************

/* Interbancarios ICAP */
INSERT #tmpmdcp ( xTipCar,
	    xnumdocu,
	 	    xcorrela,
	 	    xInstser,
		    xMascara,
	 	    xTipoOpe,
	 	    xFecVcto,
	 	    xTirComp,
	 	    xNominal,
	 	    xVpresen,
	    xCodigo,
	 	    xFecemi,
	 	    xrutemi,
		    xcodclie,
	    xmonemi,
	 	    nTasemi,
	    nbasemi,
	 	    ntasest,
	    Um,
	    Serie,
	    NomEmi,
	    Plazo,
	 	    Nemo,
	    	    Llave,
	    Generico,
	 	    TasaMerc,
	 	    Valmerc,
	 	    Prog,
		    Orden,
		    xMontoOriginal,
		    xMontoOrigPacto,
		    Feccomp,
		    xFecAnt,
		    xFecPos,
		    VerVp,
		    FecPago,
		    xRiesgo ) --MMP 13-04-2011
SELECT  MDCI.codigo_carterasuper, --citipcart,
cinumdocu,
	  cicorrela,
	  ciinstser,
	  ciMascara,
	  ciinstser,
	  cifecvenp,
	  citaspact,
	  Round(civalinip / (CASE WHEN cimonpact = 999 THEN 1
				  --**(ITAÚ)ELSE CASE WHEN @tc_rep_cnt = 'S' AND cimonpact = 994 THEN (Select vmvalor_tcrc from view_valor_moneda Where vmcodigo = cimonpact and vmfecha = cifecinip) -- cinominal,
				  ELSE CASE WHEN @tc_rep_cnt = 'S' AND cimonpact = 994 THEN (Select TIPO_CAMBIO from BACPARAMSUDA..Valor_moneda_CONTABLE Where Codigo_Moneda = cimonpact and fecha = cifecinip) -- cinominal,
					    ELSE (Select vmvalor from view_valor_moneda Where vmcodigo = cimonpact and vmfecha = cifecinip)  -- cinominal,
					    END
			          END ), (CASE WHEN cimonpact = 999 THEN 0 ELSE 4 END)),
	  Round(civalvenp * (CASE WHEN cimonpact = 999 THEN 1
				  --**(ITAÚ)ELSE CASE WHEN @tc_rep_cnt = 'S' AND cimonpact = 994 THEN Isnull((Select vmvalor_tcrc from view_valor_moneda Where vmcodigo = cimonpact and vmfecha = @dFecesp ),0)
				  ELSE CASE WHEN @tc_rep_cnt = 'S' AND cimonpact = 994 THEN Isnull((Select TIPO_CAMBIO from bacparamsuda..Valor_moneda_contable Where codigo_moneda = cimonpact and fecha = @dFecesp ),0)
					    ELSE Isnull((Select vmvalor from view_valor_moneda Where vmcodigo = cimonpact and vmfecha = @dFecesp ),0)
					    END
				  END),(CASE WHEN cimonpact = 999 THEN 0 ELSE 4 END)),
cicodigo,
	  cifecemi,
	  cirutcli,
	  cicodcli,
cimonemi,
0,-- Isnull((SELECT setasemi  FROM view_serie WHERE semascara = ciinstser),
-- Isnull((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsnumdocu = cinumdocu AND nscorrela = cicorrela),0)),
0,-- Isnull((SELECT sebasemi  FROM view_serie WHERE semascara = ciinstser),
-- Isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsnumdocu = cinumdocu AND nscorrela = cicorrela),0)),
	  0,    -- 'ntasest' ?????????????????????????????????
Isnull((SELECT mnnemo FROM View_moneda WHERE mncodmon = cimonpact),''),   -- 'Um' ???????????????????????
CONVERT(CHAR(10),cifecvenp,112), -- (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cicodigo),   -- 'Serie' ???????????????
(SELECT clnombre from view_cliente WHERE clrut = cirutcli and clcodigo = cicodcli),   -- 'NomEmi'  ????????????
DATEDIFF(dd,@dFecpro,cifecvenp), -- Plazo Pacto
	  '',   -- 'Nemo'
'',   -- 'Llave'
'',   -- 'Generico'
	  0,    -- 'TasaMerc'
	  0,    -- 'Valmerc'
	  'sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = cicodigo),   -- ''Prog''
	  CASE WHEN ciinstser = 'ICAP' THEN 5 ELSE 6 END,
	  0,
	  0,
	  Cifeccomp,
	  '',
	  '',
	  ' ',
	  cifecinip,
	  ''
FROM MDCI
WHERE CHARINDEX(cimascara,'ICAP        -ICOL        ') > 0


UPDATE #tmpmdcp
SET Llave = NomEmi + CONVERT(CHAR(15),xTirComp)
-- xTipCar = Plazo
WHERE xTipoOpe = 'ICOL' Or xTipoOpe = 'ICAP'

-- Cbg 16/06/2004
	--** Grabación de valorización a Carteras MDCP,MDVI **--
	UPDATE	MDCP
	SET	cpvcum100  = isnull(valmerc,0)--**valmerc
	FROM	#tmpmdcp
	WHERE	xTipoOpe='CP' AND xnumdocu=cpnumdocu AND xcorrela=cpcorrela

	UPDATE	MDDI
	SET	divpmcd100  = CASE WHEN dinominal = xnominal THEN valmerc ELSE Round(valmerc * Isnull( (1.00-(dinominal/xnominal)) , 1),0) END
	FROM	#tmpmdcp
	WHERE	xTipoOpe='CP' AND xnumdocu=dinumdocu AND xcorrela=dicorrela
	
	--****************************************************--

DECLARE @COUNT INT
SET @COUNT = (SELECT  COUNT(*) FROM #tmpmdcp ,Mdac WHERE VerVp <> 'S' )

IF @COUNT <> 0
BEGIN

SELECT  #tmpmdcp.xTipCar,
        xnumdocu,
	    xcorrela,
	    xInstser,
	    xTipoOpe,
	    xFecVcto, --'xFecVcto'=CONVERT(CHAR(10),xFecVcto,103),  -- dd/mm/yyyy
	    xTirComp,
	    xNominal,
	    xVpresen,
        xCodigo,
	    xFecemi,
	    'xrutemi'=RTRIM(CONVERT(CHAR(9),xrutemi)) + '-' + (CASE WHEN orden > 2 THEN IsNull((SELECT cldv FROM View_cliente Where clrut = xrutemi AND clcodigo = xcodclie),'''') ELSE (Isnull( (SELECT emdv from view_emisor WHERE emrut = xrutemi),'''')) END) ,
        xmonemi,
	    nTasemi,
        nbasemi,
	    ntasest,
        Um,
        Serie,
        NomEmi,
        'Plazo'=CONVERT(CHAR(5),Plazo),
	    #tmpmdcp.Nemo,
        Llave,
        Generico,
        -- 'TasaMerc'=CONVERT(CHAR(14),TasaMerc),
        TasaMerc,
	    Valmerc,
	    Prog,
	    Orden,
        Flag,
	    'Hora'=CONVERT(CHAR(10),GETDATE(),108),
		'dFecProx'=CONVERT(CHAR(10),@dFecProx,112), 
        'TotCl'=Isnull(TotCl,0),
		'dFecProxSa'=CONVERT(CHAR(10),@dFecProx,103),  
        'NomProp' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --acnomprop,
        'RutProp' = Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,
		'GlosaCart' = Case When xTipoOpe in('VI','CI','ICAP','ICOL') THEN ' ' ELSE (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = 1111 and tbcodigo1 = CONVERT(VARCHAR(10),xtipcar)) END
		,'FechaCalculo'= CONVERT(CHAR(10),@dFecCierre,103),
		'cCart' = Case When xTipoOpe in('VI','CI','ICAP','ICOL') THEN 'P' ELSE Left((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = 1111 and tbcodigo1 = xtipcar),1) END-- VGS (28/10/2005)
   FROM #tmpmdcp ,Mdac
  WHERE VerVp <> 'S' 
ORDER BY Orden,Serie,xTipCar,Llave,xFecVcto

END

ELSE

BEGIN

SELECT  xTipCar = '',
        xnumdocu = '',
	    xcorrela = '',
	    xInstser = '',
	    xTipoOpe = '',
	    xFecVcto = '', --'xFecVcto'=CONVERT(CHAR(10),xFecVcto,103),  -- dd/mm/yyyy
	    xTirComp = '',
	    xNominal = '',
	    xVpresen = '',
        xCodigo = '',
	    xFecemi = '',
	    'xrutemi'= '',
        xmonemi= '',
	    nTasemi= '',
        nbasemi= '',
	    ntasest= '',
        Um= '',
        Serie= '',
        NomEmi= '',
        'Plazo'= '',
	     Nemo = '',
        Llave = '',
        Generico = '',
        -- 'TasaMerc'=CONVERT(CHAR(14),TasaMerc),
        TasaMerc = '',
	    Valmerc = '',
	    Prog = '',
	    Orden = '',
        Flag = '',
	    'Hora'= '',
		'dFecProx'= '', 
        'TotCl'= '',
		'dFecProxSa'= '',  
        'NomProp' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales),
        'RutProp' = '',
		'GlosaCart' = '',
		'FechaCalculo'= '',
		'cCart' = ''

END


SET NOCOUNT OFF
END
-- Base de Datos --

GO
