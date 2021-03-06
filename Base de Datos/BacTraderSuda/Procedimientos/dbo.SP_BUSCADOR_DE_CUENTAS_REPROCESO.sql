USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCADOR_DE_CUENTAS_REPROCESO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BUSCADOR_DE_CUENTAS_REPROCESO]
AS
BEGIN

        SET NOCOUNT ON

	-- MAP 20070111	Cartera intermediada propia debe contabilizarse como CP en su Mov y Dev 	

	/*==================================================================================================================*/
	DECLARE @rut_estado   NUMERIC(09)
	,	@rut_central  NUMERIC(09)

	/*==================================================================================================================*/
	SELECT	@rut_estado  = 97030000
	,	@rut_central = 97029000
	
	/*==================================================================================================================*/
	CREATE TABLE #TMPCARTERA
	(	Sistema        CHAR(03) ,
		t_movimiento   CHAR(03) ,
		t_operacion    CHAR(04) ,
		RutCartera     NUMERIC(09) ,
		NumDocu        NUMERIC(10) ,
		Correla        NUMERIC(03) ,
		NumOper        NUMERIC(10) ,
		CodigoInst     NUMERIC(05) ,
		Instrumento    VARCHAR(12) ,
		Mascara        VARCHAR(12) ,
		InstSer        VARCHAR(12) ,
		Moneda         NUMERIC(03) ,
		CMoneda        CHAR(03) ,
		Nominal        NUMERIC(19,04),
		Monto          NUMERIC(19,04),
		Variable       VARCHAR(30) ,
		Seriado        CHAR(01) ,
		CtaContable    CHAR(20) ,
		FolPerfil      NUMERIC(05) ,          ---  19 
		CorPerfil      NUMERIC(05) ,          ---  20
		CodigoVariable VARCHAR(30) ,          ---  21
		Fijo           CHAR(01) ,             ---  22
		CampoVariable  NUMERIC(05) ,
		RutCliente     NUMERIC(09) ,
		CodigoCliente  NUMERIC(09) ,
		RutEmisor      NUMERIC(09) ,
		tipobono       CHAR(01) ,
		ForPagI        NUMERIC(04) ,
		ForPagV        NUMERIC(04) ,
		TipoLinea      CHAR(01) ,
		TipoLetra      CHAR(01) ,
		FechaInip      DATETIME ,
		FechaVtop      DATETIME ,
		tipopero       CHAR(03) 
	,	EstObj		CHAR(05)
	)

	/*==================================================================================================================*/
	DELETE CARTERA_CUENTA_REPROCESO

	/*==================================================================================================================*/
	/* Tasa Mercado()                                                                                     */
	/*==================================================================================================================*/

        DECLARE @feriado          NUMERIC (01)
        DECLARE @feriadoIniMes    NUMERIC (01)
        DECLARE @dfecfmes         DATETIME
        DECLARE @dfecImes         DATETIME
        DECLARE @Fecha_Hoy        DATETIME
        DECLARE @Fecha_prox       DATETIME

        SELECT @Fecha_Hoy =acfecproc,
               @Fecha_prox =acfecprox
        FROM   MDAC0630

        SELECT @dfecfmes = DATEADD(DAY,DATEPART(DAY,@Fecha_prox) * -1,@Fecha_prox)   

        SELECT @dfecImes = DATEADD(DAY,DATEPART(DAY,@Fecha_Hoy)* -1,DATEADD(DAY, 1, @Fecha_Hoy))         
 
        EXECUTE SP_FERIADO @dfecfmes,6 , @feriado output
        EXECUTE SP_FERIADO @dfecImes,6 , @feriadoIniMes output

	/*************************************************************************************************************/
	/***************************** FECHA DE BUSQUEDA DE VALORIZACION DE MERCADO **********************************/
	/*************************************************************************************************************/
	DECLARE @FechaBusquedaValorizacion	DATETIME

	IF DATEPART(MONTH,@fecha_hoy) <> DATEPART(MONTH,@Fecha_Prox) BEGIN
		SELECT	@FechaBusquedaValorizacion = DATEADD(DAY,-1,SUBSTRING(CONVERT(CHAR(8),@Fecha_Prox,112),1,6) + '01') --FIN DE MES (ACTUAL) HABIL O NO HABIL
	END
	ELSE BEGIN
		SELECT	@FechaBusquedaValorizacion = @fecha_hoy --FECHA HOY
	END

	/*************************************************************************************************************/
	/*************************************************************************************************************/
	/*************************************************************************************************************/
	INSERT INTO #TMPCARTERA
	SELECT	'BTR'
	,	'TMF'
	,	'TMCP'
	,	rmrutcart
	,	rmnumdocu
	,	rmcorrela
	,	rmnumdocu
	,	rmcodigo
	,	inserie
	,	tmmascara
	,	rminstser
	,	CONVERT( NUMERIC(03), 0 )
	,	CONVERT( CHAR(03), '' )
	,	valor_nominal
	,	(diferencia_mercado * CASE WHEN (PorcjeCob /100) = 0 THEN 1 ELSE (PorcjeCob /100)END) --CONVERT( FLOAT, diferencia_mercado )
	,	CASE	WHEN  diferencia_mercado >=0 THEN CONVERT( VARCHAR(30), 'dif_valor_mercado_pos' )
			ELSE CONVERT( VARCHAR(30), 'dif_valor_mercado_neg' ) END 
	,	tmseriado
	,	CONVERT( CHAR(20), '' )
	,	CONVERT( NUMERIC(05), 0 )
	,	CONVERT( NUMERIC(05), 0 )
	,	0 -- tipo cartera
	,	'N'	
	,	CONVERT( NUMERIC(05), 0 )
	,	rut_emisor  -- CONSULTAR
	,	(SELECT emcodigo FROM VIEW_EMISOR WHERE emrut =rut_emisor) 
	,	CONVERT( NUMERIC(09), 0 )
	,	'1'	 -- Falta de Donde sacar el Tipo Bono (motipobono)
	,	0
	,	0
	,	CASE	WHEN  diferencia_mercado >=0 THEN 'D' 
			ELSE 'H' END 
	,	''
	,	tmfecemi
	,	tmfecven
	,	''
	,	CASE WHEN PorcjeCob <> 0. THEN 'CBTO' ELSE 'DCBTO' END
	FROM --  REQ. 7619
        VALORIZACION_MERCADO RIGHT OUTER JOIN VIEW_EMISOR ON emrut = rut_emisor
	,	VIEW_INSTRUMENTO 
--  REQ. 7619
-- 	,	VIEW_EMISOR
	WHERE	fecha_valorizacion	= @FechaBusquedaValorizacion --@dfecfmes	
	AND	tipo_operacion		= 'CP'
	AND	valor_nominal		>  0.0 
	AND	incodigo		= rmcodigo
--  REQ. 7619
--	AND	emrut			=* rut_emisor

	INSERT	INTO #TMPCARTERA
	SELECT	A.Sistema         
	,	A.t_movimiento    
	,	A.t_operacion     
	,	A.RutCartera      
	,	A.NumDocu         
	,	A.Correla         
	,	A.NumOper         
	,	A.CodigoInst      
	,	A.Instrumento     
	,	A.Mascara         
	,	A.InstSer         
	,	A.Moneda          
	,	A.CMoneda         
	,	A.Nominal         
	,	B.diferencia_mercado - A.Monto           
	,	A.Variable        
	,	A.Seriado         
	,	A.CtaContable     
	,	A.FolPerfil       
	,	A.CorPerfil       
	,	A.CodigoVariable  
	,	A.Fijo            
	,	A.CampoVariable   
	,	A.RutCliente      
	,	A.CodigoCliente   
	,	A.RutEmisor       
	,	A.tipobono        
	,	A.ForPagI         
	,	A.ForPagV         
	,	A.TipoLinea       
	,	A.TipoLetra       
	,	A.FechaInip       
	,	A.FechaVtop       
	,	A.tipopero        
	,	'DCBTO'
	FROM	#TMPCARTERA		A
	,	VALORIZACION_MERCADO	B
	WHERE	A.EstObj		= 'CBTO'
	AND	B.fecha_valorizacion	= @FechaBusquedaValorizacion
	AND	B.rmnumdocu		= A.NumDocu
	AND	B.rmnumoper		= A.NumOper       
	AND	B.rmcorrela		= A.Correla         
	
	/*******************************************INTERMEDIACION********************************************/
	/*******************************************TASA MERCADO**********************************************/
	INSERT	INTO #TMPCARTERA
	SELECT	'BTR',
		'TMF',
		'TMCP'	,	--'TMVI',
		rmrutcart,
		rmnumdocu,
		rmcorrela,
		rmnumdocu,
		rmcodigo,
		inserie,
		tmmascara,
		rminstser,
		CONVERT( NUMERIC(03), 0 ),
		CONVERT( CHAR(03), '' ),
		valor_nominal,
		CONVERT( FLOAT, diferencia_mercado ),
		CASE	WHEN  diferencia_mercado >=0 THEN CONVERT( VARCHAR(30), 'dif_valor_mercado_pos' )
			ELSE CONVERT( VARCHAR(30), 'dif_valor_mercado_neg' ) END ,
		tmseriado,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0	, -- Tipo Mercado
		'N' ,
		CONVERT( NUMERIC(05), 0 ),
		rut_emisor,  -- CONSULTAR
		(SELECT emcodigo FROM VIEW_EMISOR WHERE emrut =rut_emisor) ,
		CONVERT( NUMERIC(09), 0 ),
		'1', -- Falta de Donde sacar el Tipo Bono (motipobono)
		0,
		0,
		CASE	WHEN  diferencia_mercado >= 0 THEN 'D' 
			ELSE 'H' END ,  
		'',
		tmfecemi,
		tmfecven,
		''
	,	'DCBTO'
	FROM  --  REQ. 7619	
        VALORIZACION_MERCADO RIGHT OUTER JOIN  VIEW_EMISOR ON emrut	= rut_emisor
	,	VIEW_INSTRUMENTO
--  REQ. 7619	
--	,	VIEW_EMISOR
	WHERE	fecha_valorizacion	=  @FechaBusquedaValorizacion --@dfecfmes
	AND	tipo_operacion		=  'VI'
	AND	valor_nominal		>  0.0 
	AND	incodigo		=  rmcodigo
--  REQ. 7619	
--	AND	emrut			=* rut_emisor

	/*==================================================================================================================*/
	/* Compra Propia (Valor compra)               */
	/*==================================================================================================================*/
	INSERT INTO #TMPCARTERA
	SELECT	'BTR',
		'MOV',
		'CP  ',
		cprutcart,
		cpnumdocu,
		cpcorrela,
		cpnumdocu,
		cpcodigo,
		inserie,
		cpmascara,
		cpinstser,
		CONVERT( NUMERIC(03), 0 ),
		CONVERT( CHAR(03), '' ),
		cpnominal,
		CONVERT( FLOAT, cpvalcomp ),
		CASE WHEN cpcodigo=20 AND (digenemi = 'BCO' OR digenemi = 'COR') THEN CONVERT( VARCHAR(30), 'valor_tasa_emision' )
		ELSE CONVERT( VARCHAR(30), 'valor_compra' ) END,
		cpseriado,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0, -- Tipo Catera // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		cprutcli,
		cpcodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1', -- Falta de Donde sacar el Tipo Bono (motipobono)
		0,
		0,
		'D',
		cptipoletra,
		cpfecemi,
		cpfecven,
		''
	,	''
	FROM	MDCP0630
	,	VIEW_INSTRUMENTO
	,	MDDI0630
	WHERE	cpcodigo	= incodigo
	AND	cpnominal	> 0.0
	AND	cpnumdocu	= dinumdocu
	AND	cpcorrela	= dicorrela

	/*==================================================================================================================*/
	/* Compra Propia (Intereses Acumulados)                                                                             */
	/*==================================================================================================================*/
	INSERT INTO #TMPCARTERA
	SELECT	'BTR',
		'DEV',
		'DVCP',
		cprutcart,
		cpnumdocu,
		cpcorrela,
		cpnumdocu,
		cpcodigo,
		inserie,
		cpmascara,
		cpinstser,
		CONVERT( NUMERIC(03), 0 ),
		CONVERT( CHAR(03), '' ),
		cpnominal,
		CONVERT( FLOAT, cpinteresc ),
		'Interes_papel',
		cpseriado,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0, --Tipo Cartera // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		cprutcli,
		cpcodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1',  -- Falta de Donde sacar el Tipo Bono (motipobono)
		0,
		0,
		'D',--'H' antes Haber ahora D, a pedido de P.Rojas, M.Alcayaga, S.MaluENDa.
		cptipoletra,
		cpfecemi,
		cpfecven,
		''
	,	''
	FROM	MDCP0630
	,	VIEW_INSTRUMENTO
	WHERE	cpcodigo	= incodigo    
	AND	cpnominal	> 0.0

	/*==================================================================================================================*/
	/* Compra Propia (Reajustes Acumulados)                                                                             */
	/*==================================================================================================================*/
	INSERT	INTO #TMPCARTERA
	SELECT	'BTR',
		'DEV',
		'DVCP',
		cprutcart,
		cpnumdocu,
		cpcorrela,
		cpnumdocu,
		cpcodigo,
		inserie,
		cpmascara,
		cpinstser,
		CONVERT( NUMERIC(03), 0 ),
		CONVERT( CHAR(03), '' ),
		cpnominal,
		CONVERT( FLOAT, cpreajustc ),
		'Reajuste_papel',
		cpseriado,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0, -- Tipo Cartera  // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		cprutcli,
		cpcodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1',  -- Falta de Donde sacar el Tipo Bono (motipobono)
		0,
		0,
		'D',-- 'D',
		cptipoletra,
		cpfecemi,
		cpfecven,
		''
	,	''
	FROM	MDCP0630
	,	VIEW_INSTRUMENTO
	WHERE	cpcodigo	= incodigo   
	AND	cpnominal	> 0.0
	AND	(inmonemi	<> 999		OR inserie = 'BR'  )
			
	/*==================================================================================================================*/
	/* Compra con Pacto (Valor compra)                                                                                  */
	/*==================================================================================================================*/
	INSERT	INTO #TMPCARTERA
	SELECT	'BTR',
		'MOV',
		CASE WHEN ciinstser = 'ICAP' OR ciinstser = 'ICOL' THEN 'CP  ' ELSE 'CI  ' END,
		cirutcart,
		cinumdocu,
		cicorrela,
		cinumdocu,
		cicodigo,
		inserie,
		cimascara,
		ciinstser,
		cimonpact,
		CONVERT( CHAR(03), '' ),
		cinominal,
		CONVERT( FLOAT, civalinip ),--CONVERT( FLOAT, civalcomp ),
		CONVERT( VARCHAR(30), 'valor_compra' ),
		CASE ciseriado WHEN 'n' THEN 'N' WHEN 's' THEN 'S' ELSE ciseriado END,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0 , -- Tipo Cartera // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		cirutcli,
		cicodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1',  -- Falta de Donde sacar el Tipo Bono (motipobono)
		ciforpagi,
		ciforpagv,
		CASE WHEN  ciinstser = 'ICAP' THEN 'H' ELSE 'D' END,
		' ',
		cifecinip,
		cifecvenp,
		''
	,	''
	FROM	MDCI0630
	,	VIEW_INSTRUMENTO
	WHERE	cicodigo	= incodigo    
	AND	cinominal	> 0.0

	/*==================================================================================================================*/
	/* Compra con Pacto (Intereses Acumulados)                                                                          */
	/*==================================================================================================================*/
	INSERT	INTO #TMPCARTERA
	SELECT	'BTR',
		'DEV',
		CASE WHEN ciinstser = 'ICAP' THEN 'DICA' WHEN ciinstser = 'ICOL' THEN 'DICO' ELSE 'DVCI' END,
		cirutcart,
		cinumdocu,
		cicorrela,
		cinumdocu,
		cicodigo,
		inserie,
		cimascara,
		ciinstser,
		cimonpact,
		CONVERT( CHAR(03), '' ),
		cinominal,
		CASE WHEN ciinstser in ( 'ICAP', 'ICOL' ) THEN CONVERT( FLOAT, ciinteresc ) ELSE CONVERT( FLOAT, ciinteresci ) END,
		CASE WHEN ciinstser in ( 'ICAP', 'ICOL' ) OR SUBSTRING(ciinstser,1,3) = 'EST'   THEN 'Interes_papel' ELSE 'Interes_papel' END, 
		CASE ciseriado WHEN 'n' THEN 'N' WHEN 's' THEN 'S' ELSE ciseriado END,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0, -- Tipo Cartera // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		cirutcli,
		cicodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1',  -- Falta de Donde sacar el Tipo Bono (motipobono)
		ciforpagi,
		ciforpagv,
		CASE WHEN  ciinstser ='ICAP'  THEN 'H' ELSE 'D' END,
		'',
		cifecinip,
		cifecvenp,
		''
	,	''
	FROM	MDCI0630
	,	VIEW_INSTRUMENTO
	WHERE	cicodigo	= incodigo    
	AND	cinominal	> 0.0

	/*==================================================================================================================*/
	/* Compra Con Pacto (Reajustes Acumulados)         */
	/*==================================================================================================================*/
	INSERT	INTO #TMPCARTERA
	SELECT	'BTR',
		'DEV',
		CASE WHEN ciinstser = 'ICAP' THEN 'DICA' WHEN ciinstser = 'ICOL' THEN 'DICO' ELSE 'DVCI' END,
		cirutcart,
		cinumdocu,
		cicorrela,
		cinumdocu,
		cicodigo,
		inserie,
		cimascara,
		ciinstser,
		cimonpact,
		CONVERT( CHAR(03), '' ),
		cinominal,
		CASE WHEN ciinstser in ( 'ICAP', 'ICOL' ) THEN CONVERT( FLOAT, cireajustc ) ELSE CONVERT( FLOAT, cireajustci ) END,
		CASE WHEN ciinstser in ( 'ICAP', 'ICOL' )  THEN (CASE WHEN cimonpact = 999 THEN '' ELSE 'Reajuste_papel' END) ELSE (CASE WHEN cimonpact = 999 THEN '' ELSE 'Reajuste_papel' END) END, --OJO 2
		CASE ciseriado WHEN 'n' THEN 'N' WHEN 's' THEN 'S' ELSE ciseriado END,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0, -- Tipo Cartera // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		cirutcli,
		cicodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1',  -- Falta de Donde sacar el Tipo Bono (motipobono)
		ciforpagi,
		ciforpagv,
		CASE WHEN  ciinstser ='ICAP' THEN 'H' ELSE 'D' END,
		'',
		cifecinip,
		cifecvenp,
		''
	,	''
	FROM	MDCI0630
	,	VIEW_INSTRUMENTO
	WHERE	cicodigo	= incodigo   
	AND	cinominal	> 0.0

	/*==================================================================================================================*/
	/* Venta con Pacto (INTERMEDIACION)      */
	/*==================================================================================================================*/
	INSERT	INTO #TMPCARTERA
	SELECT	'BTR',
		'MOV',
		'CP',  -- cambiado por CM, por que no debe buscar en VI si no en CP.
		virutcart,
		vinumdocu,
		vicorrela,
		vinumoper,
		vicodigo,
		inserie,
		vimascara,
		viinstser,
		vimonemi,   --vimonpact  cambiado por CM, por que no debe buscar en VI si no en CP.
		CONVERT( CHAR(03), '' ),
		vinominal,
		CONVERT( FLOAT, vivalcomp ),
		CONVERT( VARCHAR(30), 'valor_compra' ),
		CASE viseriado WHEN 'n' THEN 'N' WHEN 's' THEN 'S' ELSE viseriado END,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0, -- Tipo Cartera // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		virutcli,
		vicodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1',  -- Falta de Donde sacar el Tipo Bono (motipobono)
		viforpagi,
		viforpagv,
		'D',
		' ',
		vifecinip,
		vifecvenp,
		vitipoper
	,	''
	FROM	MDVI0630
	,	VIEW_INSTRUMENTO
	WHERE	vicodigo	= incodigo
	AND	vitipoper	= 'CP'

	/*==================================================================================================================*/
	/* Venta con Pacto (INTERMEDIACION - Intereses Acumulados)                                                          */
	/*==================================================================================================================*/

	INSERT	INTO #TMPCARTERA
	SELECT	'BTR',
		'DEV',
		'DVCP' , --'DVIT', MAP 20070111
		virutcart,
		vinumdocu,
		vicorrela,
		vinumoper,
		vicodigo,
		inserie,
		vimascara,
		viinstser,
		0 ,
		CONVERT( CHAR(03), '' ),
		vinominal,
		CONVERT( FLOAT, viinteresv ),
		'Interes_papel',
		CASE viseriado WHEN 'n' THEN 'N' WHEN 's' THEN 'S' ELSE viseriado END,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0, -- Tipo Cartera // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		virutcli,
		vicodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1',  -- Falta de Donde sacar el Tipo Bono (motipobono)
		viforpagi,
		viforpagv,
		'D',
		'',
		vifecinip,
		vifecvenp,
		vitipoper
	,	''
	FROM	MDVI0630
	,	VIEW_INSTRUMENTO
	WHERE	vicodigo	= incodigo
	AND	vitipoper	= 'CP'

	/*==================================================================================================================*/
	/* Venta Con Pacto (INTERMEDIACION - Reajustes Acumulados)                                                                 */
	/*==================================================================================================================*/
	INSERT	INTO #TMPCARTERA
	SELECT	'BTR',
		'DEV',
		'DVCP', -- 'DVIT', MAP 20060111
		virutcart,
		vinumdocu,
		vicorrela,
		vinumoper,
		vicodigo,
		inserie,
		vimascara,
		viinstser,
		0 ,
		CONVERT( CHAR(03), '' ),
		vinominal,
		CONVERT( FLOAT, vireajustv ),
		'Reajuste_papel',
		CASE viseriado WHEN 'n' THEN 'N' WHEN 's' THEN 'S' ELSE viseriado END,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0, -- Tipo Cartera // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		virutcli,
		vicodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1',  -- Falta de Donde sacar el Tipo Bono (motipobono)
		viforpagi,
		viforpagv,
		'D',
		'',
		vifecinip,
		vifecvenp,
		vitipoper
	,	''
	FROM	MDVI0630
	,	VIEW_INSTRUMENTO
	WHERE	vicodigo	= incodigo
	AND	vitipoper	= 'CP'

	/*==================================================================================================================*/
	/* Venta con Pacto (Valor venta)  */
	/*==================================================================================================================*/
	INSERT	INTO #TMPCARTERA
	SELECT	'BTR',
		'MOV',
		'VI',
		virutcart,
		vinumdocu,
		vicorrela,
		vinumoper,
		vicodigo,
		inserie,
		vimascara,
		viinstser,
		vimonpact,
		CONVERT( CHAR(03), '' ),
		vinominal,
		CONVERT( FLOAT, vivalcomp ),
		CONVERT( VARCHAR(30), 'valor_venta' ),
		CASE viseriado WHEN 'n' THEN 'N' WHEN 's' THEN 'S' ELSE viseriado END,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0, -- Tipo Cartera // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		virutcli,
		vicodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1',  -- Falta de Donde sacar el Tipo Bono (motipobono)
		viforpagi,
		viforpagv,
		'H',
		' ',
		vifecinip,
		vifecvenp,
		vitipoper
	,	''
	FROM	MDVI0630
	,	VIEW_INSTRUMENTO
	WHERE	vicodigo	= incodigo

	/*==================================================================================================================*/
	/* Venta con Pacto (Intereses Acumulados)                                                                           */
	/*==================================================================================================================*/
	INSERT	INTO #TMPCARTERA
	SELECT	'BTR',
		'DEV',
		'DVVI',
		virutcart,
		vinumdocu,
		vicorrela,
		vinumoper,
		vicodigo,
		inserie,
		vimascara,
		viinstser,
		vimonpact,
		CONVERT( CHAR(03), '' ),
		vinominal,
		CONVERT( FLOAT, viinteresv ),
		'Interes_papel' , --'Interes_pacto',
		CASE viseriado WHEN 'n' THEN 'N' WHEN 's' THEN 'S' ELSE viseriado END,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0, -- Tipo Cartera // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		virutcli,
		vicodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1',  -- Falta de Donde sacar el Tipo Bono (motipobono)
		viforpagi,
		viforpagv,
		'H',
		'',
		vifecinip,
		vifecvenp,
		vitipoper
	,	''
	FROM	MDVI0630
	,	VIEW_INSTRUMENTO
	WHERE	vicodigo	= incodigo

	/*==================================================================================================================*/
	/* Venta Con Pacto (Reajustes Acumulados)                                                                           */
	/*==================================================================================================================*/
	INSERT	INTO #TMPCARTERA
	SELECT  'BTR',
		'DEV',
		'DVVI',
		virutcart,
		vinumdocu,
		vicorrela,
		vinumoper,
		vicodigo,
		inserie,
		vimascara,
		viinstser,
		vimonpact,
		CONVERT( CHAR(03), '' ),
		vinominal,
		CONVERT( FLOAT, vireajustv ),
		-- 'Reajuste_papel', --'Reajuste_pacto',
		CASE WHEN vimonpact = 999 THEN '' ELSE 'Reajuste_papel' END,
		CASE viseriado WHEN 'n' THEN 'N' WHEN 's' THEN 'S' ELSE viseriado END,
		CONVERT( CHAR(20), '' ),
		CONVERT( NUMERIC(05), 0 ),
		CONVERT( NUMERIC(05), 0 ),
		0, -- Tipo Cartera // CONVERT( VARCHAR(30), '' ),
		'N',
		CONVERT( NUMERIC(05), 0 ),
		virutcli,
		vicodcli,
		CONVERT( NUMERIC(09), 0 ),
		'1',  -- Falta de Donde sacar el Tipo Bono (motipobono)
		viforpagi,
		viforpagv,
		'H',
		'',
		vifecinip,
		vifecvenp,
		vitipoper
	,	''
	FROM	MDVI0630
	,	VIEW_INSTRUMENTO
	WHERE vicodigo = incodigo

	/*==================================================================================================================*/
	/* Recuperar Moneda de Emisión (Papeles No seriados)                           */
	/*==================================================================================================================*/
	UPDATE	#TMPCARTERA
	SET	Moneda		= nsmonemi
	,	RutEmisor	= nsrutemi
	FROM	VIEW_NOSERIE
	WHERE	nsrutcart	= RutCartera
	AND	nsnumdocu	= NumDocu
	AND	nscorrela	= Correla
	AND	Seriado		= 'N'
	AND	moneda		= 0

	/*==================================================================================================================*/
	/* Recuperar Moneda de Emisión (Papeles seriados)             */
	/*==================================================================================================================*/
	UPDATE	#TMPCARTERA
	SET	Moneda		= semonemi
	,	RutEmisor	= serutemi
	FROM	VIEW_SERIE
	WHERE	semascara	= mascara
	AND	Seriado		= 'S'
	AND	moneda		= 0

	/*==================================================================================================================*/
	/* Insertar campo variable para letras propias     */
	/*==================================================================================================================*/
	UPDATE	#TMPCARTERA
	SET	Variable	= CASE	WHEN Moneda <> 997 THEN 'valor_tasa_emision'
					ELSE 'valor_compra' END
	,	CodigoVariable  = CASE	WHEN RutEmisor = 97023000     THEN '1' 
					ELSE '2' END 
	FROM	#TMPCARTERA
        WHERE	Sistema		= 'BTR' 
	AND	t_movimiento	= 'MOV'
	AND	t_operacion	= 'CP'  
	AND	CodigoInst	= 20

	/*==================================================================================================================*/
	/* Recuperar Moneda de Emisión                                                                                      */
	/*==================================================================================================================*/
	UPDATE	#TMPCARTERA
	SET	CMoneda = CONVERT( CHAR(03), Moneda )

	/*==================================================================================================================*/
	/* Generación de condiciones variables   */
	/*==================================================================================================================*/

	UPDATE	#TMPCARTERA
	SET	CodigoVariable = CASE	WHEN emtipo =  2 THEN '2' -- bancarios 
					ELSE '1' END -- empresas
	FROM	VIEW_EMISOR 
	WHERE	t_movimiento	<> 'TMF'
	AND	instrumento	=  'BONOS'  
	AND	Moneda		IN (998, 994) -- UF Ó DOLAR OBSERVADO
	AND	emrut		=  RutEmisor 

	/*==================================================================================================================*/
	UPDATE	#TMPCARTERA
	SET	CodigoVariable  = CASE	WHEN RutEmisor = 97023000 THEN '1' 
					ELSE '2' END          
	WHERE	instrumento = 'LCHR'         

	/*==================================================================================================================*/
/*	UPDATE	#TMPCARTERA -- PREGUNTAR A MASCAREÑO
	SET	CodigoVariable  =  '2' 
	WHERE   Sistema		= 'BTR' 
	AND	t_movimiento	= 'DEV' 
	AND	t_operacion	= 'DVCP'  
	AND	CodigoInst	= 20
*/
	-- *************************
	-- Condicion Venta con Pacto
	-- *************************
	UPDATE #TMPCARTERA
	SET	CodigoVariable = CASE	WHEN tipopero <> 'CI' AND clrut <> 97029000 AND cltipcli <> 1 THEN '1'
					WHEN tipopero <> 'CI' AND clrut <> 97029000 AND cltipcli  = 1 THEN '2'
					WHEN tipopero <> 'CI' AND clrut  = 97029000 AND cltipcli  = 1 THEN '3'
					WHEN tipopero  = 'CI' AND clrut  = 97029000                   THEN '3' --> No Estaba
					WHEN tipopero  = 'CI' AND clrut <> 1                          THEN '4'
					WHEN tipopero  = 'CI' AND clrut  = 1                          THEN '5'
					ELSE '0' END
	FROM	VIEW_CLIENTE
	WHERE	t_operacion   IN ('VI','RC','RCA','DVIT','DVVI' )
	AND	RutCliente    = clrut
	AND	CodigoCliente = clcodigo

	-- *************************
	-- Condicion Compra con Pacto
	-- *************************
	UPDATE	#TMPCARTERA
	SET	CodigoVariable = CASE	WHEN DATEDIFF(  DAY, FechaInip, Fechavtop) > 365
					AND cltipcli in (4,5,6,7,8,9,13)	THEN  '1'
					WHEN DATEDIFF(  DAY, FechaInip, Fechavtop) > 365
					AND cltipcli in (1,2,3)			THEN  '2'
					WHEN DATEDIFF(  DAY, FechaInip, Fechavtop) <= 365
					AND cltipcli in (4,5,6,7,8,9,13)	THEN  '3'
					WHEN DATEDIFF(  DAY, FechaInip, Fechavtop) <= 365
					AND cltipcli in (1,2,3)			THEN  '4'  END
	FROM	VIEW_CLIENTE
	WHERE	t_operacion	IN ('CI','RV','RVA','DVCI' )
	AND	RutCliente	= clrut
	AND	CodigoCliente	= clcodigo

	/*************************************************************************************************************/
	/**************************** PROCESO DE ACTUALIZACION DE CAMPO VARIABLE  ************************************/
	/*************************************************************************************************************/

	CREATE TABLE #TEMPORAL
	(	id_sistema	CHAR(03) 
	,	tipo_movimiento	CHAR(05)
	,	tipo_operacion	CHAR(05)
	,	operacion	NUMERIC(10,0)
	,	documento	NUMERIC(10,0)
	,	correlativo	NUMERIC(3,0)
	,	estadocobertura	CHAR(05)
	,	CodClas		CHAR(10)
	,	Estado		CHAR(01)
	)

	INSERT	INTO #TEMPORAL
	SELECT	Sistema
	,	t_movimiento
	,	t_operacion
	,	NumOper    
	,	NumDocu
	,	Correla
	,	EstObj
	,	''
	,	'N'
	FROM	#TMPCARTERA
	WHERE	t_operacion	NOT IN ('CI' , 'RV' , 'RVA' , 'DVCI' , 'VI' , 'RC' , 'RCA' , 'DVIT' , 'DVVI')

	DECLARE	@IdSistema		CHAR(03)
	,	@Tipo_Movimiento	CHAR(05)
	,	@Tipo_Operacion		CHAR(05)
	,	@NumOpe			NUMERIC(10,0)
	,	@NumDocu		NUMERIC(10,0)
	,	@NumCorre		NUMERIC(03)
	,	@EstadoCobertura	CHAR(05)
	,	@CodClas		CHAR(10)
	,	@Estado			CHAR(01)

	WHILE 1 = 1 BEGIN

		SELECT	@CodClas = '*'

		SET ROWCOUNT 1

		SELECT	@IdSistema		= id_sistema 
		,	@Tipo_Movimiento	= tipo_movimiento
		,	@Tipo_Operacion		= tipo_operacion
		,	@NumOpe			= operacion
		,	@NumDocu		= documento
		,	@NumCorre		= correlativo
		,	@EstadoCobertura	= estadocobertura
		,	@CodClas		= CodClas
		FROM	#TEMPORAL
		WHERE	Estado			= 'N'

		SET ROWCOUNT 0

		IF @CodClas = '*'
			BREAK

		EXECUTE @CodClas = BACPARAMSUDA.DBO.SP_CON_CLASIFICACION_CARTERA_REPROCESO @IdSistema 
										,	@Tipo_Movimiento 
										,	@Tipo_Operacion 
										,	@NumOpe    
										,	@NumDocu 
										,	@NumCorre
										,	@EstadoCobertura

		SET NOCOUNT ON

		UPDATE	#TEMPORAL
		SET	CodClas		= @CodClas
		,	Estado		= 'S'
		WHERE	id_sistema	= @IdSistema 
		AND	tipo_movimiento	= @Tipo_Movimiento
		AND	tipo_operacion	= @Tipo_Operacion
		AND	operacion	= @NumOpe
		AND	documento	= @NumDocu
		AND	correlativo	= @NumCorre
		AND	estadocobertura	= @EstadoCobertura
	END

	UPDATE	#TMPCARTERA
	SET	CodigoVariable		= CodClas
	FROM	#TEMPORAL		A
	WHERE	#TMPCARTERA.Sistema		= A.id_sistema
	AND	#TMPCARTERA.t_movimiento	= A.tipo_movimiento
	AND	#TMPCARTERA.t_operacion		= A.tipo_operacion
	AND	#TMPCARTERA.NumOper		= A.operacion
	AND	#TMPCARTERA.NumDocu		= A.documento
	AND	#TMPCARTERA.Correla		= A.correlativo
	AND	#TMPCARTERA.EstObj 		= A.EstadoCobertura

	UPDATE	#TMPCARTERA
	SET	CodigoVariable	= CASE	WHEN RutCliente  = @rut_central                   THEN '9'
					WHEN RutCliente  = @rut_estado and ForPagI = 128 and ForPagV = 128  THEN '10' 
					WHEN RutCliente <> @rut_estado and ForPagI = 128 and ForPagV = 128  THEN '11' 
					WHEN RutCliente  = @rut_estado and ForPagI = 129 and ForPagV = 129  THEN '12' 
					WHEN RutCliente <> @rut_estado and ForPagI = 129 and ForPagV = 129  THEN '13' 
					WHEN RutCliente  = @rut_estado and ForPagI = 130 and ForPagV = 130  THEN '14' 
					WHEN RutCliente <> @rut_estado and ForPagI = 130 and ForPagV = 130  THEN '15' 
					WHEN RutCliente  = @rut_estado and ForPagI = 132 and ForPagV = 132  THEN '16' 
					WHEN RutCliente <> @rut_estado and ForPagI = 132 and ForPagV = 132  THEN '17' 
					WHEN RutCliente  = @rut_estado and ForPagI = 133 and ForPagV = 133  THEN '18' 
					WHEN RutCliente <> @rut_estado and ForPagI = 133 and ForPagV = 133  THEN '19' 
					WHEN RutCliente  = @rut_estado                                      THEN '1'
					WHEN RutCliente <> @rut_estado                                      THEN '5'
					ELSE 0 END
	FROM	VIEW_CLIENTE
	WHERE	instrumento        = 'ICAP'

	UPDATE #tmpCartera
	SET	CodigoVariable	= CASE	WHEN RutCliente  = @rut_central                   THEN '9'
					WHEN RutCliente  = @rut_estado and ForPagI = 128 and ForPagV = 128  THEN '10' 
					WHEN RutCliente <> @rut_estado and ForPagI = 128 and ForPagV = 128  THEN '11' 
					WHEN RutCliente  = @rut_estado and ForPagI = 129 and ForPagV = 129  THEN '12' 
					WHEN RutCliente <> @rut_estado and ForPagI = 129 and ForPagV = 129  THEN '13' 
					WHEN RutCliente  = @rut_estado and ForPagI = 130 and ForPagV = 130  THEN '14' 
					WHEN RutCliente <> @rut_estado and ForPagI = 130 and ForPagV = 130  THEN '15' 
					WHEN RutCliente  = @rut_estado and ForPagI = 132 and ForPagV = 132  THEN '16' 
					WHEN RutCliente <> @rut_estado and ForPagI = 132 and ForPagV = 132  THEN '17' 
					WHEN RutCliente  = @rut_estado and ForPagI = 133 and ForPagV = 133  THEN '18' 
					WHEN RutCliente <> @rut_estado and ForPagI = 133 and ForPagV = 133  THEN '19' 
					WHEN RutCliente  = @rut_estado                                      THEN '1'
					WHEN RutCliente <> @rut_estado                                      THEN '5'
					ELSE 0 END
	FROM	VIEW_CLIENTE
	WHERE	instrumento        = 'ICOL'


	/*==================================================================================================================*/
	/* Recuperar datos para los perfiles fisicos                                                                        */
	/*==================================================================================================================*/
	INSERT	INTO CARTERA_CUENTA_REPROCESO
	SELECT	Sistema,
		t_movimiento,
		t_operacion,
		RutCartera,
		NumDocu,
		Correla,
		NumOper,
		CodigoInst,
		Instrumento,
		Mascara,
		InstSer,
		Moneda,
		CMoneda,
		Nominal,
		Monto,
		Variable,
		Seriado,
		0,
		0,
		0,
		CodigoVariable,
		'',
		0,
		RutCliente,
		CodigoCliente,
		RutEmisor,
		tipobono,
		ForPagI,
		ForPagV,
		TipoLinea,
		TipoLetra,
		FechaInip,
		FechaVtop
	FROM	#TMPCARTERA  

	-------------------------------------------------------------------------------------------------------------
	SELECT	b.id_sistema          ,b.tipo_movimiento     ,b.tipo_operacion     ,b.codigo_instrumento 
	,	b.moneda_instrumento  ,a.nombre_campo_tabla  ,a.codigo_campo       ,c.tipo_movimiento_cuenta  
	,	c.codigo_cuenta       ,c.folio_perfil        ,c.correlativo_perfil ,c.perfil_fijo     
	,	c.codigo_campo_variable
	INTO	#PERFIL
	FROM	VIEW_CAMPO_CNT		a 
	,	VIEW_PERFIL_CNT		b 
	,	VIEW_PERFIL_DETALLE_CNT	c 
	WHERE	a.id_sistema		= 'BTR'
	AND	a.tipo_movimiento	= b.tipo_movimiento
	AND	a.tipo_operacion	= b.tipo_operacion
	AND	b.folio_perfil		= c.folio_perfil
	AND	a.codigo_campo		= c.codigo_campo

	-------------------------------------------------------------------------------------------------------------
	UPDATE	CARTERA_CUENTA_REPROCESO
	SET	CtaContable	= codigo_cuenta
	,	FolPerfil	= folio_perfil
	,	CorPerfil	= correlativo_perfil
	,	Fijo		= perfil_fijo
	,	CampoVariable	= codigo_campo_variable
	FROM	#PERFIL
	WHERE	tipo_movimiento		= t_movimiento 
	AND	tipo_operacion		= t_operacion 
	AND	codigo_instrumento	= Instrumento
	AND	moneda_instrumento	= CONVERT(CHAR(03),moneda )
	AND	nombre_campo_tabla	= Variable
	AND	tipo_movimiento_cuenta	= TipoLinea 

	/*==================================================================================================================*/
	/* Recuperar datos para los perfiles logicos                             */
	/*==================================================================================================================*/
	UPDATE	CARTERA_CUENTA_REPROCESO
	SET	CtaContable        = a.codigo_cuenta
	FROM	CARTERA_CUENTA_REPROCESO
	,	VIEW_PERFIL_VARIABLE_CNT	a
	WHERE	a.folio_perfil		= folperfil
	AND	a.correlativo_perfil	= corperfil
	AND	a.valor_dato_campo	= CodigoVariable
	AND	fijo			= 'N' 

        DELETE	CARTERA_CUENTA_REPROCESO
	WHERE	Variable	= ''


	SET NOCOUNT OFF

END



GO
