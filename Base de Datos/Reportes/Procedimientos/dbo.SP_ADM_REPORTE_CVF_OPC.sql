USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_CVF_OPC]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_CVF_OPC]    
                      @FECHA DATETIME

AS    
BEGIN    


    
	SET NOCOUNT ON   

  /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CONTABILIDAD OPCIONES                                       */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     --EXEC Reportes.dbo.SP_ADM_REPORTE_CVF_OPC '2015-12-30'
	 
   
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



   /*-----------------------------------------------------------------------------*/
   /* GENERACION DE SALIDA                                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	         (NERO_DEAL                        NUMERIC
	         ,RUT_CLIENTE                      NUMERIC
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
	         ,@INT_RUT_CLIENTE                      NUMERIC
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
	 ,ORIGEN                 VARCHAR(03))






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
		      FROM @OPERACIONES 
		     WHERE CONTRATO          = @OPE_NUMERO_OPERACION
			   AND FECHA_CONTRATO    = @OPE_FECHA_CONTRATO
			   AND NUMERO_ESTRUCTURA = @OPE_NUMERO_ESTRUCTURA


          /*----------------------------------------------------------------------*/
          /* LLENAR INTERFACES                                                    */
          /*----------------------------------------------------------------------*/
		    SELECT @INT_NERO_DEAL                        = @OPE_NUMERO_OPERACION 
	              ,@INT_RUT_CLIENTE                      = @RUT_CLIENTE 
	              ,@INT_NOMBRE_CLIENTE                   = @NOMBRE_CLIENTE
	              ,@INT_CARTERA                          = @CARTERA 
	              ,@INT_TIPO_INSTRUMENTO                 = @DESCRIPCION_ESTRUCTURA
	              ,@INT_FECHA_INGRESO                    = @FECHA_CONTRATO
	              ,@INT_FECHA_INICIO                     = @FECHA_CONTRATO
	              ,@INT_FECHA_VENCIMIENTO                = @FECHA_VENCIMIENTO
	              ,@INT_MONEDA_LEG_ACTIVA                = @STR_MONEDA_1
	              ,@INT_NOCIONAL_ACTIVO                  = @MONTO_1 
	              ,@INT_MONEDA_LEG_PASIVA                = @STR_MONEDA_2
	              ,@INT_NOCIONAL_PASIVO                  = @MONTO_2 
	              ,@INT_TIPO_TASA_ACTIVO                 = 'FLOAT'
	              ,@INT_TIPO_TASA_PASIVO                 = 'FLOAT'
	              ,@INT_TIPO                             = 'N/A'
			      ,@INT_POSICION                         = CASE WHEN @TIPO_OPERACION  = 'V' THEN 'VENTA' WHEN  @TIPO_OPERACION  = 'C' THEN 'COMPRA' ELSE '' END
	              ,@INT_MONEDA_MTM                       = 'CLP'
	              ,@INT_MTM_ACTIVO                       = 0 
	              ,@INT_MTM_PASIVO                       = 0 
			      ,@INT_MONTO_MTM                        = 0 
			      ,@INT_AJUSTE_BID_OFFER                 = 0 
			      ,@INT_AJUSTE_RIESGO_CRED               = 0 
	              ,@INT_MTM_TOTAL                        = 0 
	              ,@INT_MTM_TOTAL_CLP                    = 0 
	              ,@INT_CUENTA_ACT_PAS                   = ''
	              ,@INT_NOCIONAL_RECIBO                  = ''
	              ,@INT_NOCIONAL_PAGO                    = ''
	              ,@INT_MODALIDAD_NOCIONALES             = ''--CASE WHEN @MODALIDAD  = 'E' THEN 'Entrega Física'  WHEN  @MODALIDAD  = 'C' THEN 'Compensación'  ELSE '' END
	              ,@INT_MODALIDAD_INTERES                = ''--CASE WHEN @MODALIDAD  = 'E' THEN 'Entrega Física'  WHEN  @MODALIDAD  = 'C' THEN 'Compensación'  ELSE '' END
	              ,@INT_FECHA_LIQUIDACION                = '1900-01-01' 
	              ,@INT_MONEDA_PAGO_1                    = @FECHA_VENCIMIENTO
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
          /* MTM SEGUN ORIGEN                                                     */
          /*----------------------------------------------------------------------*/
		    IF @ORIGEN = 'SAO' BEGIN


			   SET @INT_MTM_ACTIVO						   = CASE WHEN @CAVRDETML > 0 THEN @CAVRDETML ELSE 0 END
		       SET @INT_MTM_PASIVO						   = CASE WHEN @CAVRDETML < 0 THEN (@CAVRDETML *-1) ELSE 0 END
		       SET @INT_MONTO_MTM						   = @CAVRDETML
			   SET @INT_MTM_TOTAL						   = @CAVRDETML
		       SET @INT_MTM_TOTAL_CLP					   = @CAVRDETML

			   
			   SELECT @INT_CUENTA_ACT_PAS = CUENTA_CONTABLE                
	             FROM REPORTES.DBO.ContabilidadNominalOpcionesSAO(@FECHA,@OPE_NUMERO_OPERACION,'AVR',@OPE_NUMERO_ESTRUCTURA)
			    WHERE CORRELATIVO            = CASE WHEN @INT_MONTO_MTM > 0 THEN 1 ELSE 3 END

			END

		    IF @ORIGEN = 'BFW' BEGIN

			   SET @INT_MTM_ACTIVO						   = CASE WHEN @CaVr > 0 THEN @CaVr ELSE 0 END
		       SET @INT_MTM_PASIVO						   = CASE WHEN @CaVr < 0 THEN (@CaVr *-1) ELSE 0 END
		       SET @INT_MONTO_MTM						   = @CaVr
			   SET @INT_MTM_TOTAL						   = @CaVr
		       SET @INT_MTM_TOTAL_CLP					   = @CaVr

			   SELECT @INT_CUENTA_ACT_PAS = CUENTA_CONTABLE                
	             FROM REPORTES.DBO.ContabilidadDevengoFwdAmer(@FECHA,@OPE_NUMERO_OPERACION,@OPE_NUMERO_ESTRUCTURA)
			    WHERE CORRELATIVO            = CASE WHEN @INT_MONTO_MTM > 0 THEN 1 ELSE 3 END

			   


			END



          /*----------------------------------------------------------------------*/
          /* ORIGEN DE OPERACION SAO CUENTA CONTABLE                              */
          /*----------------------------------------------------------------------*/
		    IF @ORIGEN = 'SAO' BEGIN

			   IF @TIPO_OPERACION = 'C' BEGIN

			      SET @INT_NOCIONAL_PAGO   = ''
 			      SET @INT_NOCIONAL_RECIBO = ''

			      SELECT @INT_NOCIONAL_RECIBO = CUENTA_CONTABLE                
	                FROM REPORTES.DBO.ContabilidadNominalOpcionesSAO(@FECHA,@OPE_NUMERO_OPERACION,'MOV',@OPE_NUMERO_ESTRUCTURA)
			       WHERE CORRELATIVO            = 1

			      SET @INT_REPORTE_CASA_MATRIZ = (SELECT CATEGORIA 
			                                        FROM REPORTES.DBO.CODIGOS_COSIF(@INT_NOCIONAL_RECIBO))



			   END

			   IF @TIPO_OPERACION = 'V' BEGIN
			     SET @INT_NOCIONAL_PAGO   = ''
			     SET @INT_NOCIONAL_RECIBO = ''

			     SELECT @INT_NOCIONAL_PAGO = CUENTA_CONTABLE                
	               FROM REPORTES.DBO.ContabilidadNominalOpcionesSAO(@FECHA,@OPE_NUMERO_OPERACION,'MOV',@OPE_NUMERO_ESTRUCTURA)
			      WHERE CORRELATIVO            = 3

			      SET @INT_REPORTE_CASA_MATRIZ = (SELECT CATEGORIA 
			                                        FROM REPORTES.DBO.CODIGOS_COSIF(@INT_NOCIONAL_PAGO))

			   END



			END

          /*----------------------------------------------------------------------*/
          /* ORIGEN DE OPERACION SAO CUENTA CONTABLE                              */
          /*----------------------------------------------------------------------*/
		    IF @ORIGEN = 'BFW' BEGIN



			   IF @TIPO_OPERACION = 'C' BEGIN

			      SET @INT_NOCIONAL_PAGO   = ''
 			      SET @INT_NOCIONAL_RECIBO = ''

			     SELECT @INT_NOCIONAL_RECIBO = CUENTA_CONTABLE                
	               FROM REPORTES.DBO.ContabilidadNominalOpcionesBFW(@FECHA,@OPE_NUMERO_OPERACION,@OPE_NUMERO_ESTRUCTURA)
			      WHERE CORRELATIVO            = 1

				  
			      SET @INT_REPORTE_CASA_MATRIZ = (SELECT CATEGORIA 
			                                        FROM REPORTES.DBO.CODIGOS_COSIF(@INT_NOCIONAL_RECIBO))

			   END

			   IF @TIPO_OPERACION = 'V' BEGIN
			     SET @INT_NOCIONAL_PAGO   = ''
			     SET @INT_NOCIONAL_RECIBO = ''

			     SELECT @INT_NOCIONAL_PAGO = CUENTA_CONTABLE                
	               FROM REPORTES.DBO.ContabilidadNominalOpcionesBFW(@FECHA,@OPE_NUMERO_OPERACION,@OPE_NUMERO_ESTRUCTURA)
			      WHERE CORRELATIVO            = 3


			      SET @INT_REPORTE_CASA_MATRIZ = (SELECT CATEGORIA 
			                                        FROM REPORTES.DBO.CODIGOS_COSIF(@INT_NOCIONAL_PAGO))


			   END


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




     FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION ,@OPE_FECHA_CONTRATO , @OPE_NUMERO_ESTRUCTURA  
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
	       ,CONVERT(CHAR(10),FECHA_INGRESO,105)  AS FECHA_INGRESO                   
	       ,CONVERT(CHAR(10),FECHA_INICIO,105)   AS FECHA_INICIO                  
	       ,CONVERT(CHAR(10),FECHA_VENCIMIENTO,105) AS FECHA_VENCIMIENTO               
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
