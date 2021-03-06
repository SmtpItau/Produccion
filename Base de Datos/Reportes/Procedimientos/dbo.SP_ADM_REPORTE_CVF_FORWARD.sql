USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_CVF_FORWARD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_CVF_FORWARD]    
                      @FECHA DATETIME

AS    
BEGIN    


	SET NOCOUNT ON   

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CONTABILIDAD FORWARD                                        */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     --EXEC Reportes.dbo.SP_ADM_REPORTE_CVF_FORWARD '2015-12-30'
	 
   
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
			,@RUT_DV          VARCHAR(01)



   /*-----------------------------------------------------------------------------*/
   /* GENERACION DE SALIDA                                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	         (NERO_DEAL                        NUMERIC
	         ,RUT_CLIENTE                      VARCHAR(20)
	         ,NOMBRE_CLIENTE                   VARCHAR(150)
	         ,CARTERA                          VARCHAR(20)
	         ,TIPO_INSTRUMENTO                 VARCHAR(20)
	         ,FECHA_INGRESO                    DATETIME
	         ,FECHA_INICIO                     DATETIME
	         ,FECHA_VENCIMIENTO                DATETIME
	         ,MONEDA_LEG_ACTIVA                CHAR(03)
	         ,NOCIONAL_ACTIVO                  NUMERIC
	         ,MONEDA_LEG_PASIVA                CHAR(03)
	         ,NOCIONAL_PASIVO                  NUMERIC
	         ,TIPO_TASA_ACTIVO                 CHAR(10)
	         ,TIPO_TASA_PASIVO                 CHAR(10)
	         ,TIPO                             CHAR(10)
			 ,POSICION                         CHAR(15)
	         ,MONEDA_MTM                       CHAR(03)
	         ,MTM_ACTIVO                       NUMERIC
	         ,MTM_PASIVO                       NUMERIC
			 ,MONTO_MTM                        NUMERIC
			 ,AJUSTE_BID_OFFER                 NUMERIC
			 ,AJUSTE_RIESGO_CRED               NUMERIC
	         ,MTM_TOTAL                        NUMERIC
	         ,MTM_TOTAL_CLP                    NUMERIC
	         ,CUENTA_ACT_PAS                   VARCHAR(20)
	         ,NOCIONAL_RECIBO                  VARCHAR(20)
	         ,NOCIONAL_PAGO                    VARCHAR(20)
	         ,MODALIDAD_NOCIONALES             VARCHAR(30)
	         ,MODALIDAD_INTERES                VARCHAR(30)
	         ,FECHA_LIQUIDACION                DATETIME
	         ,MONEDA_PAGO_1                    VARCHAR(03)
	         ,LIQUIDACION_NOCIONALES_RECIBIDOS NUMERIC
	         ,LIQUIDACION_INTERES_RECIBIDOS    NUMERIC
             ,MONEDA_PAGO_2                    VARCHAR(03)
	         ,LIQUIDACION_NOCIONALES_PAGADOS   NUMERIC
	         ,LIQUIDACION_INTERES_PAGADOS      NUMERIC
	         ,LIQUIDACION_NETA_INTERES         NUMERIC
	         ,TOTAL_NOCIONA_ACTIVO_RECIBIMOS   NUMERIC
	         ,TOTAL_INTERES_ACTIVOS_RECIBIDOS  NUMERIC
	         ,TOTAL_NOCIONAL_PASIVOS_PAGADOS   NUMERIC
	         ,TOTAL_INTERES_PASIVOS_PAGADOS    NUMERIC
	         ,REPORTE_CASA_MATRIZ              VARCHAR(100)
	         ,R_STATUS                         VARCHAR(20))


   /*-----------------------------------------------------------------------------*/
   /* VARIABLES DE INTERFAZ                                                       */
   /*-----------------------------------------------------------------------------*/
      DECLARE @INT_NERO_DEAL                        NUMERIC
	         ,@INT_RUT_CLIENTE                      VARCHAR(20)
	         ,@INT_NOMBRE_CLIENTE                   VARCHAR(150)
	         ,@INT_CARTERA                          VARCHAR(20)
	         ,@INT_TIPO_INSTRUMENTO                 VARCHAR(20)
	         ,@INT_FECHA_INGRESO                    DATETIME
	         ,@INT_FECHA_INICIO                     DATETIME
	         ,@INT_FECHA_VENCIMIENTO                DATETIME
	         ,@INT_MONEDA_LEG_ACTIVA                CHAR(03)
	         ,@INT_NOCIONAL_ACTIVO                  NUMERIC
	         ,@INT_MONEDA_LEG_PASIVA                CHAR(03)
	         ,@INT_NOCIONAL_PASIVO                  NUMERIC
	         ,@INT_TIPO_TASA_ACTIVO                 CHAR(10)
	         ,@INT_TIPO_TASA_PASIVO                 CHAR(10)
	         ,@INT_TIPO                             CHAR(10)
			 ,@INT_POSICION                         CHAR(15)
	         ,@INT_MONEDA_MTM                       CHAR(03)
	         ,@INT_MTM_ACTIVO                       NUMERIC
	         ,@INT_MTM_PASIVO                       NUMERIC
			 ,@INT_MONTO_MTM                        NUMERIC
			 ,@INT_AJUSTE_BID_OFFER                 NUMERIC
			 ,@INT_AJUSTE_RIESGO_CRED               NUMERIC
	         ,@INT_MTM_TOTAL                        NUMERIC
	         ,@INT_MTM_TOTAL_CLP                    NUMERIC
	         ,@INT_CUENTA_ACT_PAS                   VARCHAR(20)
	         ,@INT_NOCIONAL_RECIBO                  VARCHAR(20)
	         ,@INT_NOCIONAL_PAGO                    VARCHAR(20)
	         ,@INT_MODALIDAD_NOCIONALES             VARCHAR(30)
	         ,@INT_MODALIDAD_INTERES                VARCHAR(30)
	         ,@INT_FECHA_LIQUIDACION                DATETIME
	         ,@INT_MONEDA_PAGO_1                    VARCHAR(03)
	         ,@INT_LIQUIDACION_NOCIONALES_RECIBIDOS NUMERIC
	         ,@INT_LIQUIDACION_INTERES_RECIBIDOS    NUMERIC
             ,@INT_MONEDA_PAGO_2                    VARCHAR(03)
	         ,@INT_LIQUIDACION_NOCIONALES_PAGADOS   NUMERIC
	         ,@INT_LIQUIDACION_INTERES_PAGADOS      NUMERIC
	         ,@INT_LIQUIDACION_NETA_INTERES         NUMERIC
	         ,@INT_TOTAL_NOCIONA_ACTIVO_RECIBIMOS   NUMERIC
	         ,@INT_TOTAL_INTERES_ACTIVOS_RECIBIDOS  NUMERIC
	         ,@INT_TOTAL_NOCIONAL_PASIVOS_PAGADOS   NUMERIC
	         ,@INT_TOTAL_INTERES_PASIVOS_PAGADOS    NUMERIC
	         ,@INT_REPORTE_CASA_MATRIZ              VARCHAR(100)
	         ,@INT_R_STATUS                         VARCHAR(20)

   /*-----------------------------------------------------------------------------*/
   /* TABLA OPERACIONES CARTERA                                                   */
   /*-----------------------------------------------------------------------------*/
     DECLARE @OPERACIONES TABLE
	 (OPERACION       NUMERIC
	 ,RUT_CLIENTE     NUMERIC
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
	 ,COD_CARTERA	  VARCHAR(03)			
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
	 ,PRODUCTO        VARCHAR(50)
	 ,RUT_DV          VARCHAR(01))






   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE OPERACIONES VIGENTE                                              */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO @OPERACIONES
     SELECT OPERACION       
	       ,RUT_CLIENTE     
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
		   ,RUT_DV       
       FROM REPORTES.DBO.CARTERA_FORWARD(@FECHA)
	  ORDER BY OPERACION 






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
				  ,@RUT_DV          = RUT_DV
		      FROM @OPERACIONES 
		     WHERE OPERACION        = @OPE_NUMERO_OPERACION


          /*----------------------------------------------------------------------*/
          /* LLENAR INTERFACES                                                    */
          /*----------------------------------------------------------------------*/
		    SELECT @INT_NERO_DEAL                        = @OPE_NUMERO_OPERACION 
	              ,@INT_RUT_CLIENTE                      = LTRIM(RTRIM(CONVERT(CHAR,@RUT_CLIENTE))) + '-' + LTRIM(RTRIM(@RUT_DV))
	              ,@INT_NOMBRE_CLIENTE                   = SUBSTRING(LTRIM(RTRIM(@NOMBRE_CLIENTE)),1,35)
	              ,@INT_CARTERA                          = @CARTERA -- Reportes.dbo.Fx_Convalida_Cartera('ADM',@COD_CARTERA)
	              ,@INT_TIPO_INSTRUMENTO                 = @PRODUCTO --Reportes.dbo.Fx_Convalida_Producto('ADM',@COD_PRODUCTO)
	              ,@INT_FECHA_INGRESO                    = @FECHA_INGRESO
	              ,@INT_FECHA_INICIO                     = @FECHA_INGRESO
	              ,@INT_FECHA_VENCIMIENTO                = @FECHA_VCTO
	              ,@INT_MONEDA_LEG_ACTIVA                = @STR_MONEDA_1
	              ,@INT_NOCIONAL_ACTIVO                  = @MONTO_NOC_1 
	              ,@INT_MONEDA_LEG_PASIVA                = @STR_MONEDA_2
	              ,@INT_NOCIONAL_PASIVO                  = @MONTO_NOC_2 
	              ,@INT_TIPO_TASA_ACTIVO                 = 'FLOAT'
	              ,@INT_TIPO_TASA_PASIVO                 = 'FLOAT'
	              ,@INT_TIPO                             = 'N/A'
			      ,@INT_POSICION                         = CASE WHEN @TIPO_OPERACION  = 'V' THEN 'VENTA' WHEN  @TIPO_OPERACION  = 'C' THEN 'COMPRA' ELSE '' END
	              ,@INT_MONEDA_MTM                       = 'CLP'
	              ,@INT_MTM_ACTIVO                       = @OPE_MTM_ACTIVO 
	              ,@INT_MTM_PASIVO                       = @OPE_MTM_PASIVO 
			      ,@INT_MONTO_MTM                        = @VALOR_RAZONABLE 
			      ,@INT_AJUSTE_BID_OFFER                 = 0 
			      ,@INT_AJUSTE_RIESGO_CRED               = 0 
	              ,@INT_MTM_TOTAL                        = @VALOR_RAZONABLE 
	              ,@INT_MTM_TOTAL_CLP                    = @VALOR_RAZONABLE 
	              ,@INT_CUENTA_ACT_PAS                   = ''
	              ,@INT_NOCIONAL_RECIBO                  = ''
	              ,@INT_NOCIONAL_PAGO                    = ''
	              ,@INT_MODALIDAD_NOCIONALES             = CASE WHEN @MODALIDAD  = 'E' THEN 'Entrega Física'  WHEN  @MODALIDAD  = 'C' THEN 'Compensación'  ELSE '' END
	              ,@INT_MODALIDAD_INTERES                = CASE WHEN @MODALIDAD  = 'E' THEN 'Entrega Física'  WHEN  @MODALIDAD  = 'C' THEN 'Compensación'  ELSE '' END
	              ,@INT_FECHA_LIQUIDACION                = '1900-01-01' 
	              ,@INT_MONEDA_PAGO_1                    = @FECHA_VCTO
	              ,@INT_LIQUIDACION_NOCIONALES_RECIBIDOS = 0 
	              ,@INT_LIQUIDACION_INTERES_RECIBIDOS    = 0 
                  ,@INT_MONEDA_PAGO_2                    = ''
	              ,@INT_LIQUIDACION_NOCIONALES_PAGADOS   = 0 
	              ,@INT_LIQUIDACION_INTERES_PAGADOS      = 0 
	              ,@INT_LIQUIDACION_NETA_INTERES         = 0 
	              ,@INT_TOTAL_NOCIONA_ACTIVO_RECIBIMOS   = 0 
	              ,@INT_TOTAL_INTERES_ACTIVOS_RECIBIDOS  = 0 
	              ,@INT_TOTAL_NOCIONAL_PASIVOS_PAGADOS   = 0 
	              ,@INT_TOTAL_INTERES_PASIVOS_PAGADOS    = 0 
	              ,@INT_REPORTE_CASA_MATRIZ              = 'Reporte Otros Derivativos Digital'
	              ,@INT_R_STATUS                         = 'Vigente'

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

		

                    SET @INT_CUENTA_ACT_PAS = ''
		         SELECT @INT_CUENTA_ACT_PAS = CUENTA_CONTABLE
		           FROM ContabilidadDevengoForward(@FECHA,@OPE_NUMERO_OPERACION)
		          WHERE COD_CAMPO              = 304
		            AND TIPO_MOVIMIENTO_CUENTA ='D'

			 END

		    IF @VALOR_RAZONABLE < 0 BEGIN

			        SET @INT_CUENTA_ACT_PAS = ''
		         SELECT @INT_CUENTA_ACT_PAS = CUENTA_CONTABLE
		           FROM ContabilidadDevengoForward(@FECHA,@OPE_NUMERO_OPERACION)
		          WHERE COD_CAMPO              = 305
		            AND TIPO_MOVIMIENTO_CUENTA ='H'


			 END


          /*----------------------------------------------------------------------*/
	      /* CUENTA CONTABLE DE NOMINALES                                         */
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
          /* INGRESO REGISTROS EN TABLA DE SALIDAS                                */
          /*----------------------------------------------------------------------*/
		    INSERT INTO @SALIDA
			(NERO_DEAL                             ,RUT_CLIENTE                      
	        ,NOMBRE_CLIENTE                        ,CARTERA                          
	        ,TIPO_INSTRUMENTO                      ,FECHA_INGRESO                    
	        ,FECHA_INICIO                          ,FECHA_VENCIMIENTO                
	        ,MONEDA_LEG_ACTIVA                     ,NOCIONAL_ACTIVO                  
	        ,MONEDA_LEG_PASIVA                     ,NOCIONAL_PASIVO                  
	        ,TIPO_TASA_ACTIVO                      ,TIPO_TASA_PASIVO                 
	        ,TIPO                                  ,POSICION                         
	        ,MONEDA_MTM                            ,MTM_ACTIVO                       
	        ,MTM_PASIVO                            ,MONTO_MTM                        
			,AJUSTE_BID_OFFER                      ,AJUSTE_RIESGO_CRED                   
	        ,MTM_TOTAL                             ,MTM_TOTAL_CLP                    
	        ,CUENTA_ACT_PAS                        ,NOCIONAL_RECIBO                  
	        ,NOCIONAL_PAGO                         ,MODALIDAD_NOCIONALES             
	        ,MODALIDAD_INTERES                     ,FECHA_LIQUIDACION                
	        ,MONEDA_PAGO_1                         ,LIQUIDACION_NOCIONALES_RECIBIDOS 
	        ,LIQUIDACION_INTERES_RECIBIDOS         ,MONEDA_PAGO_2                    
	        ,LIQUIDACION_NOCIONALES_PAGADOS        ,LIQUIDACION_INTERES_PAGADOS      
	        ,LIQUIDACION_NETA_INTERES              ,TOTAL_NOCIONA_ACTIVO_RECIBIMOS   
	        ,TOTAL_INTERES_ACTIVOS_RECIBIDOS       ,TOTAL_NOCIONAL_PASIVOS_PAGADOS   
	        ,TOTAL_INTERES_PASIVOS_PAGADOS         ,REPORTE_CASA_MATRIZ              
	        ,R_STATUS )
			VALUES                         
			(@INT_NERO_DEAL                        ,@INT_RUT_CLIENTE                      
	        ,@INT_NOMBRE_CLIENTE                   ,@INT_CARTERA                          
	        ,@INT_TIPO_INSTRUMENTO                 ,@INT_FECHA_INGRESO                    
	        ,@INT_FECHA_INICIO                     ,@INT_FECHA_VENCIMIENTO                
	        ,@INT_MONEDA_LEG_ACTIVA                ,@INT_NOCIONAL_ACTIVO                  
	        ,@INT_MONEDA_LEG_PASIVA                ,@INT_NOCIONAL_PASIVO                  
	        ,@INT_TIPO_TASA_ACTIVO                 ,@INT_TIPO_TASA_PASIVO                 
	        ,@INT_TIPO                             ,@INT_POSICION                         
	        ,@INT_MONEDA_MTM                       ,@INT_MTM_ACTIVO                       
	        ,@INT_MTM_PASIVO                       ,@INT_MONTO_MTM                        
			,@INT_AJUSTE_BID_OFFER                 ,@INT_AJUSTE_RIESGO_CRED                   
	        ,@INT_MTM_TOTAL                        ,@INT_MTM_TOTAL_CLP                    
	        ,@INT_CUENTA_ACT_PAS                   ,@INT_NOCIONAL_RECIBO                  
	        ,@INT_NOCIONAL_PAGO                    ,@INT_MODALIDAD_NOCIONALES             
	        ,@INT_MODALIDAD_INTERES                ,@INT_FECHA_LIQUIDACION                
	        ,@INT_MONEDA_PAGO_1                    ,@INT_LIQUIDACION_NOCIONALES_RECIBIDOS 
	        ,@INT_LIQUIDACION_INTERES_RECIBIDOS    ,@INT_MONEDA_PAGO_2                    
	        ,@INT_LIQUIDACION_NOCIONALES_PAGADOS   ,@INT_LIQUIDACION_INTERES_PAGADOS      
	        ,@INT_LIQUIDACION_NETA_INTERES         ,@INT_TOTAL_NOCIONA_ACTIVO_RECIBIMOS   
	        ,@INT_TOTAL_INTERES_ACTIVOS_RECIBIDOS  ,@INT_TOTAL_NOCIONAL_PASIVOS_PAGADOS   
	        ,@INT_TOTAL_INTERES_PASIVOS_PAGADOS    ,@INT_REPORTE_CASA_MATRIZ              
	        ,@INT_R_STATUS )




     FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION ,@OPE_FECHA_INGRESO 
     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES


   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE REGISTROS                                                         */
   /*-----------------------------------------------------------------------------*/
     SELECT NERO_DEAL                        
	       ,RUT_CLIENTE                      
	       ,NOMBRE_CLIENTE                   
	       ,CARTERA                          
	       ,TIPO_INSTRUMENTO                 
	       ,CONVERT(CHAR(10),FECHA_INGRESO,103)  AS FECHA_INGRESO                   
	       ,CONVERT(CHAR(10),FECHA_INICIO,103)   AS FECHA_INICIO                  
	       ,CONVERT(CHAR(10),FECHA_VENCIMIENTO,103) AS FECHA_VENCIMIENTO               
	       ,MONEDA_LEG_ACTIVA                
	       ,NOCIONAL_ACTIVO                  
	       ,MONEDA_LEG_PASIVA                
	       ,NOCIONAL_PASIVO                  
	       ,TIPO_TASA_ACTIVO                 
	       ,TIPO_TASA_PASIVO                 
	       ,TIPO                             
		   ,POSICION                         
	       ,MONEDA_MTM                       
	       ,MTM_ACTIVO                       
	       ,MTM_PASIVO                       
		   ,MONTO_MTM                        
		   ,AJUSTE_BID_OFFER                 
		   ,AJUSTE_RIESGO_CRED               
	       ,MTM_TOTAL                        
	       ,MTM_TOTAL_CLP                    
	       ,CUENTA_ACT_PAS                   
	       ,NOCIONAL_RECIBO                  
	       ,NOCIONAL_PAGO                    
	       ,MODALIDAD_NOCIONALES             
	       ,MODALIDAD_INTERES                
	       ,CONVERT(CHAR(10),FECHA_LIQUIDACION,105) AS FECHA_LIQUIDACION                
	       ,MONEDA_PAGO_1                    
	       ,LIQUIDACION_NOCIONALES_RECIBIDOS 
	       ,LIQUIDACION_INTERES_RECIBIDOS    
           ,MONEDA_PAGO_2                    
	       ,LIQUIDACION_NOCIONALES_PAGADOS   
	       ,LIQUIDACION_INTERES_PAGADOS      
	       ,LIQUIDACION_NETA_INTERES         
	       ,TOTAL_NOCIONA_ACTIVO_RECIBIMOS   
	       ,TOTAL_INTERES_ACTIVOS_RECIBIDOS  
	       ,TOTAL_NOCIONAL_PASIVOS_PAGADOS   
	       ,TOTAL_INTERES_PASIVOS_PAGADOS    
	       ,REPORTE_CASA_MATRIZ              
	       ,R_STATUS                         
	  FROM @SALIDA	 

END
GO
