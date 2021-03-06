USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALC_LCHR_NUEVO]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CALC_LCHR_NUEVO]
AS
BEGIN
	SET NOCOUNT ON

	DECLARE	@cProg		CHAR	(10)	,
		@iModcal	INTEGER		,
		@iCodigo	INTEGER		,
		@cInstser	CHAR	(12)	,
		@iMonemi	INTEGER		,
		@dFecemi	DATETIME	,
		@dFecven	DATETIME	,
		@dFeccal	DATETIME	,
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
		@nError		INTEGER         ,
		@cInstser2	CHAR(12)

	DECLARE @cInstcam	CHAR	(10)	,
		@fNomiReal	FLOAT		,
		@fValmon_Hoy	FLOAT		,
		@fValmon_Man	FLOAT		,
		@fValmon_Com	FLOAT		,
		@fValmon_Cup	FLOAT		,
		@iCupon		INTEGER		,
		@fCapital	FLOAT		,
		@fCapital_UM	FLOAT		,
		@fFactor	FLOAT		,
		@fValcupo	FLOAT		,
		@fIntcupo	FLOAT		,
		@fAmocupo	FLOAT		,
		@nReacup	NUMERIC	(19,4)	,
		@nIntcup	NUMERIC	(19,4)	,
		@nDifcup	NUMERIC (19,4)	,
		@nPagCupo	NUMERIC	(19,4)	,
		@nPagCup	NUMERIC	(19,4)  ,
		@cpvtirc        NUMERIC (19,4)

	DECLARE	@nRutcart	NUMERIC	(09,0)	,
		@nTipcart	NUMERIC	(05,0)	,
		@nNumdocu	NUMERIC	(10,0)	,
		@nNumoper	NUMERIC	(10,0)	,
		@nCorrela	NUMERIC	(03,0)	,
		@nValcomp	NUMERIC	(19,4)	,
		@fValcomu	FLOAT		,
		@dFeccomp	DATETIME	,
		@nVpresen	NUMERIC	(19,4)	,
		@cMascara	CHAR	(10)	,
		@cSeriado	CHAR	(01)	,
		@fTasaFloat	FLOAT		

	DECLARE @nMes		INTEGER		,
		@nAno		INTEGER		,
		@nMes_a		INTEGER		,
		@iAst		INTEGER		,
		@cMes		CHAR	(02)	,
		@cAno		CHAR	(04)	,
		@dFecpro	DATETIME	,
		@sw_contab	CHAR	(01)	,
		@sw_deven	CHAR	(01)	,
		@iX		INTEGER		,
		@nContador	INTEGER		,
		@dFecDevengo	DATETIME	,
		@nValorpara	FLOAT 		,
		@dFechoy	DATETIME	,
		@dFecprox	DATETIME	,
		@cCartera	CHAR	(01)

	SELECT	@dFecpro	= acfecproc	,
		@dFeccal	= acfecproc	,
		@dFechoy	= acfecproc	,
		@dFecprox	= acfecproc
	FROM	MDAC


	SELECT	@iX		= 0

SELECT	 cprutcart,
         cptipcart,
         cpnumdocu,
         cpcorrela,
         cpnumdocuo,
         cpcorrelao,
         cprutcli ,
         cpcodcli,
         cpinstser,
         cpmascara,
         cpnominal,
         cpfeccomp,
         cpvalcomp,
         cpvalcomu,
         cpvcum100,
         cptircomp,
         cptasest,
         cppvpcomp,
         cpvpcomp,
         cpnumucup,
         cpfecemi,
         cpfecven,
         cpseriado,
         cpcodigo,
         cpvptirc,
         cpcapitalc,
         cpinteresc,
         cpreajustc,
         cpcontador,
         cpfecucup,
         cpfecpcup,
         cpvcompori,
         cpdcv,
         cpdurat,
         cpdurmod,
         cpconvex,
         cpintermes,
         cpreajumes,
         fecha_compra_original,
         valor_compra_original,
         valor_compra_um_original,
         tir_compra_original,
         valor_par_compra_original,
         porcentaje_valor_par_compra_original,
         codigo_carterasuper,
         Tipo_Cartera_Financiera,
         Mercado,
         Sucursal,
         Id_Sistema,
         Fecha_PagoMañana,
         Laminas,
         Tipo_Inversion,
         Estado_Operacion_Linea,
         cptipoletra,
         cpforpagi,
         cpvaltasemi,
         cpprimadesc
      INTO	#temporal
      FROM	MDCP, VIEW_SERIE
      WHERE	MDCP.cpmascara= semascara AND MDCP.cpcodigo=20 AND serutemi = 97023000 AND MDCP.cpnominal>0 


	IF @@ERROR<>0
	BEGIN
		ROLLBACK TRANSACTION
		SELECT 'NO','No se Puede Generar Tabla Temporal de Paso con CP para Devengamiento'
		RETURN
	END

	SELECT	@iX		= 1	
	SELECT	@nContador	= COUNT(*) FROM #TEMPORAL WHERE cpnominal>0


	WHILE @iX<=@nContador
	BEGIN
		SELECT	@cInstser	= '*'

		SET ROWCOUNT @iX
		SELECT  @nRutcart	= cprutcart		,
			@nTipcart	= cptipcart		,
			@cInstser	= cpinstser		,
			@cInstser2	= cpinstser		,
			@cInstcam	= cpinstser		,
			@fNominal	= cpnominal		,
			@fTir		= 0  ,  --cptircomp		
			@iCodigo	= cpcodigo		,
			@dFecemi	= cpfecemi		,
			@dFecven	= cpfecven		,
			@nValcomp	= cpvalcomp		,
			@fValcomu	= cpvalcomu		,
			@fPvp		= cppvpcomp		,
			@fMt		= cpvptirc		,
			@fMtum		= 0.0			,
			@fMt_cien	= 0.0			,
			@fVan		= 0.0			,
			@fVpar		= 0.0			,
			@nNumucup	= 0			,
			@dFecucup	= ISNULL(cpfecucup,'')	,
			@fIntucup	= 0.0			,
			@fAmoucup	= 0.0			,
			@fSalucup	= 0.0			,
			@nNumpcup	= 0			,
			@dFecpcup	= ISNULL(cpfecpcup,'')	,
			@fIntpcup	= 0.0			,
			@fAmopcup	= 0.0			,
			@fSalpcup	= 0.0			,
			@iAst		= 0			,
			@cSeriado	= cpseriado		,
			@cMascara	= cpmascara		,
			@dFeccomp	= cpfeccomp		,
			@cProg		= 'SP_'+inprog		,
			@fDurat		= 0.0			,
			@fConvx		= 0.0			,
			@fDurmo		= 0.0			,
			@fValmon_Hoy	= 1.0			,
			@fValmon_Man	= 1.0			,
			@fValmon_Com	= 1.0			,
			@fValmon_Cup	= 1.0			,
			@iMonemi	= 0			,
			@fTasemi	= 0.0			,
			@fBasemi	= 0.0			,
			@fTasest	= 0.0			,
			@nError		= 0			,
			@fTasaFloat	= 0.0			,
			@iModcal	= 3			,
			@fAmocupo	= 0.0			,
			@fIntcupo	= 0.0			,
			@nReacup	= 0.0			,
			@nPagcup	= 0.0			,
			@fAmocupo	= 0.0			,
			@fValcupo	= 0.0			,
			@nIntcup	= 0.0			,
			@nReacup	= 0.0			,
			@nPagcup	= 0.0			,
			@nNumdocu	= cpnumdocu		,
			@nCorrela	= cpcorrela		,
			@cCartera	= codigo_carterasuper
		FROM	#TEMPORAL, VIEW_INSTRUMENTO
		WHERE	cpcodigo=incodigo
		SET ROWCOUNT 0


		SELECT	@iX = @iX + 1


		IF  CONVERT(CHAR(08),@dFeccomp,112) ='20021031'
		BEGIN
			SET ROWCOUNT 1
			SELECT	@cInstser	= cpinstser
			FROM	bacuser.MDCP1030
			WHERE	cpnumdocu = @nNumdocu and cpcorrela = @nCorrela and cpcodigo = 20
			SET ROWCOUNT 0

		END


		IF @cInstser='*'
			BREAK

		SELECT	@fTasemi	= setasemi	,
			@iMonemi	= semonemi	,
			@fBasemi	= sebasemi
		FROM	VIEW_SERIE
		WHERE	semascara=@cMascara



		IF @cCartera='T' and CONVERT(CHAR(08),@dFeccomp,112) = '20021031'
		BEGIN
			SET ROWCOUNT 1
			SELECT	@fTir	= tasa_mercado
			FROM	TASA_MERCADO
			WHERE	CONVERT(CHAR(08),fecha_proceso,112) = '20021031' AND tminstser = @cInstser  
			SET ROWCOUNT 0
			SELECT	@iModcal	= 2
		END
		ELSE IF @cCartera='P' and CONVERT(CHAR(08),@dFeccomp,112) = '20021031'
		BEGIN
			SET ROWCOUNT 1
			SELECT	@fTir	= cptircomp
			FROM	bacuser.MDCP1030
			WHERE	cpnumdocu = @nNumdocu and cpcorrela = @nCorrela 
			SET ROWCOUNT 0
			SELECT	@iModcal	= 2
		END
		ELSE IF CONVERT(CHAR(08),@dFeccomp,112) > '20021031' AND CONVERT(CHAR(08),@dFeccomp,112) <= '20030220'
		BEGIN
			SET ROWCOUNT 1
			SELECT	@fTir	= motir
			FROM	bacuser.MDMH_RESPALDO
			WHERE	monumdocu = @nNumdocu and mocorrela = @nCorrela and motipoper = 'cp' and motipopero = 'cp'
			SET ROWCOUNT 0
			SELECT	@iModcal	= 2
		END
		ELSE BEGIN
			SET ROWCOUNT 1
			SELECT	@fTir	= motir
			FROM	MDMH
			WHERE	monumdocu = @nNumdocu and mocorrela = @nCorrela and motipoper = 'cp' and motipopero = 'cp'
			SET ROWCOUNT 0	
			SELECT	@iModcal	= 2
		END
		IF @nNumdocu = 41139
		BEGIN
			SELECT	@fTir	= cptircomp
			FROM	bacuser.MDCP1031
			WHERE	cpnumdocu = @nNumdocu and cpcorrela = @nCorrela 
			SELECT	@iModcal	= 2
		END


		IF (@dFecprox>=@dFecpcup AND @dFecpcup>@dFechoy) AND @iCodigo=20 AND (CHARINDEX('*',@cInstser)<>0 OR CHARINDEX('&',@cInstser)<>0)
		BEGIN
			SELECT	@iAst	= 1
			IF CHARINDEX('*',@cInstser)<>0 --** (*) **--
			BEGIN
				IF SUBSTRING(@cInstser,7,2)='**'
					SELECT	@cInstser	= SUBSTRING(@cInstser,1,6)+' *'+SUBSTRING(@cInstser,9,2)
				ELSE
					SELECT	@cInstser	= SUBSTRING(@cInstser,1,6)+'01'+SUBSTRING(@cInstser,9,2)
			END

			IF CHARINDEX('&',@cInstser)<>0 --** (&) **--
			BEGIN
				IF SUBSTRING(@cInstser,7,2)='&&'
					SELECT	@cInstser	= SUBSTRING(@cInstser,1,6)+' &'+SUBSTRING(@cInstser,9,2)
				ELSE
				BEGIN
					SELECT	@nMes	= CONVERT(INTEGER,SUBSTRING(@cInstser,9,2))
					SELECT	@nMes_a	= DATEPART(MONTH,@dFechoy)

					IF @nMes>@nMes_a
						SELECT	@nAno	= DATEPART(YEAR,@dFechoy) - 1
					ELSE
						SELECT	@nAno	= DATEPART(YEAR,@dFechoy)
					SELECT	@cAno		= CONVERT(CHAR,@nAno)
					SELECT	@cInstser	= SUBSTRING(@cInstser,1,6)+SUBSTRING(@cInstser,9,2)+SUBSTRING(@cAno,3,2)
				END
			END
		END


		IF @cProg<>'SP_'
		BEGIN
			IF @iMonemi<>999
			BEGIN
				SELECT	@fValmon_Hoy	= vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFechoy
				SELECT	@fValmon_Man	= vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFecprox
				SELECT	@fValmon_Com	= vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFeccomp
				SELECT	@fTasest 	= CONVERT(FLOAT,0)
			END
				
			EXECUTE	@nError	= @cProg @iModcal, @dFeccal, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,
					@fNominal OUTPUT, @fTir OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,
					@nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
					@fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT
		END

			--********* Valorizacion LCHR Normativa *********--
			IF (SUBSTRING(@cInstser,1,3)='COR' OR SUBSTRING(@cInstser,1,3)='BCO') AND @iCodigo = 20 --AND CONVERT(CHAR(08),@dFeccomp,112) > '20021031' and CONVERT(CHAR(08),@dFeccomp,112) < '20021231'
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
				SELECT @VALCOMP=ROUND(@fMT,0)
				SELECT @PRIMADESC=ROUND(@Valcomp-@Valparini,0)


				/* a hoy*/

				EXECUTE	@nError  = @cProg  @iModcal, @dFechoy, @iCodigo, @cInstser2, @iMonemi,  @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest, @fNominal OUTPUT,
						@fTir OUTPUT, @fPvp OUTPUT, @fMT OUTPUT, @fMT OUTPUT, @fMT_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT, @nNumucup OUTPUT,
						@dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT,
						@fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT, @fDurmo OUTPUT




				SELECT @Valparhoy = ROUND(@fNominal*@fVpar/100*@fValmon_Hoy,0)   -- valor presente a valor par 100%
				select @reajacum = round(@kum*(@fValmon_Hoy-@fValmon_Com),0)
				select @interesacum =round((@Valparhoy-@reajacum)-@Valparini,0)
                                select @cpvtirc = round(@fMT,0)


	/*	INSERT	CARTPROPIA
		(
			cpnumdocu ,
			cpcorrela , 
			cpinstser ,
			cpmascara ,
			cpnominal , 
			cpfeccomp ,
			cpvalcomp ,
			cpvalcomu ,
			cptircomp ,
			cpvpcomp  ,
			cpvptirc  ,
			cpinteresc,
			cpreajustc,
			cpintermes,
			cpreajumes,
			valor_compra_original,
			valor_compra_um_original,
			tir_compra_original,
			valor_par_compra_original,  	
			porcentaje_valor_par_compra_original, 	
			codigo_carterasuper,
			cpvaltasemi,
			cpprimadesc,
			cpprimdescacum,
			cpinstser2,
			cpfecven
		)

		VALUES
		(
			@nNumdocu  	,
			@nCorrela  	,
			@cInstser  	,
			@cMascara  	,
			@fNominal  	,
			@dFeccomp  	,
			@VALCOMP   	,
			@Kum	   	,
			@ftir	   	,
			100	   	,
			@Valparhoy	,
			@interesacum	,
			@reajacum   	,
			0	    	,
			0		,
			@VALCOMP	,
			round(@Valcomp/@fValmon_Com,4),
			@fTasemi   	,
			@VALORPAR	,
			@fVpar		,
			@cCartera 	,
			@Valparini	,
			@primadesc	,
			round((@primadesc/datediff(dd,@dFeccomp,@dFecven))* datediff(dd,@dFeccomp,@dFechoy),0),
			@cInstser2,
			@dFecven			
		)*/


			UPDATE mdcp SET
				cpvalcomp		=	@Valparini,
				cpvalcomu		=	@Kum,
				cptircomp 		=	@fTasemi,
				cppvpcomp 		=	100,
				cpvpcomp		=	100,
				cpvptirc		=	@valparhoy,
				cpinteresc		=	@interesacum,
				cpreajustc		=	@reajacum,
				cpvcompori		=	@Valparini,
				cpintermes		=	0,
				cpreajumes		=	0,
				valor_compra_original	=	@VALCOMP,
				valor_compra_um_original=	round(@nValcomp/@fValmon_Com,4),
				valor_par_compra_original=	@VALORPAR,
				cpprimadesc		=	@primadesc,
				cpprimdescacum 		= 	round((@primadesc/datediff(dd,@dFeccomp,@dFecven))* datediff(dd,@dFeccomp,@dFechoy),0),
				tir_compra_originaL     = 	@ftir,
				cpvaltasemi             = 	@valcomp
			WHERE
			cpnumdocu=@nNumdocu AND cpcorrela=@nCorrela


			UPDATE	MDDI
				SET	ditircomp	= @fTasemi	,
					dipvpcomp	= 100		,
					dicapitalc	= @Valparini	,
					diinteresc	= @interesacum	,
					direajustc	= @reajacum	,
					divptirc	= @valparhoy	,
					diintermes	= 0		,
					direajumes	= 0
				WHERE	dinumdocu=@nNumdocu AND dicorrela=@nCorrela


		END


		IF @@ERROR<>0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT 'NO','Problemas al Actualizar Tabla Temporal de Devengamiento'
			RETURN
		END

	END

	SELECT	'SI','Proceso de Recalculo ha Finalizado de Forma Correcta'

	SET NOCOUNT OFF

	RETURN
END

GO
