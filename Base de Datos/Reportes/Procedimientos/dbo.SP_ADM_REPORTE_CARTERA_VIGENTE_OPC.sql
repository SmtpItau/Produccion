USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_CARTERA_VIGENTE_OPC]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_CARTERA_VIGENTE_OPC]    
                      @FECHA DATETIME

AS    
BEGIN    


SET NOCOUNT ON   

  
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CONTABILIDAD OPCIONES                                       */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 17/02/2016                                                  */
   /*-----------------------------------------------------------------------------*/



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DE CURSOR                                          */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPE_NUMERO_OPERACION    NUMERIC
			,@OPE_FECHA_CONTRATO      DATETIME
			,@OPE_NUMERO_ESTRUCTURA   INT



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @MONEDA_1               INT
	        ,@STR_MONEDA_1           VARCHAR(03)
	        ,@MONEDA_2               INT
	        ,@STR_MONEDA_2           VARCHAR(03)
	        ,@FOLIO                  NUMERIC
	        ,@CONTRATO               NUMERIC
	        ,@FECHA_CONTRATO         DATETIME
			,@FECHA_VENCIMIENTO      DATETIME
	        ,@CARTERA_FINANCIERA     VARCHAR(04)
	        ,@LIBRO                  VARCHAR(04)
	        ,@NORMATIVA              VARCHAR(04)
	        ,@RUT_CLIENTE            NUMERIC
	        ,@CODIGO_CLIENTE         INT
	        ,@NOMBRE_CLIENTE         VARCHAR(150)
            ,@PAIS                   INT 
	        ,@CNPJ                   VARCHAR(20)
	        ,@Clopcion               VARCHAR(02)
	        ,@RUT_DV                 VARCHAR(02)
	        ,@OPERADOR               VARCHAR(15)
	        ,@CODIDO_ESTRUCTURA      INT
	        ,@DESCRIPCION_ESTRUCTURA VARCHAR(100)
	        ,@MONTO_1                NUMERIC
	        ,@MONTO_2                NUMERIC
	        ,@NUMERO_ESTRUCTURA      INT
			,@CaVr                   NUMERIC
	        ,@CAVRDETML              NUMERIC
	        ,@CAPRIMAINICIALDETML    NUMERIC
			,@TIPO_OPERACION         VARCHAR(01)
			,@CARTERA                VARCHAR(100) 
	        ,@ORIGEN                 VARCHAR(03)
			,@MODALIDAD              VARCHAR(02)
			,@CODIGO_MONEDA          INT
			,@FORMAPAGOCOMP          INT
			,@DIAS_VALOR             INT


   /*-----------------------------------------------------------------------------*/
   /* GENERACION DE SALIDA                                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	    (N_DE_DEAL							NUMERIC
		,RUT_CLIENTE						VARCHAR(100)
		,NOMBRE_DEL_CLIENTE					VARCHAR(100)
		,CARTERA							VARCHAR(100)
		,TIPO_DE_INSTRUMENTO				VARCHAR(100)
		,FECHA_INGRESO						DATE
		,FECHA_INICIO						DATE
		,FECHA_DE_VENCIMIENTO				DATE
		,MONEDA_LEG_ACTIVA					VARCHAR(100)
		,NOCIONAL_ACTIVO					VARCHAR(100)
		,MONEDA_LEG_PASIVA					VARCHAR(100)
		,NOCIONAL_PASIVO					VARCHAR(100)
		,TIPO_DE_TASA_ACTIVO				VARCHAR(100)
		,TIPO_DE_TASA_PASIVO				VARCHAR(100)
		,TIPO								VARCHAR(100)
		,POSICIÓN							VARCHAR(100)
		,MONEDA_MTM							VARCHAR(100)
		,MTM_ACTIVO							FLOAT
		,MTM_PASIVO							FLOAT
		,MONTO_MTM							NUMERIC
		,AJUSTE_BID_OFFER					FLOAT
		,AJUSTE_RIESGO_CRED					FLOAT
		,MTM_TOTAL							NUMERIC
		,MTM_TOTAL_CLP						NUMERIC
		,CUENTA_ACTIVO_PASIVO				VARCHAR(100)
		,NOCIONAL_RECIBO					VARCHAR(20)
		,NOCIONAL_PAGO						VARCHAR(20)
		,MODALIDAD_NOCIONALES				VARCHAR(100)
		,MODALIDAD_INTERESES				VARCHAR(100)
		,FECHA_LIQUIDACION					DATE
		,MONEDA_PAGO_1						VARCHAR(100)
		,LIQUIDACION_NOCIONALES_RECIBIDOS	VARCHAR(100)
		,LIQUIDACION_INTERESES_RECIBIDOS	VARCHAR(100)
		,MONEDA_PAGO_2						VARCHAR(100)
		,LIQUIDACION_NOCIONALES_PAGADOS		VARCHAR(100)
		,LIQUIDACION_INTERESES_PAGADOS		VARCHAR(100)
		,LIQUIDACION_NETA_DE_INTERESES		VARCHAR(100)
		,TOTAL_NOCIONAL_ACTIVO_RECIBIDOS	VARCHAR(100)
		,TOTAL_INTERESES_ACTIVOS_RECIBIDOS	VARCHAR(100)
		,TOTAL_NOCIONAL_PASIVOS_PAGADOS		VARCHAR(100)
		,TOTAL_INTERESES_PASIVOS_PAGADOS	VARCHAR(100)
		,REPORTE_CASA_MATRIZ				VARCHAR(100)
		,STATUS								VARCHAR(100))
			 

   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DE LLENADO DE INTERFAZ                             */
   /*-----------------------------------------------------------------------------*/
	 DECLARE @INT_N_DE_DEAL							NUMERIC
		    ,@INT_RUT_CLIENTE						VARCHAR(100)
		    ,@INT_NOMBRE_DEL_CLIENTE				VARCHAR(100)
		    ,@INT_CARTERA							VARCHAR(100)
		    ,@INT_TIPO_DE_INSTRUMENTO				VARCHAR(100)
		    ,@INT_FECHA_INGRESO						DATE
		    ,@INT_FECHA_INICIO						DATE
		    ,@INT_FECHA_DE_VENCIMIENTO				DATE
		    ,@INT_MONEDA_LEG_ACTIVA					VARCHAR(100)
		    ,@INT_NOCIONAL_ACTIVO					VARCHAR(100)
		    ,@INT_MONEDA_LEG_PASIVA					VARCHAR(100)
		    ,@INT_NOCIONAL_PASIVO					VARCHAR(100)
		    ,@INT_TIPO_DE_TASA_ACTIVO				VARCHAR(100)
		    ,@INT_TIPO_DE_TASA_PASIVO				VARCHAR(100)
		    ,@INT_TIPO								VARCHAR(100)
		    ,@INT_POSICIÓN							VARCHAR(100)
		    ,@INT_MONEDA_MTM						VARCHAR(100)
		    ,@INT_MTM_ACTIVO						FLOAT
		    ,@INT_MTM_PASIVO						FLOAT
		    ,@INT_MONTO_MTM							NUMERIC
		    ,@INT_AJUSTE_BID_OFFER					FLOAT
		    ,@INT_AJUSTE_RIESGO_CRED				FLOAT
		    ,@INT_MTM_TOTAL							NUMERIC
		    ,@INT_MTM_TOTAL_CLP						NUMERIC
		    ,@INT_CUENTA_ACTIVO_PASIVO				VARCHAR(100)
		    ,@INT_NOCIONAL_RECIBO					VARCHAR(20)
		    ,@INT_NOCIONAL_PAGO						VARCHAR(20)
		    ,@INT_MODALIDAD_NOCIONALES				VARCHAR(100)
		    ,@INT_MODALIDAD_INTERESES				VARCHAR(100)
		    ,@INT_FECHA_LIQUIDACION					DATE
		    ,@INT_MONEDA_PAGO_1						VARCHAR(100)
		    ,@INT_LIQUIDACION_NOCIONALES_RECIBIDOS	VARCHAR(100)
		    ,@INT_LIQUIDACION_INTERESES_RECIBIDOS	VARCHAR(100)
		    ,@INT_MONEDA_PAGO_2						VARCHAR(100)
		    ,@INT_LIQUIDACION_NOCIONALES_PAGADOS	VARCHAR(100)
		    ,@INT_LIQUIDACION_INTERESES_PAGADOS		VARCHAR(100)
		    ,@INT_LIQUIDACION_NETA_DE_INTERESES		VARCHAR(100)
		    ,@INT_TOTAL_NOCIONAL_ACTIVO_RECIBIDOS	VARCHAR(100)
		    ,@INT_TOTAL_INTERESES_ACTIVOS_RECIBIDOS	VARCHAR(100)
		    ,@INT_TOTAL_NOCIONAL_PASIVOS_PAGADOS	VARCHAR(100)
		    ,@INT_TOTAL_INTERESES_PASIVOS_PAGADOS	VARCHAR(100)
		    ,@INT_REPORTE_CASA_MATRIZ				VARCHAR(100)
		    ,@INT_STATUS							VARCHAR(100)


   /*-----------------------------------------------------------------------------*/
   /* TABLA OPERACIONES CARTERA                                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPERACIONES TABLE
	 (SISTEMA                VARCHAR(03)
	 ,MONEDA_1               INT
	 ,STR_MONEDA_1           VARCHAR(03)
	 ,MONEDA_2               INT
	 ,STR_MONEDA_2           VARCHAR(03)
	 ,FOLIO                  NUMERIC
	 ,CONTRATO               NUMERIC
	 ,FECHA_CONTRATO         DATETIME
	 ,FECHA_VENCIMIENTO      DATETIME
	 ,CARTERA_FINANCIERA     VARCHAR(04)
	 ,LIBRO                  VARCHAR(04)
	 ,NORMATIVA              VARCHAR(04)
	 ,RUT_CLIENTE            NUMERIC
	 ,CODIGO_CLIENTE         INT
	 ,NOMBRE_CLIENTE         VARCHAR(150)
     ,PAIS                   INT 
	 ,CNPJ                   VARCHAR(20)
	 ,Clopcion               VARCHAR(02)
	 ,RUT_DV                 VARCHAR(02)
	 ,OPERADOR               VARCHAR(15)
	 ,CODIDO_ESTRUCTURA      INT
	 ,DESCRIPCION_ESTRUCTURA VARCHAR(100)
	 ,MONTO_1                NUMERIC
	 ,MONTO_2                NUMERIC
	 ,NUMERO_ESTRUCTURA      INT
	 ,CaVr                   NUMERIC
	 ,CAVRDETML              NUMERIC
	 ,CAPRIMAINICIALDETML    NUMERIC
	 ,TIPO_OPERACION         VARCHAR(01)
	 ,CARTERA                VARCHAR(100) 
	 ,ORIGEN                 VARCHAR(03)
	 ,MODALIDAD              VARCHAR(02)
	 ,FORMAPAGOCOMP          INT)






   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE OPERACIONES VIGENTE                                              */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @OPERACIONES
     SELECT SISTEMA                
	       ,MONEDA_1               
	       ,STR_MONEDA_1           
	       ,MONEDA_2               
	       ,STR_MONEDA_2           
	       ,FOLIO                  
	       ,CONTRATO               
	       ,FECHA_CONTRATO  
		   ,FECHA_VENCIMIENTO       
	       ,CARTERA_FINANCIERA     
	       ,LIBRO                  
	       ,NORMATIVA              
	       ,RUT_CLIENTE            
	       ,CODIGO_CLIENTE         
	       ,NOMBRE_CLIENTE         
           ,PAIS                   
	       ,CNPJ                   
	       ,Clopcion               
	       ,RUT_DV                 
	       ,OPERADOR               
	       ,CODIDO_ESTRUCTURA      
	       ,DESCRIPCION_ESTRUCTURA 
	       ,MONTO_1                
	       ,MONTO_2                
	       ,NUMERO_ESTRUCTURA  
		   ,CaVr    
	       ,CAVRDETML              
	       ,CAPRIMAINICIALDETML  
		   ,TIPO_OPERACION 
		   ,CARTERA 
	       ,ORIGEN
		   ,MODALIDAD   
		   ,FORMAPAGOCOMP               
       FROM REPORTES.DBO.CARTERA_OPCIONES(@FECHA)
	  ORDER BY CONTRATO,NUMERO_ESTRUCTURA DESC


	 


   /*-----------------------------------------------------------------------------*/
   /* CURSOR DE CONTABILIDAD SOLO ARBITRAJES                                      */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_OPERACIONES CURSOR LOCAL FOR
      SELECT CONTRATO
	        ,FECHA_CONTRATO
			,NUMERO_ESTRUCTURA 
        FROM @OPERACIONES
	   ORDER BY CONTRATO ,FECHA_CONTRATO,NUMERO_ESTRUCTURA ASC


       OPEN CURSOR_OPERACIONES
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION ,@OPE_FECHA_CONTRATO , @OPE_NUMERO_ESTRUCTURA



   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN


	      


          /*----------------------------------------------------------------------*/
          /* INFORMACION DE OPERACIONES                                           */
          /*----------------------------------------------------------------------*/
  		    SELECT @MONEDA_1               = MONEDA_1
	              ,@STR_MONEDA_1           = STR_MONEDA_1 
	              ,@MONEDA_2               = MONEDA_2
	              ,@STR_MONEDA_2           = STR_MONEDA_2 
	              ,@FOLIO                  = FOLIO
	              ,@CONTRATO               = CONTRATO
	              ,@FECHA_CONTRATO         = FECHA_CONTRATO
				  ,@FECHA_VENCIMIENTO      = FECHA_VENCIMIENTO
	              ,@CARTERA_FINANCIERA     = CARTERA_FINANCIERA
	              ,@LIBRO                  = LIBRO 
	              ,@NORMATIVA              = NORMATIVA 
	              ,@RUT_CLIENTE            = RUT_CLIENTE 
	              ,@CODIGO_CLIENTE         = CODIGO_CLIENTE
	              ,@NOMBRE_CLIENTE         = NOMBRE_CLIENTE
                  ,@PAIS                   = PAIS 
	              ,@CNPJ                   = CNPJ 
	              ,@Clopcion               = Clopcion
	              ,@RUT_DV                 = RUT_DV
	              ,@OPERADOR               = OPERADOR
	              ,@CODIDO_ESTRUCTURA      = CODIDO_ESTRUCTURA 
	              ,@DESCRIPCION_ESTRUCTURA = DESCRIPCION_ESTRUCTURA
	              ,@MONTO_1                = MONTO_1 
	              ,@MONTO_2                = MONTO_2
	              ,@NUMERO_ESTRUCTURA      = NUMERO_ESTRUCTURA
				  ,@CaVr                   = CaVr
	              ,@CAVRDETML              = CAVRDETML
	              ,@CAPRIMAINICIALDETML    = CAPRIMAINICIALDETML
	              ,@ORIGEN                 = ORIGEN  
				  ,@TIPO_OPERACION         = TIPO_OPERACION
				  ,@CARTERA                = CARTERA
				  ,@MODALIDAD              = MODALIDAD
				  ,@FORMAPAGOCOMP          = FORMAPAGOCOMP
		      FROM @OPERACIONES 
		     WHERE CONTRATO          = @OPE_NUMERO_OPERACION
			   AND FECHA_CONTRATO    = @OPE_FECHA_CONTRATO
			   AND NUMERO_ESTRUCTURA = @OPE_NUMERO_ESTRUCTURA






          /*----------------------------------------------------------------------*/
          /* LLENAR INTERFACES                                                    */
          /*----------------------------------------------------------------------*/
		    SELECT @INT_N_DE_DEAL                          = @OPE_NUMERO_OPERACION						
		          ,@INT_RUT_CLIENTE						   = LTRIM(RTRIM(@RUT_CLIENTE)) + '-' + LTRIM(RTRIM(@RUT_DV))
		          ,@INT_NOMBRE_DEL_CLIENTE				   = SUBSTRING(LTRIM(RTRIM(@NOMBRE_CLIENTE)),1,35) 
		          ,@INT_CARTERA							   = @CARTERA    
		          ,@INT_TIPO_DE_INSTRUMENTO				   = @DESCRIPCION_ESTRUCTURA
		          ,@INT_FECHA_INGRESO					   = @FECHA_CONTRATO
		          ,@INT_FECHA_INICIO					   = @FECHA_CONTRATO 
		          ,@INT_FECHA_DE_VENCIMIENTO			   = @FECHA_VENCIMIENTO
		          ,@INT_MONEDA_LEG_ACTIVA				   = @STR_MONEDA_1
		          ,@INT_NOCIONAL_ACTIVO					   = @MONTO_1
		          ,@INT_MONEDA_LEG_PASIVA				   = @STR_MONEDA_2
		          ,@INT_NOCIONAL_PASIVO					   = @MONTO_2
		          ,@INT_TIPO_DE_TASA_ACTIVO				   = 'FLOAT'
		          ,@INT_TIPO_DE_TASA_PASIVO				   = 'FLOAT'
		          ,@INT_TIPO							   = 'N/A'
		          ,@INT_POSICIÓN						   = @TIPO_OPERACION --CASE WHEN @TIPO_OPERACION  = 'V' THEN 'VENTA' WHEN  @TIPO_OPERACION  = 'C' THEN 'COMPRA' ELSE '' END
		          ,@INT_MONEDA_MTM						   = 'CLP'
		          ,@INT_AJUSTE_BID_OFFER				   = '0'
		          ,@INT_AJUSTE_RIESGO_CRED				   = '0'
		          ,@INT_CUENTA_ACTIVO_PASIVO			   = ''
		          ,@INT_NOCIONAL_RECIBO					   = ''
		          ,@INT_NOCIONAL_PAGO					   = ''
		          ,@INT_MODALIDAD_NOCIONALES			   = CASE WHEN @MODALIDAD  = 'E' THEN 'Entrega Física'  WHEN  @MODALIDAD  = 'C' THEN 'Compensación'  ELSE '' END
		          ,@INT_MODALIDAD_INTERESES				   = CASE WHEN @MODALIDAD  = 'E' THEN 'Entrega Física'  WHEN  @MODALIDAD  = 'C' THEN 'Compensación'  ELSE '' END
		          ,@INT_FECHA_LIQUIDACION				   = '1900-01-01'
		          ,@INT_MONEDA_PAGO_1					   = '1900-01-01'
		          ,@INT_LIQUIDACION_NOCIONALES_RECIBIDOS   = 'N/A'
		          ,@INT_LIQUIDACION_INTERESES_RECIBIDOS	   = 'N/A'
		          ,@INT_MONEDA_PAGO_2					   = @STR_MONEDA_2
		          ,@INT_LIQUIDACION_NOCIONALES_PAGADOS	   = 'N/A'
		          ,@INT_LIQUIDACION_INTERESES_PAGADOS	   = 'N/A'
		          ,@INT_LIQUIDACION_NETA_DE_INTERESES	   = 'N/A'
		          ,@INT_TOTAL_NOCIONAL_ACTIVO_RECIBIDOS	   = 'N/A'
		          ,@INT_TOTAL_INTERESES_ACTIVOS_RECIBIDOS  = 'N/A'
		          ,@INT_TOTAL_NOCIONAL_PASIVOS_PAGADOS	   = 'N/A'
		          ,@INT_TOTAL_INTERESES_PASIVOS_PAGADOS	   = 'N/A'
		          ,@INT_REPORTE_CASA_MATRIZ				   = 'DERIVATIVOS'
		          ,@INT_STATUS							   = 'Vigente' 		  
				  ,@INT_MTM_ACTIVO                         = 0
				  ,@INT_MTM_PASIVO                         = 0
				  ,@INT_MTM_TOTAL                          = 0
				  ,@INT_MTM_TOTAL_CLP                      = 0



          /*----------------------------------------------------------------------*/
	      /* CALCULO FECHA DE LIQUIDACION                                         */
		  /*----------------------------------------------------------------------*/
			IF @MODALIDAD ='E' BEGIN

			   SET @INT_MONEDA_PAGO_1 = @STR_MONEDA_1
			   SET @INT_MONEDA_PAGO_2 = @STR_MONEDA_2
			   SET @CODIGO_MONEDA     = @MONEDA_1
			END
			

			IF @MODALIDAD ='C' BEGIN

			   IF @PAIS = 6 BEGIN

			      SET @INT_MONEDA_PAGO_1 = 'CLP'
				  SET @INT_MONEDA_PAGO_2 = ''
				  SET @CODIGO_MONEDA     = 999

			   END
			   ELSE BEGIN

			      SET @INT_MONEDA_PAGO_1 = 'USD'
				  SET @INT_MONEDA_PAGO_2 = ''
				  SET @CODIGO_MONEDA     = 13

			   END
			END

          /*----------------------------------------------------------------------*/
	      /* DIAS VALOR DE FORMA DE PAGO                                          */
		  /*----------------------------------------------------------------------*/
		    SELECT @DIAS_VALOR = diasvalor  
			  FROM BacParamSuda.DBO.FORMA_DE_PAGO WITH(NOLOCK)
			 WHERE CODIGO      = @FORMAPAGOCOMP


            SELECT @INT_FECHA_LIQUIDACION = DBO.Fx_RetornaFechaValuta(@DIAS_VALOR,@CODIGO_MONEDA,@FECHA_VENCIMIENTO)



          /*----------------------------------------------------------------------*/
          /* MTM SEGUN ORIGEN                                                     */
          /*----------------------------------------------------------------------*/
		    IF @ORIGEN = 'SAO' AND @CODIDO_ESTRUCTURA != 8 BEGIN


			   SET @INT_MTM_ACTIVO						   = CASE WHEN @CAVRDETML > 0 THEN @CAVRDETML ELSE 0 END
		       SET @INT_MTM_PASIVO						   = CASE WHEN @CAVRDETML < 0 THEN (@CAVRDETML *-1) ELSE 0 END
		       SET @INT_MONTO_MTM						   = @CAVRDETML
			   SET @INT_MTM_TOTAL						   = @CAVRDETML
		       SET @INT_MTM_TOTAL_CLP					   = @CAVRDETML

			   
			   SELECT @INT_CUENTA_ACTIVO_PASIVO = CUENTA_CONTABLE                
	             FROM REPORTES.DBO.ContabilidadNominalOpcionesSAO(@FECHA,@OPE_NUMERO_OPERACION,'AVR',@OPE_NUMERO_ESTRUCTURA)
			    WHERE CORRELATIVO            = CASE WHEN @INT_MONTO_MTM > 0 THEN 1 ELSE 3 END

			END
			

            IF @ORIGEN = 'SAO' AND @CODIDO_ESTRUCTURA = 8 BEGIN


               SET @INT_MTM_ACTIVO						   = CASE WHEN @CaVr > 0 THEN @CaVr ELSE 0 END
		       SET @INT_MTM_PASIVO						   = CASE WHEN @CaVr < 0 THEN (@CaVr *-1) ELSE 0 END
		       SET @INT_MONTO_MTM						   = @CaVr
			   SET @INT_MTM_TOTAL						   = @CaVr
		       SET @INT_MTM_TOTAL_CLP					   = @CaVr

			   SELECT @INT_CUENTA_ACTIVO_PASIVO = CUENTA_CONTABLE                
	             FROM REPORTES.DBO.ContabilidadDevengoFwdAmer(@FECHA,@OPE_NUMERO_OPERACION,@OPE_NUMERO_ESTRUCTURA)
			    WHERE CORRELATIVO            = CASE WHEN @INT_MONTO_MTM > 0 THEN 1 ELSE 4 END


			END


		    IF @ORIGEN = 'BFW' BEGIN

			   SET @INT_MTM_ACTIVO						   = CASE WHEN @CaVr > 0 THEN @CaVr ELSE 0 END
		       SET @INT_MTM_PASIVO						   = CASE WHEN @CaVr < 0 THEN (@CaVr *-1) ELSE 0 END
		       SET @INT_MONTO_MTM						   = @CaVr
			   SET @INT_MTM_TOTAL						   = @CaVr
		       SET @INT_MTM_TOTAL_CLP					   = @CaVr

			   SELECT @INT_CUENTA_ACTIVO_PASIVO = CUENTA_CONTABLE                
	             FROM REPORTES.DBO.ContabilidadDevengoFwdAmer(@FECHA,@OPE_NUMERO_OPERACION,@OPE_NUMERO_ESTRUCTURA)
			    WHERE CORRELATIVO            = CASE WHEN @INT_MONTO_MTM > 0 THEN 1 ELSE 4 END

			   


			END



          /*----------------------------------------------------------------------*/
          /* ORIGEN DE OPERACION SAO CUENTA CONTABLE                              */
          /*----------------------------------------------------------------------*/
		    IF @ORIGEN = 'SAO' AND @CODIDO_ESTRUCTURA != 8 BEGIN


			     SET @INT_NOCIONAL_PAGO   = ''
 			     SET @INT_NOCIONAL_RECIBO = ''


		      SELECT @INT_NOCIONAL_RECIBO = CUENTA_CONTABLE                
	            FROM REPORTES.DBO.ContabilidadNominalOpcionesSAO(@FECHA,@OPE_NUMERO_OPERACION,'MOV',@OPE_NUMERO_ESTRUCTURA)
			   WHERE CORRELATIVO            = 1


			  SELECT @INT_NOCIONAL_PAGO = CUENTA_CONTABLE                
	            FROM REPORTES.DBO.ContabilidadNominalOpcionesSAO(@FECHA,@OPE_NUMERO_OPERACION,'MOV',@OPE_NUMERO_ESTRUCTURA)
			   WHERE CORRELATIVO            = 3



			END

          /*----------------------------------------------------------------------*/
          /* ORIGEN DE OPERACION SAO CUENTA CONTABLE                              */
          /*----------------------------------------------------------------------*/
		    IF @ORIGEN = 'SAO' AND @CODIDO_ESTRUCTURA = 8 BEGIN


			     SET @INT_NOCIONAL_PAGO   = ''
 			     SET @INT_NOCIONAL_RECIBO = ''

  		      SELECT @INT_NOCIONAL_RECIBO = CUENTA_CONTABLE                
	            FROM REPORTES.DBO.ContabilidadNominalOpcionesBFW(@FECHA,@OPE_NUMERO_OPERACION,@OPE_NUMERO_ESTRUCTURA)
			   WHERE CORRELATIVO            = 3


              SELECT @INT_NOCIONAL_PAGO = CUENTA_CONTABLE                
	            FROM REPORTES.DBO.ContabilidadNominalOpcionesBFW(@FECHA,@OPE_NUMERO_OPERACION,@OPE_NUMERO_ESTRUCTURA)
			   WHERE CORRELATIVO            = 1

				

			END


          /*----------------------------------------------------------------------*/
          /* ORIGEN DE OPERACION SAO CUENTA CONTABLE                              */
          /*----------------------------------------------------------------------*/
		    IF @ORIGEN = 'BFW' BEGIN

			     SET @INT_NOCIONAL_PAGO   = ''
 			     SET @INT_NOCIONAL_RECIBO = ''

  		      SELECT @INT_NOCIONAL_RECIBO = CUENTA_CONTABLE                
	            FROM REPORTES.DBO.ContabilidadNominalOpcionesBFW(@FECHA,@OPE_NUMERO_OPERACION,@OPE_NUMERO_ESTRUCTURA)
			   WHERE CORRELATIVO            = 1


              SELECT @INT_NOCIONAL_PAGO = CUENTA_CONTABLE                
	            FROM REPORTES.DBO.ContabilidadNominalOpcionesBFW(@FECHA,@OPE_NUMERO_OPERACION,@OPE_NUMERO_ESTRUCTURA)
			   WHERE CORRELATIVO            = 3

				  
			     


			END





          /*----------------------------------------------------------------------*/
          /* INGRESO DE REGISTROS                                                 */
          /*----------------------------------------------------------------------*/
		    INSERT INTO @SALIDA 
			(N_DE_DEAL			                , RUT_CLIENTE						
		    ,NOMBRE_DEL_CLIENTE	                , CARTERA							
		    ,TIPO_DE_INSTRUMENTO	            , FECHA_INGRESO						
		    ,FECHA_INICIO				        , FECHA_DE_VENCIMIENTO				
		    ,MONEDA_LEG_ACTIVA			        , NOCIONAL_ACTIVO					
		    ,MONEDA_LEG_PASIVA			        , NOCIONAL_PASIVO					
		    ,TIPO_DE_TASA_ACTIVO		        , TIPO_DE_TASA_PASIVO				
		    ,TIPO						        , POSICIÓN							
		    ,MONEDA_MTM					        , MTM_ACTIVO							
		    ,MTM_PASIVO					        , MONTO_MTM							
		    ,AJUSTE_BID_OFFER			        , AJUSTE_RIESGO_CRED					
		    ,MTM_TOTAL					        , MTM_TOTAL_CLP						
		    ,CUENTA_ACTIVO_PASIVO		        , NOCIONAL_RECIBO					
		    ,NOCIONAL_PAGO				        , MODALIDAD_NOCIONALES				
		    ,MODALIDAD_INTERESES		        , FECHA_LIQUIDACION					
		    ,MONEDA_PAGO_1				        , LIQUIDACION_NOCIONALES_RECIBIDOS	
		    ,LIQUIDACION_INTERESES_RECIBIDOS	, MONEDA_PAGO_2						
		    ,LIQUIDACION_NOCIONALES_PAGADOS		, LIQUIDACION_INTERESES_PAGADOS		
		    ,LIQUIDACION_NETA_DE_INTERESES		, TOTAL_NOCIONAL_ACTIVO_RECIBIDOS	
		    ,TOTAL_INTERESES_ACTIVOS_RECIBIDOS	, TOTAL_NOCIONAL_PASIVOS_PAGADOS		
		    ,TOTAL_INTERESES_PASIVOS_PAGADOS	, REPORTE_CASA_MATRIZ
		    ,STATUS)								
			VALUES
			(@INT_N_DE_DEAL			                , @INT_RUT_CLIENTE						
		    ,@INT_NOMBRE_DEL_CLIENTE	            , @INT_CARTERA							
		    ,@INT_TIPO_DE_INSTRUMENTO	            , @INT_FECHA_INGRESO						
		    ,@INT_FECHA_INICIO				        , @INT_FECHA_DE_VENCIMIENTO				
		    ,@INT_MONEDA_LEG_ACTIVA			        , @INT_NOCIONAL_ACTIVO					
		    ,@INT_MONEDA_LEG_PASIVA			        , @INT_NOCIONAL_PASIVO					
		    ,@INT_TIPO_DE_TASA_ACTIVO		        , @INT_TIPO_DE_TASA_PASIVO				
		    ,@INT_TIPO						        , @INT_POSICIÓN							
		    ,@INT_MONEDA_MTM					    , @INT_MTM_ACTIVO							
		    ,@INT_MTM_PASIVO					    , @INT_MONTO_MTM							
		    ,@INT_AJUSTE_BID_OFFER			        , @INT_AJUSTE_RIESGO_CRED					
		    ,@INT_MTM_TOTAL					        , @INT_MTM_TOTAL_CLP						
		    ,@INT_CUENTA_ACTIVO_PASIVO		        , @INT_NOCIONAL_RECIBO					
		    ,@INT_NOCIONAL_PAGO				        , @INT_MODALIDAD_NOCIONALES				
		    ,@INT_MODALIDAD_INTERESES		        , @INT_FECHA_LIQUIDACION					
		    ,@INT_MONEDA_PAGO_1				        , @INT_LIQUIDACION_NOCIONALES_RECIBIDOS	
		    ,@INT_LIQUIDACION_INTERESES_RECIBIDOS	, @INT_MONEDA_PAGO_2						
		    ,@INT_LIQUIDACION_NOCIONALES_PAGADOS	, @INT_LIQUIDACION_INTERESES_PAGADOS		
		    ,@INT_LIQUIDACION_NETA_DE_INTERESES		, @INT_TOTAL_NOCIONAL_ACTIVO_RECIBIDOS	
		    ,@INT_TOTAL_INTERESES_ACTIVOS_RECIBIDOS	, @INT_TOTAL_NOCIONAL_PASIVOS_PAGADOS		
		    ,@INT_TOTAL_INTERESES_PASIVOS_PAGADOS	, @INT_REPORTE_CASA_MATRIZ
		    ,@INT_STATUS)								
		

     FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION ,@OPE_FECHA_CONTRATO , @OPE_NUMERO_ESTRUCTURA  
     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES


   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
	 SELECT N_DE_DEAL						
		   ,RUT_CLIENTE						
		   ,NOMBRE_DEL_CLIENTE				
		   ,CARTERA							
		   ,TIPO_DE_INSTRUMENTO				
		   ,CONVERT(CHAR(10),FECHA_INGRESO,103) AS FECHA_INGRESO 					
		   ,CONVERT(CHAR(10),FECHA_INICIO,103) AS FECHA_INICIO 										
		   ,CONVERT(CHAR(10),FECHA_DE_VENCIMIENTO,103) AS FECHA_DE_VENCIMIENTO 								
		   ,MONEDA_LEG_ACTIVA				
		   ,NOCIONAL_ACTIVO					
		   ,MONEDA_LEG_PASIVA				
		   ,NOCIONAL_PASIVO					
		   ,TIPO_DE_TASA_ACTIVO				
		   ,TIPO_DE_TASA_PASIVO				
		   ,TIPO							
		   ,POSICIÓN						
		   ,MONEDA_MTM						
		   ,MTM_ACTIVO						
		   ,MTM_PASIVO						
		   ,MONTO_MTM						
		   ,AJUSTE_BID_OFFER				
		   ,AJUSTE_RIESGO_CRED				
		   ,MTM_TOTAL						
		   ,MTM_TOTAL_CLP					
		   ,CUENTA_ACTIVO_PASIVO			
		   ,NOCIONAL_RECIBO					
		   ,NOCIONAL_PAGO					
		   ,MODALIDAD_NOCIONALES			
		   ,MODALIDAD_INTERESES				
		   ,FECHA_LIQUIDACION				
		   ,MONEDA_PAGO_1					
		   ,LIQUIDACION_NOCIONALES_RECIBIDOS
		   ,LIQUIDACION_INTERESES_RECIBIDOS	
		   ,MONEDA_PAGO_2					
		   ,LIQUIDACION_NOCIONALES_PAGADOS	
		   ,LIQUIDACION_INTERESES_PAGADOS	
		   ,LIQUIDACION_NETA_DE_INTERESES	
		   ,TOTAL_NOCIONAL_ACTIVO_RECIBIDOS	
		   ,TOTAL_INTERESES_ACTIVOS_RECIBIDOS
		   ,TOTAL_NOCIONAL_PASIVOS_PAGADOS	
		   ,TOTAL_INTERESES_PASIVOS_PAGADOS	
		   ,REPORTE_CASA_MATRIZ				
		   ,STATUS							
       FROM @SALIDA





END
GO
