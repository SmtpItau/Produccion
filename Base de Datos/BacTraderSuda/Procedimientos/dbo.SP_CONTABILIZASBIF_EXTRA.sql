USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTABILIZASBIF_EXTRA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CONTABILIZASBIF_EXTRA]	(	@Fecha		DATETIME 
						,	@Elimina_TM	NUMERIC (01)  /* @Elimina_TM = 1 --> SI		*/
						,	@Mov_Rev	NUMERIC (02)  /* -1 = REVERSA | 1 = NORMAL	*/
						)  
AS
BEGIN
 
	DECLARE @cserie				CHAR(12)
	,	@ntir				NUMERIC (09,4)
	,	@nvalpresen			NUMERIC (19,4)
	,	@nvalmer			NUMERIC (19,4)
	,	@ndiferen			NUMERIC (19,4)
	,	@dfeccal			DATETIME
	,	@mascara			CHAR(12)
	,	@cod_ser			NUMERIC (03,0)
	,	@rutemi				NUMERIC (09,0)
	,	@nominal			NUMERIC (19,4) 
	,	@tipo_operacion 		CHAR(03)
	,	@codigo_carterasuper		CHAR(01)
	,	@rmrutcart			NUMERIC(09,0)
	,	@rmnumdocu			NUMERIC(10,0)
	,	@rmnumoper			NUMERIC(10,0)
	,	@rmcorrela			NUMERIC(03,0)
	,	@rmcodigo			NUMERIC(05,0) 	
	,	@moneda_emision			NUMERIC(03,0)
	,	@Tipo_Cartera_Financiera	CHAR(01)
	,	@tmseriado			CHAR(01) 
	,	@codCarteraFin			NUMERIC(01)
	,	@Indicadaor_rever		CHAR(1)
	, @TIP	CHAR(1)


	DECLARE	@dfecfmes   DATETIME
	,	@Fecha_prox DATETIME
	,	@Rut_prop   NUMERIC(9,0)

	SELECT	@fecha_prox = acfecprox 
        ,	@Rut_prop   = acrutprop  
	FROM	MDAC0823

        SELECT @dfecfmes = DATEADD(DAY,DATEPART(DAY,@fecha_prox) * -1,@fecha_prox)

	IF  @dfecfmes > @Fecha  AND  @dfecfmes < @fecha_prox
	     if @Mov_Rev = 1
		SELECT  @Fecha = @dfecfmes  

	SELECT @dfeccal = MDAC.acfecproc
        FROM	MDAC0823 MDAC


	DECLARE cursor1 CURSOR 
	FOR 
	SELECT	tipo_operacion
	,	A.codigo_carterasuper 
	,	rmrutcart
	,	rmnumdocu 
	,	rmnumoper 
	,	rmcorrela 
	,	rmcodigo 
	,	moneda_emision 
	,	rminstser            
	,	tasa_mercado 
	,	valor_presente
	,	valor_mercado 
	,	diferencia_mercado 
	,	rut_emisor 
	,	tmmascara 
	,	rmcodigo 
	,	valor_nominal 
	,	tmseriado
	,	CPTIPCART
	FROM	VALORIZACION_MERCADO A, MDCP0823 B
	WHERE	fecha_valorizacion	= @Fecha
	AND   CPNUMDOCU=RMNUMDOCU
	AND   CPCORRELA=RMCORRELA
	AND	(rmcodigo		<> 20	OR rut_emisor <> @Rut_prop ) 
	AND	A.codigo_carterasuper	<> 'A'

	/*--------------------------------------------------
	 * borrar movimiento que refleje la contabilidad
	 *-------------------------------------------------*/


	/*--------------------------------
	* sacar fecha de proceso
	*-------------------------------*/ 

	OPEN CURSOR1
	FETCH NEXT FROM CURSOR1 
	INTO	@tipo_operacion 
	,	@codigo_carterasuper 
	,	@rmrutcart 	
	,	@rmnumdocu
	,	@rmnumoper
	,	@rmcorrela	
	,	@rmcodigo	
	,	@moneda_emision
	,	@cserie
	,	@ntir 
	,	@nvalpresen
	,	@nvalmer
	,	@ndiferen
	,	@rutemi
	,	@mascara
	,	@cod_ser
	,	@nominal
	,	@tmseriado 
	,	@TIP

	SELECT	@dfeccal = MDAC.acfecproc
        FROM	MDAC0823 MDAC

	IF @Mov_Rev = -1 
		SET @Indicadaor_rever = 'R'   
	ELSE IF @Mov_Rev = 1 
		SET @Indicadaor_rever = ' '   

	WHILE ( @@FETCH_STATUS <> -1 ) BEGIN

		INSERT	MDMO_EXTRA 
		(	mofecpro  
		,	morutcart 
		,	monumdocu 
		,	mocorrela 
		,	monumdocuo
		,	mocorrelao
		,	monumoper 
		,	motipoper 
		,	motipopero
		,	moinstser 
		,	momascara 
		,	mocodigo  
		,	moseriado 
		,	mofecemi  
		,	mofecven  
		,	momonemi  
		,	motasemi  
		,	mobasemi  
		,	morutemi  
		,	monominal 
		,	movpresen 
		,	momtps    
		,	momtum    
		,	momtum100 
		,	monumucup 
		,	motir     
		,	mopvp     
		,	movpar    
		,	motasest  
		,	mofecinip 
		,	mofecvenp 
		,	movalinip 
		,	movalvenp 
		,	motaspact 
		,	mobaspact 
		,	momonpact 
		,	moFORPAGi 
		,	moFORPAGv 
		,	motipobono 
		,	mocondpacto 
		,	mopagohoy 
		,	morutcli 
		,	mocodcli  
		,	motipret  
		,	mohora    
		,	mousuario 
		,	moterminal
		,	mocapitali
		,	mointeresi
		,	moreajusti
		,	movpreseni
		,	mocapitalp
		,	mointeresp
		,	moreajustp
		,	movpresenp
		,	motasant  
		,	mobasant  
		,	movalant  
		,	mostatreg 
		,	movpressb 
		,	modifsb    
		,	codigo_carterasuper 			
		,	modigitador
		,	modiftran_clp
		,	modiftran_mo
		,	movptran
		,	moPvpTran
		,	moTirTran
		,Dcrp_Confirmador  
		,Dcrp_Codigo
		,Dcrp_Glosa
		,Dcrp_HoraConfirm
		,Dcrp_OperConfirm
		,Dcrp_OpeCnvConfirm
		,swimpresion
		,	MOTIPCART
		)
		VALUES 
		(	@dfeccal
		,	@rmrutcart
		,	@rmnumdocu
		,	@rmcorrela
		,	0
		,	0
		,	@rmnumoper
		,	'TM'
		,	@tipo_operacion  
		,	@cserie
		,	@mascara
		,	@cod_ser
		,	@tmseriado  
		,	''
		,	''
		,	@moneda_emision
		,	0
		,	0
		,	@rutemi
		,	@nominal
		,	@nvalpresen
		,	0
		,	0
		,	0
		,	0
		,	@ntir
		,	0
		,	0
		,	0
		,	''
		,	''
		,	0
		,	0
		,	0
		,	0
		,	0
		,	0
		,	0
		,	''
		,	''
		,	''
		,	@rutemi
		,	1
		,	''
		,	convert( CHAR(15),@dfeccal,108) 
		,	''
		,	''
		,	0
		,	0
		,	0
		,	0
		,	0
		,	0
		,	0
		,	0
		,	0
		,	0
		,	0
		,	@Indicadaor_rever
		,	@nvalmer
		,	@ndiferen  * 1 
		,	@codigo_carterasuper 
		,	'',0,0,0,0,0,
			'',0,'','','','',0,@TIP
		)

		FETCH NEXT FROM CURSOR1 
		INTO	@tipo_operacion
		,	@codigo_carterasuper 
		,	@rmrutcart
		,	@rmnumdocu
		,	@rmnumoper
		,	@rmcorrela
		,	@rmcodigo
		,	@moneda_emision
		,	@cserie
		,	@ntir
		, 	@nvalpresen
		,	@nvalmer
		,	@ndiferen
		,	@rutemi
		,	@mascara
		,	@cod_ser
		,	@nominal
		,	@tmseriado  
		, @TIP
	END

	CLOSE CURSOR1
	DEALLOCATE CURSOR1
   
END

GO
