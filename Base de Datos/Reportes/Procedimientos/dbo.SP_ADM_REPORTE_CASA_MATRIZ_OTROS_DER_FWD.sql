USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_CASA_MATRIZ_OTROS_DER_FWD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_CASA_MATRIZ_OTROS_DER_FWD]    
                      @FECHA DATETIME

AS    
BEGIN    


    
	SET NOCOUNT ON   

	 
 /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : INTERFACES FORWARD                                          */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 07/01/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     --EXEC Reportes.dbo.SP_ADM_REPORTE_CASA_MATRIZ_OTROS_DER_FWD '2015-12-30'
	 
   
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
			,@STR_MONPAGOMN   VARCHAR(03)
	        ,@STR_MONPAGOMX   VARCHAR(03)
			,@CNPJ            VARCHAR(20)
			,@Clopcion        VARCHAR(02)


   /*-----------------------------------------------------------------------------*/
   /* GENERACION DE SALIDA                                                        */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	    (Fecha_Referencia         DATETIME
        ,Codigo_Origen            VARCHAR(10)
        ,Numero_Contrato_Modelo   VARCHAR(10)
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
            ,@INT_Numero_Contrato_Modelo   VARCHAR(10)
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
	 ,COD_CARTERA	  CHAR(02)			
	 ,OPE_MTM_ACTIVO  FLOAT
	 ,OPE_MTM_PASIVO  FLOAT
	 ,MODALIDAD		  CHAR(01)
	 ,NOMBRE_CLIENTE  VARCHAR(150)
	 ,STR_MONEDA_1    VARCHAR(03)
	 ,STR_MONEDA_2    VARCHAR(03)
	 ,CNPJ            VARCHAR(20)
	 ,Clopcion        VARCHAR(02))




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
	       ,NOMBRE_CLIENTE  
	       ,STR_MONEDA_1    
	       ,STR_MONEDA_2    
	       ,CNPJ            
	       ,Clopcion        
       FROM REPORTES.DBO.CARTERA_FORWARD(@FECHA)
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
				  ,@CNPJ            = CNPJ
				  ,@Clopcion        = Clopcion
		      FROM @OPERACIONES 
		     WHERE OPERACION        = @OPE_NUMERO_OPERACION


          /*----------------------------------------------------------------------*/
          /* LLENAR INTERFACES                                                    */
          /*----------------------------------------------------------------------*/
		    SELECT @INT_Fecha_Referencia         = @FECHA
                  ,@INT_Codigo_Origen            = 'CHIBC' 
                  ,@INT_Numero_Contrato_Modelo   = 'IC769' 
                  ,@INT_Numero_Contrato_Interno  = @OPE_NUMERO_OPERACION 
                  ,@INT_Codigo_Operacion         = 'Forward'
                  ,@INT_Codigo_Empresa_SINC      = '0769'
                  ,@INT_Codigo_Mercado           = 'FW'
                  ,@INT_Mercancia                =  LTRIM(RTRIM(@STR_MONEDA_1)) +'/' + LTRIM(RTRIM(@STR_MONEDA_2))
                  ,@INT_Tipo_Opcion              = ''
                  ,@INT_Posicion                 = @TIPO_OPERACION
                  ,@INT_Fecha_Vencimiento        = @FECHA_VCTO
                  ,@INT_Fecha_Operacion          = @FECHA_INGRESO
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



     FETCH NEXT FROM CURSOR_OPERACIONES INTO @OPE_NUMERO_OPERACION ,@OPE_FECHA_INGRESO 
     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES




	 SELECT CONVERT(CHAR(10),Fecha_Referencia,103)    AS Fecha_Referencia     
           ,Codigo_Origen            
           ,Numero_Contrato_Modelo   
           ,Numero_Contrato_Interno  
           ,Codigo_Operacion         
           ,Codigo_Empresa_SINC      
           ,Codigo_Mercado           
           ,Mercancia                
           ,Tipo_Opcion              
           ,Posicion                 
           ,CONVERT(CHAR(10),Fecha_Vencimiento,103)  AS Fecha_Vencimiento      
           ,CONVERT(CHAR(10),Fecha_Operacion,103)    AS Fecha_Operacion      
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
