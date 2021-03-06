USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_DATOS_RF_TIPO_CARTERA]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ADM_DATOS_RF_TIPO_CARTERA] 
                        @IdSistema		    CHAR(03) 
                     ,  @Tipo_movimiento	CHAR(05)	= ''
					 ,	@Tipo_Operacion		CHAR(05)	= ''
					 ,	@NumOpe			    NUMERIC(10,0)	= 0
					 ,	@NumDocu		    NUMERIC(10,0)	= 0
					 ,	@NumCorrela		    NUMERIC(03,0)	= 0
					 ,  @FECHA              DATETIME
					 ,	@EstadoCobertura	CHAR(5)		= 'DCBTO'



AS    
BEGIN    


    
	SET NOCOUNT ON   

	 
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS      : TIPO DE CARTERA                                            */
   /* AUTOR          : ROBERTO MORA DROGUETT                                      */
   /* FECHA CREACION : 04/03/2016                                                 */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
    
	 
	 
   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
	 DECLARE @QUERY             VARCHAR(MAX)
	        

   /*-----------------------------------------------------------------------------*/
   /* MDCA TEMPORAL PARA CALCULOS                                                 */
   /*-----------------------------------------------------------------------------*/
     CREATE TABLE #MDAC
	 (acfecproc               DATETIME)

	 
   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA SEGUN FECHA MDCP                                          */
   /*-----------------------------------------------------------------------------*/
     SET @QUERY = 'INSERT INTO #MDAC '
	 SET @QUERY = @QUERY + 'SELECT '
	 SET @QUERY = @QUERY + ' acfecproc'
	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDAC' + SUBSTRING(CONVERT(CHAR(8),@FECHA,112),5,4)


	 EXEC (@QUERY)    


 /*-----------------------------------------------------------------------------*/
   /* CREACION DE ESTRUCTURA DE TABLA DINAMICA                                    */
   /*-----------------------------------------------------------------------------*/
     CREATE TABLE #MDDI
	 (dirutcart               NUMERIC
	 ,dinumdocu               NUMERIC
	 ,dicorrela               NUMERIC
	 ,dinumdocuo              NUMERIC
	 ,dicorrelao              NUMERIC
	 ,digenemi                VARCHAR(20)
	 ,diserie                 VARCHAR(20)
	 ,codigo_carterasuper     VARCHAR(10))


   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA SEGUN FECHA MDCP                                          */
   /*-----------------------------------------------------------------------------*/
     SET @QUERY = 'INSERT INTO #MDDI '
	 SET @QUERY = @QUERY + 'SELECT '
	 SET @QUERY = @QUERY + 'dirutcart' 
	 SET @QUERY = @QUERY + ',dinumdocu'
	 SET @QUERY = @QUERY + ',dicorrela'
	 SET @QUERY = @QUERY + ',dinumdocuo'
	 SET @QUERY = @QUERY + ',dicorrelao'
	 SET @QUERY = @QUERY + ',digenemi'
	 SET @QUERY = @QUERY + ',diserie'
	 SET @QUERY = @QUERY + ',codigo_carterasuper'
	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDDI' + SUBSTRING(CONVERT(CHAR(8),@FECHA,112),5,4)

	 EXEC (@QUERY)


 /*-----------------------------------------------------------------------------*/
   /* CREACION DE ESTRUCTURA DE TABLA DINAMICA                                    */
   /*-----------------------------------------------------------------------------*/
     CREATE TABLE #MDMO
	 (monumdocu               NUMERIC
	 ,monumoper               NUMERIC
	 ,mocorrela               NUMERIC
	 ,mocodigo                NUMERIC
	 ,codigo_carterasuper     VARCHAR(10)
	 ,morutemi                NUMERIC)




   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA SEGUN FECHA MDMO                                          */
   /*-----------------------------------------------------------------------------*/
     SET @QUERY = 'INSERT INTO #MDMO '
	 SET @QUERY = @QUERY + 'SELECT '
	 SET @QUERY = @QUERY + 'monumdocu' 
	 SET @QUERY = @QUERY + ',monumoper'
	 SET @QUERY = @QUERY + ',mocorrela'
	 SET @QUERY = @QUERY + ',mocodigo'
	 SET @QUERY = @QUERY + ',codigo_carterasuper'
	 SET @QUERY = @QUERY + ',morutemi'
	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDMO' + SUBSTRING(CONVERT(CHAR(8),@FECHA,112),5,4)

	 EXEC (@QUERY)





	DECLARE	@Tipo_Instrumento	INTEGER
	,	@Moneda			INTEGER
	,	@Tipo_Emisor		INTEGER
	,	@Origen_Emisor		INTEGER
	,	@Objeto_Cubierto	INTEGER
	,	@Contraparte		NUMERIC(9)
	,	@Desde			INTEGER
	,	@Hasta			INTEGER
	,	@Cartera_Super		CHAR(10)
	,	@SubCartera_Super	CHAR(10)
	,	@Sw                	CHAR(01)

	DECLARE @NA_Tipo_Intrumento	CHAR(01) 
	,	@NA_Tipo_Emisor		CHAR(01)
	,	@NA_Origen_Emisor	CHAR(01)
	,	@NA_Cubierto		CHAR(01)
	,	@NA_Contraparte		CHAR(01)
	,	@NA_Moneda		CHAR(01)
	,	@NA_Desde_Hasta		CHAR(01)
	,	@NA_SubCartera		CHAR(01)
	,	@NA_TipoMovimiento	CHAR(01)
	,	@NA_TipoOperacion	CHAR(01)

	SELECT	@Tipo_Instrumento	= 0
	,	@Moneda			= 0
	,	@Tipo_Emisor		= 0
	,	@Origen_Emisor		= 0
	,	@Objeto_Cubierto	= 0
	,	@Contraparte		= 0
	,	@Desde			= 0
	,	@Hasta			= 0
	,	@Cartera_Super		= ''
	,	@SubCartera_Super	= ''

	IF @IdSistema	= 'BTR' 
        BEGIN

		SELECT	@NA_TipoMovimiento	= 'F'
		,	@NA_TipoOperacion	= 'F'
		,	@NA_Moneda		= 'V'
		,	@NA_Desde_Hasta		= 'V'
		,	@NA_SubCartera		= 'V'
		,	@NA_Contraparte		= 'V'
		,	@NA_Cubierto		= CASE WHEN @Tipo_movimiento <> 'TMF' THEN 'V' ELSE 'F' END


		IF NOT EXISTS(SELECT 1 FROM BACTRADERSUDA..MDRS , #MDAC
							WHERE	rsfecha		= acfecproc
							AND	rsnumdocu	= @NumDocu
							AND	rscorrela	= @NumCorrela
							AND	rsnumoper	= @NumOpe
--							AND	rsfecvcto	= acfecproc
							AND	rstipoper	= 'DEV'		) BEGIN

                        SELECT @Sw = 0
			SELECT	DISTINCT 
                                @Sw                     = 1
			,	@Tipo_Instrumento	= incodigo
			,	@Cartera_Super		= codigo_carterasuper
			,	@Tipo_Emisor		= CASE WHEN emtipo NOT IN (1,2) THEN 0 ELSE emtipo END 
			,	@Origen_Emisor		= (CASE WHEN emrut = '97023000' THEN 1 
								ELSE (CASE	WHEN emtipo <> 2 THEN 0 
										ELSE emtipo END) 
								END )
			,	@Objeto_Cubierto	= ISNULL(CASE	WHEN @EstadoCobertura = 'CBTO'  THEN 1  
									WHEN @EstadoCobertura = 'DCBTO' THEN 2 END,0)
 			FROM	#MDDI
			,	BACPARAMSUDA..EMISOR
			,	BACPARAMSUDA..INSTRUMENTO			
                         WHERE	dinumdocu	= @NumDocu
			AND	dicorrela	= @NumCorrela
			AND	dinumdocuo	= @NumDocu
			AND	dicorrelao	= @NumCorrela
			AND	emgeneric	= digenemi
			AND	inserie		= diserie

                        IF  @Sw =0  
                        BEGIN
                            
    	        		SELECT	DISTINCT 
		    	        	@Tipo_Instrumento	= incodigo
     			        ,	@Cartera_Super		= codigo_carterasuper
	        		,	@Tipo_Emisor		= CASE WHEN emtipo NOT IN (1,2) THEN 0 ELSE emtipo END 
		        	,	@Origen_Emisor		= (CASE WHEN emrut = '97023000' THEN 1 
			        	       				ELSE (CASE	WHEN emtipo <> 2 THEN 0 
						        				ELSE emtipo END) 
				        				END )
        			,	@Objeto_Cubierto	= ISNULL(CASE	WHEN @EstadoCobertura = 'CBTO'  THEN 1  
									WHEN @EstadoCobertura = 'DCBTO' THEN 2 END,0)
 	        		FROM	#MDMO
		        	,	BACPARAMSUDA..EMISOR
               			,	BACPARAMSUDA..INSTRUMENTO
	        		WHERE	monumoper	= @NumOpe
                                AND     monumdocu	= @NumDocu
		        	AND	mocorrela	= @NumCorrela
		        	AND	emrut    	= morutemi
                                AND	incodigo	= mocodigo

                        END
                        
		END
		ELSE BEGIN 	-- LOS PAPELES VENCIDOS HOY NO SE ENCUENTRAN EN LA MDDI 
				-- POR LO CUAL SE VA A BUSCAR EL DEVENGO DE AYER

			SELECT	DISTINCT 
				@Tipo_Instrumento	= rscodigo
			,	@Cartera_Super		= codigo_carterasuper
			,	@Tipo_Emisor		= CASE WHEN emtipo NOT IN (1,2) THEN 0 ELSE emtipo END 
			,	@Origen_Emisor		= (CASE WHEN emrut = '97023000' THEN 1 
								ELSE (CASE	WHEN emtipo <> 2 THEN 0 
										ELSE emtipo END) 
								END )
			,	@Objeto_Cubierto	= ISNULL(CASE	WHEN @EstadoCobertura = 'CBTO'  THEN 1  
									WHEN @EstadoCobertura = 'DCBTO' THEN 2 END,0)
 			FROM	BACTRADERSUDA..MDRS
			,	BACPARAMSUDA..EMISOR
			,	#MDAC
			WHERE	rsfecha		= acfecproc 
			AND	rsnumdocu	= @NumDocu
			AND	rscorrela	= @NumCorrela
			AND	rsnumoper	= @NumOpe
			AND	emrut		= rsrutemis
			AND	rstipoper	= 'DEV'	
		END

		IF @Tipo_Instrumento = 15 BEGIN -- BONO ////// LA VARIABLE @Tipo_Instrumento SE REUTILIZA MAS ABAJO
--			PRINT 'BONO'
			SELECT	@NA_Tipo_Intrumento	= 'F'
			,	@NA_Tipo_Emisor		= 'F'
			,	@NA_Origen_Emisor	= 'V'

		END
		ELSE IF @Tipo_Instrumento = 20 BEGIN -- LETRA
--			PRINT 'LETRA'
			SELECT	@NA_Tipo_Intrumento	= 'F'
			,	@NA_Tipo_Emisor		= 'V'
			,	@NA_Origen_Emisor	= 'F'
		END
		ELSE BEGIN
--			PRINT 'NI BONO NI LETRA'
			SELECT	@NA_Tipo_Intrumento	= 'F'
			,	@NA_Tipo_Emisor		= 'F'
			,	@NA_Origen_Emisor	= 'V'
		END

		SELECT	@Tipo_Instrumento	= CASE	WHEN @Tipo_Instrumento <> 15 THEN 0 
							ELSE 15 END
	END ELSE 

        IF @IdSistema = 'BEX' 
        BEGIN

		SELECT	@NA_TipoMovimiento	= 'F'
		,	@NA_TipoOperacion	= 'F'
		,	@NA_Tipo_Emisor		= 'F'
		,	@NA_Cubierto		= CASE WHEN @Tipo_movimiento <> 'TMF' THEN 'V' ELSE 'F' END
		,	@NA_Moneda		= 'V'
		,	@NA_Desde_Hasta		= 'V'
		,	@NA_SubCartera		= 'V'
		,	@NA_Contraparte		= 'V'
		,	@NA_Tipo_Intrumento	= 'V'
		,	@NA_Origen_Emisor	= 'V'

		SELECT  @Cartera_Super		= A.codigo_carterasuper
		,	@Tipo_Emisor		= emtipo
		,	@Objeto_Cubierto	= ISNULL(CASE WHEN @EstadoCobertura = 'CBTO'  THEN 1  
							      WHEN @EstadoCobertura = 'DCBTO' THEN 2 
                                                         END,0)
 		FROM	BACBONOSEXTSUDA..TEXT_CTR_INV	A
		,	BACPARAMSUDA..EMISOR		
        WHERE	cpnumdocu	= CASE WHEN @Tipo_Operacion   = 'VCP' THEN @NumOpe ELSE @NumDocu    END
		AND	cpcorrelativo	= CASE WHEN @Tipo_movimiento <> 'VP'  THEN 1       ELSE @NumCorrela END
		AND	emcodigo	= cpcodemi
		AND	emrut		= cprutemi
	END

	    IF @IdSistema = 'BNY' 
        BEGIN

		SELECT	@NA_TipoMovimiento	= 'F'
		,	@NA_TipoOperacion	= 'F'
		,	@NA_Tipo_Emisor		= 'F'
		,	@NA_Cubierto		= CASE WHEN @Tipo_movimiento <> 'TMF' THEN 'V' ELSE 'F' END
		,	@NA_Moneda		= 'V'
		,	@NA_Desde_Hasta		= 'V'
		,	@NA_SubCartera		= 'V'
		,	@NA_Contraparte		= 'V'
		,	@NA_Tipo_Intrumento	= 'V'
		,	@NA_Origen_Emisor	= 'F'

		SELECT  @Cartera_Super		= A.codigo_carterasuper
		,	@Tipo_Emisor		= emtipo
		,   @Origen_Emisor      = CASE WHEN CLPAIS = 225 THEN 1 
									   WHEN	CLPAIS = 6   THEN 3
								  ELSE 2 END  
		,	@Objeto_Cubierto	= 0 /*CASE WHEN codigo_carterasuper = 'A'THEN 0 ELSE 
		                            ISNULL(CASE WHEN @EstadoCobertura = 'CBTO'  THEN 1  
							      WHEN @EstadoCobertura = 'DCBTO' THEN 2 
                                                         END,0)
                                    end*/
		    /*ISNULL(CASE WHEN @EstadoCobertura = 'CBTO'  THEN 1  
			WHEN @EstadoCobertura = 'DCBTO' THEN 2 
            END,0)*/
 		FROM	BACBONOSEXTNY..TEXT_CTR_INV	A
		,	BACPARAMSUDA..EMISOR		
		,	BACPARAMSUDA..CLIENTE
        WHERE cpnumdocu	= CASE WHEN @Tipo_Operacion   = 'VCP' THEN @NumOpe ELSE @NumDocu    END
		AND	cpcorrelativo	= CASE WHEN @Tipo_movimiento <> 'VP'  THEN 1       ELSE @NumCorrela END
		AND	emcodigo	= cpcodemi
		AND	emrut		= cprutemi
		AND emcodigo    = Clcodigo
		AND emrut		= Clrut
	END

	DECLARE @CodClas	CHAR(10)
	
	SELECT	TOP 1 @CodClas	= CodigoCartera
	FROM	BACPARAMSUDA..TBL_CLASIFICACION_CARTERA_INSTRUMENTO
	WHERE	id_Sistema		= @IdSistema	
	AND	(@NA_TipoMovimiento	= 'V'	OR Tipo_movimiento	 = @Tipo_movimiento	)
	AND	(@NA_TipoOperacion	= 'V'	OR Tipo_operacion	 = @Tipo_Operacion	)
	AND	(@NA_Tipo_Intrumento	= 'V'	OR TipoInstrumento	 = @Tipo_Instrumento	)
	AND	(@NA_Moneda		= 'V'	OR Moneda		 = @Moneda		)
	AND	(@NA_Tipo_Emisor	= 'V'	OR TipoEmisor		 = @Tipo_Emisor		)
	AND	(@NA_Origen_Emisor	= 'V'	OR OrigenEmision	 = @Origen_Emisor	)
	AND	(@NA_Cubierto		= 'V'	OR ObjetoCubierto	 = @Objeto_Cubierto	)
	AND	(@NA_Contraparte	= 'V'	OR Contraparte		 = @Contraparte		)
	AND	(@NA_Desde_Hasta	= 'V'	OR (Desde		>= @Desde	AND Hasta	<= @Hasta ))
	AND	 CarteraNormativa	= @Cartera_Super
	AND	(@NA_SubCartera		= 'V'	OR SubcarteraNormativa	 = @SubCartera_Super	)


	SET NOCOUNT OFF
	RETURN ISNULL(@CodClas,0)




END
GO
