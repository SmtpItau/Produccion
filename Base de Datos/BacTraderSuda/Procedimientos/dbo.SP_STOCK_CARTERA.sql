USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_STOCK_CARTERA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_STOCK_CARTERA] (@cFecRep CHAR(08))
AS 
BEGIN

SET NOCOUNT ON
DECLARE @FECPROC     CHAR(10), 
	@dFecPrx     DATETIME
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
	@nDolObs     FLOAT    , -- VGS (17/08/2005)
	@nRutcart    NUMERIC(10) -- VGS (10/09/2006)
	UPDATE saldos_cartera SET SALDO = 0

	SELECT @dFecRep = CONVERT(Datetime,@cFecRep)
        SELECT @FECPROC =convert(char(10),acfecproc,112),
	       @dFecPrx = acfecprox,
	       @nRutcart = acrutprop
	FROM MDAC

	SELECT @nDolObs = vmvalor FROM View_Valor_Moneda where vmcodigo = 994 and vmfecha = @FECPROC   -- VGS (17/08/2005)
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
		PRECIO_OP_UM	= Convert(Float,CASE WHEN isnull(mdvi.valor_contable,0) =0  THEN mdvi.vivptirv ELSE isnull(mdvi.valor_contable,0)  END ),    
		PRECIO_OP	= Round(mdvi.valor_contable * (CASE WHEN vimonemi = 13 THEN @nDolObs ELSE 1 END),0),  -- VGS (17/08/2005)
		TASA_CON      	= isnull(Mdcp.tasa_contrato,0),
		FECHA_VENCI   	= vifecven, --CONVERT(CHAR(12),vifecven,103),  -- cpfeccomp
		INTERES		= CASE WHEN mdcp.cpfeccomp < CONVERT(DATETIME,'20070115') THEN (Round(mdvi.valor_contable / (CAse when vimonemi = 999 OR vimonemi = 13  Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = mdcp.Fecha_Pagomañana) End),4))--vivalcomu, CBG 18/08/2004
					ELSE
					Round(CASE WHEN isnull(mdvi.valor_contable,0) =0  THEN mdvi.vivptirv ELSE isnull(mdvi.valor_contable,0)  END / (CAse when vimonemi = 999 OR vimonemi = 13  Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = mdcp.cpfeccomp) End),4)
				  END,
		OP_PROVENIENTE	= vitipoper,
		FAMILIA_SERIE   = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),''),
		GLOSA           = 'VENTA CON PACTO ' + 'PROVENIENTES DE ' + vitipoper ,
		OPERACION 	= 'VENTA CON PACTO ' + 'PROVENIENTES DE ' + (CASE WHEN vitipoper= 'CP' THEN 'COMPRAS DEFINITIVAS' ELSE 'COMPRAS CON PACTO DE RETROVENTA' END)
				 + convert(char(60),''),
                orden           = (CASE WHEN vitipoper = 'CP' then 5 else 6 END) ,
		tip		= MDVI.codigo_carterasuper,  --5              				 ,
		fecha_operacion = vifecinip,
		tipoper		= 'VI',
		valor_venc	= vivalvenp,
		fecha_pacto	= vifecvenp,--convert(char(10),vifecvenp,112) ,
		dias		= CASE WHEN mdcp.cpfeccomp < CONVERT(DATETIME,'20070115') THEN datediff(day,(CASE WHEN viseriado = 'S' THEN (CASE WHEN vifecucup > Mdcp.Fecha_Pagomañana THEN vifecucup ELSE Mdcp.Fecha_Pagomañana END)
				        									ELSE Mdcp.Fecha_Pagomañana END) ,@dFecRep)
					ELSE
						datediff(day,(CASE WHEN viseriado = 'S' THEN (CASE WHEN vifecucup > Mdcp.cpfeccomp THEN vifecucup ELSE Mdcp.cpfeccomp END)
				        	ELSE Mdcp.cpfeccomp END) ,@dFecRep)
				  END,
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
		FecaPagoOrig    = CASE WHEN mdcp.cpfeccomp < CONVERT(DATETIME,'20070115') THEN Mdcp.Fecha_Pagomañana ELSE Mdcp.cpfeccomp END, -- VGS 30/01/2007 mdcp.Fecha_Pagomañana,/
		Tasapacto       = vitaspact,
		VctoPacto	= vifecvenp,
		Flag		= IDENTITY(INT)
	INTO #PASO 
	FROM MDVI,mdac,mdcp
	WHERE vitipoper  = 'CP' and vinumdocu = cpnumdocu and vicorrela = cpcorrela and viinstser = cpinstser
--		and cpnumdocu = 55510

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
		PRECIO_OP_UM	= Convert(Float,CASE WHEN isnull(mdvi.valor_contable,0) =0  THEN mdvi.vivptirci ELSE isnull(mdvi.valor_contable,0)  END ), 
		PRECIO_OP		= Round(CASE WHEN isnull(mdvi.valor_contable,0) =0  THEN mdvi.vivptirci ELSE isnull(mdvi.valor_contable,0)  END  * (CASE WHEN vimonemi = 13 THEN @nDolObs ELSE 1 END),0), -- VGS (17/08/2005)
		TASA_CON      	= isnull(Mdci.citaspact,0),
		FECHA_VENCI   	= vifecven, --CONVERT(CHAR(12),vifecven,103),  -- cpfeccomp
		INTERES		= Round(mdvi.valor_contable / (CAse when vimonemi = 999 OR vimonemi = 13 Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = mdci.Fecha_Pagomañana) End),4),--vivalcomu, CBG 18/08/2004
		OP_PROVENIENTE	= vitipoper,
		FAMILIA_SERIE   = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),''),
		GLOSA           = 'VENTA CON PACTO ' + 'PROVENIENTES DE ' + vitipoper ,
		OPERACION 		= 'VENTA CON PACTO ' + 'PROVENIENTES DE ' + (CASE WHEN vitipoper= 'CP' THEN 'COMPRAS DEFINITIVAS' ELSE 'COMPRAS CON PACTO DE RETROVENTA' END)		 + convert(char(60),''),
                orden           = (CASE WHEN vitipoper = 'CP' then 5 else 6 END) ,
		tip				= MDVI.codigo_carterasuper              				 ,
		fecha_operacion = vifecinip,
		tipoper		= 'VI',
		valor_venc	= vivalvenp,
		fecha_pacto	= vifecvenp,--convert(char(10),vifecvenp,112) ,
		dias		= datediff(day,(CASE WHEN viseriado = 'S' THEN (CASE WHEN vifecucup > Mdci.cifecinip THEN vifecucup ELSE Mdci.cifecinip END)
				        ELSE Mdci.cifecinip END) ,@dFecRep),   --acfecproc), 
		tipopero	= vitipoper, 
		valor_ini	= vivalinip,
		OprRes          = 'INTERCI',
		ModInv		= 'P',
		ValorCont	= vivalinip,
		RutEmi		= virutemi,
		VerVp		= ' ',
		monemi		= vimonemi,
		FecaPagoOrig    = Mdci.Fecha_Pagomañana,
		Tasapacto       = vitaspact,
		VctoPacto	= vifecvenp
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
		PRECIO_OP	= CASE WHEN isnull(mdvi.valor_contable,0) =0  THEN mdvi.vivptirv ELSE isnull(mdvi.valor_contable,0)  END , 
		TASA_CON      	= isnull(Mdcp.tasa_contrato,0),
		FECHA_VENCI   	= vifecven, --CONVERT(CHAR(12),vifecven,103),  -- cpfeccomp
--		INTERES		= mdvi.valor_contable / (CAse when vimonemi = 999 OR vimonemi = 13 Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = Mdcp.Fecha_Pagomañana) End),--vivalcomu, -CBG 18/08/2004
		INTERES		= CASE WHEN mdcp.cpfeccomp < CONVERT(DATETIME,'20070115') THEN Round(mdvi.valor_contable / (CAse when vimonemi = 999 OR vimonemi = 13  Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = mdcp.Fecha_Pagomañana) End),4)--vivalcomu, CBG 18/08/2004
					ELSE
					Round(CASE WHEN isnull(mdvi.valor_contable,0) =0  THEN mdvi.vivptirv ELSE isnull(mdvi.valor_contable,0)  END  / (CAse when vimonemi = 999 OR vimonemi = 13  Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = mdcp.cpfeccomp) End),4)
				  END,
		OP_PROVENIENTE	= vitipoper,
		FAMILIA_SERIE   = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),''),
		GLOSA           = 'VENTA CON PACTO ',
		OPERACION 	= 'VENTA CON PACTO ',
                orden           = (CASE WHEN vitipoper = 'CP' then 5 else 6 END) ,
		tip		= MDVI.codigo_carterasuper              				 ,
		fecha_operacion = vifecinip,
		tipoper		= 'VI',
		valor_venc	= vivalvenp,
		fecha_pacto	= vifecvenp,--convert(char(10),vifecvenp,112) ,
--		dias		= datediff(day,(CASE WHEN viseriado = 'S' THEN (CASE WHEN vifecucup > Mdcp.Fecha_Pagomañana THEN vifecucup ELSE mdcp.Fecha_Pagomañana END)
--				        ELSE Mdcp.Fecha_Pagomañana END) ,@dFecRep), -- acfecproc),
		dias		= CASE WHEN mdcp.cpfeccomp < CONVERT(DATETIME,'20070115') THEN datediff(day,(CASE WHEN viseriado = 'S' THEN (CASE WHEN vifecucup > Mdcp.Fecha_Pagomañana THEN vifecucup ELSE Mdcp.Fecha_Pagomañana END)
				        								ELSE Mdcp.Fecha_Pagomañana END) ,@dFecRep)
					ELSE
						datediff(day,(CASE WHEN viseriado = 'S' THEN (CASE WHEN vifecucup > Mdcp.cpfeccomp THEN vifecucup ELSE Mdcp.cpfeccomp END)
				        	ELSE Mdcp.cpfeccomp END) ,@dFecRep)
				  END,
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
		FecaPagoOrig    = CASE WHEN mdcp.cpfeccomp < CONVERT(DATETIME,'20070115') THEN Mdcp.Fecha_Pagomañana ELSE Mdcp.cpfeccomp END, -- VGS 30/01/2007 Mdcp.Fecha_Pagomañana,
		Tasapacto       = vitaspact,
		VctoPacto	= vifecvenp
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
		INTERES		= mdvi.valor_contable / (CAse when vimonemi = 999 OR  vimonemi = 13  Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = Mdci.Fecha_Pagomañana) End),--vivalcomu, CBG 18/08/2004
		OP_PROVENIENTE	= vitipoper,
		FAMILIA_SERIE   = ISNULL((SELECT inserie FROM VIEW_INSTRUMENTO WHERE incodigo = vicodigo),''),
		GLOSA           = 'VENTA CON PACTO ',
		OPERACION 	= 'VENTA CON PACTO ',
                orden           = (CASE WHEN vitipoper = 'CP' then 5 else 6 END) ,
		tip		= MDVI.codigo_carterasuper              				 ,
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
		VctoPacto	= vifecvenp
	FROM MDVI,mdac,Mdci
	WHERE vitipoper  = 'CI' and vinumdocu = cinumdocu and vicorrela = cicorrela and viinstser = ciinstser

        UPDATE #PAso SET PRECIO_OP_UM = Round(PRECIO_OP_UM / (CASE WHEN monemi = 999 OR monemi = 13 THEN 1 ELSE (Select vmvalor From view_valor_moneda Where Vmcodigo = monemi and vmfecha = FecaPagoOrig )  END),4) --CBG 18/08/2004
	UPDATE #PASO SET INTERES  = round( interes * tasa_con / 36000 * (1+dias) ,(CASE WHEN monemi = 999  THEN 0 ELSE 4 END)) 


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
		OPERACION       = 'STOCK TOTAL COMPRAS CON PACTO DE RETROVENTA ' + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = codigo_carterasuper AND tbcateg = '1111'),
                orden  		= 3 	,
		tip		= MDCI.codigo_carterasuper             ,
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
		FecaPagoOrig    = Fecha_pagomañana,
		Tasapacto       = citaspact,
		VctoPacto	= cifecvenp
	FROM MDCI,mdac
	WHERE (ciinstser <> 'ICOL' AND ciinstser <> 'ICAP' AND ciinstser <> 'IC' ) 

	-- STOCK PROPIO
	INSERT #PASO
	SELECT 	NUMDOCU 	= cpnumdocu,
		CORRELA		= cpcorrela,
		FECHA_EMISION 	= CONVERT(CHAR(12), cpfecemi, 103),
		SERIE		= RTRIM(cpinstser) + (case when Fecha_pagomañana > @dFecRep THEN ' *' ELSE '' END),
		TCORRELA	= 1,
		SERIADO         = cpseriado,
		CODIGO_BOLSA  	= 0,
		NUM_CLI		= codigo_as400, --MMP 14/09/2009 --ISNULL((SELECT codigo_as400 FROM VIEW_CLIENTE WHERE clrut = cprutcli and clcodigo = cpcodcli ),0),
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
		OPERACION 	= 'STOCK TOTAL ' + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = codigo_carterasuper AND tbcateg = '1111'),
                orden           = 1,
		tip		=  codigo_carterasuper,  --cptipcart              ,
		fecha_operacion = CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN Fecha_pagomañana ELSE cpfeccomp END,

		tipoper		= 'CP'			,
		valor_venc	= convert(float,0)	,
		fecha_pacto	= ''			,
		dias		= CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > Fecha_pagomañana And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE Fecha_pagomañana END) ELSE Fecha_PagoMañana END) ,@dFecRep)
					ELSE
					    datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > cpfeccomp And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE cpfeccomp END) ELSE cpfeccomp END) ,@dFecRep)
					END,

		tipopero	= 'CP',
		valor_ini       = convert(numeric(19,4),0),
		OprRes       	= 'STOCKCP',
		ModInv		= CASE WHEN cptipcart = 1 THEN 'T' 
					WHEN cptipcart = 2 THEN 'A'
					WHEN cptipcart = 4 THEN 'H'
					ELSE 'P' END,
		ValorCont	= case  when isnull(a.Valor_Contable,0) =0 THEN  a.cpvptirc ELSE a.Valor_Contable END  + isnull((select sum(Valor_Contable) from mdvi where cpnumdocu = vinumdocu and cpcorrela = vicorrela),0),
		RutEmi		= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara ),0)
             				WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela),0)  END),
		VerVp		= (CASE WHEN (EXISTS(Select * from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela) Or cpnominal > 0) THEN ' ' ELSE 'X' END),
		monemi		= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT semonemi FROM VIEW_SERIE WHERE semascara = cpmascara),0) WHEN UPPER(cpseriado) = 'N' THEN ISNULL((SELECT nsmonemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela),0) END),
		FecaPagoOrig    = Fecha_pagomañana,
		Tasapacto       = 0.0,
		VctoPacto	= CPFECVEN
             FROM MDCP a,mdac  , VIEW_CLIENTE
                WHERE (clrut = a.cprutcli and clcodigo = a.cpcodcli )
                AND  (cpnominal>0 or EXISTS(Select * from mdvi Where vinumdocu = cpnumdocu and vicorrela = cpcorrela))

	-- Se eliminan los instrumento que estan con nominal en 0 porque si no se encontro en la 
        -- tabla de ventas con pacto se asume que el papel esta vendido definitivo
        delete #paso where VerVp = 'X' and Orden = 1


        UPDATE #PASO
	Set interes = interes/(CAse when COD_MONEDA = 999 OR COD_MONEDA = 13 Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN Fecha_Pagomañana ELSE cpfeccomp END) End) -- CBG 18/08/2004
        FROM Mdcp 
	WHERE numdocu = cpnumdocu and correla = cpcorrela and orden = 1


-- DISPONIBILIDAD 
	INSERT #PASO
	SELECT	
		NUMDOCU 	= dinumdocu,
		CORRELA		= dicorrela,
		FECHA_EMISION 	= 0,
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
		PRECIO_OP_UM	= case when isnull(a.valor_contable,0) =0 THEN a.divptirc ELSE valor_contable end, 
		PRECIO_OP		= case when isnull(a.valor_contable,0) =0 THEN a.divptirc ELSE valor_contable end,
		TASA_CON      	= 0.0,
		FECHA_VENCI   	= '',
		INTERES		= convert(float,0),
		OP_PROVENIENTE	= 0,
		FAMILIA_SERIE   = diserie,
		GLOSA           = 'DISPONIBILIDAD ',
		OPERACION 	= 'DISPONIBILIDAD ' + (CASE WHEN ditipoper = 'CI' THEN 'COMPRAS CON PACTO DE RETROVENTA ' ELSE ' ' END)
				  + (SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcodigo1 = codigo_carterasuper AND tbcateg = '1111'),
                orden            = (CASE WHEN ditipoper = 'CP' THEN 2 ELSE 4 END),		tip		= a.codigo_carterasuper             ,
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
		ValorCont	= case when isnull(a.valor_contable,0) =0 THEN a.divptirc ELSE valor_contable end,
		RutEmi		= 0,
		VerVp		= (CASE WHEN (EXISTS(Select * from mdvi Where vinumdocu = dinumdocu and vicorrela = dicorrela) Or dinominal > 0) THEN ' ' ELSE 'X' END),
		monemi		= 0,
		FecaPagoOrig    = Fecha_pagomañana,
		Tasapacto       = 0.0,
		VctoPacto	= difecsal

	FROM MDDI a 
	WHERE Difecsal > @Fecproc  AND (dinominal>0 or EXISTS(Select * from mdvi Where vinumdocu = dinumdocu and vicorrela = dicorrela))

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
		FECHA_VENCI   	= cpfecven,
		fecha_operacion = CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN Fecha_pagomañana ELSE cpfeccomp END,
		valor_venc	= convert(float,0),
		fecha_pacto	= '',
		dias		= CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > Fecha_pagomañana And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE Fecha_pagomañana END) ELSE Fecha_PagoMañana END) ,@dFecRep)
					ELSE
					    datediff(day,(CASE WHEN cpseriado = 'S' THEN (CASE WHEN cpfecucup > cpfeccomp And (Charindex('*', cpinstser)=0 And Charindex('&', cpinstser)=0 )  THEN cpfecucup ELSE cpfeccomp END) ELSE cpfeccomp END) ,@dFecRep)
					END,
		RutEmi		= (CASE WHEN UPPER(cpseriado) = 'S' THEN ISNULL((SELECT serutemi FROM VIEW_SERIE WHERE semascara = cpmascara),0) 
				        ELSE ISNULL((SELECT nsrutemi FROM VIEW_NOSERIE WHERE cpnumdocu = nsnumdocu AND cpcorrela = nscorrela) ,0) END),
                SERIADO         = cpseriado
	FROM MDCP,mdac
	WHERE cpnumdocu = numdocu AND cpcorrela = correla AND orden = 2


        delete #paso where VerVp = 'X' and Orden = 2


	UPDATE #PASO
	SET	interes	= a.valor_contable/ (Case When COD_MONEDA = 999 OR COD_MONEDA = 13 THEN 1 ELSE (Select vmvalor From View_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = CASE WHEN cpfeccomp <= CONVERT(DATETIME,'20070115') THEN a.Fecha_Pagomañana ELSE a.cpfeccomp END) END)-- cpvalcomu -CBG 18/08/2004
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
		PRECIO_OP_UM	= civalinip, --  + isnull((select sum(vivalinip) from mdvi where cinumdocu = vinumdocu and cicorrela = vicorrela),0),
		PRECIO_OP	= isnull(civalinip,0) -- + isnull((select sum(vivalinip) from mdvi where cinumdocu = vinumdocu and cicorrela = vicorrela),0),  
	FROM MDCI,mdac
	WHERE cinumdocu = numdocu AND cicorrela = correla AND orden = 4 

--calculo de interes disponibilidad propia
	UPDATE #PASO SET PRECIO_OP_UM		= Round(isnull((precio_op  / (CASE WHEN COD_MONEDA = 999 OR COD_MONEDA = 13 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = fecha_operacion) END)),0), (CASE WHEN COD_MONEDA = 999
 Then 0 ELSE 4 END)), --CBG 18/08/2004)  ,
			INTERES			= round(  interes * tasa_con / 36000 * (1+dias)  , (CASE WHEN COD_MONEDA = 999 then 0 ELSE 4 END) )
	WHERE (orden = 2  or orden = 1)

	UPDATE #PASO SET --INTERES		= Round( interes * tasa_con / CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END * (1+dias) , CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END ), -- Round((interes * ((tasa_con * (1+dias)) / (CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END) )),CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END),
 			 PRECIO_OP_UM		= isnull((interes  / (CASE WHEN cod_moneda = 999 OR cod_moneda = 13 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = @fecproc) END)),0) -- CBG 18/08/2004
	WHERE orden = 3 Or Orden = 4


	UPDATE #PASO SET INTERES		= Round( PRECIO_OP_UM * tasa_con / CASE WHEN COD_MONEDA = 999 THEN 3000 ELSE 36000 END * (1+dias) , CASE WHEN COD_MONEDA = 999 THEN 0 ELSE 4 END ) --CBG REVISAR PARA DOLARES
-- 			 PRECIO_OP_UM		= isnull((precio_op  / (CASE WHEN cod_moneda = 999 then 1 ELSE (select vmvalor from view_valor_moneda where vmcodigo = COD_MONEDA and vmfecha = @fecproc) END)),0)
	WHERE orden = 3 Or Orden = 4


	UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),clnombre) FROM VIEW_CLIENTE  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = clrut and clcodigo = cod_emisor and orden in(3,4,5,6)
	UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),emnombre) FROM VIEW_EMISOR  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = emrut and orden not in (3,4,5,6)
	UPDATE #PASO SET NOM_MONEDA = mnnemo FROM VIEW_MONEDA WHERE COD_MONEDA = mncodmon

	-- VMGS Se debe eliminar de este reporte las letras de credito hiopotecarias propia emision debido a la nueva normativa
        -- contable (Octubre del 2002)
	-- *******************************************************************************************
        DELETE #PASO WHERE SUBSTRING (SERIE,1,3) = 'ITA' AND FAMILIA_SERIE = 'LCHR'
        DELETE #PASO WHERE SUBSTRING (SERIE,1,3) = 'COR' AND FAMILIA_SERIE = 'LCHR'
        DELETE #PASO WHERE SUBSTRING (SERIE,1,3) = 'BCO' AND FAMILIA_SERIE = 'LCHR'
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
		TotMonInteres_BCCH   = CONVERT(Float,0)
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
		interes1    = sum(interes)     

	into #totales
	from #paso1
	where rut_emisor =97029000 and orden in(5,6)
	group by clave
	Order by clave

	insert into #totales
	select  clave ,
		rut = 0 ,
		cod_moneda ,
		nominal= sum(nominal)   ,
		op_um	= sum(precio_op_um)   ,
		op	= sum(precio_op)      , 	
		valor_ini = sum (valor_ini)     ,
		valor_venc = sum(valor_venc)	,
		interes    = sum(interes)	

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
	TotMonInteres_CLP   = interes1
  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 999
  
  UPDATE #Paso1
  SET 	TotMonNomi_UF	= nominal1,
	TotMonValIni_Um_UF = op_um1,
	TotMonValIni_Pe_UF = op1,
	TotMonVinicial_UF  = valor_ini1,
	TotMonValVcto_UF   = valor_venc1,
	TotMonInteres_UF   = interes1
  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 998

  UPDATE #Paso1
  SET 	TotMonNomi_DO	= nominal1,
	TotMonValIni_Um_DO = op_um1,
	TotMonValIni_Pe_DO = op1,
	TotMonVinicial_DO  = valor_ini1,
	TotMonValVcto_DO   = valor_venc1,
	TotMonInteres_DO   = interes1
  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 994

  UPDATE #Paso1
  SET 	TotMonNomi_USD	= nominal1,
	TotMonValIni_Um_USD = op_um1,
	TotMonValIni_Pe_USD = op1,
	TotMonVinicial_USD  = valor_ini1,
	TotMonValVcto_USD   = valor_venc1,
	TotMonInteres_USD   = interes1
  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 13

  UPDATE #Paso1
  SET 	TotMonNomi_BCCH	= nominal1,
	TotMonValIni_Um_BCCH = op_um1,
	TotMonValIni_Pe_BCCH = op1,
	TotMonVinicial_BCCH  = valor_ini1,
	TotMonValVcto_BCCH   = valor_venc1,
	TotMonInteres_BCCH   = interes1
  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 0 and Rut = 1

  DELETE #Paso Where SUBSTRING(OprRes,1,5) = 'DISPO'


  SELECT @nCont = Max(Flag) From #Paso --WHERE right(SERIE,1) <> '*'  -- Excluye del resumen contable las operaciones PM
  SELECT @n = Min(Flag) from #Paso --WHERE right(SERIE,1) <> '*' -- Excluye del resumen contable las operaciones PM
--  SELECT @n, @nCont

  WHILE @n <= @nCont
   BEGIN
   SELECT @cEstado = '*'
   SELECT @nValOpePe=0,@nValCont=0,@nNominal=0,@ValVen = 0,@Valini=0 -- CBG
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
   SELECT @nValMon = CASE WHEN @xMoneda = 999 THEN 1 
			  WHEN @xMoneda = 13  THEN Isnull((SELECT vmvalor FROM View_VALOR_MONEDA Where vmcodigo =994 ANd vmfecha =@dFecinicial),1)  -- VGS (17/08/2005)
			ELSE Isnull((SELECT vmvalor FROM View_VALOR_MONEDA Where vmcodigo =@xMoneda ANd vmfecha =@dFecinicial),1) END --CBG 18/08/2004

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
--	if Not (@xRutCli = 97029000 and CHARINDEX(@cLlave,'INTERCP')>0 ) Begin
		SELECT @nMtoPe = CASE WHEN @cCampoVar = 'VALCONU'  THEN @nValCont-- @nValCont/@nValMon
	   		 WHEN @cCampoVar = 'VALCONP'  THEN @nValOpePe -- @nValCont -- @nValCont
			 WHEN @cCampoVar = 'NOMINAL'  THEN @nNominal
			 WHEN @cCampoVar = 'NOMINALP' THEN Round(@nNominal*@nValMon,0)
			 WHEN @cCampoVar = 'VALINIC'  THEN @nValCont-- @Valini
			 WHEN @cCampoVar = 'VALINIP'  THEN @Valini END
        

		UPDATE saldos_cartera
		SET Saldo = Saldo + @nMtoPe
		WHERE Llave = @cLlave AND NMONTO = @cCampoVar AND UMMONTO = @nmoneda AND Cuenta = @cNumcta
	end
        select @nn= @nn +1
   End
   drop table #TmpCta
   SELECT @n = @n +1
  End


  DECLARE @COUNT INT
  SET @COUNT = (SELECT COUNT(*) FROM #paso1)


  IF @COUNT <> 0
  BEGIN


  SELECT * from #paso1 ORDER BY CLAVE,OprRes,ModInv,VctoPacto,fecha_operacion 

  END

  ELSE

  BEGIN

  	SELECT  numdocu          = '', 
		FECHA_EMISION        = '',
		SERIE                = '',
		SERIADO              = '',
		CODIGO_BOLSA         = '',
		NUM_CLI              = '' ,
		RUT_EMISOR           = '',
		NOM_EMISOR           = '',
		CONTRATO             = '',
		NOM_MONEDA           = '',
		COD_MONEDA           = '',
		NOMINAL              = '',
		PRECIO_OP_UM         = '' ,
		PRECIO_OP            = '',
		TASA_CON             = '',
		FECHA_VENCI          = '',
		INTERES              = '',
		OP_PROVENIENTE       = '',
		FAMILIA_SERIE        = '',
		GLOSA                = '',
		OPERACION            = '',
		'HORA'               = '',
        orden                = '',
		CLAVE                = '',
		fecha_operacion      = '',
		tipoper              = '',
		'acfecproc'          = '',
		valor_venc           = '',
		fecha_pacto          = '',
		dias                 = '',
		tipopero             = ''	,
		tip                  = ''		,
		valor_ini            = ''	,
		Tasapacto            = ''	,
		ModInv               = ''		,
        'NomProp'            = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales),   --acnomprop,
        'RutProp'            = '',
		VctoPacto            = '',
		OprRes               = '',
		TotMonNomi_CLP	     = '',
		TotMonValIni_Um_CLP  = '',
		TotMonValIni_Pe_CLP  = '',
		TotMonVinicial_CLP   = '',
		TotMonValVcto_CLP    = '',
		TotMonInteres_CLP    = '',

		TotMonNomi_UF	      = '',
		TotMonValIni_Um_UF    = '',
		TotMonValIni_Pe_UF    = '',
		TotMonVinicial_UF     = '',
		TotMonValVcto_UF      = '',
		TotMonInteres_UF      = '',

		TotMonNomi_DO	      = '',
		TotMonValIni_Um_DO    = '',
		TotMonValIni_Pe_DO    = '',
		TotMonVinicial_DO     = '',
		TotMonValVcto_DO      = '',
		TotMonInteres_DO      = '',

		TotMonNomi_USD	      = '',
		TotMonValIni_Um_USD   = '',
		TotMonValIni_Pe_USD   = '',
		TotMonVinicial_USD    = '',
		TotMonValVcto_USD     = '',
		TotMonInteres_USD     = '',

		TotMonNomi_BCCH	      = '',
		TotMonValIni_Um_BCCH  = '',
		TotMonValIni_Pe_BCCH  = '',
		TotMonVinicial_BCCH   = '',
		TotMonValVcto_BCCH    = '',
		TotMonInteres_BCCH    = ''

END


END
-- Base de Datos --

GO
