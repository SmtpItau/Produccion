USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENVIA_VALORES_ARTICULO_84]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*
EXEC SP_ENVIA_VALORES_ARTICULO_84 6000,20,'BFW','USD',1,97080000,0
*/


CREATE PROCEDURE [dbo].[SP_ENVIA_VALORES_ARTICULO_84]
(   
	@ID_TICKET          INT
,	@MONTO              DECIMAL
,   @PLAZO              INT
,   @SISTEMA            VARCHAR(6)
,   @COD_MONEDA         VARCHAR(4)
,   @CODIGOPRODUCTO     VARCHAR(20)
,   @RUT_CLIENTE        DECIMAL(10,0)
,   @CODIGO_CLIENTE     INT
,   @MTM                DECIMAL
)


AS
BEGIN

SET NOCOUNT ON



   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CALCULO DE ADDON ARTICULO 84                                */
   /* AUTOR         : PABLO MONCADA AGUILERA                                      */
   /* FECHA CRACION : 06/11/2014                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/

   /*-----------------------------------------------------------------------------*/
   /* DECLARACIONES DE VARIABLES                                                  */
   /*-----------------------------------------------------------------------------*/
     DECLARE @FECHADEPROCESO       DATETIME
            ,@TIPO_DE_CAMBIO_USD   NUMERIC (10,4)
			,@TIPO_DE_CAMBIO_MON   NUMERIC (10,4)
	        ,@MONTO_SALIDA         NUMERIC
	        ,@CLASIFICACION_MONEDA VARCHAR(3)
			,@COMP_BILATERAL       CHAR(01)
	        ,@CANASTA1             NUMERIC(8,4)	
			,@CANASTA2             NUMERIC(8,4)	
			,@RIESGO_NORMATIVO     INT
			,@INT_COD_MONEDA       INT
			,@MENSAJE              CHAR(200)
			,@MONTO_AFECTO         DECIMAL

	 SET @MONTO_SALIDA   = 0

   /*-----------------------------------------------------------------------------*/
   /* DEPENDIENDO DE EL SISTEMA SE SACARA LA FECHA DE PROCESO                     */
   /*-----------------------------------------------------------------------------*/
     SET @FECHADEPROCESO = (SELECT acfecante FROM BacTraderSuda.dbo.VIEW_MFAC)


   /*-----------------------------------------------------------------------------*/
   /* EXTRAER CODIGO DE MONEDA SEGUN STRING ENVIADO                               */
   /*-----------------------------------------------------------------------------*/
     SET @INT_COD_MONEDA = 0
     SET @INT_COD_MONEDA =(SELECT mncodmon FROM MONEDA WITH(NOLOCK) WHERE mnnemo = @COD_MONEDA)

	  IF @INT_COD_MONEDA = 0 OR @INT_COD_MONEDA IS NULL BEGIN
	     SET @MENSAJE = 'CODIGO DE MONEDA: ' + @COD_MONEDA + ' NO EXISTE'
	     RAISERROR(@MENSAJE,16,1)
	  END

   /*-----------------------------------------------------------------------------*/
   /* DOLAR CONTABLE                                                              */
   /*-----------------------------------------------------------------------------*/
     SET @TIPO_DE_CAMBIO_USD = (SELECT vmc.Tipo_Cambio 
	                              FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vmc WITH(NOLOCK)
								 WHERE vmc.Fecha         = @FECHADEPROCESO 
								   AND vmc.Codigo_Moneda = 994)


   /*-----------------------------------------------------------------------------*/
   /* TIPO DE CAMBIO POR MONEDA                                                   */
   /*-----------------------------------------------------------------------------*/
    SET @TIPO_DE_CAMBIO_MON = (SELECT vmvalor 
	                             FROM BacParamSuda.dbo.VALOR_MONEDA VM WITH(NOLOCK)
								     ,Bacfwdsuda.dbo.MFAC           V  WITH(NOLOCK)
                                WHERE VM.vmfecha = V.acfecante 
								  AND VM.vmcodigo = @INT_COD_MONEDA)


    IF @INT_COD_MONEDA = 13 BEGIN
	   SET @TIPO_DE_CAMBIO_MON = @TIPO_DE_CAMBIO_USD
	END
	IF @INT_COD_MONEDA = 999 BEGIN
	   SET @TIPO_DE_CAMBIO_MON = 1
	END

   /*-----------------------------------------------------------------------------*/
   /* EL CLIENTE TIENE COMPENSACION BILATERAL                                     */
   /*-----------------------------------------------------------------------------*/
     IF EXISTS(SELECT 1 
	             FROM BacParamSuda.dbo.CLIENTE WITH(NOLOCK)
			    WHERE Clrut           = @RUT_CLIENTE 
				  AND Clcodigo        = @CODIGO_CLIENTE 
				  AND ClCompBilateral = 'S')BEGIN

        SET @COMP_BILATERAL ='S'
     END
	 ELSE BEGIN
	    SET @COMP_BILATERAL ='N'
	 END







   /*=============================================================================*/
   /*-----------------------------------------------------------------------------*/
   /* SI ES FORWARD                                                               */
   /*-----------------------------------------------------------------------------*/
   /*=============================================================================*/    
     IF @SISTEMA ='BFW' BEGIN



       /*-----------------------------------------------------------------*/
	   /* CALCULAR TIPO DE RIESGO POR PRODUCTO FORWARD                    */
	   /*-----------------------------------------------------------------*/
	     SET @RIESGO_NORMATIVO = 0
		 SET @MONTO_SALIDA     = 0
         SET @RIESGO_NORMATIVO = (SELECT RIESGO_NORMATIVO 
		                            FROM BacParamSuda.dbo.PRODUCTO WITH(NOLOCK)
								   WHERE ID_SISTEMA      = 'BFW'
								     AND codigo_producto = @CODIGOPRODUCTO
								     AND ESTADO          = 1)


         IF @RIESGO_NORMATIVO = 0 OR @RIESGO_NORMATIVO IS NULL BEGIN
		    SET @MONTO_SALIDA = 0
			GOTO SALIR
		 END


       /*-----------------------------------------------------------------*/ 
       /*-----------------------------------------------------------------*/
	   /* RIESGO NORMATIVO 1 FORWARD DE TASAS DE INTERES                  */
	   /*-----------------------------------------------------------------*/
	   /*-----------------------------------------------------------------*/
	     SET @MONTO_SALIDA = 0
		 SET @CANASTA1     = 0

         IF @RIESGO_NORMATIVO = 1 BEGIN


		    SET @CANASTA1 = ISNULL((SELECT Factor1 
			                          FROM BacParamSuda.dbo.MATRIZ_RIESGO_NORMATIVO WITH(NOLOCK)
			  	   	                 WHERE @PLAZO BETWEEN Plazo_Desde AND Plazo_Hasta 
							           AND Codigo_Riesgo = 1),0)
            SET @MONTO_SALIDA = 0
            SET @MONTO_SALIDA = ROUND((@MONTO * (@CANASTA1/100.0)) * @TIPO_DE_CAMBIO_MON,0)




		 END


       /*-----------------------------------------------------------------*/ 
       /*-----------------------------------------------------------------*/
	   /* FIN RIESGO NORMATIVO 1                                          */
	   /*-----------------------------------------------------------------*/
	   /*-----------------------------------------------------------------*/




       /*-----------------------------------------------------------------*/ 
       /*-----------------------------------------------------------------*/
	   /* RIESGO NORMATIVO 2 FORWARD DE MONEDAS                           */
	   /*-----------------------------------------------------------------*/
	   /*-----------------------------------------------------------------*/
         IF @RIESGO_NORMATIVO = 2 BEGIN

            /*------------------------------------------------------------*/
            /*EN ESTA SECCION SE CLASIFICARAN LAS MONEDAS DE ACUERDO AL   */
	        /*RIESGO DEL PAIS QUE CORRESPONDA                             */
            /*------------------------------------------------------------*/
              SET @CLASIFICACION_MONEDA = (SELECT mnClasificaRiesgoPais 
		                                     FROM BacParamSuda.dbo.moneda WITH(NOLOCK)
					    				    WHERE mncodmon             = @INT_COD_MONEDA
									          AND mnClasificaRiesgoPais <> '')


            /*------------------------------------------------------------*/
	        /* DEFINICION DEL FACTOR CORRESPONDIENTE SEGUN LA CANASTA AL  */
	        /* QUE PERTENEZCA LA MONEDA INDICADA                          */
            /*------------------------------------------------------------*/
			  SET @CANASTA1 = 0
			  SET @CANASTA2 = 0

              IF(@CLASIFICACION_MONEDA = 'AAA') BEGIN
	             SET @CANASTA1 = ISNULL((SELECT Factor1 
			                               FROM BacParamSuda.dbo.MATRIZ_RIESGO_NORMATIVO WITH(NOLOCK)
						   	              WHERE @PLAZO BETWEEN Plazo_Desde AND Plazo_Hasta 
							                AND Codigo_Riesgo = 2),0)
	          END
	          ELSE BEGIN
	            SET @CANASTA2 = ISNULL((SELECT factor2 
				                          FROM BacParamSuda.dbo.MATRIZ_RIESGO_NORMATIVO WITH(NOLOCK)
			                             WHERE @PLAZO BETWEEN Plazo_Desde AND Plazo_Hasta 
							               AND Codigo_Riesgo = 2),0)
              END
		


            /*------------------------------------------------------------*/
			/* DEPENDIENDO DE LA CLASIFICACION ESTE CALCULARA             */
            /*------------------------------------------------------------*/
			  SET @MONTO_SALIDA = 0
 	          IF (@CLASIFICACION_MONEDA = 'AAA') BEGIN
			     SET @MONTO_SALIDA = 0
		         SET @MONTO_SALIDA = ROUND((@MONTO * (@CANASTA1/100.0)) * @TIPO_DE_CAMBIO_MON,0)
		      END
		      ELSE BEGIN
			     SET @MONTO_SALIDA = 0
		         SET @MONTO_SALIDA = ROUND((@MONTO * (@CANASTA2/100.0)) * @TIPO_DE_CAMBIO_MON,0)
	          END
         END
       /*-----------------------------------------------------------------*/ 
       /*-----------------------------------------------------------------*/
	   /* FIN RIESGO NORMATIVO 2                                          */
	   /*-----------------------------------------------------------------*/
	   /*-----------------------------------------------------------------*/








	 END
   /*=============================================================================*/
   /*-----------------------------------------------------------------------------*/
   /* FIN FORWARD                                                                 */
   /*-----------------------------------------------------------------------------*/
   /*=============================================================================*/    







   /*=============================================================================*/
   /*-----------------------------------------------------------------------------*/
   /* SI ES OPCIONES                                                              */
   /*-----------------------------------------------------------------------------*/
   /*=============================================================================*/    

   IF @SISTEMA ='OPT' BEGIN



       /*-----------------------------------------------------------------*/
	   /* CALCULAR TIPO DE RIESGO POR PRODUCTO FORWARD                    */
	   /*-----------------------------------------------------------------*/
	     SET @RIESGO_NORMATIVO = 0
		 SET @MONTO_SALIDA     = 0
         SET @RIESGO_NORMATIVO = (SELECT RIESGO_NORMATIVO 
		                            FROM BacParamSuda.dbo.PRODUCTO WITH(NOLOCK)
								   WHERE ID_SISTEMA      = 'OPT'
								     AND ESTADO          = 1)


         IF @RIESGO_NORMATIVO = 0 OR @RIESGO_NORMATIVO IS NULL BEGIN
		    SET @MONTO_SALIDA = 0
			GOTO SALIR
		 END



       /*-----------------------------------------------------------------*/ 
       /*-----------------------------------------------------------------*/
	   /* RIESGO NORMATIVO 2 FORWARD DE MONEDAS                           */
	   /*-----------------------------------------------------------------*/
	   /*-----------------------------------------------------------------*/
         IF @RIESGO_NORMATIVO = 2 BEGIN

            /*------------------------------------------------------------*/
            /*EN ESTA SECCION SE CLASIFICARAN LAS MONEDAS DE ACUERDO AL   */
	        /*RIESGO DEL PAIS QUE CORRESPONDA                             */
            /*------------------------------------------------------------*/
              SET @CLASIFICACION_MONEDA = (SELECT mnClasificaRiesgoPais 
		                                     FROM BacParamSuda.dbo.moneda WITH(NOLOCK)
					    				    WHERE mncodmon             = @INT_COD_MONEDA
									          AND mnClasificaRiesgoPais <> '')


            /*------------------------------------------------------------*/
	        /* DEFINICION DEL FACTOR CORRESPONDIENTE SEGUN LA CANASTA AL  */
	        /* QUE PERTENEZCA LA MONEDA INDICADA                          */
            /*------------------------------------------------------------*/
			  SET @CANASTA1 = 0
			  SET @CANASTA2 = 0

              IF(@CLASIFICACION_MONEDA = 'AAA') BEGIN
	             SET @CANASTA1 = ISNULL((SELECT Factor1 
			                               FROM BacParamSuda.dbo.MATRIZ_RIESGO_NORMATIVO WITH(NOLOCK)
						   	              WHERE @PLAZO BETWEEN Plazo_Desde AND Plazo_Hasta 
							                AND Codigo_Riesgo = 2),0)
	          END
	          ELSE BEGIN
	            SET @CANASTA2 = ISNULL((SELECT factor2 
				                          FROM BacParamSuda.dbo.MATRIZ_RIESGO_NORMATIVO WITH(NOLOCK)
			                             WHERE @PLAZO BETWEEN Plazo_Desde AND Plazo_Hasta 
							               AND Codigo_Riesgo = 2),0)
              END
		


            /*------------------------------------------------------------*/
			/* DEPENDIENDO DE LA CLASIFICACION ESTE CALCULARA             */
            /*------------------------------------------------------------*/
			  SET @MONTO_SALIDA = 0
 	          IF (@CLASIFICACION_MONEDA = 'AAA') BEGIN
			     SET @MONTO_SALIDA = 0
		         SET @MONTO_SALIDA = ROUND((@MONTO * (@CANASTA1/100.0)) * @TIPO_DE_CAMBIO_MON,0)
		      END
		      ELSE BEGIN
			     SET @MONTO_SALIDA = 0
		         SET @MONTO_SALIDA = ROUND((@MONTO * (@CANASTA2/100.0)) * @TIPO_DE_CAMBIO_MON,0)
	          END
         END
       /*-----------------------------------------------------------------*/ 
       /*-----------------------------------------------------------------*/
	   /* FIN RIESGO NORMATIVO 2                                          */
	   /*-----------------------------------------------------------------*/
	   /*-----------------------------------------------------------------*/





     END
   /*=============================================================================*/
   /*-----------------------------------------------------------------------------*/
   /* FIN OPCIONES                                                                */
   /*-----------------------------------------------------------------------------*/
   /*=============================================================================*/    








   /*=============================================================================*/
   /*-----------------------------------------------------------------------------*/
   /* SI ES SWAP                                                                  */
   /*-----------------------------------------------------------------------------*/
   /*=============================================================================*/    
     IF @SISTEMA ='PCS' BEGIN


       /*-----------------------------------------------------------------*/
	   /* CALCULAR TIPO DE RIESGO POR PRODUCTO FORWARD                    */
	   /*-----------------------------------------------------------------*/
	     SET @RIESGO_NORMATIVO = 0
		 SET @MONTO_SALIDA     = 0
         SET @RIESGO_NORMATIVO = (SELECT RIESGO_NORMATIVO 
		                            FROM BacParamSuda.dbo.PRODUCTO WITH(NOLOCK)
								   WHERE ID_SISTEMA      = 'PCS'
								     AND codigo_producto = @CODIGOPRODUCTO 
								     AND ESTADO          = 1)


         IF @RIESGO_NORMATIVO = 0 OR @RIESGO_NORMATIVO IS NULL BEGIN
		    SET @MONTO_SALIDA = 0
			GOTO SALIR
		 END


       /*-----------------------------------------------------------------*/ 
       /*-----------------------------------------------------------------*/
	   /* RIESGO NORMATIVO 1 FORWARD DE TASAS DE INTERES                  */
	   /*-----------------------------------------------------------------*/
	   /*-----------------------------------------------------------------*/
	     SET @MONTO_SALIDA = 0
		 SET @CANASTA1     = 0

         IF @RIESGO_NORMATIVO = 1 BEGIN


		    SET @CANASTA1 = ISNULL((SELECT Factor1 
			                          FROM BacParamSuda.dbo.MATRIZ_RIESGO_NORMATIVO WITH(NOLOCK)
			  	   	                 WHERE @PLAZO BETWEEN Plazo_Desde AND Plazo_Hasta 
							           AND Codigo_Riesgo = 1),0)
            SET @MONTO_SALIDA = 0
            SET @MONTO_SALIDA = ROUND((@MONTO * (@CANASTA1/100.0)) * @TIPO_DE_CAMBIO_MON,0)

		 END


       /*-----------------------------------------------------------------*/ 
       /*-----------------------------------------------------------------*/
	   /* FIN RIESGO NORMATIVO 1                                          */
	   /*-----------------------------------------------------------------*/
	   /*-----------------------------------------------------------------*/




       /*-----------------------------------------------------------------*/ 
       /*-----------------------------------------------------------------*/
	   /* RIESGO NORMATIVO 2 FORWARD DE MONEDAS                           */
	   /*-----------------------------------------------------------------*/
	   /*-----------------------------------------------------------------*/
         IF @RIESGO_NORMATIVO = 2 BEGIN

            /*------------------------------------------------------------*/
            /*EN ESTA SECCION SE CLASIFICARAN LAS MONEDAS DE ACUERDO AL   */
	        /*RIESGO DEL PAIS QUE CORRESPONDA                             */
            /*------------------------------------------------------------*/
              SET @CLASIFICACION_MONEDA = (SELECT mnClasificaRiesgoPais 
		                                     FROM BacParamSuda.dbo.moneda WITH(NOLOCK)
					    				    WHERE mncodmon             = @INT_COD_MONEDA
									          AND mnClasificaRiesgoPais <> '')


            /*------------------------------------------------------------*/
	        /* DEFINICION DEL FACTOR CORRESPONDIENTE SEGUN LA CANASTA AL  */
	        /* QUE PERTENEZCA LA MONEDA INDICADA                          */
            /*------------------------------------------------------------*/
			  SET @CANASTA1 = 0
			  SET @CANASTA2 = 0

              IF(@CLASIFICACION_MONEDA = 'AAA') BEGIN
	             SET @CANASTA1 = ISNULL((SELECT Factor1 
			                               FROM BacParamSuda.dbo.MATRIZ_RIESGO_NORMATIVO WITH(NOLOCK)
						   	              WHERE @PLAZO BETWEEN Plazo_Desde AND Plazo_Hasta 
							                AND Codigo_Riesgo = 2),0)
	          END
	          ELSE BEGIN
	            SET @CANASTA2 = ISNULL((SELECT factor2 
				                          FROM BacParamSuda.dbo.MATRIZ_RIESGO_NORMATIVO WITH(NOLOCK)
			                             WHERE @PLAZO BETWEEN Plazo_Desde AND Plazo_Hasta 
							               AND Codigo_Riesgo = 2),0)
              END
		


            /*------------------------------------------------------------*/
			/* DEPENDIENDO DE LA CLASIFICACION ESTE CALCULARA             */
            /*------------------------------------------------------------*/
			  SET @MONTO_SALIDA = 0
 	          IF (@CLASIFICACION_MONEDA = 'AAA') BEGIN
			     SET @MONTO_SALIDA = 0
		         SET @MONTO_SALIDA = ROUND((@MONTO * (@CANASTA1/100.0)) * @TIPO_DE_CAMBIO_MON,0)
		      END
		      ELSE BEGIN
			     SET @MONTO_SALIDA = 0
		         SET @MONTO_SALIDA = ROUND((@MONTO * (@CANASTA2/100.0)) * @TIPO_DE_CAMBIO_MON,0)
	          END
         END
       /*-----------------------------------------------------------------*/ 
       /*-----------------------------------------------------------------*/
	   /* FIN RIESGO NORMATIVO 2                                          */
	   /*-----------------------------------------------------------------*/
	   /*-----------------------------------------------------------------*/




	 END

   /*=============================================================================*/
   /*-----------------------------------------------------------------------------*/
   /* FIN SWAP                                                                    */
   /*-----------------------------------------------------------------------------*/
   /*=============================================================================*/   




     SALIR:


	/*-----------------------------------------------------------------*/ 
    /*-----------------------------------------------------------------*/
	/* CALCULO DE MONTO AFECTO                                         */
	/*-----------------------------------------------------------------*/
	/*-----------------------------------------------------------------*/
	  SET @MONTO_SALIDA = ISNULL(@MONTO_SALIDA,0)
	  SET @MONTO_AFECTO = 0


	  IF @MTM <= 0 BEGIN
	     SET @MONTO_AFECTO = @MONTO_SALIDA
	  END
	  ELSE BEGIN
	     SET @MONTO_AFECTO = @MTM + @MONTO_SALIDA
	  END



	/*-----------------------------------------------------------------*/ 
    /*-----------------------------------------------------------------*/
	/* REGISTRO POR CALCULO DE ADDON                                   */
	/*-----------------------------------------------------------------*/
	/*-----------------------------------------------------------------*/
	 INSERT INTO BacParamSuda.dbo.TBL_ART84_INPADDON
	  SELECT
	  @ID_TICKET
	 ,@RUT_CLIENTE         
	 ,@CODIGO_CLIENTE       
	 ,@MONTO                        
	 ,@PLAZO               
     ,@SISTEMA             
	 ,@COD_MONEDA           
	 ,ISNULL(@CLASIFICACION_MONEDA,'')          
	 ,ISNULL(@TIPO_DE_CAMBIO_MON,0)  
     ,ISNULL(@TIPO_DE_CAMBIO_USD,0)  
	 ,@CODIGOPRODUCTO       
	 ,ISNULL(@RIESGO_NORMATIVO,0)      
	 ,ISNULL(@CANASTA1,0)
	 ,ISNULL(@CANASTA2,0)           
     ,ISNULL(@MONTO_SALIDA,0)
	 ,@FECHADEPROCESO
	 ,@MTM 
	 ,@MONTO_AFECTO

	 

	/*-----------------------------------------------------------------*/ 
    /*-----------------------------------------------------------------*/
	/* SALIDA DE DATOS                                                 */
	/*-----------------------------------------------------------------*/
	/*-----------------------------------------------------------------*/
	 SELECT @MONTO_SALIDA AS MONTO_ADDON
	       ,@MONTO_AFECTO AS MONTO_AFECTO









  SET NOCOUNT OFF
END

GO
