USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Reporte_TIR_Historica_AFS]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Reporte_TIR_Historica_AFS] 
						(	
							@nMediInt	float		,
							@cFecpro	CHAR(08)	, 
							@cFecProx	CHAR(08)	,
							@Swfinmes	INT             
						)
AS
BEGIN

  DECLARE @nTotCInt 	FLOAT
  DECLARE @nTotCInt_DOLAR 	FLOAT

  DECLARE @nTotVInt 	FLOAT
  DECLARE @nTotVInt_DOLAR 	FLOAT

  DECLARE @nUtPeVta 	FLOAT
  DECLARE @nUtPeVta_DOLAR 	FLOAT

  DECLARE @nDifPre 	FLOAT
  DECLARE @nDifPre_DOLAR 	FLOAT

  DECLARE @nCosPro 	FLOAT
  DECLARE @nCosPro_DOLAR 	FLOAT

  DECLARE @nIntDia 	FLOAT
  DECLARE @nIntDia_DOLAR 	FLOAT

  DECLARE @nUtPeIntDia 	FLOAT
  DECLARE @nUtPeIntDia_DOLAR 	FLOAT

  DECLARE @nTotDia 	FLOAT
  DECLARE @nTotDia_DOLAR 	FLOAT

  DECLARE @xToCint	FLOAT
  DECLARE @xToCint_DOLAR	FLOAT

  DECLARE @xToVint	FLOAT
  DECLARE @xToVint_DOLAR	FLOAT

  DECLARE @xIntDia	FLOAT
  DECLARE @xIntDia_DOLAR	FLOAT

  DECLARE @xUtPeVta	FLOAT
  DECLARE @xUtPeVta_DOLAR	FLOAT

  DECLARE @xUtPeIdia	FLOAT
  DECLARE @xUtPeIdia_DOLAR	FLOAT

  DECLARE @xDifPre	FLOAT
  DECLARE @xDifPre_DOLAR	FLOAT

  DECLARE @xCosPro	FLOAT
  DECLARE @xCosPro_DOLAR	FLOAT

  DECLARE @xTotDia	FLOAT
  DECLARE @xTotDia_DOLAR	FLOAT

  DECLARE @dFecAnt 	DATETIME
  DECLARE @dFecpro 	DATETIME
  DECLARE @dFecProx 	DATETIME
  DECLARE @ac_Fecpro 	DATETIME
  DECLARE @ac_FecProx 	DATETIME
  DECLARE @cEstado	CHAR(1)
  DECLARE @rutcart 	numeric(9)
  DECLARE @tipcart 	numeric(5)
  DECLARE @cTipopOr     Char(3)
  DECLARE @dFecvAnt     DATETIME
  DECLARE @nvalprox 	FLOAT
  DECLARE @nvalproc 	FLOAT
  DECLARE @ninteres 	FLOAT
  DECLARE @nCotador     INT
  DECLARE @i		INT
  DECLARE @dfecvtoreal  DATETIME
  DECLARE @ctipo        CHAR(1)
  DECLARE @nvalvtoreal  NUMERIC(19,04)

  DECLARE @xTotCProc    FLOAT
  DECLARE @xTotCProc_DOLAR    FLOAT

  DECLARE @xTotVproc	FLOAT
  DECLARE @xTotVproc_DOLAR	FLOAT

  DECLARE @xvVta	CHAR(01)
  DECLARE @nCont        INT
  DECLARE @nn           INT
  DECLARE @e            FLOAT
  DECLARE @r            FLOAT
  DECLARE @dFechaVcto   DATETIME

  DECLARE 
	@Ainteresesganadosporcompras       FLOAT,
	@Ainteresesganadosporcompras_DOLAR       FLOAT,

  	@Ainteresespagadosporventas        FLOAT,
  	@Ainteresespagadosporventas_DOLAR        FLOAT,

  	@AUtilidadperdidaporintereses      FLOAT,
  	@AUtilidadperdidaporintereses_DOLAR      FLOAT,

  	@AUtilidadperdidaporventadecartera FLOAT,
  	@AUtilidadperdidaporventadecartera_DOLAR FLOAT,

	@AUtilidadperdidafinalporcartera   FLOAT,
	@AUtilidadperdidafinalporcartera_DOLAR   FLOAT,

  	@ADiferenciadeprecios              FLOAT,
  	@ADiferenciadeprecios_DOLAR              FLOAT,

  	@Acostopromedio                    FLOAT,
  	@Acostopromedio_DOLAR                    FLOAT,

	@AUtilidadPerdidanetaenpesos       FLOAT,
	@AUtilidadPerdidanetaenpesos_DOLAR       FLOAT,


  -- @dFecpro
          	@Hinteresesganadosporcompras       FLOAT,
          	@Hinteresesganadosporcompras_DOLAR    FLOAT,

          	@Hinteresespagadosporventas        FLOAT,
	@Hinteresespagadosporventas_DOLAR        FLOAT,

	@HUtilidadperdidaporintereses      FLOAT,
	@HUtilidadperdidaporintereses_DOLAR      FLOAT,

	@HUtilidadperdidaporventadecartera FLOAT,
	@HUtilidadperdidaporventadecartera_DOLAR FLOAT,

	@HUtilidadperdidafinalporcartera   FLOAT,
	@HUtilidadperdidafinalporcartera_DOLAR   FLOAT,

	@HDiferenciadeprecios              FLOAT,
	@HDiferenciadeprecios_DOLAR              FLOAT,

	@Hcostopromedio                    FLOAT,
	@Hcostopromedio_DOLAR                    FLOAT,

	@HUtilidadPerdidanetaenpesos       FLOAT,
	@HUtilidadPerdidanetaenpesos_DOLAR       FLOAT,

  --  ACUMULADO MES
          	@Minteresesganadosporcompras       FLOAT,
	@Minteresesganadosporcompras_DOLAR       FLOAT,

          	@Minteresespagadosporventas        FLOAT,
          	@Minteresespagadosporventas_DOLAR        FLOAT,

  	@MUtilidadperdidaporintereses      FLOAT,
  	@MUtilidadperdidaporintereses_DOLAR      FLOAT,

	@MUtilidadperdidaporventadecartera FLOAT,
	@MUtilidadperdidaporventadecartera_DOLAR FLOAT,

	@MUtilidadperdidafinalporcartera   FLOAT,
	@MUtilidadperdidafinalporcartera_DOLAR   FLOAT,

	@MDiferenciadeprecios              FLOAT,
	@MDiferenciadeprecios_DOLAR              FLOAT,

	@Mcostopromedio                    FLOAT,
	@Mcostopromedio_DOLAR                    FLOAT,

	@MUtilidadPerdidanetaenpesos       FLOAT,
	@MUtilidadPerdidanetaenpesos_DOLAR       FLOAT,


          	 @FechaP                            CHAR(35),
	 @TasMedia                          FLOAT,
	 @Posicion                          NUMERIC(19,4),
	 @Costo                             NUMERIC(19,4)

  DECLARE @numdocu   numeric(10),
          @correla   numeric(3),
          @instser   char(12),
          @mascara   char(12),
          @Nominal   numeric(19,4),
          @feccomp   datetime,
          @valcomp   numeric(19,4),
          @valcomu   float, 
          @tircomp   numeric(9,4),
          @numucup   numeric(3),
          @fecemi    DATETIME,
          @fecven    DATETIME,
          @seriado   CHAR(1),
          @codigo    Numeric(5),
          @vptirc    NUMERIC(19,04),
          @fecucup   DATETIME,
          @fecpcup   DATETIME,
          @FechaPago DATETIME,
	  @ForPago   Int,
	  @ForPagf   Int,
	  @ForPagi   Int,
	  @ForPagvo  Int,
	  @nMoneda   NUMERIC(3),
	  @Monemis   NUMERIC(3),
	  @Inst      CHAR(12),
	  @nRutCl    NUMERIC(9),
	  @nRutClVi  NUMERIC(9),
	  @nCodCl    NUMERIC(9),
	  @nBase     FLOAT, --NUMERIC(3),
	  @cProg     CHAR(12),
	  @ntasemi   NUMERIC(9,4),
	  @ntasest   NUMERIC(9,4),
	  @xtir      NUMERIC(9,4),
	  @nTirn     FLOAT,
	  @nTirhAp   FLOAT,
	  @dFAntpCup DATETIME,
	  @NumopeVi  NUMERIC(10),
	  @nnumoper  NUMERIC(10),
	  @nmonpact  NUMERIC(3),
	  @dFecInip  DATETIME,
          @dFecVtop  DATETIME,
	  @Valinip   FLOAT,
	  @nValVta   FLOAT,
	  @ValVenp   FLOAT,
	  @ValAntic  FLOAT,
	  @cartera   CHAR(03),
	  @dFecPagfR DATETIME,
          @fValProx  FLOAT,
	  @fValProc  FLOAT


  DECLARE @fPvp          FLOAT  ,
	  @fMT           FLOAT  ,
	  @fMTUM         FLOAT  ,
	  @fMT_cien      FLOAT  ,
	  @fVan          FLOAT  ,
	  @fVpar         FLOAT  ,
	  @nNumucup      INTEGER  ,
	  @fIntucup      FLOAT  ,
	  @fAmoucup      FLOAT  ,
	  @fSalucup      FLOAT  ,
	  @nNumpcup      INTEGER  ,
	  @fIntpcup      FLOAT  ,
	  @fAmopcup      FLOAT  ,
	  @fSalpcup      FLOAT  ,
	  @fDurat        FLOAT  ,
	  @fConvx        FLOAT  ,
	  @fDurmo        FLOAT  ,
	  @nError        INTEGER,
	  @dFecucup      DATETIME,
	  @dFecpcup      DATETIME,
	  @dFecPagfV     DATETIME,
	  @dFecPagfI     DATETIME,
	  @dFecPagfIVi   DATETIME,
	  @dFecPagfVVi   DATETIME,
	  @dFecPagfAnt   DATETIME,
	  @nValProceso   FLOAT,
	  @nValMonpi     NUMERIC(10,4),
	  @xValIni       FLOAT,
	  @xValVtop      FLOAT,
	  @Feccal        DATETIME,
	  @xTirHistorica FLOAT,
	  @xValProxVc    FLOAT,
	  @dFechaSalida  DATETIME,
	  @cTipoper      CHAR(10),
	  @dFecReal      DATETIME,
	  @crenta        char(1),
	  @nValMonHoy    FLOAT,
          	  @nValMonPxPr   FLOAT,
	  @xfecemi       DATETIME,
	@tc_rep_cnt  CHAR(01),
	  @DO_TC FLOAT

	--SELECT @DO_TC   = isnull(VMVALOR_TCRC,0)     /* Dolar T/C Rep. Contable */
	--FROM VIEW_VALOR_MONEDA,MDAC
	--WHERE VMCODIGO = 994 AND VMFECHA = ACFECPROC

SELECT @DO_TC   = isnull(TIPO_CAMBIO,0)     /* Dolar T/C Rep. Contable */
FROM BacParamSuda..VALOR_MONEDA_CONTABLE,MDAC
WHERE CODIGO_MONEDA = 994 AND FECHA = ACFECPROC



	IF @DO_TC=0 
	BEGIN
		SELECT @tc_rep_cnt = 'N'   /* SE OCUPA T/C OBS */
        	END 
	ELSE 
	BEGIN
		SELECT @tc_rep_cnt = 'S'   /* SE OCUPA T/C REP CONTABLE */
	END

  	SELECT @nTotCint   	=   acyTotCint,
  	 	@nTotVInt   	=   acyTotVint,
  	 	@nUtPeVta   	=   acyUtPeVta,
  	 	@nDifPre    	=   acyDifPre,
  	 	@nCosPro    	=   acyCodPro,
  	 	@nIntDia    	=   (acyTotCint - acyTotVint),
	 	@dFecAnt    	=   acfecante,
         		@dFecpro    	=   @cFecpro,
         		@dFecProx   	=   @cFecProx,
 	 	@ac_Fecpro  	=   acfecproc,
	 	@ac_FecProx 	=   acfecprox,

		@nTotCInt_DOLAR	= USD_acyTotCint,
  	 	@nTotVInt_DOLAR 	= USD_acyTotVint,
  	 	@nUtPeVta_DOLAR 	= USD_acyUtPeVta,
  	 	@nDifPre_DOLAR 	= USD_acyDifPre,
  	 	@nCosPro_DOLAR 	= USD_acyCodPro

  	FROM	MDAC


  SELECT @nUtPeIntDia = @nIntDia + @nUtPeVta
  SELECT @nTotDia     = @nUtPeIntDia + @nDifPre - @nCosPro

  CREATE TABLE #tmp    (cartera	    CHAR(3),
			fecini	    DATETIME,
			fecvto	    DATETIME,
			cliente	    NUMERIC(9),
			moneda	    NUMERIC(3),
			base	    NUMERIC(3),
			valvtop	    FLOAT, -- NUMERIC(17,4),
			valinip	    FLOAT, --NUMERIC(17,4),
			tirh	    FLOAT,
			valprox	    FLOAT,
			valproc	    FLOAT,
			interes	    FLOAT,
			renta	    CHAR(1),
			instser	    CHAR(12),
			inst	    CHAR(12),
			nominal	    NUMERIC(15,2),
			numdocu	    NUMERIC(10),
			correla	    NUMERIC(3),
			fecorig	    DATETIME,
			tashist	    NUMERIC(10,6),
			tirn	    FLOAT, -- NUMERIC(10,6),
			numoper	    NUMERIC(10),
			valorvta    NUMERIC(19,4),
			vefecreal   DATETIME,
			tipo	    CHAR(2),
			valvtoreal  NUMERIC(17,4),
			fecvtoreal  DATETIME,
			ForPagoI    INT,
			ForPagoF    INT,
			Orden	    INT,
			Flag        INT,
			codcli      NUMERIC(10),
			VerVtas     CHAR(01) DEFAULT(' '))


    /* Procesa Cartera Propia */
  SET NOCOUNT ON
  SELECT *, 'Flag' = IDENTITY(INT,1,1), 'Tipoper' = 'CP','FechaReal'=CONVERT(DATETIME,''),'ValorVenta'=CONVERT(NUMERIC(19,4),0),'NumOper'= 0,'VerVta' = ' ' ,
         'Monemi' = (CASE WHEN cpseriado = 'S' THEN Isnull((SELECT semonemi FROM view_serie WHERE semascara = cpmascara),0)
             	       ELSE Isnull((SELECT nsmonemi FROM VIEW_NOSERIE WHERE nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela),0) END ),
	 'inst'  = (Select inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo)
  INTO #tmpmdcp FROM mdcp 
  WHERE Tipo_Cartera_Financiera <> 'T' and (cpnominal>0 or  (EXISTS(Select * from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) Or cpnominal > 0)) 
  ORDER BY cpnumdocu,cpcorrela

/*
            AVERIGUAR PORQUE Tipo_Cartera_Financiera <> 'T'   MSP

*/

  UPDATE #tmpmdcp
  SET VerVta = (CASE WHEN (EXISTS(Select 1 from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) Or cpnominal > 0) THEN ' ' ELSE 'X' END)

  DELETE #tmpmdcp where VerVta = 'X'

-- cbg 17/08/2004
  DELETE #tmpmdcp where Monemi = 13

  /*Recupera Ventas Definitivas*/

  INSERT INTO #tmpmdcp (	cprutcart,
	  			cptipcart,
	  			cpnumdocu,
	  			cpcorrela,
          				cpinstser,
	  			cpmascara,
	  			cpNominal,
	  			cpvalcomp,
	  			cptircomp, 
	  			cpfeccomp, --10
	  			cpfecemi,
          				cpfecven,
	  			cpcodigo,
	  			cpfecpcup,
	  			cpfecucup, 
	  			Fecha_PagoMañana,
	  			cpforpagi,
	  			cprutcli, 
	  			cpcodcli,
	  			cpnumucup, -- 20
				Tipoper,
				cpseriado,
				cptipoletra,
				Tipo_Inversion,
				Laminas,
				Id_Sistema,
				Mercado,
				Tipo_Cartera_Financiera,
				codigo_carterasuper, --30
				porcentaje_valor_par_compra_original,
				valor_par_compra_original,
				tir_compra_original,
				valor_compra_um_original,
				valor_compra_original,
				fecha_compra_original,
				cpintermes,
				cpreajumes,
				cpconvex,
				cpdurat, -- 40
				cpdurmod, -- 41
				cpdcv,    -- 42
				cpvcompori, -- 43
				cpcontador, --44
				cpreajustc, -- 45
				cpinteresc, -- 46
				cpcapitalc, --47
				cpvptirc, --48
				cpvpcomp, --49
				cppvpcomp, -- 50
				cptasest,  --51
				cpvcum100, --52
				cpvalcomu, --53
				cpcorrelao, --54
				cpnumdocuo, --55
				Sucursal, --56
				FechaReal, --57
				ValorVenta, --58
				Numoper,
				VerVta,
				Monemi)  -- 59
  SELECT 	 RUT_CARTERA
		,TIPO_CARTERA
		,NUMDOCU
		,CORRELA
		,INSTSER
		,Mascara
		,NOMINAL
		,VALCOMP
		,TIRCOMP
		,FECCOMP
		,FECEMIS
		,FECVENC
		,CODIGO
		,FECPCUP
		,FECUCUP
		,FECHAPAGO
		,FORMAPAGOI
		,RUTCLI
		,CODCLI
--		,Isnull((SELECT tdcupon FROM view_Tabla_Desarrollo WHERE tdmascara = MASCARA And tdfecven = FECUCUP),0)
		,Isnull((SELECT cpnumucup FROM mdcp WHERE cpnumdocu = numdocu and cpcorrela = correla ),0)
		,'VP'
	  	,(Select inmdse FROM VIEW_INSTRUMENTO WHERE incodigo = CODIGO)
	  	,' '
	  	,' '
	  	,' '
	  	,'BTR'
	  	,' '
	  	,CASE 	WHEN TIPO_CARTERA = 1 THEN 'T' 
	       		WHEN TIPO_CARTERA = 2 THEN 'A' 
	       		WHEN TIPO_CARTERA = 3 THEN 'P' 
			WHEN TIPO_CARTERA = 4 THEN 'H' END
	  	,' ' -- 30
	  	,0
	  	,VALCOMP
	  	,TIRCOMP
	  	,VALCOMU
	  	,VALCOMP
	  	,FECCOMP
	  	,0
	  	,0
	  	,0
	  	,0 -- 40
	  	,0 -- 41
	  	,' ' --42
	  	,VALCOMP -- 43 select * from mdmo where motipoper ='VP'
	  	,0 -- mocontador,
	  	,0
	  	,0
	  	,VALCOMP--47
	  	,VPRESEN -- 0,
	  	,0
	  	,VALORPARC -- 50
          	,0
		,0 -- momtum100,
		,VALCOMU
		,0
		,0
		,' '
		,isnull(VENTAFECHAREAL,' ')
	  	,VENTAVALOR -- 57  
	  	,NUMOPER
		,'X'
		,MONEMIS
  FROM Tabla_ventas
  Where TIPO_LISTADO = 'H' AND TIPO_CARTERA <> 1  and VENTAFECHAREAL >= @cFecpro and monemis<>13 -- Cbg 17/08/2004


  delete #tmpmdcp where CHARINDEX(SUBSTRING(inst,1,2),'LC-IC-BO') > 0 Or (Monemi = 994 Or Monemi = 995)

 -- cbg despues sacer
--  select count(*) from  #tmpmdcp


  SELECT @nCont = MAX(Flag) FROM #tmpmdcp
  SELECT @nn    = MIN(Flag) FROM #tmpmdcp

-- cbg sacar despues
--  select count(*) FROM #tmpmdcp
--  select  @nn,@nCont

  WHILE @nn <= @nCont
   BEGIN
   SELECT @cEstado = '*'

   SELECT @rutcart   = cprutcart,
	  @tipcart   = cptipcart,
	  @numdocu   = cpnumdocu,
	  @correla   = cpcorrela,
          @instser   = cpinstser,
	  @mascara   = cpmascara,
	  @Nominal   = cpNominal + Isnull( (SELECT sum(vinominal) FROM MDVI WHERE vinumdocu = cpnumdocu AND vicorrela = cpcorrela AND tipoper = 'CP') ,0),
	  @Valcomp   = cpvalcomp + Isnull( (SELECT sum(vivalcomp) FROM MDVI WHERE vinumdocu = cpnumdocu AND vicorrela = cpcorrela AND tipoper = 'CP') ,0),
	  @tircomp   = cptircomp, 
	  @feccomp   = cpfeccomp,
	  @fecemi    = cpfecemi,
	  @xfecemi   = cpfecemi,
          @fecven    = cpfecven,
	  @codigo    = cpcodigo,
	  @fecpcup   = cpfecpcup,
	  @fecucup   = cpfecucup,
	  @FechaPago = Fecha_PagoMañana,
	  @ForPago   = cpforpagi,
	  @Monemis   = Monemi ,
	  @Inst	     = (Select inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo),
	  @nRutCl    = cprutcli, 
	  @nCodCl    = cpcodcli,
	  @Numucup   = cpnumucup, 
	  @Seriado   = cpseriado,
	  @nBase     = (Select inbasemi FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo), 
	  @cProg     = 'sp_' + (Select inprog FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo),
	  @ntasemi   = CASE WHEN cpseriado = 'S' THEN Isnull((SELECT setasemi FROM view_serie WHERE semascara = cpmascara),0)
               	       ELSE Isnull((SELECT nstasemi FROM VIEW_NOSERIE WHERE nsrutcart = cprutcart AND nsnumdocu = cpnumdocu AND nscorrela = cpcorrela),0) END,
	  @ntasest   = 0,
	  @cEstado   = ' ',
	  @cTipoper  = Tipoper,
	  @dFecReal  = FechaReal,
	  @nValVta   = ValorVenta,
	  @nnumoper  = NumOper,
	  @xvVta     = VerVta
   FROM #tmpmdcp WHERE flag = @nn
      
   SELECT @xTir = @tircomp

   If @cEstado = ' ' BEGIN
   Select @dFAntpCup = ''
   SET    ROWCOUNT 1
   SELECT @dFAntpCup  = Isnull(tdfecven,'')
   FROM   VIEW_TABLA_DESARROLLO
   WHERE  tdmascara   = @instser AND tdfecven  < @FecpCup ORDER by tdfecven DESC
   SET ROWCOUNT 0
/* -------------------------------------------------------------------------------   
    Esto porque el papel puede que no haya cortado ningun cupon todavia por lo que no
    existe cupon anterior, por lo tanto debe tomar la fecha de ingreso a la cartera, o sea

    fecha de compra del papel
*/
   Select @dFAntpCup = isnull(@dFAntpCup,@FechaPago) --@fecemi)

   Select @fPvp     = 0 
   Select @fMt      = 0
   Select @fMtum    = 0
   Select @fMt_cien = 0
   Select @fVan     = 0
   Select @fVpar    = 0
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


   Select @dFechaSalida = ''
   EXECUTE DBO.SP_PagoFisico @FechaPago, @ForPago, @dFechaSalida OUTPUT

   If @Seriado = 'S' Begin
      IF (@dFAntpCup > @Feccomp)
         SELECT @dFechaSalida = @dFAntpCup
   End Else SELECT @dFAntpCup = @Feccomp

   SELECT @dFecPagfI = @dFechaSalida
   SELECT @dFecPagfV = @fecpcup
   SELECT @dFecPagfR = @dFecReal

   Select @nValMonpi = 0
   If @Seriado = 'S' Or @Monemis <> 999
      SELECT @nValMonpi = Isnull((SELECT vmvalor from view_valor_moneda WHERE vmcodigo = @Monemis AND vmfecha = @dFecPagfI),1)
   Else
      SELECT @nValMonpi = 1

   -- Primera valorizacion a fecha pago inicial o ultimo cupon cortado
   If (@dFAntpCup > @Feccomp) Or @Valcomp = 0 Begin

	  --SELECT @xfecemi = @dFechaSalida
	   EXECUTE @nError = @cProg 2, @Feccomp, @codigo,@instser, @monemis, @xfecemi, @Fecven, 
        	   @ntasemi, @nbase, @ntasest,@Nominal OUTPUT, @xTir OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
	           @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
	           @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
	           @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

	Select @nValProceso = @fMt

   End Else Select @nValProceso = @Valcomp

   Select @xValIni       = 0
   Select @xValVtop      = 0
   Select @xTirHistorica = 0
   Select @xValProxVc    = 0
   If Not @seriado       = 'S' Begin

	Select @xValIni       = Round( @nValProceso/@nValMonpi , (CASE WHEN @monemis = 999 THEN 1 ELSE 4 END) )
	Select @xValVtop      = @Nominal
	SELECT @xTirHistorica = 0
	SELECT @xValProxVc    = 0

   End Else Begin

	Select @fPvp     = 0 
   	Select @fMt      = @nValProceso
   	Select @fMtum    = 0
   	Select @fMt_cien = 0
   	Select @fVan     = 0
   	Select @fVpar    = 0
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

	-- Valorizacion a Fecha pago fisico para obtener tir historica
        Select @dFechaSalida = ''
        EXECUTE DBO.SP_PagoFisico @FechaPago, @ForPago, @dFechaSalida OUTPUT
	SELECT @Feccal = @dFechaSalida

	SELECT @xTir = 0
   	EXECUTE @nError = @cProg 3, @Feccal, @codigo,@instser, @monemis, @fecemi, @FecVen, 
           	@ntasemi, @nbase, @ntasest,@Nominal OUTPUT, @xTir OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
	        @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
	        @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
	        @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT
      
	SELECT @xTirHistorica = @xTir

--	Select @xTirHistorica -- cbg

	If (@dFAntpCup > @Feccomp)
	   SELECT @Feccal = @dFAntpCup
--	Else
--	   SELECT @Feccal = @feccomp

	Select @fPvp     = 0 
   	Select @fMt      = 0
   	Select @fMtum    = 0
   	Select @fMt_cien = 0
 	Select @fVan     = 0
   	Select @fVpar    = 0
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


	-- Valorizacion a Tir historica fecha cupon anterior o fecha compra segun el papel 

   	EXECUTE @nError = @cProg 2, @Feccal, @codigo,@instser, @monemis, @fecemi, @FecVen, 
           	@ntasemi, @nbase, @ntasest,@Nominal OUTPUT, @xTirHistorica OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
	        @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
	        @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
	        @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

	Select @xValIni = Round(@fMtum,4)
	Select @xValProxVc = ROUND( round( Round( (@fIntpcup+@fAmopcup),4) * @Nominal,6) / 100,4)

	Select @fPvp     = 0 
   	Select @fMt      = 0
   	Select @fMtum    = 0
   	Select @fMt_cien = 0
   	Select @fVan     = 0
   	Select @fVpar    = 0
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

	-- Valorizacion a Tir historica proximo vcto. de cupon
	If @Fecpcup > @fecven  -- VMGS 06/01/2003
		Select @Feccal = @fecven
        Else
		Select @Feccal = @Fecpcup

   	EXECUTE @nError = @cProg 2, @Feccal, @codigo,@instser, @monemis, @fecemi, @FecVen, 
           	@ntasemi, @nbase, @ntasest,@Nominal OUTPUT, @xTirHistorica OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
	        @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
	        @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
	        @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

	SELECT @xValVtop = (@fMtum + @xValProxVc)
        If @dFAntpCup < @Feccomp
		Select @xValIni = @nValProceso / Isnull((Select vmvalor From View_Valor_moneda Where vmcodigo = @monemis and vmfecha = @dFechaSalida),1)


   End

   IF @cTipoper = 'CP' BEGIN
   	If CHARINDEX(SUBSTRING(@Inst,1,2),'LC-IC-BO') = 0 And not (@Monemis = 994 Or @Monemis = 995) AND 
      		@dFecpro >= @dFecPagfI BEGIN
		INSERT  #Tmp ( cartera,
				   numdocu,
				   correla,
				   instser,
				   inst,
				   cliente,
				   codcli,
				   fecorig,
				   fecini,
				   fecvto,
				   moneda,
				   base,
				   nominal,
				   Forpagoi,
				   numoper,
				   renta,
				   tashist,
				   Valinip,
				   ValvTop,
				   vefecreal,
				   Orden,
				 Flag,
				   VerVtas)
	
		VALUES (	   '111',
				   @numdocu,
				   @correla,
				   @instser,
				   @Inst,
				   @nRutCl,
				   @nCodCl,
				   @feccomp,
				   @dFecPagfI,
				   @dFecPagfV,
				   @Monemis,
				   @nBase,
				   @Nominal,
				   @ForPago,
				   @numdocu,
				   'H',
				   @xTirHistorica,
				   @xValIni,
				   @xValVtop,
				   Convert(DAtetime,''),
				   1,
				   0,
				   ' ')
		end

  END ELSE BEGIN
   	If CHARINDEX(SUBSTRING(@Inst,1,2),'LC-IC-BO') = 0 And not @Monemis = 994 AND
      		(@dFecPagfi <= @dFecpro AND @dFecPagfR >= @dFecpro) BEGIN
		INSERT  #Tmp ( cartera,  
				   numdocu,
				   correla,
				   instser,
				   inst,
				   cliente,
				   codcli,
				   fecorig,
				   fecini,
				   fecvto,
				   moneda,
				   base,
				   nominal,
				   Forpagoi,
				   numoper,
				   renta,
				   tashist,
				   Valinip,
				   ValvTop,
				   valorvta,
				   vefecreal,
				   Orden,
				   Flag,
				   VerVtas)

		VALUES (	   '111',
				   @numdocu,
				   @correla,
				   @instser,
				   @Inst,
				   @nRutCl,
				   @nCodCl,
				   @feccomp,
				   @dFecPagfI,
				   @dFecPagfV,
				   @Monemis,
				   @nBase,
				   @Nominal,
				   @ForPago,
				   @nnumoper,
				   CASE WHEN @cTipoper = 'VP' THEN 'V' ELSE 'H' END,
				   @xTirHistorica,
				   @xValIni,
				   @xValVtop,
				   @nValVta,
				   @dFecReal,
				   1,
				   0,
				   @xvVta) eND

  END
  END
  SELECT @nn = @nn + 1 
 End

 /* Ventas con pacto*/

 DELETE #tmpmdcp
 SELECT *, 'Flag' = IDENTITY(INT) INTO #tmpmdvc FROM mdvi 
 SELECT @nCont    = COUNT(1) FROM #tmpmdvc
 SELECT @nn       = 1
 WHILE @nn <= @nCont
    BEGIN
    SELECT @cEstado  = '*'

    SELECT @rutcart  = virutcart,
      	   @numdocu  = vinumdocu,
       	   @instser  = viinstser,
	   @correla  = vicorrela,
	   @dFecInip = vifecinip,
	   @dFecVtop = vifecvenp,
	   @ForPagi  = viforpagi,
	   @ForPagf  = viforpagv,
	   @NumopeVi = vinumoper,
	   @nRutClVi = virutcli,
	   @nmonpact = vimonpact,
	   @cartera  = '114',
	   @cEstado  = ' '
    FROM #tmpmdvc WHERE flag = @nn

--    IF @cEstado = '*' BEGIN
--       BREAK
--    END

    SELECT @dFechaSalida = ''
    EXECUTE DBO.SP_PagoFisico @dFecInip, @ForPagi, @dFechaSalida OUTPUT
    SELECT @dFecPagfIVi = isnull(@dFechaSalida,'')
    SELECT @dFechaSalida = ''
    EXECUTE DBO.SP_PagoFisico @dFecVtop, @ForPagf, @dFechaSalida OUTPUT
    SELECT @dFecPagfVVi = isnull(@dFechaSalida,'')

    If @nmonpact <> 994 AND @dFecpro >= @dFecPagfIVi begin -- AND @cTipopOr = 'CP' Begin

	If not Exists(SELECT * FROM #Tmp WHERE cartera = @cartera AND 
					       fecvto  = @dFecPagfVVi  AND 
					       fecini  = @dFecPagfIVi  AND
					       cliente = @nRutClVi  AND
					       moneda =  @nmonpact AND
					 numoper = @NumopeVi ) Begin

  		INSERT #Tmp ( 	cartera,
				Inst,
				cliente,
				codcli,
				moneda,
				base,
				fecini,
				fecvto,
				Forpagoi,
				Forpagof,
				numoper,
				numdocu,
				correla,
				fecorig,
				renta,
				Valinip,
		    		ValvTop,
				Orden,
				Flag)
		SELECT 	@cartera,
			Isnull((Select inserie FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),''),
			@nRutClVi,
			vicodcli,
			@nmonpact,
			vibaspact,
			@dFecPagfIVi,
			@dFecPagfVVi,
			viforpagi,
			viforpagv,
			@NumopeVi,
			vinumdocu,
			vicorrela,
			vifecinip,
			'H',
			vivalinip,
			vivalvenp,
			2,
			0
  		FROM mdvi
		WHERE  virutcart  = @rutcart  AND
		       vinumdocu  = @numdocu  AND
		       vicorrela  = @correla  AND
		       vinumoper  = @NumopeVi AND
		       virutcli   = @nRutClVi AND
        	       viinstser  = @instser


	End Else Begin
	
 		SELECT 	@Valinip  = vivalinip,
	  	      	@ValVenp  = vivalvenp
		FROM MDVI 
		WHERE  	virutcart = @rutcart  AND
	      	     	vinumdocu = @numdocu  AND
		      	vicorrela = @correla  AND
 		        vinumoper = @NumopeVi AND
		        virutcli  = @nRutClVi AND
        	      	viinstser = @instser

		UPDATE #Tmp 
		SET     Valinip   = Valinip + @Valinip,
		        ValvTop   = ValvTop + @ValVenp
		WHERE  cartera    = @cartera     AND 
			fecini    = @dFecPagfIVi AND
			fecvto    = @dFecPagfVVi AND 
			cliente   = @nRutClVi    AND
			moneda    = @nmonpact    AND
			numoper   = @NumopeVi
	End
    End
    SELECT @nn = @nn + 1
 END 

 /* Busca la cartera compras con pacto*/
 DELETE #tmpmdvc
 SELECT *, 'Flag' = 0 INTO #tmpmdci FROM mdci
 WHERE cimascara <> 'ICOL' And cimascara <> 'ICAP'

 WHILE (1=1)
    BEGIN
    SELECT @cEstado = '*'

    SET ROWCOUNT 1
    SELECT @rutcart  = cirutcart,
      	   @numdocu  = cinumdocu,
       	   @instser  = ciinstser,
	   @correla  = cicorrela,
	   @dFecInip = cifecinip,
	   @dFecVtop = cifecvenp,
	   @ForPagi  = ciforpagi,
	   @ForPagf  = ciforpagv,
	   @NumopeVi = cinumdocu,
	   @nRutClVi = cirutcli,
	   @nmonpact = cimonpact,
	   @cEstado  = ' '
    FROM #tmpmdci WHERE flag = 0
    SET ROWCOUNT 0

    IF @cEstado = '*' BEGIN
       BREAK
    END

    EXECUTE DBO.SP_PagoFisico @dFecInip, @ForPagi, @dFechaSalida OUTPUT
    SELECT  @dFecPagfIVi  = isnull(@dFechaSalida,'')
    SELECT  @dFechaSalida = ''
    EXECUTE DBO.SP_PagoFisico @dFecVtop, @ForPagf, @dFechaSalida OUTPUT
    SELECT  @dFecPagfVVi  = isnull(@dFechaSalida,'')

    If @nmonpact <> 994 AND @dFecpro >= @dFecPagfIVi Begin

	If not Exists(SELECT * FROM #Tmp WHERE cartera = '112'        AND 
					        fecini = @dFecPagfIVi AND
					        fecvto = @dFecPagfVVi AND 
					       cliente = @nRutClVi    AND
					       numoper = @NumopeVi) Begin
  		INSERT #Tmp ( 	cartera,
				Inst,
				Instser,
				cliente,
				codcli,
				moneda,
				base,
				fecini,
				fecvto,
				Forpagoi,
				Forpagof,
				numdocu,
				numoper,
				correla,
				fecorig,
				renta,
				Valinip,
		    		ValvTop,
				vefecreal,
				nominal,
				Orden,
				Flag)
		SELECT 	'112',
			Isnull((Select inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cicodigo),''),
			ciinstser,
			@nRutClVi,
			cicodcli,
			cimonpact,
			cibaspact,
			@dFecPagfIVi,
		        @dFecPagfVVi,
			ciforpagi,
			ciforpagv,
			@NumopeVi,
			@NumopeVi,
			cicorrela,
			cifecinip,
			'H',
			civalinip,
			civalvenp,
			convert(datetime,''),
			cinominal,
			1,
			0
  		FROM mdci
	  	WHERE cirutcart = @rutcart AND
      		      cinumdocu = @numdocu AND
	      	      cicorrela = @correla AND
       	      	      ciinstser = @instser
	End Else Begin
		SELECT @Valinip = civalinip,
  		       @ValVenp = civalvenp
		FROM MDCI 
		WHERE cirutcart = @rutcart AND
      		      cinumdocu = @numdocu AND
	      	      cicorrela = @correla AND
       	      	      ciinstser = @instser

		UPDATE #Tmp 
		SET Valinip     = Valinip + @Valinip,
		    ValvTop     = ValvTop + @ValVenp
		WHERE cartera   = '112'        AND 
		      fecini    = @dFecPagfIVi AND
		      fecvto    = @dFecPagfVVi AND 
		      cliente   = @nRutClVi    AND
		      numoper   = @NumopeVi
	End
    End

    UPDATE #tmpmdci SET flag = 1 WHERE cinumdocu = @numdocu AND cicorrela = @correla
 END 

 /* Recupera pactos vencidos*/

 If @Swfinmes  = 1 
    Select @dFechaVcto = acfecproc from mdac
 else
    Select @dFechaVcto = @dFecpro

 DELETE #tmpmdci
 SELECT *, 'Flag' = IDENTITY(INT,1,1) INTO #tmpmdpv FROM mdrs
 WHERE rsfecha = @dFechaVcto AND  /* el Devengo de Ayer esta con fecha de Hoy */
       rsfecvtop = @dFechaVcto AND 
       rstipcart <> 1 And 
       CHARINDEX(rscartera,'112-114') > 0 and
       rstipoper = 'DEV' -- and rsnumdocu = 46217 and rsnumoper =51270 and rscorrela =3

 SELECT @nCont = MAX(Flag) From #tmpmdpv WHERE CHARINDEX(rscartera,'112-114') > 0
 SELECT    @nn = MIN(Flag) From #tmpmdpv WHERE CHARINDEX(rscartera,'112-114') > 0

 WHILE @nn <= @nCont
    BEGIN
    SELECT @cEstado = '*'

    SELECT @rutcart  = rsrutcart,
      	   @numdocu  = rsnumdocu,
       	   @instser  = rsinstser,
	   @correla  = rscorrela,
	   @dFecInip = rsfecinip,
	   @dFecVtop = rsfecvtop,
	   @ForPagi  = rsforpagi,
	   @ForPagf  = rsforpagv,
	   @NumopeVi = rsnumoper,
	   @nRutClVi = rsrutcli,
	   @nmonpact = rsmonpact,
	   @cartera  = rscartera,
	   @cEstado  = ' '
    FROM #tmpmdpv WHERE flag = @nn


    SELECT @dFechaSalida = ''
    EXECUTE DBO.SP_PagoFisico @dFecInip, @ForPagi, @dFechaSalida OUTPUT
    SELECT @dFecPagfIVi  = isnull(@dFechaSalida,'')
    SELECT @dFechaSalida = ''
    EXECUTE DBO.SP_PagoFisico @dFecVtop, @ForPagf, @dFechaSalida OUTPUT
    SELECT @dFecPagfVVi  = isnull(@dFechaSalida,'')
 
    If @nmonpact <> 994 AND @dFecVtop<= @dFechaVcto And  @dFecPagfVVi > @dFechaVcto Begin

	If not Exists(SELECT 1 FROM #Tmp WHERE cartera = @cartera     AND 
					       fecini  = @dFecPagfIVi AND
					       fecvto  = @dFecPagfVVi AND 
					       cliente = @nRutClVi    AND
					       numoper = @NumopeVi)  Begin
  		INSERT #Tmp ( 	cartera,
				Inst,
				Instser,
				cliente,
				codcli,
				moneda,
				base,
				fecini,
				fecvto,
				Forpagoi,
				Forpagof,
				numoper,
				numdocu,
				correla,
				fecorig,
				renta,
				Valinip,
		    		ValvTop,
				vefecreal,
				Orden,
				Flag)
		SELECT 	rscartera,
			Isnull((Select inserie FROM VIEW_INSTRUMENTO WHERE incodigo = rscodigo),''),
			rsinstser,
			@nRutClVi,

			rscodcli,
			rsmonpact,
			CASE WHEN rsmonpact = 999 THEN 30
			     WHEN rsmonpact = 998 THEN 365
			     ELSE 360 END, --?????????????????
			@dFecPagfIVi,
		        @dFecPagfVVi,
			rsforpagi,
			rsforpagv,
			@NumopeVi,
			rsnumdocu,
			rscorrela,
			rsfecinip,
			'A',
			rsvalinip,
			rsvalvtop,
			convert(datetime,''),
			CASE WHEN rscartera = '112' THEN 1 ELSE 2 END,
			0
  		FROM mdrs
	  	WHERE rsrutcart  = @rutcart    AND
      		      rsnumdocu  = @numdocu    AND
	      	      rscorrela  = @correla    AND
		      rsnumoper  = @NumopeVi   AND
       	      	      rsinstser  = @instser    AND 
		      rsfecha    = @dFechaVcto AND 
       		      rsfecvtop  = @dFechaVcto AND 
       		      rstipcart <> 1           AND 
		      rstipoper  = 'DEV'

	End Else Begin
		SELECT @Valinip = rsvalinip,
  		       @ValVenp = rsvalvtop
		FROM MDRS
		WHERE rsrutcart  = @rutcart    AND
      		      rsnumdocu  = @numdocu    AND
	      	      rscorrela  = @correla    AND
		      rsnumoper  = @NumopeVi   AND
       	      	      rsinstser  = @instser    AND 
		      rsfecha    = @dFechaVcto AND 
       		      rsfecvtop  = @dFechaVcto AND 
       		      rstipcart <> 1           AND 
		      rstipoper = 'DEV'


		UPDATE #Tmp 
		SET Valinip   = Valinip + @Valinip,
		    ValvTop   = ValvTop + @ValVenp
		WHERE cartera = @cartera     AND 
		      fecini  = @dFecPagfIVi AND
		      fecvto  = @dFecPagfVVi AND 
		      cliente = @nRutClVi    AND
		      numoper = @NumopeVi
	End
    End

    SELECT @nn = @nn + 1
 END 

 /* Recupera RCA - RVA del archivo de movimientos diarios */
 DELETE #tmpmdpv
 SELECT *, 'Flag' = 0 INTO #tmpmdrcrv FROM mdmo
 WHERE CHARINDEX(motipoper,'RCA-RVA') > 0 AND 
       momonpact <> 994

 WHILE (1=1)
    BEGIN
    SELECT @cEstado = '*'

    SET ROWCOUNT 1
    SELECT @rutcart  = morutcart,
      	   @numdocu  = monumdocu,
       	   @instser  = moinstser,
	   @correla  = mocorrela,
	   @dFecInip = mofecinip,
	   @dFecVtop = mofecpro,
	   @ForPagi  = moforpagi,
	   @ForPagf  = moforpagv,
	   @ForPagvo = (SELECT rsforpagv FROM MDRS WHERE rsfecha   = mofecpro  AND
							 rsrutcart = morutcart AND
							 rsnumdocu = monumdocu AND
							 rscorrela = mocorrela AND
							 rsnumoper = monumoper AND
							 rscartera = '114'),

	   @NumopeVi = monumoper,
	   @nRutClVi = morutcli,
	   @nmonpact = momonpact,
	   @cartera  = CASE WHEN motipoper = 'RCA' THEN '114' ELSE '112' END,
	 @cEstado  = ' '
    FROM #tmpmdrcrv WHERE flag = 0
    SET ROWCOUNT 0

    IF @cEstado = '*' BEGIN
       BREAK
    END

    SELECT @dFechaSalida  = ''
    EXECUTE DBO.SP_PagoFisico @dFecInip, @ForPagi, @dFechaSalida OUTPUT
    SELECT  @dFecPagfIVi  = isnull(@dFechaSalida,'')
    SELECT @dFechaSalida  = ''
    EXECUTE DBO.SP_PagoFisico @dFecVtop, @ForPagvo, @dFechaSalida OUTPUT
    SELECT  @dFecPagfVVi  = isnull(@dFechaSalida,'')

    -- Fecha y forma de pago vencimiento del anticipo
    SELECT  @dFechaSalida = '' 
    EXECUTE DBO.SP_PagoFisico @dFecpro, @ForPagf, @dFechaSalida OUTPUT
    SELECT  @dFecPagfAnt  = isnull(@dFechaSalida,'')


    If not Exists(SELECT 1 FROM #Tmp WHERE cartera = @cartera     AND 
				           fecini  = @dFecPagfIVi AND
					   fecvto  = @dFecPagfVVi AND 
					   cliente = @nRutClVi    AND
					   numoper = @NumopeVi) Begin
  	INSERT #Tmp ( 	cartera,
			Inst,
			Instser,
			cliente,
			codcli,
			moneda,
			base,
			fecini,
			fecvto,
			Forpagoi,
			Forpagof,
			numdocu,
			numoper,
			correla,
			fecorig,
			renta,
			Valinip,
	    		ValvTop,
			Valvtoreal,
			fecvtoreal,
			tipo,
			Orden,
			Flag)
	SELECT 	@cartera,
		Isnull((Select inserie FROM VIEW_INSTRUMENTO WHERE incodigo = mocodigo),''),
		@instser,
		@nRutClVi,
		mocodcli,
		momonpact,
		mobaspact,
		@dFecPagfIVi,
	        	@dFecPagfVVi,
		@ForPagi,
		@ForPagvo,
		monumdocu,
		@NumopeVi,
		mocorrela,
		mofecinip,
		'R',
		movalinip,
		movalant,--movalvenp,
		movalant,
		@dFecPagfAnt,
		'AP',
		CASE WHEN @cartera = '112' THEN 1 ELSE 2 END,
		0
  	FROM mdmo
	WHERE morutcart  = @rutcart  AND
      	      monumdocu  = @numdocu  AND
	      mocorrela  = @correla  AND
	      monumoper  = @NumopeVi AND
       	      moinstser  = @instser
    End Else Begin
	SELECT @Valinip  = movalinip,
  	       @ValVenp  = movalvenp,
	       @ValAntic = movalant
	FROM MDMO
	WHERE morutcart  = @rutcart  AND
      	      monumdocu  = @numdocu  AND
	      mocorrela  = @correla  AND
	      monumoper  = @NumopeVi AND
       	      moinstser  = @instser
	UPDATE #Tmp 
	SET Valinip    = Valinip    + @Valinip,
	    ValvTop    = ValvTop    + @ValVenp,
	    Valvtoreal = Valvtoreal + @ValAntic
	WHERE cartera  = @cartera     AND 
	      fecini   = @dFecPagfIVi AND
	      fecvto   = @dFecPagfVVi AND 
	      cliente  = @nRutClVi    AND
	      numoper  = @NumopeVi
    End

    UPDATE #tmpmdrcrv SET flag = 1 WHERE monumdocu = @numdocu AND mocorrela = @correla AND monumoper = @NumopeVi
 END 

 SELECT @numdocu  =  0,
	@correla  =  0,
	@NumopeVi =  0,
        @Inst     = ' '

 /* Calcula el valor a tir historica */
--delete #Tmp where numdocu <> 37447 or correla <> 1

 SELECT @nCotador = COUNT(*) FROM #Tmp
 SELECT @i        = 0 
 WHILE @i <= @nCotador
  BEGIN

    Select @Inst = '*'
    SET ROWCOUNT 1
    SELECT @Inst             = inst,
	   @cartera          = cartera,
	   @dfecinip         = fecini,
	   @dfecvtop         = fecvto,
	   @nRutCl           = cliente,
	   @nMoneda          = moneda,
	   @nbase            = base,
	   @ValVenp          = Round(valvtop,4),
	   @Valinip          = valinip,
	   @xTirHistorica    = tirh,
	   @nvalprox         = valprox,
	   @nvalproc         = valproc,
	   @ninteres         = interes,
	   @crenta           = renta,
	   @instser          = instser,
	   @nominal          = nominal,
	   @numdocu          = numdocu,
	   @correla          = correla,
	   @dFechaSalida     = fecorig,
	   @ntirn            = tirn,
	   @NumopeVi         = numoper,
	   @ctipo            = tipo,
	   @nvalvtoreal      = valvtoreal,
	   @dfecvtoreal      = fecvtoreal,
	   @dFecPagfI        = ForPagoI,
	   @dFecPagfV        = ForPagoF,
	   @Seriado          = (Select inmdse FROM VIEW_INSTRUMENTO WHERE inserie = Inst)
    FROM #Tmp WHERE Flag = 0
    SET ROWCOUNT 0

    If @Inst = '*'
       BREAK

    SELECT @i = @i + 1

    Select @xTirHistorica = 0
    If @Valvenp > 0 AND @valinip > 0 Begin

      If @Inst = 'PCDUS$'
	 SELECT @xTirHistorica = Round(@nMediInt,2)
      ELSE 
      BEGIN

	IF (@Inst = 'CERO' OR @Inst = 'ZERO') AND @cartera = '111' 
	    	 SELECT @xTirHistorica = ROUND( (POWER(   (@valvenp/@valinip) , (@nBase/datediff(dd,@dfecinip,@dfecvtop)))-1) *100.0,4)
      	ELSE
             	SELECT @xTirHistorica = ROUND((((@valvenp/@valinip)-1) * @nBase * 100.0) / datediff(dd,@dfecinip,@dfecvtop) , 4)
      END

    End 

    SELECT @fValProx = CONVERT(FLOAT,0),@fValProc = CONVERT(FLOAT,0),@nInteres = CONVERT(FLOAT,0)

    	If (@nMoneda <> 999)
	BEGIN 
    		SELECT @nValMonHoy  = vmvalor FROM view_valor_moneda WHERE @nmoneda = vmcodigo AND vmfecha = @dfecpro
    		SELECT @nValMonPxPr = vmvalor FROM view_valor_moneda WHERE @nmoneda = vmcodigo AND vmfecha = @dFecProx
	
    	End 
	Else 
	BEGIN 
        	SELECT @nValMonHoy  = 1
    		SELECT @nValMonPxPr = 1
	
    	END

	If (@Inst = 'CERO' OR @Inst = 'ZERO') AND @cartera = '111' BEGIN
	   Select @e        = POWER( (1 + (@xTirHistorica/100)), (datediff(dd,@dfecProx,@dfecvtop)/@nBase) )
	   select @r        = round(@Valvenp/@e,6)
	   select @fValProx = round(@r*@nValMonPxPr,0)

	END 
	ELSE  
	BEGIN

	   Select @e        = (1 + (@xTirHistorica/100) * (datediff(dd,@dfecProx,@dfecvtop)/@nBase))
	   select @r        = @Valvenp/@e

	-- Sp_Reporte_TIR_Historica_AFS 1.000000, 20100910, 20100913, 0

	   IF (@nMoneda = 13) --USD
		SELECT @fValProx = Round(@r, 2)
	   ELSE
		SELECT @fValProx = Round(@r * @nValMonPxPr , CASE WHEN @cartera in('114','112') THEN 2 ELSE 0 END)

        	   END

	   If @cTipo = 'AP' 
	   BEGIN
	   	SELECT @nTirhAp  = ROUND( (((@nvalvtoreal/@valinip)-1)*@nBase*100.0 /(datediff(dd,@dfecinip,@dfecvtoreal))),CASE WHEN @cartera in('114','112') THEN 2 ELSE 0 END)
	   	SELECT @fValProc = ROUND( ( @nvalvtoreal / (1 + (@nTirhAp/100.0)) * (datediff(dd,@dfecProx,@dfecvtoreal)/@nBase)) * @nValMonHoy , CASE WHEN @cartera in('114','112') THEN 2 ELSE 0 END)
	   END 
 	   ELSE 
  	   BEGIN

	    	If (@Inst = 'CERO' OR @Inst = 'ZERO') AND @cartera = '111'
		BEGIN
 	        		Select @e   = POWER( (1 + (@xTirHistorica/100)), (datediff(dd,@dfecPro,@dfecvtop)/@nBase) )
	        		select @r   = round(@Valvenp/@e,6)
	        		SELECT @fValProc = round(@r*@nValMonHoy,CASE WHEN @cartera in('114','112') THEN 2 ELSE 0 END)
	    	END
		ELSE
	        		
			IF (@nMoneda = 13) --USD
				SELECT @fValProc = ROUND( @Valvenp / (1 + (@xTirHistorica/100) * (datediff(dd,@dfecPro,@dFecvtop)/@nBase)) ,2)
	   		ELSE
				SELECT @fValProc = ROUND( @Valvenp / (1 + (@xTirHistorica/100) * (datediff(dd,@dfecPro,@dFecvtop)/@nBase)) * @nValMonHoy , CASE WHEN @cartera in('114','112') THEN 2 ELSE 0 END)
	   		END

	SELECT @nInteres = Round(@fValProx - @fValProc,CASE WHEN @cartera in('114','112') THEN 2 ELSE 0 END)
	SELECT @nTirn    = ROUND(   (((@fValProx/@fValProc)-1)*3000) / datediff(dd,@dfecPro,@dFecProx) ,2)


    	UPDATE #Tmp
    	SET   Flag = 1,
		tirh    = @xTirHistorica,
           	 	valprox = @fValProx,
		valproc = @fValProc,
		interes = @nInteres,
		tirn    = @nTirn
    	WHERE cartera = @cartera AND
          		cliente = @nRutCl  AND 
          		numdocu = @numdocu AND 
          		correla = @correla AND 
          		numoper = @NumopeVi
  	END


  
  /* Actualiza Tabla Resumen */

  -- Sp_Reporte_TIR_Historica_AFS 1.000000, 20100730, 20100801, 0

  SELECT @xToCint   = Isnull((Select Sum(interes) FROM #Tmp WHERE CHARINDEX(cartera,'111-112' ) > 0  and  vefecreal <> @dFecpro AND (moneda <> 13) ),0)
  SELECT @xToCint_DOLAR   = Isnull((Select Sum(interes) FROM #Tmp WHERE CHARINDEX(cartera,'111-112' ) > 0  and  vefecreal <> @dFecpro AND (moneda = 13) ),0) 

  SELECT @xToVint   = Isnull((Select Sum(interes) FROM #Tmp WHERE cartera = '114' AND (moneda <> 13) ),0)
  SELECT @xToVint_DOLAR   = Isnull((Select Sum(interes) FROM #Tmp WHERE cartera = '114' AND (moneda = 13) ),0)

  SELECT @xIntDia   = isnull((@xToCint - @xToVint),0)
  SELECT @xIntDia_DOLAR   = isnull((@xToCint_DOLAR - @xToVint_DOLAR),0)

  SELECT @xUtPeVta  = Isnull((Select Sum((ValorVta-ValProc)) FROM #Tmp WHERE cartera = '111' And numoper <> numdocu And vefecreal = @dFecpro AND (moneda <> 13) ),0)
  SELECT @xUtPeVta_DOLAR  = Isnull((Select Sum((ValorVta-ValProc)) FROM #Tmp WHERE cartera = '111' And numoper <> numdocu And vefecreal = @dFecpro AND (moneda = 13) ),0)

  SELECT @xUtPeIdia = Isnull((@xIntDia+@xUtPeVta),0)
  SELECT @xUtPeIdia_DOLAR = Isnull((@xIntDia_DOLAR+@xUtPeVta_DOLAR),0)

  SELECT @xDifPre   = 0
  SELECT @xDifPre_DOLAR   = 0

  SELECT @xTotCProc = Isnull((SELECT Sum(Valproc) FROM #Tmp WHERE CHARINDEX(cartera,'111-112') > 0 and  vefecreal <> @dFecpro AND (moneda <> 13)),0)
  SELECT @xTotCProc_DOLAR = Isnull((SELECT Sum(Valproc) FROM #Tmp WHERE CHARINDEX(cartera,'111-112') > 0 and  vefecreal <> @dFecpro AND (moneda = 13)),0)

  SELECT @xTotVproc = Isnull((SELECT Sum(Valproc) FROM #Tmp WHERE cartera ='114' AND (moneda <> 13)),0)
  SELECT @xTotVproc_DOLAR = Isnull((SELECT Sum(Valproc) FROM #Tmp WHERE cartera ='114' AND (moneda = 13)),0)
  
  SELECT @xCosPro   = Round((@nMediInt/3000) * datediff(dd,@dfecPro,@dFecProx) * (@xTotCProc-@xTotVproc)  ,0)
  SELECT @xCosPro_DOLAR   = Round((@nMediInt/3000) * datediff(dd,@dfecPro,@dFecProx) * (@xTotCProc_DOLAR-@xTotVproc_DOLAR)  ,0)

  SELECT @xTotDia   = Isnull((@xUtPeIdia+@xDifPre)- @xCosPro,0)
  SELECT @xTotDia_DOLAR   = Isnull((@xUtPeIdia_DOLAR+@xDifPre_DOLAR)- @xCosPro_DOLAR,0)

  IF DATEPART(MONTH,@ac_Fecpro) <> DATEPART(MONTH,@ac_FecProx) AND @dFecpro > @ac_Fecpro

	SELECT	@nTotCInt	= 0,
		@nTotVInt	= 0,
		@nIntDia	= 0,
		@nUtPeVta	= 0,
		@nUtPeIntDia	= 0,
		@nDifPre	= 0,
		@nCosPro	= 0,
		@nTotDia	= 0,

		@nTotCInt_DOLAR	= 0,
  	 	@nTotVInt_DOLAR 	= 0,
		@nIntDia_DOLAR	= 0,
  	 	@nUtPeVta_DOLAR 	= 0,
		@nUtPeIntDia_DOLAR	= 0,
  	 	@nDifPre_DOLAR 	= 0,
  	 	@nCosPro_DOLAR 	= 0,
		@nTotDia_DOLAR	= 0

-- Sp_Reporte_TIR_Historica_AFS 1.000000, 20100730, 20100801, 0

-- ************* EN PESOS *************

 -- Fecha Proceso
  SELECT
         	@Hinteresesganadosporcompras       	= Isnull(@xToCint,0),
         	@Hinteresespagadosporventas        	= Isnull(@xToVint,0),
  	@HUtilidadperdidaporintereses      	= Isnull(@xIntDia,0),
	@HUtilidadperdidaporventadecartera 	= Isnull(@xUtPeVta,0),
	@HUtilidadperdidafinalporcartera   	= Isnull(@xUtPeIdia,0),
	@HDiferenciadeprecios              		= Isnull(@xDifPre,0),
	@Hcostopromedio                    		= Isnull(@xCosPro,0),
	@HUtilidadPerdidanetaenpesos       	= Isnull(@xTotDia,0),

  -- Dia Anterior
 	 @Ainteresesganadosporcompras       	= Isnull(@nTotCInt,0),
  	 @Ainteresespagadosporventas        	= Isnull(@nTotVInt,0),
  	 @AUtilidadperdidaporintereses      	= Isnull(@nIntDia,0),
  	 @AUtilidadperdidaporventadecartera 	= Isnull(@nUtPeVta,0),
	 @AUtilidadperdidafinalporcartera   	= Isnull(@nUtPeIntDia,0),
  	 @ADiferenciadeprecios              		= Isnull(@nDifPre,0),
  	 @Acostopromedio                    		= Isnull(@nCosPro,0),
	 @AUtilidadPerdidanetaenpesos       	= Isnull(@nTotDia,0),

  --  ACUMULADO MES
         	@Minteresesganadosporcompras       	= Isnull(@xToCint+@nTotCInt,0),
         	@Minteresespagadosporventas        	= Isnull(@xToVint+@nTotVInt,0),
  	@MUtilidadperdidaporintereses      	= Isnull(@xIntDia+@nIntDia,0),
	@MUtilidadperdidaporventadecartera 	= Isnull(@xUtPeVta+@nUtPeVta,0),
	@MUtilidadperdidafinalporcartera   	= Isnull(@xUtPeIdia+@nUtPeIntDia,0),
	@MDiferenciadeprecios              		= Isnull(@xDifPre+@nDifPre,0),
	@Mcostopromedio                    		= Isnull(@xCosPro+@nCosPro,0),
	@MUtilidadPerdidanetaenpesos       	= Isnull(@xTotDia+@nTotDia,0),

         	@FechaP   				= 'Media Interbancaria ' + CONVERT(CHAR(10),@dFecpro,103),
	@TasMedia 				= @nMediInt, --  + ' Posición Financiada con Recursos propios   $$ ' + 
	@Posicion 				= CONVERT(NUMERIC(19,4),Isnull((@xTotCProc - @xTotVproc),0)),
	@Costo    				= CONVERT(NUMERIC(19,4),Isnull(@xCosPro,0)),


-- ************* EN DOLARES *************

 -- Fecha Proceso
	@Hinteresesganadosporcompras_DOLAR       = Isnull(@xToCint_DOLAR,0),
	@Hinteresespagadosporventas_DOLAR       = Isnull(@xToVint_DOLAR,0),
	@HUtilidadperdidaporintereses_DOLAR      = Isnull(@xIntDia_DOLAR,0),	
	@HUtilidadperdidaporventadecartera_DOLAR = Isnull(@xUtPeVta_DOLAR,0),
	@HUtilidadperdidafinalporcartera_DOLAR   = Isnull(@xUtPeIdia_DOLAR,0),
	@HDiferenciadeprecios_DOLAR              = Isnull(@xDifPre_DOLAR,0),
	@Hcostopromedio_DOLAR                    = Isnull(@xCosPro_DOLAR,0),
	@HUtilidadPerdidanetaenpesos_DOLAR       = Isnull(@xTotDia_DOLAR,0),

  -- Dia Anterior
	 @Ainteresesganadosporcompras_DOLAR       	= Isnull(@nTotCInt_DOLAR,0),
  	 @Ainteresespagadosporventas_DOLAR        	= Isnull(@nTotVInt_DOLAR,0),
  	 @AUtilidadperdidaporintereses_DOLAR      	= Isnull(@nIntDia_DOLAR,0),
  	 @AUtilidadperdidaporventadecartera_DOLAR 	= Isnull(@nUtPeVta_DOLAR,0),
	 @AUtilidadperdidafinalporcartera_DOLAR   	= Isnull(@nUtPeIntDia_DOLAR,0),
  	 @ADiferenciadeprecios_DOLAR              		= Isnull(@nDifPre_DOLAR,0),
  	 @Acostopromedio_DOLAR                    		= Isnull(@nCosPro_DOLAR,0),
	 @AUtilidadPerdidanetaenpesos_DOLAR       	= Isnull(@nTotDia_DOLAR,0),
	
 --  ACUMULADO MES
         	@Minteresesganadosporcompras_DOLAR       	= Isnull(@xToCint_DOLAR+@nTotCInt_DOLAR,0),
         	@Minteresespagadosporventas_DOLAR        	= Isnull(@xToVint_DOLAR+@nTotVInt_DOLAR,0),
  	@MUtilidadperdidaporintereses_DOLAR      	= Isnull(@xIntDia_DOLAR+@nIntDia_DOLAR,0),
	@MUtilidadperdidaporventadecartera_DOLAR 	= Isnull(@xUtPeVta_DOLAR+@nUtPeVta_DOLAR,0),
	@MUtilidadperdidafinalporcartera_DOLAR   	= Isnull(@xUtPeIdia_DOLAR+@nUtPeIntDia_DOLAR,0),
	@MDiferenciadeprecios_DOLAR              		= Isnull(@xDifPre_DOLAR+@nDifPre_DOLAR,0),
	@Mcostopromedio_DOLAR                    		= Isnull(@xCosPro_DOLAR+@nCosPro_DOLAR,0),
	@MUtilidadPerdidanetaenpesos_DOLAR       	= Isnull(@xTotDia_DOLAR+@nTotDia_DOLAR,0)

  UPDATE #Tmp
  SET      inst = 'VI'
  WHERE cartera = '114'

  UPDATE #Tmp
  SET      inst = 'CI'
  WHERE cartera = '112'

--  DELETE #Tmp 
  delete #Tmp Where numdocu <> Numoper and cartera = '111' and vefecreal = @dFecpro

-- cbg despues sacar
--SELECT  count(* ) from #Tmp

  IF (SELECT COUNT(*) FROM #Tmp) > 0 

	-- Sp_Reporte_TIR_Historica_AFS 1.000000, 20100730, 20100801, 0

  	SELECT 
		#Tmp.cartera,
	  	#Tmp.Orden,
	  	#Tmp.fecini,
	  	#Tmp.fecvto,  --vefecreal
	  	'NombreCl'=(SELECT clnombre from view_cliente WHERE clrut = #Tmp.cliente And clcodigo = codcli),
	  	#Tmp.moneda,
	  	#Tmp.base,
	  	'valvtop' = ROUND(#Tmp.valvtop,4),
	  	'valinip' = ROUND(#Tmp.valinip,4),
	  	#Tmp.tirh,
	  	#Tmp.valprox,
	  	#Tmp.valproc,
	  	#Tmp.interes,
		--'Interes' = (CASE WHEN (@tc_rep_cnt = 'S') AND (#Tmp.moneda = 13) THEN (#Tmp.interes * @DO_TC) ELSE #Tmp.interes END),
	  	#Tmp.renta,
	  	#Tmp.instser,
	  	#Tmp.inst,
   	       	'nominal'= Isnull(#Tmp.nominal,0),
	  	'numdocu' = CONVERT(CHAR(10),#Tmp.numdocu),
	  	#Tmp.correla,
	  	'fecorig'=CONVERT(CHAR(10),#Tmp.fecorig,103),
	  	#Tmp.tashist,
	  	#Tmp.tirn,
	  	#Tmp.numoper,
	  	#Tmp.valorvta,
	  	#Tmp.vefecreal,
	  	#Tmp.tipo,
	  	#Tmp.valvtoreal,
	  	#Tmp.fecvtoreal,
	  	#Tmp.ForPagoI,
	  	#Tmp.ForPagoF,
	  	'Moneda'  = (Isnull((SELECT mnnemo FROM View_moneda WHERE mncodmon = #Tmp.moneda),'')),
	  	'FecProx' = CONVERT(CHAR(10),@dFecProx,103),
	  	'FecProc' = CONVERT(CHAR(10),@dFecPro,103),
	  	'DifDia'  = Datediff(dd,@dFecPro,@dFecProx),
	  	'Mes' = CASE 	WHEN DATEPART(mm,@dFecPro) = 1  THEN 'ENERO' 
		       		WHEN DATEPART(mm,@dFecPro) = 2  THEN 'FEBRERO'
				WHEN DATEPART(mm,@dFecPro) = 3  THEN 'MARZO'
				WHEN DATEPART(mm,@dFecPro) = 4  THEN 'ABRIL'
				WHEN DATEPART(mm,@dFecPro) = 5  THEN 'MAYO'
				WHEN DATEPART(mm,@dFecPro) = 6  THEN 'JUNIO'
				WHEN DATEPART(mm,@dFecPro) = 7  THEN 'JULIO'
				WHEN DATEPART(mm,@dFecPro) = 8  THEN 'AGOSTO'
				WHEN DATEPART(mm,@dFecPro) = 9  THEN 'SEPTIEMBRE'
				WHEN DATEPART(mm,@dFecPro) = 10 THEN 'OCTUBRE'
				WHEN DATEPART(mm,@dFecPro) = 11 THEN 'NOVIEMBRE'
				WHEN DATEPART(mm,@dFecPro) = 12 THEN 'DICIEMBRE' END,
	  	'Ainteresesganadosporcompras'      = @Ainteresesganadosporcompras,
  	  	'Ainteresespagadosporventas'       = @Ainteresespagadosporventas,
  	  	'AUtilidadperdidaporintereses'     = @AUtilidadperdidaporintereses,
  	  	'AUtilidadperdidaporventadecartera'= @AUtilidadperdidaporventadecartera,
	  	'AUtilidadperdidafinalporcartera'  = @AUtilidadperdidafinalporcartera,
  	  	'ADiferenciadeprecios'             = @ADiferenciadeprecios,
  	  	'Acostopromedio'                   = @Acostopromedio,
	  	'AUtilidadPerdidanetaenpesos'      = @AUtilidadPerdidanetaenpesos,
          		'Hinteresesganadosporcompras'      = @Hinteresesganadosporcompras,
          		'Hinteresespagadosporventas'       = @Hinteresespagadosporventas,
  	  	'HUtilidadperdidaporintereses'     = @HUtilidadperdidaporintereses,
	  	'HUtilidadperdidaporventadecartera'= @HUtilidadperdidaporventadecartera,
	  	'HUtilidadperdidafinalporcartera'  = @HUtilidadperdidafinalporcartera,
	  	'HDiferenciadeprecios'             = @HDiferenciadeprecios,
	  	'Hcostopromedio'                   = @Hcostopromedio,
	  	'HUtilidadPerdidanetaenpesos'      = @HUtilidadPerdidanetaenpesos,
	  	'Minteresesganadosporcompras'      = @Minteresesganadosporcompras,
          		'Minteresespagadosporventas'       = @Minteresespagadosporventas,
  	  	'MUtilidadperdidaporintereses'     = @MUtilidadperdidaporintereses,
	  	'MUtilidadperdidaporventadecartera'= @MUtilidadperdidaporventadecartera,
	  	'MUtilidadperdidafinalporcartera'  = @MUtilidadperdidafinalporcartera,
	  	'MDiferenciadeprecios'             = @MDiferenciadeprecios,
	  	'Mcostopromedio'                   = @Mcostopromedio,
	  	'MUtilidadPerdidanetaenpesos'      = @MUtilidadPerdidanetaenpesos,
		--'Hinteresesganadosporcompras_DOLAR' = @Hinteresesganadosporcompras_DOLAR,
          		'FechaP'                           = @FechaP,
	  	'TasMedia'                         = @TasMedia, 
	  	'Posicion'                         = @Posicion,
	  	'Costo'                            = @Costo,
	  	'Hora'                             = CONVERT(CHAR(10),GETDATE(),108),
          		'NomProp'                          = acnomprop,
	          	'RutProp'= Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.') + '-' + acdigprop,

	 	-- Fecha Proceso (DOLAR)
		'Hinteresesganadosporcompras_DOLAR' 		= @Hinteresesganadosporcompras_DOLAR,
		'Hinteresespagadosporventas_DOLAR' 		= @Hinteresespagadosporventas_DOLAR,
		'HUtilidadperdidaporintereses_DOLAR' 		= @HUtilidadperdidaporintereses_DOLAR,
		'HUtilidadperdidaporventadecartera_DOLAR' 	= @HUtilidadperdidaporventadecartera_DOLAR,
		'HUtilidadperdidafinalporcartera_DOLAR' 		= @HUtilidadperdidafinalporcartera_DOLAR,
		'HDiferenciadeprecios_DOLAR' 			= @HDiferenciadeprecios_DOLAR,
		'Hcostopromedio_DOLAR' 			= @Hcostopromedio_DOLAR,
		'HUtilidadPerdidanetaenpesos_DOLAR' 		= @HUtilidadPerdidanetaenpesos_DOLAR,
		-- Dia Anterior (DOLAR)
	 	'Ainteresesganadosporcompras_DOLAR' 		= @Ainteresesganadosporcompras_DOLAR,
  	 	'Ainteresespagadosporventas_DOLAR'	 	= @Ainteresespagadosporventas_DOLAR,
  	 	'AUtilidadperdidaporintereses_DOLAR' 		= @AUtilidadperdidaporintereses_DOLAR,
  	 	'AUtilidadperdidaporventadecartera_DOLAR' 	= @AUtilidadperdidaporventadecartera_DOLAR,
	 	'AUtilidadperdidafinalporcartera_DOLAR' 		= @AUtilidadperdidafinalporcartera_DOLAR,
  	 	'ADiferenciadeprecios_DOLAR' 			= @ADiferenciadeprecios_DOLAR,
  	 	'Acostopromedio_DOLAR' 			= @Acostopromedio_DOLAR,
	 	'AUtilidadPerdidanetaenpesos_DOLAR' 		= @AUtilidadPerdidanetaenpesos_DOLAR,
		--  ACUMULADO MES (DOLAR)
        		'Minteresesganadosporcompras_DOLAR' 		= @Minteresesganadosporcompras_DOLAR,
        		'Minteresespagadosporventas_DOLAR' 		= @Minteresespagadosporventas_DOLAR,
  		'MUtilidadperdidaporintereses_DOLAR' 		= @MUtilidadperdidaporintereses_DOLAR,
		'MUtilidadperdidaporventadecartera_DOLAR' 	= @MUtilidadperdidaporventadecartera_DOLAR,
		'MUtilidadperdidafinalporcartera_DOLAR' 		= @MUtilidadperdidafinalporcartera_DOLAR,
		'MDiferenciadeprecios_DOLAR' 			= @MDiferenciadeprecios_DOLAR,
		'Mcostopromedio_DOLAR' 			= @Mcostopromedio_DOLAR,
		'MUtilidadPerdidanetaenpesos_DOLAR' 		= @MUtilidadPerdidanetaenpesos_DOLAR

 	FROM #Tmp, mdac  
	--WHERE (#Tmp.Moneda = 13)
	Order by #Tmp.Orden,#Tmp.Cartera,#Tmp.inst,#Tmp.Instser

	-- Sp_Test 1.000000, 20100910, 20100913, 0

 ELSE

  	SELECT 
		'cartera'   = '',
	  	'Orden'     = 1,
	  	'fecini'    = CONVERT(CHAR(10),GETDATE(),103),
	  	'fecvto'    = CONVERT(CHAR(10),GETDATE(),103),
	  	'NombreCl'  = 'NO EXISTEN DATOS PARA IMPRIMIR',
	  	'moneda'    = 0,
	  	'base'      = 0,
	  	'valvtop'   = ROUND(0,4),
	  	'valinip'   = ROUND(0,4),
	  	'tirh'      = 0,
	  	'valprox'   = 0,
	  	'valproc'   = 0,
	  	'interes'   = 0,
	  	'renta'     = '',
	  	'instser'   = '',
	  	'inst'      = '',
          		'nominal'   = 0,
	  	'numdocu'   = CONVERT(CHAR(10),0),
	  	'correla'   = 0,
	  	'fecorig'   = CONVERT(CHAR(10),GETDATE(),103),
	  	'tashist'   = 0,
	  	'tirn'      = 0,
	  	'numoper'   = 0,
	  	'valorvta'  = 0,
	  	'vefecreal' = CONVERT(CHAR(10),GETDATE(),103),
	  	'tipo'      ='',
	  	'valvtoreal'= 0,
	  	'fecvtoreal'= CONVERT(CHAR(10),GETDATE(),103),
	  	'ForPagoI'  = 0,
	  	'ForPagoF'  = 0,
	  	'Moneda'    = '',
	  	'FecProx'   = CONVERT(CHAR(10),@dFecProx,103),
	  	'FecProc'   = CONVERT(CHAR(10),@dFecPro,103),
	  	'DifDia'    = Datediff(dd,@dFecPro,@dFecProx),
	  	'Mes'       = CASE 	WHEN DATEPART(mm,@dFecPro) = 1 THEN 'ENERO' 
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
				WHEN DATEPART(mm,@dFecPro) = 12 THEN 'DICIEMBRE' END,
	  	'Ainteresesganadosporcompras'       = @Ainteresesganadosporcompras,
  	  	'Ainteresespagadosporventas'        = @Ainteresespagadosporventas,
  	  	'AUtilidadperdidaporintereses'      = @AUtilidadperdidaporintereses,
  	  	'AUtilidadperdidaporventadecartera' =@AUtilidadperdidaporventadecartera,
	  	'AUtilidadperdidafinalporcartera'   = @AUtilidadperdidafinalporcartera,
  	  	'ADiferenciadeprecios'              = @ADiferenciadeprecios,
  	  	'Acostopromedio'                    = @Acostopromedio,
	  	'AUtilidadPerdidanetaenpesos'       = @AUtilidadPerdidanetaenpesos,
          		'Hinteresesganadosporcompras'       = @Hinteresesganadosporcompras,
          		'Hinteresespagadosporventas'        = @Hinteresespagadosporventas,
  	  	'HUtilidadperdidaporintereses'      = @HUtilidadperdidaporintereses,
	  	'HUtilidadperdidaporventadecartera' = @HUtilidadperdidaporventadecartera,
	  	'HUtilidadperdidafinalporcartera'   = @HUtilidadperdidafinalporcartera,
	  	'HDiferenciadeprecios'              = @HDiferenciadeprecios,
	  	'Hcostopromedio'                    = @Hcostopromedio,
	  	'HUtilidadPerdidanetaenpesos'       = @HUtilidadPerdidanetaenpesos,
	  	'Minteresesganadosporcompras'       = @Minteresesganadosporcompras,
          		'Minteresespagadosporventas'        = @Minteresespagadosporventas,
  	  	'MUtilidadperdidaporintereses'      = @MUtilidadperdidaporintereses,
	  	'MUtilidadperdidaporventadecartera' = @MUtilidadperdidaporventadecartera,
	  	'MUtilidadperdidafinalporcartera'   = @MUtilidadperdidafinalporcartera,
	  	'MDiferenciadeprecios'              = @MDiferenciadeprecios,
	  	'Mcostopromedio'                    = @Mcostopromedio,
	  	'MUtilidadPerdidanetaenpesos'       = @MUtilidadPerdidanetaenpesos,
          		'FechaP'                            = @FechaP,
	  	'TasMedia'                          = @TasMedia, 
	  	'Posicion'                          = @Posicion,
	  	'Costo'                             = @Costo,
	  	'Hora'                              = CONVERT(CHAR(10),GETDATE(),108),
          		'NomProp'                           = acnomprop,
          		'RutProp' = Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,

		-- Fecha Proceso (DOLAR)
		'Hinteresesganadosporcompras_DOLAR' 		= @Hinteresesganadosporcompras_DOLAR,
		'Hinteresespagadosporventas_DOLAR' 		= @Hinteresespagadosporventas_DOLAR,
		'HUtilidadperdidaporintereses_DOLAR' 		= @HUtilidadperdidaporintereses_DOLAR,
		'HUtilidadperdidaporventadecartera_DOLAR' 	= @HUtilidadperdidaporventadecartera_DOLAR,
		'HUtilidadperdidafinalporcartera_DOLAR' 		= @HUtilidadperdidafinalporcartera_DOLAR,
		'HDiferenciadeprecios_DOLAR' 			= @HDiferenciadeprecios_DOLAR,
		'Hcostopromedio_DOLAR' 			= @Hcostopromedio_DOLAR,
		'HUtilidadPerdidanetaenpesos_DOLAR' 		= @HUtilidadPerdidanetaenpesos_DOLAR,
		-- Dia Anterior (DOLAR)
	 	'Ainteresesganadosporcompras_DOLAR' 		= @Ainteresesganadosporcompras_DOLAR,
  	 	'Ainteresespagadosporventas_DOLAR'	 	= @Ainteresespagadosporventas_DOLAR,
  	 	'AUtilidadperdidaporintereses_DOLAR' 		= @AUtilidadperdidaporintereses_DOLAR,
  	 	'AUtilidadperdidaporventadecartera_DOLAR' 	= @AUtilidadperdidaporventadecartera_DOLAR,
	 	'AUtilidadperdidafinalporcartera_DOLAR' 		= @AUtilidadperdidafinalporcartera_DOLAR,
  	 	'ADiferenciadeprecios_DOLAR' 			= @ADiferenciadeprecios_DOLAR,
  	 	'Acostopromedio_DOLAR' 			= @Acostopromedio_DOLAR,
	 	'AUtilidadPerdidanetaenpesos_DOLAR' 		= @AUtilidadPerdidanetaenpesos_DOLAR,
		--  ACUMULADO MES (DOLAR)
        		'Minteresesganadosporcompras_DOLAR' 		= @Minteresesganadosporcompras_DOLAR,
        		'Minteresespagadosporventas_DOLAR' 		= @Minteresespagadosporventas_DOLAR,
  		'MUtilidadperdidaporintereses_DOLAR' 		= @MUtilidadperdidaporintereses_DOLAR,
		'MUtilidadperdidaporventadecartera_DOLAR' 	= @MUtilidadperdidaporventadecartera_DOLAR,
		'MUtilidadperdidafinalporcartera_DOLAR' 		= @MUtilidadperdidafinalporcartera_DOLAR,
		'MDiferenciadeprecios_DOLAR' 			= @MDiferenciadeprecios_DOLAR,
		'Mcostopromedio_DOLAR' 			= @Mcostopromedio_DOLAR,
		'MUtilidadPerdidanetaenpesos_DOLAR' 		= @MUtilidadPerdidanetaenpesos_DOLAR

 	FROM mdac

--select * from MDAC

 UPDATE MDAC
 SET	acxTotCint = @xToCint,
	acxTotVint = @xToVint,
	acxUtPeVta = @xUtPeVta,
	acxDifPre  = @xDifPre,
	acxCosPro  = @xCosPro,

	USD_acyTotCint = @xToCint_DOLAR,
	USD_acyTotVint = @xToVint_DOLAR,
	USD_acyUtPeVta = @xUtPeVta_DOLAR,
	USD_acyDifPre  = @xDifPre_DOLAR,
	USD_acyCodPro  = @xCosPro_DOLAR


  SET NOCOUNT OFF

END

GO
