USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MD0700C]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_MD0700C]
 (
		@Modcal     INT,
		@dFeccal    DATETIME,
		@nCodigo    INTEGER,
		@cMascara   CHAR(12),
		@nMonemi    INT,
		@dFecemi    DATETIME,
		@dFecven    DATETIME,
		@fTasemi    FLOAT,
		@fBasemi    FLOAT,
		@fTasest    FLOAT,
		@fNominal   FLOAT		OUTPUT,
		@fTir       FLOAT		OUTPUT,
		@fPvp       FLOAT		OUTPUT,
		@fMT        FLOAT		OUTPUT,
		@fMTUM      FLOAT		OUTPUT,
		@fMT_cien   FLOAT		OUTPUT,
		@fVan       FLOAT		OUTPUT,
		@fVpar      FLOAT		OUTPUT,
		@nNumucup   INT			OUTPUT,
		@dFecucup   DATETIME	OUTPUT,
		@fIntucup   FLOAT		OUTPUT,
		@fAmoucup   FLOAT		OUTPUT,
		@fSalucup   FLOAT		OUTPUT,
		@nNumpcup   INT			OUTPUT,
		@dFecpcup   DATETIME	OUTPUT,
		@fIntpcup   FLOAT		OUTPUT,
		@fAmopcup   FLOAT		OUTPUT,
		@fSalpcup   INT			OUTPUT,
		@fDurat     FLOAT		OUTPUT,
		@fConvx     FLOAT		OUTPUT,
		@fDurmo     FLOAT		OUTPUT
       )
AS
BEGIN
	

	DECLARE @nTera      FLOAT
	DECLARE @nCupones   NUMERIC(03,00)
	DECLARE @nMonemis   NUMERIC(03,00)
	DECLARE @x1         INT
	DECLARE @nSaldo     FLOAT
	DECLARE @fVan_1     FLOAT
	DECLARE @fVan_2     FLOAT
	DECLARE @fVpar_1    FLOAT
	DECLARE @fVpar_2    FLOAT
	DECLARE @nValmon    NUMERIC(18,10)
	DECLARE @auxMascara CHAR(12)
	DECLARE @auxCup     NUMERIC(03,00)
	DECLARE @auxFven    DATETIME
	DECLARE @auxInt     NUMERIC(19,10)
	DECLARE @auxAmort   NUMERIC(19,10)
	DECLARE @auxFluj    NUMERIC(19,10)
	DECLARE @auxSaldo   NUMERIC(19,10)
	DECLARE @rango      NUMERIC(05,02)
	DECLARE @decs       INTEGER
	DECLARE @tkl        FLOAT
	DECLARE @ut         FLOAT
	DECLARE @ma         FLOAT
	DECLARE @me         FLOAT
	DECLARE @jVan       FLOAT
	DECLARE @nCount     INTEGER
	DECLARE @pervcupano INTEGER
	DECLARE @fTasa      FLOAT         -- Libor ultimo cupon cortado
	DECLARE @fTasaFlot  FLOAT         -- Tasa Flotante
	DECLARE @cBonosFlot CHAR(01)      -- Flag que identifica a los papeles con tasa flotante
	DECLARE @nCuponFlot FLOAT
	SELECT @fTasaFlot = 0.0
	SELECT @cBonosFlot = '0'
	DECLARE @dfechaCurvas DATETIME
	

   
	SELECT @nTera  = -1.0

	SET ROWCOUNT 1
   
	SELECT  @nTera      = setera,
			@dFecemi    = sefecemi,
			@dFecven    = sefecven,
			@nCupones   = secupones,
			@nMonemis   = semonemi,
			@pervcupano = (12/sepervcup)
	  FROM  VIEW_SERIE
	WHERE semascara   = @cMascara
          
   SET ROWCOUNT 0
   
   
   IF @nTera = -1.0 BEGIN
      SELECT @fAmoucup = 0.0
      SELECT @dFecucup = ''
      SELECT @fIntucup = 0.0
      SELECT @fSalucup = 0.0
      SELECT @fPvp     = 0.0
      SELECT @fVan     = 0.0
      SELECT @fVpar    = 0.0
      RETURN
   END
   IF @dFeccal < @dFecemi BEGIN
      SELECT 'NO','La serie tiene Fecha de emisi=n posterior a Fecha de Cÿlculo'
      RETURN
   END
   
   IF @dFeccal > @dFecven
   BEGIN
		SELECT @dFeccal = @dFecven
   END
   
   SELECT @auxMascara = '*'
   
   SELECT @auxMascara = tdmascara
	 FROM VIEW_TABLA_DESARROLLO
    WHERE tdmascara=@cMascara
    
	IF @auxMascara = '*' BEGIN
		SELECT 'NO','Serie No ha sido encontrada en Tabla de Desarrollo'
		RETURN
	END
	
	IF @dFeccal = @dFecven BEGIN
		SELECT @dFecucup = @dFecven
		SELECT	@nSaldo   = 0.0,
				@nNumucup = @nCupones,
				@fIntucup = tdinteres,
				@fAmoucup = tdamort,
				@fSalucup = 0.0,
				@fMt      = 0.0,
				@fMtum    = 0.0,
				@fMt_cien = 0.0
		  FROM  VIEW_TABLA_DESARROLLO
		 WHERE tdmascara = @cMascara 
		   AND tdcupon   = @nCupones
		   
		SET @fPvp     = 0.0
		SET @fVan     = 0.0
		SET @fVpar    = 0.0
		SET @nNumucup = @nCupones
		SET @dFecucup = @dFecven
		SET @nNumpcup = @nCupones
		SET @dFecpcup = @dFecven
		SET @fIntpcup = 0.0
		SET @fAmopcup = 0.0
		SET @fSalpcup = 0.0
		
		RETURN
		
	END

	-- Para los Bonos del BCCH 
	DECLARE	@ctipo_moneda	CHAR	(01)	,
			@cdecimal	NUMERIC	(05)

	SELECT	@ctipo_moneda	= CASE WHEN mnmx='C' THEN '0'	ELSE '1' END	,
			@cdecimal	= mndecimal
	  FROM	VIEW_MONEDA
	 WHERE	mncodmon=@nMonemis


	IF @nMonemis=999 OR @ctipo_moneda='0'
		SELECT	@nValmon = 1
	ELSE
		SELECT	@nValmon	= vmvalor
		FROM	VIEW_VALOR_MONEDA
		WHERE	vmfecha	= @dFeccal	AND
			vmcodigo= @nMonemis
	IF @nValmon=0
	BEGIN
		SELECT	@nValmon	= vmvalor
		FROM	VIEW_VALOR_MONEDA
		WHERE	vmfecha	=(SELECT MAX(vmfecha) FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@nMonemis AND vmvalor<>0)	AND
			vmcodigo= @nMonemis     
	END
	
	DECLARE @TablaD		TABLE(	tdinteres		FLOAT
						,		tdamort			FLOAT
						,		tdsaldo			FLOAT
						,		tdflujo			FLOAT
						,		tdfecven		DATETIME
						,		tdcupon			SMALLINT
						,		tdlibor			FLOAT
						,		tdfecant		DATETIME
						,		tdsaldoin		FLOAT
						,		tdplazoini		NUMERIC(10)
						,		tdplazofin		NUMERIC(10)
						,		tdtasaini		FLOAT
						,		tdtasafin		FLOAT	
						,		tdtasaforward	FLOAT
						,		tdtasaEmision	FLOAT
						,		tdtasaTemp		FLOAT
						,		tddescuento		FLOAT
						,		tdCuponReal		SMALLINT
						,		tdVan			FLOAT
						) 
	
	
	DECLARE @Libor		FLOAT


	INSERT INTO @tablaD
	SELECT  
            tdinteres,
            tdamort,
			tdsaldo,
            tdflujo,
            tdfecven,
            tdcupon,
            0,
            tdfecven,
            tdsaldo,
            DATEDIFF(DAY,@dfeccal, tdfecven),	
            DATEDIFF(DAY,@dfeccal, tdfecven)+180.0,
            0,	
            0,
            0,
			@fTasemi,
			0,
			0,
			tdcupon+1
			,0
	 FROM  VIEW_TABLA_DESARROLLO
    WHERE tdmascara  = @cMascara
          
	UPDATE @TablaD
	   SET tdfecant = vd.tdfecven
	  FROM @TablaD r
	 INNER 
	  JOIN VIEW_TABLA_DESARROLLO vd
	    ON vd.tdmascara  = @cMascara
	   AND (vd.tdcupon-1)=r.tdcupon-1
	WHERE r.tdcupon >1

	SELECT @dfechaCurvas =@dFeccal
	 
	IF NOT EXISTS(SELECT 1 FROM BacParamSuda.dbo.CURVAS  WHERE codigocurva = 'CURVASWAPUSD' and fechageneracion=@dFeccal)
	BEGIN
		SET @dfechaCurvas =(SELECT MAX(fechageneracion) FROM BacParamSuda.dbo.CURVAS  WHERE codigocurva = 'CURVASWAPUSD' and fechageneracion<@dFeccal)
	END
	
     --> Creo Tabla temporal con informacion 
     
    DECLARE @Curva	TABLE(	cCurva			VARCHAR(20)
						,	vTasa			FLOAT
						,	vTasaMenor		FLOAT
						,	vTasaMayor		FLOAT
						,	iPlazoMenor		INT
						,	iPlazoMayor		INT
						,	iPlazo			INT
						,	sDirection		VARCHAR(1)	)
						
	INSERT INTO @Curva 	
	SELECT DISTINCT 
		'CURVASWAPUSD'			AS cCurva
	,	CONVERT(FLOAT,0 )		AS vTasa
	,	CONVERT(FLOAT,0 )      	AS vTasaMenor
	,	CONVERT(FLOAT,0 )      	AS vTasaMayor
	,	CONVERT(INT,0 )      	AS iPlazoMenor
	,	CONVERT(INT,0 )      	AS iPlazoMayor
	,	DATEDIFF(DAY,@dFeccal,tdfecven) AS iPlazo
	,	'N'					   AS sDirection
	FROM VIEW_TABLA_DESARROLLO
   WHERE tdmascara  = @cMascara
  UNION
	SELECT DISTINCT 
		'CURVASWAPUSD'			AS cCurva
	,	CONVERT(FLOAT,0 )		AS vTasa
	,	CONVERT(FLOAT,0 )      	AS vTasaMenor
	,	CONVERT(FLOAT,0 )      	AS vTasaMayor
	,	CONVERT(INT,0 )      	AS iPlazoMenor
	,	CONVERT(INT,0 )      	AS iPlazoMayor
	,	DATEDIFF(DAY,@dFeccal,tdfecven)+180 AS iPlazo
	,	'N'					   AS sDirection
	FROM VIEW_TABLA_DESARROLLO
   WHERE tdmascara  = @cMascara
   UNION
   	SELECT DISTINCT 
		'CURVASWAPUSD'			AS cCurva
	,	CONVERT(FLOAT,0 )		AS vTasa
	,	CONVERT(FLOAT,0 )      	AS vTasaMenor
	,	CONVERT(FLOAT,0 )      	AS vTasaMayor
	,	CONVERT(INT,0 )      	AS iPlazoMenor
	,	CONVERT(INT,0 )      	AS iPlazoMayor
	,	DATEDIFF(DAY,@dFeccal,@dFecven) AS iPlazo
	,	'N'					   AS sDirection
	
 	UPDATE @Curva 
	   SET vTasa		= ISNULL(valorbid,0)
	,	   vTasaMenor	= ISNULL(valorbid,0)
	,	   vTasaMayor	= ISNULL(valorbid,0)
	,	   iPlazoMenor	= iPlazo
	,	   iPlazoMayor	= iPlazo
	  FROM @Curva	
	  LEFT 
	  JOIN BACPARAMSUDA.DBO.CURVAS B WITH(nolock)
	    ON B.FechaGeneracion = @dfechaCurvas
	   AND B.CodigoCurva     = cCurva
	   AND dias				 = iplazo

	UPDATE @Curva 
	   SET iPlazoMenor	= ISNULL((SELECT MAX(dias) 	
									FROM BacParamSuda.dbo.CURVAS B WITH(NOLOCK)
								   WHERE B.FechaGeneracion	= @dfechaCurvas
									 AND CodigoCurva		= cCurva
									 AND dias				< iplazo),0)
	,	   iPlazoMayor	= ISNULL((SELECT MIN(dias) 
	 	              	            FROM BACPARAMSUDA.DBO.CURVAS B WITH(NOLOCK)
	 	        	           WHERE B.FechaGeneracion	= @dfechaCurvas
									 AND CodigoCurva		= cCurva
									 AND dias			    > iplazo),0)
	 WHERE vTasa	= 0

	UPDATE @Curva 
	   SET iPlazoMenor	= iPlazoMayor
	,	   iPlazoMayor	= ISNULL((SELECT MIN(dias) 
	 	              		 FROM BACPARAMSUDA.DBO.CURVAS B WITH(NOLOCK)
	 	              	    WHERE B.FechaGeneracion	= @dfechaCurvas 
							  AND CodigoCurva		= cCurva
							  AND Dias			> iPlazoMayor),0)
	,	   sDirection	= 'I'
	  FROM @Curva 	
	 WHERE vTasa		= 0
	   AND iPlazoMenor	= 0

	UPDATE @Curva  
	   SET iPlazoMayor  = iPlazoMenor
	,	   iPlazoMenor	= ISNULL((SELECT MAX(dias) 
							 FROM BACPARAMSUDA.DBO.CURVAS B WITH(NOLOCK)
							WHERE B.FechaGeneracion	= @dfechaCurvas
							  AND CodigoCurva		= cCurva
							  AND Dias < iPlazoMenor),0)
	,      sDirection	= 'S'
	  FROM @Curva 
	 WHERE vTasa		= 0
	   AND iPlazoMayor	= 0 
	
	UPDATE	@Curva  
	SET	vTasaMayor	= ISNULL(x.valorbid,0)
	,	vTasaMenor	= ISNULL(b.valorbid,0)
	,	sDirection	= 'N'
	FROM @Curva INNER JOIN BacParamSuda.dbo.CURVAS B WITH(NOLOCK)
					ON b.fechageneracion  = @dfechaCurvas
					AND b.codigocurva      = cCurva
					AND dias=iplazomenor
				INNER JOIN BacParamSuda.dbo.CURVAS x WITH(NOLOCK)
					ON x.fechageneracion  = @dfechaCurvas
					AND x.codigocurva      = cCurva
					AND x.dias=iplazomayor
	WHERE	vTasa	= 0
	 
--    SELECT * FROM @curva

	UPDATE	@Curva 
	SET	vTasa	= vTasaMenor + CASE	WHEN sDirection ='N' THEN ((iPlazo-iplazoMenor) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) ) 
						WHEN sDirection ='I' THEN ((iPlazoMenor-iPlazo) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) ) * - 1 
						WHEN sDirection ='S' THEN ((iPlazo-iPlazoMayor) * ((vTasaMayor-vTasaMenor)/(iPlazoMayor-iPlazoMenor) ) ) 
				       END
    	 WHERE	vTasa	= 0
    	 
	UPDATE @TablaD
	   SET tdplazoini = (SELECT tdplazoini from @TablaD f WHERE f.tdcupon=ad.tdcupon-1),
		   tdplazofin = (SELECT tdplazofin from @TablaD f WHERE f.tdcupon=ad.tdcupon-1)
	FROM @TablaD ad
	WHERE tdcupon>1

	UPDATE @TablaD 
	   SET tdtasaini = vTasa
	  FROM @TablaD
	 INNER
	  JOIN @Curva
	    ON iplazo=tdplazoini
	   AND tdfecven>@dfeccal   

	UPDATE @TablaD 
	   SET tdtasafin = vTasa
	  FROM @TablaD
	 INNER
	  JOIN @Curva
	    ON iplazo=tdplazofin
	AND tdfecven>@dfeccal

	/*===========================================================================================================*/
	/* Recupera el próximo cupón y el anterior.                                                                  */
	/*===========================================================================================================*/
	SET @nSaldo   = 100.0
	SET @dFecucup = @dFecemi
	SET @nNumucup = 0
	SET @fAmoucup = 0.0
	SET @fIntucup = 0.0
	SET @fSalucup = 0.0
	/*===========================================================================================================*/
	/* Próximo Cupón                                                                                             */
	/*===========================================================================================================*/
	SET ROWCOUNT 1
	
	SELECT	@nNumpcup   = tdcupon,
			@dFecpcup   = tdfecven,
			@fIntpcup   = tdinteres,
			@fAmopcup   = tdamort,
			@auxFluj    = tdflujo,
			@fSalpcup   = tdsaldo
	  FROM  @TablaD
	 WHERE tdfecven    > @dFeccal
	 
	SET ROWCOUNT 0
	SELECT @fSalpcup = @nSaldo
	/*===========================================================================================================*/
	/* Cupón Anterior                                                                                            */
	/*===========================================================================================================*/
	SET ROWCOUNT 1
	
	SELECT  @nNumucup   = tdcupon,
			@dFecucup   = tdfecven,
			@fIntucup   = tdinteres,
			@fAmoucup   = tdamort,
			@auxFluj    = tdflujo,
			@nSaldo     = tdsaldo
	  FROM  @TablaD
	 WHERE tdfecven    < @dFecpcup
	 ORDER 
	    BY tdcupon DESC
	
	SET ROWCOUNT 0
		
		DECLARE @dFecLibor DATETIME 
		set @dFecLibor = @dFecucup
		
   		SET @Libor		=(SELECT  vmvalor FROM view_valor_moneda WHERE vmcodigo=222 AND vmfecha = @dFecucup) ;
   		
   		while @libor=0
   		BEGIN
   			SET @dFecLibor =DATEADD(dd,-1,@dfeclibor)
   			SET @libor=(SELECT  vmvalor FROM view_valor_moneda WHERE vmcodigo=222 AND vmfecha = @dFecLibor) ;
   		
   		END 
		SET @Libor		= @Libor		/100.0
	
   SELECT @fSalucup = @nSaldo
   	
	IF @nNumucup = 0 BEGIN
		SELECT @nSaldo = 100.0
	END ELSE BEGIN
		SELECT @nSaldo = tdsaldo
		  FROM @TablaD
		 WHERE tdcupon   = @nNumuCup
	END
	
	
	UPDATE @TablaD SET tdtasaforward = @Libor WHERE tdcupon= @nNumpcup  --> Asigno tasa conocida a prox cupon a pagar

		
	UPDATE @TablaD
	SET tdtasaforward=( POWER((1+(tdtasafin/100)),(tdplazofin/360.0)) /POWER((1+(tdtasaini/100)),(tdplazoini/360.0))-1.0)*360/180
	WHERE tdcupon> @nNumpcup --tdfecven >@dFeccal

	UPDATE @TablaD
	SET tdlibor =  (tdtasaEmision +( tdtasaforward*100.0)  )
	WHERE tdcupon>= @nNumpcup
	 
   UPDATE @TablaD
      SET tdfecant   = @dfecemi 
	,	  tdsaldoin = @fSalucup
	WHERE tdcupon  =1

	 
   UPDATE @TablaD
      SET tdfecant   = fecha
   FROM @TablaD
   INNER JOIN (SELECT tdcupon AS flujo, tdfecven as fecha FROM @tablad  ) tabla	
      ON tdCuponReal=flujo
	WHERE tdcupon  >1
     
	UPDATE @TablaD
	   SET tdDescuento = (SELECT tdtasaini from @TablaD f WHERE f.tdcupon=ad.tdcupon+1)
	FROM @TablaD ad
	WHERE tdcupon>1
	
	UPDATE @TablaD SET tddescuento =  vtasa
	FROM  @TablaD
	INNER JOIN  @curva ON iplazo =DATEDIFF(DAY,@dFeccal,@dFecven)
	WHERE tdcupon = (SELECT MAX(tdcupon) FROM @TablaD td) 
	  

	UPDATE @TablaD
       SET tdinteres = ISNULL(ROUND( (100.0 *  tdlibor * (180.0 / 36000.0 )), 6 ),0)  
                               
	UPDATE @TablaD
	   SET tdflujo   = tdamort + tdinteres



      SELECT @fVpar  = ROUND( CONVERT( FLOAT, @fSalucup ) * 
                             POWER( CONVERT( FLOAT, 1.0 ) + (((@libor + @fTir) * 
                              CONVERT( FLOAT, DATEDIFF( DAY, @dFecuCup, @dFecpCup ) )) / CONVERT( FLOAT, 36000.0 )),
                              CONVERT( FLOAT, DATEDIFF( DAY, @dFecucup, @dFeccal ) ) / CONVERT( FLOAT, DATEDIFF( DAY, @dFecuCup, @dFecpCup ) ) ), 8 )

      SELECT @fVpar  = ROUND( @nSaldo * POWER( CONVERT( FLOAT, 1 ) + @nTera / CONVERT( FLOAT, 100 ),  
                                               DATEDIFF( DAY, @dFecucup, @dFeccal ) / CONVERT( FLOAT, 365 ) ), 8 )  


      SELECT @fTasemi = (@fTasa + @fTasaFlot)
   /*************************************************************************************************************/
   /*************************************************************************************************************/
   /**   Modalidad 2                                                                     **/
   /*************************************************************************************************************/
   /*************************************************************************************************************/
   IF @Modcal = 2 OR @Modcal = 5 BEGIN
      
      SELECT @fVan     = 0.0
      SELECT @fVan_1   = 0.0
      SELECT @fVan_2   = 0.0
      
      /*========================================================================================================*/
      /** Calculo del Van                                                                                       */
      /*========================================================================================================*/
      
      UPDATE @TablaD  set tdvan   =  tdflujo / POWER( CONVERT( FLOAT, 1 ) + ((tddescuento+@ftir)/ CONVERT( FLOAT, 100 )), DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 360 ) ) 
      
      SELECT @fVan	   = SUM( tdflujo / POWER( CONVERT( FLOAT, 1 ) + ((tddescuento+@ftir)/ CONVERT( FLOAT, 100 )), DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 360 ) ) ),
			 @fDurat   = SUM( ( tdflujo * DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 360 ) /
						 POWER( CONVERT( FLOAT, 1 ) + (tddescuento+@ftir)/ CONVERT( FLOAT, 100 ),
                         DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT,360 ) ) ) ),
			 @fConvx   = SUM( ( tdflujo * DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 360 ) ) *
                         ( ( DATEDIFF( DAY, @dFeccal, tdfecven ) / CONVERT( FLOAT, 360 ) ) +
                         CONVERT( FLOAT, 1 ) ) / POWER( CONVERT( FLOAT, 1 ) + (tddescuento+@ftir)/
                         CONVERT( FLOAT, 100 ), DATEDIFF( DAY, @dFeccal, tdfecven ) /
                         CONVERT( FLOAT, 360 ) ) )
		FROM @TablaD
	   WHERE tdcupon   > @nNumucup

		
--> SELECT @fVpar
      /*========================================================================================================*/
      /* Duration y Convexidad                                                                                  */
      /*========================================================================================================*/
      SELECT @fDurat = ROUND( @fDurat / @fVan, 8 )
      SELECT @fConvx = ROUND( ( @fConvx / POWER( CONVERT( FLOAT, 1 ) + (@fTir+@Libor) / CONVERT( FLOAT, 100 ),
                                                 CONVERT( FLOAT, 2 ) ) ) / @fVan, 8 )
      SELECT @fDurmo = ROUND( @fDurat / ( CONVERT(FLOAT,1) + ( ( (@fTir+@Libor) / CONVERT( FLOAT, 100 ) ) / @pervcupano ) ), 8 )
      /*========================================================================================================*/
      /* % Valor Par                                               */
      /*========================================================================================================*/
	 
		SELECT @fPvp  = ROUND( ( @fVan / @fVpar ) * CONVERT( FLOAT, 100 ), 2 )
      
		SELECT @fMt  =  (@fVan/100.0)*@fNominal --( @fPvp / CONVERT( FLOAT, 100 ) ) * ( @fVpar / CONVERT( FLOAT, 100 ) ) * @fNominal
         
		SELECT @fMt_cien = ROUND( ( @fPvp / CONVERT( FLOAT, 100 ) ) * ( @fVpar / CONVERT( FLOAT, 100 ) ) *
						 CONVERT( FLOAT, 100 ), 4 )
		IF @nMonemis = 999
		BEGIN 
		 SELECT @fMtum    = ROUND(@fMt,0)
		END ELSE
		BEGIN
		 SELECT @fMtum    = @fMt
		END

		SELECT @fMt      = ROUND( @fMt * @nValmon, CASE WHEN @ctipo_moneda ='0' THEN @cdecimal ELSE 0 END )
   END

   --SELECT tdsaldo, tdcupon,tdfecven,tdplazoini,tdplazofin,tdtasaini, tdtasafin, tdtasaforward,tdlibor, tdinteres, tdflujo,tddescuento,tdvan FROM @TablaD 
END
-- =======================================================================================================================
-- PRUEBA DE BONOS CON TASA FLOTANTE
-- =======================================================================================================================

--sp_helptext sp_md0200c
--SP_VALORIZAR_CLIENT 2, '20110510', 4, 'PRC-4D0402', 998, '2011401', '20100401', 6, 360, 0, 10000, 0.0, 0.0, 179731267
--execute SP_VALORIZAR_CLIENT 2, '20110510', 15, 'BCAPS-F   ', 994, '20080515', '20180515', 2.25, 360, 0, 9050000, 2.7389, 95.53, 232594120
--> select  * from bacparamsuda.dbo.curvas where fechageneracion='20110510'

GO
