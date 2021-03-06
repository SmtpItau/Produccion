USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_RF_769BSL]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_RF_769BSL]    
                      @FECHA DATETIME

AS    
BEGIN    


    
    
	SET NOCOUNT ON   

	 
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS     : CONTABILIDAD RENTA FIJA                                     */
   /* AUTOR         : ROBERTO MORA DROGUETT                                       */
   /* FECHA CRACION : 14/03/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/


     --EXEC Reportes.dbo.SP_ADM_REPORTE_RF_769BSL '2015-12-30'
	 
   
   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA GENERAL DE REGISTROS PARA EVALUAR                         */
   /*-----------------------------------------------------------------------------*/
     CREATE TABLE #CARTERA_RF_INFORME
	 ( fechaProceso      datetime           NOT NULL
	  ,Sistema           char     (10)      NOT NULL
	  ,cprutcart         NUMERIC            NOT NULL
	  ,cpnumdocu         NUMERIC            NOT NULL
	  ,cpcorrela         NUMERIC            NOT NULL
	  ,cptipcart         NUMERIC            NOT NULL
	  ,Fecproc           datetime           NOT NULL
	  ,CodOrigen         char    (10)       NOT NULL
	  ,inserie           varchar (30)       NOT NULL
	  ,CodEmpresa        char    (10)       NOT NULL
	  ,FecEmi            datetime           NOT NULL
	  ,cpfeccomp         datetime           NOT NULL
	  ,fecvenc           datetime           NOT NULL
	  ,mnnemo            char    (8)        NOT NULL
	  ,TasEmi            FLOAT              NOT NULL
	  ,Emisor            varchar (50)       NOT NULL
	  ,CodEmisor         char    (10)       NOT NULL
	  ,Rutemi            NUMERIC            NOT NULL
	  ,CalJur            char    (10)       NOT NULL
	  ,Pais              varchar (50)       NOT NULL
	  ,Cartera           char    (2)        NOT NULL
	  ,Valcomp           NUMERIC            NOT NULL
	  ,ValCapital        NUMERIC            NOT NULL
	  ,InteresDev        float              NOT NULL
	  ,Cosif             char(12)           NOT NULL
	  ,Cosif_Ger         char(12)           NOT NULL
	  ,ValMdo            NUMERIC            NOT NULL
	  ,Util_Mercado      NUMERIC            NOT NULL
	  ,Perd_Mercado      NUMERIC            NOT NULL
	  ,InteresDevAno     NUMERIC            NOT NULL
	  ,ReajustesDevAno   NUMERIC            NOT NULL
	  ,DifMercano        NUMERIC            NOT NULL
	  ,ValcompAno        NUMERIC            NOT NULL
	  ,ValorVenta        NUMERIC            NOT NULL
	  ,InteresesporVenta NUMERIC            NOT NULL
	  ,UtilporVenta      NUMERIC            NOT NULL
	  ,monedaor          char    (5)        NOT NULL
	  ,CtaAltamira       char    (12)       NOT NULL
	  ,cpinstser         varchar (30)       NOT NULL
	  ,dimoneda          nchar   (20)       NOT NULL
	  ,Prog              varchar (10)       NOT NULL
	  ,cpcodigo          NUMERIC            NOT NULL
	  ,difecsal          datetime           NOT NULL
	  ,BasEmi            NUMERIC            NOT NULL
	  ,cpnominal         NUMERIC            NOT NULL
	  ,cptircomp         float              NOT NULL
	  ,cpvalcomu         float              NOT NULL
	  ,Valor_Contable    NUMERIC            NULL
	  ,Tasa_Contrato     float              NULL
	  ,cpmascara         varchar (20)       NOT NULL
	  ,cpseriado         char    (1)        NOT NULL
	  ,Fecha_PagoManana  datetime           NOT NULL
	  ,cpfecpcup         datetime           NOT NULL
	  ,cpFecucup         datetime           NOT NULL
	  ,Pendiente_Pago    char    (1)        NOT NULL
	  ,Codigo_Producto   int                NOT NULL
	  ,Monto_Pago        NUMERIC            NOT NULL
	  ,Rut_Cliente       NUMERIC            NOT NULL
	  ,Periodicidad      varchar (50)       NOT NULL
	  ,dvEmisor          VARCHAR (10))     


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DEL CURSOR                                         */
   /*-----------------------------------------------------------------------------*/
     DECLARE @CUR_fechaProceso      datetime           
	        ,@CUR_Sistema           char     (10)      
	        ,@CUR_cprutcart         numeric  
	        ,@CUR_cpnumdocu         numeric  
	        ,@CUR_cpcorrela         numeric  
	        ,@CUR_cptipcart         numeric  
	        ,@CUR_Fecproc           datetime           
	        ,@CUR_CodOrigen         char    (10)       
	        ,@CUR_inserie           varchar (30)       
	        ,@CUR_CodEmpresa        char    (10)       
	        ,@CUR_FecEmi            datetime           
	        ,@CUR_cpfeccomp         datetime           
	        ,@CUR_fecvenc           datetime           
	        ,@CUR_mnnemo            char    (8)        
	        ,@CUR_TasEmi            FLOAT
	        ,@CUR_Emisor            varchar (50)       
	        ,@CUR_CodEmisor         char    (10)       
	        ,@CUR_Rutemi            NUMERIC
	        ,@CUR_CalJur            char    (10)       
	        ,@CUR_Pais              varchar (50)       
	        ,@CUR_Cartera           char    (2)        
	        ,@CUR_Valcomp           numeric
	        ,@CUR_ValCapital        numeric
	        ,@CUR_InteresDev        float              
	        ,@CUR_Cosif             char(12)           
	        ,@CUR_Cosif_Ger         char(12)           
	        ,@CUR_ValMdo            numeric
	        ,@CUR_Util_Mercado      numeric
	        ,@CUR_Perd_Mercado      numeric
	        ,@CUR_InteresDevAno     numeric
	        ,@CUR_ReajustesDevAno   numeric
	        ,@CUR_DifMercano        numeric
	        ,@CUR_ValcompAno        numeric
	        ,@CUR_ValorVenta        numeric
	        ,@CUR_InteresesporVenta numeric
	        ,@CUR_UtilporVenta      numeric
	        ,@CUR_monedaor          char    (5)        
	        ,@CUR_CtaAltamira       char    (12)       
	        ,@CUR_cpinstser         varchar (30)       
	        ,@CUR_dimoneda          nchar   (20)       
	        ,@CUR_Prog              varchar (10)       
	        ,@CUR_cpcodigo          numeric
	        ,@CUR_difecsal          datetime           
	        ,@CUR_BasEmi            numeric
	        ,@CUR_cpnominal         numeric
	        ,@CUR_cptircomp         float              
	        ,@CUR_cpvalcomu         float              
	        ,@CUR_Valor_Contable    numeric
	        ,@CUR_Tasa_Contrato     float              
	        ,@CUR_cpmascara         varchar (20)       
	        ,@CUR_cpseriado         char    (1)        
	        ,@CUR_Fecha_PagoManana  datetime           
	        ,@CUR_cpfecpcup         datetime           
	        ,@CUR_cpFecucup         datetime           
	        ,@CUR_Pendiente_Pago    char    (1)        
	        ,@CUR_Codigo_Producto   int                
	        ,@CUR_Monto_Pago        numeric
	        ,@CUR_Rut_Cliente       numeric
	        ,@CUR_Periodicidad      varchar (50)       
	        ,@CUR_dvEmisor          VARCHAR (10)    


   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA DE SALIDAS                                                */
   /*-----------------------------------------------------------------------------*/
     DECLARE @SALIDA TABLE
	 (Fecha_Referencia               DATETIME
     ,Codigo_Producto                VARCHAR(10)
     ,Nemotécnico                    VARCHAR(20)
     ,Tipo_Operacion                 VARCHAR(20)
     ,Cosif_Pendiente_de_Liquidacion VARCHAR(20)
     ,Cod_Operacion                  VARCHAR(20)
     ,Pendiente_Pago                 VARCHAR(02)
     ,Monto_Pago                     NUMERIC
     ,Agencia                        VARCHAR(05)
     ,Nemotecnico                    VARCHAR(20)
     ,CGI_da_Camara_de_Compensacion  VARCHAR(20)
     ,Ind_Clase                      VARCHAR(20)
     ,Cod_Pais                       VARCHAR(03)
     ,Cod_Moneda                     VARCHAR(03)
     ,Cod_Contraparte                NUMERIC
     ,Frecuencia_Cupon               VARCHAR(50)
     ,Posicion_Embutida              VARCHAR(20)
     ,Data_Inicio                    VARCHAR(20)
     ,Data_Final                     VARCHAR(20)
     ,Strike                         VARCHAR(20)
     ,Mesa_Gestion                   VARCHAR(20))




     DECLARE @Fecha_Referencia               DATETIME
            ,@Codigo_Producto                VARCHAR(10)
            ,@Nemotécnico                    VARCHAR(20)
            ,@Tipo_Operacion                 VARCHAR(20)
            ,@Cosif_Pendiente_de_Liquidacion VARCHAR(20)
            ,@Cod_Operacion                  VARCHAR(20)
            ,@Pendiente_Pago                 VARCHAR(02)
            ,@Monto_Pago                     NUMERIC
            ,@Agencia                        VARCHAR(05)
            ,@Nemotecnico                    VARCHAR(20)
            ,@CGI_da_Camara_de_Compensacion  VARCHAR(20)
            ,@Ind_Clase                      VARCHAR(20)
            ,@Cod_Pais                       VARCHAR(03)
            ,@Cod_Moneda                     VARCHAR(03)
            ,@Cod_Contraparte                NUMERIC
            ,@Frecuencia_Cupon               VARCHAR(50)
            ,@Posicion_Embutida              VARCHAR(20)
            ,@Data_Inicio                    VARCHAR(20)
            ,@Data_Final                     VARCHAR(20)
            ,@Strike                         VARCHAR(20)
            ,@Mesa_Gestion                   VARCHAR(20)

   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OJO LOS INFORMES POSEEN LA MISMA ESTRUCTURA DE SALIDA DE LA TABLA           */
   /* TEMPORAL SI SE MODIFICA UNA SE DEBERAN ESTABLECER LOS CAMBIOS EN TODOS LOS  */
   /* SP QUE ESTA TRABAJE                                                         */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/



   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE CARTERAS EN TABLA TEMPORAL                                       */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO #CARTERA_RF_INFORME EXEC SP_ADM_DATOS_RF_CARTERA @FECHA


   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE VENTAS EN TABLA TEMPORAL                                         */
   /*-----------------------------------------------------------------------------*/
     --INSERT INTO #CARTERA_RF_INFORME EXEC SP_ADM_DATOS_RF_VENTAS @FECHA



   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE VENCIMIENTOS EN TABLA TEMPORAL                                   */
   /*-----------------------------------------------------------------------------*/
     --INSERT INTO #CARTERA_RF_INFORME EXEC SP_ADM_DATOS_RF_VCTOS @FECHA


   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE CARTERA BONES EN TABLA TEMPORAL                                  */
   /*-----------------------------------------------------------------------------*/
    --INSERT INTO #CARTERA_RF_INFORME EXEC SP_ADM_DATOS_RF_BONES @FECHA



   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE CARTERA BONES EN TABLA TEMPORAL                                  */
   /*-----------------------------------------------------------------------------*/
    INSERT INTO #CARTERA_RF_INFORME EXEC SP_ADM_DATOS_RF_BONOS_INV @FECHA



   /*-----------------------------------------------------------------------------*/
   /* SE REALIZARA CURSOR DE DATOS DEBIDO A QUE SIEMPRE SE ESTAN PIDIENDO CAMBIOS */
   /* SIGNIFICATIVOS EN LAS SALIDAS DE REGISTROS                                  */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_OPERACIONES CURSOR LOCAL FOR     
     SELECT fechaProceso      
	        ,Sistema           
	        ,cprutcart         
	        ,cpnumdocu         
	        ,cpcorrela         
	        ,cptipcart         
	        ,Fecproc           
	        ,CodOrigen         
	        ,inserie           
	        ,CodEmpresa        
	        ,FecEmi            
	        ,cpfeccomp         
	        ,fecvenc           
	        ,mnnemo            
	        ,TasEmi            
	        ,Emisor            
	        ,CodEmisor         
	        ,Rutemi            
	        ,CalJur            
	        ,Pais              
	        ,Cartera           
	        ,Valcomp           
	        ,ValCapital        
	        ,InteresDev        
	        ,Cosif             
	        ,Cosif_Ger         
	        ,ValMdo            
	        ,Util_Mercado      
	        ,Perd_Mercado      
	        ,InteresDevAno     
	        ,ReajustesDevAno   
	        ,DifMercano        
	        ,ValcompAno        
	        ,ValorVenta        
	        ,InteresesporVenta 
	        ,UtilporVenta      
	        ,monedaor          
	        ,CtaAltamira       
	        ,cpinstser         
	        ,dimoneda          
	        ,Prog              
	        ,cpcodigo          
	        ,difecsal          
	        ,BasEmi            
	        ,cpnominal         
	        ,cptircomp         
	        ,cpvalcomu         
	        ,Valor_Contable    
	        ,Tasa_Contrato     
	        ,cpmascara         
	        ,cpseriado         
	        ,Fecha_PagoManana  
	        ,cpfecpcup         
	        ,cpFecucup         
	        ,Pendiente_Pago    
	        ,Codigo_Producto   
	        ,Monto_Pago        
	        ,Rut_Cliente       
	        ,Periodicidad      
	        ,dvEmisor          
	   FROM #CARTERA_RF_INFORME
	  WHERE ValMdo != 0


        OPEN CURSOR_OPERACIONES
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_fechaProceso      
	                                          ,@CUR_Sistema           
	                                          ,@CUR_cprutcart         
	                                          ,@CUR_cpnumdocu         
	                                          ,@CUR_cpcorrela         
	                                          ,@CUR_cptipcart         
	                                          ,@CUR_Fecproc           
	                                          ,@CUR_CodOrigen         
	                                          ,@CUR_inserie           
	                                          ,@CUR_CodEmpresa        
	                                          ,@CUR_FecEmi            
	                                          ,@CUR_cpfeccomp         
	                                          ,@CUR_fecvenc           
	                                          ,@CUR_mnnemo            
	                                          ,@CUR_TasEmi            
	                                          ,@CUR_Emisor            
	                                          ,@CUR_CodEmisor         
	                                          ,@CUR_Rutemi            
	                                          ,@CUR_CalJur            
	                                          ,@CUR_Pais              
	                                          ,@CUR_Cartera           
	                                          ,@CUR_Valcomp           
	                                          ,@CUR_ValCapital        
	                                          ,@CUR_InteresDev        
	                                          ,@CUR_Cosif             
	                                          ,@CUR_Cosif_Ger         
	                                          ,@CUR_ValMdo            
	                                          ,@CUR_Util_Mercado      
	                                          ,@CUR_Perd_Mercado      
	                                          ,@CUR_InteresDevAno     
	                                          ,@CUR_ReajustesDevAno   
	                                          ,@CUR_DifMercano        
	                                          ,@CUR_ValcompAno        
	                                          ,@CUR_ValorVenta        
	                                          ,@CUR_InteresesporVenta 
	                                          ,@CUR_UtilporVenta      
	                                          ,@CUR_monedaor          
	                                          ,@CUR_CtaAltamira       
	                                          ,@CUR_cpinstser         
	                                          ,@CUR_dimoneda          
	                                          ,@CUR_Prog              
	                                          ,@CUR_cpcodigo          
	                                          ,@CUR_difecsal          
	                                          ,@CUR_BasEmi            
	                                          ,@CUR_cpnominal         
	                                          ,@CUR_cptircomp         
	                                          ,@CUR_cpvalcomu         
	                                          ,@CUR_Valor_Contable    
	                                          ,@CUR_Tasa_Contrato     
	                                          ,@CUR_cpmascara         
	                                          ,@CUR_cpseriado         
	                                          ,@CUR_Fecha_PagoManana  
	                                          ,@CUR_cpfecpcup         
	                                          ,@CUR_cpFecucup         
	                                          ,@CUR_Pendiente_Pago    
	                                          ,@CUR_Codigo_Producto   
	                                          ,@CUR_Monto_Pago        
	                                          ,@CUR_Rut_Cliente       
	                                          ,@CUR_Periodicidad      
	                                          ,@CUR_dvEmisor          


   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN



          /*----------------------------------------------------------------------*/
	      /* SETEO DE MONTOS DE INTERFAZ                                          */
		  /*----------------------------------------------------------------------*/
            SELECT @Fecha_Referencia               = @FECHA
                  ,@Codigo_Producto                = 'IC769' --@CUR_Codigo_Producto
                  ,@Nemotécnico                    = @CUR_cpmascara
                  ,@Tipo_Operacion                 = ''
                  ,@Cosif_Pendiente_de_Liquidacion = ''
                  ,@Cod_Operacion                  = LTRIM(RTRIM(CONVERT(CHAR,@CUR_cpnumdocu))) + '-' + LTRIM(RTRIM(CONVERT(CHAR,@CUR_cpcorrela)))
                  ,@Pendiente_Pago                 = 'N'
                  ,@Monto_Pago                     = 0
                  ,@Agencia                        = '0000'
                  ,@Nemotecnico                    = @CUR_cpmascara
                  ,@CGI_da_Camara_de_Compensacion  = ''
                  ,@Ind_Clase                      = ''
                  ,@Cod_Pais                       = @CUR_Pais
                  ,@Cod_Moneda                     = @CUR_monedaor
                  ,@Cod_Contraparte                = 0
                  ,@Frecuencia_Cupon               = @CUR_Periodicidad
                  ,@Posicion_Embutida              = ''
                  ,@Data_Inicio                    = ''
                  ,@Data_Final                     = ''
                  ,@Strike                         = '00000000000.00'
                  ,@Mesa_Gestion                   = ''




				     
          /*----------------------------------------------------------------------*/
	      /* SE INSERTAN REGISTROS                                                */
		  /*----------------------------------------------------------------------*/
		    INSERT INTO @SALIDA 
	        (Fecha_Referencia               ,Codigo_Producto                
            ,Nemotécnico                    ,Tipo_Operacion                 
            ,Cosif_Pendiente_de_Liquidacion ,Cod_Operacion                  
            ,Pendiente_Pago                 ,Monto_Pago                     
            ,Agencia                        ,Nemotecnico                    
            ,CGI_da_Camara_de_Compensacion  ,Ind_Clase                      
            ,Cod_Pais                       ,Cod_Moneda                     
            ,Cod_Contraparte                ,Frecuencia_Cupon               
            ,Posicion_Embutida              ,Data_Inicio                    
            ,Data_Final                     ,Strike                         
            ,Mesa_Gestion                   )
			VALUES
	        (@Fecha_Referencia               ,@Codigo_Producto                
            ,@Nemotécnico                    ,@Tipo_Operacion                 
            ,@Cosif_Pendiente_de_Liquidacion ,@Cod_Operacion                  
            ,@Pendiente_Pago                 ,@Monto_Pago                     
            ,@Agencia                        ,@Nemotecnico                    
            ,@CGI_da_Camara_de_Compensacion  ,@Ind_Clase                      
            ,@Cod_Pais                       ,@Cod_Moneda                     
            ,@Cod_Contraparte                ,@Frecuencia_Cupon               
            ,@Posicion_Embutida              ,@Data_Inicio                    
            ,@Data_Final                     ,@Strike                         
            ,@Mesa_Gestion                   )




       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_fechaProceso      
	                                          ,@CUR_Sistema           
	                                          ,@CUR_cprutcart         
	                                          ,@CUR_cpnumdocu         
	                                          ,@CUR_cpcorrela         
	                                          ,@CUR_cptipcart         
	                                          ,@CUR_Fecproc           
	                                          ,@CUR_CodOrigen         
	                                          ,@CUR_inserie           
	                                          ,@CUR_CodEmpresa        
	                                          ,@CUR_FecEmi            
	                                          ,@CUR_cpfeccomp         
	                                          ,@CUR_fecvenc           
	                                          ,@CUR_mnnemo            
	                                          ,@CUR_TasEmi            
	                                          ,@CUR_Emisor            
	                                          ,@CUR_CodEmisor         
	                                          ,@CUR_Rutemi            
	                                          ,@CUR_CalJur            
	                                          ,@CUR_Pais              
	                                          ,@CUR_Cartera           
	                                          ,@CUR_Valcomp           
	                                          ,@CUR_ValCapital        
	                                          ,@CUR_InteresDev        
	                                          ,@CUR_Cosif             
	                                          ,@CUR_Cosif_Ger         
	                                          ,@CUR_ValMdo            
	                                          ,@CUR_Util_Mercado      
	                                          ,@CUR_Perd_Mercado      
	                                          ,@CUR_InteresDevAno     
	                                          ,@CUR_ReajustesDevAno   
	                                          ,@CUR_DifMercano        
	                                          ,@CUR_ValcompAno        
	                                          ,@CUR_ValorVenta        
	                                          ,@CUR_InteresesporVenta 
	                                          ,@CUR_UtilporVenta      
	                                          ,@CUR_monedaor          
	                                          ,@CUR_CtaAltamira       
	                                          ,@CUR_cpinstser         
	                                          ,@CUR_dimoneda          
	                                          ,@CUR_Prog              
	                                          ,@CUR_cpcodigo          
	                                          ,@CUR_difecsal          
	                                          ,@CUR_BasEmi            
	                                          ,@CUR_cpnominal         
	                                          ,@CUR_cptircomp         
	                                          ,@CUR_cpvalcomu         
	                                          ,@CUR_Valor_Contable    
	                                          ,@CUR_Tasa_Contrato     
	                                          ,@CUR_cpmascara         
	                                          ,@CUR_cpseriado         
	                                          ,@CUR_Fecha_PagoManana  
	                                          ,@CUR_cpfecpcup         
	                                          ,@CUR_cpFecucup         
	                                          ,@CUR_Pendiente_Pago    
	                                          ,@CUR_Codigo_Producto   
	                                          ,@CUR_Monto_Pago        
	                                          ,@CUR_Rut_Cliente       
	                                          ,@CUR_Periodicidad      
	                                          ,@CUR_dvEmisor    
									
											  
     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES											   


	


   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     SELECT CONVERT(CHAR(10),Fecha_Referencia,103)  AS Fecha_Referencia
           ,Codigo_Producto                
           ,Nemotécnico                    
           ,Tipo_Operacion                 
           ,Cosif_Pendiente_de_Liquidacion 
           ,Cod_Operacion                  
           ,Pendiente_Pago                 
           ,Monto_Pago                     
           ,Agencia                        
           ,Nemotecnico                    
           ,CGI_da_Camara_de_Compensacion  
           ,Ind_Clase                      
           ,Cod_Pais                       
           ,Cod_Moneda                     
           ,Cod_Contraparte                
           ,Frecuencia_Cupon               
           ,Posicion_Embutida              
           ,Data_Inicio                    
           ,Data_Final                     
           ,Strike                         
           ,Mesa_Gestion                   
	  FROM @SALIDA


END
GO
