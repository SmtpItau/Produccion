USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_ITAU_OTROS_DER_DIGITAL_OPC]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_ITAU_OTROS_DER_DIGITAL_OPC]    
                      @FECHA DATETIME

AS    
BEGIN    


    
	SET NOCOUNT ON   

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : INTERFACES OPCIONES                                         */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     --EXEC Reportes.dbo.SP_ADM_REPORTE_ITAU_OTROS_DER_DIGITAL_OPC '2015-12-30'
	 
   
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
	    (Fecha_Referencia         DATETIME
        ,Codigo_Origen            VARCHAR(10)
        ,Numero_Contrato_Modelo   NUMERIC
        ,Numero_Contrato_Interno  NUMERIC
        ,Codigo_Operacion         VARCHAR(20)
        ,Codigo_Empresa_SINC      VARCHAR(10)
        ,Codigo_Mercado           VARCHAR(05)
        ,Mercancia                VARCHAR(10)
        ,Tipo_Opcion              VARCHAR(10)
        ,Posicion                 VARCHAR(01)
        ,Fecha_Vencimiento        DATETIME
        ,Fecha_Operacion          DATETIME
        ,cliente                  VARCHAR(150)
        ,CNPJ                     VARCHAR(20)
        ,Codigo_Cliente_SINC      VARCHAR(05)
        ,Tipo_Cliente             VARCHAR(02)
        ,Valor_Base_Actual        NUMERIC
        ,Valor_Costo              NUMERIC
        ,Valor_Mercado            NUMERIC
        ,PDT                      NUMERIC
        ,PVT                      NUMERIC 
        ,Cosif_Costo              VARCHAR(20)
        ,Cosif_Ger_Costo          VARCHAR(10)
        ,Cuenta_Cosif_Notnl       VARCHAR(20)
        ,Cuenta_SINC_Costo        VARCHAR(20)
        ,Cosif_Compensacion       VARCHAR(20)
        ,Cosif_Ger_Compensacion   VARCHAR(20)
        ,Cuenta_SINC_Compensacion VARCHAR(20)
        ,Resultado_Apropiado_Ano  VARCHAR(20)
        ,MTM_Apropiado_Ano        NUMERIC
        ,Riesgo_Potencial         NUMERIC
        ,Moneda_Origen            VARCHAR(03)
        ,Observacion              VARCHAR(100)
        ,Info_Adicional           VARCHAR(100))


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DE INTERFAZ                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @INT_Fecha_Referencia         DATETIME
            ,@INT_Codigo_Origen            VARCHAR(10)
            ,@INT_Numero_Contrato_Modelo   NUMERIC
            ,@INT_Numero_Contrato_Interno  NUMERIC
            ,@INT_Codigo_Operacion         VARCHAR(20)
            ,@INT_Codigo_Empresa_SINC      VARCHAR(10)
            ,@INT_Codigo_Mercado           VARCHAR(05)
            ,@INT_Mercancia                VARCHAR(10)
            ,@INT_Tipo_Opcion              VARCHAR(10)
            ,@INT_Posicion                 VARCHAR(01)
            ,@INT_Fecha_Vencimiento        DATETIME
            ,@INT_Fecha_Operacion          DATETIME
            ,@INT_cliente                  VARCHAR(150)
            ,@INT_CNPJ                     VARCHAR(20)
            ,@INT_Codigo_Cliente_SINC      VARCHAR(05)
            ,@INT_Tipo_Cliente             VARCHAR(02)
            ,@INT_Valor_Base_Actual        NUMERIC
            ,@INT_Valor_Costo              NUMERIC
            ,@INT_Valor_Mercado            NUMERIC
            ,@INT_PDT                      NUMERIC
            ,@INT_PVT                      NUMERIC 
            ,@INT_Cosif_Costo              VARCHAR(20)
            ,@INT_Cosif_Ger_Costo          VARCHAR(10)
            ,@INT_Cuenta_Cosif_Notnl       VARCHAR(20)
            ,@INT_Cuenta_SINC_Costo        VARCHAR(20)
            ,@INT_Cosif_Compensacion       VARCHAR(20)
            ,@INT_Cosif_Ger_Compensacion   VARCHAR(20)
            ,@INT_Cuenta_SINC_Compensacion VARCHAR(20)
            ,@INT_Resultado_Apropiado_Ano  VARCHAR(20)
            ,@INT_MTM_Apropiado_Ano        NUMERIC
            ,@INT_Riesgo_Potencial         NUMERIC
            ,@INT_Moneda_Origen            VARCHAR(03)
            ,@INT_Observacion              VARCHAR(100)
            ,@INT_Info_Adicional           VARCHAR(100)



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
		    SELECT @INT_Fecha_Referencia         = @FECHA
                  ,@INT_Codigo_Origen            = 'IC769' 
                  ,@INT_Numero_Contrato_Modelo   = 0 
                  ,@INT_Numero_Contrato_Interno  = @OPE_NUMERO_OPERACION 
                  ,@INT_Codigo_Operacion         = 'Opciones'
                  ,@INT_Codigo_Empresa_SINC      = '0769'
                  ,@INT_Codigo_Mercado           = 'OPC'
                  ,@INT_Mercancia                =  LTRIM(RTRIM(@STR_MONEDA_1)) +'/' + LTRIM(RTRIM(@STR_MONEDA_2))
                  ,@INT_Tipo_Opcion              = ''
                  ,@INT_Posicion                 = @TIPO_OPERACION
                  ,@INT_Fecha_Vencimiento        = @FECHA_VENCIMIENTO
                  ,@INT_Fecha_Operacion          = @FECHA_CONTRATO
                  ,@INT_cliente                  = SUBSTRING(LTRIM(RTRIM(@NOMBRE_CLIENTE)),1,35)
                  ,@INT_CNPJ                     = @CNPJ
                  ,@INT_Codigo_Cliente_SINC      = ''
                  ,@INT_Tipo_Cliente             = @Clopcion
                  ,@INT_Valor_Base_Actual        = 0 
                  ,@INT_Valor_Costo              = 0 
                  ,@INT_Valor_Mercado            = 0 
                  ,@INT_PDT                      = 0 
                  ,@INT_PVT                      = 0 
                  ,@INT_Cosif_Costo              = ''
                  ,@INT_Cosif_Ger_Costo          = ''
                  ,@INT_Cuenta_Cosif_Notnl       = ''
                  ,@INT_Cuenta_SINC_Costo        = ''
                  ,@INT_Cosif_Compensacion       = ''
                  ,@INT_Cosif_Ger_Compensacion   = ''
                  ,@INT_Cuenta_SINC_Compensacion = ''
                  ,@INT_Resultado_Apropiado_Ano  = ''
                  ,@INT_MTM_Apropiado_Ano        = 0 
                  ,@INT_Riesgo_Potencial         = 0 
                  ,@INT_Moneda_Origen            = ''
                  ,@INT_Observacion              = ''
                  ,@INT_Info_Adicional           = ''


          /*----------------------------------------------------------------------*/
          /* INGRESAR REGISTROS                                                   */
          /*----------------------------------------------------------------------*/
		    INSERT INTO @SALIDA
			(Fecha_Referencia                ,Codigo_Origen            
            ,Numero_Contrato_Modelo          ,Numero_Contrato_Interno  
            ,Codigo_Operacion                ,Codigo_Empresa_SINC      
            ,Codigo_Mercado                  ,Mercancia                
            ,Tipo_Opcion                     ,Posicion                 
            ,Fecha_Vencimiento               ,Fecha_Operacion          
            ,cliente                         ,CNPJ                     
            ,Codigo_Cliente_SINC             ,Tipo_Cliente             
            ,Valor_Base_Actual               ,Valor_Costo              
            ,Valor_Mercado                   ,PDT                      
            ,PVT                             ,Cosif_Costo              
            ,Cosif_Ger_Costo                 ,Cuenta_Cosif_Notnl       
            ,Cuenta_SINC_Costo               ,Cosif_Compensacion       
            ,Cosif_Ger_Compensacion          ,Cuenta_SINC_Compensacion 
            ,Resultado_Apropiado_Ano         ,MTM_Apropiado_Ano        
            ,Riesgo_Potencial                ,Moneda_Origen            
            ,Observacion                     ,Info_Adicional)
			VALUES
			(@INT_Fecha_Referencia           ,@INT_Codigo_Origen            
            ,@INT_Numero_Contrato_Modelo     ,@INT_Numero_Contrato_Interno  
            ,@INT_Codigo_Operacion           ,@INT_Codigo_Empresa_SINC      
            ,@INT_Codigo_Mercado             ,@INT_Mercancia                
            ,@INT_Tipo_Opcion                ,@INT_Posicion                 
            ,@INT_Fecha_Vencimiento          ,@INT_Fecha_Operacion          
            ,@INT_cliente                    ,@INT_CNPJ                     
            ,@INT_Codigo_Cliente_SINC        ,@INT_Tipo_Cliente             
            ,@INT_Valor_Base_Actual          ,@INT_Valor_Costo              
            ,@INT_Valor_Mercado              ,@INT_PDT                      
            ,@INT_PVT                        ,@INT_Cosif_Costo              
            ,@INT_Cosif_Ger_Costo            ,@INT_Cuenta_Cosif_Notnl       
            ,@INT_Cuenta_SINC_Costo          ,@INT_Cosif_Compensacion       
            ,@INT_Cosif_Ger_Compensacion     ,@INT_Cuenta_SINC_Compensacion 
            ,@INT_Resultado_Apropiado_Ano    ,@INT_MTM_Apropiado_Ano        
            ,@INT_Riesgo_Potencial           ,@INT_Moneda_Origen            
            ,@INT_Observacion                ,@INT_Info_Adicional)			           





     FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION ,@OPE_FECHA_CONTRATO , @OPE_NUMERO_ESTRUCTURA  
     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES




	 SELECT CONVERT(CHAR(10),Fecha_Referencia,103) AS Fecha_Referencia        
           ,Codigo_Origen            
           ,Numero_Contrato_Modelo   
           ,Numero_Contrato_Interno  
           ,Codigo_Operacion         
           ,Codigo_Empresa_SINC      
           ,Codigo_Mercado           
           ,Mercancia                
           ,Tipo_Opcion              
           ,Posicion                 
           ,CONVERT(CHAR(10),Fecha_Vencimiento,103) AS Fecha_Vencimiento        
           ,CONVERT(CHAR(10),Fecha_Operacion,103) AS Fecha_Operacion         
           ,cliente                  
           ,CNPJ                     
           ,Codigo_Cliente_SINC      
           ,Tipo_Cliente             
           ,Valor_Base_Actual        
           ,Valor_Costo              
           ,Valor_Mercado            
           ,PDT                      
           ,PVT                      
           ,Cosif_Costo              
           ,Cosif_Ger_Costo          
           ,Cuenta_Cosif_Notnl       
           ,Cuenta_SINC_Costo        
           ,Cosif_Compensacion       
           ,Cosif_Ger_Compensacion   
           ,Cuenta_SINC_Compensacion 
           ,Resultado_Apropiado_Ano  
           ,MTM_Apropiado_Ano        
           ,Riesgo_Potencial         
           ,Moneda_Origen            
           ,Observacion              
           ,Info_Adicional           
	   FROM @SALIDA



END
GO
