USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GAR_VALORIZACIONMERCADO]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_GAR_VALORIZACIONMERCADO]
		(	@dFecpro        DATETIME
		,   	@Serie          CHAR(12)
		,   	@Emisor         CHAR(10)
		,	@iControl	INTEGER
   		)
AS
BEGIN

	SET NOCOUNT ON		;

	DECLARE	@fTasemi		FLOAT
	,	@fBasemi		FLOAT
	,	@fTasest		FLOAT
	,	@fNominal		FLOAT
	,	@fTir			FLOAT
	,	@fPvp			FLOAT
	,	@fMT			FLOAT
	,	@fMTUM			FLOAT
	,	@fMT_cien		FLOAT
	,	@fVan			FLOAT
	,	@fVpar			FLOAT
	,	@fIntucup		FLOAT
	,	@fAmoucup		FLOAT
	,	@fSalucup		FLOAT
	,	@fIntpcup		FLOAT
	,	@fAmopcup		FLOAT
	,	@fSalpcup		FLOAT
	,	@fDurat			FLOAT
	,	@fConvx			FLOAT
	,	@fDurmo			FLOAT
	,	@fTe_pcdus		FLOAT
	,	@fTe_pcduf		FLOAT
	,	@fTe_ptf		FLOAT
	,	@fTasaMercado		FLOAT
	,	@fTasaMark		FLOAT
	,	@fTasaMark1		FLOAT
	,	@fTasaMark2		FLOAT		;

	DECLARE	@cProg			CHAR(10)
	,	@cInstser		CHAR(10)
	,	@cMascara		CHAR(10)
	,	@cSeriado		CHAR(01)
	,	@cCartSbif		CHAR(01)
	,	@tipoper		CHAR(03)	;

	DECLARE	@iModcal		INTEGER
	,	@nCodigo		INTEGER
	,	@nNumucup		INTEGER
	,	@nNumpcup		INTEGER
	,	@nError			INTEGER
	,	@nMonemi		INTEGER
	,	@ix		      	INTEGER
	,	@nContador	      	INTEGER		;

	DECLARE	@acfecproc		DATETIME
	,	@acfecprox		DATETIME
	,	@dFecemi		DATETIME
	,	@dFecven		DATETIME
	,	@dFecpcup		DATETIME
	,	@dFecucup	      	DATETIME
	,	@dfecfmes	      	DATETIME
	,	@dfec_mdrs	      	DATETIME
	,	@dFecFMesProx      	DATETIME
	,	@dFechaProcVal     	DATETIME	;

	DECLARE	@nRutcart		NUMERIC(09,0)
	,	@nRutemi		NUMERIC(09,0)
	,	@nNumdocu		NUMERIC(10,0)
	,	@nNumoper		NUMERIC(10,0)
	,	@nCorrela		NUMERIC(03,0)
	,	@nVpresen		NUMERIC(19,4)
	,	@nValMercado		NUMERIC(19,4)
	,	@nValMercadoProx	NUMERIC(19,4)
	,	@nValMark		NUMERIC(19,4)
	,	@nValMark1		NUMERIC(19,4)
	,	@nValMark2		NUMERIC(19,4)
	,	@nDifValMerc		NUMERIC(19,4)
	,	@dDifTasMark		NUMERIC(19,4)
	,	@dDifTasMark1		NUMERIC(19,4)
	,	@dDifTasMark2		NUMERIC(19,4)	;


	IF @iControl = 1 
	BEGIN
		DELETE FROM bacparamsuda.dbo.tbl_ValMercado_Garantia 
		 WHERE FechaValoriza = @dFecpro
	END				  
		

	SELECT @acfecproc = acfecproc
	,      @acfecprox = acfecprox
	  FROM MDAC					;

	
	SET @dfecfmes     = DATEADD(DAY,DATEPART(DAY,@acfecprox)* -1,@acfecprox)		     	-- Primer dia del mes siguiente
	SET @dFecFMesProx = DATEADD( MONTH, 1, @acfecprox )				     		-- Suma 1 mes a la fecha proxima que deberia ser el primer dia habil del mes siguiente
	SET @dFecFMesProx = DATEADD( DAY, DATEPART( DAY, @dFecFMesProx ) * -1, @dFecFMesProx ) 		-- fin de mes siguiente

		
	IF @acfecproc = @dFecpro OR (DATEPART(MONTH,@acfecproc) <> DATEPART(MONTH,@acfecprox) AND @dfecfmes = @dFecpro) 
	BEGIN


     
		CREATE TABLE #TMP_CART
		(	cpinstser		CHAR(12)
		,   	cptircomp		NUMERIC(19,4)
		,   	cpcodigo		NUMERIC(05,0)
		,   	cpfecemi		DATETIME
		,   	cpfecven		DATETIME 
		,   	cptasest		FLOAT
		,   	cpnominal		NUMERIC(19,4)
		,   	tmrutemis		NUMERIC(09,0)
		,   	tasa_mercado		NUMERIC(08,4)
		,   	tasa_market		NUMERIC(08,4)
		,   	tasa_market1		NUMERIC(08,4)
		,   	tasa_market2		NUMERIC(08,4)
		,   	cpvptirc		NUMERIC(19,4)
		,   	cpfecucup		DATETIME
		,   	cpfecpcup		DATETIME
		,   	cpseriado		CHAR(01)
		,   	cprutcart		NUMERIC(09,0)
		,   	cpnumdocu		NUMERIC(10,0)
		,   	cpcorrela		NUMERIC(03,0)
		,   	cpmascara		CHAR(12)
		,	cpmoneda		NUMERIC(3)
		,	cpbase			NUMERIC(3)
		,   	sw			CHAR(01)
      		);
					
		INSERT INTO #TMP_CART				
		(	cpinstser            
		,   	cptircomp            
		,   	cpcodigo             
		,   	cpfecemi             
		,   	cpfecven             
		,   	cpnominal            	
		,   	tmrutemis            
		,   	tasa_mercado         
		,   	tasa_market          
		,   	tasa_market1         
		,   	tasa_market2         
		,   	cpvptirc             
		,   	cpseriado            
		,   	cprutcart            
		,   	cpnumdocu            
		,   	cpcorrela            
		,   	cpmascara   
		,	cpmoneda         
		,	cpbase
		,   	sw                   
		)
		SELECT 	car.Instrumento	             
		,	car.TIR               
		,	codigo                  
		,	FechaEmision
		,	FechaVencimiento              
		,	car.Nominal          
		,	rutEmision
		,	TM.tasa_mercado	
		,	TM.tasa_market	
		,	TM.tasa_market1	
		,	TM.tasa_market2
		,	car.ValorPresente            
		,	Seriado                 
		,	tmrutcart                 
		,	car.NumeroOperacion
		,	car.Correlativo           
		,	car.Mascara                 
		,	MonedaEmision
		,	BaseEmision
		,	'N' 
		   FROM BACPARAMSUDA.DBO.TBL_CARTERA_GARANTIA car
		  INNER 
		   JOIN BACPARAMSUDA.DBO.tbl_mov_garantia_detalle  det
		     ON car.NumeroOperacion = det.NumeroOperacion
		    AND Car.Correlativo =  Det.Correlativo
		    AND Car.Instrumento = @Serie
      		  INNER 
		   JOIN TASA_MERCADO tm
		    ON  tminstser             = car.instrumento
		    AND fecha_proceso         = @dFecpro
		    AND tminstser             = @Serie
		    AND tmgenemis	      = @Emisor


			WHILE 1 = 1 
			BEGIN
				SELECT @cInstser	= '*'
				SET ROWCOUNT 1
	
					SELECT 	@cInstser	  = cpinstser
					,	@fTir		 = cptircomp
					,	@nCodigo	 = cpcodigo
					,	@dFecemi	 = cpfecemi
					,	@dFecven	 = cpfecven
					,	@fTasest	 = 0
					,	@fNominal	 = cpnominal
					,	@nRutemi	 = tmrutemis
					,	@fTasaMercado	 = tasa_mercado
					,	@fTasaMark	 = tasa_market
					,	@fTasaMark1	 = tasa_market1
					,	@fTasaMark2	 = tasa_market2
					,	@nVpresen	 = cpvptirc
					,	@nValMercado	 = 0.0
					,	@nValMark	 = 0.0
					,	@nValMark1	 = 0.0
					,	@nValMark2	 = 0.0
					,	@nDifValMerc	 = 0.0
					,	@dDifTasMark	 = 0.0
					,	@dDifTasMark1	 = 0.0
					,	@dDifTasMark2	 = 0.0
					,	@fMt		 = 0.0
					,	@fMtum		 = 0.0
					,	@fMt_cien	 = 0.0
					,	@fVan		 = 0.0
					,	@fVpar		 = 0.0
					,	@nNumucup	 = 0
					,	@dFecucup	 = ''
					,	@fIntucup	 = 0.0
					,	@fAmoucup	 = 0.0
					,	@fSalucup	 = 0.0
					,	@nNumpcup	 = 0
					,	@dFecpcup	 = ''
					,	@fIntpcup	 = 0.0
					,	@fAmopcup	 = 0.0
					,	@fSalpcup	 = 0.0
					,	@cSeriado	 = cpseriado
					,	@nRutcart	 = cprutcart
					,	@nNumdocu	 = cpnumdocu
					,	@nNumoper	 = cpnumdocu
					,	@nCorrela        = cpcorrela
					,	@cMascara 	 = cpmascara
					,	@nMonemi	 = Cpmoneda
					,	@fBasemi	= cpbase
					   FROM #tmp_cart
					  WHERE sw                 = 'N'
	
					SET ROWCOUNT 0
	
					IF @cInstser='*'	BREAK
							
					IF @cSeriado = 'S' 
					BEGIN
						SELECT @fTasemi  = setasemi	
						  FROM VIEW_SERIE
						 WHERE semascara = @cMascara
					END ELSE
					BEGIN
						SELECT @fTasemi = 0
					END
	
					SELECT @cProg   = 'SP_' + inprog 
					  FROM VIEW_INSTRUMENTO
					 WHERE incodigo = @nCodigo
	
					IF @cProg <> 'SP_' 
					BEGIN
						SELECT @fTasest = CASE 	WHEN @nCodigo = 1 THEN @fTe_pcdus
	                                         			WHEN @nCodigo = 2 THEN @fTe_pcduf
	                                         			WHEN @nCodigo = 5 THEN @fTe_ptf
	                                         			ELSE CONVERT(FLOAT,0)
	                                    				END
							
						SET @nValMercado = @nVpresen
	
						IF @fTasaMercado <> 0
						BEGIN --** Valorizaci¢n a Tasa de Mercado **--

							EXECUTE @nError = @cProg 2, @acfecprox, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
							, @fNominal OUTPUT, @fTasaMercado OUTPUT, @fPvp     OUTPUT, @fMt     OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
							, @fVan     OUTPUT, @fVpar        OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
							, @fSalucup OUTPUT, @nNumpcup     OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
							, @fDurat   OUTPUT, @fConvx       OUTPUT, @fDurmo   OUTPUT
	
							SELECT @nValMercadoProx = @fMt
	

							EXECUTE @nError = @cProg 2, @dFecpro, @nCodigo, @cInstser, @nMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
							, @fNominal OUTPUT, @fTasaMercado OUTPUT, @fPvp     OUTPUT, @fMt     OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT
							, @fVan     OUTPUT, @fVpar        OUTPUT, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT
							, @fSalucup OUTPUT, @nNumpcup     OUTPUT, @dFecpcup OUTPUT, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT
							, @fDurat   OUTPUT, @fConvx       OUTPUT, @fDurmo   OUTPUT
	
							SELECT @nValMercado = @fMt
						END
						
					
						INSERT INTO bacparamsuda.dbo.tbl_ValMercado_Garantia
						(	FechaValoriza
						,	NumeroOperacion
						,	Correlativo
						,	Instrumento
						,	Mascara
						,	Nominal
						,	TIR
						,	ValorPresenteHoy
						,	ValorPresenteProx
						,	Duration
						,	DurationMod
						,	convexidad
						)
						VALUES	
						(	@dFecpro
						,	@nNumdocu
						,	@nCorrela
						,	@cInstser
						,	@cInstser				
						,	@fNominal
						,	@fTasaMercado
						,	@nValMercado
						,	@nValMercadoProx
						,	@fDurat
						,	@fDurmo
						,	@fConvx
						)


						UPDATE #tmp_cart
						   SET    sw        = 'S'
						 WHERE @nNumdocu = cpnumdocu
						   AND @nNumoper = cpnumdocu
						   AND @nCorrela = cpcorrela
					END
				END
			END			


	END


GO
