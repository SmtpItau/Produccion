USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABARRCA]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_GRABARRCA]
    (
    @nrutcart	NUMERIC (09,0)	,
    @nnumoper	NUMERIC (10,0)	,
    @ntasapacto	NUMERIC (09,4)	,
    @nvalant	NUMERIC (19,4)	,
    @cuser	CHAR(12)	,
    @cterminal	CHAR(12)	,
    @forpav	NUMERIC (05,0)	,
    @nTirTran	NUMERIC (19,4)	,
    @nVpTran	NUMERIC (19,4)	,
    @DifTran	NUMERIC	(19,4)	,
    @DifTranCLP NUMERIC (19,0),

--ITAU------------------------------------------
	@subfpago			NUMERIC	(5,0)   = 0,
	@nValOriginal		NUMERIC	(19,4)  = 0,
	@nEjecutivo			NUMERIC (5)     = 0,
	@cSucursal			NUMERIC (5)     = 0,
	@observ				VARCHAR(70)		= ''
--ITAU------------------------------------------
    )
AS
BEGIN

 SET NOCOUNT ON      

 DECLARE @ctipoper CHAR (03)  ,
  @dfeccal DATETIME  ,
  @serie  CHAR (12)  ,
  @monemi  NUMERIC (03,0)  ,
  @cforpago CHAR (04)  ,
  @tasemi  NUMERIC (09,4)  ,
  @basemi  NUMERIC (03,0)  ,
  @rutemi  NUMERIC (09,0)  ,
  @iestado INTEGER   ,
  @mdse  CHAR (01)  ,
  @numdocu NUMERIC (10,0)  ,
  @correla NUMERIC (03,0)  ,
  @suma  NUMERIC (10,0)  ,
  @nerror  INTEGER   ,
  @ftasest FLOAT   ,
  @cod_ser INTEGER   ,
  @codmon  INTEGER   ,
  @cfecemi CHAR (10)  ,
  @cfecven CHAR (10)  ,
  @ftasemi FLOAT   ,
  @fbasemi FLOAT   ,
  @dfecemi DATETIME  ,
  @dfecven DATETIME  ,
  @fnominal FLOAT   ,
  @ftir  FLOAT   ,
  @nnumucup INTEGER   ,
  @dfecucup DATETIME  ,
  @nnumpcup INTEGER   ,
  @dfecpcup DATETIME  ,
  @vptirc         NUMERIC (19,4)  ,
  @interesc       NUMERIC (19,4)  ,
  @reajustec      NUMERIC (19,4)  ,
  @valcomu        NUMERIC (19,4)  ,
  @valcomp        NUMERIC (19,4)  ,
  @nnominalp NUMERIC (19,0)  , 
  @dfecinip DATETIME  ,
  @dfecvenp DATETIME  ,
  @nvalinipo NUMERIC (19,4)  ,
  @nvalvenp NUMERIC (19,4)  ,
  @nvalvtopo NUMERIC (19,4)  ,  
  @nintpac NUMERIC (19,4)  ,
  @nintpacdv FLOAT    ,
  @nbaspacto INTEGER   ,
  @ndifpos NUMERIC (19,4)  ,
  @ndifneg NUMERIC (19,4)  ,
  @nmonpact INTEGER   ,
  @nvalmoni NUMERIC (19,4)  ,
  @nvalmonv NUMERIC (19,4)  ,
  @x  INTEGER   ,
  @freapacdv FLOAT   ,
  @nrutcli NUMERIC (10,0)  ,
  @ncodcli NUMERIC (10,0)  ,
  @nvalpacto NUMERIC (19,0)  ,
  @nvalorant NUMERIC (19,4)  ,
  @nTaspactoO NUMERIC (09,4),

--ITAU------------------------------------------
		@nValcont	NUMERIC(19,04),
		@ntotal  	NUMERIC	(19,4),
		@nForPagIo	INTEGER,
		@nForPagVo	INTEGER,
		@nValTasEmi	numeric (19,0),
		@nMtoaDif	numeric (19,0),
		@nCaptTasEm	numeric (19,0),
		@nintTasEm	numeric (19,0),
		@nReajTasEm	numeric (19,0)
--ITAU------------------------------------------

 SELECT @codmon  = 0   ,
  @dfecemi = ''   ,
  @dfecven = ''   ,
  @ftasemi = 0   ,
  @fbasemi = 0   ,
  @ftasest = 0   ,
  @fnominal = 0   ,
  @ftir  = 0   ,
  @nnumucup = 0   ,
  @dfecucup = ''   ,
  @nnumpcup = 0   ,
  @dfecpcup = ''   ,
  @x   = 1       ,
  @vptirc  = 0   ,
  @interesc = 0   ,
  @reajustec = 0   ,
  @valcomu = 0   ,
  @valcomp = 0   ,
  @nnominalp = 0   ,
  @dfecinip = ''   ,
  @dfecvenp = ''   ,
  @nvalinipo = 0   ,
  @nvalvenp = 0   ,
  @nvalvtopo = 0   ,
  @nintpac = 0   ,
  @nintpacdv = 0   ,
  @nbaspacto = 0   ,
  @ndifpos = 0   ,
  @ndifneg = 0   ,
  @nmonpact = 0   ,
  @nvalmoni = 1.0   ,
  @nvalmonv = 1.0   ,
  @suma  = 0   ,
  @nTaspactoO = 0
 
CREATE TABLE
 #TEMP
  (
  numdocu  NUMERIC (10,0) NOT NULL ,
  correla  NUMERIC (03,0) NOT NULL ,
  tipoper  CHAR (03) NOT NULL ,
  numoper  NUMERIC (10,0) NOT NULL ,
  nominal  NUMERIC (19,4) NOT NULL ,
  tasest  NUMERIC (09,4) NOT NULL ,
  tirventa NUMERIC (09,4) NOT NULL ,
  monemi  NUMERIC (03,0) NOT NULL ,
  serie  CHAR (12) NOT NULL ,
  cod_ser  NUMERIC (05,0) NOT NULL ,
  vptirc  NUMERIC (19,4) NULL  ,
  interesc NUMERIC (19,4) NULL  ,
  reajustec NUMERIC (19,4) NULL  ,
  valcomu  NUMERIC (19,4) NULL  ,
  valcomp  NUMERIC (19,4) NULL  ,
  nominalp NUMERIC (19,0) NULL  ,
  fecinip  DATETIME NULL  ,
  fecvenp  DATETIME NULL  ,
  valinip  NUMERIC (19,4) NULL  ,
  valvenp  NUMERIC (19,4) NULL  ,
  intpact  FLOAT   NULL  ,
  reapact  FLOAT   NULL  ,
  baspact  INTEGER  NULL  ,
  monpact  INTEGER  NULL  ,
  rutcli  NUMERIC (10,0) NULL  ,
  codcli  NUMERIC (10,0) NULL  ,
  registro INTEGER IDENTITY(1,1) PRIMARY KEY NOT NULL,
  valpacto FLOAT  NULL  ,
  taspacto FLOAT  NULL,

--ITAU------------------------------------------
		ValorCont		NUMERIC (19,04) NULL,		
		ForpagoIo		INTEGER		NULL,
		ForpagoVo		INTEGER		NULL,
		valtasemi  		NUMERIC(09,0)	NULL,
		mtoadif    		NUMERIC(09,0)	NULL,
	   	CapitalTasEmi  	NUMERIC(09,0)	NULL,
	   	InteresTasEmi  	NUMERIC(09,0)	NULL,
	   	ReajustTasEmi  	NUMERIC(09,0)	NULL
--ITAU------------------------------------------
  )  
 
 INSERT INTO #TEMP
	(	numdocu,				--> 01
		correla,
		tipoper,
		numoper,
		nominal,
		tasest,
		tirventa,
		monemi,
		serie,
		cod_ser,				-->	10
		vptirc,
		interesc,
		reajustec,
		valcomu,
		valcomp,
		nominalp,
		fecinip,
		fecvenp,
		valinip,
		valvenp,				-->	20
		intpact,
		reapact,
		baspact,
		monpact,
		rutcli,
		codcli,
		valpacto,
		taspacto,
		ValorCont,		
		ForpagoIo,				--> 30
		ForpagoVo,
		valtasemi,
		mtoadif,
		CapitalTasEmi,
		InteresTasEmi,
		ReajustTasEmi			-->	36
	)
	SELECT	vinumdocu			,	-->	numdocu
			vicorrela			,	-->	correla
			vitipoper			,	-->	tipoper
			vinumoper			,	-->	numoper
			vinominal			,	-->	nominal
			vitasest			,	-->	tasest
			vitirvent			,	-->	tirventa
			vimonemi			,	-->	monemi
			viinstser			,	-->	serie
			0					,	-->	cod_ser
			vivptirc			,	-->	vptirc
			viinteresv			,	-->	interesc
			vireajustv			,	-->	reajustec
			vivalcomu			,	-->	valcomu	
			vivalcomp			,	-->	valcomp
			vinominalp			,	-->	nominalp
			vifecinip			,	-->	fecinip
			vifecvenp			,	-->	fecvenp
			vivalinip			,	-->	valinip
			vivalvenp			,	-->	valvenp
			viinteresvi			,	-->	intpact
			vireajustvi			,	-->	reapact
			vibaspact			,	-->	baspact
			vimonpact			,	-->	monpact
			virutcli			,	-->	rutcli
			vicodcli			,	-->	codcli
			vivptirvi			,	-->	valpacto
			vitaspact			,	-->	taspacto
		--ITAU------------------
			valor_contable		,	-->	ValorCont
			viforpagi			,	-->	ForpagoIo
			viforpagv			,	-->	ForpagoVo
			vivptasemi			,	-->	valtasemi
			vimtoadif			,	-->	mtoadif
			Capital_Tasa_Emi	,	-->	CapitalTasEmi
			Intereses_Tasa_Emi	,	-->	InteresTasEmi
			Reajustes_Tasa_Emi		-->	ReajustTasEmi
		--ITAU------------------

 FROM MDVI
 WHERE virutcart=@nrutcart AND vinumoper=@nnumoper

 UPDATE #TEMP 
 SET cod_ser = cpcodigo
 FROM MDCP, #TEMP
 WHERE tipoper='CP' AND cpnumdocu=numdocu AND cpcorrela=correla

 UPDATE #TEMP
 SET cod_ser = cicodigo
 FROM MDCI, #TEMP
 WHERE tipoper='CI' AND cinumdocu=numdocu AND cicorrela=correla

 SELECT @dfeccal = acfecproc FROM MDAC

 BEGIN TRANSACTION

 DELETE mdmo where monumoper = @nnumoper

 WHILE @x=1
 BEGIN
  SELECT @ctipoper='*' 
  SET ROWCOUNT 1 
 
  SELECT  @numdocu = numdocu   ,
   @correla = correla   ,
   @ctipoper = ISNULL(tipoper,'*')  ,
   @ftasest = tasest   ,
   @fnominal = nominal   ,
   @ftir  = tirventa   ,
   @codmon  = monemi   ,
   @serie  = serie    ,
   @cod_ser = cod_ser   ,
   @vptirc = vptirc   ,
   @interesc = interesc   ,
   @reajustec = reajustec   ,
   @valcomu = valcomu   ,
   @valcomp = valcomp   ,
   @nnominalp = ISNULL(nominalp,0),
   @nvalinipo = valinip   ,
   @nvalvenp = valvenp   ,
   @dfecinip = fecinip   ,
   @dfecvenp = fecvenp   ,
   @nintpacdv = intpact   ,
   @freapacdv = reapact    ,
   @nbaspacto = baspact   ,
   @nTaspactoO = taspacto   ,
   @nmonpact = monpact   ,
   @nrutcli = rutcli   ,
   @ncodcli = codcli   ,
   @suma  = registro   ,
   @nvalpacto = valpacto,

--ITAU------------------------------------------
			@nValcont 	= ValorCont			,
			@nForPagIo	= ForpagoIo			,
			@nForPagVo	= ForpagoVo			,
		   	@nValTasEmi	= valtasemi			,
		   	@nMtoaDif	= mtoadif			,
		   	@nCaptTasEm	= CapitalTasEmi			,
		   	@nintTasEm	= InteresTasEmi			,
		   	@nReajTasEm	= ReajustTasEmi	
--ITAU------------------------------------------

  FROM #TEMP
  WHERE registro>@suma
  SET ROWCOUNT 0 

  IF @ctipoper='*'
   BREAK

  SELECT @mdse = inmdse FROM VIEW_INSTRUMENTO WHERE incodigo=@cod_ser
  SELECT @nvalmoni = 1.0 ,
   @nvalmonv = 1.0

  IF @nmonpact<>999 AND @nmonpact <> 13
  BEGIN
   SELECT @nvalmoni = ISNULL(vmvalor,0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonpact AND vmfecha=@dfecinip
   SELECT @nvalmonv = ISNULL(vmvalor,0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonpact AND vmfecha=@dfeccal
  END

  IF @nmonpact= 13
  BEGIN
   SELECT @nvalmoni = ISNULL(vmvalor,0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=@dfecinip
   SELECT @nvalmonv = ISNULL(vmvalor,0) FROM VIEW_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=@dfeccal
  END

  SELECT  @nvalorant  = ROUND(@nvalvenp, 4)
  SELECT @nvalorant = ROUND(@nValvenp/(((@nTasapacto/(@nBaspacto*100.0))*DATEDIFF(DAY,@dFeccal,@dFecvenp))+1.0),0)
  SELECT @nIntpac = ROUND(@nValvenp/(((@nTasapacto/(@nBaspacto*100.0))*DATEDIFF(DAY,@dFeccal,@dFecvenp))+1.0)*@nValmonV,0)-@nValinipO
--  SELECT  @nvalinipo  = ROUND(@nvalorant*@nvalmonv, 0)
  SELECT  @nvalinipo = ROUND(@nvalorant*@nvalmonv, 0) --@nvalinipo+@nIntpac+@freapacdv
  SELECT  @nvalvtopo = ROUND(@nvalorant*@nvalmonv, 0) --@nvalinipo+@nIntpac+@freapacdv
  SELECT @nvalpacto = ROUND(@nvalorant*@nvalmonv, 0) --@nvalorant

  IF @nvalpacto<@nvalinipo
   SELECT @ndifneg = @nvalinipo - @nvalpacto
  ELSE
   SELECT @ndifpos = @nvalpacto - @nvalinipo

  IF  @mdse='S'
   SELECT @monemi = semonemi ,
    @tasemi = SETasemi ,
    @basemi = sebasemi ,
    @rutemi = serutemi
   FROM VIEW_SERIE
   WHERE secodigo=@cod_ser
  ELSE
   SELECT @monemi = nsmonemi ,
    @tasemi = nstasemi ,
    @basemi = nsbasemi ,
    @rutemi = nsrutemi
   FROM VIEW_NOSERIE
   WHERE   nsrutcart=@nrutcart AND nsnumdocu=@numdocu AND nscorrela=@correla AND nscodigo=@cod_ser

  SELECT @tasemi = ISNULL(@tasemi,0)

  IF @ctipoper='CP'
  BEGIN
   UPDATE MDCP
   SET cpnominal = cpnominal  + @fnominal  ,
    cpvptirc = cpvptirc   + @vptirc   ,  --  valor presente
    cpinteresc = cpinteresc + @interesc  ,  --  intereses acumulados
    cpreajustc = cpreajustc + @reajustec  ,  --  reajustes acumulados
    cpvalcomu = cpvalcomu  + ISNULL(@valcomu,0.0) , 
    cpcapitalc = cpvalcomp  + ISNULL(@valcomp,0.0) ,
    cpvalcomp = cpvalcomp  + ISNULL(@valcomp,0.0),

--ITAU------------------------------------------
		valor_contable  = valor_contable + isnull(@nValcont,0.0),
		cpvptasemi	= cpvptasemi + @nValTasEmi		,
		Valor_a_Diferir = Valor_a_Diferir + @nMtoaDif		,
	    Capital_Tasa_Emi = Capital_Tasa_Emi + @nCaptTasEm	,
		Intereses_Tasa_Emi = Intereses_Tasa_Emi + @nintTasEm	,
		Reajustes_Tasa_Emi = Reajustes_Tasa_Emi + @nReajTasEm
--ITAU------------------------------------------

   WHERE cpnumdocu=@numdocu AND cpcorrela=@correla

   IF @@error<>0
   BEGIN
    SET NOCOUNT OFF
    ROLLBACK TRANSACTION
    SELECT 0, 'Problemas en Actualizacion de tabla de Compras Propias, Comunique al Administrador ' 
    RETURN 1
   END   

   UPDATE MDDI
   SET dinominal = dinominal  + @fnominal  ,
    divptirc = divptirc   + @vptirc   ,
    dicapitalc  = dicapitalc + ISNULL(@valcomp,0.0) ,
    diinteresc  = diinteresc + @interesc  ,
   direajustc  = direajustc + @reajustec,

--ITAU------------------------------------------
		valor_contable  = valor_contable + isnull(@nValcont,0.0)
--ITAU------------------------------------------

WHERE dinumdocu=@numdocu AND dicorrela=@correla AND ditipoper='CP'

   IF @@error<>0
   BEGIN
    SET NOCOUNT OFF
    SELECT 0, 'Problemas en actualizacion de tabla de compras propias, comunique al administrador ' 
    ROLLBACK TRANSACTION
    RETURN 1
   END   
  
   INSERT INTO
   MDMO
    (
    mofecpro  ,
    morutcart  ,
    motipcart  ,
    monumdocu  ,
    mocorrela  ,
    monumdocuo  ,
    mocorrelao  ,
    monumoper  ,
    motipoper  ,
    motipopero  ,
    moinstser  ,
    momascara  ,
    mocodigo  ,
    moseriado  ,
    mofecemi  ,
    mofecven  ,
    momonemi  ,
    motasemi  ,
    mobasemi  ,
    morutemi  ,
    monominal  ,
    movpresen  ,
    momtps   ,
    momtum   ,
    momtum100  ,
    monumucup  ,
    motir   ,
    mopvp   ,
    movpar   ,
    motasest  ,
    mofecinip  ,
    mofecvenp  ,
    movalinip  ,
    movalvenp  ,
    motaspact  ,
     mobaspact  ,
    momonpact  ,
    moforpagi  ,
    moforpagv  ,
    motipobono  ,
    mocondpacto  ,
    mopagohoy  ,
    morutcli  ,
    mocodcli  ,
    motipret  ,
    mohora   ,
    mousuario  ,
    moterminal  ,
    mocapitali  , -- Se Ocupan Para Anulaciones 
    mointeresi   , -- Se Ocupan Para Anulaciones 
    moreajusti   ,
    movpreseni   ,
    mocapitalp   ,
    mointeresp   ,
    moreajustp   ,
    movpresenp  ,
    motasant     ,
    mobasant     ,
    movalant     ,
    mostatreg    ,
    movpressb    ,
    modifsb      ,
    monominalp   ,
    movalcomp    ,
    movalcomu    ,
    mointeres    ,
    moreajuste   ,
    mointpac     ,
    moreapac     ,
    moutilidad   ,
    moperdida    ,
    movalven     ,
    mocorvent    ,
    id_libro     ,
    moTirTran	 ,
    moVPTran	 ,
    moDifTran_MO ,	
    moDifTran_CLP,

--ITAU------------------------------------------
		sub_forma_venc,
		Ejecutivo,
		Movptasemi,
		MoMtoDif,
		Capital_Tasa_Emi,
		Intereses_Tasa_Emi,
		Reajustes_Tasa_Emi,
		moTasCFdo

--ITAU------------------------------------------

    )
   SELECT
    @dfeccal  ,
    virutcart  ,
    cptipcart  ,
    vinumdocu  ,
    vicorrela  ,
    vinumdocu  ,
    vicorrela  ,
    vinumoper  ,
    'RCA'   ,
    'CP'   ,
    viinstser  ,
    cpmascara  ,
    cpcodigo  ,
    cpseriado  ,
    cpfecemi  ,
    cpfecven  ,
    @monemi   ,
    @tasemi   ,
    @basemi   ,
    @rutemi   ,
    vinominal  ,
    @vptirc   ,
    @vptirc   ,
    0   ,
    0   ,
    cpnumucup  ,
    @fTir   ,
    0   ,
    0   , 
    @ftasest  ,
    vifecinip  ,
    ISNULL(vifecvenp,0) ,
    vivalinip  ,
    @nvalvtopo   ,
    vitaspact  ,
    vibaspact  ,
    vimonpact  ,
    viforpagi  ,
    @forpav   ,
    ''   ,
    ''   ,
    ''   ,
    virutcli  ,
    vicodcli  ,
    ''   ,
    CONVERT(CHAR(15),GETDATE(),108),
    @cuser   ,
    @cterminal  ,
    vivalinip  ,
    viinteresvi  ,
    0   ,
    0   ,
    vivalinip  ,
    (@nvalant - vivalinip ),
    0   ,
    0   ,
    @ntasapacto  ,-- tasa pacto antigua    motasant 
    vibaspact  ,
    @nvalvtopo  ,
    ' '   ,
    0   ,
    0            ,
    vinominalp   ,
    vivalcomp    ,
    vivalcomu    ,
    viinteresv   ,  -- intereses del papel
    vireajustv   ,  -- reajustes del papel
    @nintpac     ,
    vireajustvi  ,
    @ndifpos     ,
    @ndifneg     ,
    @nvalvtopo   ,
    @suma        ,
    MDVI.id_libro,
    @nTirTran	 ,
    @nVpTran	 ,
    @DifTran	 ,
    @DifTranCLP,

--ITAU------------------------------------------
				@subfpago,
				@nEjecutivo,
			   	vivptasemi,
			   	vimtoadif,
			   	MDVI.Capital_Tasa_Emi,
			   	MDVI.Intereses_Tasa_Emi,
			   	MDVI.Reajustes_Tasa_Emi,
				viTasCFdo
--ITAU------------------------------------------

   FROM MDCP, MDVI
   WHERE cpnumdocu=@numdocu 
   AND   cpcorrela=@correla 
   AND   vinumdocu=@numdocu 
   AND   vicorrela=@correla 
   AND   vinumoper=@nnumoper 
   AND   virutcart=@nrutcart

   IF @@error<>0
   BEGIN
    SET NOCOUNT OFF
    ROLLBACK TRANSACTION
    SELECT 0, 'Problemas en Grabaci¢n de Operaci¢n en Tabla de Movimiento'
    RETURN 1
   END

   UPDATE MDCO
   SET cocantcortd = cocantcortd + cvcantcort
   FROM MDCV
   WHERE conumdocu=@numdocu AND cocorrela=@correla AND cvnumdocu=@numdocu AND cvcorrela=@correla AND
    cvnumoper=@nnumoper AND comtocort=mdcv.cvmtocort

   IF @@error<>0
   BEGIN
    SET NOCOUNT OFF
    ROLLBACK TRANSACTION
    SELECT 0, 'Problemas en grabaci¢n de recompra anticipada en actualizacion de tabla de cortes '
    RETURN
   END  

  END
  ELSE
  BEGIN
   UPDATE MDDI 
   SET dinominal = dinominal + @fnominal  ,
   divptirc = divptirc + @vptirc,

--ITAU------------------------------------------
		valor_contable  = valor_contable + isnull(@nValcont,0.0)
--ITAU------------------------------------------
   WHERE dinumdocu=@numdocu AND dicorrela=@correla AND ditipoper='CI'

   IF @@error<>0
   BEGIN
    SET NOCOUNT OFF
    ROLLBACK TRANSACTION
    SELECT 0, 'Problemas en grabaci¢n de recompra anticipada en acutalizaci¢n de tabla de compras con pacto' 
    RETURN
   END   

   INSERT INTO 
   MDMO
    (
    mofecpro ,
    morutcart ,
    motipcart ,
    monumdocu ,
    mocorrela ,
    monumdocuo ,
    mocorrelao ,
    monumoper ,
    motipoper ,
    motipopero ,
    moinstser ,
    momascara ,
    mocodigo ,
    moseriado ,
    mofecemi ,
    mofecven ,
    momonemi ,
    motasemi ,
    mobasemi ,
    morutemi ,
    monominal ,
    movpresen ,
    momtps  ,
    momtum  ,
    momtum100 ,
    monumucup ,
    motir  ,
    mopvp  ,
    movpar  ,
    motasest ,
    mofecinip ,
    mofecvenp ,--32
    movalinip ,
    movalvenp ,
    motaspact ,
    mobaspact ,
    momonpact ,
    moforpagi ,
    moforpagv ,
    motipobono ,
    mocondpacto ,
    mopagohoy ,
     morutcli ,
    mocodcli ,
    motipret ,
    mohora  ,
    mousuario ,
    moterminal ,
    mocapitali , -- Se Ocupan Para Anulaciones 
    mointeresi , -- Se Ocupan Para Anulaciones
    moreajusti ,
    movpreseni ,
    mocapitalp ,
    mointeresp ,
    moreajustp ,
    movpresenp ,
    motasant ,
    mobasant ,
    movalant ,
    mostatreg ,
    movpressb ,
    modifsb  ,
    monominalp ,
    movalcomp ,
    movalcomu ,
    mointeres ,
     moreajuste  ,
    mointpac     ,
    moreapac     ,
    moutilidad   ,
    moperdida    ,
    movalven     ,
    mocorvent    ,
    id_libro     ,
    moTirTran	 ,
    moVPTran	 ,
    moDifTran_MO ,	
    moDifTran_CLP,

--ITAU------------------------------------------
	   sub_forma_venc  , --74,
	   moTasCFdo
--ITAU------------------------------------------
    )
   SELECT
    @dfeccal    ,
    virutcart    ,
    citipcart    ,--
    vinumdocu    ,
    vicorrela    ,
    vinumdocu    ,
    vicorrela    ,
    vinumoper    ,
    'RCA'     ,
    'CI'     ,
    viinstser    ,
    cimascara    ,
    cicodigo    ,
    ciseriado    ,
    cifecemi    ,
    cifecven    ,
    @monemi     ,
    @tasemi     ,
    @basemi     ,
    @rutemi     ,
    vinominal    ,
    @vptirc     ,
    @vptirc     ,
    0     ,
    0     ,
    cinumucup    ,
    @ftir     ,
    0     ,
    0     ,
    @ftasest    ,
    vifecinip    ,
    ISNULL(vifecvenp,0)   ,--32--antes sin ISNULL
    vivalinip    ,
    @nvalvtopo    ,
    @ntasapacto    ,  -- tasa de pacto antuiguo @ntasapacto
    vibaspact    ,
    vimonpact    ,
    viforpagi    ,
     @forpav     ,
    ''     ,
    ''     ,
    ''     ,
    virutcli    ,
    vicodcli    , 
    ''     ,
    convert( CHAR(15), getdate(), 108) ,
    @cuser     ,
    @cterminal    ,
    vivalvenp    ,
    viinteresvi    ,
    0     ,
    0     ,
    vivalinip    ,
    (@nvalant - vivalinip )   ,
    0     ,
    0     ,
    vitaspact    ,
    vibaspact    ,
    @nvalant    ,
    ''     ,
    0     ,
    0     ,
    vinominalp    ,
    vivalcomp     ,
    vivalcomu     ,
    viinteresv    ,
    vireajustv    ,
    @nintpac      ,
    vireajustvi   ,
    @ndifpos      ,
    @ndifneg      ,
    @nvalvtopo    ,
    @suma         ,
    MDVI.id_libro ,
    @nTirTran	  ,
    @nVpTran	  ,
    @DifTran	  ,
    @DifTranCLP,

--ITAU------------------------------------------
				@subfpago,
				viTasCFdo
--ITAU------------------------------------------
   FROM MDCI, MDVI
   WHERE  cinumdocu=@numdocu AND cicorrela=@correla AND vinumdocu=@numdocu AND vicorrela=@correla AND
    vinumoper=@nnumoper AND virutcart=@nrutcart
   
   IF @@error<>0
   BEGIN
                                SET NOCOUNT OFF
    ROLLBACK TRANSACTION
    SELECT 0, 'Problemas en grabaci¢n de recompra anticipada en actualizaci¢n de movimiento <ci> '
    RETURN
   END
   UPDATE MDCI 
   SET cinominalp = cinominalp + @nnominalp,

--ITAU------------------------------------------
		valor_contable  = valor_contable + ISNULL(@nValcont,0.0)
--ITAU------------------------------------------

   WHERE cinumdocu=@numdocu AND cicorrela=@correla
   IF @@error<>0
   BEGIN
                                SET NOCOUNT OFF
    ROLLBACK TRANSACTION
    SELECT 0, 'Problemas en grabaci¢n de recompra anticipada en actualizaci¢n de tabla de compras con pacto'
    RETURN
   END
   UPDATE MDCO 
   SET cocantcortd = cocantcortd + mdcv.cvcantcort
   FROM MDCV
   WHERE conumdocu=@numdocu AND cocorrela=@correla AND cvnumdocu=@numdocu AND cvcorrela=@correla AND
    cvnumoper=@nnumoper AND comtocort=cvmtocort
   IF @@error<>0
   BEGIN
    SET NOCOUNT OFF
    ROLLBACK TRANSACTION
    SELECT 0, 'Problemas en Grabacion de Recompra Anticipada en Actualizacion Tabla de Cortes <ci>'
    RETURN
   END
  END
  CONTINUE
 END

 INSERT INTO MDANT_VI
 SELECT *
 FROM  MDVI
 WHERE vinumoper=@nnumoper
 AND virutcart=@nrutcart

 DELETE FROM MDVI WHERE vinumoper=@nnumoper AND virutcart=@nrutcart
 IF @@error<>0
 BEGIN
                SET NOCOUNT OFF
  ROLLBACK TRANSACTION
  SELECT 0, 'Problemas en grabaci¢n de recompra anticipada en actualizaci¢n de tabla de ventas con pacto, <baja de venta con pacto>'
  RETURN
 END
 SELECT @cforpago = CONVERT(CHAR(4),@forpav)
 SET NOCOUNT OFF
 COMMIT TRANSACTION

 SELECT @nnumoper,'Operacion de Recompra Anticipada finalizada con exito'
END


GO
