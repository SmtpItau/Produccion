USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CALC_LCHR]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CALC_LCHR]
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
		@nError		INTEGER

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
		@nPagCup	NUMERIC	(19,4)

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

SELECT	cprutcart,
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
INTO	#tempo
	FROM	MDCP, VIEW_SERIE
	WHERE	MDCP.cpmascara= semascara AND MDCP.cpcodigo=20 AND serutemi = 97023000

SELECT * FROM #tempo

/*	IF @@ERROR<>0
	BEGIN
		ROLLBACK TRANSACTION
		SELECT 'NO','No se Puede Generar Tabla Temporal de Paso con CP para Devengamiento'
		RETURN
	END

	SELECT	@iX		= 1	
	SELECT	@nContador	= COUNT(*) FROM #TEMP1 WHERE cpnominal>0

	WHILE @iX<=@nContador
	BEGIN
		SELECT	@cInstser	= '*'

		SET ROWCOUNT @iX
		SELECT  @nRutcart	= cprutcart		,
			@nTipcart	= cptipcart		,
			@cInstser	= cpinstser		,
			@cInstcam	= cpinstser		,
			@fNominal	= cpnominal		,
			@fTir		= cptircomp		,
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
		FROM	#TEMP1, VIEW_INSTRUMENTO
		WHERE	cpcodigo=incodigo
		SET ROWCOUNT 0

		SELECT	@iX = @iX + 1

		IF @cInstser='*'
			BREAK

		SELECT	@fTasemi	= setasemi	,
			@iMonemi	= semonemi	,
			@fBasemi	= sebasemi
		FROM	VIEW_SERIE
		WHERE	semascara=@cMascara

		IF @cCartera='T'
		BEGIN
			SET ROWCOUNT 1
			SELECT	@fTir	= tasa_mercado
			FROM	TASA_MERCADO
			WHERE	fecha_proceso=@dFecpro AND tminstser=@cInstser
			SET ROWCOUNT 0

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

		UPDATE	#TEMP1
		SET	cpvalcomp	= @fMt				,
			cpvalcomu	= ROUND(@fMt/@fValmon_Com,4)	,
			cptircomp	= @fTir				,
			cpfeccomp	= @dFeccal
		WHERE	@nNumdocu = cpnumdocu AND @nCorrela = cpcorrela

--DBO.Sp_Calc_LCHR

		UPDATE	MDCP
		SET	MDCP.cpfeccomp				= A.cpfeccomp,
			MDCP.cpvalcomp       			= A.cpvalcomp,     
			MDCP.cpvalcomu				= A.cpvalcomu,
			MDCP.cptircomp				= A.cptircomp,
			MDCP.cppvpcomp       			= A.cppvpcomp,
			MDCP.cpvpcomp				= A.cpvpcomp ,
			MDCP.cpvptirc				= A.cpvptirc ,
			MDCP.cpcapitalc				= A.cpcapitalc,
			MDCP.cpinteresc				= 0,
			MDCP.cpreajustc				= 0,
			MDCP.cpvcompori				= A.cpvcompori,
			MDCP.cpintermes      			= 0	    ,
			MDCP.cpreajumes      			= 0	    ,
			MDCP.fecha_compra_original       	= A.cpfeccomp ,
			MDCP.valor_compra_original	    	= A.cpvalcomp ,
			MDCP.valor_compra_um_original    	= A.cpvalcomu ,
			MDCP.tir_compra_original         	= A.cptircomp ,
			MDCP.valor_par_compra_original   	= A.cpvpcomp  ,
			MDCP.porcentaje_valor_par_compra_original 	= @fVpar
	FROM #TEMP1 A
	WHERE	MDCP.cpnumdocu = A.cpnumdocu AND MDCP.cpcorrela = A.cpcorrela


		UPDATE	MDDI
		SET	ditircomp	= A.cptircomp ,
			dipvpcomp	= A.cpvpcomp ,
			divptirc	= A.cpvptirc  ,
			dicapitalc	= A.cpvalcomp ,
			diinteresc	= 0         ,
			direajustc	= 0         ,
			diintermes      = 0	    ,   
			direajumes	= 0
		FROM #TEMP1 A
		WHERE	dinumdocu = A.cpnumdocu AND dicorrela = A.cpcorrela

		IF @@ERROR<>0
		BEGIN
			ROLLBACK TRANSACTION
			SELECT 'NO','Problemas al Actualizar Tabla Temporal de Devengamiento'
			RETURN
		END

	END

--select cpnumdocu,cpcorrela,cpinstser,cptircomp,cpnominal,cpvptirc,cpvalcomp,cpvalcomu,cpfeccomp from #TEMP1

	SELECT	'SI','Proceso de Recalculo ha Finalizado de Frma Correcta'

	SET NOCOUNT OFF

	RETURN*/

END

-- Sp_Calc_LCHR
-- select * from mdcp 
-- select * from tasa_mercado where fecha_proceso='20020906'
-- select * from tasa_mercado where tminstser='SUD0010198'
-- select * from tasa_mercado where tminstser='SUD0240600'


-- select * from tasa_mercado where fecha_proceso='20020531' and tmnominal=990
-- select * from tasa_mercado where fecha_proceso='20020531' and tmnominal=1100
-- update tasa_mercado set fecha_proceso='20020906',tminstser='SUD0010198' where  fecha_proceso='20020531' and tmnominal=990
-- update tasa_mercado set fecha_proceso='20020906',tminstser='SUD0240600' where  fecha_proceso='20020531' and tmnominal=1100

-- select * from mdac
-- select name from sysobjects where type='U' and name like '%mdcp'
-- select * from CP


GO
