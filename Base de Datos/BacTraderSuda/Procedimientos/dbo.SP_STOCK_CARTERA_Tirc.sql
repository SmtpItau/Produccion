USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_STOCK_CARTERA_Tirc]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_STOCK_CARTERA_Tirc] ( @cFecRep CHAR(08) )
AS
BEGIN

SET NOCOUNT ON

DECLARE @FECPROC      CHAR(10), 
	@dFecPrx      DATETIME,
	@nValCupon    FLOAT,
        @dFecSal      DATETIME,
        @fValmon_Cup  FLOAT,
	@cMascara     CHAR(12),
	@Folio_Perfil Numeric(05),
	@CodCamCond   Numeric(03),
	@cCtaSup      Char(10),
   	@codinst      CHAR(10),
   	@xMonedae     CHAR(04),
	@TipoCart     NUMERIC(05)


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
	@nFecPag datetime,
	@nRutCart NUMERIC(10)
	

	UPDATE saldos_cartera SET SALDO = 0 , CUENTASUP = ''

	SELECT @dFecRep = CONVERT(Datetime,@cFecRep)
        SELECT @FECPROC =convert(char(10),acfecproc,112),
	       @dFecPrx = acfecprox,
	       @nRutCart = acrutprop
	FROM MDAC


	-- VI PROVENIENTES DE CP
	SELECT	NUMDOCU 	= vinumdocu,
		CORRELA		= Vicorrela,
		FECHA_EMISION 	= CONVERT(CHAR(12), vifecemi, 103),
		SERIE		= viinstser,
		TCORRELA	= 3,
		SERIADO         = viseriado,
		CODIGO_BOLSA  	= 0,
		NUM_CLI		= ISNULL((SELECT codigo_as400 FROM VIEW_CLIENTE WHERE clrut = virutcli and clcodigo = vicodcli ),0),
		RUT_EMISOR      = virutcli,
		COD_EMISOR	= vicodcli,
		NOM_EMISOR	= SPACE(50),
		CONTRATO	= Mdcp.Numero_Contrato, 
		NOM_MONEDA	= SPACE(10),
		COD_MONEDA	= vimonpact,
		NOMINAL		= vinominal,
		PRECIO_OP_UM	= Convert(Float,mdvi.valor_contable), --/(CASE WHEN vimonemi = 999 THEN 1 ELSE (Select vmcodigo From view_valor_moneda Where vmcodigo = vimonemi and vmfecha = (Select Fecha_Pagomañana From Mdcp where cpnumdocu = vinumdocu and cpcorrela = vicorrela)) END),--vivalcomu,--
		PRECIO_OP	= mdvi.valor_contable, 
		TASA_CON      	= isnull(Mdcp.tasa_contrato,0),
		FECHA_VENCI   	= vifecven, --CONVERT(CHAR(12),vifecven,103),  -- cpfeccomp
		INTERES		= Round(mdvi.valor_contable / (CAse when vimonemi = 999 OR vimonemi = 13 Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = mdcp.Fecha_Pagomañana) End),4),--vivalcomu, -CBG 18/08/2004
		OP_PROVENIENTE	= vitipoper,
		FAMILIA_SERIE   = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),''),
		GLOSA           = 'VENTA CON PACTO ' + 'PROVENIENTES DE ' + vitipoper ,
		OPERACION 	= 'VENTA CON PACTO ' + 'PROVENIENTES DE ' + (CASE WHEN vitipoper= 'CP' THEN 'COMPRAS DEFINITIVAS' ELSE 'COMPRAS CON PACTO DE RETROVENTA' END)
				 + convert(char(60),''),
                orden           = (CASE WHEN vitipoper = 'CP' then 5 else 6 END) ,
		tip		= 5              				 ,
		fecha_operacion = vifecinip,
		tipoper		= 'VI',
		valor_venc	= vivalvenp,
		fecha_pacto	= vifecvenp,--convert(char(10),vifecvenp,112) ,
		dias		= datediff(day,(CASE WHEN viseriado = 'S' THEN (CASE WHEN vifecucup > Mdcp.Fecha_Pagomañana THEN vifecucup ELSE Mdcp.Fecha_Pagomañana END)ELSE Mdcp.Fecha_Pagomañana END) ,@dFecRep),   --acfecproc), 

		tipopero	= vitipoper, 
		valor_ini	= vivalinip,

		OprRes          = 'INTERCP',
		ModInv		= CASE WHEN cptipcart = 1 THEN 'T'
   				       WHEN cptipcart = 2 THEN 'A' 
				       WHEN cptipcart = 4 THEN 'H'
			               ELSE 'P'
     				  END,
		ValorCont	= vivalinip,
		RutEmi		= virutemi,
		VerVp		= ' ',
		monemi		= vimonemi,
		FecaPagoOrig    = Mdcp.Fecha_Pagomañana,
		Tasapacto       = vitaspact,
		VctoPacto	= vifecvenp,
		TirComp		= vitircomp,
		vPresen		= Convert(Float,0),
		InteresesPeso   = Convert(Float,0),
		Reajustes	= Convert(Float,0),
		Codigo		= vicodigo,
		Base		= (Select inbasemi FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),
		Valcomp		= vivalcomu,
                ValcompPeso	= vivalcomp,
		Mascara		= vimascara,
		Flag		= IDENTITY(INT)
	INTO #PASO 
	FROM MDVI,mdac,mdcp
	WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser


	-- VI PROVENIENTES DE CI
        INSERT INTO #PASO
	SELECT	NUMDOCU 	= vinumdocu,
		CORRELA		= Vicorrela,
		FECHA_EMISION 	= CONVERT(CHAR(12), vifecemi, 103),
		SERIE		= viinstser,
		TCORRELA	= 3,
		SERIADO         = viseriado,
		CODIGO_BOLSA  	= 0,
		NUM_CLI		= ISNULL((SELECT codigo_as400 FROM VIEW_CLIENTE WHERE clrut = virutcli and clcodigo = vicodcli ),0),
		RUT_EMISOR      = virutcli,
		COD_EMISOR	= vicodcli,
		NOM_EMISOR	= SPACE(50),
		CONTRATO	= Mdci.Numero_Contrato, 
		NOM_MONEDA	= SPACE(10),
		COD_MONEDA	= vimonpact,
		NOMINAL		= vinominal,
		PRECIO_OP_UM	= Convert(Float,mdvi.valor_contable), 
		PRECIO_OP	= mdvi.valor_contable, 
		TASA_CON      	= isnull(Mdci.citaspact,0),
		FECHA_VENCI   	= vifecven, --CONVERT(CHAR(12),vifecven,103),  -- cpfeccomp
		INTERES		= Round(mdvi.valor_contable / (CAse when vimonemi = 999 OR vimonemi = 13 Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = mdci.Fecha_Pagomañana) End),4),--vivalcomu, --CBG 18/08/2004
		OP_PROVENIENTE	= vitipoper,
		FAMILIA_SERIE   = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),''),
		GLOSA           = 'VENTA CON PACTO ' + 'PROVENIENTES DE ' + vitipoper ,
		OPERACION 	= 'VENTA CON PACTO ' + 'PROVENIENTES DE ' + (CASE WHEN vitipoper= 'CP' THEN 'COMPRAS DEFINITIVAS' ELSE 'COMPRAS CON PACTO DE RETROVENTA' END)
				 + convert(char(60),''),
                orden           = (CASE WHEN vitipoper = 'CP' then 5 else 6 END) ,
		tip		= 5              				 ,
		fecha_operacion = vifecinip,
		tipoper		= 'VI',
		valor_venc	= vivalvenp,
		fecha_pacto	= vifecvenp,--convert(char(10),vifecvenp,112) ,
		dias		= datediff(day,(CASE WHEN viseriado = 'S' THEN (CASE WHEN vifecucup > Mdci.cifecinip THEN vifecucup ELSE Mdci.cifecinip END)
				        ELSE Mdci.cifecinip END) ,@dFecRep),   --acfecproc), 
		tipopero	= vitipoper, 
		valor_ini	= vivalinip,
-- OJOOJOJOJOJOJOJOJOJOJOJOJOJOJOJOJOJOJOJO
		OprRes          = 'INTERCI',
		ModInv		= 'P',
		ValorCont	= vivalinip,
		RutEmi		= virutemi,
		VerVp		= ' ',
		monemi		= vimonemi,
		FecaPagoOrig    = Mdci.Fecha_Pagomañana,
		Tasapacto       = vitaspact,
		VctoPacto	= vifecvenp,
		TirComp		= vitircomp,
		vPresen		= Convert(Float,0),
		InteresesPeso   = Convert(Float,0),
		Reajustes	= Convert(Float,0),
		Codigo		= vicodigo,
		Base		= (Select inbasemi FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),
		Valcomp		= vivalcomu,
               ValcompPeso	= vivalcomp,
		Mascara		= vimascara

	FROM MDVI,mdac,mdci
	WHERE  vitipoper  = 'CI' and vinumdocu = cinumdocu and vicorrela = cicorrela and viinstser = ciinstser

	-- VI PROVENIENTES DE CP
	INSERT #PASO
	SELECT	NUMDOCU 	= vinumdocu,
		CORRELA		= Vicorrela,
		FECHA_EMISION 	= CONVERT(CHAR(12), vifecemi, 103),
		SERIE		= viinstser,
		TCORRELA	= 3,

		SERIADO         = viseriado,
		CODIGO_BOLSA  	= 0,
		NUM_CLI		= ISNULL((SELECT codigo_as400 FROM VIEW_CLIENTE WHERE clrut = virutcli and clcodigo = vicodcli ),0),
		RUT_EMISOR      = virutcli,
		COD_EMISOR	= vicodcli,
		NOM_EMISOR	= SPACE(50),
		CONTRATO	= mdcp.Numero_Contrato,
		NOM_MONEDA	= SPACE(10),
		COD_MONEDA	= vimonpact,-- (CASE WHEN UPPER(viseriado) = 'S' THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = vimascara),0) WHEN UPPER(viseriado) = 'N' THEN	ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE vinumdocu = nsnumdocu AND vicorrela = nscorrela),0) END),
		NOMINAL		= vinominal,
		PRECIO_OP_UM	= convert(Float,mdvi.valor_contable),
		PRECIO_OP	= mdvi.valor_contable, 
		TASA_CON      	= isnull(Mdcp.tasa_contrato,0),
		FECHA_VENCI   	= vifecven, --CONVERT(CHAR(12),vifecven,103),  -- cpfeccomp
		INTERES		= mdvi.valor_contable / (CAse when vimonemi = 999 OR vimonemi = 13  Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = Mdcp.Fecha_Pagomañana) End),--vivalcomu, --CBG 18/08/2004
		OP_PROVENIENTE	= vitipoper,
		FAMILIA_SERIE   = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),''),
		GLOSA           = 'VENTA CON PACTO ',
		OPERACION 	= 'VENTA CON PACTO ',
                orden           = (CASE WHEN vitipoper = 'CP' then 5 else 6 END) ,
		tip		= 5              				 ,
		fecha_operacion = vifecinip,
		tipoper		= 'VI',
		valor_venc	= vivalvenp,
		fecha_pacto	= vifecvenp,--convert(char(10),vifecvenp,112) ,
		dias		= datediff(day,(CASE WHEN viseriado = 'S' THEN (CASE WHEN vifecucup > Mdcp.Fecha_Pagomañana THEN vifecucup ELSE mdcp.Fecha_Pagomañana END)
				        ELSE Mdcp.Fecha_Pagomañana END) ,@dFecRep), -- acfecproc),
		tipopero	= vitipoper, 
		valor_ini	= vivalinip,
		OprRes          = 'VENTACP',
		ModInv		= CASE WHEN Mdcp.cptipcart = 1 THEN 'T' 
                                       WHEN mdcp.cptipcart = 2 THEN 'A' 
				       WHEN mdcp.cptipcart = 4 THEN 'H' 
                                       ELSE 'P' 
				  END,

		ValorCont	= vivalinip,
		RutEmi		= virutemi,
		VerVp		= ' ',
		monemi		= vimonemi,
		FecaPagoOrig    = Mdcp.Fecha_Pagomañana,
		Tasapacto       = vitaspact,
		VctoPacto	= vifecvenp,
		TirComp		= vitircomp,
		vPresen		= Convert(Float,0),
		InteresesPeso   = Convert(Float,0),
		Reajustes	= Convert(Float,0),
		Codigo		= vicodigo,
		Base		= (Select inbasemi FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),
		Valcomp		= vivalcomu,
                ValcompPeso	= vivalcomp,
		Mascara		= vimascara
	FROM MDVI,mdac,Mdcp
	WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser


	-- VI PROVENIENTES DE CI
	INSERT #PASO
	SELECT	NUMDOCU 	= vinumdocu,
		CORRELA		= Vicorrela,
		FECHA_EMISION 	= CONVERT(CHAR(12), vifecemi, 103),
		SERIE		= viinstser,
		TCORRELA	= 3,

		SERIADO         = viseriado,
		CODIGO_BOLSA  	= 0,
		NUM_CLI		= ISNULL((SELECT codigo_as400 FROM VIEW_CLIENTE WHERE clrut = virutcli and clcodigo = vicodcli ),0),
		RUT_EMISOR      = virutcli,
		COD_EMISOR	= vicodcli,
		NOM_EMISOR	= SPACE(50),
		CONTRATO	= mdci.Numero_Contrato,
		NOM_MONEDA	= SPACE(10),
		COD_MONEDA	= vimonpact,-- (CASE WHEN UPPER(viseriado) = 'S' THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = vimascara),0) WHEN UPPER(viseriado) = 'N' THEN	ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE vinumdocu = nsnumdocu AND vicorrela = nscorrela),0) END),
		NOMINAL		= vinominal,
		PRECIO_OP_UM	= convert(Float,mdvi.valor_contable),
		PRECIO_OP	= mdvi.valor_contable, 
		TASA_CON      	= isnull(Mdci.citaspact,0),
		FECHA_VENCI   	= vifecven, --CONVERT(CHAR(12),vifecven,103),  -- cpfeccomp
		INTERES		= mdvi.valor_contable / (CAse when vimonemi = 999 OR vimonemi = 13 Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = Mdci.Fecha_Pagomañana) End),--vivalcomu, --CBG 18/08/2004
		OP_PROVENIENTE	= vitipoper,
		FAMILIA_SERIE   = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),''),
		GLOSA           = 'VENTA CON PACTO ',
		OPERACION 	= 'VENTA CON PACTO ',
                orden           = (CASE WHEN vitipoper = 'CP' then 5 else 6 END) ,
		tip		= 5              				 ,
		fecha_operacion = vifecinip,
		tipoper		= 'VI',
		valor_venc	= vivalvenp,
		fecha_pacto	= vifecvenp,--convert(char(10),vifecvenp,112) ,
		dias		= datediff(day,(CASE WHEN viseriado = 'S' THEN (CASE WHEN vifecucup > Mdci.Fecha_Pagomañana THEN vifecucup ELSE mdci.Fecha_Pagomañana END)
				        ELSE Mdci.Fecha_Pagomañana END) ,@dFecRep), -- acfecproc),
		tipopero	= vitipoper, 
		valor_ini	= vivalinip,
		OprRes          = 'VENTACI',
		ModInv		= 'P',
		ValorCont	= vivalinip,
		RutEmi		= virutemi,
		VerVp		= ' ',
		monemi		= vimonemi,
		FecaPagoOrig    = Mdci.Fecha_Pagomañana,
		Tasapacto       = vitaspact,
		VctoPacto	= vifecvenp,
		TirComp		= vitircomp,
		vPresen		= Convert(Float,0),
		InteresesPeso   = Convert(Float,0),
		Reajustes	= Convert(Float,0),
		Codigo		= cicodigo,
		Base		= (Select inbasemi FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),
		Valcomp		= vivalcomu,
                ValcompPeso	= vivalcomp,
		Mascara		= vimascara

	FROM MDVI,mdac,Mdci
	WHERE vitipoper  = 'CI' and vinumdocu = cinumdocu and vicorrela = cicorrela and viinstser = ciinstser

        UPDATE #PAso SET PRECIO_OP_UM = Round(PRECIO_OP_UM / (CASE WHEN monemi = 999  OR monemi = 13 THEN 1 ELSE (Select vmvalor From view_valor_moneda Where Vmcodigo = monemi and vmfecha = FecaPagoOrig )  END),4) --CBG 18/08/2004
	UPDATE #PASO SET INTERES  = round( interes * tasa_con / 36000 * (1+dias) ,(CASE WHEN monemi = 999 THEN 0 ELSE 4 END)) 

	-- STOCK CON COMPRA CON PACTO
	INSERT #PASO
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

/* El modelo original de las versiones Cliente Servidor no descuenta de la tabla MDCI los valores
  para cuando se vende con pacto un papel comprado con pacto, por lo tanto no debo sumarle los valores vendidos con pacto*/
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
		OPERACION       = 'STOCK TOTAL COMPRAS CON PACTO DE RETROVENTA ' + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = MDCI.codigo_carterasuper AND tbcateg = '1111'),
                orden  		= 3 	,
		tip		= citipcart, -- MDCI.codigo_carterasuper,  --citipcart             ,
		fecha_operacion = cifecinip 		,
		tipoper		= 'CI'			,
		valor_venc	= CONVERT(FLOAT,civalvenp)	,
		fecha_pacto	= cifecvenp,
		dias		= datediff(day,cifeccomp,@dFecRep),
		tipopero	= 'CI',
		valor_ini	= convert(numeric(19,4),0),
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
		Mascara		= cimascara
	FROM MDCI,mdac
	WHERE (ciinstser <> 'ICOL' AND ciinstser <> 'ICAP' AND ciinstser <> 'IC' ) 



	-- STOCK PROPIO
	INSERT #PASO
	SELECT 	NUMDOCU 	= cpnumdocu,
		CORRELA		= cpcorrela,
		FECHA_EMISION 	= CONVERT(CHAR(12), cpfecemi, 103),
		SERIE		= cpinstser,
		TCORRELA	= 1,
		SERIADO         = cpseriado,
		CODIGO_BOLSA  	= 0,
		NUM_CLI		= ISNULL((SELECT codigo_as400 FROM VIEW_CLIENTE WHERE clrut = cprutcli and clcodigo = cpcodcli ),0),
		RUT_EMISOR      = (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara ),0)WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela) ,0)  END),
		COD_EMISOR	= cpcodcli,
		NOM_EMISOR	= SPACE(50),
		CONTRATO	= ISNULL(a.Numero_Contrato,0),
		NOM_MONEDA	= SPACE(10),
		COD_MONEDA	= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = cpmascara),0) WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela),0) END),
		NOMINAL		= cpnominal + isnull((select sum(vinominal) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		PRECIO_OP_UM	= isnull(a.valor_contable,0) + isnull((select sum(valor_contable) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		PRECIO_OP	= isnull(a.valor_contable,0) + isnull((select sum(valor_contable) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		TASA_CON      	= ISNULL(a.tasa_contrato,0),
		FECHA_VENCI   	= cpfecven,--CONVERT(CHAR(12),cpfecven,103),
		INTERES		= (a.valor_contable + isnull((select sum(valor_contable) from mdvi where vinumdocu = cpnumdocu and vicorrela = cpcorrela),0)), 
		OP_PROVENIENTE  = ' ',
		FAMILIA_SERIE   = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo),''),
		GLOSA           = 'STOCK PROPIO',
		OPERACION 	= 'STOCK TOTAL ' + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = a.codigo_carterasuper AND tbcateg = '1111'),
                orden           = 1,
		tip		= cptipcart,  -- a.codigo_carterasuper, --cptipcart              ,
--		fecha_operacion = Fecha_pagomañana, --cpfeccomp		,
		fecha_operacion = cpfeccomp		,
		tipoper		= 'CP'			,
		valor_venc	= convert(float,0)	,
		fecha_pacto	= ''			,
--		dias		=  datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > Fecha_pagomañana And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE Fecha_pagomañana END)
--				        ELSE Fecha_PagoMañana END) ,@dFecRep), --acfecproc),
		dias		=  datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > cpfeccomp And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE cpfeccomp END)
				        ELSE cpfeccomp END) ,@dFecRep), --acfecproc),

		tipopero	= 'CP',
		valor_ini       = convert(numeric(19,4),0),
		OprRes       	= 'STOCKCP',
		ModInv		= CASE WHEN cptipcart = 1 THEN 'T' 
					WHEN cptipcart = 2 THEN 'A'
					WHEN cptipcart = 4 THEN 'H'
					ELSE 'P' END,
		ValorCont	= a.Valor_Contable + isnull((select sum(Valor_Contable) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		RutEmi		= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara ),0)
             				WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela),0)  END),
		VerVp		= (CASE WHEN (EXISTS(Select * from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) Or cpnominal > 0) THEN ' ' ELSE 'X' END),
		monemi		= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = cpmascara),0) WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela),0) END),
		FecaPagoOrig    = Fecha_pagomañana,
		Tasapacto       = 0.0,
		VctoPacto	= CPFECVEN,
		TirComp		= cptircomp,
		vPresen		= Convert(Float,0),
		InteresesPeso   = Convert(Float,0),
		Reajustes	= Convert(Float,0),
		Codigo		= cpcodigo,
		Base		= (Select inbasemi FROM VIEW_INSTRUMENTO WHERE incodigo = cpcodigo),
		Valcomp		= cpvalcomu + isnull((select sum(vivalcomu) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
                ValcompPeso	= cpvalcomp + isnull((select sum(vivalcomp) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		Mascara		= cpmascara
	FROM MDCP a,mdac 
	WHERE (cpnominal>0 or EXISTS(Select * from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela)) --CBG

	-- Se eliminan los instrumento que estan con nominal en 0 porque si no se encontro en la 
        -- tabla de ventas con pacto se asume que el papel esta vendido definitivo
        delete #paso where VerVp = 'X' and Orden = 1


        UPDATE #PASO
 	Set interes = interes/(CAse when COD_MONEDA = 999 OR COD_MONEDA =  13 Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = Fecha_Pagomañana) End) -- CBG 18/08/2004
        FROM Mdcp 
	WHERE numdocu = cpnumdocu and correla = cpcorrela and orden = 1

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
						 + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = a.codigo_carterasuper  AND tbcateg = '1111'),
                orden            = (CASE WHEN ditipoper = 'CP' THEN 2 ELSE 4 END),
		tip		=  ditipcart,  -- a.codigo_carterasuper , --ditipcart             ,
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
		monemi		= dimoneda,
		FecaPagoOrig    = Fecha_pagomañana,
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
	WHERE Difecsal > @Fecproc AND (dinominal>0 or EXISTS(Select * from mdvi Where vinumdocu = dinumdocu and vicorrela = dicorrela)) --CBG

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
--		FECHA_OPERACION = Fecha_Pagomañana,
		FECHA_OPERACION = cpfeccomp,
		valor_venc	= convert(float,0),
		fecha_pacto	= '',
--		dias		= datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > Fecha_pagomañana And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE Fecha_pagomañana END)
--				        ELSE Fecha_PagoMañana END) ,@dFecRep), --acfecproc),
		dias		= datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > cpfeccomp And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE cpfeccomp END)
				        ELSE cpfeccomp END) ,@dFecRep), --acfecproc),

--		interes		= Convert(float,0.0),-- cpvalcomu,
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


	UPDATE #PASO
	SET	interes	= a.valor_contable/ (Case When COD_MONEDA = 999 OR COD_MONEDA = 13 THEN 1 ELSE (Select vmvalor From View_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = a.Fecha_Pagomañana) END)-- cpvalcomu --CBG 18/08/2004
	FROM MDCP a,mdac
	WHERE cpnumdocu = numdocu AND cpcorrela = correla AND orden = 2


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
		fecha_pacto	= cifecvenp,--convert(char(10),cifecvenp,112),
		dias		= datediff(day,cifecinip,@dFecRep), --acfecproc),
		interes		= CASE WHEN nominal = 0 Then 0 ELSE (nominal*civalinip)/(Isnull((Select sum(vinominal) From Mdvi Where vinumdocu = cinumdocu and vicorrela = cicorrela) ,cinominal)) END,
		Tasapacto       = citaspact,
		VctoPacto	= cifecvenp,
                SERIADO         = ciseriado,
		Valcomp		= civalcomu,
		ValcompPeso	= civalcomp,
		Base		= (Select inbasemi FROM VIEW_INSTRUMENTO WHERE incodigo = cicodigo),
		monemi		= cimonemi,
		Mascara		= cimascara,
                FecaPagoOrig    = cifecinip
	FROM MDCI,mdac
	WHERE cinumdocu = numdocu AND cicorrela = correla AND orden = 4 

--calculo de interes disponibilidad propia

	UPDATE #PASO SET PRECIO_OP_UM		= Round(isnull((precio_op  / (CASE WHEN COD_MONEDA = 999 OR COD_MONEDA = 13 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = fecha_operacion) END)),0), (CASE WHEN COD_MONEDA = 999

 Then 0 ELSE 4 END))  , --CBG 18/08/2004
			INTERES			= round(   interes * tasa_con / 36000 * (1+dias)  , (CASE WHEN COD_MONEDA = 999 then 0 ELSE 4 END) )
	WHERE (orden = 2  or orden = 1)


        
	UPDATE #PASO SET --INTERES		= Round( interes * tasa_con / CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END * (1+dias) , CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END ), -- Round((interes * ((tasa_con * (1+dias)) / (CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END) )),CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END),
 			 PRECIO_OP_UM		= isnull((interes  / (CASE WHEN cod_moneda = 999 OR cod_moneda = 13 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = @fecproc) END)),0) --CBG 18/08/2004
	WHERE orden = 3 Or Orden = 4


	UPDATE #PASO SET INTERES		= Round( PRECIO_OP_UM * tasa_con / CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END * (1+dias) , CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END )
-- 			 PRECIO_OP_UM		= isnull((precio_op  / (CASE WHEN cod_moneda = 999 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = @fecproc) END)),0)
	WHERE orden = 3 Or Orden = 4

	UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),clnombre) FROM VIEW_CLIENTE  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = clrut and clcodigo = cod_emisor and orden in(3,4,5,6)
	UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),emnombre) FROM VIEW_EMISOR  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = emrut and orden not in (3,4,5,6)
	UPDATE #PASO SET NOM_MONEDA = mnnemo FROM VIEW_MONEDA WHERE COD_MONEDA = mncodmon

/*   Valorizacvion a Fecha de Reporte */
  DELETE #Paso Where SUBSTRING(OprRes,1,5) = 'DISPO'



  SELECT @nCont = Max(Flag) From #Paso
  SELECT @n = Min(Flag) from #Paso

  WHILE @n <= @nCont
   BEGIN
   SELECT @cEstado = '*'
   SELECT @nValOpePe=0,@nValCont=0,@nNominal=0,@ValVen = 0,@Valini=0
   SELECT @xSistema = 'BTR',
          @xTipoMov = 'MOV',
          @TipOpe   = (CASE WHEN CharIndex(OprRes,'INTERCP ') > 0 THEN 'CP' 
                            ELSE (CASE WHEN CharIndex(OprRes,'INTERCI ') > 0 THEN 'CI' ELSE tipoper END) 
                            END),
	  @codins   = Ltrim(Rtrim(FAMILIA_SERIE)) + CASE WHEN FAMILIA_SERIE = 'LCHR' THEN (CASE WHEN RUT_EMISOR = @nRutcart THEN 'BO' ELSE 'DI' END) ELSE '' END,
	  @xMoneda  = CASE WHEN CHARINDEX(OprRes,'STOCKCP -INTERCP ') > 0 THEN monemi ELSE (CASE WHEN CHARINDEX(OprRes,'STOCKCI -VENTACI -INTERCI -VENTACP ') > 0  THEN COD_MONEDA ELSE 0 END) END ,
	  @TipoCartera = CONVERT(CHAR(01),LTRIm(RTRIM(ModInv))),
	  @xRutCli     = RUT_EMISOR,
	  @cRtEm        =RutEmi,
	  @xCodCli     = COD_EMISOR,  -- (Select clcodigo From View_Cliente Where Clrut = RUT_EMISOR And ),
	  @dFecini     = Fecha_Operacion,
	  @dFecFin     = Fecha_pacto,
	  @xGarantia   = 'N',
	  @NumDocu     = NUMDOCU,
	  @Correla     = CORRELA,
	  @cOpe        = OprRes,
	  @nValCont    = PRECIO_OP_UM, -- ValorCont,
	  @nValOpePe   = PRECIO_OP,
	  @nNominal    = Nominal,
	  @dFecinicial = FECHA_OPERACION,
	  @Valini      = valor_ini,
	  @ValVen      = valor_venc,
	  @xMonemi     = monemi,
   	  @codinst     = CONVERT(Char(10),Codigo),
	  @TipoCart    = CASE WHEN ModInv = 'T' THEN 1 
   			      WHEN ModInv = 'A' THEN 2
			      WHEN ModInv = 'H' THEN 4
  	                 ELSE 3 END,
	  @cEstado = ' '
   FROM #PASO
   WHERE Flag = @n 

   SELECT @cCond = ''

   If CharIndex(@TipOpe,'CP   ') > 0  OR @cOpe = 'INTERCP' Begin --  OR @cOpe = 'VENTACP' Begin
	SELECT @cCondi = CASE WHEN @xRutCli = 97029000 and @cOpe = 'INTERCP' THEN '0' ELSE (Select Isnull(Emtipo,'') From view_emisor Where emrut = @cRtEm) END

   End Else Begin
 	EXECUTE dbo.sp_cond_vi @Tipope,@xRutCli,@xCodCli,@dFecini,@dFecFin,@xGarantia,@cCondi OUTPUT
   End

   SELECT @cCondi = CASE WHEN LEN(@cCondi) = 0 THEN '0' ELSE @cCondi END

   SELECT @cCond = CASE WHEN CONVERT(NUMERIC(2),@cCondi) <= 9 THEN ' '+ltrim(rtrim(@cCondi)) ELSE ltrim(rtrim(@cCondi)) END
   SELECT @cCustodia = CASE WHEN CHARINDEX(@cOpe,'INTERCP -STOCKCP -VENTACP -STOCKCI -VENTACI ') > 0 THEN '1' ELSE '2' END
   SELECT @indice = 1


   SELECT @cLlave = ''

   SELECT @cLlave = CASE WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN
				@cOpe+Space(6)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia
	     		 WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAR(06),@codins)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN
				@cOpe+CONVERT(CHAR(06),@codins)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia
	     		 WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAr(06),@codins)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia) ) THEN
				@cOpe+CONVERT(CHAr(06),@codins)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia
	     		 WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia) )THEN
				@cOpe+Space(6)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia
	     		 WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+@TipoCartera+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN
				@cOpe+Space(6)+@TipoCartera+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia
	     		 WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAR(06),@codins)+' '+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN
				@cOpe+CONVERT(CHAR(06),@codins)+' '+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia
		    END


   SELECT *,'Filas'=IDENTITY(INT) INTO #TmpCta
   FROM saldos_Cartera WHERE LLAVE = @cLlave

   IF CHARINDEX(@cOpe,'INTERCI -STOCKCI -VENTACI ') > 0 Begin
   	DECLARE  @cLlaveDos CHAR(21)
	SELECT @cLlaveDos = ''
   	SELECT @cCustodia = '2'
	select @xMoneda = @xMonemi

   	SELECT @cLlaveDos = CASE WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN
				@cOpe+Space(6)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia
	     		 WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAR(06),@codins)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN
				@cOpe+CONVERT(CHAR(06),@codins)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia
	     		 WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAr(06),@codins)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia) ) THEN
				@cOpe+CONVERT(CHAr(06),@codins)+@TipoCartera+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia
	     		 WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia) )THEN
				@cOpe+Space(6)+' '+@cCond+CONVERT(CHAR(03),@xMoneda)+@cCustodia
	     		 WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+Space(6)+@TipoCartera+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN
				@cOpe+Space(6)+@TipoCartera+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia
	     		 WHEN Exists(Select * from SALDOS_CARTERA WHERE LLAVE = (@cOpe+CONVERT(CHAR(06),@codins)+' '+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia)) THEN
				@cOpe+CONVERT(CHAR(06),@codins)+' '+'  '+CONVERT(CHAR(03),@xMoneda)+@cCustodia
		    END
   	INSERT #TmpCta
   	SELECT * FROM saldos_Cartera WHERE LLAVE = @cLlavedos
   End
   SELECT @nValMon = CASE WHEN @xMoneda = 999 THEN 1 ELSE Isnull((SELECT vmvalor FROM View_VALOR_MONEDA Where vmcodigo =@xMoneda ANd vmfecha =@dFecinicial),1) END

--select @nValMon,@dFecinicial


   SELECT @nReg = COUNT(*) FROM #TmpCta
   SELECT @nn = 1
   WHILE @nn <= @nReg BEGIN

	SELECT @cEstado = '*'
	SELECT @cCampoVar = Upper(NMONTO),
	       @nmoneda   = UMMONTO,
	       @cNumcta   = Cuenta,
	       @cLlave     = Llave,
	      @cEstado  = ' '
	FROM #TmpCta
	WHERE Filas = @nn

	If @cEstado = '*' BREAK 

	SELECT @nMtoPe = 0
	
if Not (@xRutCli = 97029000 and @cOpe = 'INTERCP') Begin

		SELECT @nMtoPe = CASE WHEN @cCampoVar = 'VALCONU'  THEN @nValCont-- @nValCont/@nValMon
	   		 WHEN @cCampoVar = 'VALCONP'  THEN @nValOpePe -- @nValCont -- @nValCont
			 WHEN @cCampoVar = 'NOMINAL'  THEN @nNominal
			 WHEN @cCampoVar = 'NOMINALP' THEN Round(@nNominal*@nValMon,0)
			 WHEN @cCampoVar = 'VALINIC'  THEN @nValCont-- @Valini
			 WHEN @cCampoVar = 'VALINIP'  THEN @Valini END
        

--        select @cCampoVar,@nmoneda,@cNumcta,@cLlave

		UPDATE saldos_cartera
		SET Saldo = Saldo + @nMtoPe
		WHERE Llave = @cLlave AND NMONTO = @cCampoVar AND UMMONTO = @nmoneda AND Cuenta = @cNumcta
	end
        select @nn= @nn +1
   End
   drop table #TmpCta
   SELECT @n = @n +1
  End


END

-- Base de Datos --
GO
