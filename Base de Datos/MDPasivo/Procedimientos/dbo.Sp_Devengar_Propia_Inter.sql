USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Devengar_Propia_Inter]    Script Date: 16-05-2022 11:18:09 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Devengar_Propia_Inter]
				(    
                                @EJECUCION      CHAR(1)         ,
                                @nNumdocu	NUMERIC	(10,0)	= 0,
		                @nNumoper	NUMERIC	(10,0)  = 0,
		                @nCorrela	NUMERIC	(03,0)  = 0,
				@dFechoy	DATETIME	= '',
				@dFecprox	DATETIME	= '',
				@fTe_pcdus	FLOAT   	= 0,
				@fTe_pcduf	FLOAT   	= 0,
				@fTe_ptf	FLOAT   	= 0,
				@cDevengo_dolar	CHAR	(01)    = '',
                                @nRutcart	NUMERIC(10)     = 0,
				@nTipcart	NUMERIC	(05,0)	= 0,
				@cInstser	CHAR(12)        = '',
				@cInstcam	CHAR(12)        = '',
				@fNominal	FLOAT           = 0, 
				@fTir		FLOAT           = 0, 
				@iCodigo	INTEGER		= 0,
				@dFecemi	DATETIME        = '',
				@dFecven	DATETIME        = '',
				@nValcomp_O	FLOAT           = 0,
				@fValcomu_O	FLOAT           = 0,
				@nVpresen_O	FLOAT           = 0,
				@nIntMes_O	FLOAT           = 0,
				@nReaMes_O	FLOAT           = 0,
 				@nInteres_O	FLOAT           = 0,
				@nReajuste_O	FLOAT           = 0,
				@fPvp		FLOAT           = 0,
                                @cppvpcomp      FLOAT           = 0,
				@dFecucup	DATETIME        = '',
                                @dFecpcup       DATETIME        = '',
                                @cSeriado	CHAR	(01)	= '',
                                @cMascara	CHAR	(10)	= '',
                                @dFeccomp	DATETIME	= '',
                                @cartera        CHAR(03)        = '',
                                @nrutcli        NUMERIC(10)     = 0,
                                @ncodcli        NUMERIC(10)     = 0,
                                @codmon         NUMERIC(03)     = 0,
                                @carterasuper   CHAR(1)         = '',
				@FechaPacto	DATETIME	= '',
				@tipoper	CHAR(3)		= ''
				)
AS
BEGIN

        SET DATEFORMAT dmy

          DECLARE @dFecha_Mes_Actual      DATETIME
              ,   @dFecha_Mes_Anterior    DATETIME
              ,   @Estado_Reajuste        CHAR(1)
	      ,   @Sw_Reajuste		  CHAR(1)



                  DECLARE 	@nIntMes	FLOAT           ,
				@nReaMes	FLOAT           ,
 				@nInteres	FLOAT           ,
				@nReajuste	FLOAT           ,
				@nValcomp	FLOAT           ,
				@fValcomu	FLOAT           ,
				@nVpresen	FLOAT


                  SELECT	@nIntMes	= @nIntMes_O      ,
				@nReaMes	= @nReaMes_O      ,
 				@nInteres	= @nInteres_O     ,
				@nReajuste	= @nReajuste_O    ,
				@nValcomp	= @nValcomp_O     ,
				@fValcomu	= @fValcomu_O     ,
				@nVpresen	= @nVpresen_O



	SET NOCOUNT ON

	DECLARE	@cProg		CHAR	(10)	,
		@iModcal	INTEGER		,
		@iMonemi	INTEGER		,
		@fTasemi	FLOAT		,
		@fBasemi	FLOAT		,
                @npvpcomp       FLOAT           , 
		@fMT		FLOAT		,
		@fMTUM		FLOAT           ,
		@fMT_cien	FLOAT		,
		@fVan		FLOAT		,
		@fVpar		FLOAT		,
		@nNumucup	INTEGER		,
		@fIntucup	FLOAT		,
		@fAmoucup	FLOAT		,
		@fSalucup	FLOAT		,
		@nNumpcup	INTEGER		,
		@fIntpcup	FLOAT		,
		@fAmopcup	FLOAT		,
		@fSalpcup	FLOAT		,
		@fDurat		FLOAT		,
		@fConvx		FLOAT		,
		@fDurmo		FLOAT		,
		@nError		INTEGER         ,
		@fTasest	FLOAT           ,
                @cTipo_Moneda_papel   CHAR(1) ,
                @nDecimal       INTEGER
    

	DECLARE @fNomiReal	FLOAT		,
		@fValmon_Hoy	NUMERIC(19,4)   ,
		@fValmon_Man	NUMERIC(19,4)	,
		@fValmon_Vct	NUMERIC(19,4)	,
		@fValmon_Com	NUMERIC(19,4)	,
		@fValmon_Cup	NUMERIC(19,4)	,
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
		@nPagCup	NUMERIC	(19,4)	,
		@nDifReaCup	NUMERIC	(19,4)

	DECLARE	@nIntdia	NUMERIC	(19,4)	,
		@nReadia	NUMERIC	(19,4)	,
		@fTasaFloat	FLOAT           ,
                @reajuste_papel FLOAT

	DECLARE @nMes		INTEGER		,
		@nAno		INTEGER		,
		@nMes_a		INTEGER		,
		@iAst		INTEGER		,

		@cMes		CHAR	(02)	,
		@cAno		CHAR	(04)	,
		@iPago_Nohabil	INTEGER		,
		@sw_contab	CHAR	(01)	,
		@sw_deven	CHAR	(01)	,
		@iX		INTEGER		,
		@nContador	INTEGER		,
		@dFecDevengo	DATETIME	,
		@nValorpara	FLOAT 		,
		@X1		FLOAT           ,
                @Fecha_anterior DATETIME


        DECLARE @dplazo_operacion    NUMERIC(6)
              , @dplazo_calculo      NUMERIC(6)


        SELECT @Sw_Reajuste = 'N'

        SELECT @Fecha_anterior = fecha_anterior
        FROM VIEW_DATOS_GENERALES

      IF @EJECUCION = 'C' BEGIN      --SI PARA LLEVAR A VISUAL LA CONSULTA DE PAPELES

	 SELECT @X1 =0	
        --** Guarda Fecha de Devengo segun dolar **--
        
  	IF @cDevengo_dolar='N' BEGIN
		SELECT	@dFecDevengo	= @dFecHoy		
        END

	--** Variables Chequeo Fin de Mes no Habil **--
	SELECT	@iX		= 0		,
		@nMes		= 0		,
		@cMes		= ''


		
		IF @cDevengo_dolar='N'
		BEGIN

			IF (SELECT SUM(rsreajuste)
			    FROM  RESULTADO_DEVENGO
			    WHERE rsfecha=@dFechoy AND (rscartera='111' OR rscartera='114') AND
				 (rsmonemi=999 OR rsmonemi=998 OR rsmonemi=997) OR rscodigo=13
				 AND rscodigo =888) <> 0 AND (SELECT Estado_Reajuste FROM VIEW_DATOS_GENERALES) = 'S'
			BEGIN
				
			 	UPDATE VIEW_DATOS_GENERALES SET Estado_Reajuste = 'N'
			END


			DELETE	FROM RESULTADO_DEVENGO
			WHERE	rsfecha=@dFechoy AND (rscartera='111' OR rscartera='114') AND
				(rsmonemi=999 OR rsmonemi=998 OR rsmonemi=997) OR rscodigo=13

			IF @@ERROR<>0
			BEGIN
				SELECT 'NO','No se pudieron eliminar registros de tabla Resultado'
				RETURN
			END
		END
		ELSE
		BEGIN
			DELETE	FROM RESULTADO_DEVENGO
			WHERE	(rsmonemi<>999 AND rsmonemi<>998 AND rsmonemi<>997) AND rsfecha=@dFechoy AND
				(rscartera='111' OR rscartera='114') 
			IF @@ERROR<>0
			BEGIN
				SELECT 'NO','No se pudieron eliminar registros de tabla Resultado'
				RETURN
			END
		END
		

	     -- D E V E N G A M I E N T O   C A R T E R A    P R O P I A    D I S P O N I B L E    E    I N T E R M E D I A D A  --  
	     -- ________________________________________________________________________________________________________________ --

		SELECT	'rutcart'	= cprutcart			,   -- 01
			'tipcart'	= cptipcart			,   -- 02
			'instser'	= cpinstser			,   -- 03
			'instcam'	= cpinstser			,   -- 04
			'mascara'	= cpmascara			,   -- 05
			'feccomp'	= CONVERT(CHAR(10),cpfeccomp,103),  -- 06
			'tircomp'	= cptircomp			,   -- 07
			'nominal'	= cpnominal		        ,   -- 08
			'valcomp'	= cpcapitalc		        ,   -- 09
			'valcomu'	= cpvalcomu		        ,   -- 10
			'intdia'	= CONVERT(NUMERIC(19,4),0)	,   -- 11
			'readia'	= CONVERT(NUMERIC(19,4),0)	,   -- 12
			'interes'	= cpinteresc		        ,   -- 13
			'reajuste'	= cpreajustc		        ,   -- 14
			'interesmes'	= cpintermes		        ,   -- 15
			'reajustemes'	= cpreajumes		        ,   -- 16
			'readifmes'	= CONVERT(NUMERIC(19,4),0)	,   -- 17
			'seriado'	= cpseriado			,   -- 18
			'codigo'	= cpcodigo			,   -- 19
			'valptehoy'	= cpvptirc			,   -- 20
			'valpteman'	= CONVERT(NUMERIC(19,4),0)	,   -- 21
			'amocup'	= CONVERT(FLOAT,0)		,   -- 22
			'intcup'	= CONVERT(FLOAT,0)		,   -- 23
			'reacup'	= CONVERT(FLOAT,0)		,   -- 24
			'flujo'		= CONVERT(FLOAT,0)		,   -- 25
			'duration'	= CONVERT(FLOAT,0)		,   -- 26
			'durmodif'	= CONVERT(FLOAT,0)		,   -- 27
			'convex'	= CONVERT(FLOAT,0)		,   -- 28
			'tasa_float'	= CONVERT(FLOAT,0)		,   -- 29
			'monemi'	= CONVERT(INTEGER,0)		,   -- 30
			'basemi'	= CONVERT(FLOAT,0)		,   -- 31
			'tasemi'	= CONVERT(FLOAT,0)		,   -- 32
			'fecemi'	= CONVERT(CHAR(10),cpfecemi,103),   -- 33
			'fecven'	= CONVERT(CHAR(10),cpfecven,103),   -- 34
			'cupon'		= CONVERT(INTEGER,0)		,   -- 35
			'pvpcomp'	= CONVERT(FLOAT,0)		,   -- 36
			'numucup'	= CONVERT(FLOAT,0)		,   -- 37
			'numpcup'	= CONVERT(FLOAT,0)		,   -- 38
			'fecucup'	= CONVERT(CHAR(10),cpfecucup,103),   -- 39
			'fecpcup'	= CONVERT(CHAR(10),cpfecpcup,103),   -- 40
			'condpacto'	= CONVERT(CHAR(01),'')		,   -- 41
			'flag'		= CONVERT(CHAR(01),'N')         ,   -- 42
                        'cppvpcomp'     = cppvpcomp                     ,   -- 43
                        'intpcup'       = CONVERT(NUMERIC(19,4),0)      ,   -- 44
		        'amopcup'       = CONVERT(NUMERIC(19,4),0)      ,   -- 45
                        'reapcup'       = CONVERT(NUMERIC(19,4),0)      ,   -- 46
                'flupcup'       = CONVERT(NUMERIC(19,4),0)      ,   -- 47
                        'numdocu'       = cpnumdocu                     ,   -- 48
                        'correla'       = cpcorrela                     ,   -- 49
                        'numoper'       = cpnumdocu                     ,   -- 50
                        'cartera'       = 'CP '                         ,   -- 51
                        'rutcli'        = cprutcli                      ,   -- 52
                        'codcli'        = cpcodcli                      ,   -- 53
                        'carterasuper'  = CARTERA_PROPIA.codigo_carterasuper ,-- 54
			'FechaPacto'	= cpfeccomp			,	--55
			'tipoper'	= 'CP'
		INTO	#TEMPORAL
      	        FROM	CARTERA_PROPIA,
                        CARTERA_DISPONIBLE,
                        VIEW_MONEDA
		WHERE	cprutcart>0 AND cpcodigo<>98
		  AND   cpnominal > 0
                  AND   cpnumdocu = dinumdocu
                  AND   cpcorrela = dicorrela
                  AND   dinemmon  = mnnemo
                  AND   CHARINDEX(STR(mncodmon,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999-503' ELSE '988-994-995- 13' END)>0
                UNION
		SELECT	'rutcart'	= virutcart			,   -- 01
			'tipcart'	= 1		                ,   -- 02
			'instser'	= viinstser			,   -- 03
			'instcam'	= viinstser			,   -- 04
			'mascara'	= vimascara			,   -- 05
			'feccomp'	= CONVERT(CHAR(10),vifeccomp,103),   -- 06
			'tircomp'	= vitircomp			,   -- 07
			'nominal'	= vinominal		        ,   -- 08
			'valcomp'	= vicapitalv                    ,   -- 09
			'valcomu'	= vivalcomu		        ,   -- 10
			'intdia'	= CONVERT(NUMERIC(19,4),0)	,   -- 11
			'readia'	= CONVERT(NUMERIC(19,4),0)	,   -- 12
			'interes'	= viinteresv		        ,   -- 13
			'reajuste'	= vireajustv		        ,   -- 14
			'interesmes'	= viintermesv		        ,   -- 15
			'reajustemes'	= vireajumesv		        ,   -- 16
			'readifmes'	= CONVERT(NUMERIC(19,4),0)	,   -- 17
			'seriado'	= viseriado			,   -- 18
			'codigo'	= vicodigo			,   -- 19
			'valptehoy'	= vivptirc			,   -- 20
			'valpteman'	= CONVERT(NUMERIC(19,4),0)	,   -- 21
			'amocup'	= CONVERT(FLOAT,0)		,   -- 22
			'intcup'	= CONVERT(FLOAT,0)		,   -- 23
			'reacup'	= CONVERT(FLOAT,0)		,   -- 24
			'flujo'		= CONVERT(FLOAT,0)		,   -- 25
			'duration'	= CONVERT(FLOAT,0)		,   -- 26
			'durmodif'	= CONVERT(FLOAT,0)		,   -- 27
			'convex'	= CONVERT(FLOAT,0)		,   -- 28
			'tasa_float'	= CONVERT(FLOAT,0)		,   -- 29
			'monemi'	= CONVERT(INTEGER,0)		,   -- 30
			'basemi'	= CONVERT(FLOAT,0)		,   -- 31
			'tasemi'	= CONVERT(FLOAT,0)		,   -- 32
			'fecemi'	= CONVERT(CHAR(10),vifecemi,103),   -- 33
			'fecven'	= CONVERT(CHAR(10),vifecven,103),   -- 34
			'cupon'		= CONVERT(INTEGER,0)		,   -- 35
			'pvpcomp'	= CONVERT(FLOAT,0)		,   -- 36
			'numucup'	= CONVERT(FLOAT,0)		,   -- 37
			'numpcup'	= CONVERT(FLOAT,0)		,   -- 38
			'fecucup'	= CONVERT(CHAR(10),vifecucup,103),   -- 39
			'fecpcup'	= CONVERT(CHAR(10),vifecpcup,103),   -- 40
			'condpacto'	= CONVERT(CHAR(01),'')		,   -- 41
			'flag'		= CONVERT(CHAR(01),'N')         ,   -- 42
                        'cppvpcomp'     = vipvpvent                     ,   -- 43
                        'intpcup'       = CONVERT(NUMERIC(19,4),0)      ,   -- 44
                        'amopcup'       = CONVERT(NUMERIC(19,4),0)      ,   -- 45
                        'reapcup'       = CONVERT(NUMERIC(19,4),0)      ,   -- 46
                        'flupcup'       = CONVERT(NUMERIC(19,4),0)      ,   -- 47
                        'numdocu'       = vinumdocu                     ,   -- 48
                        'correla'       = vicorrela                     ,   -- 49
                        'numoper'       = vinumoper                     ,   -- 50
                        ---PARA LA CONTABILIDAD -------
                        --'cartera'       = 'INT' ,   -- 51
             		'cartera'       = CASE WHEN vitipoper = 'CI' THEN vitipoper ELSE 'INT' END   ,   -- 51
                        'rutcli'        = virutcli                      ,   -- 52
                        'codcli'        = vicodcli                      ,   -- 53
                        'carterasuper'  = codigo_carterasuper           ,    -- 54
			'FechaPacto'	= vifecinip			,     --55
			'tipoper'	= codigo_subproducto
		FROM	CARTERA_VENTA_PACTO
		WHERE	virutcart>0 AND vicodigo<>98
     		AND     vinominal > 0
                AND     CHARINDEX(STR(vimonemi,3),CASE WHEN @cDevengo_dolar='N' THEN '997-998-999-503' ELSE '988-994-995- 13' END)>0


		IF @@ERROR<>0
		BEGIN
			SELECT 'NO','No se Puede Generar Tabla Temporal de Paso con CP para Devengamiento'
			RETURN
		END

			IF @cDevengo_dolar='S'
			BEGIN
				IF @iMonemi<>994 AND @iMonemi<>995 AND @iMonemi<>988
				BEGIN
					DELETE FROM #TEMPORAL
					WHERE	@nRutcart=rutcart AND @cInstcam=instser AND @dFeccomp=feccomp AND @fTir=tircomp

					IF @@ERROR<>0
					BEGIN
						SELECT 'NO','Problemas al Borrar Operaciones desde Temporal'
						RETURN
					END
				END
			END
			ELSE
			BEGIN
				IF @iMonemi=994 OR @iMonemi=995 OR @iMonemi=988
				BEGIN
					DELETE FROM #TEMPORAL
					WHERE	@nRutcart=rutcart AND @cInstcam=instser AND @dFeccomp=feccomp AND @fTir=tircomp

					IF @@ERROR<>0
					BEGIN
						SELECT 'NO','Problemas al Borrar Operaciones desde Temporal'

						RETURN
					END
				END
			END

                        SELECT * FROM #TEMPORAL
	                WHERE (CONVERT(DATETIME,fecven,103) >= @dFechoy) AND flag<>'S' -- nominal>0 AND 

                  RETURN
         END ---FIN SI PARA LLEVAR A VISUAL LA CONSULTA DE PAPELES




         IF @EJECUCION = 'D' BEGIN


                        -- PLAZO PARA CALCULO DE DIFERIDO

                           DECLARE @nRutEmisor   NUMERIC(9)
                                 , @nPremio      NUMERIC(19)
                                 , @nDescuento   NUMERIC(19)

                            SELECT @nPremio    = 0
                                 , @nDescuento = 0
            
                            SELECT @nRutEmisor   = emrut
                                 , @nPremio      = premio
                                 , @nDescuento   = descuento
                              FROM CARTERA_DISPONIBLE
                                 , VIEW_EMISOR
                             WHERE digenemi      = emgeneric
                               AND dinumdocu     = @nNumdocu
                               AND dicorrela     = @nCorrela

                           IF @iCodigo = 20 AND @nRutCart = @nRutEmisor BEGIN
      
                                 SELECT @dplazo_operacion    = DATEDIFF(DAY, @dFeccomp ,@dFecven )
                                      , @dplazo_calculo      = DATEDIFF(DAY, @dFechoy ,@dFecprox )

                                 IF @dplazo_operacion = 0 BEGIN
                                    SELECT @dplazo_operacion = 1
                                         , @dplazo_calculo   = 1

                                 END


                                 SELECT @nPremio    = CASE WHEN @nPremio > 0 THEN
                                                                ROUND((( @nPremio / @dplazo_operacion ) * @dplazo_calculo),0)
                                                           ELSE 0 
                                                           END
                                      , @nDescuento = CASE WHEN @nDescuento > 0 THEN    
                                                                ROUND((( @nDescuento / @dplazo_operacion ) * @dplazo_calculo),0)
                                                           ELSE 0
                                                           END

                           END

                                 

                        -- FIN


			SELECT  @fMt		= 0.0			,
				@fMtum		= 0.0			,
				@fMt_cien	= 0.0			,
				@fVan		= 0.0			,
				@fVpar		= 0.0			,
				@nNumucup	= 0			,
				@fIntucup	= 0.0			,
				@fAmoucup	= 0.0			,
				@fSalucup	= 0.0			,
				@nNumpcup	= 0			,
				@fIntpcup	= 0.0			,
				@fAmopcup	= 0.0			,
				@fSalpcup	= 0.0			,
				@iAst		= 0			,
				@iPago_NoHabil	= 0			,
				@cProg		= 'SP_'+inprog		,
				@fDurat		= 0.0			,
				@fConvx		= 0.0			,
				@fDurmo		= 0.0			,
				@fValmon_Hoy	= 1.0			,
				@fValmon_Man	= 1.0			,
				@fValmon_Com	= 1.0			,
				@fValmon_Cup	= 1.0			,
				@fValmon_Vct	= 1.0			,
				@iMonemi	= 0			,
				@fTasemi	= 0.0			,
				@fBasemi	= 0.0			,
				@fTasest	= 0.0			,
				@nError		= 0			,
				@iCupon		= 0			,
				@fTasaFloat	= 0.0			,
				@iModcal	= 2			,
				@fAmocupo	= 0.0			,
				@fIntcupo	= 0.0			,
				@nReacup	= 0.0			,
				@nDifReaCup	= 0.0			,
				@nPagcup	= 0.0			,
				@fAmocupo	= 0.0			,
				@fValcupo	= 0.0			,
				@nIntcup	= 0.0			,
				@nReacup	= 0.0			,
				@nPagcup	= 0.0			,
				@nIntdia	= 0.0			,
				@nReadia	= 0.0                   
                                FROM VIEW_INSTRUMENTO
                                WHERE incodigo = @iCodigo

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
				FROM	NOSERIE
				WHERE	nsserie=@cInstser
				SET ROWCOUNT 0
			END


                        SELECT @cTipo_Moneda_papel = mnextranj,
                               @ndecimal     = mnredondeo
                        FROM VIEW_MONEDA 
                        WHERE mncodmon = @iMonemi

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

				IF (@iMonemi<>999 AND @iMonemi<>13)
				BEGIN
					SELECT	@fValmon_Hoy	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFechoy),0)
					SELECT	@fValmon_Man	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFecprox),0)
					SELECT	@fTasest 	= CASE
									WHEN @iCodigo=1 THEN @fTe_pcdus
									WHEN @iCodigo=2 THEN @fTe_pcduf
									WHEN @iCodigo=5 THEN @fTe_ptf
                  					 		ELSE CONVERT(FLOAT,0)
							  	  END

                                      IF @fValmon_Hoy = 0 BEGIN
                                      
					SELECT	@fValmon_Hoy = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND VMFECHA = @Fecha_anterior),0)            
                                        
                                       END 
                                                   
                                       IF @fValmon_Man = 0 BEGIN
                                      
					SELECT	@fValmon_Man   = @fValmon_Hoy                                        

                                       END 

                                       IF @fValmon_Hoy  = 0  BEGIN
					      SELECT 'NO','Falta Moneda:' + CONVERT(CHAR(3),@iMonemi) + ' del ' + CONVERT(CHAR(10),@dFechoy,103)
                                            RETURN
                                       END

                                       IF @fValmon_Man  = 0  BEGIN
                                            SELECT 'NO','Falta Moneda:' + CONVERT(CHAR(3),@iMonemi) + ' del ' + CONVERT(CHAR(10),@dFecprox,103)
                                            RETURN
                                       END

				END

				--** Valorizaci¢n a Pr¢ximo Proceso **--

                                IF @dFecven < @dFecprox BEGIN
	
					IF (@iMonemi<>999 AND @iMonemi<>13)
					BEGIN
						SELECT	@fValmon_vct = 0
						SELECT	@fValmon_vct = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFecven),0)

	                                       	IF @fValmon_vct  = 0  BEGIN
							SELECT 'NO','Falta Moneda:' + CONVERT(CHAR(3),@iMonemi) + ' del ' + CONVERT(CHAR(10),@dFecven,103)
	                                        	RETURN
						END

					END

     
          				EXECUTE	@nError	= @cProg @iModcal, @dFecven, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,
						@fNominal OUTPUT, @fTir OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,
						@nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
	       			    		@fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

                                END ELSE BEGIN
          				EXECUTE	@nError	= @cProg @iModcal, @dFecprox, @iCodigo, @cInstser, @iMonemi, @dFecemi, @dFecven, @fTasemi, @fBasemi, @fTasest,
						@fNominal OUTPUT, @fTir OUTPUT, @fPvp OUTPUT, @fMt OUTPUT, @fMtum OUTPUT, @fMt_cien OUTPUT, @fVan OUTPUT, @fVpar OUTPUT,
						@nNumucup OUTPUT, @dFecucup OUTPUT, @fIntucup OUTPUT, @fAmoucup OUTPUT, @fSalucup OUTPUT, @nNumpcup OUTPUT, @dFecpcup OUTPUT,
	       			    		@fIntpcup OUTPUT, @fAmopcup OUTPUT, @fSalpcup OUTPUT, @fDurat OUTPUT, @fConvx OUTPUT,@fDurmo OUTPUT

                                END  
                  
				IF @iCodigo=13  --**	Devengamiento DPX	**--
				BEGIN
					IF @dFechoy=@dFeccomp
						SELECT	@nVpresen	= @fNominal
					SELECT	@fMt	= ROUND(@fNominal*(((@fTir/(@fBasemi*100.0))*DATEDIFF(DAY,@dFeccomp,@dFecprox))+1.0),4)
				END                       



				IF (@dFecprox>=@dFecucup AND @dFechoy<@dFecucup) AND @iAst=0 AND @cartera<>'CI'
				BEGIN

					SELECT	@iCupon    = 1                                      

					IF @iMonemi<>999 AND @iMonemi<>13
					BEGIN
						SELECT	@fValmon_Cup	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFecucup),0)
						SELECT	@fValmon_Com	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFeccomp),0)

                                            IF @fValmon_Cup  = 0  AND @dFecucup = @dFecprox BEGIN
                                                SELECT 'NO','Falta Moneda:' + CONVERT(CHAR(3),@iMonemi) + ' del ' + CONVERT(CHAR(10),@dFecucup,103)
                                                RETURN
                                            END

                                            IF @fValmon_Com  = 0  BEGIN
                                                SELECT 'NO','Falta Moneda:' + CONVERT(CHAR(3),@iMonemi) + ' del ' + CONVERT(CHAR(10),@dFeccomp,103)
                                                RETURN
                                            END

					END

					IF @cSeriado='S'
					BEGIN
						--** Pago Inhabil **--
						IF @dFecucup>@dFechoy AND @dFecucup<=@dFecprox
							SELECT	@iPago_Nohabil	= 1

						SELECT	@fIntucup = ((@fIntucup * @fNominal) / CONVERT(FLOAT,100))
						SELECT	@fAmoucup = ((@fAmoucup * @fNominal) / CONVERT(FLOAT,100))
						SELECT	@fIntcupo = ROUND( @fIntucup * @fValmon_Cup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
						SELECT	@fAmocupo = ROUND( @fAmoucup * @fValmon_Cup,  CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
						SELECT	@nPagcup  = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Man,  CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)

						IF @dFecucup<>@dFecprox
							SELECT	@nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Man,  CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
						ELSE
							SELECT	@nPagcupo = ROUND( (@fIntucup + @fAmoucup) * @fValmon_Cup,  CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
						SELECT	@fValcupo = @fIntcupo + @fAmocupo
					END

				END



                                IF  (@iCodigo = 888 or @iCodigo = 889 or @iCodigo = 890 or @iCodigo = 891 or @iCodigo = 892) 
                                BEGIN

                                /********************************************************************************************************
                                                CAMBIO PARA LOS REAJUSTES DE LOS BONOS DE RECONOCIMIENTO                                 
                                ********************************************************************************************************/
					
                                        SELECT	@fValmon_Com	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=DATEADD(MONTH,-1,DATEADD(DAY,(DATEPART(day,@dFeccomp)*-1)+1,@dFeccomp))),0)

                                        IF @fValmon_Com  = 0  BEGIN
						
					    SELECT @fValmon_Com	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=DATEADD(MONTH,-2,DATEADD(DAY,(DATEPART(day,@dFeccomp)*-1)+1,@dFeccomp))),0)

	                                    IF @fValmon_Com  = 0  BEGIN

	                                            SELECT 'NO','Falta Moneda:502 del ' + CONVERT(CHAR(10),DATEADD(MONTH,-2,DATEADD(DAY,(DATEPART(day,@dFeccomp)*-1)+1,@dFeccomp)),103)
        	                                    RETURN
					    END
                                        END

                                        SELECT @dFecha_Mes_Anterior = DATEADD(MONTH,-2,DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy))

                                        SELECT @fValmon_Hoy = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFecha_Mes_Anterior),0)
                                        
                                                                     
                                        IF @fValmon_Hoy = 0 BEGIN
                                                SELECT 'NO', 'No se encuentra Moneda: 502 del ' + CONVERT(CHAR(10),@dFecha_Mes_Anterior,103)
                                                RETURN
                                        END

                                        SELECT @dFecha_Mes_Actual = DATEADD(MONTH,-1,DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy))

					SELECT	@fValmon_Man	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFecha_Mes_Actual),0)

                                        SELECT @Estado_Reajuste = Estado_Reajuste
                                            FROM VIEW_DATOS_GENERALES

					SELECT @nReadia = 0

                                        IF @fValmon_Man <> 0
					BEGIN

	 					IF @Estado_Reajuste = 'N' AND @fValmon_Man <> @fValmon_Hoy 
						BEGIN	
        	                                    SELECT @nReadia = ROUND(( @fValmon_Man - @fValmon_Hoy ) * ROUND(@nValcomp/@fValmon_Com, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END),  CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
						    SELECT @Sw_Reajuste = 'S'
						END
                	                        ELSE BEGIN
	                       	                    SELECT @nReadia = 0
						END
				 	END			

				END ELSE BEGIN 
     		      		       SELECT @nReadia = ROUND(( @fValmon_Man - @fValmon_Hoy ) * @fValcomu,  CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)                                 
               	                END


				SELECT	@nIntdia   = Round(@fMt - @nVpresen - @nReadia + @nPagcup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)

				SELECT	@nInteres  = @nInteres  
				SELECT	@nReajuste = @nReajuste 

				IF DATEPART(MONTH,@dFechoy)<>DATEPART(MONTH,@dFecprox)
					SELECT	@nIntMes   = 0.0	,
						@nReaMes   = 0.0

				--SELECT	@nIntMes   = @nIntMes   
				--SELECT	@nReaMes   = @nReaMes   

				--** Capitalizacion **--
				IF @iCupon=1

				BEGIN
					IF @cSeriado='S'
         				BEGIN

 						SELECT	@fFactor	= ((( @fIntucup * @fValmon_Cup ) - @nInteres ) / (CASE WHEN @fValmon_Cup = 0 THEN 1 ELSE @fValmon_Cup END))
						SELECT	@fCapital_UM	= @fAmoucup + @fFactor
						SELECT	@fCapital	= ROUND( @fCapital_UM * @fValmon_Com ,  CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)

						SELECT	@nReacup	= CASE WHEN  @fValmon_Cup <= 1   THEN ROUND( (@fValmon_Man-@fValmon_Com) * @fCapital_UM ,  CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END )
													 ELSE ROUND( (@fValmon_Cup-@fValmon_Com) * @fCapital_UM ,  CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END ) END

						SELECT	@nIntcup	= @nInteres
						SELECT	@nDifcup	= @nPagcup - ( @fCapital + @nReacup + @nIntcup )
         					SELECT	@fCapital	= @fCapital + @nDifcup

						SELECT	@nReacup	= @nReacup + ROUND((@fValmon_Man-(CASE WHEN @fValmon_Cup <= 1 THEN @fValmon_Man ELSE @fValmon_Cup END))* @fCapital_UM,  CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END )
	
						SELECT	@nIntcup	= @nPagcup - @fCapital - @nReacup
						SELECT	@fAmocupo	= @fCapital
						SELECT	@nDifReaCup	= @nPagcupo-(@fAmocupo+@nIntcup+@nReacup)
						SELECT	@nPagcup	= @nPagcupo

					END
					ELSE
					BEGIN
						SELECT	@fAmocupo	= @nValcomp
						SELECT	@fValcupo	= @nValcomp  + @nInteres + @nReajuste + @nIntdia + @nReadia
						SELECT	@nIntcup	= @nInteres  + @nIntdia	 + @nReadia,
							@nReacup	= @nReajuste + @nReadia,
							@nPagcup	= @fValcupo
					END
				END
			END

			IF @iCupon=1 AND @cSeriado='S'
			BEGIN
				SELECT	@ninteres	= CONVERT(NUMERIC(19,4),0)
                                SELECT	@nReajuste	= (@nReajuste - @nReacup)
				SELECT	@nValcomp	= @nValcomp  - @fCapital
				SELECT	@fValcomu	= ROUND( @nValcomp / (CASE WHEN @fValmon_com = 0 THEN 1 ELSE @fValmon_com END) ,4 )
				IF @iPago_NoHabil=0
					SELECT	@nInteres = 0.0
			END

/*
                                intpcup         = ((@fIntucup * @fNominal) / CONVERT(FLOAT,100)) ,
                                amopcup         = ((@fAmopcup * @fNominal)/ CONVERT(FLOAT,100)) ,
                                flupcup         = CASE WHEN  @iAst<>0 THEN 0.0 ELSE (((@fIntucup + @fAmoucup)* @fNominal) / CONVERT(FLOAT,100)) END
*/
                DECLARE @valvenc        FLOAT




                SELECT @reajuste_papel = 0

		IF @cartera='CI'
		BEGIN

			SELECT	@nInteres  	= 0,
				@nReajuste 	= 0,
				@nIntdia	= 0,
				@nReadia	= 0

	                IF @fintpcup = 0 AND @famopcup=0 AND @fsalpcup = 0 BEGIN
        	            SELECT  @valvenc   =   @fnominal
	                END ELSE BEGIN
        	            SELECT  @valvenc   = @fsalpcup
                	    SELECT  @valvenc   = (@valvenc  * @fnominal) /100
	                END
                        
                        IF (@iMonemi = 999 or @iMonemi = 13) BEGIN
                            SELECT @fValmon_Com	 =1
                        END ELSE BEGIN
        		    SELECT @fValmon_Com	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=@iMonemi AND vmfecha=@dFeccomp),0)
                        END

                        IF @fValmon_Com = 0 BEGIN
                            SELECT 'NO', 'Falta Moneda:' + CONVERT(CHAR(3),@IMONEMI) + CONVERT(CHAR(10),@dFeccomp,103)
                            RETURN
                        END

	                SELECT @reajuste_papel = ROUND(( @fValmon_Man - @fValmon_Com ) * ROUND(@valvenc,0),  CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)


			SELECT	@nPremio = ROUND( @fValmon_Man * @valvenc, 0)

		END


		INSERT INTO RESULTADO_DEVENGO
			(
			rsfecha		,-- 1
			rsrutcart	,-- 2
			rstipcart	,-- 3
			rsnumdocu	,-- 4
			rscorrela	,-- 5 
			rsnumoper	,-- 6
			rscartera	,-- 7
			rstipoper	,-- 8
			rsinstser	,-- 9
			rsrutcli	,-- 10
			rscodcli	,-- 11
			rsvppresen	,-- 12
			rsvppresenx	,-- 13
			rscupamo	,-- 14
			rscupint	,-- 15
			rscuprea	,-- 16
			rsflujo		,-- 17
			rsfecprox	,-- 18
			rsfecctb	,-- 19
			rsnominal	,-- 20
			rstir		,-- 21
			rstasfloat	,-- 22
			rsmonpact	,-- 23
			rsmonemi	,-- 24
			rstasemi	,-- 25
			rsbasemi	,-- 26
			rscodigo	,-- 27
			rsinteres	,-- 28
			rsreajuste	,-- 29
			rsintermes	,-- 30
			rsreajumes	,-- 31
			rsinteres_acum	,-- 32
			rsreajuste_acum	,-- 33
			rsforpagv	,-- 34
			rsvalcomp	,-- 35
 			rsvalcomu	,-- 36
			rsvalvenc	,-- 37
			rsdurat		,-- 38
			rsdurmod	,-- 39
			rsconvex	,-- 40
			rsnumucup	,-- 41
			rsnumpcup	,-- 42
			rsfecucup	,-- 43
			rsfecpcup	,-- 44
			rsvpcomp	,-- 45
			rstipopero	,-- 46
			rsfeccomp	,-- 47
			rsdifrea	,-- 48
			rsinstcam	,-- 49
			rsfecinip	,-- 50	 
			rsfecvtop	,-- 51	 
			rsvalvtop	,-- 52	 
			rsrutemis 	,-- 53	
			rsvalinip	,-- 54	
			rstaspact	,-- 55
			rsmascara	,-- 56
			rsfecemis	,-- 57
			rsfecvcto	,-- 58
                        rspvpcomp       ,-- 59                  
                        rsseriado       ,-- 60 
                        codigo_carterasuper , --61
                        premio          ,-- 62
                        descuento       ,-- 63
                        codigo_subproducto --64
			)

		SELECT
			@dFechoy	,-- 1 rsfecha,rsrutcart,rstipcart,rsnumdocu,rscorrela,rsnumoper,rscartera,rstipoper
			@nRutcart	,-- 2 
			@nTipcart       ,-- 3
			@nNumdocu	,-- 4
			@nCorrela	,-- 5
			@nNumoper	,-- 6
			CASE WHEN @cartera = 'CP'             THEN '111'
                             WHEN @cartera IN ( 'INT' , 'CI') THEN '114'
                             ELSE '' END,-- 7
			'DEV'		,-- 8
		        @cInstcam	,-- 9
			@nrutcli      	,-- 10
			@ncodcli	,-- 11
			@nVpresen_O	,-- 12 rsvppresen
			CASE WHEN @dFecven <= @dFecprox THEN
                                @nPagcup
                        ELSE  
                                          CASE WHEN @iCodigo =13 THEN ROUND((@nValcomp+@nInteres+@nReajuste+@nReadia+@nIntdia), CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					       ELSE ROUND((@nValcomp+@nInteres+@nReajuste+@nReadia+@nIntdia), CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					  END
                        END,-- 13 rsvppresenx
			CASE WHEN @iCodigo =13 THEN ROUND(@fAmocupo, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					       ELSE ROUND(@fAmocupo, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					  END,-- 14 rscupamo
			CASE WHEN @iCodigo =13 THEN ROUND(@nIntcup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
						ELSE ROUND(@nIntcup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					  END,-- 15 rscupint
			CASE WHEN @iCodigo =13 THEN ROUND(@nReacup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					       ELSE ROUND(@nReacup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					  END, -- 16 rscuprea
			CASE WHEN @iCodigo =13 THEN ROUND(@nPagcup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
						ELSE ROUND(@nPagcup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					  END,-- 17 rsflujo
			@dFecprox	,-- 18
			@dFechoy	,-- 19
			@fNominal	,-- 20
			@fTir	        ,-- 21
			@fTasaFloat	,-- 22 rstasfloat
			@iMonemi        ,-- 23 rsmonpact
			@iMonemi        ,-- 24 rsmonemi  
			@fTasemi	,-- 25 rstasemi
			@fBasemi	,-- 26 rsbasemi
			@iCodigo        ,-- 27
			CASE WHEN @iCodigo = 13 THEN ISNULL(ROUND(@nIntdia, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END),0)
						ELSE ISNULL(ROUND(@nIntdia, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END),0)
					   END,-- 28 rsinteres
			ROUND(@nReadia, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END),-- 29 rsreajuste
			@nIntMes_O	,-- 30 rsintermes
                        CASE WHEN @cartera = 'CI' THEN @reajuste_papel ELSE @nReaMes_O END,
			@nInteres_O	,-- 32 rsinteres
			@nReajuste_O	,-- 33 rsreajuste
			0		,-- 34 rsforpagv
			@nValcomp_O	,-- 35
			@fValcomu_O	, -- 36
			CASE WHEN @iCodigo = 13 THEN ROUND(CASE WHEN  @iAst<>0     THEN 0.0
                                                                WHEN  @iCodigo=888 THEN @nValcomp+@nInteres+@nReajuste+@nReadia+@nIntdia
                                                                ELSE (((@fIntpcup + @fAmopcup)* @fNominal) / CONVERT(FLOAT,100)) END, @ndecimal ) --CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END) --(@fIntucup + @fAmoucup)* @fNominal) / CONVERT(FLOAT,100))
 
						ELSE ROUND(CASE WHEN  @iAst<>0      THEN 0.0 
                                                                WHEN  @iCodigo=888  THEN @nValcomp+@nInteres+@nReajuste+@nReadia+@nIntdia
                                                                ELSE (((@fIntpcup + @fAmopcup)* @fNominal) / CONVERT(FLOAT,100)) END, @ndecimal )--CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					   END,-- 37 rsvalvenc
			@fDurat		,-- 38 rsdurat
			@fDurmo		,-- 39 rsdurmod
			@fConvx		,-- 40 rsconvex
			@nNumucup	,-- 41 rsnumucup
			@nNumpcup	,-- 42 rsnumpcup
			@dFecucup	,-- 43 rsfecucup
			@dFecpcup	,-- 44 rsfecpcup
			@fPvp		,-- 45 rsvpcomp
			CASE WHEN @cartera IN( 'CP') THEN 'CP'
			     WHEN @cartera IN( 'CI') THEN 'CI'
                             ELSE (CASE WHEN @tipoper = 'VIX' THEN 'VI' ELSE @tipoper END)
                        END,-- 46
			@dFeccomp	,-- 47
			@nDifReaCup	,-- 48 rsdifrea
			@cInstser	,-- 49 rsinstcam
			@FechaPacto	,-- 50
			''		,-- 51
			0.0		,-- 52
			0.0		,-- 53
			0.0		,-- 54
			0.0		,-- 55
			@cMascara	,-- 56
			@dFecemi	,-- 57
			@dFecven	,-- 58
                        @cppvpcomp      ,--cppvpcomp       ,-- 59 
			@cSeriado       ,-- 60
                        @carterasuper   ,-- 61
                        @nPremio        ,-- 62
                        @nDescuento     ,-- 63
                        --SE AGREGA ESTE CAMPO PARA CONTABILIDAD ******************
                        CASE WHEN @cartera = 'CI' THEN 'CI' 
                             WHEN @cartera = 'CP' THEN 'CP'
                             ELSE (CASE WHEN @tipoper = 'VIX' THEN 'VI' ELSE @tipoper END)
                        END      -- 64

		IF @@ERROR<>0
		BEGIN
			RETURN
		END

/***********************************************************************************************************************/
/**********************************   V E N C I M I E N T O S **********************************************************/
/***********************************************************************************************************************/
     IF @dFecven > @dFecprox  BEGIN

         IF (@nPagcup > 0 OR ((@cInstser <> @cInstcam) AND @iCodigo = 20)) BEGIN

		INSERT INTO RESULTADO_DEVENGO
			(
			rsfecha		,-- 1
			rsrutcart	,-- 2
			rstipcart	,-- 3
			rsnumdocu	,-- 4
			rscorrela	,-- 5 
			rsnumoper	,-- 6
			rscartera	,-- 7
			rstipoper	,-- 8
			rsinstser	,-- 9
			rsrutcli	,-- 10
			rscodcli	,-- 11
			rsvppresen	,-- 12
			rsvppresenx	,-- 13
			rscupamo	,-- 14
			rscupint	,-- 15
			rscuprea	,-- 16
			rsflujo		,-- 17
			rsfecprox	,-- 18
			rsfecctb	,-- 19
			rsnominal	,-- 20
			rstir		,-- 21
			rstasfloat	,-- 22
			rsmonpact	,-- 23
			rsmonemi	,-- 24
			rstasemi	,-- 25
			rsbasemi	,-- 26
			rscodigo	,-- 27
			rsinteres	,-- 28
			rsreajuste	,-- 29
			rsintermes	,-- 30
			rsreajumes	,-- 31
			rsinteres_acum	,-- 32
			rsreajuste_acum	,-- 33
			rsforpagv	,-- 34
			rsvalcomp	,-- 35
			rsvalcomu	,-- 36
			rsvalvenc	, -- 37
			rsdurat		,-- 38
			rsdurmod	,-- 39
			rsconvex	,-- 40
			rsnumucup	,-- 41
			rsnumpcup	,-- 42
			rsfecucup	,-- 43
			rsfecpcup	,-- 44
			rsvpcomp	,-- 45
			rstipopero	,-- 46
			rsfeccomp	,-- 47
			rsdifrea	,-- 48
			rsinstcam	,-- 49
			rsfecinip	,-- 50	 
			rsfecvtop	,-- 51	 
			rsvalvtop	,-- 52	 
			rsrutemis 	,-- 53	
			rsvalinip	,-- 54	
			rstaspact	,-- 55
			rsmascara	,-- 56
			rsfecemis	,-- 57
			rsfecvcto	,-- 58
                        rspvpcomp       ,-- 59                  
                        rsseriado       ,-- 60 
                        codigo_carterasuper, --61
                        premio          ,-- 62
                        descuento       ,-- 63
                        codigo_subproducto --64
			)
		SELECT
			@dFechoy	,-- 1 rsfecha,rsrutcart,rstipcart,rsnumdocu,rscorrela,rsnumoper,rscartera,rstipoper
			@nRutcart	,-- 2 
			@nTipcart	,-- 3
			@nNumdocu	,-- 4
			@nCorrela	,-- 5
			@nNumoper	,-- 6
			CASE WHEN @cartera = 'CP'  THEN '111'
                             WHEN @cartera = 'INT' THEN '114'
                             ELSE '' END,-- 7
			'VC'		,-- 8
			@cInstcam	,-- 9
			@nrutcli      	,-- 10
			@ncodcli	,-- 11
			@nVpresen	,-- 12 rsvppresen
			CASE WHEN @iCodigo =13 THEN ROUND((@nValcomp+@nInteres+@nReajuste+@nReadia+@nIntdia), CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					       ELSE ROUND((@nValcomp+@nInteres+@nReajuste+@nReadia+@nIntdia), CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					  END,-- 13 rsvppresenx
			CASE WHEN @iCodigo =13 THEN ROUND(@fAmocupo, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					       ELSE ROUND(@fAmocupo, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					  END,-- 14 rscupamo
			CASE WHEN @iCodigo =13 THEN ROUND(@nIntcup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
						ELSE ROUND(@nIntcup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					  END,-- 15 rscupint
			CASE WHEN @iCodigo =13 THEN ROUND(@nReacup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					       ELSE ROUND(@nReacup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					  END,-- 16 rscuprea
			CASE WHEN @iCodigo =13 THEN ROUND(@nPagcup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
						ELSE ROUND(@nPagcup, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
					  END,-- 17 rsflujo
			@dFecprox	,-- 18
			@dFechoy	,-- 19
			@fNominal	,-- 20
			@fTir	        ,-- 21
			@fTasaFloat	,-- 22 rstasfloat
			@iMonemi        ,-- 23 rsmonpact
			@iMonemi        ,-- 24 rsmonemi  
			@fTasemi	,-- 25 rstasemi
			@fBasemi	,-- 26 rsbasemi
			@iCodigo        ,-- 27
			CASE WHEN @iCodigo = 13 THEN ISNULL(ROUND(@nIntdia, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END),0)
						ELSE ISNULL(ROUND(@nIntdia, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END),0)
					   END,-- 28 rsinteres
			ROUND(@nReadia, CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END),-- 29 rsreajuste
			@nIntMes	,-- 30 rsintermes
			@nReaMes	,-- 31 rsreajumes
			@nInteres	,-- 32 rsinteres
			@nReajuste	,-- 33 rsreajuste
			0		,-- 34 rsforpagv
			@nValcomp	,-- 35
			@fValcomu	,-- 36

			CASE WHEN @iCodigo = 13 THEN ROUND(CASE WHEN  @iAst<>0     THEN 0.0
                                                                WHEN  @iCodigo=888 THEN @nValcomp+@nInteres+@nReajuste+@nReadia+@nIntdia
                                                                ELSE (((@fIntpcup + @fAmopcup)* @fNominal) / CONVERT(FLOAT,100)) END, @ndecimal)--CASE WHEN @ctipo_moneda_papel ="0" THEN @ndecimal ELSE 0 END)
						ELSE ROUND(CASE WHEN  @iAst<>0     THEN 0.0
                                                                WHEN  @iCodigo=888 THEN @nValcomp+@nInteres+@nReajuste+@nReadia+@nIntdia
                                                                ELSE (((@fIntpcup + @fAmopcup)* @fNominal) / CONVERT(FLOAT,100)) END,4)
					  END,-- 37 rsvalvenc

			@fDurat		,-- 38 rsdurat
			@fDurmo		,-- 39 rsdurmod
			@fConvx		,-- 40 rsconvex
			@nNumucup	,-- 41 rsnumucup
			@nNumpcup	,-- 42 rsnumpcup
			@dFecucup	,-- 43 rsfecucup
			@dFecpcup	,-- 44 rsfecpcup
			@fPvp		,-- 45 rsvpcomp
			CASE WHEN @cartera = 'CP' THEN @cartera ELSE (CASE WHEN @tipoper = 'VIX' THEN 'VI' ELSE @tipoper END) END,-- 46
			@dFeccomp	,-- 47
			@nDifReaCup	,-- 48 rsdifrea
			@cInstser	,-- 49 rsinstcam
			@FechaPacto	,-- 50
			''		,-- 51
			0.0		,-- 52
			0.0		,-- 53
			0.0		,-- 54
			0.0		,-- 55
			@cMascara	,-- 56
			@dFecemi	,-- 57
			@dFecven	,-- 58
                        @cppvpcomp      ,--cppvpcomp       ,-- 59 
			@cSeriado       ,-- 60
                        @carterasuper   ,-- 61
			@nPremio        ,-- 62
                        @nPremio        ,-- 63
                        CASE WHEN @cartera = 'CP' THEN @cartera ELSE (CASE WHEN @tipoper = 'VIX' THEN 'VI' ELSE @tipoper END) END

		IF @@ERROR<>0
		BEGIN
			SELECT	'NO','Problemas al Insertar Vencimiento CP al RESULTADO_DEVENGO'
			RETURN
		END

         END
    END
/***********************************************************************************************************************/
   

  END  --FIN DE OPCION DEVENGAR

 IF @EJECUCION = 'V' BEGIN

		UPDATE	RESULTADO_DEVENGO
		SET	rsrutemis	= nsrutemi
		FROM	NOSERIE, VIEW_INSTRUMENTO
		WHERE	rscodigo=incodigo 
                  AND inmdse='N' 
                  AND rsrutcart=nsrutcart 
                  AND rsnumdocu=nsnumdocu 
                  AND rscorrela=nscorrela
                  AND rsfecha = @dFechoy

		UPDATE	RESULTADO_DEVENGO
		SET	rsrutemis	= serutemi
		FROM	VIEW_INSTRUMENTO, VIEW_SERIE
		WHERE	rscodigo=incodigo 
                  AND inmdse='S' 
                  AND rsmascara=semascara
                  AND rsfecha = @dFechoy

/********************************************************************************************************
                CAMBIO PARA LOS REAJUSTES DE LOS BONOS DE RECONOCIMIENTO                                 
********************************************************************************************************/

--        SELECT  @dFecha_Mes_Actual = DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy)
--        SELECT	@fValmon_Man	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFecha_Mes_Actual),0)

--        IF @fValmon_Man <> 0

	  SELECT @dFecha_Mes_Actual = DATEADD(MONTH,-1,DATEADD(DAY,(DATEPART(day,@dFechoy)*-1)+1,@dFechoy))
  	  SELECT @fValmon_Man	= ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo=502 AND vmfecha=@dFecha_Mes_Actual),0)

	  IF @fValmon_Man <> 0 BEGIN

	    UPDATE VIEW_DATOS_GENERALES SET Estado_Reajuste = 'S'
	    WHERE  Estado_Reajuste = 'N'	

	  END

	  
	SET NOCOUNT OFF

 END --FIN DE OPCION VENCIMIENTOS



RETURN

END



GO
