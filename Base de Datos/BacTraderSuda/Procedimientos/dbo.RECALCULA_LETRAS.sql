USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[RECALCULA_LETRAS]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[RECALCULA_LETRAS]
AS
BEGIN
	SET NOCOUNT ON
	DECLARE	@cProg		CHAR	(10)	,
		@iModcal	INTEGER		,
		@iCodigo	INTEGER		,
		@cInstser	CHAR	(10)	,
		@iMonemi	INTEGER		,
		@dFecemi	DATETIME	,
		@dFecven	DATETIME	,
		@fTasemi	FLOAT		,
		@fBasemi	FLOAT		,
		@fTasest	FLOAT		,
		@fNominal	FLOAT		,
		@fTir		FLOAT		,
		@fPvp		FLOAT		,
		@fMT		FLOAT		,
		@fMTUM		FLOAT		,
		@fMT_cien	FLOAT		,
		@fVan		FLOAT		,
		@fVpar		FLOAT		,
		@nNumucup	INTEGER		,
		@dFecucup	DATETIME	,
		@fIntucup	FLOAT		,
		@fAmoucup	FLOAT		,
		@fSalucup	FLOAT		,
		@nNumpcup	INTEGER		,
		@dFecpcup	DATETIME	,
		@fIntpcup	FLOAT		,
		@fAmopcup	FLOAT		,
		@fSalpcup	FLOAT		,
		@fDurat		FLOAT		,
		@fConvx		FLOAT		,
		@fDurmo		FLOAT		,
		@nError		INTEGER 
  
	DECLARE	@fValmon_Hoy	NUMERIC	(19,4)	,
		@fValmon_Man	NUMERIC	(19,4)	,
		@fValmon_Com	NUMERIC	(19,4)	,
		@nNumdocu	NUMERIC	(10,0)	,
		@nNumoper	NUMERIC	(10,0)	,
		@nCorrela	NUMERIC	(03,0)	,
		@nValcomp	NUMERIC	(19,0)	,
		@fValcomu	FLOAT		,
		@dFeccomp	DATETIME	,
		@dFechoy	DATETIME	,
		@dFecprox	DATETIME	,
		@dFecante	DATETIME	,
		@dFecinip	DATETIME	,
		@dFecvtop	DATETIME	,
		@nVpresen	NUMERIC	(19,0)	,
		@nValpacto	NUMERIC	(19,0)	,
		@cMascara	CHAR	(10)	,
		@cSeriado	CHAR	(01)	,
		@nInteres	NUMERIC	(19,0)	,
		@nReajuste	NUMERIC	(19,0)	,
		@nIntpacto	NUMERIC	(19,0)	,
		@nReapacto	NUMERIC	(19,0)	,
		@fTe_pcdus	FLOAT		,
		@fTe_pcduf	FLOAT		,
		@fTe_ptf	FLOAT		,
		@nValinip	NUMERIC	(19,4)	,
		@nBaspacto	INTEGER		,
		@nTaspacto	NUMERIC	(08,4)	,
		@nMonpacto	INTEGER		,
		@iBusca		INTEGER		,
		@iMesman	INTEGER		,
		@cFecman	CHAR	(10)	,
		@fIpcemi	FLOAT		,
		@fIpccal	FLOAT		,
		@dFecman	DATETIME	,
		@iMescp		INTEGER		,
		@cFeccp		CHAR	(10)	,
		@dFeccp		DATETIME	,
		@iExtrae	INTEGER		,
		@cFecemi	CHAR	(10)	,
		@cMesemi	CHAR	(02)	,
		@iAnoemi	INTEGER		,
		@iMesemi	INTEGER		,
		@nIntdia	NUMERIC	(19,0)	,
		@nReadia	NUMERIC	(19,0)	,
		@nValvtop	NUMERIC	(19,4)	,
 		@nInterpacto	NUMERIC	(19,0)	,
		@nReajpacto	NUMERIC	(19,0)	,
		@fIntmes	FLOAT		,
		@fReames	FLOAT		,
		@iX		INTEGER		,
		@nContador	INTEGER		,
		@nVpresvpar	NUMERIC	(19,0)	,
		@nPrimDescto	NUMERIC	(19,0)	,
		@nVpMercado	NUMERIC	(19,0)	,
		@fTasMercado	FLOAT

	SELECT	@iX		= 1		,
		@dFechoy	= acfecproc	,
		@dFecprox	= acfecprox	,
		@dFecante	= acfecante
	FROM	MDAC

	SELECT @iMesman	= DATEPART(DAY,@dFechoy)*-1
	SELECT @cFecman = CONVERT(CHAR(08),DATEADD(DAY,@iMesman,@dFechoy),112)
	SELECT @dFecman = CONVERT(DATETIME,SUBSTRING(@cFecman,1,4)+SUBSTRING(@cFecman,5,2)+'01')
	SELECT @fIpccal = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFecman

	--*******************************--
	--** Cartera Propia Disponible **--
	--*******************************--

	SELECT	@nContador	= COUNT(*) FROM MDCP WHERE cpnominal>0

	WHILE @iX<=@nContador
	BEGIN
		SELECT	@cInstser	= '*'  
  
--cpvaltasemi,--
		SET ROWCOUNT @iX
		SELECT	@cInstser	= cpinstser		,
			@fNominal	= cpnominal		,
			@fTir		= TIR_COMPRA_ORIGINAL	,
			@iCodigo	= cpcodigo		,
			@dFecemi	= cpfecemi		,
			@dFecven	= cpfecven		,  
			@fTasest	= cptasest		,
			@nValcomp	= valor_compra_original	,
			@fValcomu	= cpvalcomu		,
			@nNumdocu	= cpnumdocu		,
			@nCorrela	= cpcorrela		,
			@nVpresen	= valor_compra_original	,
			@fPvp		= cppvpcomp		,
			@nInteres	= 0			,
			@nReajuste	= 0			,
			@fMT		= 0.0			,
			@fMTUM		= 0.0			,
			@fMT_cien	= 0.0			,
			@fVan		= 0.0			,
			@fVpar		= 0.0			,
			@nNumucup	= 0			,
			@dFecucup	= ''			,
			@fIntucup	= 0.0			,
			@fAmoucup	= 0.0			,
			@fSalucup	= 0.0 			,
			@nNumpcup	= 0			,
			@dFecpcup	= ''			,
			@fIntpcup	= 0.0			,
			@fAmopcup	= 0.0			,
			@fSalpcup	= 0.0			,
			@cSeriado	= cpseriado		,
			@cMascara	= cpmascara		,
			@dFeccomp	= cpfeccomp		,
			@cProg		= 'SP_'+inprog		,
			@fDurat		= 0.0			,
			@fConvx		= 0.0			,
			@fDurmo		= 0.0			,
			@fValmon_Hoy= 1.0			,
			@fValmon_Man= 1.0			,
			@fValmon_Com= 1.0			,
			@iMonemi 	= 0			,
			@fTasemi	= 0.0			,
			@fBasemi	= 0.0			,
			@fTasest	= 0.0			,
			@fTe_pcduf	= 0.0			,
			@nError		= 0			,
			@iBusca		= 0			,
			@iModcal	= CASE
						WHEN cpcodigo=1 OR cpcodigo=2 THEN 1
						ELSE 2
					  END
		FROM	MDCP, VIEW_INSTRUMENTO
		WHERE	cpnominal>0 AND cpfecven>@dFechoy AND cpcodigo=incodigo
			
		SET ROWCOUNT 0
  
		SELECT @iX = @iX + 1
 
		IF @cInstser='*'
			BREAK
  
		IF @cSeriado='S'
			SELECT	@fTasemi	= setasemi	,  
			 	@iMonemi	= semonemi	,  
			 	@fBasemi	= sebasemi  
			FROM	VIEW_SERIE  
			WHERE	semascara=@cMascara  
		ELSE  
		BEGIN  
			SET ROWCOUNT 1  
			SELECT	@fTasemi	= nstasemi	,
				@iMonemi	= nsmonemi	,
				@fBasemi	= nsbasemi
			FROM	VIEW_NOSERIE
			WHERE	nsnumdocu=@nNumdocu AND nscorrela=@nCorrela
			SET ROWCOUNT 0  
		END

		IF @cProg<>'SP_'
		BEGIN
			IF @iMonemi<>999
			BEGIN
				SELECT	@fValmon_Com	= (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFeccomp)
				SELECT	@fValmon_Hoy	= (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFechoy)
				SELECT	@fValmon_Man	= (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFecprox)
				SELECT 	@fTasest 	= CASE  
								WHEN @iCodigo=1 THEN @fTe_pcdus
								WHEN @iCodigo=2 THEN @fTe_pcduf
								WHEN @iCodigo=5 THEN @fTe_ptf
								ELSE CONVERT(FLOAT,0)
							   END
			END

			--********* Valorizacion LCHR Normativa *********--
			--SELECT (SUBSTRING(@cInstser,1,3)),@iCodigo,@dFeccomp
			IF (SUBSTRING(@cInstser,1,3)='COR' OR SUBSTRING(@cInstser,1,3)='BCO') AND @iCodigo = 20 AND @dFeccomp > '20021031'
			BEGIN

				
			/* aL iNICIO*/		
			EXECUTE	@nError  = @cProg  @iModcal, @dFeccomp, @iCodigo, @cInstser, @iMonemi,  @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest, @fNominal OUTPUT,
				@fTir OUTPUT, @fPvp OUTPUT, @fMT OUTPUT, @fMTUM OUTPUT, @fMT_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT, @nNumucup OUTPUT,
				@dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT,
				@fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT, @fDurmo OUTPUT


				DECLARE @Kum 		NUMERIC(19,4),
					@Valparini	NUMERIC(19,0),
					@ValparHOY	NUMERIC(19,0),
					@reajacum	NUMERIC(19,0),
					@interesacum	NUMERIC(19,0),
					@VALCOMP	NUMERIC(19,0),	
					@PRIMADESC	NUMERIC(19,0),
					@VALORPAR	NUMERIC(19,8)	
					
			

				SELECT @VALORPAR= ROUND(@fVpar,8)	
				SELECT @Valparini = ROUND(@fNominal*@fVpar/100*@fValmon_Com,0)
				SELECT @Kum =ROUND(@Valparini/@fValmon_Com,4)
				--SELECT @VALCOMP=ROUND(@fMT,0)
				SELECT @PRIMADESC=ROUND(@nValcomp-@Valparini,0)


				/* a hoy*/
				EXECUTE	@nError  = @cProg  @iModcal, @dFechoy, @iCodigo, @cInstser, @iMonemi,  @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest, @fNominal OUTPUT,
						@fTir OUTPUT, @fPvp OUTPUT, @fMT OUTPUT, @fMT OUTPUT, @fMT_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT, @nNumucup OUTPUT,
						@dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT,
						@fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT, @fDurmo OUTPUT




				SELECT @Valparhoy = ROUND(@fNominal*@fVpar/100*@fValmon_Hoy,0)
				select @reajacum = round(@kum*(@fValmon_Hoy-@fValmon_Com),0)
				select @interesacum =round((@Valparhoy-@reajacum)-@Valparini,0)


			update mdcp set 
				cpvalcomp=@Valparini,
				cpvalcomu=@Kum,
				cpvcum100=@Kum,
				cptircomp =@fTasemi,
				cppvpcomp =100,
				cpvpcomp=100,
				cpvptirc=@valparhoy,
				cpinteresc=@interesacum,
				cpreajustc=@reajacum,
				cpvcompori=@Valparini,
				cpintermes=0,
				cpreajumes=0,
				--valor_compra_original=@VALCOMP,
				valor_compra_um_original=round(@nValcomp/@fValmon_Com,4),
				valor_par_compra_original=@VALORPAR,
				cpprimadesc=@primadesc,
				cpprimdescacum = round((@primadesc/datediff(dd,@dFeccomp,@dFecven))* datediff(dd,@dFeccomp,@dFechoy),0)


			where 
			cpnumdocu=@nNumdocu AND cpcorrela=@nCorrela

			UPDATE	MDDI
				SET	ditircomp	= @fTasemi	,
					dipvpcomp	= 100		,
					dicapitalc	= @nVpresvpar	,
					diinteresc	= @interesacum	,
					direajustc	= @reajacum	,
					divptirc	= @valparhoy	,
					diintermes	= 0		,
					direajumes	= 0
				WHERE	dinumdocu=@nNumdocu AND dicorrela=@nCorrela
					
			END

		END
	END

	SET NOCOUNT OFF
END



GO
