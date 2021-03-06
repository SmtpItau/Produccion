USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_STOCK_CART_Tirc_Pact_Ci]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_STOCK_CART_Tirc_Pact_Ci] (@cFecRep CHAR(08))
AS

BEGIN

SET NOCOUNT ON

DECLARE @FECPROC     CHAR(10),
	@dFecPrx     DATETIME,
	@nValCupon   FLOAT,
        @dFecSal     DATETIME,
        @fValmon_Cup FLOAT,
	@cMascara    CHAR(12),
	@nValIni     FLOAT,
	@nTasPact    FLOAT,
	@nBasPact    NUMERIC(04),
	@nMonPact    NUMERIC(03),
	@nDiasPac    NUMERIC(05),
	@nValHoy     FLOAT,
	@nUf_IniPac  FLOAT,
	@nValIni_UM  FLOAT		-- VGS (18/08/2005)


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

	SELECT @dFecRep = CONVERT(Datetime,@cFecRep)
        SELECT @FECPROC =convert(char(10),acfecproc,112),
	       @dFecPrx = acfecprox
	FROM MDAC


	-- STOCK CON COMPRA CON PACTO
	SELECT	NUMDOCU 	= cinumdocu,
		CORRELA		= cicorrela,
		FECHA_EMISION 	= CONVERT(CHAR(12), cifecemi, 103),
		SERIE		= ciinstser,
		TCORRELA	= 1,
		SERIADO         = ciseriado,
		CODIGO_BOLSA  	= 0,
		NUM_CLI		= ISNULL((SELECT codigo_as400 FROM VIEW_CLIENTE WHERE clrut = cirutcli and clcodigo = cicodcli ),0), 
		RUT_EMISOR      = cirutcli,
		COD_EMISOR	= cicodcli,
		NOM_EMISOR	= SPACE(50),
		CONTRATO	= ISNULL(Numero_Contrato,0),
		NOM_MONEDA	= SPACE(10),
		COD_MONEDA	= cimonpact,

		NOMINAL		= cinominal, --  + isnull((select sum(vinominal) from mdvi where cinumdocu = vinumdocu and cicorrela = vicorrela),0),
		PRECIO_OP_UM	= civalinip, --  + isnull((select sum(vivalinip) from mdvi where cinumdocu = vinumdocu and cicorrela = vicorrela),0),
		PRECIO_OP	= isnull(civalinip,0), -- + isnull((select sum(vivalinip) from mdvi where cinumdocu = vinumdocu and cicorrela = vicorrela),0),  
-------------------------------------------------------------------------------------------------

		TASA_CON      	= ISNULL(citaspact,0.0),
		FECHA_VENCI   	= cifecven,
		INTERES		= civalinip,
		OP_PROVENIENTE	= ' ', 
		FAMILIA_SERIE   = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cicodigo),''),
		GLOSA           = 'STOCK COMPRAS CON PACTO',
		OPERACION       = 'STOCK TOTAL COMPRAS CON PACTO DE RETROVENTA ' + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = codigo_carterasuper AND tbcateg = '1111'),
                orden  		= 3 	,
		tip			= codigo_carterasuper, --citipcart             ,
		fecha_operacion = cifecinip 		,
		tipoper		= 'CI'			,
		valor_venc	= CONVERT(FLOAT,civalvenp)	,
		fecha_pacto	= cifecvenp,
		dias		= datediff(day,cifeccomp,@dFecRep),
		tipopero	= 'CI',
		valor_ini	= civalinip,
		OprRes          = 'STOCKCI',
		ModInv		= 'P',
		ValorCont	= Valor_Contable,
		RutEmi		= cirutemi,
		VerVp		= ' ',
		monemi		= cimonemi, --39
		FecaPagoOrig    = cifecinip,
		Tasapacto       = citaspact,
		VctoPacto	= cifecvenp,
		TirComp		= citircomp,
		vPresen		= Convert(Float,0),
		InteresesPeso   = Convert(Float,0),
		Reajustes	= Convert(Float,0),
		Codigo		= cicodigo,
		Base		= (Select inbasemi FROM VIEW_INSTRUMENTO WHERE incodigo = cicodigo),
		Valcomp		= civalcomu,
                ValcompPeso	= civalcomp,
		Mascara		= cimascara,
		Flag		= IDENTITY(INT)
	INTO #PASO
	FROM MDCI,mdac
	WHERE (ciinstser <> 'ICOL' AND ciinstser <> 'ICAP' AND ciinstser <> 'IC' ) And cifecvenp > @Fecproc



-- DISPONIBILIDAD 
	INSERT #PASO
	SELECT	NUMDOCU 	= dinumdocu,
		CORRELA		= dicorrela,
		FECHA_EMISION 	= Convert(Char(12),''),
		SERIE		= diinstser,
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
		tip		= a.codigo_carterasuper,  --ditipcart             ,
		fecha_operacion = '',
		tipoper		= ditipoper,
		valor_venc	= 0.0,---convert(float,0),
		fecha_pacto	= ''	,
		dias =0			,
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
		monemi		= Isnull(dimoneda,0),
		FecaPagoOrig    = '',
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
	WHERE Fecha_pagomañana <= @Fecproc and Difecsal > @Fecproc and ditipoper = 'CI'
	AND dinominal>0

--- Disponibilidades Pacto
	UPDATE #PASO
	SET	FECHA_EMISION 	= CONVERT(CHAR(12), cifecemi, 103),
		RUT_EMISOR      = cirutcli,
		COD_EMISOR	= cicodcli,
		NUM_CLI		= ISNULL((SELECT codigo_as400 FROM VIEW_CLIENTE WHERE clrut = cirutcli and clcodigo = cicodcli ),0),
		CONTRATO	= Isnull(Numero_Contrato,0),
		COD_MONEDA	= cimonpact,
		TASA_CON      	= isnull(citaspact,0.0),
		FECHA_VENCI   	= cifecven,--CONVERT(CHAR(12),cifecven,103),
		FECHA_OPERACION = cifecinip,
		valor_venc	= CASE WHEN nominal = 0 Then 0 ELSE ((nominal * civalvenp) /cinominal)	END,
		valor_ini       = civalinip,
		fecha_pacto	= cifecvenp,--convert(char(10),cifecvenp,112),
		dias		= datediff(day,cifeccomp,@dFecRep), --acfecproc),
		interes		= CASE WHEN nominal = 0 Then 0 ELSE (nominal*civalinip)/(Isnull((Select sum(vinominal) From Mdvi Where vinumdocu = cinumdocu and vicorrela = cicorrela) ,cinominal)) END,
		Tasapacto       = citaspact,
		VctoPacto	= cifecvenp,
                SERIADO         = ciseriado,
		Valcomp		= civalcomu,
		ValcompPeso	= civalcomp,
		Base		= (Select inbasemi FROM VIEW_INSTRUMENTO WHERE incodigo = cicodigo),
		monemi		= cimonemi,
		Mascara		= cimascara,
                FecaPagoOrig    = cifecinip,
		PRECIO_OP_UM	= civalinip, --  + isnull((select sum(vivalinip) from mdvi where cinumdocu = vinumdocu and cicorrela = vicorrela),0),
		PRECIO_OP	= isnull(civalinip,0) -- + isnull((select sum(vivalinip) from mdvi where cinumdocu = vinumdocu and cicorrela = vicorrela),0),  
	FROM MDCI,mdac
	WHERE cinumdocu = numdocu AND cicorrela = correla --AND orden = 4 

	--6336081
	UPDATE #PASO SET --INTERES		= Round( interes * tasa_con / CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END * (1+dias) , CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END ), -- Round((interes * ((tasa_con * (1+dias)) / (CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END) )),CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END),
 			 PRECIO_OP_UM		= isnull((interes  / (CASE WHEN cod_moneda = 999 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = @fecproc) END)),0)
	WHERE orden = 3 Or Orden = 4


	UPDATE #PASO SET INTERES		= Round( PRECIO_OP_UM * tasa_con / CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END * (1+dias) , CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END )
-- 			 PRECIO_OP_UM		= isnull((precio_op  / (CASE WHEN cod_moneda = 999 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = @fecproc) END)),0)
	WHERE orden = 3 Or Orden = 4


	UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),clnombre) FROM VIEW_CLIENTE  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = clrut and clcodigo = cod_emisor ---and orden in(3,4,5,6)
	UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),emnombre) FROM VIEW_EMISOR  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = emrut --and orden not in (3,4,5,6)
	UPDATE #PASO SET NOM_MONEDA = mnnemo FROM VIEW_MONEDA WHERE COD_MONEDA = mncodmon

/*   Valorizacvion a Fecha de Reporte */
--> DELETE #PASO WHERE numdocu <> 52208 OR correla <> 2
--> 

  SELECT @nCont = Max(Flag) From #Paso
  SELECT @n = Min(Flag) from #Paso

  WHILE @n <= @nCont
  Begin

   SELECT @cEstado = '*'

   SELECT @cProg       = 'SP_' + Isnull((SELECT inprog From View_Instrumento Where inserie = FAMILIA_SERIE),'') ,
          @codigo      = Codigo,
	  @instser     = SERIE, 
	  @monemis     = monemi,
	  @xfecemi     = CONVERT(Datetime,FECHA_EMISION,103),
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
	  @nValIni     = valor_ini,
	  @nTasPact    = Tasapacto,
	  @nBasPact    = CASE WHEN COD_MONEDA = 13 THEN 360 ELSE (SELECT mnbase From view_Moneda Where isnull(mnmx,'')<> 'C' and mncodmon = COD_MONEDA) END,
	  @nMonPact    = COD_MONEDA,
	  @nDiasPac    = dias+1,
	  @cEstado = ' '
   FROM #PASO
   WHERE Flag = @n

	If @cEstado = ' ' 
	Begin
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

	If @Nominal > 0 Begin

   	   EXECUTE @nError = @cProg 2, @dFecRep, @codigo,@instser, @monemis, @xfecemi, @Fecven,
       		   @ntasemi, @nbase, @ntasest,@Nominal OUTPUT, @xTir OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
           	   @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
           	   @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
           	   @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

           SELECT @nUf_Hoy = vmvalor From view_Valor_moneda Where vmcodigo = @nMonPact and Vmfecha = @cFecRep
           SELECT @nUf_Pag = vmvalor From view_Valor_moneda Where vmcodigo = @nMonPact and Vmfecha = @nFecPag
           SELECT @nUf_IniPac = CASE WHEN @nUf_Pag > 0 THEN @nUf_Pag ELSE 1 END

           SELECT @nReajuste = 0.0
	   SELECT @nInteres  = 0.0
           Select @nValCupon = 0.0


	   IF @nMonPact = 999 Or @nMonPact = 13 BEGIN    -- VGS (18/08/2005) VGS (03/03/2008) Agregar pactos en USD
	   	SELECT @nUf_Pag = 1     -- VGS (18/08/2005)
		SELECT @nUf_Hoy = 1     -- VGS (18/08/2005)
		SELECT @nUf_IniPac = 1  -- VGS (03/03/2008)
	   END                          -- VGS (18/08/2005)

	   SELECT @nValIni_UM = ROUND(@nValIni/@nUf_Pag,(CASE @nMonPact	WHEN 998 THEN 4   -- VGS (18/08/2005)
							   		WHEN 999 THEN 0   -- VGS (18/08/2005)
						      	 ELSE 2 END))                     -- VGS (18/08/2005)

	   SELECT @nReajuste = CASE WHEN @nMonPact <> 999 THEN ROUND(( @nUf_Hoy - @nUf_Pag ) * @nValIni_UM, 0) ELSE 0.0 END  -- VGS (18/08/2005)

	   If @dFecpcup <= @cFecRep Begin
              If @cSeriado = 'S' BEGIN

--		EXECUTE @nValCupon = Sp_SumaCupones @cMascara,@nFecPag,@cFecRep
                EXECUTE Sp_Nexthabil @dFecpcup,6,@dFecSal OUTPUT
                SELECT @fValmon_Cup = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=(CASE WHEN @monemis = 13 THEN 994 ELSE @monemis END) AND vmfecha=@dFecSal  -- VGS (18/08/2005)
	        Select @nValCupon = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Cup, 0)
	      End Else Select @nValCupon = 0  -- ?????????????????????? VMGS
            
	   End

           SELECT @nValHoy = Round((@nValIni_UM * (((@nTasPact / (@nBasPact * 100)) * @nDiasPac) + 1))*@nUf_Hoy, (CASE WHEN @nBasPact = 30 THEN 0 ELSE 4 END))  -- VGS (18/08/2005)
	   SELECT @nInteres = (@nValHoy - @nValIni - @nReajuste)

	   UPDATE #PASO
	   SET vPresen = @fMt,
	      Reajustes	  = @nReajuste,
	      InteresesPeso = @nInteres,
	      INTERES  = isnull(ROUND(@nInteres/@nUf_IniPac,4),0)
	   WHERE Flag = @n
	   --select @nValIni_UM,@nTasPact,@nBasPact,@nDiasPac,@nUf_Hoy,@nBasPact
	End
   End
   SELECT @n = @n + 1
  End

--Select * from #PASO WHERE CHARINDEX(OprRes,'VENTACP -VENTACI') = 0 --and InteresesPeso < 0
--End



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
                'NomProp' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --acnomprop,
                'RutProp' = Replace(substring(CONVERT(CHAR(13),CONVERT(MONEY,acrutprop),1),1,10),',','.')+ '-'+acdigprop,
		VctoPacto,
		OprRes,
		TotMonNomi_CLP	= CONVERT(Float,0),
		TotMonValIni_Um_CLP = CONVERT(Float,0),
		TotMonValIni_Pe_CLP = CONVERT(Float,0),
		TotMonVinicial_CLP  = CONVERT(Float,0),
		TotMonValVcto_CLP   = CONVERT(Float,0),
		TotMonInteres_CLP   = CONVERT(Float,0),

		TotMonNomi_UF	= CONVERT(Float,0),
		TotMonValIni_Um_UF = CONVERT(Float,0),
		TotMonValIni_Pe_UF = CONVERT(Float,0),
		TotMonVinicial_UF  = CONVERT(Float,0),
		TotMonValVcto_UF   = CONVERT(Float,0),
		TotMonInteres_UF   = CONVERT(Float,0),

		TotMonNomi_DO	= CONVERT(Float,0),
		TotMonValIni_Um_DO = CONVERT(Float,0),
		TotMonValIni_Pe_DO = CONVERT(Float,0),
		TotMonVinicial_DO  = CONVERT(Float,0),
		TotMonValVcto_DO   = CONVERT(Float,0),
		TotMonInteres_DO   = CONVERT(Float,0),

		TotMonNomi_USD	= CONVERT(Float,0),
		TotMonValIni_Um_USD = CONVERT(Float,0),
		TotMonValIni_Pe_USD = CONVERT(Float,0),
		TotMonVinicial_USD  = CONVERT(Float,0),
		TotMonValVcto_USD   = CONVERT(Float,0),
		TotMonInteres_USD   = CONVERT(Float,0),

		TotMonNomi_BCCH	= CONVERT(Float,0),
		TotMonValIni_Um_BCCH = CONVERT(Float,0),
		TotMonValIni_Pe_BCCH = CONVERT(Float,0),
		TotMonVinicial_BCCH  = CONVERT(Float,0),
		TotMonValVcto_BCCH   = CONVERT(Float,0),
		TotMonInteres_BCCH   = CONVERT(Float,0),
		TirComp		,
		vPresen		,
		InteresesPeso   ,
		Reajustes	,
		Codigo		,
		TotVpresen_CLP	= CONVERT(Float,0),
		TotInteresesPeso_CLP = CONVERT(Float,0),
		TotReajustes_CLP = CONVERT(Float,0),

		TotVpresen_UF	= CONVERT(Float,0),
		TotInteresesPeso_UF = CONVERT(Float,0),
		TotReajustes_UF = CONVERT(Float,0),

		TotVpresen_DO	= CONVERT(Float,0),
		TotInteresesPeso_DO = CONVERT(Float,0),
		TotReajustes_DO = CONVERT(Float,0),

		TotVpresen_USD	= CONVERT(Float,0),
		TotInteresesPeso_USD = CONVERT(Float,0),
		TotReajustes_USD = CONVERT(Float,0),

		TotVpresen_BCCH	= CONVERT(Float,0),
		TotInteresesPeso_BCCH = CONVERT(Float,0),
		TotReajustes_BCCH = CONVERT(Float,0)


	into #paso1	
	FROM #PASO a,mdac
  	WHERE CHARINDEX(OprRes,'VENTACP -VENTACI') = 0
	ORDER BY  orden,operacion,FAMILIA_SERIE,OprRes,Modinv,FECHA_VENCI--TCORRELA

	select  Clave1 = clave ,
		rut = 1 ,
		cod_moneda1 = 0,
		nominal1= sum(nominal),
		op_um1	= sum(precio_op_um)  , 
		op1	= sum(precio_op)     ,
		valor_ini1 = sum (valor_ini)    ,
		valor_venc1 = sum(valor_venc)  ,
		interes1    = sum(interes)     ,
		vPresen1    = sum(vPresen),
		IntPeso1    = sum(InteresesPeso),
		ReaPeso1    = sum(Reajustes)
	into #totales
	from #paso1
	where rut_emisor =97029000 and orden in(5,6)
	group by clave
	Order by clave

	insert into #totales
	select  clave ,
		rut = 0 ,
		cod_moneda ,
			  nominal		= ISNULL(sum(nominal)   , 0)
			, op_um		= ISNULL(sum(precio_op_um)   ,0)
			, op			= ISNULL(sum(precio_op)      ,0) 	
			, valor_ini	= ISNULL(sum (valor_ini)     ,0)
			, valor_venc  = ISNULL(sum(valor_venc)	, 0)
			, interes     = ISNULL(sum(interes)	,	  0)
			, vPresen     = ISNULL(sum(vPresen),		  0)
			, IntPeso     = ISNULL(sum(InteresesPeso),  0)
			, ReaPeso     = ISNULL(sum(Reajustes),0)
	from #paso1
	where rut_emisor <> 97029000 and orden in(3,4,5,6)
	group by clave ,cod_moneda 
	Order by clave ,cod_moneda 

  UPDATE #Paso1
  SET 	TotMonNomi_CLP	= nominal1,
	TotMonValIni_Um_CLP = op_um1,
	TotMonValIni_Pe_CLP = op1,
	TotMonVinicial_CLP  = valor_ini1,
	TotMonValVcto_CLP   = valor_venc1,
	TotMonInteres_CLP   = interes1,
	TotVpresen_CLP	    = vPresen1 ,
	TotInteresesPeso_CLP = IntPeso1,
	TotReajustes_CLP = ReaPeso1
  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 999
  
  UPDATE #Paso1
  SET 	TotMonNomi_UF	= nominal1,
	TotMonValIni_Um_UF = op_um1,
	TotMonValIni_Pe_UF = op1,
	TotMonVinicial_UF  = valor_ini1,
	TotMonValVcto_UF   = valor_venc1,
	TotMonInteres_UF   = interes1,
	TotVpresen_UF	    = vPresen1 ,
	TotInteresesPeso_UF = IntPeso1,
	TotReajustes_UF = ReaPeso1

  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 998

  UPDATE #Paso1
  SET 	TotMonNomi_DO	    = ISNULL(nominal1   ,0) 
	, TotMonValIni_Um_DO    = ISNULL(op_um1		,0)
	, TotMonValIni_Pe_DO    = ISNULL(op1		,0)
	, TotMonVinicial_DO     = ISNULL(valor_ini1	,0)
	, TotMonValVcto_DO      = ISNULL(valor_venc1,0)
	, TotMonInteres_DO      = ISNULL(interes1	,0)
	, TotVpresen_DO	        = ISNULL(vPresen1 	,0)
	, TotInteresesPeso_DO   = ISNULL(IntPeso1	,0)
	, TotReajustes_DO	    = ISNULL(ReaPeso1 	,0)

  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 994

  UPDATE #Paso1
  SET 	  TotMonNomi_USD	   = ISNULL(nominal1,   0)
	    , TotMonValIni_Um_USD  = ISNULL(op_um1,	  0)
	    , TotMonValIni_Pe_USD  = ISNULL(op1,		  0)
	    , TotMonVinicial_USD   = ISNULL(valor_ini1, 0)
	    , TotMonValVcto_USD    = ISNULL(valor_venc1,0)
	    , TotMonInteres_USD    = ISNULL(interes1,	  0)
	    , TotVpresen_USD	   = ISNULL(vPresen1 ,  0)
	    , TotInteresesPeso_USD = ISNULL(IntPeso1,	  0)
		, TotReajustes_USD	   = ISNULL(ReaPeso1,	  0)

  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 13

  UPDATE #Paso1
  SET 	 TotMonNomi_BCCH		= ISNULL(nominal1,  0)
	    , TotMonValIni_Um_BCCH  = ISNULL(op_um1, 0)
	    , TotMonValIni_Pe_BCCH  = ISNULL(op1, 0)
	    , TotMonVinicial_BCCH   = ISNULL(valor_ini1, 0)
	    , TotMonValVcto_BCCH    = ISNULL(valor_venc1, 0)
	    , TotMonInteres_BCCH    = ISNULL(interes1, 0)
	    , TotVpresen_BCCH	    = ISNULL(vPresen1 ,0)
	    , TotInteresesPeso_BCCH = ISNULL(IntPeso1,0)
	    , TotReajustes_BCCH		= ISNULL(ReaPeso1, 0)

  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 0 and Rut = 1



  DECLARE @COUNT INT
  SET @COUNT = (SELECT COUNT(*) FROM #paso1)


  IF @COUNT <> 0
  BEGIN

	SELECT * from #paso1 where cod_moneda<>0 ORDER BY CLAVE,OprRes,ModInv,VctoPacto,fecha_operacion

  END

  ELSE

  BEGIN

	SELECT  numdocu                = '', 
		    FECHA_EMISION          = '',
		    SERIE                  = '',
			SERIADO                = '',
			CODIGO_BOLSA           = '',
			NUM_CLI                = '',
			RUT_EMISOR             = '',
			NOM_EMISOR             = '',
			CONTRATO               = '',
			NOM_MONEDA             = '',
			COD_MONEDA             = '',
			NOMINAL                = '',
			PRECIO_OP_UM           = '' ,
			PRECIO_OP              = '',
			TASA_CON               = '',
			FECHA_VENCI            = '',
			INTERES                = '',
			OP_PROVENIENTE         = '',
			FAMILIA_SERIE          =  '',
			GLOSA                  = '',
			OPERACION              = '',
			'HORA'                 = '',
			orden                  = '',
			CLAVE                  =  '',
			fecha_operacion        = '',
			tipoper                = '',
			'acfecproc'            =  '', --acfecproc,
			valor_venc             = '',
			fecha_pacto            = '',
			dias		           = '',
			tipopero	           = '',
			tip		               = '',
			valor_ini              = ''	,
			Tasapacto	           = '',
			ModInv		           = '',
            'NomProp'              = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales), --acnomprop,
            'RutProp'              = '',
			VctoPacto              = '',
			OprRes                 = 0,
			TotMonNomi_CLP	       = 0,
			TotMonValIni_Um_CLP    = 0,
			TotMonValIni_Pe_CLP    = 0,
			TotMonVinicial_CLP     = 0,
			TotMonValVcto_CLP      = 0,
			TotMonInteres_CLP      = 0,
			TotMonNomi_UF	       = 0,
			TotMonValIni_Um_UF     = 0,
			TotMonValIni_Pe_UF     = 0,
			TotMonVinicial_UF      = 0,
			TotMonValVcto_UF       = 0,
			TotMonInteres_UF       = 0,
			TotMonNomi_DO	       = 0,
			TotMonValIni_Um_DO     = 0,
			TotMonValIni_Pe_DO     = 0,
			TotMonVinicial_DO      = 0,
			TotMonValVcto_DO       = 0,
			TotMonInteres_DO       = 0,
			TotMonNomi_USD	       = 0,
			TotMonValIni_Um_USD    = 0,
			TotMonValIni_Pe_USD    = 0,
			TotMonVinicial_USD     = 0,
			TotMonValVcto_USD      = 0,
			TotMonInteres_USD      = 0,
			TotMonNomi_BCCH	       = 0,
			TotMonValIni_Um_BCCH   = 0,
			TotMonValIni_Pe_BCCH   = 0,
			TotMonVinicial_BCCH    = 0,
			TotMonValVcto_BCCH     = 0,
			TotMonInteres_BCCH     = 0,
			TirComp		           = 0,
			vPresen		           = 0,
			InteresesPeso          = 0,
			Reajustes	           = 0,
			Codigo		           = 0,
			TotVpresen_CLP	       = 0,
			TotInteresesPeso_CLP   = 0,
			TotReajustes_CLP       = 0,
			TotVpresen_UF	       = 0,
			TotInteresesPeso_UF    = 0,
			TotReajustes_UF        = 0,
			TotVpresen_DO	       = 0,
			TotInteresesPeso_DO    = 0,
			TotReajustes_DO        = 0,
			TotVpresen_USD	       = 0,
			TotInteresesPeso_USD   = 0,
			TotReajustes_USD       = 0,
			TotVpresen_BCCH	       = 0,
			TotInteresesPeso_BCCH  = 0,
			TotReajustes_BCCH      = 0

  END

END

-- Base de Datos --

GO
