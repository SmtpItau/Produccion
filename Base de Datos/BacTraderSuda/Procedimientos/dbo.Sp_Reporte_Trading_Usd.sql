USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Reporte_Trading_Usd]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Reporte_Trading_Usd](	@nMediInt	FLOAT ,
						@cFecpro 	CHAR(8),
						@cFecProx 	CHAR(8),
						@SwFinMes	INT)
AS

BEGIN

  SET NOCOUNT ON
  DECLARE @dFecpro 	DATETIME
  DECLARE @dFecProx 	DATETIME
  DECLARE @ac_Fecpro 	DATETIME
  DECLARE @ac_FecProx 	DATETIME

  DECLARE @cEstado	CHAR(1)
  DECLARE @nIntGa	NUMERIC(19,4)
  DECLARE @nReaGa 	NUMERIC(19,4)
  DECLARE @nDifPre	NUMERIC(19,4)
  DECLARE @nTotVprox    FLOAT
  DECLARE @nIntPag	FLOAT


  DECLARE @nCont 	INT
  DECLARE @nn		INT
  
  DECLARE @xnumdocu numeric(10),
          @xcorrela numeric(3),
          @cProg    char(30),
          @xcodigo  numeric(3),
	  @xinstser char(12),
          @xmonemi  numeric(3),
	  @xfecemi  datetime,
          @xFecVcto datetime, 
          @ntasemi  numeric(9,4),
          @nbasemi  numeric(3), 
	  @ntasest  numeric(9,4),
	  @xNomiTot numeric(19,4),
	  @nTasaMerc numeric(9,4),
	  @nNumoper numeric(10),
	  @dfeccomp datetime,
	  @nvalcomp numeric(19,4),
	  @xTirAnt  numeric(9,4),
	  @xTirhis numeric(9,4),
	  @nValMon numeric(10,4),
	  @nValHoyOld numeric(19,4),
	  @nValHoyNew numeric(19,4),
	  @nSenala numeric(5),
	  @nValMonHoy numeric(19,4),
	  @nValMonMan numeric(19,4),
	  @nvalrea numeric(19,4),
	  @nValPxpr numeric(19,4),
	  @nCupon numeric(19,4),
	  @nReajuste numeric(19,4),
--	  @nInteres FLOAT,
	  @nInteres numeric(19,4),
	  @nUtPer FLOAT,
	  @nInter FLOAT

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
	  @dFecucup DATETIME,
	  @dFecpcup DATETIME

  DECLARE @AcnUtPer	NUMERIC(19,4),
	  @AcnInter 	NUMERIC(19,4),
	  @AcnIntGa 	NUMERIC(19,4),
	  @AcnReaGa 	NUMERIC(19,4),
	  @AcnDifPre 	NUMERIC(19,4),
	  @AcnIntPag 	NUMERIC(19,4)

  SELECT @dFecpro = @cFecpro , 
	 @dFecprox = @cFecProx


  select @AcnUtPer = acut_per_Usd,
	 @AcnInter = ac_inter_Usd,
	 @AcnIntGa = acint_gan_Usd,
	 @AcnReaGa = acrea_gan_Usd,
	 @AcnDifPre = acdif_pre_Usd,
	 @AcnIntPag = acint_pag_Usd,
 	 @ac_Fecpro = acfecproc,
	 @ac_FecProx = acfecprox

  from mdac




  CREATE TABLE #tmp    ( cartera CHAR(03) DEFAULT(''),
 			 feccomp datetime DEFAULT(''),
			 cliente numeric(9) DEFAULT(0),
			 instser char(12) DEFAULT(''),
			 monemis numeric(3) DEFAULT(0),
 			 nominal numeric(17,4) DEFAULT(0.0),
			 fecvtop datetime DEFAULT(''),
			 fecvcto datetime DEFAULT(''),
			 valvtop numeric(17,4) DEFAULT(0.0),
			 valinip numeric(17,4) DEFAULT(0.0),
			 tir  numeric(8,4) DEFAULT(0.0),
 			 vpresen numeric(19,4) DEFAULT(0.0),
 			 vpprox numeric(19,4) DEFAULT(0.0),
			 interes numeric(19,4) DEFAULT(0.0),
			 reajuste numeric(19,4) DEFAULT(0.0),
			 tirhist numeric(8,4) DEFAULT(0.0),
			 docuorig numeric(5) DEFAULT(0),
			 corrorig numeric(3) DEFAULT(0),
			 codigo numeric(3) DEFAULT(0),
			 btscomp numeric(3) DEFAULT(0),
			 valvenc numeric(17,4) DEFAULT(0.0),
			 fecemis datetime DEFAULT(''),
			 tasemis numeric(8,4) DEFAULT(0.0),
			 btsemis numeric(3) DEFAULT(0),
			 numoper numeric(5) DEFAULT(0),
			 int_acu numeric(17,4) DEFAULT(0.0),
			 rea_acu numeric(17,4) DEFAULT(0.0),
			 tiprenta char(10) DEFAULT(''),
			 fecinip datetime DEFAULT(''),
			 fecpcup datetime DEFAULT(''),
			 senala numeric(2) DEFAULT(0),
			 Inst char(12) DEFAULT(''),
 			 cupon numeric(17,4) DEFAULT(0.0),
			 nTirAnt numeric(8,4) DEFAULT(0.0),
			 Prog CHAR(10) DEFAULT(''),
			 tipoper char(3) DEFAULT(''),
			 nDiferenci numeric(17,2) DEFAULT(0),
			 Orden	  INT DEFAULT(0),
			 Um CHAR(3) DEFAULT(''),
      			 NomEmi CHAR(50) DEFAULT(''),
      			 Nemo CHAR(15) DEFAULT(''),
			 Generico CHAR(15) DEFAULT(''),
			 Llave CHAR(70) DEFAULT(''),
			 Plazo NUMERIC(5) DEFAULT(0),
			 VerVta CHAR(01) DEFAULT(''),
			 FechaPag DATETIME DEFAULT(''),
			 Flag      INT IDENTITY(0,1),
                         codcli  numeric(5)
			 )

    /* Procesa Cartera Propia */

  INSERT #tmp 	(cartera ,
 		 feccomp,
		 cliente,
		 instser,
		 monemis,
	 	 nominal,
		 fecvtop,
		 fecvcto,
		 valvtop,
		 valinip,
		 tir,
		 tirhist,
		 docuorig,
		 corrorig,
		 codigo ,
		 btscomp ,
		 fecemis ,
		 tasemis ,
		 btsemis ,
		 numoper ,
		 tiprenta ,
		 fecpcup ,
		 senala ,
		 Inst ,
		 nTirAnt ,
		 Prog,
		 Plazo,
		 Orden,
	  	 VerVta,
		 FechaPag,--28
                 codcli ) 
      SELECT '111', -- 1
             cpfeccomp, --2
	     cprutcli, --3
 	     cpinstser, --4
	     CASE WHEN cpseriado = 'S' THEN Isnull((SELECT semonemi FROM view_serie WHERE semascara = cpmascara),0)
             ELSE Isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela),0) END, --5
	     cpnominal + Isnull( (SELECT sum(vinominal) FROM MDVI WHERE vinumdocu = cpnumdocu AND vicorrela = cpcorrela) ,0), --6
	     '', -- 7
      	     cpfecven,
	     0,
	     cpvalcomp + Isnull( (SELECT sum(vivalcomp) FROM MDVI WHERE vinumdocu = cpnumdocu AND vicorrela = cpcorrela) ,0),
     	     cptircomp,
	     0, -- Tir historica
	     cpnumdocu,
    	     cpcorrela,
	     cpcodigo,
	     CASE WHEN cpseriado = 'S' THEN Isnull((SELECT sebasemi FROM view_serie WHERE semascara = cpmascara),0)
             ELSE Isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela),0) END,
	     cpfecemi,
	     CASE WHEN cpseriado = 'S' THEN Isnull((SELECT setasemi FROM view_serie WHERE semascara = cpmascara),0)
             ELSE Isnull((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela),0) END,
	     CASE WHEN cpseriado = 'S' THEN Isnull((SELECT sebasemi FROM view_serie WHERE semascara = cpmascara),0)
             ELSE Isnull((SELECT nsbasemi FROM VIEW_NOSERIE WHERE nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela),0) END,
	     cpnumdocu,
	     Tipo_Rentabilidad,
	     cpfecpcup,
	     cpsenala, -- crear en mdcp, mddi.mdvi,mdci y actualizar en fin de dia
	     (SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo),
	     0, -- Tasa old
	     'sp_' + (SELECT inprog FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo),
   	     DATEDIFF(dd,@dFecpro,cpfecven),
	     1,
	     ' ',
	     Fecha_Pagomañana,
             cpcodcli
  FROM MDCP  , view_instrumento
  WHERE cptipcart = 1 AND (cpnominal>0 or EXISTS(Select * from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela))
	AND cpcodigo=incodigo AND inmonemi=13 -- Trae solo los papeles en doalres usd


  UPDATE #tmp
  SET VerVta = (CASE WHEN (EXISTS(Select * from mdvi Where vinumdocu = docuorig and vicorrela = corrorig) Or nominal > 0) THEN ' ' ELSE 'X' END)
  DELETE #tmp where VerVta = 'X'

  /* Captura Cartera Ventas */

  INSERT #tmp 	(cartera ,
 		 feccomp,
		 cliente,
		 instser,
		 monemis,
	 	 nominal,
		 fecvtop,
		 fecvcto,
		 valvtop,
		 valinip,
		 vpresen,
		 tir,
		 tirhist,
		 docuorig,
		 corrorig,
		 codigo ,
		 btscomp ,
		 fecemis ,
		 tasemis ,
		 btsemis ,
		 numoper ,
		 tiprenta ,
		 fecpcup ,
		 senala ,
		 Inst ,
		 nTirAnt ,
		 Prog,
		 Plazo,
		 Orden,
		 VerVta,--28
                 codcli  ) -- 28
  SELECT 	'111',
		FECCOMP,
		RUTCLICOMP, 
		INSTSER,
		MONEMIS,
		NOMINAL,
	 	FECVENP,
		FECVENC,
		VALVTOP,
		VALINIP,
		VPRESEN,
		TIRCOMP,
		TIRHISTORICA,
		NUMDOCU,
		CORRELA,
		CODIGO,
		BASECOMP,
		FECEMIS,
		TASEMIS,
		BASEEMIS,
		NUMOPER,
		RENTA,
		FECPCUP,
		SENALA,
		INST,
		TIRANTERIOR,
		'SP_'+PROG,
		DATEDIFF(dd,@dFecpro,FECVENC),
		1,
		' ',
                codcli
  FROM View_Tabla_ventas --Tabla_Ventas
  WHERE Renta = 'T' And TIPO_LISTADO = 'T'  and MONEMIS=13


  UPDATE #tmp
  SET Um = Isnull((SELECT mnnemo FROM View_moneda WHERE mncodmon = monemis),''),
      NomEmi = Isnull((SELECT clnombre from view_cliente WHERE clrut = cliente and clcodigo = codcli),''),
      Nemo   = (CASE WHEN Inst = 'PCD' THEN (CASE WHEN monemis = 994 THEN 'PCDDO' ELSE 'PCDDA' END) ELSE Inst END )

  UPDATE #tmp
  SET Generico = Isnull((SELECT Clasificacion FROM Tramo_Tasa WHERE Nemo = Nemotecnico_Instrumento AND Plazo Between Desde And Hasta),'')

  UPDATE #tmp
  SET Llave = (CASE WHEN Nemo = 'LCHR' 
                   THEN SUBSTRING(instser,1,3) + Ltrim(Rtrim(Generico)) + '  ' + CONVERT(CHAR(7),Tasemis)
		   ELSE (Isnull((SELECT Clasificacion FROM Tramo_Tasa WHERE Nemo = Nemotecnico_Instrumento AND Plazo Between Desde And Hasta),Nemo))
              END)

--**  UPDATE #tmp
--**  SET tirhist = Isnull((SELECT Tasa_Mercado_Hoy FROM Tasa_Mercado_Diaria_Agrupado WHERE Nemotecnico_Instrumento = Llave),0.0),
--**      nTirAnt = CASE WHEN feccomp = @dFecpro THEN tir ELSE Isnull((SELECT Tasa_Mercado_Ayer FROM Tasa_Mercado_Diaria_Agrupado WHERE Nemotecnico_Instrumento = Llave),0.0) END


  If @SwFinMes = 1
     UPDATE #tmp
     SET nTirAnt = tirhist
     FROM MDAC


  SELECT @nCont = Max(Flag) FROM #Tmp
  SELECT @nn = Min(Flag) FROM #Tmp
	
  WHILE @nn <= @nCont
   BEGIN
   SELECT @cEstado = '*'

   SELECT @xnumdocu = docuorig,
          @xcorrela = corrorig,
          @cProg    = Prog,
          @xcodigo  = codigo,
	  @xinstser = instser,
          @xmonemi  = monemis,
	  @xfecemi  = fecemis,
          @xFecVcto = fecvcto, 
          @ntasemi  = Tasemis,
          @nbasemi  = btsemis, 
	  @ntasest  = 0,
	  @xNomiTot = nominal,
	  @nTasaMerc = tirhist,
	  @nNumoper = numoper,
	  @dfeccomp = feccomp,
	  @nvalcomp = valinip,
	  @xTirAnt  = nTirAnt,
	  @xTirhis  = tirhist,
	  @nSenala = Senala,
          @cEstado = ' '
   FROM #tmp WHERE flag = @nn

   If @cEstado = ' ' Begin
     SELECT @nValMon = 1--CASE WHEN @xmonemi <> 999 THEN (SELECT Isnull(vmvalor,0) from VIEW_VALOR_MONEDA where vmfecha=@dfeccomp and vmcodigo=@xmonemi) ELSE 1 END
     SELECT @nValMonHoy = 1--CASE WHEN @xmonemi <> 999 THEN (SELECT Isnull(vmvalor,0) from VIEW_VALOR_MONEDA where vmfecha=@dfecpro and vmcodigo=@xmonemi) ELSE 1 END
     SELECT @nValMonMan =1 --CASE WHEN @xmonemi <> 999 THEN (SELECT Isnull(vmvalor,0) from VIEW_VALOR_MONEDA where vmfecha=@dfecprox and vmcodigo=@xmonemi) ELSE 1 END
     SELECT @nvalrea =  @nvalcomp / @nValMon

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

     EXECUTE @nError = @cProg 2, @dFecpro, @xcodigo,@xinstser, @xmonemi, @xfecemi, @xFecVcto, 
             @ntasemi, @nbasemi, @ntasest,@xNomiTot OUTPUT, @xTirAnt OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
             @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
             @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
             @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

     SELECT @nValHoyOld = @fMt

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

     EXECUTE @nError = @cProg 2, @dFecpro, @xcodigo,@xinstser, @xmonemi, @xfecemi, @xFecVcto,
             @ntasemi, @nbasemi, @ntasest,@xNomiTot OUTPUT, @xTirhis OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
             @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
             @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
             @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

     SELECT @nValHoyNew = @fMt

     SELECT @nCupon =  CASE WHEN @dFecpcup <= @dfecprox THEN (((@fIntpcup+@fAmopcup)/100)*@xNomiTot)*@nValMonMan ELSE 0 END

     EXECUTE @nError = @cProg 2, @dfecprox, @xcodigo,@xinstser, @xmonemi, @xfecemi, @xFecVcto, 
             @ntasemi, @nbasemi, @ntasest,@xNomiTot OUTPUT, @xTirhis OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
             @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
             @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
             @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT
   
     SELECT @nValPxpr = @fMt


     SELECT @nDifPre = @nValHoyNew - @nValHoyOld
     SELECT @nReajuste = Round(@nvalrea*(@nValMonMan-@nValMonHoy),0)
     SELECT @nInteres = @nValPxpr + @nCupon - @nValHoyNew - @nReajuste 

     
     If @nSenala <> 3 And @nSenala <> 4 AND @nSenala <> -1 begin
--	select @nCupon, Isnull(@nValPxpr,0),Isnull(@nValHoyOld,0),Isnull(@nInteres,0),Isnull(@nValHoyNew,0),Isnull(@nDifPre,0)
	Update #Tmp
	Set vpresen    = Isnull(@nValHoyOld,0),
 	    vpprox     = Isnull(@nValPxpr,0),
	    interes    = Isnull(@nInteres,0),
	    reajuste   = Isnull(@nReajuste,0),
	    nDiferenci = Isnull(@nDifPre,0)
	Where Flag = @nn  

     end Else begin
	If @nSenala = -1
	   Update #Tmp
	   Set vpresen    = Isnull(@nValHoyOld,0)
	   Where Flag = @nn 

     end   
   End
   Select @nn = @nn + 1
  END

  SELECT @nUtPer = SUM(Valinip-vpresen) FROM #tmp WHERE Senala = -1 AND fecvcto > @dFecpro AND feccomp <> @dFecpro and @SwFinMes = 0
  SELECT @nInter = SUM(Valinip-Valvtop) FROM #tmp WHERE Senala = -1 AND feccomp = @dFecpro and @SwFinMes = 0


  SELECT @nIntGa = SUM(interes) FROM #tmp WHERE Senala <> -1 AND Senala <> -2
  SELECT @nReaGa = SUM(Reajuste) FROM #tmp WHERE Senala <> -1 AND Senala <> -2
  SELECT @nDifPre = SUM(nDiferenci) FROM #tmp WHERE Senala <> -1 AND Senala <> -2
  SELECT @nTotVprox = SUM(vpresen) FROM #tmp WHERE Senala <> -1 AND Senala <> -2 and Senala <> 1 and senala <> 2



 SELECT @nIntPag = ROUND(@nTotVprox*@nMediInt/36000 * (Datediff(dd,@dFecpro,@dFecprox))  ,0)


  --**INSERT INTO #TMP ( cartera,
		--     Nomemi,
		--     Nominal,
		--     tirhist,
		--     senala,
		--     Orden )
  --SELECT DISTINCT '140',
	 --Nemotecnico_Instrumento,
	 --Tasa_Mercado_Hoy,
 	-- Tasa_Mercado_Ayer,
	 --2,
	 --2
  --FROM Tasa_Mercado_Diaria_Agrupado, #TMP
  --WHERE Nemotecnico_Instrumento = #TMP.Llave and Tasa_Mercado_Hoy > 0


  if datepart(month,@ac_Fecpro) <> datepart(month,@ac_FecProx) AND @dFecpro > @ac_Fecpro
	select	@AcnUtPer = 0,
		@AcnInter = 0,
		@AcnIntGa = 0,
		@AcnReaGa = 0,
		@AcnDifPre = 0,
		@AcnIntPag = 0


  If @SwFinMes = 1 Begin
	Update #Tmp
	Set senala = 0
	Where Senala = 1

	Update #Tmp
	Set senala = 1
	Where Senala = 2
  end

  IF EXISTS(SELECT * FROM #TMP WHERE senala <> -1 AND senala <> -2) BEGIN
  SELECT cartera,
 	 'feccomp'=CONVERT(CHAR(10),feccomp,103),
	 cliente,
	 instser,
	 monemis,
 	 nominal,
	 fecvtop,
	 'fecvcto'=CONVERT(CHAR(10),fecvcto,103),
	 valvtop,
	 valinip,
	 tir  ,
 	 'vpresen'=(CASE WHEN Senala in (1,2) THEN 0 ELSE vpresen END),
 	 'vpprox'=(CASE WHEN Senala = 3 THEN 0 ELSE (CASE WHEN Senala = 4 THEN valinip ELSE vpprox END) END),
	 'interes'= (CASE WHEN Senala in (3,4) Then 0 ELSE interes END),
	 'reajuste'= (CASE WHEN Senala in (3,4) Then 0 ELSE reajuste END),
	 tirhist ,
	 docuorig,
	 corrorig,
	 codigo ,
	 btscomp ,
	 valvenc ,
	 fecemis ,
	 tasemis ,
	 btsemis ,
	 numoper ,
	 int_acu ,
	 rea_acu ,
	 tiprenta,
	 fecinip ,
	 fecpcup ,
	 senala ,
	 Inst ,
 	 cupon ,
	 nTirAnt,
	 Prog ,
	 tipoper ,
	 'nDiferenci'=(CASE WHEN Senala in (3,4) Then 0 ELSE nDiferenci END),
	 Orden	 ,
	 Flag    ,
	 Um ,
      	 NomEmi,
      	 Nemo,
	 Generico,
	 Llave,
	 Plazo,
	 'Fecproc'=CONVERT(CHAR(10),@dFecpro,103),
	 'FecProx'=CONVERT(CHAR(10),@dfecprox,103),
    	 'nUtPer'=Isnull(@nUtPer,0),
	 'nInter'=Isnull(@nInter,0),
	 'nIntGa'=Isnull(@nIntGa,0),
	 'nReaGa'=Isnull(@nReaGa,0),
	 'nDifPre'=Isnull(@nDifPre,0),
	 'nTotVprox'=Isnull(@nTotVprox,0),
	 'nIntPag'= Isnull(@nIntPag,0),

   	 'AcnUtPer'=Isnull(@AcnUtPer,0),
	 'AcnInter'=Isnull(@AcnInter,0),
	 'AcnIntGa'=Isnull(@AcnIntGa,0),
	 'AcnReaGa'=Isnull(@AcnReaGa,0),
	 'AcnDifPre'=Isnull(@AcnDifPre,0),
	 'AcnIntPag'=Isnull(@AcnIntPag,0),
	 'Media'=@nMediInt,
         'Hora' = CONVERT(CHAR(10),GETDATE(),108),
         'NomProp' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --acnomprop,
         'RutProp' = Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,
	 'Mes' = CASE 	WHEN DATEPART(mm,@dFecPro) = 1 THEN 'ENERO' 
		       	WHEN DATEPART(mm,@dFecPro) = 2 THEN 'FEBRERO'
			WHEN DATEPART(mm,@dFecPro) = 3 THEN 'MARZO'
			WHEN DATEPART(mm,@dFecPro) = 4 THEN 'ABRIL'
			WHEN DATEPART(mm,@dFecPro) = 5 THEN 'MAYO'
			WHEN DATEPART(mm,@dFecPro) = 6 THEN 'JUNIO'
			WHEN DATEPART(mm,@dFecPro) = 7 THEN 'JULIO'
			WHEN DATEPART(mm,@dFecPro) = 8 THEN 'AGOSTO'
			WHEN DATEPART(mm,@dFecPro) = 9 THEN 'SEPTIEMBRE'
			WHEN DATEPART(mm,@dFecPro) = 10 THEN 'OCTUBRE'
			WHEN DATEPART(mm,@dFecPro) = 11 THEN 'NOVIEMBRE'
			WHEN DATEPART(mm,@dFecPro) = 12 THEN 'DICIEMBRE' END


  FROM #TMP, MDAC WHERE senala <> -1 AND senala <> -2 ORDER BY Orden,cartera,feccomp,Cliente
  END ELSE BEGIN

  SELECT cartera = CONVERT(CHAR(03),''),
 	 'feccomp'=CONVERT(CHAR(10),'  /  /    '),
	 cliente = 0,
	 instser = SPACE(12),
	 monemis = 0,
 	 nominal = 0.0,
	 fecvtop =CONVERT(CHAR(10),'  /  /    '),
	 'fecvcto'=CONVERT(CHAR(10),'  /  /    '),
	 valvtop = 0.0,
	 valinip = 0.0,
	 tir     = 0.0,
 	 'vpresen'=0.0,
 	 'vpprox'=0.0,
	 'interes'= 0.0,
	 'reajuste'= 0.0,
	 tirhist  = 0.0,
	 docuorig = 0,
	 corrorig = 0,
	 codigo  = 0,
	 btscomp  = 0,
	 valvenc  = 0,
	 fecemis  = CONVERT(CHAR(10),'  /  /    '),
	 tasemis  = 0.0,
	 btsemis  = 0.0,
	 numoper  = 0,
	 int_acu  = 0.0,
	 rea_acu  = 0.0,
	 tiprenta = CONVERT(CHAR(10),''),
	 fecinip  = CONVERT(DATETIME,'',103),
	 fecpcup  = CONVERT(DATETIME,'',103),
	 senala   = 0,
	 Inst     = SPACE(12),
 	 cupon    = 0.0,
	 nTirAnt  = 0.0,
	 Prog     = Space(10),
	 tipoper  = Space(3),
	 'nDiferenci'=0.0,
	 Orden	  = 0,
	 Flag     = 0,
	 Um       = Space(8),
      	 NomEmi   = Space(50),
      	 Nemo     = Space(15),
	 Generico =Space(15),
	 Llave    =Space(70),
	 Plazo    = 0,
	 'Fecproc'=CONVERT(CHAR(10),@dFecpro,103),
	 'FecProx'=CONVERT(CHAR(10),@dfecprox,103),
    	 'nUtPer'=Isnull(@nUtPer,0),
	 'nInter'=Isnull(@nInter,0),
	 'nIntGa'=Isnull(@nIntGa,0),
	 'nReaGa'=Isnull(@nReaGa,0),
	 'nDifPre'=Isnull(@nDifPre,0),
	 'nTotVprox'=Isnull(@nTotVprox,0),
	 'nIntPag'= Isnull(@nIntPag,0),

   	 'AcnUtPer'=Isnull(@AcnUtPer,0),
	 'AcnInter'=Isnull(@AcnInter,0),
	 'AcnIntGa'=Isnull(@AcnIntGa,0),
	 'AcnReaGa'=Isnull(@AcnReaGa,0),
	 'AcnDifPre'=Isnull(@AcnDifPre,0),
	 'AcnIntPag'=Isnull(@AcnIntPag,0),
	 'Media'=@nMediInt,
         'Hora' = CONVERT(CHAR(10),GETDATE(),108),
         'NomProp' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --acnomprop,
         'RutProp' = Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,
	 'Mes' = CASE 	WHEN DATEPART(mm,@dFecPro) = 1 THEN 'ENERO' 
		       	WHEN DATEPART(mm,@dFecPro) = 2 THEN 'FEBRERO'
			WHEN DATEPART(mm,@dFecPro) = 3 THEN 'MARZO'
			WHEN DATEPART(mm,@dFecPro) = 4 THEN 'ABRIL'
			WHEN DATEPART(mm,@dFecPro) = 5 THEN 'MAYO'
			WHEN DATEPART(mm,@dFecPro) = 6 THEN 'JUNIO'
			WHEN DATEPART(mm,@dFecPro) = 7 THEN 'JULIO'
			WHEN DATEPART(mm,@dFecPro) = 8 THEN 'AGOSTO'
			WHEN DATEPART(mm,@dFecPro) = 9 THEN 'SEPTIEMBRE'
			WHEN DATEPART(mm,@dFecPro) = 10 THEN 'OCTUBRE'
			WHEN DATEPART(mm,@dFecPro) = 11 THEN 'NOVIEMBRE'
			WHEN DATEPART(mm,@dFecPro) = 12 THEN 'DICIEMBRE' END


  FROM MDAC 


  END

  UPDATE Mdac
  SET	Int_Gan_Usd = Isnull(@nIntGa,0),
	Rea_Gan_Usd = Isnull(@nReaGa,0),
	Dif_Pre_Usd = Isnull(@nDifPre,0),
	Int_Pag_Usd = Isnull(@nIntPag,0),
	Ut_Per_Usd  = Isnull(@nUtPer,0),
	Inter_Usd   = Isnull(@nInter,0)


  SET NOCOUNT OFF

END
-- Base de Datos --

GO
