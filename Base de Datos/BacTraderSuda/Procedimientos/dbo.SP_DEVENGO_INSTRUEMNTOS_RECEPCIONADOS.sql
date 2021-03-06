USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVENGO_INSTRUEMNTOS_RECEPCIONADOS]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_DEVENGO_INSTRUEMNTOS_RECEPCIONADOS]
	(	@dfechoy		DATETIME
	,	@dfecprox		DATETIME
	,	@fte_pcdus		FLOAT
	,	@fte_pcduf		FLOAT
	,	@fte_ptf		FLOAT
	,	@devengo_dolar	CHAR(01)
	)
AS
BEGIN

	SET NOCOUNT ON

	DECLARE	@modcal			INTEGER
		,	@ncodigo		INTEGER
		,	@cmascara		CHAR(10)
		,	@nmonemi		INTEGER
		,	@cfecemi		CHAR(10)
		,	@cfecven		CHAR(10)
		,	@ftasemi		FLOAT
		,	@fbasemi		FLOAT
		,	@ftasest		FLOAT
		,	@fnominal		FLOAT
		,	@ftir			FLOAT
		,	@fpvp			FLOAT
		,	@fmt			FLOAT
		,	@fmtum			FLOAT
		,	@fmt_cien		FLOAT
		,	@fvan			FLOAT
		,	@fvpar			FLOAT
		,	@fvpar2			FLOAT
		,	@nnumucup		INTEGER
		,	@dfecucup		DATETIME
		,	@fintucup		FLOAT
		,	@famoucup		FLOAT
		,	@fsalucup		FLOAT
		,	@nnumpcup		INTEGER
		,	@dfecpcup		DATETIME
		,	@fintpcup		FLOAT
		,	@famopcup		FLOAT
		,	@fsalpcup		FLOAT
		,	@nerror			INTEGER
		,	@cprog			CHAR(10)
		,	@fdurat			FLOAT
		,	@fconvx			FLOAT
		,	@fdurmo			FLOAT
		,	@nintmes		FLOAT
		,	@nreames		FLOAT
		
	DECLARE @dfecemi		DATETIME
		,	@dfecven		DATETIME
		,	@dfecinip		DATETIME
		,	@dfecvtop		DATETIME
		,	@cinstser		CHAR(10)
		,	@cinstorg		CHAR(10)
		,	@cseriado		CHAR(01)
		,	@ctipopero		CHAR(03)
		,	@nrutcart		NUMERIC(09, 0)
		,	@ntipcart		NUMERIC(03, 0)
		,	@nrutclip		NUMERIC(09, 0)
		,	@nrutcli		NUMERIC(09, 0)
		,	@nrutemi		NUMERIC(09,0)
		,	@nnumdocu		NUMERIC(10,0)
		,	@ncorrela		NUMERIC(03,0)
		,	@nnumoper		NUMERIC(10,0)
		,	@fvpresen		NUMERIC(19,4)
		,	@nvalmon_h		FLOAT
		,	@nvalmon_m		FLOAT
		,	@nvalmon_o		FLOAT
		,	@fvalcomu		FLOAT
		,	@fvalcupo		FLOAT
		,	@fintcupo		FLOAT
		,	@famocupo		FLOAT
		,	@dfeccomp		DATETIME
		,	@dfpxreal		DATETIME
		,	@dfecoriginal	DATETIME
		,	@bcupon			INTEGER
		,	@ffactor		FLOAT
		,	@nvalmon_c		FLOAT
		,	@nvalmon_i		FLOAT
		,	@nmoncupon		FLOAT
		,	@fcapital		FLOAT
		,	@nnumcupant		INTEGER
		,	@fcapital_um	FLOAT
		,	@ninterpacto	NUMERIC(19,4) 
		,	@ctipoper		CHAR(02) 
		,	@nvpresenci		NUMERIC(19,4) 
		,	@ninterpactoci	NUMERIC(19,4) 
		,	@nreajpactoci	NUMERIC(19,4) 
		,	@ntaspactoci	NUMERIC(08,4) 
		,	@nmonpactoci	INTEGER  
		,	@nbaspactoci	INTEGER  
		,	@ninteres		NUMERIC(19,4) 
		,	@nreajuste		NUMERIC(19,4) 
		,	@nintdia		NUMERIC(19,4) 
		,	@nreadia		NUMERIC(19,4) 
		,	@nvalinip		NUMERIC(19,4) 
		,	@nbaspacto		INTEGER  
		,	@ntaspacto		NUMERIC(08,4) 
		,	@nvpresen		NUMERIC(19,4) 
		,	@nmonpacto		INTEGER  
		,	@nreajpacto		NUMERIC(19,4) 
		,	@nbasemi		INTEGER  
		,	@ntasemi		NUMERIC(08,4) 
		,	@nreacup		NUMERIC(19,4) 
		,	@nintcup		NUMERIC(19,4) 
		,	@ndifcup		NUMERIC(19,4) 
		,	@npagcup		NUMERIC(19,4) 
		,	@npagcupo		NUMERIC(19,4)
		,	@pago_nohabil	INTEGER  
		,	@nmes			INTEGER  
		,	@ndia			INTEGER  
		,	@nano			INTEGER  
		,	@nmes_a			INTEGER  
		,	@nast			INTEGER  
		,	@cmes			CHAR(02) 
		,	@cdia			CHAR(02) 
		,	@cano			CHAR(04) 
		,	@nuf			INTEGER  
		,	@nivp			INTEGER  
		,	@ndo			INTEGER  
		,	@ndifreacup		NUMERIC(19,4) 
		,	@ncodcli		NUMERIC(09,0) 
		,	@nvalvtop		NUMERIC(19,4)	
		,	@id_libro		CHAR(06)
  
	DECLARE @cestado		CHAR(02)  
		,	@cmensa			VARCHAR(255)
		,	@nRedondeo		INTEGER
		,	@cMnMx			CHAR(1)
		,	@nTCInicio		FLOAT
		,	@nvalinipAux	NUMERIC(19,4)
  
	DECLARE @sw_contab		CHAR(01) 
		,	@sw_deven		CHAR(01) 
		,	@x1				INTEGER  
		,	@contador		INTEGER  
		,	@nvalcomp		NUMERIC(19,4) 
		,	@nnominal		NUMERIC(19,4) 
		,	@ccartera		CHAR(03) 
		,	@nforpagv		NUMERIC(04,0) 
		,	@nmonib			NUMERIC(19,4)  
		,	@fecdevengo		DATETIME

	DECLARE @fvpresant		FLOAT 
	DECLARE @nvalorpara		FLOAT 

	--** guarda fecha de devengo segun dolar **--
	IF @devengo_dolar = 'S'
		SET @fecdevengo		= @dfecprox
	ELSE
		SET @fecdevengo		= @dfechoy

	SELECT	@sw_contab		= acsw_co
		,	@sw_deven		= acsw_ges --> acsw_dvci
		,	@dfpxreal		= acfecprox
	FROM	MDAC

	--** variables chequeo fin de mes no hÿbil **--
	SELECT	@x1		= 0
		,	@nmes	= 0
		,	@ndia	= 0
		,	@cmes	= ''
		,	@cdia	= ''

	--** se realiza la validaci¢n de las monedas necesarias para procesar devengamiento
	WHILE @x1 <= DATEDIFF(DAY,@dfechoy,@dfecprox) 
	BEGIN

		SET @nvalorpara = 0.0

		IF @devengo_dolar = 'N'
		BEGIN
			SELECT	@nvalorpara = vmvalor 
			FROM	VIEW_VALOR_MONEDA 
			WHERE	vmcodigo	= 998 
			AND		vmfecha		= DATEADD(DAY,@x1,@dfechoy)

			IF @nvalorpara IS NULL OR @nvalorpara = 0.0 
			BEGIN
				SELECT 'NO', 'Valor U.F. ' + CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103) + ' No Existe'
				RETURN -1
			END

			SELECT	@nvalorpara		= vmvalor
			FROM	VIEW_VALOR_MONEDA
			WHERE	vmcodigo		= 997
			AND		vmfecha			= DATEADD(DAY,@x1,@dfechoy)

			IF @nvalorpara IS NULL OR @nvalorpara = 0.0
			BEGIN
				SELECT 'NO', 'Valor I.V.P. '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				RETURN -1
			END
		END
			
		IF @devengo_dolar = 'S'
		BEGIN
			SELECT @nvalorpara = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = DATEADD(DAY,@x1,@dfechoy) 

			IF @nvalorpara IS NULL OR @nvalorpara=0.0
			BEGIN
				SELECT 'NO', 'Valor Dolar '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				RETURN -1
			END

			SELECT @nvalorpara = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 800 AND vmfecha=DATEADD(DAY,@x1,@dfechoy) 

			IF @nvalorpara IS NULL OR @nvalorpara=0.0 
			BEGIN
				SELECT 'NO', 'Valor ICP Nominal '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				RETURN -1
			END

			SELECT @nvalorpara = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 801 AND vmfecha=DATEADD(DAY,@x1,@dfechoy) 
			
			IF @nvalorpara IS NULL OR @nvalorpara=0.0 
			BEGIN
				SELECT 'NO', 'Valor ICP Real '+CONVERT(CHAR(10),DATEADD(DAY,@x1,@dfechoy),103)+' No Existe'
				RETURN -1
			END
		END

		SET @x1 = @x1 + DATEDIFF(DAY, @dfechoy, @dfecprox)
	END

	SET @nmonemi	= 0  
	SET @dfecemi	= ''  
	SET @dfecven	= ''  
	SET @ftasemi	= 0.0  
	SET @fbasemi	= 0  
	SET @ftasest	= 0.0  
	SET @fnominal	= 0.0  
	SET @ftir		= 0.0  
	SET @fpvp		= 0.0  
	SET @fmt		= 0.0  
	SET @fmtum		= 0.0  
	SET @fmt_cien	= 0.0  
	SET @fvan		= 0.0  
	SET @fvpar		= 0.0  
	SET @fvpar2		= 0.0  
	SET @nnumucup	= 0.0  
	SET @dfecucup	= ''  
	SET @fintucup	= 0.0  
	SET @famoucup	= 0.0  
	SET @fsalucup	= 0.0  
	SET @nnumpcup	= 0.0  
	SET @dfecpcup	= ''  
	SET @fintpcup	= 0.0  
	SET @famopcup	= 0.0  
	SET @fsalpcup	= 0.0  
	SET @nerror		= 0  
	SET @cprog		= ''  
	SET @nvalcomp	= 0.0

	IF @devengo_dolar = 'N' 
	BEGIN
		DELETE	FROM	MDRS
				WHERE	rscartera	= '160'		--> Cartera de Intrumentos Recibidos en Garantias
				AND		rsfecha		= @dfecprox

		IF @@ERROR <> 0 
		BEGIN
			RETURN -1
		END
	END

	-- Devengamiento de instrumentos recepcionados en Garantias   --
	-- ___________________________________________________________--
	
	SET		@x1			= 1
	SET		@contador   = 0

	SELECT  @contador	= COUNT(1)
	FROM	bdbomesa.Garantia.TBL_CarteraGarantia						enc with(nolock)
			inner join bdbomesa.Garantia.TBL_DetalleCarteraGarantia		det with(nolock) On det.NumeroGarantia		 = enc.NumeroGarantia
			inner join bdbomesa.Garantia.Tbl_Valorizacion_Instrumento	val with(nolock) On val.Garantia_Numero		 = det.NumeroGarantia
																						and val.Garantia_Correlativo = det.CorrelativoGarantia
	WHERE	(
			not (	enc.TipoMovimiento	= '23'			)
	and		not (	det.Instrumento		= 'EFECTIVO'	)
			)
	and		det.nominal	> 0


	WHILE @x1 <= @contador 
	BEGIN

		SET @cinstser = '*'
		
		SET ROWCOUNT @x1

		SELECT	@nrutcart		= (select top 1 acrutprop from BacTraderSuda.dbo.MDAC with(nolock) ) --> cirutcart
			,	@ntaspacto		= 0								--> citaspact
			,	@nbaspacto		= 0								--> cibaspact
			,	@nmonpacto		= 999							--> cimonpact	-> Moneda del Pacto
			
			,	@nvalinip		= val.ValorProceso				-->	civalinip
			,	@nvpresen		= val.ValorProceso				-->	civptirci
			,	@fvpresen		= val.ValorProceso				--> civptirci
			,	@fvpresant		= val.ValorProceso				--> civptirc
			,	@fvalcomu		= val.ValorCompraUm				--> civalcomu
			,	@ninterpacto	= val.InteresAcumCp				--> ciinteresci
			,	@nreajpacto		= val.ReajusteAcumCp			--> cireajustci

			,	@fnominal		= val.Nominal					-->	cinominal
			,	@ftir			= val.Tir						-->	citircomp
			,	@ncodigo		= val.Codigo					--> cicodigo
			,	@nnumdocu		= val.Garantia_Numero			-->	cinumdocu
			,	@ncorrela		= val.Garantia_Correlativo		--> cicorrela
			,	@ntipcart		= 0								--> citipcart
			,	@cinstser		= val.Serie						--> ciinstser
			,	@nrutclip		= 0								-->	cirutcli
			,	@ncodcli		= 0								--> cicodcli
			,	@dfecinip		= enc.FechaIngresoGarantia		-->	cifecinip
			,	@dfecven		= enc.FechaVencimientoGarantia	--> cifecvenp
			,	@cmascara		= val.Mascara					--> cimascara
			,	@dfecpcup		= ''
			,	@nrutclip		= 0								-->	cirutcli
			,	@nintmes		= val.Interes_Mes				--> ciintermes
			,	@nreames		= val.Reajuste_Mes				--> cireajumes
			,	@nrutemi		= det.RutEmisor					--> cirutemi
			,	@nvalvtop		= val.ValorProceso				--> civalvenp
			,	@nTCInicio		= det.TipoCambio				--> citcinicio
			,	@nValcomp		= val.ValorCompra				--> civalcomp
			,	@id_libro		= 0								--> id_libro
		FROM	bdbomesa.Garantia.TBL_CarteraGarantia						enc with(nolock)
				inner join bdbomesa.Garantia.TBL_DetalleCarteraGarantia		det with(nolock) On det.NumeroGarantia		 = enc.NumeroGarantia
				inner join bdbomesa.Garantia.Tbl_Valorizacion_Instrumento	val with(nolock) On val.Garantia_Numero		 = det.NumeroGarantia
																							and val.Garantia_Correlativo = det.CorrelativoGarantia
		WHERE	(
				not (	enc.TipoMovimiento	= '23'			)
		and		not (	det.Instrumento		= 'EFECTIVO'	)
				)
		and		det.nominal	> 0

		SET ROWCOUNT 0

		SET		@x1 = @x1 + 1

		IF @cinstser = '*' 
			BREAK

        /* dolares existentes =================================================== */
        /* 994 : dolar observado                                                  */
        /* 995 : dolar acuerdo                                                    */
        /* 996 : dolar interbancario                                              */
        /* ====================================================================== */

		IF @devengo_dolar = 'S' 
		BEGIN
			IF @nmonpacto <> 994 AND @nmonpacto <> 995 AND @nmonpacto <> 988 --AND @nmonpacto<>13
				CONTINUE
		END ELSE 
		BEGIN
			IF @nmonpacto  = 994 OR @nmonpacto  = 995 OR @nmonpacto   = 988 --OR @nmonpacto=13
				CONTINUE
		END

		SELECT	@cprog	=	'sp_'	+	inprog	FROM	VIEW_INSTRUMENTO	WHERE incodigo = @ncodigo

		SET		@nvalmon_h		= 1.0
		SET		@nvalmon_m		= 1.0
		SET		@nvalmon_c		= 1.0
		SET		@nreadia		= 0.0
		SET		@nintdia		= 0.0
		SET		@cMnMx			= ''
		SET		@nvalinipAux	= 0.0

		IF @nmonpacto <> 999 AND @nmonpacto <> 13 
		BEGIN
			SET @nvalmon_h = ( SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @nmonpacto AND vmfecha = @dfechoy  )
			SET @nvalmon_m = ( SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @nmonpacto AND vmfecha = @dfecprox )
			SET @nvalmon_c = ( SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @nmonpacto AND vmfecha = @dfecinip ) 
		END

		SET		@cMnMx		= ( SELECT mnmx FROM VIEW_MONEDA WHERE mncodmon = @nmonpacto )
		SET		@nRedondeo	= CASE WHEN @cMnMx = 'C' THEN 2 ELSE 0 END

		IF @cMnMx = 'C' AND @nmonpacto <> 13 
		BEGIN
			SET @nvalmon_c	= @nTCInicio
			SET @nvalmon_m	= 1
			SET @nvalmon_h	= 1
	
			IF @dfechoy = @dfecinip
				SET	@fvpresen	= ROUND(@nvalinip/@nvalmon_c,@nRedondeo)
		END

		IF DATEDIFF(MONTH,@dfechoy,@dfecprox)<>0
		BEGIN
			SET	@nintmes = 0.0
			SET	@nreames = 0.0
		END

		IF @dfechoy = @dfecinip AND @cMnMx <> 'C' and @nmonpacto = 999
			SET @fvpresen = @nvalinip

		SET		@nvalinipAux	= @nvalinip
		SET		@nvalinip		= ROUND(@nvalinip / @nvalmon_c,(CASE WHEN @cMnMx = 'C' THEN 2 ELSE 4 END))
		SET		@fmt			= ROUND(ROUND(@nvalinip * (((@ntaspacto / (@nbaspacto * 100.0)) * DATEDIFF(DAY,@dfecinip, @dfecprox)) + 1.0) ,4) * @nvalmon_m,@nRedondeo)

		IF @dfecprox = @dfecven
			SET @fmt	= ROUND(@nvalvtop * @nvalmon_m ,(CASE WHEN @cMnMx = 'C' THEN 2 ELSE 0 END))

		SET	@nreadia   = ROUND((@nvalmon_m-@nvalmon_h)*@nvalinip,@nRedondeo)
		SET	@nintdia   = @fmt - @fvpresen - @nreadia
		SET	@ninteres  = @ninterpacto + @nintdia
		SET	@nreajuste = @nreajpacto  + @nreadia
		SET	@nintmes   = @nintmes + @nintdia
		SET	@nreames   = @nreames  + @nreadia
		SET	@fvpresen  = @fvpresen + @nintdia + @nreadia
		SET	@famocupo  = 0.0
		SET	@fintcupo  = 0.0
		SET	@fvalcomu  = 0.0
		SET	@ftasest   = 0.0
		SET	@fpvp      = 0.0
		SET	@fvpar     = 0.0 

		IF @cseriado = 'S' 
		BEGIN
			SELECT	@ftasemi	= setasemi
				,	@nmonemi	= semonemi
				,	@fbasemi	= sebasemi
			FROM	VIEW_SERIE
			WHERE	semascara	= @cmascara	
		END ELSE 
		BEGIN
			SELECT	@ftasemi	= nstasemi 
				,	@nmonemi	= nsmonemi
				,	@fbasemi	= nsbasemi
			FROM	VIEW_NOSERIE
			WHERE	nsrutcart	= @nrutcart 
			AND		nsnumdocu	= @nnumdocu 
			AND		nscorrela	= @ncorrela
		END

		SELECT @ftasest		= CASE	WHEN @ncodigo = 1	THEN	@fte_pcdus
									WHEN @ncodigo = 2	THEN	@fte_pcduf
									WHEN @ncodigo = 5	THEN	@fte_ptf
									ELSE						CONVERT(FLOAT,0)
								END
		--** valorizaci+n a pr+ximo proceso **--
		EXECUTE @nerror		=	@cprog 2,	@dfecprox,	@ncodigo,	@cinstser,	@nmonemi,	@dfecemi,	@dfecven,	@ftasemi,
								@fbasemi,	@ftasest,	@fnominal	output,		@ftir		output,		@fpvp		output,		@fmt		output,
								@fmtum		output,		@fmt_cien	output,		@fvan		output,		@fvpar		output,		@nnumucup	output,
								@dfecucup	output,		@fintucup	output,		@famoucup	output,		@fsalucup	output,
								@nnumpcup	output,		@dfecpcup	output,		@fintpcup	output,		@famopcup	output,
								@fsalpcup	output,		@fdurat		output,		@fconvx		output,		@fdurmo		output
		--************************************--
		--** comienzo de la transacci+n **--
		DECLARE @fmtpacto	FLOAT
		SELECT  @fmtpacto	= @fmt
					
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
		,	'160'  
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

		IF @@error <> 0
		BEGIN
			SELECT 'NO', 'Devengamiento Ha Fallado en Grabacion de Resultado'
			RETURN -1
		END
	END

	SELECT 'OK', 'DEVENGAMIENTO DE LAS GARANTIAS RECEPCIONADAS HA FINALIZADO OK'

	UPDATE	MDAC SET acsw_ges = '1' --> Se ocupara para Garantias

	RETURN 0
END
GO
