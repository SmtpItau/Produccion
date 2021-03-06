USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_STOCK_CART_Tirc_Prop]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_STOCK_CART_Tirc_Prop] (@cFecRep CHAR(08))
AS 

BEGIN

SET NOCOUNT ON

DECLARE @FECPROC     CHAR(10), 
	@dFecPrx     DATETIME,
	@nValCupon   FLOAT,
        @dFecSal     DATETIME,
        @fValmon_Cup FLOAT,
	@cMascara    CHAR(12),
	@dFecCal     DATETIME

DECLARE @xSistema    CHAR(03),
        @xTipoMov    CHAR(03), 
        @TipOpe      CHAR(03), 
	@codins      CHAR(6),
	@xMoneda     NUMERIC(03),
	@TipoCartera CHAR(01),
	@xRutCli     NUMERIC(09),
	@xCodCli     Numeric(9),
	@dFecini     Datetime,
	@dFecFin     Datetime,
	@xGarantia   Char(01),
	@NumDocu     Numeric(10),
	@Correla     Numeric(03),
	@cOpe        CHAR(08),
	@cEstado     CHAR(01),
	@cCond	     CHAR(02),
	@cCondi	     CHAR(02),	
	@cLlave	     CHAR(21),
	@indice	     INT,
	@cCustodia   CHAR(01),
	@nReg 	     INT,
	@nn	     INT,
	@cCampoVar   CHAR(10),
	@nmoneda     NUMERIC(3),
	@nValCont    FLOAT,
	@dFecinicial DATETIME,
	@nValMon     FLOAT,	
	@nMtoPe	     FLOAT,
	@nNominal    FLOAT,
	@Valini	     FLOAT,
	@ValVen	     FLOAT,
	@cRtEm       NUMERIC(09),
	@cNumcta     CHAR(08),
	@nCont	     INT,
	@n	     INT,
	@nValOpePe   FLOAT,
	@xMonemi     NUMERIC(03),
	@dFecRep     DATETIME,
	@Valcomp     FLOAT,
	@nUf_Hoy     FLOAT,
	@nUf_Pag     FLOAT,
	@cProg 	     CHAR(10),
	@codigo	     NUMERIC(05),
	@instser     CHAR(12),
	@xfecemi     DATETIME,
	@Fecven	     DATETIME,
	@ntasemi     FLOAT,
	@nbase	     NUMERIC(04),
	@ntasest     FLOAT,
	@Nominal     NUMERIC(19,4),
	@xTir	     NUMERIC(09,4),
	@nDias	     NUMERIC(05),
	@dFecpcup    DATETIME,
	@nReajuste   FLOAT,
	@nInteres    FLOAT,
	@nVpresen    NUMERIC(19,4),
        @cSeriado    CHAR(01)


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
	@dFecucup datetime,
	@monemis NUMERIC(05),
	@nFecPag datetime
	

	UPDATE saldos_cartera SET SALDO = 0

	SELECT @dFecRep = CONVERT(DATETIME,@cFecRep)
	SELECT @FECPROC =CONVERT(CHAR(10),acfecproc,112),
	       @dFecPrx = acfecprox
	FROM MDAC



	-- STOCK PROPIO
	SELECT 
		NUMDOCU 		= cpnumdocu,
		CORRELA		= cpcorrela,
		FECHA_EMISION 	= CONVERT(CHAR(12), cpfecemi, 103),
		SERIE			= RTRIM(cpinstser) + (case when Fecha_pagomañana > @dFecRep THEN ' *' ELSE '' END),
		TCORRELA		= 1,
		SERIADO         		= cpseriado,
		CODIGO_BOLSA  	= 0,
		NUM_CLI		= ISNULL((SELECT codigo_as400 FROM VIEW_CLIENTE WHERE clrut = cprutcli and clcodigo = cpcodcli ),0),
		RUT_EMISOR      	= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara ),0)WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela) ,0)  END),
		COD_EMISOR		= cpcodcli,
		NOM_EMISOR		= SPACE(50),
		CONTRATO		= ISNULL(a.Numero_Contrato,0),
		NOM_MONEDA		= SPACE(10),
		COD_MONEDA		= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = cpmascara),0) WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela),0) END),
		NOMINAL		= cpnominal + isnull((select sum(vinominal) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		PRECIO_OP_UM		= isnull(a.valor_contable,0) + isnull((select sum(valor_contable) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		PRECIO_OP		= isnull(a.valor_contable,0) + isnull((select sum(valor_contable) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		TASA_CON      		= ISNULL(a.tasa_contrato,0),
		FECHA_VENCI   		= cpfecven,--CONVERT(CHAR(12),cpfecven,103),
		INTERES		= CONVERT(Numeric(19,4),(a.valor_contable + isnull((select sum(valor_contable) from mdvi where vinumdocu = cpnumdocu and vicorrela = cpcorrela),0))), 
		OP_PROVENIENTE 	 = ' ',
		FAMILIA_SERIE   	= ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo),''),
		GLOSA           		= 'STOCK PROPIO   ',
		OPERACION 		=  CONVERT(VARCHAR(100),'STOCK TOTAL ' + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = a.codigo_carterasuper AND tbcateg = '1111')), -- CONVERT(VARCHAR(100),'STOCK TOTAL ' + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = cptipcart AND tbcateg = '204')),
                	orden           		= 1,
		tip				= codigo_carterasuper, --cptipcart   
		fecha_operacion 	= CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN Fecha_pagomañana ELSE cpfeccomp END,
		tipoper			= 'CP'			,
		valor_venc		= convert(float,0)	,
		fecha_pacto		= Convert(datetime,'')	,
		dias			= CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > Fecha_pagomañana And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE Fecha_pagomañana END) ELSE Fecha_PagoMañana END) ,@dFecRep)
					ELSE
					    datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > cpfeccomp And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE cpfeccomp END) ELSE cpfeccomp END) ,@dFecRep)
					END,

		tipopero	= 'CP',
		valor_ini      		 = convert(numeric(19,4),0),
		OprRes       		= 'STOCKCP',
		ModInv			= CASE WHEN cptipcart = 1 THEN 'T' 
					WHEN cptipcart = 2 THEN 'A'
					WHEN cptipcart = 4 THEN 'H'
					ELSE 'P' END,
		ValorCont		= a.Valor_Contable + isnull((select sum(Valor_Contable) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		RutEmi			= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara ),0)
             				WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela),0)  END),
		VerVp			= (CASE WHEN (EXISTS(Select  TOP 1 virutcart from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) Or cpnominal > 0) THEN ' ' ELSE 'X' END),
		monemi			= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = cpmascara),0) WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela),0) END),
		FecaPagoOrig    		= Fecha_pagomañana,
		Tasapacto       		= 0.0,
		VctoPacto		= CPFECVEN,
		TirComp		= cptircomp,
		vPresen			= Convert(Float,0),
		InteresesPeso   		= Convert(Float,0),
		Reajustes		= Convert(Float,0),
		Codigo			= cpcodigo,
		Base			= (Select inbasemi FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo),
		Valcomp		= cpvalcomu + isnull((select sum(vivalcomu) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
                	ValcompPeso		= cpvalcomp + isnull((select sum(vivalcomp) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		Mascara			= cpmascara,
		Flag			= IDENTITY(INT)
	INTO #PASO
	FROM MDCP a,mdac 
	WHERE (cpnominal>0 or EXISTS(SELECT * FROM mdvi WHERE vinumdocu = cpnumdocu and vicorrela = cpcorrela)) --CBG
	order by NUMDOCU

    delete #paso where VerVp = 'X' and Orden = 1  -- Quedan 494 reg. de 1200



        UPDATE #PASO
 	Set interes = interes/(CAse when COD_MONEDA = 999 or COD_MONEDA = 13 Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = CASE WHEN cpfeccomp <= CONVERT(DATETIME,'20070115') THEN Fecha_Pagomañana ELSE cpfeccomp END) End) -- CBG 18/08/2004
        FROM Mdcp 
	WHERE numdocu = cpnumdocu and correla = cpcorrela and orden = 1

-- DISPONIBILIDAD 
	INSERT #PASO
	SELECT	NUMDOCU 	= dinumdocu,
		CORRELA		= dicorrela,
		FECHA_EMISION 	= Convert(Char(12),''),
		SERIE		= RTRIM(diinstser)  + (case when Fecha_pagomañana > @dFecRep THEN ' *' ELSE '' END),
		TCORRELA	= 2,
		SERIADO         = ' ',
		CODIGO_BOLSA  	= 0,
		NUM_CLI		= 0,
		RUT_EMISOR      = 0,
		COD_EMISOR	= 0,
		NOM_EMISOR	= ' ',
		CONTRATO	= 0,
		NOM_MONEDA	= 0,
		COD_MONEDA	= 0,
		NOMINAL		= dinominal, 
		PRECIO_OP_UM	= isnull(a.valor_contable,0), 
		PRECIO_OP	= isnull(a.valor_contable,0),
		TASA_CON      	= 0.0,
		FECHA_VENCI   	= Convert(Datetime,''),
		INTERES		= convert(float,0),
		OP_PROVENIENTE	= 0,
		FAMILIA_SERIE   = diserie,
		GLOSA           = 'DISPONIBILIDAD ',
		OPERACION 	= 'DISPONIBILIDAD ' + (CASE WHEN ditipoper = 'CI' THEN 'COMPRAS CON PACTO DE RETROVENTA ' ELSE ' ' END)
				  + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = a.codigo_carterasuper AND tbcateg = '1111'),
                orden            = (CASE WHEN ditipoper = 'CP' THEN 2 ELSE 4 END),
		tip		= a.codigo_carterasuper,  -- ditipcart   
		fecha_operacion = '',
		tipoper		= ditipoper,
		valor_venc	= 0.0,---convert(float,0),
		fecha_pacto	= ''	,
		dias 		=0			,
		tipopero	=ditipoper ,
		valor_ini	= convert(numeric(19,4),0),
		OprRes       = (CASE WHEN ditipoper= 'CP' THEN 'DISPOCP' ELSE 'DISPOCI' END),
		ModInv		= CASE WHEN ditipoper= 'CP' THEN (CASE WHEN ditipcart = 1 THEN 'T' 
									WHEN ditipcart = 2 THEN 'A'
									WHEN ditipcart = 4 THEN 'H'
  				        				ELSE 'P'
				  				  END)
				  ELSE 'P' END,
		ValorCont	= a.Valor_Contable,
		RutEmi		= 0,
		VerVp		= (CASE WHEN (EXISTS(Select * from mdvi Where vinumdocu = dinumdocu and vicorrela = dicorrela) Or dinominal > 0) THEN ' ' ELSE 'X' END),
		monemi		= dimoneda,
		FecaPagoOrig    = a.Fecha_pagomañana,
		Tasapacto       = 0.0,
		VctoPacto	= difecsal,
		TirComp		= ditircomp,
		vPresen		= Convert(Float,0),
		InteresesPeso   = Convert(Float,0),
		Reajustes	= Convert(Float,0),
		Codigo		= 0,
		Base		= dibase,
		Valcomp		= 0.0,
		ValcompPeso	= 0.0,
		Mascara		= ''
	FROM MDDI a --,MDMO 
	WHERE Difecsal > @Fecproc and ditipoper = 'CP' AND (dinominal>0 or EXISTS(Select * from mdvi Where vinumdocu = dinumdocu and vicorrela = dicorrela))

	-- DISPONIBLE PROPIO
	UPDATE #PASO
	SET	FECHA_EMISION 	= CONVERT(CHAR(12), cpfecemi, 103),
		RUT_EMISOR      = (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara),0) 
				        ELSE ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela) ,0) END),
		NUM_CLI		= ISNULL((SELECT codigo_as400 FROM VIEW_CLIENTE WHERE clrut = cprutcli and clcodigo = cpcodcli ),0),
		COD_EMISOR 	= cpcodcli,
		CONTRATO	= Isnull(Numero_Contrato,0),
		COD_MONEDA	= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = cpmascara),0) 
					ELSE ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela) ,0) END),
		TASA_CON      	= isnull(tasa_contrato,0.0),
		FECHA_VENCI   	= cpfecven,--CONVERT(CHAR(12),cpfecven,103),
		fecha_operacion = CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN Fecha_pagomañana ELSE cpfeccomp END,
		valor_venc	= convert(float,0),
		fecha_pacto	= '',
		dias		= CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > Fecha_pagomañana And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE Fecha_pagomañana  END) ELSE Fecha_PagoMañana END) ,@dFecRep)
					ELSE
					    datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > cpfeccomp And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE cpfeccomp END) ELSE cpfeccomp END) ,@dFecRep)
					END,
		RutEmi		= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara),0) 
				        ELSE ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela) ,0) END),
	            SERIADO         = cpseriado,
		Codigo		= cpcodigo,
		Valcomp		= cpvalcomu,
		ValcompPeso	= cpvalcomp,
		Mascara		= cpmascara

	FROM MDCP,mdac
	WHERE cpnumdocu = numdocu AND cpcorrela = correla AND orden = 2


        delete #paso where VerVp = 'X' and Orden = 2
--        delete #paso where nominal <= 0 and Orden = 4

	-- Esto es momentaneo ya que no se especifico en ningun momento que el nuevo calculo se deberia aplicar a la cartera
	-- de operaciones posterior al dia de instalacion 15/01/2007
	UPDATE #PASO
	SET	interes	= a.valor_contable/ (Case When COD_MONEDA = 999 OR COD_MONEDA = 13 THEN 1 ELSE (Select vmvalor From View_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN a.Fecha_Pagomañana ELSE a.cpfeccomp END ) END)-- cpvalcomu --CBG 18/08/2004
	FROM MDCP a,mdac
	WHERE cpnumdocu = numdocu AND cpcorrela = correla AND orden = 2


	UPDATE #PASO SET PRECIO_OP_UM		= Round(isnull((precio_op  / (CASE WHEN COD_MONEDA = 999 OR COD_MONEDA = 13 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = fecha_operacion) END)),0), (CASE WHEN COD_MONEDA = 999
 Then 0 ELSE 4 END)), --CBG)  ,
			INTERES			= round(   interes * tasa_con / 36000 * (1+dias)  , (CASE WHEN COD_MONEDA = 999 then 0 ELSE 4 END) )
	WHERE (orden = 2  or orden = 1)


	UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),clnombre) FROM VIEW_CLIENTE  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = clrut and clcodigo = cod_emisor and orden in(3,4,5,6)
	UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),emnombre) FROM VIEW_EMISOR  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = emrut and orden not in (3,4,5,6)
	UPDATE #PASO SET NOM_MONEDA = mnnemo FROM VIEW_MONEDA WHERE COD_MONEDA = mncodmon

/*   Valorizacvion a Fecha de Reporte */
--delete #PASO where numdocu <> 52349 Or correla <> 1

  SELECT @nCont = Max(Flag) From #Paso
  SELECT @n = Min(Flag) from #Paso

  WHILE @n <= @nCont
  Begin
   DECLARE @cIndPm CHAR(01)
   SELECT @cEstado = '*'
   SELECT @cIndPm = ''
   SELECT @cProg       = 'SP_' + Isnull((SELECT inprog From View_Instrumento Where inserie = FAMILIA_SERIE),'') ,
          @codigo      = Codigo,
	  @instser     = SERIE, 
	  @monemis     = monemi,
	  @xfecemi     = Convert(Datetime,FECHA_EMISION,103),
	  @Fecven      = FECHA_VENCI,
       	  @ntasemi     = 0.0, 
	  @nbase       = Base,
	  @ntasest     = 0.0,
	  @Nominal     = Nominal,
	  @xTir	       = Tircomp,
	  @Valcomp     = Valcomp,
          @nDias       = Datediff(DAY,FecaPagoOrig,@dFecRep),
	  @nFecPag     = FecaPagoOrig,
	  @NumDocu     = NUMDOCU,
	  @Correla     = CORRELA,
	  @nVpresen    = ValcompPeso,
	  @cSeriado    = SERIADO,
	  @cMascara    = MASCARA,
	  @cEstado = ' '
   FROM #PASO
   WHERE Flag = @n

   If @cEstado = ' ' Begin
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


	if SUBSTRING(@instser,len(@instser),1) = '*' BEGIN
--		SELECT @dFecCal = @dFecPrx
		SELECT @instser = SUBSTRING(@instser,1,len(@instser)-1)
		SELECT @cIndPm = 'S'

	END else BEGIN
		SELECT @dFecCal = @dFecRep
		SELECT @cIndPm = 'N'
	END

	If @Nominal > 0 Begin

   	   EXECUTE @nError = @cProg 2, @dFecCal, @codigo,@instser, @monemis, @xfecemi, @Fecven,
       		   @ntasemi, @nbase, @ntasest,@Nominal OUTPUT, @xTir OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
           	   @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
           	   @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
           	   @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

	     SELECT @nUf_Hoy =  vmvalor From view_Valor_moneda Where vmcodigo = @monemis and Vmfecha = @dFecCal
             SELECT @nUf_Pag =  vmvalor From view_Valor_moneda Where vmcodigo = @monemis and Vmfecha = @nFecPag

   IF  @monemis=13 Or @monemis=999
		BEGIN
		     SELECT @nUf_Hoy = 1
	             SELECT @nUf_Pag = 1
		END	
	
           SELECT @nReajuste = 0.0
	   SELECT @nInteres  = 0.0
           Select @nValCupon = 0.0

	   SELECT @nReajuste = CASE WHEN (@monemis <> 999 AND @monemis <> 13)  THEN ROUND(( @nUf_Hoy - @nUf_Pag ) * @Valcomp, 0) ELSE 0.0 END -- CBG 07/02/2005
	   SELECT @nInteres = (@fMt - @nVpresen - @nReajuste + @nValCupon)

	   IF @cIndPm = 'S' BEGIN
		SELECT @nReajuste = 0
		SELECT @nInteres = 0
	   END

	   UPDATE #PASO
	   SET vPresen = @fMt,
	      Reajustes	  = @nReajuste,
	      InteresesPeso = @nInteres,
	      INTERES = (CASE WHEN @nUf_Pag > 0 THEN ROUND(@nInteres/@nUf_Pag,4) ELSE 0.0 END)
	   WHERE Flag = @n

	End
   End
   SELECT @n = @n + 1
  END
  
  -- VMGS Se debe eliminar de este reporte las letras de credito hiopotecarias propia emision debido a la nueva normativa
  -- contable (Octubre del 2002)

  -- *******************************************************************************************
  DELETE #PASO WHERE SUBSTRING (SERIE,1,3) = 'ITA' AND FAMILIA_SERIE = 'LCHR'
  -- *******************************************************************************************

	SELECT  numdocu, 
		FECHA_EMISION = CASE WHEN Seriado = 'N' THEN '  /  /    ' ELSE FECHA_EMISION END,
		SERIE,
		SERIADO,
		CODIGO_BOLSA,
		NUM_CLI ,
		RUT_EMISOR,
		NOM_EMISOR,
		CONTRATO,
		NOM_MONEDA,
		COD_MONEDA,
		NOMINAL,
		PRECIO_OP_UM ,
		PRECIO_OP ,
		TASA_CON,
		FECHA_VENCI,
		INTERES,
		OP_PROVENIENTE,
		FAMILIA_SERIE = (CASE WHEN 'ITA' = (SELECT SUBSTRING (SERIE,1,3)) AND FAMILIA_SERIE = 'LCHR' THEN 'LCHR BOSTON' ELSE FAMILIA_SERIE END),
		GLOSA,
		OPERACION,
		'HORA'    = CONVERT(CHAR(8),getdate(),108),
                orden,
		CLAVE = (CASE WHEN 'ITA' = (SELECT SUBSTRING (SERIE,1,3)) AND FAMILIA_SERIE = 'LCHR' THEN 'LCHR BOSTON' ELSE FAMILIA_SERIE END) + ' '  +  convert(char(2),tip) + ' ' + convert(char(1),orden),
		fecha_operacion,
		tipoper,
		'acfecproc' = @dFecRep, --acfecproc,
		valor_venc,
		fecha_pacto,
		dias		,
		tipopero	,
		tip		,
		valor_ini	,
		Tasapacto	,
		ModInv		,
        'NomProp' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales),   --acnomprop,
        'RutProp' = Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,
		VctoPacto,
		OprRes,
		TirComp		,
		vPresen		,
		InteresesPeso   ,
		Reajustes	,
		Codigo
	into #paso1	
	FROM #PASO a,mdac
  	WHERE CHARINDEX(OprRes,'VENTACP -VENTACI') = 0
	ORDER BY  orden,operacion,FAMILIA_SERIE,OprRes,Modinv,FECHA_VENCI--TCORRELA

  
  DECLARE @COUNT INT
  SET @COUNT = (SELECT COUNT(*) FROM #paso1)


  IF @COUNT <> 0
  BEGIN


  SELECT * from #paso1 ORDER BY CLAVE,OprRes,ModInv,VctoPacto,fecha_operacion

  END

  ELSE

  BEGIN

	SELECT  numdocu = '', 
		    FECHA_EMISION = '',
		    SERIE  = '',
		    SERIADO = '',
		    CODIGO_BOLSA = '',
		    NUM_CLI = '' ,
		    RUT_EMISOR = '',
		    NOM_EMISOR = '',
		    CONTRATO = '',
		    NOM_MONEDA = '',
		    COD_MONEDA = '',
		    NOMINAL = '',
		    PRECIO_OP_UM  = '',
		    PRECIO_OP  = '',
		    TASA_CON = '',
		    FECHA_VENCI = '',
		    INTERES = '',
		    OP_PROVENIENTE = '',
		    FAMILIA_SERIE = '',
		    GLOSA = '',
		    OPERACION = '',
		    'HORA'     = '',
			orden  = '',
		    CLAVE = '',
		    fecha_operacion = '',
		    tipoper = '',
		    'acfecproc' = '',
		    valor_venc = '',
		    fecha_pacto = '',
		    dias = '',
		    tipopero = '',
		    tip	 = '',
		    valor_ini = '',
		    Tasapacto = '',
		    ModInv	 = '',
            'NomProp' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales),   --acnomprop,
            'RutProp' = '',
		    VctoPacto = '',
		    OprRes = '',
		    TirComp	 = '',
		    vPresen	 = '',
		    InteresesPeso = ''  ,
		    Reajustes = '',
		    Codigo = ''


  END
  --DROP TABLE PASO1
END
-- Base de Datos --

GO
