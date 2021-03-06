USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_STOCK_CART_Tirc_Pact_Vi]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_STOCK_CART_Tirc_Pact_Vi] (@cFecRep CHAR(08))
AS

BEGIN

SET NOCOUNT ON

DECLARE @FECPROC     CHAR(10),
	@dFecPrx     DATETIME,
	@nValCupon   FLOAT,
        @dFecSal     DATETIME,
        @fValmon_Cup FLOAT,
	@cMascara    CHAR(12)

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
	@FecInip datetime
	

	UPDATE saldos_cartera SET SALDO = 0

	SELECT @dFecRep = CONVERT(Datetime,@cFecRep)
        SELECT @FECPROC =convert(char(10),acfecproc,112),
	       @dFecPrx = acfecprox
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
		INTERES		= Round(mdvi.valor_contable / (CAse when vimonemi = 999 Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = mdcp.Fecha_Pagomañana) End),4),--vivalcomu,
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
		dias		= datediff(day,(CASE WHEN viseriado = 'S' THEN (CASE WHEN vifecucup > Mdcp.Fecha_Pagomañana THEN vifecucup ELSE Mdcp.Fecha_Pagomañana END)
				        ELSE Mdcp.Fecha_Pagomañana END) ,@dFecRep),   --acfecproc), 
		tipopero	= vitipoper, 
		valor_ini	= vivalinip,
-- OJOOJOJOJOJOJOJOJOJOJOJOJOJOJOJOJOJOJOJO
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
		INTERES		= Round(mdvi.valor_contable / (CAse when vimonemi = 999 Then 1 Else (Select vmvalor From View_valor_moneda where vmcodigo = vimonemi and vmfecha = mdci.Fecha_Pagomañana) End),4),--vivalcomu,
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


	UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),clnombre) FROM VIEW_CLIENTE  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = clrut and clcodigo = cod_emisor and orden in(3,4,5,6)
	UPDATE #PASO SET NOM_EMISOR = CONVERT(CHAR(50),emnombre) FROM VIEW_EMISOR  WHERE CONVERT(NUMERIC(15),RUT_EMISOR) = emrut and orden not in (3,4,5,6)
	UPDATE #PASO SET NOM_MONEDA = mnnemo FROM VIEW_MONEDA WHERE COD_MONEDA = mncodmon

/*   Valorizacvion a Fecha de Reporte */
--delete #PASO where numdocu <> 52208 Or correla <> 2

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
	  @FecInip     = fecha_operacion,
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

	If @Nominal > 0 Begin

   	   EXECUTE @nError = @cProg 2, @dFecRep, @codigo,@instser, @monemis, @xfecemi, @Fecven,
       		   @ntasemi, @nbase, @ntasest,@Nominal OUTPUT, @xTir OUTPUT,@fPvp OUTPUT, @fMt OUTPUT,
           	   @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,@nNumucup OUTPUT, @dFecucup OUTPUT,
           	   @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
           	   @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

           SELECT @nUf_Hoy = vmvalor From view_Valor_moneda Where vmcodigo = @monemis and Vmfecha = @cFecRep
           SELECT @nUf_Pag = vmvalor From view_Valor_moneda Where vmcodigo = @monemis and Vmfecha = @nFecPag

           SELECT @nReajuste = 0.0
	   SELECT @nInteres  = 0.0
           Select @nValCupon = 0.0


	   SELECT @nReajuste = CASE WHEN @monemis <> 999 AND @monemis <> 13 THEN ROUND(( @nUf_Hoy - @nUf_Pag ) * @Valcomp, 0) ELSE 0.0 END

	   If @dFecpcup <= @cFecRep Begin
              If @cSeriado = 'S' BEGIN

--		EXECUTE @nValCupon = Sp_SumaCupones @cMascara,@nFecPag,@cFecRep
                EXECUTE Sp_Nexthabil @dFecpcup,6,@dFecSal OUTPUT
                SELECT @fValmon_Cup = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@monemis AND vmfecha=@dFecSal
	        Select @nValCupon = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Cup, 0)
	      End Else Select @nValCupon = 0  -- ?????????????????????? VMGS
            
	   End

	   If @FecInip = @dFecRep
		SELECT @nVpresen = @fMt  -- VGS Esto es para evitar descuadres de decimales al inico de la operacion, para los papeles en USD

	   SELECT @nInteres = (@fMt - @nVpresen - @nReajuste + @nValCupon)

	   UPDATE #PASO
	   SET vPresen = @fMt,
	      Reajustes	  = @nReajuste,
	      InteresesPeso = @nInteres,
	      INTERES  = (CASE WHEN @nUf_Pag > 0 THEN ROUND(@nInteres/@nUf_Pag,4) ELSE 0 END)
	   WHERE Flag = @n

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
		nominal= sum(nominal)   ,
		op_um	= sum(precio_op_um)   ,
		op	= sum(precio_op)      , 	
		valor_ini = sum (valor_ini)     ,
		valor_venc = sum(valor_venc)	,
		interes    = sum(interes)	,
		vPresen     = sum(vPresen),
		IntPeso     = sum(InteresesPeso),
		ReaPeso     = sum(Reajustes)
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
  SET 	TotMonNomi_DO	= nominal1,
	TotMonValIni_Um_DO = op_um1,
	TotMonValIni_Pe_DO = op1,
	TotMonVinicial_DO  = valor_ini1,
	TotMonValVcto_DO   = valor_venc1,
	TotMonInteres_DO   = interes1,
	TotVpresen_DO	    = vPresen1 ,
	TotInteresesPeso_DO = IntPeso1,
	TotReajustes_DO = ReaPeso1

  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 994

  UPDATE #Paso1
  SET 	TotMonNomi_USD	= nominal1,
	TotMonValIni_Um_USD = op_um1,
	TotMonValIni_Pe_USD = op1,
	TotMonVinicial_USD  = valor_ini1,
	TotMonValVcto_USD   = valor_venc1,
	TotMonInteres_USD   = interes1,
	TotVpresen_USD	    = vPresen1 ,
	TotInteresesPeso_USD = IntPeso1,
	TotReajustes_USD = ReaPeso1
  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 13

  UPDATE #Paso1
  SET 	TotMonNomi_BCCH	= nominal1,
	TotMonValIni_Um_BCCH = op_um1,
	TotMonValIni_Pe_BCCH = op1,
	TotMonVinicial_BCCH  = valor_ini1,
	TotMonValVcto_BCCH   = valor_venc1,
	TotMonInteres_BCCH   = interes1,
	TotVpresen_BCCH	    = vPresen1 ,
	TotInteresesPeso_BCCH = IntPeso1,
	TotReajustes_BCCH = ReaPeso1

  FROM #totales
  WHERE clave = Clave1 and cod_moneda1 = 0 and Rut = 1


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
		SERIE = '',
		SERIADO = '',
		CODIGO_BOLSA = '',
		NUM_CLI  = '',
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
		FAMILIA_SERIE  = '',
		GLOSA = '',
		OPERACION = '',
		'HORA'    = '',
        orden= '',
		CLAVE = '',
		fecha_operacion= '',
		tipoper= '',
		'acfecproc' = '',
		valor_venc= '',
		fecha_pacto= '',
		dias	= '',
		tipopero= '',
		tip		= '',
		valor_ini	= '',
		Tasapacto	= '',
		ModInv		= '',
        'NomProp' = (SELECT RazonSocial FROM BacParamSuda.dbo.Contratos_ParametrosGenerales),
        'RutProp' = '',
		VctoPacto= '',
		OprRes                = 0,
		TotMonNomi_CLP	      = 0,
		TotMonValIni_Um_CLP   = 0,
		TotMonValIni_Pe_CLP   = 0,
		TotMonVinicial_CLP    = 0,
		TotMonValVcto_CLP     = 0,
		TotMonInteres_CLP     = 0,

		TotMonNomi_UF	      = 0,
		TotMonValIni_Um_UF    = 0,
		TotMonValIni_Pe_UF    = 0,
		TotMonVinicial_UF     = 0,
		TotMonValVcto_UF      = 0,
		TotMonInteres_UF      = 0,
		TotMonNomi_DO	      = 0,
		TotMonValIni_Um_DO    = 0,
		TotMonValIni_Pe_DO    = 0,
		TotMonVinicial_DO     = 0,
		TotMonValVcto_DO      = 0,
		TotMonInteres_DO      = 0,
		TotMonNomi_USD	      = 0,
		TotMonValIni_Um_USD   = 0,
		TotMonValIni_Pe_USD   = 0,
		TotMonVinicial_USD    = 0,
		TotMonValVcto_USD     = 0,
		TotMonInteres_USD     = 0,
		TotMonNomi_BCCH	      = 0,
		TotMonValIni_Um_BCCH  = 0,
		TotMonValIni_Pe_BCCH  = 0,
		TotMonVinicial_BCCH   = 0,
		TotMonValVcto_BCCH    = 0,
		TotMonInteres_BCCH    = 0,
		TirComp	              = 0,			
		vPresen	              = 0,			
		InteresesPeso         = 0,		
		Reajustes             = 0,			
		Codigo                = 0,			
		TotVpresen_CLP	      = 0,
		TotInteresesPeso_CLP  = 0,
		TotReajustes_CLP      = 0,
		TotVpresen_UF	      = 0,
		TotInteresesPeso_UF   = 0,
		TotReajustes_UF       = 0,
		TotVpresen_DO	      = 0,
		TotInteresesPeso_DO   = 0,
		TotReajustes_DO       = 0,
		TotVpresen_USD   	  = 0,
		TotInteresesPeso_USD  = 0,
		TotReajustes_USD      = 0,
		TotVpresen_BCCH	      = 0,
		TotInteresesPeso_BCCH = 0,
		TotReajustes_BCCH     = 0



  END

END
-- Base de Datos --

GO
