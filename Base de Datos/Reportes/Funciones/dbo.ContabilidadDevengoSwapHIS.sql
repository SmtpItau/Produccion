USE [Reportes]
GO
/****** Object:  UserDefinedFunction [dbo].[ContabilidadDevengoSwapHIS]    Script Date: 16-05-2022 10:17:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[ContabilidadDevengoSwapHIS](@Numero_operacion NUMERIC)



  /*-----------------------------------------------------------------------------*/
  /* CREACION DE TABLA DE SALIDA                                                 */
  /*-----------------------------------------------------------------------------*/
    returns @CONTABILIDAD TABLE
	 (GLOSA_PERFIL           CHAR(70)
	 ,FOLIO_PERFIL           NUMERIC(5)
     ,ID_SISTEMA             CHAR(3)
     ,TIPO_MOVIMIENTO        CHAR(3)
     ,TIPO_OPERACION         CHAR(5)
     ,OPERACION              NUMERIC(10)
     ,CORRELATIVO            NUMERIC(5)
	 ,MONEDA_INSTRUMENTO     CHAR(6)
	 ,CUENTA_CONTABLE        VARCHAR(20)
	 ,TIPO_MOVIMIENTO_CUENTA VARCHAR(04)
	 ,COD_CAMPO              INT
	 ,TIPO_CUENTA            VARCHAR(04)
	 ,DESCRIPCION            VARCHAR(2000)
	 ,CAMPO_FIJO             CHAR(01)
	 ,NOMBRE_CAMPO_CONTABLE  VARCHAR(50)
	 ,CLASIFICACION_CARTERA  VARCHAR(10))
	 




 AS BEGIN
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CARTERA FORWARD CONTABLE                                    */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 21/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/

   /*-----------------------------------------------------------------------------*/
   /* TABLA DE SALIDA                                                             */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	        (TIPO_VOUCHER           CHAR(1)
            ,GLOSA_PERFIL           CHAR(70)
		    ,FOLIO_PERFIL           NUMERIC(5)
            ,ID_SISTEMA             CHAR(3)
            ,TIPO_MOVIMIENTO        CHAR(3)
            ,TIPO_OPERACION         CHAR(5)
            ,OPERACION              NUMERIC(10)
            ,CORRELATIVO            NUMERIC(5)
			,MONEDA_INSTRUMENTO     CHAR(6)
			,CUENTA_CONTABLE        VARCHAR(20)
			,TIPO_MOVIMIENTO_CUENTA VARCHAR(02)
			,COD_CAMPO              INT
			,PERFIL_FIJO            CHAR(01)
			,NOMBRE_CAMPO_CONTABLE  VARCHAR(50)
			,CLASIFICACION_CARTERA  VARCHAR(10))
			

   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES CURSOR PRINCIPAL                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @CUR_TIPO_VOUCHER           CHAR(1)
            ,@CUR_GLOSA_PERFIL           CHAR(70)
		    ,@CUR_FOLIO_PERFIL           NUMERIC(5)
            ,@CUR_ID_SISTEMA             CHAR(3)
            ,@CUR_TIPO_MOVIMIENTO        CHAR(3)
            ,@CUR_TIPO_OPERACION         CHAR(5)
            ,@CUR_OPERACION              NUMERIC(10)
            ,@CUR_CORRELATIVO            NUMERIC(5)
			,@CUR_MONEDA_INSTRUMENTO     CHAR(6)
			,@CUR_CLASIFICACION_CARTERA  VARCHAR(10)
			,@CUR_TIPO_MARCA             CHAR(01)

     DECLARE @DET_CODIGO_CAMPO           NUMERIC(03)
	        ,@DET_TIPO_MOVIMIENTO_CUENTA CHAR(01)
            ,@DET_PERFIL_FIJO            CHAR(1)
            ,@DET_CODIGO_CUENTA          CHAR(20)
            ,@DET_CORRELATIVO_PERFIL     NUMERIC(3)
            ,@DET_CAMPO_VARIABLE         NUMERIC(3)
            ,@DET_FOLIO_PERFIL           NUMERIC(5)


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES AUXILIARES                                         */
   /*-----------------------------------------------------------------------------*/
     DECLARE @AUX_CODIGO_CUENTA          VARCHAR(20)
	        ,@VALOR_CAMPO_VARIABLE       VARCHAR(10)
			,@Nombre_Campo               VARCHAR(50)
			,@NOMBRE_CAMPO_CONTABLE      VARCHAR(50)

   /*-----------------------------------------------------------------------------*/
   /* BAC CONTABILIZA                                                             */
   /*-----------------------------------------------------------------------------*/
     DECLARE @BAC_CNT_CONTABILIZA TABLE
           ( ID_SISTEMA            VARCHAR(03)
           , TIPO_MOVIMIENTO       VARCHAR(03)
           , TIPO_OPERACION        VARCHAR(04)
           , OPERACION             NUMERIC
           , CORRELATIVO           INT
           , CODIGO_INSTRUMENTO    INT
           , MONEDA_INSTRUMENTO    INT
           , CARTERA_NORMATIVA     VARCHAR(04)
           , SUB_CARTERA_NORMATIVA VARCHAR(04)
           , PAIS                  INT
           , CLASIFICACION_CARTERA VARCHAR(10))

  

   /*-----------------------------------------------------------------------------*/
   /* REPRESENTACION DE MODELO DE CONTABILIZACION PARA MOVIMIENTOS                */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @BAC_CNT_CONTABILIZA
	 SELECT TOP(01)
	        'PCS'
	      , 'DEV'
		  , CASE WHEN CAR.tipo_swap = 2 THEN 'D' + LTRIM(RTRIM(CAR.tipo_swap))        
            ELSE 'D' + LTRIM(RTRIM(CAR.tipo_swap))        
            END         
		  , CAR.NUMERO_OPERACION
		  , 1
		  ,''
		  ,CASE WHEN CAR.tipo_swap = 1 THEN CONVERT(CHAR(03),CAR.Compra_Moneda)        
                WHEN CAR.tipo_swap = 4 THEN CONVERT(CHAR(03),CAR.Compra_Moneda)        
                WHEN CAR.tipo_swap = 2 THEN '999'        
                ELSE                      ''        
           END 
          ,CAR.CHI_Cartera_Normativa
          ,CAR.CHI_SubCartera_Normativa
		  ,CASE WHEN CLI.Clpais  = 6 THEN 2 ELSE 1 END   
		  ,'9999'
      FROM BacSwapSuda.DBO.CARTERAHIS CAR
	  LEFT JOIN
	       BacParamSuda.DBO.CLIENTE CLI 
		ON CAR.RUT_CLIENTE      = CLI.Clrut 
	   AND CAR.CODIGO_CLIENTE   = CLI.Clcodigo 
	 WHERE CAR.NUMERO_OPERACION = @Numero_operacion
	   AND CAR.tipo_flujo       = 1




   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR CODIGOS DE CARTERA                                               */
   /*-----------------------------------------------------------------------------*/
     UPDATE CON
	    SET CON.CLASIFICACION_CARTERA  = INS.CodigoCartera
	   FROM @BAC_CNT_CONTABILIZA CON
	  INNER JOIN
            BacParamSuda.DBO.TBL_CLASIFICACION_CARTERA_INSTRUMENTO  INS
         ON INS.id_Sistema          = CON.ID_SISTEMA   
        AND INS.Contraparte         = CON.PAIS 
        AND INS.CarteraNormativa    = CON.CARTERA_NORMATIVA  
        AND INS.SubcarteraNormativa = CON.SUB_CARTERA_NORMATIVA  
		AND CasaMatriz              = 0

	



	

     DECLARE CURSOR_CONTABLE CURSOR LOCAL FOR 
      SELECT PER.tipo_voucher
            ,PER.glosa_perfil
	        ,PER.folio_perfil
			,CON.id_sistema
			,CON.tipo_movimiento
			,CON.tipo_operacion
			,CON.operacion
			,CON.correlativo
			,CON.moneda_instrumento
			,CON.CLASIFICACION_CARTERA 
			,'N'
        FROM BacParamSuda..PERFIL_CNT PER
       INNER JOIN
             @BAC_CNT_CONTABILIZA     CON
	      ON CON.id_sistema         = PER.id_sistema
	     AND CON.tipo_movimiento    = PER.tipo_movimiento
	     AND CON.tipo_operacion     = PER.tipo_operacion
	     AND CON.codigo_instrumento = PER.codigo_instrumento
	     AND CON.moneda_instrumento = PER.moneda_instrumento
		 AND CON.OPERACION          = @Numero_operacion
        OPEN CURSOR_CONTABLE
       FETCH NEXT FROM CURSOR_CONTABLE INTO @CUR_TIPO_VOUCHER  
                                           ,@CUR_GLOSA_PERFIL  
		                                   ,@CUR_FOLIO_PERFIL  
										   ,@CUR_ID_SISTEMA          
                                           ,@CUR_TIPO_MOVIMIENTO       
										   ,@CUR_TIPO_OPERACION        
                                           ,@CUR_OPERACION  
										   ,@CUR_CORRELATIVO
										   ,@CUR_MONEDA_INSTRUMENTO 
										   ,@CUR_CLASIFICACION_CARTERA          
										   ,@CUR_TIPO_MARCA






   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO POR FOLIO                                                   */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS = 0 BEGIN



	    /*================================================================*/
	    /*----------------------------------------------------------------*/
		/* SEGUN EL FOLIO SE DEBE EXTRAER EL DETALLE A CONTABILIZAR       */
		/*----------------------------------------------------------------*/
		/*================================================================*/
		 DECLARE CURSOR_DETALLES CURSOR LOCAL FOR
		  SELECT Codigo_Campo
                ,Tipo_Movimiento_Cuenta
                ,Perfil_Fijo
                ,Codigo_Cuenta
                ,Correlativo_Perfil
                ,Codigo_Campo_Variable
		        ,folio_perfil
            FROM BacParamSuda..PERFIL_DETALLE_CNT
           WHERE Folio_Perfil = @CUR_FOLIO_PERFIL
           ORDER BY Folio_Perfil 
		          , Correlativo_Perfil


			

            OPEN CURSOR_DETALLES
           FETCH NEXT FROM CURSOR_DETALLES INTO @DET_CODIGO_CAMPO    
	                                           ,@DET_TIPO_MOVIMIENTO_CUENTA 
                                               ,@DET_PERFIL_FIJO            
                                               ,@DET_CODIGO_CUENTA          
                                               ,@DET_CORRELATIVO_PERFIL     
                                               ,@DET_CAMPO_VARIABLE         
											   ,@DET_FOLIO_PERFIL    


           WHILE @@FETCH_STATUS = 0 BEGIN



			   /*---------------------------------------------------------*/
			   /* CAMPO CONTABLE                                          */
			   /*---------------------------------------------------------*/
			     SELECT @NOMBRE_CAMPO_CONTABLE    = Nombre_Campo_Tabla
                   FROM BACSWAPSUDA.DBO.VIEW_CAMPO_CNT 
                  WHERE ID_Sistema                = @CUR_ID_SISTEMA
                    AND Tipo_Movimiento           = @CUR_TIPO_MOVIMIENTO
                    AND Tipo_Operacion            = @CUR_TIPO_OPERACION
                    AND Codigo_Campo              = @DET_CODIGO_CAMPO
                    AND Tipo_Administracion_Campo = 'F'



			     SET @AUX_CODIGO_CUENTA    =''
				 SET @VALOR_CAMPO_VARIABLE =''


			   /*---------------------------------------------------------*/
			   /* VERIFICAR SI EL PERFIL ES FIJO                          */
			   /*---------------------------------------------------------*/
                 IF @DET_PERFIL_FIJO = 'N' BEGIN
               

			        
			         
			       /*-----------------------------------------------------*/
				   /* NOMBRE DE CAMPO VARIABLE                            */
			       /*-----------------------------------------------------*/
                     SELECT @Nombre_Campo             = Nombre_Campo_Tabla
                       FROM BACSWAPSUDA.DBO.VIEW_CAMPO_CNT 
                      WHERE ID_Sistema                = @CUR_ID_SISTEMA
                        AND Tipo_Movimiento           = @CUR_TIPO_MOVIMIENTO
                        AND Tipo_Operacion            = @CUR_TIPO_OPERACION
                        AND Codigo_Campo              = @DET_CAMPO_VARIABLE
                        AND Tipo_Administracion_Campo = 'V'


			       /*-----------------------------------------------------*/
				   /* VALOR DINAMICO                                      */
			       /*-----------------------------------------------------*/
				     IF @Nombre_Campo = 'SubCartera' BEGIN

					    SELECT @VALOR_CAMPO_VARIABLE = CLASIFICACION_CARTERA 
						  FROM @BAC_CNT_CONTABILIZA 
						 WHERE ID_SISTEMA            = @CUR_ID_SISTEMA
                           AND TIPO_MOVIMIENTO       = @CUR_TIPO_MOVIMIENTO
                           AND TIPO_OPERACION        = @CUR_TIPO_OPERACION
                           AND OPERACION             = @CUR_OPERACION
                           AND CORRELATIVO           = @CUR_CORRELATIVO
                           AND MONEDA_INSTRUMENTO    = @CUR_MONEDA_INSTRUMENTO

					 END



			       /*-----------------------------------------------------*/
				   /* NOMBRE DE CAMPO VARIABLE                            */
			       /*-----------------------------------------------------*/
			         SELECT @AUX_CODIGO_CUENTA = Codigo_Cuenta
					   FROM BacSwapSuda.DBO.VIEW_PERFIL_VARIABLE_CNT 
					  WHERE Folio_Perfil       = @DET_FOLIO_PERFIL
					    AND Valor_Dato_Campo   = @VALOR_CAMPO_VARIABLE
						AND Correlativo_Perfil = @DET_CORRELATIVO_PERFIL



                     
                 END
				 ELSE BEGIN
					SET @AUX_CODIGO_CUENTA = @DET_CODIGO_CUENTA
					
				 END
				 


			   /*---------------------------------------------------------*/
			   /* INGRESO DE REGISTROS                                    */
			   /*---------------------------------------------------------*/
			     INSERT INTO @SALIDA
				 (TIPO_VOUCHER                  ,GLOSA_PERFIL      
		         ,FOLIO_PERFIL                  ,ID_SISTEMA             
                 ,TIPO_MOVIMIENTO               ,TIPO_OPERACION        
                 ,OPERACION                     ,CORRELATIVO      
			     ,MONEDA_INSTRUMENTO            ,CUENTA_CONTABLE 
				 ,TIPO_MOVIMIENTO_CUENTA        ,COD_CAMPO
				 ,PERFIL_FIJO                   ,NOMBRE_CAMPO_CONTABLE
				 ,CLASIFICACION_CARTERA)
				 VALUES
				 (@CUR_TIPO_VOUCHER            ,@CUR_GLOSA_PERFIL  
		         ,@CUR_FOLIO_PERFIL            ,@CUR_ID_SISTEMA             
                 ,@CUR_TIPO_MOVIMIENTO         ,@CUR_TIPO_OPERACION        
                 ,@CUR_OPERACION               ,@DET_CORRELATIVO_PERFIL      
			     ,@CUR_MONEDA_INSTRUMENTO      ,@AUX_CODIGO_CUENTA
				 ,@DET_TIPO_MOVIMIENTO_CUENTA  ,@DET_CODIGO_CAMPO
				 ,@DET_PERFIL_FIJO             ,@NOMBRE_CAMPO_CONTABLE
				 ,@CUR_CLASIFICACION_CARTERA)



                 FETCH NEXT FROM CURSOR_DETALLES INTO @DET_CODIGO_CAMPO    
	                                                 ,@DET_TIPO_MOVIMIENTO_CUENTA 
                                                     ,@DET_PERFIL_FIJO            
                                                     ,@DET_CODIGO_CUENTA          
                                                     ,@DET_CORRELATIVO_PERFIL     
                                                     ,@DET_CAMPO_VARIABLE         
											         ,@DET_FOLIO_PERFIL   

		   END
		   CLOSE CURSOR_DETALLES
           DEALLOCATE CURSOR_DETALLES
	    /*================================================================*/
	    /*----------------------------------------------------------------*/
		/* FIN DETALLES A CONTABILIZAR                                    */
		/*----------------------------------------------------------------*/
		/*================================================================*/






		FETCH NEXT FROM CURSOR_CONTABLE INTO @CUR_TIPO_VOUCHER  
										    ,@CUR_GLOSA_PERFIL  
											,@CUR_FOLIO_PERFIL 
										    ,@CUR_ID_SISTEMA          
                                            ,@CUR_TIPO_MOVIMIENTO 
											,@CUR_TIPO_OPERACION        
                                            ,@CUR_OPERACION
											,@CUR_CORRELATIVO  
											,@CUR_MONEDA_INSTRUMENTO 
											,@CUR_CLASIFICACION_CARTERA
											,@CUR_TIPO_MARCA
     END
     CLOSE CURSOR_CONTABLE
     DEALLOCATE CURSOR_CONTABLE


   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE DATOS                                                             */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @CONTABILIDAD 
     SELECT SAL.GLOSA_PERFIL           
		   ,SAL.FOLIO_PERFIL           
           ,SAL.ID_SISTEMA             
           ,SAL.TIPO_MOVIMIENTO        
           ,SAL.TIPO_OPERACION         
           ,SAL.OPERACION              
           ,SAL.CORRELATIVO            
		   ,SAL.MONEDA_INSTRUMENTO     
		   ,SAL.CUENTA_CONTABLE        
		   ,SAL.TIPO_MOVIMIENTO_CUENTA 
		   ,SAL.COD_CAMPO 
		   ,CUE.tipo_cuenta 
		   ,CUE.DESCRIPCION
		   ,SAL.PERFIL_FIJO
		   ,SAL.NOMBRE_CAMPO_CONTABLE 
		   ,SAL.CLASIFICACION_CARTERA
       FROM @SALIDA 	                     SAL  
       Left JOIN
            BacParamSuda.dbo.PLAN_DE_CUENTA  CUE WITH(NOLOCK)
	     ON SAL.CUENTA_CONTABLE         = CUE.CUENTA 





 Return

 END


GO
