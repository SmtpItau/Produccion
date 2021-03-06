USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVENGO_COMPRAS_CON_PACTO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DEVENGO_COMPRAS_CON_PACTO]
	(	@dfechoy		DATETIME
	,	@dfecprox		DATETIME
	,	@fte_pcdus		FLOAT
	,	@fte_pcduf		FLOAT
	,	@fte_ptf		FLOAT    
	,	@devengo_dolar	CHAR (01)
	,	@DevMañana		INT		= 1	--> 1=Indica que es desde el Servicio
									--> 0=Indica que viene desde el VB Formulario Devengo
	)
AS
BEGIN
	SET NOCOUNT ON



	-->		Lee el Sw de Configuracion de Garantias
	DECLARE @iActivaCicloGarantias	INT
	SELECT	@iActivaCicloGarantias	= BacTraderSuda.dbo.Fx_Sw_Garantias(4)
	-->		Si @iActivaCicloGarantias = 0 ; esta Apagado	Garantias
	-->		Si @iActivaCicloGarantias = 1 ; esta Encendido	Garantias
	if @iActivaCicloGarantias = 1
	begin
		IF @DevMañana = 1
		BEGIN
			DECLARE @nEstado	INT
			EXECUTE @nEstado	= dbo.SP_DEVENGO_INSTRUEMNTOS_RECEPCIONADOS	@dfechoy
																		,	@dfecprox
																		,	@fte_pcdus
																		,	@fte_pcduf
																		,	@fte_ptf
																		,	@devengo_dolar
			IF @nEstado = -1
			BEGIN
				SELECT 'NO', 'Devengamiento de Instrumentos Recepcionados en Garantias ha Fallado.'
				RETURN -1
			END 
		END
	end
	
	DECLARE	@modcal INTEGER   
	,	@ncodigo INTEGER   
	,	@cmascara CHAR (10)  
	,	@nmonemi INTEGER   
	,	@cfecemi CHAR (10)  
	,	@cfecven CHAR (10)     
	,	@ftasemi FLOAT   
	,	@fbasemi FLOAT   
	,	@ftasest FLOAT   
	,	@fnominal FLOAT   
	,	@ftir  FLOAT   
	,	@fpvp  FLOAT   
	,	@fmt  FLOAT   
	,	@fmtum  FLOAT   
	,	@fmt_cien FLOAT   
	,	@fvan  FLOAT   
	,	@fvpar  FLOAT   
	,	@fvpar2  FLOAT   
	,	@nnumucup INTEGER   
	,	@dfecucup DATETIME  
	,	@fintucup FLOAT   
	,	@famoucup FLOAT   
	,	@fsalucup FLOAT   
	,	@nnumpcup INTEGER   
	,	@dfecpcup DATETIME  
	,	@fintpcup FLOAT   
	,	@famopcup FLOAT   
	,	@fsalpcup FLOAT   
	,	@nerror  INTEGER   
	,	@cprog  CHAR (10)  
	,	@fdurat  FLOAT   
	,	@fconvx  FLOAT   
	,	@fdurmo  FLOAT   
	,	@nintmes FLOAT   
	,	@nreames FLOAT

	DECLARE @dfecemi DATETIME  
	,	@dfecven DATETIME  
	,	@dfecinip DATETIME  
	,	@dfecvtop DATETIME  
	,	@cinstser CHAR (10)  
	,	@cinstorg CHAR (10)  
	,	@cseriado CHAR (01)  
	,	@ctipopero CHAR (03)  
	,	@nrutcart NUMERIC (09, 0)  
	,	@ntipcart NUMERIC (03, 0)  
	,	@nrutclip NUMERIC (09, 0)  
	,	@nrutcli NUMERIC (09, 0) 
	,	@nrutemi NUMERIC (09,0) 
	,	@nnumdocu NUMERIC (10,0) 
	,	@ncorrela NUMERIC (03,0) 
	,	@nnumoper NUMERIC (10,0) 
	,	@fvpresen NUMERIC (19,4) 
	,	@nvalmon_h FLOAT  
	,	@nvalmon_m FLOAT  
	,	@nvalmon_o FLOAT  
	,	@fvalcomu FLOAT  
	,	@fvalcupo FLOAT  
	,	@fintcupo FLOAT  
	,	@famocupo FLOAT  
	,	@dfeccomp DATETIME 
	,	@dfpxreal DATETIME 
	,	@dfecoriginal DATETIME 
	,	@bcupon  INTEGER  
	,	@ffactor FLOAT  
	,	@nvalmon_c FLOAT  
	,	@nvalmon_i FLOAT  
	,	@nmoncupon FLOAT  
	,	@fcapital FLOAT  
	,	@nnumcupant INTEGER  
	,	@fcapital_um FLOAT  
	,	@ninterpacto NUMERIC (19,4) 
	,	@ctipoper CHAR (02) 
	,	@nvpresenci NUMERIC (19,4) 
	,	@ninterpactoci NUMERIC (19,4) 
	,	@nreajpactoci NUMERIC (19,4) 
	,	@ntaspactoci NUMERIC (08,4) 
	,	@nmonpactoci INTEGER  
	,	@nbaspactoci INTEGER  
	,	@ninteres NUMERIC (19,4) 
	,	@nreajuste NUMERIC (19,4) 
	,	@nintdia NUMERIC (19,4) 
	,	@nreadia NUMERIC (19,4) 
	,	@nvalinip NUMERIC (19,4) 
	,	@nbaspacto INTEGER  
	,	@ntaspacto NUMERIC (08,4) 
	,	@nvpresen NUMERIC (19,4) 
	,	@nmonpacto INTEGER  
	,	@nreajpacto NUMERIC (19,4) 
	,	@nbasemi INTEGER  
	,	@ntasemi NUMERIC (08,4) 
	,	@nreacup NUMERIC (19,4) 
	,	@nintcup NUMERIC (19,4) 
	,	@ndifcup NUMERIC (19,4) 
	,	@npagcup NUMERIC (19,4) 
	,	@npagcupo NUMERIC (19,4)
	,	@pago_nohabil INTEGER  
	,	@nmes  INTEGER  
	,	@ndia  INTEGER  
	,	@nano  INTEGER  
	,	@nmes_a  INTEGER  
	,	@nast  INTEGER  
	,	@cmes  CHAR (02) 
	,	@cdia  CHAR (02) 
	,	@cano  CHAR (04) 
	,	@nuf  INTEGER  
	,	@nivp  INTEGER  
	,	@ndo  INTEGER  
	,	@ndifreacup NUMERIC (19,4) 
	,	@ncodcli NUMERIC (09,0) 
	,	@nvalvtop NUMERIC (19,4)	
	,	@id_libro	CHAR(06)
  
	DECLARE @cestado  CHAR (02)  
	,	@cmensa   VARCHAR (255)
	,	@nRedondeo INTEGER
	,	@cMnMx     CHAR(1)
	,	@nTCInicio FLOAT
	,	@nvalinipAux NUMERIC (19,4)
  
	DECLARE @sw_contab CHAR (01) 
	,	@sw_deven CHAR (01) 
	,	@x1  INTEGER  
	,	@contador INTEGER  
	,	@nvalcomp NUMERIC (19,4) 
	,	@nnominal NUMERIC (19,4) 
	,	@ccartera CHAR (03) 
	,	@nforpagv NUMERIC (04,0) 
	,	@nmonib  NUMERIC (19,4)  
	,   @fecdevengo     DATETIME

	DECLARE @fvpresant  FLOAT 

	DECLARE @nvalorpara FLOAT 

        --** guarda fecha de devengo segun dolar **--
	IF @devengo_dolar = 'S'
		SELECT	@fecdevengo = @dfecprox
	ELSE
		SELECT	@fecdevengo = @dfechoy

	SELECT	@sw_contab = acsw_co 
	,		@sw_deven = acsw_dvci
	,		@dfpxreal = acfecprox
	FROM	MDAC

	 --** variables chequeo fin de mes no hÿbil **--

	SELECT	@x1  = 0  
	,	@nmes  = 0  
	,	@ndia  = 0  
	,	@cmes  = '' 
	,	@cdia  = ''

	--** se realiza la validaci¢n de las monedas necesarias para procesar devengamiento

	WHILE @x1 <= DATEDIFF(DAY,@dfechoy,@dfecprox) BEGIN
		SELECT @nvalorpara = 0.0
		
		IF @devengo_dolar = 'N' BEGIN
			SELECT	@nvalorpara = vmvalor 
			FROM	VIEW_VALOR_MONEDA 
			WHERE	vmcodigo	= 998 
			AND	vmfecha		= DATEADD(DAY,@x1,@dfechoy)
				
			IF @nvalorpara IS NULL OR @nvalorpara=0.0 BEGIN
				SELECT 'NO', 'Valor U.F. ' + CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103) + ' No Existe'
				SET NOCOUNT OFF
				RETURN
			END
 			
			SELECT	@nvalorpara = vmvalor 
			FROM	VIEW_VALOR_MONEDA  
			WHERE	vmcodigo	= 997 
			AND	vmfecha		= DATEADD(DAY,@x1,@dfechoy) 
			
			IF @nvalorpara IS NULL OR @nvalorpara = 0.0  BEGIN
				SELECT 'NO', 'Valor I.V.P. '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				SET NOCOUNT OFF
				RETURN
			END
		END
			
		IF @devengo_dolar = 'S'  BEGIN
			SELECT @nvalorpara = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=DATEADD(DAY,@x1,@dfechoy) 
			
			IF @nvalorpara IS NULL OR @nvalorpara=0.0 BEGIN
				SELECT 'NO', 'Valor Dolar '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				SET NOCOUNT OFF
				RETURN
			END

			SELECT @nvalorpara = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=800 AND vmfecha=DATEADD(DAY,@x1,@dfechoy) 
			
			IF @nvalorpara IS NULL OR @nvalorpara=0.0 BEGIN
				SELECT 'NO', 'Valor ICP Nominal '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				SET NOCOUNT OFF
				RETURN
			END

			SELECT @nvalorpara = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=801 AND vmfecha=DATEADD(DAY,@x1,@dfechoy) 
			
			IF @nvalorpara IS NULL OR @nvalorpara=0.0 BEGIN
				SELECT 'NO', 'Valor ICP Real '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				SET NOCOUNT OFF
				RETURN
			END

		END
			
		SELECT @x1 = @x1 + DATEDIFF(DAY,@dfechoy,@dfecprox)
	END

	SELECT	@nmonemi = 0  
	,	@dfecemi = ''  
	,	@dfecven = ''  
	,	@ftasemi = 0.0  
	,	@fbasemi = 0  
	,	@ftasest = 0.0  
	,	@fnominal = 0.0  
	,	@ftir = 0.0  
	,	@fpvp  = 0.0  
	,	@fmt  = 0.0  
	,	@fmtum  = 0.0  
	,	@fmt_cien = 0.0  
	,	@fvan  = 0.0  
	,	@fvpar  = 0.0  
	,	@fvpar2  = 0.0  
	,	@nnumucup = 0.0  
	,	@dfecucup = ''  
	,	@fintucup = 0.0  
	,	@famoucup = 0.0  
	,	@fsalucup = 0.0  
	,	@nnumpcup = 0.0  
	,	@dfecpcup = ''  
	,	@fintpcup = 0.0  
	,	@famopcup = 0.0  
	,	@fsalpcup = 0.0  
	,	@nerror  = 0  
	,	@cprog  = ''  
	,	@nvalcomp = 0.0

	IF @devengo_dolar = 'N' BEGIN
		DELETE	MDRS 
		WHERE	rscartera	= '112' 
		AND	rsfecha		= @dfecprox

		IF @@error<>0 BEGIN
			SET NOCOUNT OFF
			RETURN
		END
	END
     -- D e v e n g a m i e n t o   C o m p r a s   c o n   P a c t o    --
     -- ___________________________________________________________________--
	SELECT @x1  = 1   
	SELECT  @contador       = 0
	SELECT  @contador =  COUNT(1) FROM MDCI WHERE cimascara<>'ICAP' AND cimascara<>'ICOL'

	WHILE @x1<=@contador BEGIN
		SELECT @cinstser='*'
		
		SET ROWCOUNT @x1

		SELECT	@nvalinip = civalinip ,
			@nvpresen = civptirci ,
			@fvpresen = civptirci ,
			@fvpresant = civptirc , -- Valor ayer papel pacto
			@ntaspacto = citaspact ,
			@nbaspacto = cibaspact ,
			@fvalcomu = civalcomu ,
			@ninterpacto = ciinteresci ,
			@nreajpacto = cireajustci ,
			@nmonpacto = cimonpact ,
			@fnominal = cinominal ,
			@ftir  = citircomp ,
			@ncodigo = cicodigo ,
			@nnumdocu = cinumdocu ,
			@ncorrela = cicorrela ,
			@nrutcart = cirutcart ,
			@ntipcart = citipcart ,
			@cinstser = ciinstser ,
			@nrutclip = cirutcli ,
			@ncodcli = cicodcli ,
			@dfecinip = cifecinip ,
			@dfecven = cifecvenp ,
			@cmascara = cimascara ,
			@dfecpcup = ''  ,
			@nrutclip = cirutcli ,
			@nintmes = ciintermes ,
			@nreames = cireajumes ,
			@nrutemi = cirutemi ,
			@nvalvtop = civalvenp,
			@nTCInicio	= citcinicio,
			@nValcomp = civalcomp	,
			@id_libro = id_libro
		FROM	MDCI
		WHERE	cimascara<>'ICAP' 
		AND	cimascara<>'ICOL'

		SET ROWCOUNT 0
		SELECT @x1 = @x1 + 1
	
		IF @cinstser = '*' 
			BREAK
                /* dolares existentes =================================================== */
                /* 994 : dolar observado                                                  */
                /* 995 : dolar acuerdo                                                    */
                /* 996 : dolar interbancario                                              */
                /* ====================================================================== */
		IF @devengo_dolar = 'S' BEGIN
			IF @nmonpacto <> 994 AND @nmonpacto <> 995 AND @nmonpacto <> 988 --AND @nmonpacto<>13
				CONTINUE
		END
		ELSE BEGIN
			IF @nmonpacto=994 OR @nmonpacto=995 OR @nmonpacto=988 --OR @nmonpacto=13
				CONTINUE
		END

		SELECT @cprog='sp_'+inprog FROM VIEW_INSTRUMENTO WHERE incodigo=@ncodigo

		SELECT 	@nvalmon_h = 1.0  ,
			@nvalmon_m = 1.0  ,
			@nvalmon_c = 1.0  ,
			@nreadia = 0.0  ,
			@nintdia = 0.0,
			@cMnMx   = '',
			@nvalinipAux = 0.0

		IF @nmonpacto<>999 AND @nmonpacto <> 13 BEGIN
			SELECT @nvalmon_h=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonpacto AND vmfecha=@dfechoy
			SELECT @nvalmon_m=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonpacto AND vmfecha=@dfecprox
			SELECT @nvalmon_c=vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nmonpacto AND vmfecha=@dfecinip
		END

		SELECT @cMnMx = mnmx from view_moneda WHERE mncodmon = @nmonpacto
		SELECT @nRedondeo = CASE WHEN @cMnMx = 'C' THEN 2 ELSE 0 END

		IF @cMnMx = 'C' AND @nmonpacto <> 13 BEGIN
			SELECT 	@nvalmon_c=@nTCInicio
			SELECT 	@nvalmon_m = 1,
				@nvalmon_h = 1
	
			IF @dfechoy=@dfecinip
				SELECT	@fvpresen = ROUND(@nvalinip/@nvalmon_c,@nRedondeo)
			END

		IF DATEDIFF(MONTH,@dfechoy,@dfecprox)<>0
			SELECT	@nintmes = 0.0 ,
				@nreames = 0.0

		IF @dfechoy=@dfecinip AND @cMnMx <> 'C' and @nmonpacto = 999
			SELECT @fvpresen = @nvalinip

		SELECT @nvalinipAux = @nvalinip
		SELECT @nvalinip  = ROUND(@nvalinip/@nvalmon_c,(CASE WHEN @cMnMx = 'C' THEN 2 ELSE 4 END))
		SELECT @fmt    = ROUND(ROUND(@nvalinip*(((@ntaspacto/(@nbaspacto*100.0))*DATEDIFF(DAY,@dfecinip,@dfecprox))+1.0),4)*@nvalmon_m,@nRedondeo)
		
		IF @dfecprox = @dfecven
			SELECT @fmt    = ROUND(@nvalvtop*@nvalmon_m,(CASE WHEN @cMnMx = 'C' THEN 2 ELSE 0 END))

		SELECT	@nreadia   = ROUND((@nvalmon_m-@nvalmon_h)*@nvalinip,@nRedondeo)
		SELECT	@nintdia   = @fmt - @fvpresen - @nreadia
		SELECT	@ninteres  = @ninterpacto + @nintdia
		SELECT	@nreajuste = @nreajpacto  + @nreadia
		SELECT	@nintmes   = @nintmes + @nintdia
		SELECT	@nreames   = @nreames  + @nreadia
		SELECT	@fvpresen  = @fvpresen + @nintdia + @nreadia
		SELECT	@famocupo  = 0.0 ,
			@fintcupo  = 0.0 ,
			@fvalcomu  = 0.0 ,
			@ftasest   = 0.0 ,
			@fpvp      = 0.0 ,
			@fvpar     = 0.0 

		IF @cseriado = 'S' begin
			SELECT	@ftasemi = setasemi ,
				@nmonemi = semonemi ,
				@fbasemi = sebasemi
			FROM	VIEW_SERIE
			WHERE	semascara=@cmascara	

		END 	
		ELSE BEGIN
			SELECT	@ftasemi = nstasemi ,
				@nmonemi = nsmonemi ,
				@fbasemi = nsbasemi
			FROM VIEW_NOSERIE
			WHERE nsrutcart=@nrutcart AND nsnumdocu=@nnumdocu AND nscorrela=@ncorrela
		END

		SELECT @ftasest = CASE	WHEN @ncodigo=1 THEN @fte_pcdus
					WHEN @ncodigo=2 THEN @fte_pcduf
					WHEN @ncodigo=5 THEN @fte_ptf
					ELSE CONVERT(FLOAT,0)
					END

	  --** valorizaci+n a pr+ximo proceso **--
		EXECUTE @nerror = @cprog 2, @dfecprox, @ncodigo, @cinstser, @nmonemi, @dfecemi, @dfecven, @ftasemi, 
					@fbasemi, @ftasest,  @fnominal output,@ftir output, @fpvp output, @fmt output, 
					@fmtum output, @fmt_cien output, @fvan output, @fvpar output, @nnumucup output, 
					@dfecucup output, @fintucup output, @famoucup output, @fsalucup output, 
					@nnumpcup output, @dfecpcup output, @fintpcup output, @famopcup output, 
					@fsalpcup output, @fdurat output, @fconvx output,@fdurmo output
	  --************************************--
	  --** comienzo de la transacci+n **--
		DECLARE @fmtpacto FLOAT

		SELECT  @fmtpacto = @fmt
	
		SELECT	@nnominal = dinominal
		FROM	MDDI
		WHERE	dirutcart = @nrutcart 
		AND	dinumdocu = @nnumdocu 
		AND	dicorrela = @ncorrela

		IF @nnominal <> @fnominal
			SELECT @fmt = ROUND(@fmt*(1.00-(@nnominal/@fnominal)),@nRedondeo)

		INSERT INTO MDRS
		(	rsfecha
		,	rsrutcart 
		,	rstipcart 
		,	rsnumdocu 
		,	rscorrela 
		,	rsnumoper 
		,	rscartera 
		,	rstipoper 
		,	rsrutcli 
		,	rscodcli 
		,	rsinstser 
		,	rsvppresen 
		,	rsvppresenx
		,	rscupamo
		,	rscupint
		,	rsflujo 
		,	rsfecprox
		,	rsfecctb 
		,	rsnominal
		,	rstir  
		,	rstasfloat 
		,	rsmonemi 
		,	rsmonpact 
		,	rstasemi 
		,	rsbasemi 
		,	rscodigo 
		,	rsinteres 
		,	rsreajuste 
		,	rsintermes 
		,	rsreajumes 
		,	rsinteres_acum 
		,	rsreajuste_acum 
		,	rsforpagv 
		,	rsvalcomp 
		,	rsvalcomu 
		,	rsvalvenc 
		,	rsdurat  
		,	rsdurmod 
		,	rsconvex 
		,	rsnumucup 
		,	rsnumpcup 
		,	rsfecucup 
		,	rsfecpcup 
		,	rsvpcomp 
		,	rstipopero 
		,	rsfecinip 
		,	rsfecvtop 
		,	rsvalvtop 
		,	rsrutemis 
		,	rsvalinip 
		,	rstaspact 
		,	rsid_libro
		)
		VALUES
		(	@dfecprox 
		,	@nrutcart 
		,	@ntipcart 
		,	@nnumdocu 
		,	@ncorrela 
		,	@nnumdocu 
		,	'112'  
		,	'DEV'  
		,	@nrutclip 
		,	@ncodcli  
		,	@cinstser 
		,	@nvpresen 
		,	@fvpresen 
		,	@fvpresant
		,	0.0
		,	@fvpresant
		,	@dfecprox
		,	@dfechoy
		,	@fnominal
		,	@ntaspacto
		,	0.0
		,	@nmonemi
		,	@nmonpacto
		,	@ntaspacto
		,	@nbaspacto
		,	@ncodigo 
		,	@nintdia 
		,	@nreadia 
		,	@nintmes 
		,	@nreames 
		,	@ninteres
		,	@nreajuste
		,	0  
		,	0.0  
		,	0.0  
		,	0.0  
		,	@fdurat  
		,	@fdurmo  
		,	@fconvx  
		,	@nnumucup 
		,	0  
		,	@dfecucup     
		,	@dfecpcup 
		,	0.0  
		,	'CI'  
		,	@dfecinip 
		,	@dfecven 
		,	@nvalvtop 
		,	@nrutemi 
		,	@nvalinipAux
		,	@ntaspacto 	
		,	@id_libro	
		)
		
		IF @devengo_dolar = 'N'	BEGIN

			DECLARE @cFinMesEsp CHAR(01),
				@dFecha1    DATETIME,
				@dFecha2    DATETIME

			SELECT @dFecha1 = @dfecprox
		 	SELECT @dFecha2 = @dFecha1

			EXECUTE SP_DIAHABIL @dFecha2 output

		 	IF @dFecha1 <> @dFecha2  BEGIN /* Solo si es el primer devengo del fin de mes especial (VGS 11/2004) */

				UPDATE	MDCI 
				SET	civptirci	= @fvpresen
				,	civptirc	= @fvpresen
				,	cicapitalci	= @nvalinipAux
				,	ciinteresci	= @ninteres 
				,	cireajustci	= @nreajuste
				,	ciintermes	= @nintmes
				,	cireajumes	= @nreames
				WHERE	cirutcart	= @nrutcart 
				AND	cinumdocu	= @nnumdocu 
				AND	cicorrela	= @ncorrela

				UPDATE MDDI
				SET   	divptirci	= @fvpresen
				,	dicapitaci	= @nValcomp
				,	diintereci	= @ninteres
				,	direajusci	= @nreajuste
				,	diintermes	= @nintmes
				,	direajumes	= @nreames
				WHERE	dirutcart	= @nrutcart 
				AND	dinumdocu	= @nnumdocu 
				AND	dicorrela	= @ncorrela
			END
		END

		IF @@error <> 0 BEGIN 
			SELECT 'NO', 'Devengamiento Ha Fallado en Grabacion de Resultado'
			SET NOCOUNT OFF
			RETURN
		END
	 END

	SELECT 'OK', 'DEVENGAMIENTO DE LAS COMPRAS CON PACTO HA TERMINADO EXITOSAMENTE'
	
	UPDATE	MDAC 
		SET acsw_dvci = '1'


	SET NOCOUNT OFF
	RETURN
END

GO
