USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVPROPIAINTRAMESA]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_DEVPROPIAINTRAMESA]
   (   @dFechoy        DATETIME
   ,   @dFecprox       DATETIME
   ,   @cDevengo_dolar CHAR(01)
   )
AS
BEGIN

	SET NOCOUNT ON    ;
            
    	DECLARE @TipDev			CHAR(03)
    	,	@cProg               	CHAR(10)
    	,       @cInstser            	CHAR(10)
    	,       @cInstcam            	CHAR(10)
    	,	@cMascara            	CHAR(10)
    	,	@cSeriado            	CHAR(01)
	,	@cCartera            	CHAR(03)
	,	@cMes                	CHAR(02)
	,	@cAno                	CHAR(04)
	,	@sw_contab           	CHAR(01)
	,	@sw_deven            	CHAR(01)
	,	@cTipo_Moneda_papel  	CHAR(01)	;

	DECLARE	@fTasaFloaT		FLOAT
	,	@fValcomu       	FLOAT
	,	@nValorpara          	FLOAT
	,	@fIpc_Mes            	FLOAT
	,	@fIpc_Hoy            	FLOAT
	,	@fIpc_cp             	FLOAT
	,	@fIpc_in             	FLOAT
	,	@fIpc_pr             	FLOAT
	,	@fVparDEV            	FLOAT
	,	@fNocionalPm         	FLOAT
	,	@fTasemi             	FLOAT
	,	@fBasemi             	FLOAT
	,	@fTasest             	FLOAT
	,	@fNominal            	FLOAT
	,	@fTir                	FLOAT
	,	@fTirBCaps           	FLOAT
	,	@fPvp                	FLOAT
	,	@fMT                 	FLOAT
	,	@fMTUM               	FLOAT
	,	@fMT_cien            	FLOAT
	,	@fVan                	FLOAT
	,	@fVpar               	FLOAT
	,	@fIntucup            	FLOAT
	,	@fAmoucup            	FLOAT
	,	@fSalucup            	FLOAT
	,	@fIntpcup            	FLOAT
	,	@fAmopcup            	FLOAT
	,	@fSalpcup            	FLOAT
	,	@fDurat              	FLOAT
	,	@fConvx              	FLOAT
	,	@fDurmo              	FLOAT
	,	@fNomiReal           	FLOAT
	,	@fValmon_Hoy         	FLOAT
	,	@fValmon_Man         	FLOAT
	,	@fValmon_Com         	FLOAT
	,	@fValmon_Cup         	FLOAT
	,	@fCapital            	FLOAT
	,	@fCapital_UM         	FLOAT
	,	@fFactor             	FLOAT
	,	@fValcupo            	FLOAT
	,	@fIntcupo            	FLOAT
	,	@fAmocupo            	FLOAT
	,	@fMonto              	FLOAT		
	,   	@fTe_pcdus      	FLOAT
	,   	@fTe_pcduf      	FLOAT
	,   	@fTe_ptf        	FLOAT	;
	


	DECLARE	@iCupon              	INTEGER
	,	@iModcal             	INTEGER
	,	@iCodigo             	INTEGER
	,	@iMonemi             	INTEGER
	,	@nNumucup            	INTEGER
	,	@nNumpcup            	INTEGER
	,	@nError              	INTEGER
	,	@nMes                	INTEGER
	,	@nAno                	INTEGER
	,	@nMes_a              	INTEGER
	,	@iAst                	INTEGER
	,	@iPago_Nohabil       	INTEGER
	,	@iX                  	INTEGER
	,	@nContador           	INTEGER
	,	@nDecimal	     	INTEGER		;

	
	DECLARE	@dFecemi		DATETIME
	,	@dFecven             	DATETIME
	,	@dFeccal             	DATETIME
	,	@dFecucup            	DATETIME
	,	@dFecpcup            	DATETIME
	,	@dFeccomp            	DATETIME
	,	@dFecpro             	DATETIME
	,	@dFecDevengo         	DATETIME
	,	@dFec_cp             	DATETIME
	,	@dFec_in             	DATETIME
	,	@dFec_pr             	DATETIME
	,	@dFechaLiquida       	DATETIME	;


	DECLARE	@nReacup             	NUMERIC(19,4)
	,	@nIntcup             	NUMERIC(19,4)
	,	@nDifcup             	NUMERIC(19,4)
	,	@nPagCupo            	NUMERIC(19,4)
	,	@nPagCup             	NUMERIC(19,4)
	,	@nVpresen            	NUMERIC(19,4)
	,	@nDifReaCup          	NUMERIC(19,0)
	,	@nIntdif             	NUMERIC(19,0)
	,	@nIntPordia          	NUMERIC(19,0)
	,	@nInteres_RealCup    	NUMERIC(19,0)
	,	@nRutcart            	NUMERIC(09,0)
	,	@nTipcart            	NUMERIC(05,0)
	,	@nNumdocu            	NUMERIC(10,0)
	,	@nNumoper            	NUMERIC(10,0)
	,	@nCorrela            	NUMERIC(03,0)
	,	@nValcomp            	NUMERIC(19,4)
	,	@nInteres            	NUMERIC(19,4)
	,	@nReajuste         	NUMERIC(19,0)
	,	@nIntMes            	NUMERIC(19,4)
	,	@nReaMes          	NUMERIC(19,0)
	,	@nIntdia          	NUMERIC(19,4)
	,	@nReadia             	NUMERIC(19,0)
	,	@nValoraTasaEmi      	NUMERIC(19,4)
	,	@nPrimaDctoTot       	NUMERIC(19,0)
	,	@nPrimaDctoDia       	NUMERIC(19,0)
	,	@frutemis            	NUMERIC(09,0)
	,	@valorpar_lchr       	NUMERIC(19,4)
	,	@nInteresvpar        	NUMERIC(19,0)
	,	@xx		     	NUMERIC(18,4)
	,	@xx1		     	NUMERIC(18,4)
	,	@nPrimaDesc	     	NUMERIC(19,4)
	,	@nRea_cp             	NUMERIC(19,0)
	,	@nRea_pr             	NUMERIC(19,0)
	,	@nRutBanco	     	NUMERIC(09,0)
	,	@nCodBanco           	NUMERIC(05,0)	;

	SET @iX    = 0  
	SET @nMes  = 0  
	SET @cMes  = ''
            
	SET @fIpc_hoy = (SELECT  vmvalor 
			   FROM VIEW_VALOR_MONEDA 
			  WHERE vmcodigo = 502 
       			    AND vmfecha = DATEADD(MONTH, -1, DATEADD(DAY,(DATEPART(DAY,@dFechoy) * -1) +1, @dFechoy)) )	;

	SET @fIpc_hoy = ISNULL(@fIpc_hoy, @fIpc_Mes)

	IF @fIpc_hoy = 0.0  SET @fIpc_hoy = @fIpc_Mes

    --> Se realiza la validaci¢n de las monedas necesarias para procesar devengamiento **--
	IF @cDevengo_dolar = 'N'
	BEGIN  
		DELETE 
		  FROM tbl_resticketrtafija 
		 WHERE fecha_operacion   = @dFecprox 
		   AND tipo_resultado= 'DEV'
            	   AND (moneda    = 999 OR 
			moneda    = 998 OR
			moneda    = 997 OR
			moneda   = 13)

		IF @@ERROR<>0
		BEGIN
			SELECT 'NO','No se pudieron eliminar registros de tabla Resultado'
			RETURN
		END
	END ELSE
	BEGIN
		DELETE 
		  FROM tbl_resticketrtafija 
		 WHERE fecha_operacion   = @dFecprox 
		   AND tipo_resultado= 'DEV'
            	   AND (moneda   <> 999 OR 
			moneda   <> 998 OR
			moneda   <> 997 OR
			moneda  <> 13)

		IF @@ERROR<>0
		BEGIN
			SELECT 'NO','No se pudieron eliminar registros de tabla Resultado'
			RETURN
		END
	END

   --> SELECT * FROM TBL_CARTICKETRTAFIJA

	SELECT  'rutcart'	= 0
	,	'tipcart'	= 0
	,	'instser'	= mov.Nemotecnico
	,	'instcam'	= mov.Nemotecnico
	,	'mascara'	= mov.Mascara
	,	'feccomp'	= mov.Fecha_Operacion
	,	'tircomp'	= mov.tir
	,	'nominal'	= mov.valor_nominal
	,	'valcomp'	= mov.valor_compra
	,	'valcomu'	= mov.valor_compra_um
	,	'intdia'	= CONVERT(NUMERIC(19,4),0)
	,	'readia'	= CONVERT(NUMERIC(19,4),0)
	,	'interes'	= CONVERT(NUMERIC(19,4),0)
	,	'reajuste'      = CONVERT(NUMERIC(19,4),0)
	,	'interesmes'    = CONVERT(NUMERIC(19,4),0)
	,	'reajustemes'   = CONVERT(NUMERIC(19,4),0)
	,	'readifmes'     = CONVERT(NUMERIC(19,4),0)
	,	'seriado'	= mov.seriado
	,	'codigo'	= mov.CodigoInstrumento
	,	'valptehoy'     = mov.valor_presente
	,	'valpteman'     = CONVERT(NUMERIC(19,2),0)
	,	'amocup'	= CONVERT(FLOAT,0)
	,	'intcup'	= CONVERT(FLOAT,0)
	,	'reacup'	= CONVERT(FLOAT,0)
	,	'flujo'	  	= CONVERT(FLOAT,0)
	,	'duration'     	= CONVERT(FLOAT,0)
	,	'durmodif'     	= CONVERT(FLOAT,0)
	,	'convex'	= CONVERT(FLOAT,0)
	,	'tasa_float'   	= CONVERT(FLOAT,0)
	,	'monemi'	= CONVERT(INTEGER,0)
	,	'basemi'	= CONVERT(FLOAT,0)
	,	'tasemi'	= CONVERT(FLOAT,0)
	,	'fecemi'	= dmov.Fecha_Emision
	,	'fecven'	= mov.Fecha_Vencimiento
	,	'cupon'	  	= CONVERT(INTEGER,0)
	,	'pvpcomp'	= (CASE WHEN LEFT(mov.Nemotecnico, 4 ) = 'BCAP' THEN mov.pvp ELSE CONVERT(FLOAT,0) END)
	,	'numucup'	= CONVERT(FLOAT,0)
	,	'numpcup'	= CONVERT(FLOAT,0)
	,	'fecucup'	= mov.FechaUltCupon
	,	'fecpcup'	= mov.FechaProxCupon
	,	'condpacto'    	= CONVERT(CHAR(01),'')
	,	'flag'	   	= CONVERT(CHAR(01),'N')
	,	'cup'	    	= CONVERT(FLOAT,0)
	,	'numdocu'	= mov.numero_documento
	,	'correla'	= mov.correlativo
	,	'PrimaDcto'    	= mov.Valor_PrimaDescto
	,	'tasaEmis'     	= mov.Valor_Tasa_Emision
	,	'valordia'     	= CONVERT(FLOAT,0)
	,	'valorpar'     	= CONVERT(FLOAT,0)
	,	'Moneda_papel' 	= CONVERT(CHAR(01),'')
	,	'Decimales'	= CONVERT(INTEGER,0)
	,	'Nreg'	   	= CONVERT(NUMERIC(10),0)
	,	'FechaLiquida' 	= CASE WHEN dmov.Fecha_Activacion> @dFechoy THEN dmov.Fecha_activacion ELSE @dFechoy END
	,	'VentaPM'	= 'N'
	,	'TipoDev'	= CAST( 'DEV' AS CHAR(03) )
	  INTO #TEMPORAL_INTRA
	FROM tbl_carticketrtafija mov
	 INNER 
	  JOIN tbl_movticketrtafija dmov
	    ON dmov.tipo_operacion ='CP' 
	   AND dmov.numero_documento = mov.numero_documento
	   AND dmov.correlativo     = mov.correlativo
	 WHERE mov.valor_nominal > 0 
	   AND mov.Fecha_Vencimiento >= @dFechoy

	IF @@ERROR<>0
	BEGIN
		SELECT 'NO','No se Puede Generar Tabla Temporal de Paso con CP para Devengamiento'
		RETURN
	END

	IF @dFechoy <> @dFecpro
	BEGIN
		SELECT 	'rscartera'       = '111'
		,   	'rstipopero'      = 'CP'
		,   	'rsfecha'         = fecha_operacion
		,   	'rsrutcart'       = 1
		,   	'rsnumdocu'       = numero_documento
		,   	'rscorrela'       = correlativo
		,   	'rsnominal'       = valor_nominal
		,   	'rsvalcomp'       = valor_compra
		,   	'rsvalcomu'       = valor_compra_um
		,   	'rsvppresenx'     = Valor_Presente_Hoy
		,   	'rsinteres_acum'  = Interes_Acumulado
		,   	'rsreajuste_acum' = Reajuste_Acumulado
		,   	'rsintermes'      = Interes_mes
		,   	'rsreajumes'      = Reajuste_mes
		,   	'rstipoper'       = tipo_resultado
		   INTO #TMPRS_TMP
	   	   FROM tbl_resticketrtafija
		  WHERE Fecha_Operacion = @dFecHoy 
		    AND tipo_resultado = 'DEV' 

	
		IF @@ERROR<>0
		BEGIN
			SELECT 'NO', 'No se Puede obtener el devengamiento de fin de mes'
			RETURN
		END
	
		UPDATE #TEMPORAL_INTRA
		SET    valptehoy   = rsvppresenx
		,      interes     = rsinteres_acum
		,      reajuste    = rsreajuste_acum
		,      interesmes  = rsintermes
		,      reajustemes = rsreajumes
		FROM   #TMPRS_TMP
		WHERE  rsfecha     = @dFecHoy
		AND    rscartera   = '111' 
		AND    rstipopero  = 'CP' 
		AND    rutcart     = rsrutcart
		AND    numdocu     = rsnumdocu
		AND    correla     = rscorrela
		AND    rsTipOper   = TipoDev
	
		IF @@ERROR <> 0
		BEGIN
			SELECT 'NO', 'No se Puede actualizar el devengamiento de fin de mes'
			RETURN
		END
	END
	
	DELETE FROM #TEMPORAL_INTRA WHERE nominal <= 0 

	UPDATE #TEMPORAL_INTRA
	SET    monemi    = semonemi
	,      basemi    = sebasemi
	,      tasemi    = setasemi
	  FROM VIEW_SERIE
         WHERE semascara = Mascara 
           AND seriado   = 'S'

	UPDATE #TEMPORAL_INTRA
   	   SET tasemi    = nstasemi
	,      monemi    = nsmonemi
	,      basemi    = nsbasemi
	  FROM VIEW_NOSERIE
	 WHERE seriado   = 'N'
	   AND rutcart   = nsrutcart
	   AND numdocu   = nsnumdocu
	   AND correla   = nscorrela

	IF @cDevengo_dolar = 'N'
	BEGIN
		DELETE 
		  FROM #temporal_INTRA 
		 WHERE monemi <> 999 
		   AND monemi <> 998 
		   AND monemi <> 997 
		   AND monemi <> 13 
	END ELSE
	BEGIN
		DELETE 
		  FROM #temporal_INTRA
            	 WHERE (monemi = 999 OR 
			monemi = 998 OR 
			monemi = 997 OR 
			monemi = 13) 
	END

	SELECT *,'nRegi'= IDENTITY(NUMERIC(10)) INTO #TEMPORAL22 FROM #TEMPORAL_INTRA

	DELETE FROM #TEMPORAL_INTRA

	INSERT INTO #TEMPORAL_INTRA
	SELECT rutcart,    tipcart,     instser,   instcam,   mascara,  feccomp,   tircomp,   nominal,      valcomp,   valcomu, intdia,  readia,   interes,   reajuste
	       ,  interesmes, reajustemes, readifmes, seriado,   codigo,   valptehoy, valpteman, amocup,       intcup,    reacup,  flujo,   duration, durmodif,  convex
	       ,  tasa_float, monemi,      basemi,    tasemi,    fecemi,   fecven,    cupon,     pvpcomp,      numucup,   numpcup, fecucup, fecpcup,  condpacto, flag
	       ,  cup,        numdocu,     correla,   PrimaDcto, tasaEmis, valordia,  valorpar,  Moneda_papel, Decimales, nRegi,   FechaLiquida, VentaPM, TipoDev
	   FROM #TEMPORAL22 
	ORDER BY nRegi

	SET @iX        = 0
	SET @nContador = (SELECT MAX(Nreg) FROM #TEMPORAL_INTRA)

	WHILE @iX<=@nContador
	BEGIN
		SET @iX                = @iX + 1
		SET @cInstser          = '*'

		SELECT @nRutcart          = rutcart
		,      @nTipcart          = tipcart
		,      @cInstser          = instser
		,      @cInstcam          = instser
		,      @fNominal          = nominal
		,      @fTir              = tircomp
		,      @iCodigo           = codigo
		,      @dFecemi           = fecemi
		,      @dFecven           = fecven
		,      @fTasest           = tasa_float
		,      @nValcomp          = valcomp
		,      @fValcomu          = valcomu
		,      @nVpresen          = valptehoy
		,      @nIntMes           = interesmes
		,      @nReaMes           = reajustemes
		,      @nInteres          = interes
		,      @nReajuste         = reajuste
		,      @fPvp              = pvpcomp
		,      @fMt               = 0.0
		,      @fMtum             = 0.0
		,      @fMt_cien          = 0.0
		,      @fVan              = 0.0
		,      @fVpar             = 0.0
		,      @nNumucup          = 0
		,      @dFecucup          = ISNULL(fecucup,'')
		,      @fIntucup          = 0.0
		,      @fAmoucup          = 0.0
		,      @fSalucup          = 0.0
		,      @nNumpcup          = 0
		,      @dFecpcup          = ISNULL(fecpcup,'')
		,      @fIntpcup          = 0.0
		,      @fAmopcup          = 0.0
		,      @fSalpcup          = 0.0
		,      @iAst              = 0
		,      @iPago_NoHabil     = 0
		,      @cSeriado          = seriado
		,      @cMascara          = mascara
		,      @dFeccomp          = feccomp
		,      @cProg             = 'SP_' + inprog
		,      @fDurat            = 0.0
		,      @fConvx            = 0.0
		,      @fDurmo            = 0.0
		,      @fValmon_Hoy       = 1.0
		,      @fValmon_Man       = 1.0
		,      @fValmon_Com       = 1.0
		,      @fValmon_Cup       = 1.0
		,      @iMonemi           = monemi
		,      @fTasemi           = tasemi
		,      @fBasemi           = basemi
		,      @fTasest           = 0.0
		,      @nError            = 0
		,      @iCupon            = 0
		,      @fTasaFloat        = 0.0
		,      @iModcal           = 2
		,      @fAmocupo          = 0.0
		,      @fIntcupo          = 0.0
		,      @nReacup           = 0.0
		,      @nDifReaCup        = 0.0
		,      @nPagcup           = 0.0
		,      @fAmocupo          = 0.0
		,      @fValcupo          = 0.0
		,      @nIntcup           = 0.0
		,      @nReacup           = 0.0
		,      @nPagcup           = 0.0
		,      @nIntdia           = 0.0
		,      @nReadia           = 0.0
		,      @fMonto            = 0.0
		,      @nIntdif           = 0.0
		,      @nNumdocu          = numdocu
		,      @nCorrela          = correla
		,      @nPrimaDctoDia     = 0
		,      @nValoraTasaEmi    = tasaEmis
		,      @nPrimaDctoTot     = PrimaDcto
		,      @valorpar_lchr     = 0
		,      @dFechaLiquida     = FechaLiquida
		  FROM #TEMPORAL_INTRA
		,      	VIEW_INSTRUMENTO
		 WHERE  codigo             = incodigo 
		   AND  Nreg               = @iX   

		IF @cInstser = '*'
    		BEGIN
        		BREAK
    		END

		IF @cSeriado = 'S'
			SELECT @fTasemi  = setasemi 
			,      @iMonemi  = semonemi 
			,      @fBasemi  = sebasemi 
			,      @frutemis = serutemi
			  FROM VIEW_SERIE
			 WHERE semascara = @cMascara
		ELSE BEGIN
			SELECT TOP 1 @fTasemi  = nstasemi    
			,      @iMonemi  = nsmonemi 
			,      @fBasemi  = nsbasemi 
-->			,      @dFecemi  = nsfecemi 
			,      @frutemis = 97032000
			  FROM VIEW_NOSERIE 
		    	 WHERE nsserie = @cInstser
			   AND nsfecven >=@dFecHoy
		END

		SELECT @cTipo_Moneda_papel = CASE WHEN mnmx = 'C' THEN '0' ELSE '1' END
		,      @nDecimal           = mndecimal
		  FROM VIEW_MONEDA
      		 WHERE mncodmon = @iMonemi

		IF (@dFecprox >= @dFecpcup AND @dFecpcup > @dFechoy) AND @iCodigo = 20 AND (CHARINDEX('*',@cInstser) <> 0 OR CHARINDEX('&',@cInstser) <> 0)
		BEGIN
			SET @iAst = 1

			IF CHARINDEX('*',@cInstser) <> 0 
			BEGIN
				IF SUBSTRING(@cInstser,7,2)='**'
					SET @cInstser = SUBSTRING(@cInstser,1,6)+' *'+SUBSTRING(@cInstser,9,2)
				ELSE
					SET @cInstser = SUBSTRING(@cInstser,1,6)+'01'+SUBSTRING(@cInstser,9,2)
			END

			IF CHARINDEX('&',@cInstser)<>0 --** (&) **--
			BEGIN
				IF SUBSTRING(@cInstser,7,2)='&&'
					SET @cInstser = SUBSTRING(@cInstser,1,6)+' &'+SUBSTRING(@cInstser,9,2)
				ELSE 
				BEGIN
					SET @nMes   = CONVERT(INTEGER,SUBSTRING(@cInstser,9,2))	
					SET @nMes_a = DATEPART(MONTH,@dFechoy)

					IF @nMes>@nMes_a
						SET @nAno = DATEPART(YEAR,@dFechoy) - 1
					ELSE
						SET @nAno = DATEPART(YEAR,@dFechoy)

					SET @cAno  = CONVERT(CHAR,@nAno)
					SET @cInstser = SUBSTRING(@cInstser,1,6)+SUBSTRING(@cInstser,9,2)+SUBSTRING(@cAno,3,2)
				END
			END
		END

		IF @iCodigo = 888
		BEGIN
			SET @fIpc_pr = 0 
			SET @fIpc_in = 0 
			SET @fIpc_cp = 0
			SET @dFec_cp = @dFeccomp - DATEPART(DAY,@dFeccomp)
			SET @dFec_cp = @dFec_cp  - DATEPART(DAY,@dFec_cp) + 1 --** Fecha Emisi¢n BR **--
			SET @dFec_in = @dFechoy  - DATEPART(DAY,@dFechoy)
			SET @dFec_in = @dFec_in  - DATEPART(DAY,@dFec_in)
			SET @dFec_in = @dFec_in  - DATEPART(DAY,@dFec_in) + 1 --** Fecha Dev.2 meses atr s Ant
			SET @dFec_pr = @dFechoy  - DATEPART(DAY,@dFechoy)
			SET @dFec_pr = @dFec_pr  - DATEPART(DAY,@dFec_pr) + 1 --** Fecha Dev.1 mes atr s
			SET @fIpc_cp = 1
			SET @fIpc_in = 0
			SET @fIpc_pr = 0
			SET @fIpc_cp = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_cp)
			SET @fIpc_in = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_in)
			SET @fIpc_pr = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 502 AND vmfecha = @dFec_pr)
		END

		IF @cProg<>'SP_'
		BEGIN

			IF @iMonemi<>999
			BEGIN
            			SET @fValmon_Hoy = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFechoy)
				SET @fValmon_Man = (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecprox)
				SET @fTasest     =  CASE WHEN @iCodigo=1 THEN @fTe_pcdus
                                     			 WHEN @iCodigo=2 THEN @fTe_pcduf
							 WHEN @iCodigo=5 THEN @fTe_ptf
                                     			 ELSE CONVERT(FLOAT,0)
						     END
			END

			SET @dFeccal = @dFecprox

			IF @dFecven < @dFecprox
				SET @dFeccal = @dFecven

			IF LEFT( @cInstser, 4 ) = 'BCAP' 
			BEGIN    
            			EXECUTE @nError = @cProg 1, @dFeccal, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
			                        , @fNominal OUTPUT, @fTirBCaps OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT, @fVan     OUTPUT, @fVpar OUTPUT
						, @nNumucup OUTPUT, @dFecucup  OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT
						, @fIntpcup OUTPUT, @fAmopcup  OUTPUT, @fSalpcup OUTPUT, @fDurat   OUTPUT, @fConvx   OUTPUT, @fDurmo   OUTPUT
			END ELSE 

			IF @frutemis=@nRutBanco AND @iCodigo=20
			BEGIN
				SELECT @fVparDEV=0.0	
				EXECUTE @nError = @cProg @iModcal, @dFeccal, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
						, @fNominal OUTPUT, @fTir     OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT, @fVan     OUTPUT, @fVpar OUTPUT
						, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT
						, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat   OUTPUT, @fConvx   OUTPUT, @fDurmo   OUTPUT	
				SELECT @fVparDEV = ROUND( @fVpar,8)
				SELECT @fMt      = ROUND((@fNominal * (@fVparDEV / 100.0)) *  @fValmon_Man,0)
			END ELSE

				EXECUTE @nError = @cProg @iModcal, @dFeccal,@iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest
						, @fNominal OUTPUT, @fTir     OUTPUT, @fPvp     OUTPUT, @fMt      OUTPUT, @fMtum    OUTPUT, @fMt_cien OUTPUT, @fVan     OUTPUT, @fVpar OUTPUT
						, @nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT
						, @fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat   OUTPUT, @fConvx   OUTPUT, @fDurmo   OUTPUT
    

         --** Valorizaci¢n a Pago de Cupon **--
			IF @iMonemi <> 999 AND @iMonemi <> 13
			BEGIN
				SELECT @fValmon_Cup = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecucup
				SELECT @fValmon_Com = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFeccomp
			END

         --> Se agrego validacion de Fecha de Liquidacion (Pago Mañana u Hoy) al Controp, para que no rebaje los Papeles PagoMañana
         IF (@dFecprox >= @dFecucup AND @dFechoy < @dFecucup) AND @iAst = 0 AND @dFechaLiquida = @dFechoy
         BEGIN
            SET @iCupon    = 1

            IF @iMonemi <> 999 AND @iMonemi<>13
            BEGIN
               SELECT @fValmon_Cup = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFecucup
               SELECT @fValmon_Com = vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = @iMonemi AND vmfecha = @dFeccomp
            END

            IF @cSeriado = 'S'
            BEGIN
               --** Pago Inhabil **--
               IF @dFecucup > @dFechoy AND @dFecucup < @dFecprox
                  SET @iPago_Nohabil = 1

               SET @fIntucup =      ((@fIntucup * @fNominal) / CONVERT(FLOAT,100))
               SET @fAmoucup =      ((@fAmoucup * @fNominal) / CONVERT(FLOAT,100))
               SET @fIntcupo = ROUND( @fIntucup * @fValmon_Cup, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) -- wms
               SET @fAmocupo = ROUND( @fAmoucup * @fValmon_Cup, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) -- wms
               SET @nPagcup  = ROUND((@fIntucup + @fAmoucup) * @fValmon_Man, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) --wms

               IF @dFecucup <> @dFecprox
                  SELECT @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Man, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) --wms
               ELSE
                  SELECT @nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Cup, CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END) --wms

               SELECT @fValcupo = @fIntcupo + @fAmocupo

            END
         END

         --> Segun Carlos Basterrica Debiera quedar en Cero el Reajuste
	
	IF @dFechaLiquida > @dFechoy
            SET @nReadia   = 0
         ELSE
            SET @nReadia   = ROUND((@fValmon_Man - @fValmon_Hoy) * @fValcomu, 0)
         --************************************************************************************

         IF @iCodigo=888
         BEGIN
            SELECT @fIpc_cp	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=DATEADD(MONTH,-1,DATEADD(DAY,(DATEPART(day,@dFeccomp)*-1)+1,@dFeccomp))),0)
            IF @fIpc_cp  = 0  
            BEGIN
               SELECT @fIpc_cp	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=DATEADD(MONTH,-2,DATEADD(DAY,(DATEPART(day,@dFeccomp)*-1)+1,@dFeccomp))),0)
            END

            SELECT @dFec_in = DATEADD(MONTH,-2,DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy))
            SELECT @fIpc_in = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFec_in),0)
            SELECT @dFec_pr = DATEADD(MONTH,-1,DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy))
            SELECT @fIpc_pr = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFec_pr),0)
            SELECT @nReadia = 0
            ---SELECT @fIpc_pr , @fIpc_in ,@fIpc_mes , @fIpc_hoy

            IF @fIpc_pr <> 0 AND @fIpc_pr <> @fIpc_in
            BEGIN
               --> Segun Carlos Basterrica Debiera quedar en Cero el Reajuste
               IF @dFechaLiquida > @dFechoy
                  SET @nReadia = 0
               ELSE
                  SET @nReadia = ROUND(( @fIpc_pr - @fIpc_in ) * ROUND(@nValcomp/@fIpc_cp, CASE WHEN @ctipo_moneda_papel ='0' THEN @ndecimal ELSE 0 END),  (CASE WHEN @ctipo_moneda_papel ='0' THEN @ndecimal ELSE 0 END) )
            END ELSE 
            BEGIN
               SELECT @nReadia = 0
            END


	 IF @iMonemi = 800 AND @iMonemi = 801
	 BEGIN
               SELECT @nReadia = 0
	 END


            -- VGS 16/03/2005 Se incorpora esta pregunta para que genere el regisrto de VC en la MDRS
         IF @dFecven < @dFecprox 
               SELECT @iCupon = 1
         END

         IF @iCodigo = 888 AND @fIpc_mes <> @fIpc_hoy AND @dFeccomp < @dFechoy
         BEGIN
            IF @dFechaLiquida > @dFechoy
               SET @nIntdia = 0
            ELSE               
               SET @nIntdia = @fMt - @nVpresen - @nReadia

            SET @nInteres   = @nInteres  + @nIntdia
            SET @nReajuste  = @nReajuste + @nReadia
         END ELSE
         BEGIN
            IF @iCodigo = 888
               SET @nReadia = 0

            IF @dFechaLiquida > @dFechoy
               SET @nIntdia = 0
            ELSE               
               SET @nIntdia = ROUND(@fMt - @nVpresen - @nReadia + @nPagcup,CASE WHEN @cTipo_moneda_papel='0' THEN @nDecimal ELSE 0 END)

            SET @nInteres   = @nInteres  + @nIntdia
            SET @nReajuste  = @nReajuste + @nReadia
         END

         IF DATEPART(MONTH,@dFechoy)<>DATEPART(MONTH,@dFecprox)
         BEGIN
            SET @nIntMes = 0.0 
            SET @nReaMes = 0.0
         END

         SET @nIntMes = @nIntMes + @nIntdia
         SET @nReaMes = @nReaMes + @nReadia
 
         --** Capitalizacion **--
         IF @iCupon=1
         BEGIN
            IF @cSeriado='S'
            BEGIN
               SET @nInteres_RealCup = @nInteres 

               IF @iPago_NoHabil=1
               BEGIN
                  SET @nIntPordia       = @nIntdia  / DATEDIFF(DAY,@dFechoy,@dFecprox)
                  SET @nInteres_RealCup = @nInteres - @nIntdia + (@nIntPordia * DATEDIFF(DAY,@dFechoy,@dFecucup) )
               END

               SET @fFactor     = (((@fIntucup * @fValmon_Cup) - @nInteres_RealCup) / ISNULL(@fValmon_Cup,1))

               SET @fCapital_UM = @fAmoucup + @fFactor
               SET @fCapital    = ROUND( @fCapital_UM * @fValmon_Com, CASE WHEN @cTipo_moneda_papel = '0' THEN @nDecimal ELSE 0 END)
               SET @nReacup     = ROUND((@fValmon_Cup - @fValmon_Com) * @fCapital_UM, 0)
               SET @nIntcup     = @nInteres_RealCup

               SET @nDifcup     = @nPagcup  - (@fCapital + @nReacup + @nIntcup)
               SET @fCapital    = @fCapital + @nDifcup
               SET @nReacup     = @nReacup  + ROUND((@fValmon_Man-@fValmon_Cup) * @fCapital_UM, CASE WHEN @cTipo_moneda_papel = '0' THEN @nDecimal ELSE 0 END)
               SET @nIntcup     = @nPagcup  - @fCapital - @nReacup
               SET @fAmocupo    = @fCapital
               SET @nDifReaCup  = @nPagcupo - (@fAmocupo + @nIntcup + @nReacup)
               SET @nPagcup     = @nPagcupo

            END ELSE
            BEGIN
               SET @fAmocupo    = @nValcomp
               SET @fValcupo    = @nValcomp + @nInteres + @nReajuste
               SET @nIntcup     = @nInteres
               SET @nReacup     = @nReajuste
               SET @nPagcup     = @fValcupo

            END
         END
      END

      IF @iCupon=1 AND @cSeriado='S'
      BEGIN
         SET @nReajuste = @nReajuste - @nReacup
         SET @nValcomp  = ISNULL(@nValcomp - ISNULL(@fCapital,1),1)
         SET @fValcomu  = ROUND(@nValcomp / ISNULL(@fValmon_com,1) ,4 )
         SET @nInteres  = @nInteres  - @nIntcup
      END

      IF @frutemis = @nRutBanco AND @iCodigo = 20
      BEGIN 
         SELECT @nPrimaDctoDia = ROUND(@nPrimaDctoTot / DATEDIFF(day, @dFeccomp, @dFecven),0)
      END


	UPDATE #TEMPORAL_INTRA
	SET    	instser      = @cInstcam
	,      	instcam      = @cInstser
	,      	valcomp      = @nValcomp
	,      	valcomu      = @fValcomu
	,      	intdia       = @nIntdia
	,      	readia       = @nReadia
	,      	interesmes   = @nIntMes
	,      	reajustemes  = @nReaMes
	,      	interes      = @nInteres
	,      	reajuste     = @nReajuste
	,      	readifmes    = @nDifReaCup
	,      	valptehoy    = @nVpresen
	,	valpteman    = @fMt
	,      	amocup       = @fAmocupo
    	,      	intcup      = @nIntcup
	,      	reacup       = @nReacup
	,      	flujo        = @nPagcup
      	,      	duration     = @fDurat
	,      	durmodif     = @fDurmo
      	,      	convex       = @fConvx
      	,	tasa_float   = @fTasaFloat
      	,	tasemi       = @fTasemi
      	,      	monemi       = @iMonemi
 	,	basemi       = @fBasemi
      	,	cupon        = @iCupon
     	,	pvpcomp      = @fPvp
      	,      	numucup      = @nNumucup
      	,      	numpcup      = @nNumpcup
      	,      	fecucup      = @dFecucup
      	,      	fecpcup      = @dFecpcup
      	,      	flag         = 'S'
      	,      	cup          = @fIntpcup+@fAmopcup
      	,	PrimaDcto    = @nPrimaDctoTot
      	,	tasaEmis     = @nValoraTasaEmi
      	,      	valordia     = @nPrimaDctoDia
      	,      	valorpar     = @fVpar
      	,      	Moneda_papel = @cTipo_moneda_papel
      	,      	Decimales    = @nDecimal
      	  WHERE @nNumdocu    = numdocu 
	    AND @nCorrela    = correla
	    AND Nreg         = @iX   

	IF @@ERROR<>0
	BEGIN
		SELECT 'NO','Problemas al Actualizar Tabla Temporal de Devengamiento'
		RETURN
	END

END

-->+                                                        <
------------------------------------------------------------+
--> Fin de ciclo de lectura de cartera                      <


	INSERT INTO 
	dbo.tbl_resticketrtafija	
	(	Fecha_Operacion
	,	Numero_Documento
    	,    	Correlativo
    	,	tipo_resultado
        ,       tipo_operacion
	,	CodCartera
	,	CodMesa
	,	moneda
	,	Nemotecnico
	,	Mascara
	,	CodigoInstrumento
	,	Valor_Nominal
	,	Tir
	,	pvp
	,	vpar
	,	Tir_Estimada
	,	Valor_Presente_Hoy
	,	Valor_Presente_prox
	,	Intereses
	,	Reajustes
	,	Interes_mes
	,	Reajuste_mes
	,	Interes_Acumulado
	,	Reajuste_Acumulado
	,	Duration
	,	DurationMod
	,	Convexidad
	,	Amortizacion_Cupon
	,	Interes_Cupon
	,	Reajuste_Cupon
	,	Flujo_Cupon
	,	valor_compra
	,	valor_compra_um
	,	num_ult_cupon
	,	num_prox_cupon
	,	fecha_ult_cupon
	,	fecha_prox_cupon
	,	valor_pvcomp
	,	diferencia_reajuste
	,	valor_venc
	,	prima_descuento_total
	,	prima_descuento_dia
	,	valor_tasa_emision
	,	valor_par
	)
	SELECT 
	 	@dfecprox
	,	Numero_Documento 
	,	Correlativo
	,	'DEV'
        ,       Tipo_Operacion
	,	CodCarteraOrigen
	,	CodMesaOrigen
	,	moneda
	,	Nemotecnico
	,	Mascara
	,	CodigoInstrumento
	,	Valor_Nominal
	,	tir
	,	pvp
	,	vpar	
	,	tir_estimada
	,	Valor_Presente
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
	,	0
	,	0
	,	0 
	,	0
	,	0
	,	0	
	,	0
	,	getdate()
	,	getdate()
	,	0
	,	0
	,	0
	,	0
	,	0
	,	0
	,	0
	   FROM tbl_carticketrtafija
	  WHERE valor_nominal > 0 
	    AND tipo_operacion = 'CP'

	IF @@ERROR<>0
	BEGIN
		SELECT 'NO','Problemas al Insertar Operaciones CP al MDRS'
		RETURN
	END

	UPDATE #TEMPORAL_INTRA
	SET    intdia      = 0
	,      readia      = 0
	,      interes     = 0
	,      reajuste    = 0
	,      interesmes  = 0
	, reajustemes = 0
	WHERE  mascara   = 'FMUTUO'



   UPDATE tbl_resticketrtafija
   SET   Nemotecnico	      = instser
   ,     valor_presente_prox  = CASE WHEN moneda=13 THEN ROUND(valpteman * (valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                     ELSE                  ROUND(valpteman * (valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                END
   ,     Amortizacion_cupon   = CASE WHEN moneda=13 THEN ROUND(amocup    * (valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                     ELSE                  ROUND(amocup    * (valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                END
   ,     Interes_cupon        = CASE WHEN moneda=13 THEN ROUND(intcup    * (valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                     ELSE                  ROUND(intcup    * (valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                END
   ,     Reajuste_cupon       = CASE WHEN moneda=13 THEN ROUND(reacup    * (valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
   			             ELSE                  ROUND(reacup    * (valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                END
   ,     Flujo_cupon          = CASE WHEN moneda=13 THEN ROUND(flujo     * (valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                     ELSE                  ROUND(flujo     * (valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                END
   ,     intereses            = CASE WHEN moneda=13 THEN ROUND(intdia  *(valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                     ELSE                  ROUND(intdia  *(valor_nominal/nominal),0)
                                END
   ,     reajustes            = ROUND(readia  *(valor_nominal/nominal),0)
   ,     interes_mes          = CASE WHEN moneda = 13 THEN ISNULL( ROUND(interesmes  *(valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END),0)
                                     ELSE                            ROUND(interesmes  *(valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                END
   ,     reajuste_mes        =                              ISNULL( ROUND(reajustemes *(valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END),0)
   ,     interes_acumulado    = CASE WHEN moneda  = 13 THEN ISNULL( ROUND(interes     *(valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END),0)
                                      ELSE                   ISNULL( ROUND(interes     *(valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END),0)
                                END
   ,     reajuste_acumulado   = ISNULL(ROUND(reajuste *(valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END),0)
   ,     valor_compra	      = CASE WHEN codigoinstrumento =13 AND cupon=1 THEN ROUND(valcomp *(valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                 WHEN codigoinstrumento<>13AND cupon=1 THEN ROUND(valcomp *(valor_nominal/nominal),CASE WHEN moneda_papel='0' THEN Decimales ELSE 0 END)
                                     ELSE valcomp
                                END
   ,     valor_compra_um      = CASE WHEN codigoinstrumento=13 AND cupon=1 THEN ROUND(valcomu *(valor_nominal/nominal),2)
           			     WHEN monemi=999 AND cupon=1  THEN ROUND(valcomu *(valor_nominal/nominal),0)
                                     WHEN monemi<>999 AND cupon=1 THEN ROUND(valcomu *(valor_nominal/nominal),4)
                                     ELSE ISNULL(valcomu,1)      
                                END
   ,     tbl_resticketrtafija.duration             = #TEMPORAL_INTRA.duration
   ,     durationmod 	      = durmodif
   ,     convexidad	      = convex
   ,     num_ult_cupon        = numucup
   ,     num_prox_cupon       = numpcup
   ,     fecha_ult_cupon      = fecucup
   ,     fecha_prox_cuPon     = fecpcup
   ,     valor_pvcomp         = pvpcomp
   ,     diferencia_reajuste  = ISNULL(readifmes, 0)
   ,     valor_venc           = CASE WHEN seriado  = 'N' AND codigoinstrumento <> 888 THEN valor_nominal
                                     WHEN                    codigoinstrumento <> 888 THEN ROUND((cup*valor_nominal)/100.0,4) 
                                     ELSE                                         cup 
                                END
   ,     prima_descuento_total= CASE WHEN moneda=13 THEN isnull( ROUND(PrimaDcto  *(valor_nominal/nominal),2), 0 )
                                     ELSE                          ROUND(PrimaDcto  *(valor_nominal/nominal),0)
                                END
   ,     prima_descuento_dia  = CASE WHEN moneda=13 THEN isnull( ROUND(valordia *(valor_nominal/nominal),2), 0 )
                        	     ELSE                          ROUND(valordia *(valor_nominal/nominal) * DATEDIFF(day, @dFechoy, @dFecprox),0)
                      	        END
   ,     valor_tasa_emision   = CASE WHEN moneda=13 THEN ISNULL( ROUND(tasaEmis *(valor_nominal/nominal),2),0)
                                     ELSE                          ROUND(tasaEmis *(valor_nominal/nominal),0)
                      	        END
   ,     valor_par             = valorpar
   FROM  #TEMPORAL_INTRA 
   WHERE fecha_operacion  = @dFecprox 
   AND   Nemotecnico= instser 
   AND   tir       	    = tircomp 
   AND   numero_documento   = numdocu 
   AND   correlativo   = correla
   AND tipo_resultado   = TipoDev

   IF @@ERROR <> 0
   BEGIN
      SELECT 'NO', 'Problemas al Actualizar Tabla MDRS con Devengamiento'
      RETURN
   END

   SELECT 'SI','Proceso de Devengamiento ha finalizado en forma correcta'

   SET NOCOUNT OFF

   RETURN

END

GO
