USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[CARTERA_AJUSTE_IFRS3_Ventas]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[CARTERA_AJUSTE_IFRS3_Ventas] 
AS         
BEGIN
	SET NOCOUNT ON ;

	DECLARE    
		   @modcal				INTEGER
	   ,   @mascara 			CHAR(10)
	   ,   @nominal				FLOAT
	   ,   @tir					FLOAT
	   ,   @pvp					FLOAT
	   ,   @monto				FLOAT
	   ,   @fValComu			FLOAT
	   ,   @feccal				CHAR(10)
	   ,   @feccomp				CHAR(10)
	   
	DECLARE    
  			@numdocu	NUMERIC(10,0),
			@correla	INT 

	DECLARE @reajuste FLOAT 
	DECLARE @interes FLOAT
	
--> 	TRUNCATE TABLE dbo.FinalSerie

	DECLARE @cProg           CHAR(10)	,
		@iModcal             INTEGER	,
		@iCodigo             INTEGER	,
		@cInstser            CHAR(10)	,
		@iMonemi             INTEGER	,
		@dFecemi             CHAR(10)	,
		@dFecven             CHAR(10)	,
		@fTasemi             FLOAT	,	
		@fBasemi             FLOAT	,
		@fTasest             FLOAT	,
		@fNominal            FLOAT	,
		@zNominal			 FLOAT 	,
		@fTir                FLOAT	,
		@fPvp                FLOAT	,
		@fmtA                FLOAT	,
		@fMT                 FLOAT	,
		@fMTum               FLOAT	;

	DECLARE @Usuario        VARCHAR(15)	,
		@Marca				CHAR(1)	,
		@zdocumento	        NUMERIC(9)	,
 		@zcorrelativo	    NUMERIC(9)	,
		@Documento          NUMERIC(9)	,
		@Correlativo        NUMERIC(9)	,
		@Serie              VARCHAR(20)	,
		@Moneda             CHAR(3)	,
		@Nominal_Compra     FLOAT	,
		@Tasa_Compra        FLOAT	,
		@Valor_Par          FLOAT	,
		@Valor_Presente     FLOAT	,
		@Margen             FLOAT	,
		@Valor_Inicial      FLOAT	,
		@Nominal_Venta      FLOAT	,
		@Tasa_Venta         FLOAT	,
		@vPar_Venta         FLOAT	,
		@vPresente_Venta    FLOAT	,
		@vInicial_Venta     FLOAT	,
		@plazo				INTEGER	,	
		@Ventana            NUMERIC(9)	;


	DECLARE @iContadorReg	    INTEGER 
		,	@iContadorTot	    INTEGER	;		


CREATE TABLE 
	#DatosSerie( 
	   	nerror      	INTEGER		,
		cmascara    	CHAR(12)	,
		codigo		INTEGER		,
		cserie      	CHAR(12)	,
		nrutemi     	NUMERIC(9,0)	,
		nmonemi     	INTEGER		,
		ftasemi     	FLOAT		,
		nbasemi     	NUMERIC(3,0)	,
		dfecemi     	CHAR(10)	,
		dfecven     	CHAR(10)	,
		crefnomi    	CHAR(1)		,
		cgenemi     	CHAR(10)	,
		cnemmon     	CHAR(5) 	,
		ncorte      	NUMERIC(21,4)	,
		cseriado    	CHAR(1)		,
		clecemi     	CHAR(6)		,
		fecpro	    	CHAR(10)	)	;

	DECLARE	@nNumucup	INTEGER		,
		@cFecucup	CHAR(10)	,
		@cFecpcup	CHAR(10)	,
		@fDurat		FLOAT		,
		@fConvx		FLOAT		,
		@fDurmo		FLOAT 		,
		@fechaAntes		CHAR(10)	,
		@nrutemi	NUMERIC(9)		;

	DECLARE @estado 	INTEGER			;

      -- Tabla para recibir datos de la Valorizacion
	 CREATE TABLE 
	 #Valorizacion(
		fError 		INTEGER 	,
		fNominal	FLOAT		,
		fTir		FLOAT		,	
		fPvp		FLOAT		,
		fMT		FLOAT		,
		fMTUM		NUMERIC(21,8)		,
		fMT_cien	FLOAT		,
		fVan		FLOAT		,
		fVpar		FLOAT		,
		nNumucup	INTEGER		,
		cFecucup	CHAR(10)	,
		fIntucup	FLOAT		,
		fAmoucup	FLOAT		,
		fSalucup	FLOAT		,
		nNumpcup	FLOAT		,
		cFecpcup	CHAR(10)	,
		fIntpcup	FLOAT		,
		fAmopcup	FLOAT		,
		fSalpcup	FLOAT		,
		fDurat		FLOAT		,
		fConvx		FLOAT		,
		fDurmo		FLOAT 		);

	DECLARE @fValmonHOY		FLOAT
	DECLARE @fValmonAYER	FLOAT
	DECLARE @fValorVenta    FLOAT
	DECLARE @fResultado		FLOAT

		DECLARE @tblFechas	TABLE (fechaRevision	date)
		DECLARE @i  INT 
		DECLARE @fIni date 


/*
	   ;WITH cteCartera
		AS (	
			SELECT cpnumdocu
				 , cpcorrela
				 , cpinstser
				 , cpnominal
			 
				 , cpvalcomp
				 , cpvalcomu 
				 , cptircomp
				 , cpinteresc
				 , cpreajustc
			 
				 , cpvptirc
				 , codigo_carterasuper
				
				 , inserie 
-->			  INTO #Cartera 
			  FROM BacTraderSuda.dbo.mdcp0331
			 INNER
			  JOIN BacParamSuda.dbo.INSTRUMENTO i 
			    ON i.incodigo = cpcodigo 			   
			 WHERE cpnumdocu = cpnumdocuo  
			   AND cpnominal > 0 
			   AND codigo_carterasuper IN ('P','A')
		   )
		,  cteconCupon 
		   AS ( SELECT * 
		          FROM BacParamSuda.dbo.TABLA_DESARROLLO td 
		         WHERE td.tdfecven ='2016-04-01')
		,  cteVentas
		   AS ( SELECT mofecpro
					 , monumoper
					 , monumdocu
					 , mocorrela
					 , monominal
					 , movalven
					 , moutilidad
					 , moperdida
					 , movpresen
		          FROM BacTraderSuda.dbo.mdmh mh
		         INNER 
		          JOIN cteCartera cp
		            ON cp.cpnumdocu = monumdocu
		           AND cp.cpcorrela = mocorrela
		           AND motipoper = 'VP' 
		           AND mh.mostatreg ='' 
		        WHERE mh.mofecpro >'2016-03-31' 
		   )   		  
		,  cteDevengo 
		   AS ( SELECT rsfecha
					 , rsnumoper
					 , rsfecctb
					 , rsnumdocu
					 , rscorrela
					 , rsnominal
					 , rstipoper
					 , rsinteres
					 , rsreajuste
					 , rsvppresen
					 , rsvppresenx
		          FROM BacTraderSuda.dbo.mdrs rs
		         INNER 
		          JOIN cteCartera cp
		            ON cp.cpnumdocu = rsnumdocu
		           AND cp.cpcorrela = rscorrela
		           AND rscartera = '111' 
		           AND rstipoper = 'DEV' 
		        WHERE rs.rsfecha >='2016-03-31' 
		   )   		  


			SELECT rsfecha
				 , rsfecctb
				 , vm.rmnumdocu												AS Operacion
				 , vm.rmcorrela												AS Correla
				 , vm.rminstser												AS Serie 
				 , vm.valor_nominal											AS NominalDisponible
				 , rsnominal 
				 , vm.valor_presente
				 , vm.valor_mercado
				 , vm.diferencia_mercado
				 , vm.tasa_compra
				 	
				 ---------------------------------------------------------------------------------------------------											
				 -- La nueva tasa de Compra  				 
				 ---------------------------------------------------------------------------------------------------
				 , vm.tasa_mercado											AS cptircomp
				 ---------------------------------------------------------------------------------------------------	
				 
				 , cp.cpvptirc
				 , cp.cpvalcomp												AS CapitalOriginal
				 , cp.cpvalcomp
				 , cp.cpvalcomu												AS CapitalOriginalUM
				 , cp.cpvalcomu										
				 , cp.codigo_carterasuper
				 , cp.inserie
				 ---------------------------------------------------------------------------------------------------	
				 -- RS	
				 ---------------------------------------------------------------------------------------------------	
				 , rstipoper 
				 , rsinteres 
				 , rsreajuste
				 
				 , rsinteres												AS InteresOriginal 
				 , rsreajuste												AS ReajusteOriginal
				 , rsvppresenx					
				 ---------------------------------------------------------------------------------------------------	
				 -- Ventas
				 ---------------------------------------------------------------------------------------------------	
				 , ISNULL( vta.monominal, 0)								AS NominalVenta
				 , ISNULL( vta.movalven , 0)								AS ValorVenta
				 , ISNULL( vta.movpresen, 0)								AS ValorCarteraVenta
				 , ISNULL( vta.movpresen, 0)								AS ValorCartera                                                                                                                                                                                    
				 , ISNULL( vta.moutilidad,0)								AS Utilidad
				 , ABS(ISNULL( vta.moperdida ,0))							AS Perdida
				 , ISNULL( vta.moutilidad,0)								AS UtilidadOriginal
				 , ABS(ISNULL( vta.moperdida ,0))							AS PerdidaOriginal
		   		 , ROW_NUMBER() OVER (ORDER BY rmnumdocu, rmcorrela)		AS iRegistro
		   		 
		   	  INTO #Cartera	 
			  FROM BacTraderSuda.dbo.VALORIZACION_MERCADO vm 
			 INNER 
			  JOIN cteCartera cp 
			    ON cpnumdocu = vm.rmnumdocu
			   AND cpcorrela = vm.rmcorrela
			  LEFT
			  JOIN cteconCupon ccC1 
			    ON ccC1.tdmascara = cpinstser
			  LEFT
			  JOIN cteDevengo ccC 
			    ON cpnumdocu = ccC.rsnumdocu
			   AND cpcorrela = ccC.rscorrela

			  LEFT
			  JOIN cteVentas vta 
			    ON rsnumdocu  = vta.monumdocu
			   AND rscorrela = vta.mocorrela
			   AND rsfecha   = mofecpro  
			   

			 WHERE vm.fecha_valorizacion ='2016-03-31'   
			   AND vm.tipo_operacion = 'CP' 
			   AND vm.codigo_carterasuper IN ('P','A') 
*/

	   ;WITH cteCartera
		AS (	
			SELECT cpnumdocu			
				 , cpcorrela			
				 , cpinstser
				 , cpnominal
			 
				 , cpvalcomp
				 , cpvalcomu 
				 , cptircomp
				 , cpinteresc
				 , cpreajustc
			 
				 , cpvptirc
				 , codigo_carterasuper
				 , cptipcart
				 , inserie 
-->			  INTO #Cartera 
			  FROM BacTraderSuda.dbo.mdcp0331
			 INNER
			  JOIN BacParamSuda.dbo.INSTRUMENTO i 
			    ON i.incodigo = cpcodigo 			   
			 WHERE cpnumdocu = cpnumdocuo  
			   AND cpnominal > 0 
			   AND codigo_carterasuper IN ('P','A','T')
		   )

				SELECT mofecpro
					 , monumoper
					 , monumdocu						AS Operacion
					 , mocorrela						AS Correla
					 , monominal						AS rsnominal
					 , movalven							AS ValorVenta
					 , moutilidad
					 , moperdida
					 , moutilidad						AS UtilidadOriginal
					 , moperdida						AS PerdidaOriginal
					 , movpresen
					 , movpresen						AS ValorCartera
					 , mh.moinstser						AS Serie
					 , mh.Resultado_Dif_Precio
					 , mh.Resultado_Dif_Mercado
					 , mh.Resultado_Dif_Precio			AS ResDifPrecio
					 , mh.Resultado_Dif_Mercado			AS ResDifMercado

					 , mh.motir							AS TirVenta
					 , vm.tasa_compra
					 , vm.tasa_mercado					AS cptircomp
					 , inserie 
					 , cp.codigo_carterasuper
					 , cp.cptipcart			
					 , ROW_NUMBER() OVER (ORDER BY monumdocu, mocorrela)		AS iRegistro

				  INTO #Cartera					 
		          FROM BacTraderSuda.dbo.mdmh mh
		         INNER 
		          JOIN cteCartera cp
		            ON cp.cpnumdocu = monumdocu
		           AND cp.cpcorrela = mocorrela
		           AND motipoper = 'VP' 
		           AND mh.mostatreg =''
				 INNER  
				  JOIN dbo.VALORIZACION_MERCADO vm
				    ON vm.rmnumdocu = monumdocu 
				   AND vm.rmcorrela = mocorrela 
				   AND vm.fecha_valorizacion ='2016-03-31' 		            
		         WHERE mh.mofecpro >'2016-03-31' 


	DECLARE @fNomiVentas	NUMERIC(24,4)
	--DECLARE @fResultado		NUMERIC(24,0)
	DECLARE @DiferenciaPrecio	numeric(21,4)
	DECLARE @DiferenciaAvr		numeric(21,4)
	
	DECLARE @iRow	NUMERIC(10,0)
	DECLARE @iTotal	NUMERIC(10,0) 
		SET @iRow	= 1
		SET @iTotal = (SELECT MAX(iRegistro) FROM #Cartera); 
	
/*  	
*   =========================================================================================================================================================		
*														CICLO PRINCIPAL PARA PROCESAR INFROMACION
*   =========================================================================================================================================================
*/
	WHILE (@iRow <=@iTotal)
	BEGIN
		SELECT 
			@mascara		= serie				,
			@feccal			= CONVERT(CHAR(10),mofecpro,112)			, --> Fecha Hoy
			@fNominal		= rsnominal,  --NominalDisponible , 
			@fTir			= cptircomp			, 
			@numdocu		= operacion			, 
			@correla		= correla			,
		-->	@fechaAntes		= CONVERT(CHAR(10),rsfecctb,112)		,  --> Fecha Anterior	 
			@fNomiVentas	= rsnominal		,
			@fValorVenta	= ValorVenta	,
			@fResultado     = moutilidad+moperdida
		FROM #Cartera
  	   WHERE iRegistro = @irow  		
			
		SET @modcal= 2


		/* ________________________________________________________________________________________________}
		Cargo datos de las series para poder valorizar							|
		================================================================================================} */
		INSERT INTO #DatosSerie		
		EXECUTE sp_chkinstser @mascara;

		SELECT 	@cInstser	= cmascara	,
				@imonemi	= nmonemi	,
				@icodigo	= codigo		,
				@dFecemi	= CONVERT(CHAR(10),CONVERT(DATETIME,dFecemi,103),112),
				@dFecven	= CONVERT(CHAR(10),CONVERT(DATETIME,dFecven,103),112),
				@ftasemi	= ftasemi	,
				@fbasemi	= nbasemi	,
				@ftasest	= 0.0		,
				@fpvp		= @pvp		,
				@fmt		= @monto	,
				@nrutemi	= nrutemi	
			FROM #DatosSerie;		

			SET @fValComu =0 ; 
		
/*
 			TRUNCATE TABLE #Valorizacion
				
			INSERT INTO  #Valorizacion
			EXECUTE sp_valorizar_client
				@modcal,
				'20160401',
				@iCodigo,
				@Mascara,
				@iMonemi,
				@dFecemi,
				@dFecven,
				@fTasemi,
				@fBasemi,
				@fTasest,
				@fNominal,
				@fTir,
				@fPvp,
				@fMT

			SELECT @fValComu= fmtum    
				,  @fmt		= fmt 
   				FROM #Valorizacion

*/
/*			IF @feccal = '20160401'  /* debo regenerar datos NUEVO CAPITAL */ 
			BEGIN 
   				  
				UPDATE #cartera 
				   SET cpvalcomp	= @fmt 
				   ,   cpValcomu	= @fValComu
				   ,   rsinteres    = iif( @feccal = '20160401' ,0, rsinteres  )
				   ,   rsreajuste   = iif( @feccal = '20160401' ,0, rsreajuste )
				 WHERE iRegistro = @irow   


-->			END
*/			
		 -- ---------------------------------------------------------------------------------------------------------------------------------------			 			 
		 --						Se revisa si hay ventas 
		 -- ---------------------------------------------------------------------------------------------------------------------------------------			 
			IF @fNomiVentas >0 
			BEGIN 
				
				TRUNCATE TABLE #Valorizacion
				
				INSERT INTO  #Valorizacion
				EXECUTE sp_valorizar_client
							@modcal,
							@feccal,
							@iCodigo,
							@Mascara,
							@iMonemi,
							@dFecemi,
							@dFecven,
							@fTasemi,
							@fBasemi,
							@fTasest,
							-----------------------------------------
							@fNomiVentas,  -- Nominales de la Venta -
							-----------------------------------------
							@fTir,
							@fPvp,
							@fMT
				
				SELECT @fmt		= fmt FROM #Valorizacion

				
			 -- -------------------------------------------------------------------------------------------------------------------------------------
				SET @fResultado = ( @fValorVenta - @fMT )  -- Nuevo resultado de la venta 
			 -- -------------------------------------------------------------------------------------------------------------------------------------  			
			 
				SET @DiferenciaPrecio	= 0; 
				SET @DiferenciaAvr		= 0;
			 
				EXECUTE dbo.sp_fx_utilidad_ventaHIST 'BTR',@numdocu,@correla,@fNomiVentas,@fValorVenta,@fResultado,@feccal,@DiferenciaPrecio OUTPUT,@DiferenciaAvr OUTPUT
	
					
				UPDATE #Cartera 
				   SET ValorCartera		= @fmt 
				   ,   mouTilidad	    = iIf( @fResultado>0,    @fResultado ,0)  
				   ,   moPerdida		= iIf( @fResultado<0,ABS(@fResultado),0)
				   ,   ResDifPrecio     = @DiferenciaPrecio 
				   ,   ResDifMercado	= @DiferenciaAvr
				 WHERE iRegistro		= @irow   
				
			END
		 -- ---------------------------------------------------------------------------------------------------------------------------------------			 


		-- -------------------------------------------------------------------------------------------------------------------------------------
		-- Se comienza con la regeneracion de los intereses y reajustes
		-- -------------------------------------------------------------------------------------------------------------------------------------
/*
			SET @interes = 0 
			SET @reajuste = 0
			
			IF @feccal > '20160401'  
			BEGIN 

				TRUNCATE TABLE #Valorizacion
				
				INSERT INTO  #Valorizacion
				EXECUTE sp_valorizar_client
							@modcal,
							@fechaAntes,  
							@iCodigo,
							@Mascara,
							@iMonemi,
							@dFecemi,
							@dFecven,
							@fTasemi,
							@fBasemi,
							@fTasest,
							@fNominal,  
							@fTir,
							@fPvp,
							@fMT
				
				SELECT @fmtA = fmt  FROM 			#Valorizacion
				

				TRUNCATE TABLE #Valorizacion
				
				INSERT INTO  #Valorizacion
				EXECUTE sp_valorizar_client
							@modcal,
							@feccal,
							@iCodigo,
							@Mascara,
							@iMonemi,
							@dFecemi,
							@dFecven,
							@fTasemi,
							@fBasemi,
							@fTasest,
							@fNominal,  
							@fTir,
							@fPvp,
							@fMT
				
				SELECT @fmt = fmt  FROM 			#Valorizacion
				
			
				SET @reajuste = 0
				SET @interes  = 0
			
			 -- ---------------------------------------------------------------------------------------------------------------------------------------			 
			 -- Se Calcula monto de Reajustes 
			 -- -------------------------------------------------------------------------------------------------------------------------------------
				IF @iMonemi <> 999 
				BEGIN 
					SELECT @fValmonHOY = ISNULL(vvm.vmvalor,1) FROM  VIEW_VALOR_MONEDA vvm WHERE vvm.vmcodigo = @iMonemi AND vvm.vmfecha = @feccal
					SELECT @fValmonAYER= ISNULL(vvm.vmvalor,1) FROM  VIEW_VALOR_MONEDA vvm WHERE vvm.vmcodigo = @iMonemi AND vvm.vmfecha = @fechaAntes
			
					SET @reajuste = (@fValmonHOY - @fValmonAYER) * @fValComu
				END 			
			--> -------------------------------------------------------------------------------------------------------------------------------------

				SET @interes = (@fMT - @fmtA) - @reajuste 


				UPDATE #cartera 
				   SET rsinteres	= @interes 
					,  rsreajuste	= @reajuste   
					,  cpvptirc	= @fMT
				 WHERE iRegistro = @irow   
			END
*/			   		
		SET @iRow =@iRow+1
			
	END


	SELECT c.*, tgd.tbglosa AS GlosaCartera , Fin.tbglosa 
	INTO dbo.CarteraCorregida
	FROM   #cartera c
	INNER JOIN bacparamsuda.dbo.TABLA_GENERAL_DETALLE tgd
	ON tgd.tbcateg = '1111'
	AND  tgd.tbcodigo1 =codigo_carterasuper
	  
	INNER JOIN bacparamsuda.dbo.TABLA_GENERAL_DETALLE Fin
	ON Fin.tbcateg = '204'
	AND Fin.tbcodigo1 =cptipcart
	
	
	  
END
GO
