USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_DATOS_RF_TIPO_CARTERA_2]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ADM_DATOS_RF_TIPO_CARTERA_2] 
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
     CREATE TABLE #MDCP
	 (cprutcart               NUMERIC
	 ,CPnumdocu               NUMERIC
	 ,CPcorrela               NUMERIC
	 ,cpcodigo                NUMERIC
	 ,codigo_carterasuper     VARCHAR(10)
	 ,cpseriado               VARCHAR(10)
	 ,cpmascara               VARCHAR(30))
	 




   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA SEGUN FECHA MDMO                                          */
   /*-----------------------------------------------------------------------------*/
     SET @QUERY = 'INSERT INTO #MDCP '
	 SET @QUERY = @QUERY + 'SELECT '
	 SET @QUERY = @QUERY + 'cprutcart' 
	 SET @QUERY = @QUERY + ',CPnumdocu'
	 SET @QUERY = @QUERY + ',CPcorrela'
	 SET @QUERY = @QUERY + ',cpcodigo'
	 SET @QUERY = @QUERY + ',codigo_carterasuper'
	 SET @QUERY = @QUERY + ',cpseriado'
	 SET @QUERY = @QUERY + ',cpmascara'
	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDCP' + SUBSTRING(CONVERT(CHAR(8),@FECHA,112),5,4)

	 EXEC (@QUERY)



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
	DECLARE @NA_TipoMovimiento	CHAR(01)
	      , @NA_TipoOperacion	CHAR(01)
		  , @NA_Tipo_Intrumento	CHAR(01) 
		  , @NA_Moneda		    CHAR(01)
		  , @NA_Tipo_Emisor		CHAR(01)
		  , @NA_Origen_Emisor	CHAR(01)
		  , @NA_Cubierto		CHAR(01)
		  , @NA_Contraparte		CHAR(01)
		  , @NA_Desde_Hasta		CHAR(01)
		  , @NA_SubCartera		CHAR(01)


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @Tipo_Instrumento	INTEGER
	        ,@Cartera_Super		CHAR(10)
			,@Tipo_Emisor		INTEGER
	        ,@Origen_Emisor		INTEGER
			,@Objeto_Cubierto	INTEGER
			,@Moneda			INTEGER
		    ,@Contraparte		NUMERIC(9)
		    ,@Desde			    INTEGER
	        ,@Hasta			    INTEGER
	        ,@SubCartera_Super	CHAR(10)


   /*-----------------------------------------------------------------------------*/
   /* ASIGNACIONES POR DEFECTO                                                    */
   /*-----------------------------------------------------------------------------*/
	 SELECT	@Tipo_Instrumento	= 0
	       ,@Moneda			    = 0
	       ,@Tipo_Emisor		= 0
	       ,@Origen_Emisor		= 0
	       ,@Objeto_Cubierto	= 0
	       ,@Contraparte		= 0
	       ,@Desde			    = 0
	       ,@Hasta			    = 0
	       ,@Cartera_Super		= ''
	       ,@SubCartera_Super	= ''


   /*-----------------------------------------------------------------------------*/
   /* SEGUN SISTEMA ENVIADO ESTE HARA                                             */
   /*-----------------------------------------------------------------------------*/
	IF @IdSistema	= 'BTR' BEGIN

       /*-------------------------------------------------------------------------*/
       /* ASIGNACION POR DEFECTO                                                  */
       /*-------------------------------------------------------------------------*/
	     SELECT @NA_TipoMovimiento = 'F'
		      , @NA_TipoOperacion  = 'F'
		      , @NA_Moneda		   = 'V'
		      , @NA_Desde_Hasta	   = 'V'
		      , @NA_SubCartera	   = 'V'
		      , @NA_Contraparte	   = 'V'
		      , @NA_Cubierto	   = CASE WHEN @Tipo_movimiento <> 'TMF' THEN 'V' ELSE 'F' END

       /*-------------------------------------------------------------------------*/
       /* SE EXTRAEN REGISTROS SIEMPRE DE LA VALORIZACION                         */
       /*-------------------------------------------------------------------------*/
		 --SELECT	DISTINCT 
			--	    @Tipo_Instrumento	= rscodigo
			--      , @Cartera_Super		= codigo_carterasuper
			--      , @Tipo_Emisor		= CASE WHEN emtipo NOT IN (1,2) THEN 0 ELSE emtipo END 
			--      ,	@Origen_Emisor		= (CASE WHEN emrut = '97023000' THEN 1 
			--		                			ELSE (CASE WHEN emtipo <> 2 THEN 0 
			--						                  ELSE emtipo END) 
			--					           END )
			--      , @Objeto_Cubierto	= ISNULL(CASE	WHEN @EstadoCobertura = 'CBTO'  THEN 1  
			--						             WHEN @EstadoCobertura = 'DCBTO' THEN 2 END,0)
 		--	  FROM BACTRADERSUDA..MDRS
			--     , BACPARAMSUDA..EMISOR
			--     , #MDAC
			-- WHERE rsfecha		= acfecproc 
			--   AND rsnumdocu	= @NumDocu
			--   AND rscorrela	= @NumCorrela
			--   AND emrut		= rsrutemis
			--   AND rstipoper	= 'DEV'	

       /*-------------------------------------------------------------------------*/
       /* SE EXTRAEN REGISTROS SIEMPRE DE LA VALORIZACION                         */
       /*-------------------------------------------------------------------------*/
         SELECT DISTINCT
		        @Tipo_Instrumento = CP.cpcodigo
               ,@Cartera_Super    = CP.codigo_carterasuper
	           ,@Tipo_Emisor      = CASE WHEN EMI.emtipo NOT IN (1,2) THEN 0 ELSE EMI.emtipo END 
	           ,@Origen_Emisor    = (CASE WHEN EMI.emrut = '97023000' THEN 1 
			                         ELSE (CASE WHEN EMI.emtipo <> 2 THEN 0 ELSE EMI.emtipo END) 
		                             END) 
              ,@Objeto_Cubierto	  = ISNULL(CASE	WHEN @EstadoCobertura = 'CBTO'  THEN 1  
				 				                WHEN @EstadoCobertura = 'DCBTO' THEN 2 END,0)
           FROM (SELECT CAR.CPnumdocu
                       ,CAR.CPcorrela
                       ,CAR.cpcodigo
                       ,CAR.codigo_carterasuper
		               ,CASE WHEN cpseriado = 'S' THEN (SELECT serutemi 
		                                                  FROM bactradersuda.dbo.VIEW_SERIE    WITH(NOLOCK) 
					        				             WHERE semascara = CAR.cpmascara )
			                ELSE (SELECT nsrutemi 
				                    FROM bactradersuda.dbo.VIEW_NOSERIE  WITH(NOLOCK) 
				                   WHERE nsrutcart = cprutcart 
					                 AND nsnumdocu = cpnumdocu 
					                 AND nscorrela = cpcorrela) 
		                END AS RUT_EMISOR
                   FROM #MDCP CAR
                  WHERE cpnumdocu	= @NumDocu
	                AND cpcorrela	= @NumCorrela) CP
          INNER JOIN
                BACPARAMSUDA..EMISOR  EMI
	         ON EMI.emrut   = CP.RUT_EMISOR

       /*-------------------------------------------------------------------------*/
       /* DEFINICION POR TIPO DE INSTRUMENTO                                      */
       /*-------------------------------------------------------------------------*/
		 IF @Tipo_Instrumento = 15 BEGIN 
--		
			SELECT @NA_Tipo_Intrumento	= 'F'
			      ,@NA_Tipo_Emisor		= 'F'
			      ,@NA_Origen_Emisor	= 'V'

		 END
		 ELSE IF @Tipo_Instrumento = 20 BEGIN

			SELECT @NA_Tipo_Intrumento	= 'F'
			     , @NA_Tipo_Emisor		= 'V'
			     , @NA_Origen_Emisor	= 'F'
		END
		ELSE BEGIN

			SELECT @NA_Tipo_Intrumento	= 'F'
			     , @NA_Tipo_Emisor		= 'F'
			     , @NA_Origen_Emisor	= 'V'
		END


		SELECT	@Tipo_Instrumento	= CASE WHEN @Tipo_Instrumento <> 15 THEN 0 
							          ELSE 15 
									  END


	END
	ELSE BEGIN
	  

       /*-------------------------------------------------------------------------*/
       /* SI ES BONEX                                                             */
       /*-------------------------------------------------------------------------*/
	     IF @IdSistema = 'BEX' BEGIN

		    SELECT @NA_TipoMovimiento	= 'F'
		          ,@NA_TipoOperacion	= 'F'
		          ,@NA_Tipo_Emisor		= 'F'
		          ,@NA_Cubierto		    = CASE WHEN @Tipo_movimiento <> 'TMF' THEN 'V' ELSE 'F' END
		          ,@NA_Moneda		    = 'V'
		          ,@NA_Desde_Hasta		= 'V'
		          ,@NA_SubCartera		= 'V'
		          ,@NA_Contraparte		= 'V'
		          ,@NA_Tipo_Intrumento	= 'V'
		          ,@NA_Origen_Emisor	= 'V'


		    SELECT @Cartera_Super	= A.codigo_carterasuper
		          ,@Tipo_Emisor		= emtipo
		          ,@Objeto_Cubierto	= ISNULL(CASE WHEN @EstadoCobertura = 'CBTO'  THEN 1  
							                 WHEN @EstadoCobertura = 'DCBTO' THEN 2 
                                             END,0)
 		      FROM BACBONOSEXTSUDA..TEXT_CTR_INV	A
		          ,BACPARAMSUDA..EMISOR		
             WHERE cpnumdocu	  = CASE WHEN @Tipo_Operacion   = 'VCP' THEN @NumOpe ELSE @NumDocu    END
		       AND cpcorrelativo  = CASE WHEN @Tipo_movimiento <> 'VP'  THEN 1       ELSE @NumCorrela END
		       AND emcodigo	      = cpcodemi
		       AND emrut		  = cprutemi


		 END
       /*-------------------------------------------------------------------------*/
       /* SI ES BONEX                                                             */
       /*-------------------------------------------------------------------------*/
	     IF @IdSistema = 'BNY' BEGIN


            SELECT @NA_TipoMovimiento	= 'F'
		          ,@NA_TipoOperacion	= 'F'
		          ,@NA_Tipo_Emisor		= 'F'
		          ,@NA_Cubierto		    = CASE WHEN @Tipo_movimiento <> 'TMF' THEN 'V' ELSE 'F' END
		          ,@NA_Moneda		    = 'V'
		          ,@NA_Desde_Hasta		= 'V'
		          ,@NA_SubCartera		= 'V'
		          ,@NA_Contraparte		= 'V'
		          ,@NA_Tipo_Intrumento	= 'V'
		          ,@NA_Origen_Emisor	= 'F'


		    SELECT @Cartera_Super		= A.codigo_carterasuper
		          ,@Tipo_Emisor		    = emtipo
		          ,@Origen_Emisor       = CASE WHEN CLPAIS = 225 THEN 1 
									           WHEN	CLPAIS = 6   THEN 3
								          ELSE 2 END  
		          ,@Objeto_Cubierto	    = 0 
 		     FROM BACBONOSEXTNY..TEXT_CTR_INV	A
		         ,BACPARAMSUDA..EMISOR		
		         ,BACPARAMSUDA..CLIENTE
             WHERE cpnumdocu	  = CASE WHEN @Tipo_Operacion   = 'VCP' THEN @NumOpe ELSE @NumDocu    END
		       AND cpcorrelativo  = CASE WHEN @Tipo_movimiento <> 'VP'  THEN 1       ELSE @NumCorrela END
		       AND emcodigo	      = cpcodemi
		       AND emrut		  = cprutemi
		       AND emcodigo       = Clcodigo
		       AND emrut		  = Clrut



		 END



	END





   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE VALORES                                                           */
   /*-----------------------------------------------------------------------------*/
	 DECLARE @CodClas	CHAR(10)
	
	 SELECT	TOP 1 @CodClas	= CodigoCartera
	   FROM	BACPARAMSUDA..TBL_CLASIFICACION_CARTERA_INSTRUMENTO
	  WHERE	id_Sistema		= @IdSistema	
	    AND	(@NA_TipoMovimiento	    = 'V'	OR Tipo_movimiento	 = @Tipo_movimiento	)
	    AND	(@NA_TipoOperacion	    = 'V'	OR Tipo_operacion	 = @Tipo_Operacion	)
	    AND	(@NA_Tipo_Intrumento	= 'V'	OR TipoInstrumento	 = @Tipo_Instrumento	)
	    AND	(@NA_Moneda		        = 'V'	OR Moneda		     = @Moneda		)
	    AND	(@NA_Tipo_Emisor	    = 'V'	OR TipoEmisor		 = @Tipo_Emisor		)
	    AND	(@NA_Origen_Emisor	    = 'V'	OR OrigenEmision	 = @Origen_Emisor	)
	    AND	(@NA_Cubierto		    = 'V'	OR ObjetoCubierto	 = @Objeto_Cubierto	)
	    AND	(@NA_Contraparte	    = 'V'	OR Contraparte		 = @Contraparte		)
	    AND	(@NA_Desde_Hasta	    = 'V'	OR (Desde		    >= @Desde	AND Hasta	<= @Hasta ))
	    AND	 CarteraNormativa	    = @Cartera_Super
	    AND	(@NA_SubCartera		    = 'V'	OR SubcarteraNormativa	= @SubCartera_Super	)




	SET NOCOUNT OFF
	RETURN ISNULL(@CodClas,0)




END
GO
