USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_PASIVOS_CAPTACION_MENSUAL]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[SP_ADM_REPORTE_PASIVOS_CAPTACION_MENSUAL]    
                      @FECHA DATETIME

AS    
BEGIN    

  
	SET NOCOUNT ON   

 /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : PASIVOS                                                     */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     
	 
   
  


  
   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @FECHA_ANTERIOR DATETIME



   /*-----------------------------------------------------------------------------*/
   /* TABLA DE PASIVOS                                                            */
   /*-----------------------------------------------------------------------------*/
     DECLARE @PASIVOS TABLE
	        (SERIE                   VARCHAR(30)
	        ,OPERACION               NUMERIC
			,CORRELATIVO             INT
			,RUT_CLIENTE             NUMERIC
			,CODIGO_CLIENTE          INT
			,PAIS                    INT
			,MONEDA_EMISION          INT
			,FECHA_COLOCACION        DATETIME
			,FECHA_PROX_CUPON        DATETIME
			,TASA_EMISION            FLOAT
			,NOMINAL                 NUMERIC
			,EMISION_PESOS           NUMERIC
			,REAJUSTE_EMISION        NUMERIC
			,DESCUENTO               NUMERIC
			,INTERES_EMISION         NUMERIC
			,TIPO_BONO               VARCHAR(05)
			,NUMERO_AMORTIZACION     INT
			,CODIGO_INSTRUMENTO      INT)



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES CURSOR PRINCIPAL                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @CUR_SERIE                   VARCHAR(30)
	        ,@CUR_OPERACION               NUMERIC
			,@CUR_CORRELATIVO             INT
			,@CUR_RUT_CLIENTE             NUMERIC
			,@CUR_CODIGO_CLIENTE          INT
			,@CUR_PAIS                    INT
			,@CUR_MONEDA_EMISION          INT
			,@CUR_FECHA_COLOCACION        DATETIME
			,@CUR_FECHA_PROX_CUPON        DATETIME
			,@CUR_TASA_EMISION            FLOAT
			,@CUR_NOMINAL                 NUMERIC
			,@CUR_EMISION_PESOS           NUMERIC
			,@CUR_REAJUSTE_EMISION        NUMERIC
			,@CUR_DESCUENTO               NUMERIC
			,@CUR_INTERES_EMISION         NUMERIC
			,@CUR_TIPO_BONO               VARCHAR(05)
			,@CUR_NUMERO_AMORTIZACION     INT
			,@CUR_CODIGO_INSTRUMENTO      INT
	        ,@CNPJ                        VARCHAR(20)
			,@NEMO                        VARCHAR(04)
			,@PAIS                        VARCHAR(04)
			,@FLUJO                       FLOAT



   /*-----------------------------------------------------------------------------*/
   /* GENERACION DE SALIDA                                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	         (Nro_Control_Institucion_Financiera       VARCHAR(20)
			 ,Tipo_Operacion                           VARCHAR(05)
			 ,Identificador_Captacion                  VARCHAR(10)
			 ,Data_de_la_captacion                     DATETIME
			 ,Deudor_CNPJ                              VARCHAR(20)
			 ,Pais_Deudor                              VARCHAR(05)
			 ,Acreedor                                 VARCHAR(05)
			 ,Ind_de_ope_intraconglomerado             VARCHAR(05)
			 ,Ind_de_operacion_intragrupo_financiero   VARCHAR(05)
			 ,Moneda                                   VARCHAR(03)
			 ,Valor_de_la_captacion                    NUMERIC
			 ,Ind_Captacion_sin_Vcto_principal         VARCHAR(05)
			 ,Fecha_Vcto_prevista_Parcial_A_Principal  DATETIME
			 ,Val_Previsto_Parcial_Principal           NUMERIC
			 ,Tipo_de_Intereses                        VARCHAR(05)
			 ,Codigo_tasa_post_fijada                  VARCHAR(10)
			 ,Spread_tasa_post_fijada                  VARCHAR(10)
			 ,Costo_total_de_la_captacion              FLOAT
			 ,Modalidad_de_origen                      VARCHAR(05)
			 ,Destinacion                              VARCHAR(05)
			 ,Cuenta_Cosif                             VARCHAR(20)
			 ,Observaciones                            VARCHAR(150)
			 ,SERIE                                    VARCHAR(30))

	        		





   /*-----------------------------------------------------------------------------*/
   /* VARIABLES DE INTERFAZ                                                       */
   /*-----------------------------------------------------------------------------*/
      DECLARE @INT_Nro_Control_Institucion_Financiera       VARCHAR(20)
			 ,@INT_Tipo_Operacion                           VARCHAR(05)
			 ,@INT_Identificador_Captacion                  VARCHAR(10)
			 ,@INT_Data_de_la_captacion                     DATETIME
			 ,@INT_Deudor_CNPJ                              VARCHAR(20)
			 ,@INT_Pais_Deudor                              VARCHAR(05)
			 ,@INT_Acreedor                                 VARCHAR(05)
			 ,@INT_Ind_de_ope_intraconglomerado             VARCHAR(05)
			 ,@INT_Ind_de_operacion_intragrupo_financiero   VARCHAR(05)
			 ,@INT_Moneda                                   VARCHAR(03)
			 ,@INT_Valor_de_la_captacion                    NUMERIC
			 ,@INT_Ind_Captacion_sin_Vcto_principal         VARCHAR(05)
			 ,@INT_Fecha_Vcto_prevista_Parcial_A_Principal  DATETIME
			 ,@INT_Val_Previsto_Parcial_Principal           NUMERIC
			 ,@INT_Tipo_de_Intereses                        VARCHAR(05)
			 ,@INT_Codigo_tasa_post_fijada                  VARCHAR(10)
			 ,@INT_Spread_tasa_post_fijada                  VARCHAR(10)
			 ,@INT_Costo_total_de_la_captacion              FLOAT
			 ,@INT_Modalidad_de_origen                      VARCHAR(05)
			 ,@INT_Destinacion                              VARCHAR(05)
			 ,@INT_Cuenta_Cosif                             VARCHAR(20)
			 ,@INT_Observaciones                            VARCHAR(100)




   /*-----------------------------------------------------------------------------*/
   /* CALCULO DE FECHA                                                            */
   /*-----------------------------------------------------------------------------*/
    DECLARE @FECHA_PROCESO DATETIME
		   ,@TIPO_CONSULTA CHAR(01)


     SELECT @FECHA_PROCESO = acfecproc 
	   FROM BacTraderSuda.dbo.MDAC

	    SET @TIPO_CONSULTA = 'X'
	     

	     IF @FECHA < @FECHA_PROCESO BEGIN
		    SET @TIPO_CONSULTA = 'H'
		 END
		 IF @FECHA > @FECHA_PROCESO BEGIN
		    SET @TIPO_CONSULTA = 'X'
		 END
		 IF @FECHA = @FECHA_PROCESO BEGIN
		    SET @TIPO_CONSULTA = 'V'
		 END



   /*-----------------------------------------------------------------------------*/
   /* QUERY GENERAL DE TABLA DE PASIVOS                                           */
   /*-----------------------------------------------------------------------------*/
     IF @TIPO_CONSULTA = 'H' BEGIN
        INSERT INTO @PASIVOS
        SELECT 'SERIE'                   = CAR.nombre_serie
	          ,'OPERACION'               = CAR.numero_operacion
	    	  ,'CORRELATIVO'             = CAR.numero_correlativo
	          ,'RUT_CLIENTE'             = CAR.rut_cliente 
	          ,'CODIGO_CLIENTE'          = CAR.codigo_cliente
	    	  ,'PAIS'                    = CLI.Clpais
	    	  ,'MONEDA_EMISION'          = CAR.moneda_emision 	
	    	  ,'FECHA_COLOCACION'        = CAR.fecha_colocacion 
	    	  ,'FECHA_PROX_CUPON'        = CAR.fecha_proximo_cupon 
	    	  ,'TASA_COLOCACION'         = CAR.tasa_colocacion 
	    	  ,'NOMINAL'                 = CAR.nominal 
	          ,'EMISION_PESOS'           = ISNULL(CAR.valor_emision_pesos,0)
	    	  ,'REAJUSTE_EMISION'        = ISNULL(CAR.reajuste_emision,0)
	    	  ,'DESCUENTO'               = CASE WHEN CAR.nombre_serie IN('BCORAG0710','BCORBW0914','BCORUSD0919') 
	    	                                     THEN (Presente_Estimado - presente_emision)
	    										 ELSE ISNULL(CAR.descuento,0) 
	    	                                END
	    	  ,'INTERES_EMISION'         = ISNULL(CAR.interes_emision,0)
	    	  ,'TIPO_BONO'               = ISNULL(SER.Tipo_Bono,'')
	    	  ,'NUMERO_AMORTIZACION'     = ISNULL(SER.numero_amortizacion, 0) 	
	    	  ,'CODIGO_INSTRUMENTO'      = CAR.CODIGO_INSTRUMENTO   
	      FROM MDPasivo.dbo.CARTERA_PASIVO_HISTORICA CAR
          LEFT OUTER JOIN
               MDPasivo.dbo.SERIE_PASIVO AS SER
	        ON CAR.nombre_serie = SER.nombre_serie
         INNER JOIN
               MDPARPASIVO..CLIENTE                 CLI
	        ON CLI.Clrut             = CAR.rut_cliente
           AND CLI.Clcodigo          = CAR.codigo_cliente   
	     WHERE CAR.fecha_cartera     = @FECHA
    END
	   

   /*-----------------------------------------------------------------------------*/
   /* QUERY GENERAL DE TABLA DE PASIVOS                                           */
   /*-----------------------------------------------------------------------------*/
     IF @TIPO_CONSULTA = 'V' BEGIN

        INSERT INTO @PASIVOS
        SELECT 'SERIE'                   = CAR.nombre_serie
	          ,'OPERACION'               = CAR.numero_operacion
	    	  ,'CORRELATIVO'             = CAR.numero_correlativo
	          ,'RUT_CLIENTE'             = CAR.rut_cliente 
	          ,'CODIGO_CLIENTE'          = CAR.codigo_cliente
	    	  ,'PAIS'                    = CLI.Clpais
	    	  ,'MONEDA_EMISION'          = CAR.moneda_emision 	
	    	  ,'FECHA_COLOCACION'        = CAR.fecha_colocacion 
	    	  ,'FECHA_PROX_CUPON'        = CAR.fecha_proximo_cupon 
	    	  ,'TASA_COLOCACION'         = CAR.tasa_colocacion 
	    	  ,'NOMINAL'                 = CAR.nominal 
	          ,'EMISION_PESOS'           = ISNULL(CAR.valor_emision_pesos,0)
	    	  ,'REAJUSTE_EMISION'        = ISNULL(CAR.reajuste_emision,0)
	    	  ,'DESCUENTO'               = CASE WHEN CAR.nombre_serie IN('BCORAG0710','BCORBW0914','BCORUSD0919') 
	    	                                     THEN (Presente_Estimado - presente_emision)
	    										 ELSE ISNULL(CAR.descuento,0) 
	    	                                END
	    	  ,'INTERES_EMISION'         = ISNULL(CAR.interes_emision,0)
	    	  ,'TIPO_BONO'               = ISNULL(SER.Tipo_Bono,'')
	    	  ,'NUMERO_AMORTIZACION'     = ISNULL(SER.numero_amortizacion, 0) 	
	    	  ,'CODIGO_INSTRUMENTO'      = CAR.CODIGO_INSTRUMENTO   
	      FROM MDPasivo.dbo.CARTERA_PASIVO CAR
          LEFT OUTER JOIN
               MDPasivo.dbo.SERIE_PASIVO AS SER
	        ON CAR.nombre_serie = SER.nombre_serie
         INNER JOIN
               MDPARPASIVO..CLIENTE                 CLI
	        ON CLI.Clrut             = CAR.rut_cliente
           AND CLI.Clcodigo          = CAR.codigo_cliente   

    END


   /*-----------------------------------------------------------------------------*/
   /* PARA CIERTAS OPERACIONES SE DEBE CONSIDERAR SOLO EL MONTO DE EMISION        */
   /*-----------------------------------------------------------------------------*/
     UPDATE @PASIVOS
	    SET REAJUSTE_EMISION = 0
		   ,DESCUENTO        = 0
		   ,INTERES_EMISION  = 0
	  WHERE SERIE IN('C-B11','C-B14','C-PRE','FOGAIN')


   /*-----------------------------------------------------------------------------*/
   /* CURSOR DE CONTABILIDAD SOLO ARBITRAJES                                      */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_OPERACIONES CURSOR LOCAL FOR
     SELECT  SERIE                   
	        ,OPERACION               
			,CORRELATIVO             
			,RUT_CLIENTE             
			,CODIGO_CLIENTE          
			,PAIS                    
			,MONEDA_EMISION          
			,FECHA_COLOCACION        
			,FECHA_PROX_CUPON        
			,TASA_EMISION            
			,NOMINAL                 
			,EMISION_PESOS           
			,REAJUSTE_EMISION        
			,DESCUENTO               
			,INTERES_EMISION         
			,TIPO_BONO               
			,NUMERO_AMORTIZACION    
			,CODIGO_INSTRUMENTO 
	   FROM @PASIVOS 




       OPEN CURSOR_OPERACIONES
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_SERIE                   
	                                          ,@CUR_OPERACION               
			                                  ,@CUR_CORRELATIVO             
			                                  ,@CUR_RUT_CLIENTE             
			                                  ,@CUR_CODIGO_CLIENTE          
			                                  ,@CUR_PAIS                    
			                                  ,@CUR_MONEDA_EMISION          
			                                  ,@CUR_FECHA_COLOCACION        
			                                  ,@CUR_FECHA_PROX_CUPON        
			                                  ,@CUR_TASA_EMISION            
			                                  ,@CUR_NOMINAL                 
			                                  ,@CUR_EMISION_PESOS           
			                                  ,@CUR_REAJUSTE_EMISION        
			                                  ,@CUR_DESCUENTO               
			                                  ,@CUR_INTERES_EMISION 
											  ,@CUR_TIPO_BONO               
			                                  ,@CUR_NUMERO_AMORTIZACION  
											  ,@CUR_CODIGO_INSTRUMENTO      

   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN


          /*----------------------------------------------------------------------*/
          /* SETEO DE REGISTROS                                                   */
          /*----------------------------------------------------------------------*/
		    SELECT @INT_Nro_Control_Institucion_Financiera       = '769-01-'
			                                                     + LTRIM(RTRIM(CONVERT(CHAR,@CUR_OPERACION)))
																 + '-'
																 + LTRIM(RTRIM(CONVERT(CHAR,@CUR_CORRELATIVO)))
			      ,@INT_Tipo_Operacion                           = 'A'
			      ,@INT_Identificador_Captacion                  = ''
			      ,@INT_Data_de_la_captacion                     = @CUR_FECHA_COLOCACION
			      ,@INT_Deudor_CNPJ                              = LTRIM(RTRIM(CONVERT(CHAR,@CUR_RUT_CLIENTE)))
				                                                 + '-' 
																 + LTRIM(RTRIM(CONVERT(CHAR,@CUR_CODIGO_CLIENTE)))
			      ,@INT_Pais_Deudor                              = ''
			      ,@INT_Acreedor                                 = ''
			      ,@INT_Ind_de_ope_intraconglomerado             = 'N'
				  ,@INT_Ind_de_operacion_intragrupo_financiero   = ''
			      ,@INT_Moneda                                   = @CUR_MONEDA_EMISION
			      ,@INT_Valor_de_la_captacion                    = (@CUR_EMISION_PESOS + @CUR_REAJUSTE_EMISION + @CUR_INTERES_EMISION + @CUR_DESCUENTO)
			      ,@INT_Ind_Captacion_sin_Vcto_principal         = ''
			      ,@INT_Fecha_Vcto_prevista_Parcial_A_Principal  = @CUR_FECHA_PROX_CUPON
			      ,@INT_Val_Previsto_Parcial_Principal           = 0
			      ,@INT_Tipo_de_Intereses                        = CASE WHEN @CUR_TASA_EMISION > 0 THEN 'PRE' ELSE 'SEM' END
			      ,@INT_Codigo_tasa_post_fijada                  = ''
			      ,@INT_Spread_tasa_post_fijada                  = ''
			      ,@INT_Costo_total_de_la_captacion              = @CUR_TASA_EMISION
			      ,@INT_Modalidad_de_origen                      = ''
			      ,@INT_Destinacion                              = '999'
			      ,@INT_Cuenta_Cosif                             = (SELECT CUENTA_CONTABLE FROM REPORTES.DBO.ContabilidadBonosPasivo(@CUR_OPERACION,@CUR_CORRELATIVO) WHERE CORRELATIVO =1)
			     

          /*----------------------------------------------------------------------*/
          /* SE VERIFICA QUE EL RUT EXISTA EN LA TABLA PERSONAS REALACIONADAS     */
          /*----------------------------------------------------------------------*/
		    IF EXISTS(SELECT 1
			            FROM BacParamSuda.DBO.TBL_PERSONAS_RELACIONADAS WITH(NOLOCK)
					   WHERE  CODIGO = @CUR_RUT_CLIENTE) BEGIN

			   SET @INT_Ind_de_ope_intraconglomerado ='S'
			END
			ELSE BEGIN 
			   SET @INT_Ind_de_ope_intraconglomerado ='N'
			END


          /*----------------------------------------------------------------------*/
          /* SE VERIFICA QUE EL RUT EXISTA EN LA TABLA GRUPOS  REALACIONADAS      */
          /*----------------------------------------------------------------------*/
		    IF EXISTS(SELECT 1
			            FROM BacParamSuda.DBO.TBL_GRUPOS_RELACIONADOS WITH(NOLOCK)
					   WHERE  CODIGO = @CUR_RUT_CLIENTE) BEGIN

			   SET @INT_Ind_de_operacion_intragrupo_financiero ='S'
			END
			ELSE BEGIN 
			   SET @INT_Ind_de_operacion_intragrupo_financiero ='N'
			END				

          /*----------------------------------------------------------------------*/
          /* VERIFICAR SI LOS CODIGOS CNPJ EXISTEN EN LA TABLA DE CLIENTES        */
		  /* DE BACPARAMSUDA O SE LE ASIGNARA RUT MAS GUION ORIGINAL              */
          /*----------------------------------------------------------------------*/
		    SELECT @CNPJ    = CNPJ 
			      ,@CUR_PAIS = CLPAIS 
			  FROM BacParamSuda.DBO.CLIENTE 
			 WHERE CLRUT    = @CUR_RUT_CLIENTE
			   AND CLCODIGO = @CUR_CODIGO_CLIENTE
			   
			   IF LEN(LTRIM(RTRIM(@CNPJ))) <= 0 BEGIN
			      SET @INT_Deudor_CNPJ = @CUR_RUT_CLIENTE
			   END

          /*----------------------------------------------------------------------*/
          /* LA MONEDA SE DEBERA BUSCAR EN LA TABLA MONEDA PARA QUE EXISTA        */
		  /* HOMOLOGACION HACIA LAS SIGLAS DE ITAU                                */
          /*----------------------------------------------------------------------*/
		    IF @CUR_MONEDA_EMISION = 998 BEGIN
			   SET @NEMO ='CLF'
			END
			ELSE BEGIN

		       SELECT @NEMO    = mnnemo  
		         FROM BacParamSuda.DBO.MONEDA
			    WHERE mncodmon = @CUR_MONEDA_EMISION 

			END
			   
	        IF @NEMO IS NOT NULL BEGIN
			   SET @INT_Moneda = @NEMO
			END


          /*----------------------------------------------------------------------*/
          /* EL PAIS SE DEBERA BUSCAR EN LA TABLA PAISES PARA QUE EXISTA          */
		  /* HOMOLOGACION HACIA LAS SIGLAS DE ITAU                                */
          /*----------------------------------------------------------------------*/
		    SELECT @PAIS = COD_ITAU 
			  FROM BACPARAMSUDA.DBO.PAIS 
			 WHERE CODIGO_PAIS = @CUR_PAIS



			   IF @PAIS IS NOT NULL BEGIN
			      SET @INT_Pais_Deudor = @PAIS
			   END

          /*----------------------------------------------------------------------*/
          /* VALOR PREVISTO PARCIAL PRINCIPAL DEBE POSEER EL MONTO DE PAGO PROXIMO*/
		  /* CUPON EN MONEDA DE EMISION                                           */
          /*----------------------------------------------------------------------*/
		       SET @FLUJO = 0
		    SELECT @FLUJO = ISNULL(FLUJO,0)
			  FROM MdPasivo.dbo.FLUJO_BONOS
			 WHERE FECHA_VENCIMIENTO = @CUR_FECHA_PROX_CUPON

			    IF @@ROWCOUNT = 0 BEGIN
				   SET @FLUJO = 0 
				   SET @INT_Ind_Captacion_sin_Vcto_principal = 'N'
				END
				ELSE BEGIN
				   SET @INT_Ind_Captacion_sin_Vcto_principal = 'S'
				END


			IF @FLUJO != 0 BEGIN
			    SET @INT_Val_Previsto_Parcial_Principal = (@CUR_NOMINAL * @FLUJO) /100
			END
			ELSE BEGIN
			     SET @INT_Val_Previsto_Parcial_Principal = 0
			END


          /*----------------------------------------------------------------------*/
          /* VERIFICAR PRODUCTO DEL INTRUMENTO PARA DETERMINAR SU ORIGEN          */
          /*----------------------------------------------------------------------*/
			SET @INT_Modalidad_de_origen = (SELECT 
			                                  CASE 
			                                  WHEN codigo_producto ='CORFO' THEN 3
										      WHEN codigo_producto ='BONOS' THEN 5
											  ELSE ''
											  END 
				                              FROM MDPasivo.dbo.INSTRUMENTO_PASIVO 
										     WHERE CODIGO_INSTRUMENTO = @CUR_CODIGO_INSTRUMENTO)


            IF @INT_Modalidad_de_origen = 5 BEGIN

			   
			   SET @INT_Modalidad_de_origen = (SELECT 
			                                     CASE 
			                                     WHEN bono_subordinado ='N' THEN 5
												 WHEN bono_subordinado ='S' THEN 3
												 ELSE ''
												 END 
				                                 FROM MDPasivo.dbo.SERIE_PASIVO
										        WHERE CODIGO_INSTRUMENTO = @CUR_CODIGO_INSTRUMENTO
												  AND NOMBRE_SERIE       = @CUR_SERIE) 
 

			END


          /*----------------------------------------------------------------------*/
          /* OBSERVACIONES DE COSIF                                               */
          /*----------------------------------------------------------------------*/
            SELECT @INT_Observaciones = GLOSA_COSIF
			  FROM REPORTES.DBO.CODIGOS_COSIF(@INT_Cuenta_Cosif)

			    IF @@ROWCOUNT = 0 BEGIN
				   SET @INT_Observaciones = 'NO EXISTE COSIF' 
				END


			      

          /*----------------------------------------------------------------------*/
          /* INGRESO DE REGISTROS                                                 */
          /*----------------------------------------------------------------------*/
		    INSERT INTO @SALIDA
	         (Nro_Control_Institucion_Financiera       ,Tipo_Operacion                           
			 ,Identificador_Captacion                  ,Data_de_la_captacion                     
			 ,Deudor_CNPJ                              ,Pais_Deudor                              
			 ,Acreedor                                 ,Ind_de_ope_intraconglomerado             
			 ,Moneda                                   ,Valor_de_la_captacion                    
			 ,Ind_Captacion_sin_Vcto_principal         ,Fecha_Vcto_prevista_Parcial_A_Principal  
			 ,Val_Previsto_Parcial_Principal           ,Tipo_de_Intereses                        
			 ,Codigo_tasa_post_fijada                  ,Spread_tasa_post_fijada                  
			 ,Costo_total_de_la_captacion              ,Modalidad_de_origen                      
			 ,Destinacion                              ,Cuenta_Cosif                             
			 ,Observaciones                            ,Ind_de_operacion_intragrupo_financiero
			 ,SERIE) 
			 VALUES                           
	         (@INT_Nro_Control_Institucion_Financiera  ,@INT_Tipo_Operacion                           
			 ,@INT_Identificador_Captacion             ,@INT_Data_de_la_captacion                     
			 ,@INT_Deudor_CNPJ                         ,@INT_Pais_Deudor                              
			 ,@INT_Acreedor                            ,@INT_Ind_de_ope_intraconglomerado             
			 ,@INT_Moneda                              ,@INT_Valor_de_la_captacion                    
			 ,@INT_Ind_Captacion_sin_Vcto_principal    ,@INT_Fecha_Vcto_prevista_Parcial_A_Principal  
			 ,@INT_Val_Previsto_Parcial_Principal      ,@INT_Tipo_de_Intereses                        
			 ,@INT_Codigo_tasa_post_fijada             ,@INT_Spread_tasa_post_fijada                  
			 ,@INT_Costo_total_de_la_captacion         ,@INT_Modalidad_de_origen                      
			 ,@INT_Destinacion                         ,@INT_Cuenta_Cosif                             
			 ,@INT_Observaciones                       ,@INT_Ind_de_operacion_intragrupo_financiero
			 ,@CUR_SERIE)




       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_SERIE                   
	                                          ,@CUR_OPERACION               
			                                  ,@CUR_CORRELATIVO             
			                                  ,@CUR_RUT_CLIENTE             
			                                  ,@CUR_CODIGO_CLIENTE          
			                                  ,@CUR_PAIS                    
			                                  ,@CUR_MONEDA_EMISION          
			                                  ,@CUR_FECHA_COLOCACION        
			                                  ,@CUR_FECHA_PROX_CUPON        
			                                  ,@CUR_TASA_EMISION            
			                                  ,@CUR_NOMINAL                 
			                                  ,@CUR_EMISION_PESOS           
			                                  ,@CUR_REAJUSTE_EMISION        
			                                  ,@CUR_DESCUENTO               
			                                  ,@CUR_INTERES_EMISION 
											  ,@CUR_TIPO_BONO               
			                                  ,@CUR_NUMERO_AMORTIZACION 
											  ,@CUR_CODIGO_INSTRUMENTO  											       


     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES



   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT Nro_Control_Institucion_Financiera       
		   ,Tipo_Operacion                           
		   ,Identificador_Captacion                  
		   ,CONVERT(CHAR(10),Data_de_la_captacion,105) AS Data_de_la_captacion
		   ,Deudor_CNPJ                              
		   ,Pais_Deudor                              
		   ,Acreedor                                 
		   ,Ind_de_ope_intraconglomerado
		   ,Ind_de_operacion_intragrupo_financiero             
		   ,Moneda                                   
		   ,Valor_de_la_captacion                    
		   ,Ind_Captacion_sin_Vcto_principal         
		   ,CONVERT(CHAR(10),Fecha_Vcto_prevista_Parcial_A_Principal  ,105) AS Fecha_Vcto_prevista_Parcial_A_Principal   
		   ,Val_Previsto_Parcial_Principal           
		   ,Tipo_de_Intereses                        
		   ,Codigo_tasa_post_fijada                  
		   ,Spread_tasa_post_fijada                  
		   ,Costo_total_de_la_captacion              
		   ,Modalidad_de_origen                      
		   ,Destinacion                              
		   ,Cuenta_Cosif                             
		   ,Observaciones  
		   --,SERIE                          
	   FROM @SALIDA







END
GO
