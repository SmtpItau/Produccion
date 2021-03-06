USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_CARTERA_VIGENTE_FWD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_CARTERA_VIGENTE_FWD]    
                      @FECHA DATETIME

AS    
BEGIN    


    
	SET NOCOUNT ON   

	 
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CONTABILIDAD FORWARD                                        */
   /* AUTOR         : ROBERTO MORA DROGUETT / RODRIGO SILVA RAMIREZ               */
   /* FECHA CRACION : 07/01/2016 / 23-01-2015                                     */
   /*-----------------------------------------------------------------------------*/


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DE CURSOR                                          */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPE_NUMERO_OPERACION    NUMERIC
			,@OPE_FECHA_INGRESO       DATETIME


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPERACION       NUMERIC
	        ,@RUT_CLIENTE     NUMERIC
			,@RUT_DV          VARCHAR(02)
	        ,@COD_CLIENTE     NUMERIC
	        ,@COD_PRODUCTO    INT			
	        ,@COD_MONEDA_1    INT
	        ,@COD_MONEDA_2    INT
	        ,@MONTO_NOC_1     numeric(25,4)
	        ,@MONTO_NOC_2	  numeric(25,4)
	        ,@TIPO_OPERACION  CHAR(01)
	        ,@FECHA_INGRESO   DATETIME	
	        ,@FECHA_VCTO      DATETIME
	        ,@VALOR_RAZONABLE FLOAT
	        ,@TIPO_OPE_TRAN_1 CHAR(01)		
	        ,@TIPO_OPE_TRAN_2 CHAR(01)		
	        ,@COD_CARTERA	  VARCHAR(02)			
	        ,@OPE_MTM_ACTIVO  FLOAT
	        ,@OPE_MTM_PASIVO  FLOAT
	        ,@MODALIDAD		  CHAR(01)
			,@STR_MONEDA_1    VARCHAR(03)
			,@STR_MONEDA_2    VARCHAR(03)
			,@NOMBRE_CLIENTE  VARCHAR(150)
			,@MONPAGOMN       INT
	        ,@MONPAGOMX       INT
			,@PAIS            INT
			,@CODIGO_MONEDA   INT
			,@DIAS_VALOR      INT
			,@CAFECHASTARTING DATETIME
			,@CARTERA         VARCHAR(50)
			,@PRODUCTO        VARCHAR(50)


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
	 (OPERACION       NUMERIC
	 ,RUT_CLIENTE     NUMERIC
	 ,RUT_DV          CHAR(02)
	 ,COD_CLIENTE     NUMERIC
	 ,COD_PRODUCTO    INT			
	 ,COD_MONEDA_1    INT
	 ,COD_MONEDA_2    INT
	 ,MONTO_NOC_1     numeric(25,4)
	 ,MONTO_NOC_2	  numeric(25,4)
	 ,TIPO_OPERACION  CHAR(01)
	 ,FECHA_INGRESO   DATETIME	
	 ,FECHA_VCTO      DATETIME
	 ,VALOR_RAZONABLE FLOAT
	 ,TIPO_OPE_TRAN_1 CHAR(01)		
	 ,TIPO_OPE_TRAN_2 CHAR(01)		
	 ,COD_CARTERA	  VARCHAR(02)			
	 ,OPE_MTM_ACTIVO  FLOAT
	 ,OPE_MTM_PASIVO  FLOAT
	 ,MODALIDAD		  CHAR(01)
	 ,MONPAGOMN       INT
	 ,MONPAGOMX       INT
	 ,CAFECHASTARTING DATETIME
	 ,NOMBRE_CLIENTE  VARCHAR(150)
	 ,STR_MONEDA_1    VARCHAR(03)
	 ,STR_MONEDA_2    VARCHAR(03)
	 ,PAIS            INT
	 ,CARTERA         VARCHAR(50)
	 ,PRODUCTO        VARCHAR(50))






   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE OPERACIONES VIGENTE                                              */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @OPERACIONES
     SELECT OPERACION       
	       ,RUT_CLIENTE 
		   ,RUT_DV    
	       ,COD_CLIENTE     
	       ,COD_PRODUCTO    
	       ,COD_MONEDA_1    
	       ,COD_MONEDA_2    
	       ,MONTO_NOC_1     
	       ,MONTO_NOC_2	  
	       ,TIPO_OPERACION  
	       ,FECHA_INGRESO   
	       ,FECHA_VCTO      
	       ,VALOR_RAZONABLE 
	       ,TIPO_OPE_TRAN_1 
	       ,TIPO_OPE_TRAN_2 
	       ,COD_CARTERA	  
	       ,OPE_MTM_ACTIVO  
	       ,OPE_MTM_PASIVO  
	       ,MODALIDAD		
	       ,MONPAGOMN       
	       ,MONPAGOMX       
	       ,CAFECHASTARTING 
	       ,NOMBRE_CLIENTE  
	       ,STR_MONEDA_1    
	       ,STR_MONEDA_2    
	       ,PAIS            
	       ,CARTERA         
	       ,PRODUCTO        
       FROM REPORTES.DBO.CARTERA_FORWARD(@FECHA)
	  WHERE RUT_CLIENTE != 76317889
	  ORDER BY OPERACION DESC


	 


   /*-----------------------------------------------------------------------------*/
   /* CURSOR DE CONTABILIDAD SOLO ARBITRAJES                                      */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_OPERACIONES CURSOR LOCAL FOR
      SELECT DISTINCT 
	         OPERACION
	        ,FECHA_INGRESO 
        FROM @OPERACIONES
	   ORDER BY OPERACION ASC


       OPEN CURSOR_OPERACIONES
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION ,@OPE_FECHA_INGRESO 


   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN


	      


          /*----------------------------------------------------------------------*/
          /* INFORMACION DE OPERACIONES                                           */
          /*----------------------------------------------------------------------*/
  		    SELECT @OPERACION       = OPERACION 
	              ,@RUT_CLIENTE     = RUT_CLIENTE
				  ,@RUT_DV          = RUT_DV
	              ,@COD_CLIENTE     = COD_CLIENTE 
	              ,@COD_PRODUCTO    = COD_PRODUCTO
	              ,@COD_MONEDA_1    = COD_MONEDA_1
	              ,@COD_MONEDA_2    = COD_MONEDA_2
	              ,@MONTO_NOC_1     = MONTO_NOC_1
	              ,@MONTO_NOC_2	    = MONTO_NOC_2
	              ,@TIPO_OPERACION  = TIPO_OPERACION
	              ,@FECHA_INGRESO   = FECHA_INGRESO
	              ,@FECHA_VCTO      = FECHA_VCTO
	              ,@VALOR_RAZONABLE = VALOR_RAZONABLE
	              ,@TIPO_OPE_TRAN_1 = TIPO_OPE_TRAN_1
	              ,@TIPO_OPE_TRAN_2 = TIPO_OPE_TRAN_2
	              ,@COD_CARTERA	    = COD_CARTERA
	              ,@OPE_MTM_ACTIVO  = OPE_MTM_ACTIVO
	              ,@OPE_MTM_PASIVO  = OPE_MTM_PASIVO
	              ,@MODALIDAD		= MODALIDAD
				  ,@STR_MONEDA_1    = STR_MONEDA_1  
			      ,@STR_MONEDA_2    = STR_MONEDA_2
			      ,@NOMBRE_CLIENTE  = NOMBRE_CLIENTE
				  ,@MONPAGOMN       = MONPAGOMN       
				  ,@MONPAGOMX       = MONPAGOMX
				  ,@PAIS            = PAIS
				  ,@CAFECHASTARTING = CAFECHASTARTING
				  ,@CARTERA         = CARTERA
				  ,@PRODUCTO        = PRODUCTO
		      FROM @OPERACIONES 
		     WHERE OPERACION        = @OPE_NUMERO_OPERACION


          /*----------------------------------------------------------------------*/
          /* LLENAR INTERFACES                                                    */
          /*----------------------------------------------------------------------*/
		    SELECT @INT_N_DE_DEAL                          = @OPE_NUMERO_OPERACION						
		          ,@INT_RUT_CLIENTE						   = LTRIM(RTRIM(@RUT_CLIENTE)) + '-' + LTRIM(RTRIM(@RUT_DV))
		          ,@INT_NOMBRE_DEL_CLIENTE				   = @NOMBRE_CLIENTE 
		          ,@INT_CARTERA							   = @CARTERA    --Reportes.dbo.Fx_Convalida_Cartera('ADM',@COD_CARTERA)
		          ,@INT_TIPO_DE_INSTRUMENTO				   = CASE WHEN @COD_PRODUCTO IN(14,15) THEN 'Seguro de cambio' ELSE @PRODUCTO  END
		          ,@INT_FECHA_INGRESO					   = @FECHA_INGRESO
		          ,@INT_FECHA_INICIO					   = @FECHA_INGRESO 
		          ,@INT_FECHA_DE_VENCIMIENTO			   = @FECHA_VCTO
		          ,@INT_MONEDA_LEG_ACTIVA				   = @STR_MONEDA_1
		          ,@INT_NOCIONAL_ACTIVO					   = @MONTO_NOC_1
		          ,@INT_MONEDA_LEG_PASIVA				   = @STR_MONEDA_2
		          ,@INT_NOCIONAL_PASIVO					   = @MONTO_NOC_2
		          ,@INT_TIPO_DE_TASA_ACTIVO				   = 'FLOAT'
		          ,@INT_TIPO_DE_TASA_PASIVO				   = 'FLOAT'
		          ,@INT_TIPO							   = 'N/A'
		          ,@INT_POSICIÓN						   = CASE WHEN @TIPO_OPERACION  = 'V' THEN 'VENTA' WHEN  @TIPO_OPERACION  = 'C' THEN 'COMPRA' ELSE '' END
		          ,@INT_MONEDA_MTM						   = 'CLP'
		          ,@INT_MTM_ACTIVO						   = @OPE_MTM_ACTIVO
		          ,@INT_MTM_PASIVO						   = @OPE_MTM_PASIVO
		          ,@INT_MONTO_MTM						   = @VALOR_RAZONABLE
		          ,@INT_AJUSTE_BID_OFFER				   = '0'
		          ,@INT_AJUSTE_RIESGO_CRED				   = '0'
		          ,@INT_MTM_TOTAL						   = @VALOR_RAZONABLE
		          ,@INT_MTM_TOTAL_CLP					   = @VALOR_RAZONABLE
		          ,@INT_CUENTA_ACTIVO_PASIVO			   = ''
		          ,@INT_NOCIONAL_RECIBO					   = ''
		          ,@INT_NOCIONAL_PAGO					   = ''
		          ,@INT_MODALIDAD_NOCIONALES			   = CASE WHEN @MODALIDAD  = 'E' THEN 'Entrega Física'  WHEN  @MODALIDAD  = 'C' THEN 'Compensación'  ELSE '' END
		          ,@INT_MODALIDAD_INTERESES				   = CASE WHEN @MODALIDAD  = 'E' THEN 'Entrega Física'  WHEN  @MODALIDAD  = 'C' THEN 'Compensación'  ELSE '' END
		          ,@INT_FECHA_LIQUIDACION				   = @FECHA_VCTO
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
		          ,@INT_REPORTE_CASA_MATRIZ				   = 'Reporte Otros Derivativos Digital'
		          ,@INT_STATUS							   = 'Vigente' 


          /*----------------------------------------------------------------------*/
	      /* CONDICION FECHA DE INICIO                                            */
		  /*----------------------------------------------------------------------*/
		    IF @COD_PRODUCTO = 14 BEGIN 
		       SET @INT_FECHA_INICIO = @CAFECHASTARTING
			END
			ELSE BEGIN
			   SET @INT_FECHA_INICIO = @FECHA_INGRESO
			END


          /*----------------------------------------------------------------------*/
	      /* CALCULO FECHA DE LIQUIDACION                                         */
		  /*----------------------------------------------------------------------*/
			IF @MODALIDAD ='E' BEGIN

			   SET @INT_MONEDA_PAGO_1 = @STR_MONEDA_1
			   SET @INT_MONEDA_PAGO_2 = @STR_MONEDA_2
			   SET @CODIGO_MONEDA     = @COD_MONEDA_1
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
			 WHERE CODIGO      = @MONPAGOMN


            SELECT @INT_FECHA_LIQUIDACION = DBO.Fx_RetornaFechaValuta(@DIAS_VALOR,@CODIGO_MONEDA,@FECHA_VCTO)


		

          /*----------------------------------------------------------------------*/
	      /* CUENTA CONTABLE DE DEVENGO                                           */
		  /*----------------------------------------------------------------------*/
		    IF @VALOR_RAZONABLE > 0 BEGIN

		

                    SET @INT_CUENTA_ACTIVO_PASIVO = ''
		         SELECT @INT_CUENTA_ACTIVO_PASIVO = CUENTA_CONTABLE
		           FROM ContabilidadDevengoForward(@FECHA,@OPE_NUMERO_OPERACION)
		          WHERE COD_CAMPO              = 304
		            AND TIPO_MOVIMIENTO_CUENTA ='D'

			 END

		    IF @VALOR_RAZONABLE < 0 BEGIN

			        SET @INT_CUENTA_ACTIVO_PASIVO = ''
		         SELECT @INT_CUENTA_ACTIVO_PASIVO = CUENTA_CONTABLE
		           FROM ContabilidadDevengoForward(@FECHA,@OPE_NUMERO_OPERACION)
		          WHERE COD_CAMPO              = 305
		            AND TIPO_MOVIMIENTO_CUENTA ='H'


			 END


			  


			
          /*----------------------------------------------------------------------*/
          /* COMPRA                                                               */
          /*----------------------------------------------------------------------*/
			IF @TIPO_OPERACION = 'C' BEGIN

			  SET @INT_NOCIONAL_PAGO   = ''
			  SET @INT_NOCIONAL_RECIBO = ''

			  SELECT @INT_NOCIONAL_RECIBO = CUENTA_CONTABLE                
	            FROM REPORTES.DBO.ContabilidadNominalForward(@OPE_FECHA_INGRESO,@OPE_NUMERO_OPERACION)
			   WHERE CORRELATIVO            = 1

			   SET @INT_REPORTE_CASA_MATRIZ = (SELECT CATEGORIA 
			                                    FROM REPORTES.DBO.CODIGOS_COSIF(@INT_NOCIONAL_RECIBO))


			END
          /*----------------------------------------------------------------------*/
          /* FIN COMPRA                                                           */
          /*----------------------------------------------------------------------*/


          /*----------------------------------------------------------------------*/
          /* VENTA                                                                */
          /*----------------------------------------------------------------------*/
			IF @TIPO_OPERACION = 'V' BEGIN

			  SET @INT_NOCIONAL_PAGO   = ''
			  SET @INT_NOCIONAL_RECIBO = ''

			  SELECT @INT_NOCIONAL_PAGO = CUENTA_CONTABLE                
	            FROM REPORTES.DBO.ContabilidadNominalForward(@OPE_FECHA_INGRESO,@OPE_NUMERO_OPERACION)
			   WHERE CORRELATIVO            = 1

              SET @INT_REPORTE_CASA_MATRIZ = (SELECT CATEGORIA 
			                                    FROM REPORTES.DBO.CODIGOS_COSIF(@INT_NOCIONAL_PAGO))


			END

          /*----------------------------------------------------------------------*/
          /* FIN VENTA                                                            */
          /*----------------------------------------------------------------------*/



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
		

     FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION ,@OPE_FECHA_INGRESO 
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
		   ,CONVERT(CHAR(10),FECHA_INGRESO,105) AS FECHA_INGRESO 					
		   ,CONVERT(CHAR(10),FECHA_INICIO,105) AS FECHA_INICIO 										
		   ,CONVERT(CHAR(10),FECHA_DE_VENCIMIENTO,105) AS FECHA_DE_VENCIMIENTO 								
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
