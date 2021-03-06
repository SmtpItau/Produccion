USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_RF_769TVM]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ADM_REPORTE_RF_769TVM]    
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


     --EXEC Reportes.dbo.SP_ADM_REPORTE_RF_769TVM '2015-12-30'
	 
   
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
	 (FechaPro         DATETIME
     ,Cod_Orig         VARCHAR(10)
     ,Cod_Papel        VARCHAR(15)
     ,Cod_EmpSinc      VARCHAR(10)
     ,Fec_Emision      DATETIME
     ,Fec_Ope          DATETIME     
     ,Fec_Vcto         DATETIME
     ,S_Index          VARCHAR(04)
     ,Tasa_Emi         FLOAT
     ,Nom_Emi          VARCHAR(200)
     ,Cod_EmiSinc      VARCHAR(10)
     ,Rut_Emi          VARCHAR(15)
     ,Cal_Jur          VARCHAR(05)
     ,Pais             VARCHAR(05)
     ,Cartera          VARCHAR(10)
     ,Val_Comp         NUMERIC
     ,Custo_Ppal       NUMERIC
     ,Custo_Juros      NUMERIC
     ,Cosif            VARCHAR(20)
     ,Cosif_Ger        VARCHAR(10)
     ,Conta_Sinc       VARCHAR(20)
     ,Perda_Perm       NUMERIC
     ,Val_Mercado      NUMERIC
     ,PDT              NUMERIC
     ,PVT              NUMERIC
     ,Int_Año          NUMERIC
     ,Reaj_Año         NUMERIC
     ,Dif_Mcdo_Año     NUMERIC
     ,Val_Comp_Año     NUMERIC
     ,Val_Venta        NUMERIC
     ,Int_x_Vta        NUMERIC
     ,Uti_Perd_x_Vta   NUMERIC
     ,Mda_Orig         VARCHAR(04)
     ,Observación      VARCHAR(200)
     ,Cod_Bolsa        VARCHAR(20)
     ,Nivel            INT
     ,N_Docto          VARCHAR(20)
     ,Frecuencia_Cupon VARCHAR(60))



     DECLARE @FechaPro         DATETIME
            ,@Cod_Orig         VARCHAR(10)
            ,@Cod_Papel        VARCHAR(15)
            ,@Cod_EmpSinc      VARCHAR(10)
            ,@Fec_Emision      DATETIME
            ,@Fec_Ope          DATETIME     
            ,@Fec_Vcto         DATETIME
            ,@S_Index          VARCHAR(04)
            ,@Tasa_Emi         FLOAT
            ,@Nom_Emi          VARCHAR(200)
            ,@Cod_EmiSinc      VARCHAR(10)
            ,@Rut_Emi          VARCHAR(15)
            ,@Cal_Jur          VARCHAR(05)
            ,@Pais             VARCHAR(05)
            ,@Cartera          VARCHAR(10)
            ,@Val_Comp         NUMERIC
            ,@Custo_Ppal       NUMERIC
            ,@Custo_Juros      NUMERIC
            ,@Cosif            VARCHAR(20)
            ,@Cosif_Ger        VARCHAR(10)
            ,@Conta_Sinc       VARCHAR(20)
            ,@Perda_Perm       NUMERIC
            ,@Val_Mercado      NUMERIC
            ,@PDT              NUMERIC
            ,@PVT              NUMERIC
            ,@Int_Año          NUMERIC
            ,@Reaj_Año         NUMERIC
            ,@Dif_Mcdo_Año     NUMERIC
            ,@Val_Comp_Año     NUMERIC
            ,@Val_Venta        NUMERIC
            ,@Int_x_Vta        NUMERIC
            ,@Uti_Perd_x_Vta   NUMERIC
            ,@Mda_Orig         VARCHAR(04)
            ,@Observación      VARCHAR(200)
            ,@Cod_Bolsa        VARCHAR(20)
            ,@Nivel            INT
            ,@N_Docto          VARCHAR(20)
            ,@Frecuencia_Cupon VARCHAR(60)
			,@CodClas          VARCHAR(20)

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
            SELECT @FechaPro         = @CUR_fechaProceso
                  ,@Cod_Orig         = @CUR_CodOrigen
                  ,@Cod_Papel        = @CUR_inserie
                  ,@Cod_EmpSinc      = '0769'
                  ,@Fec_Emision      = @CUR_FecEmi
                  ,@Fec_Ope          = @CUR_cpfeccomp  
                  ,@Fec_Vcto         = @CUR_fecvenc
                  ,@S_Index          = @CUR_mnnemo
                  ,@Tasa_Emi         = @CUR_TasEmi
                  ,@Nom_Emi          = SUBSTRING(LTRIM(RTRIM(@CUR_Emisor)),1,35)
                  ,@Cod_EmiSinc      = @CUR_CodEmisor
                  ,@Rut_Emi          = LTRIM(RTRIM(CONVERT(CHAR,@CUR_Rutemi))) + '-' + LTRIM(RTRIM(@CUR_dvEmisor))
                  ,@Cal_Jur          = @CUR_CalJur
                  ,@Pais             = @CUR_Pais
                  ,@Cartera          = @CUR_Cartera
                  ,@Val_Comp         = @CUR_Valcomp
                  ,@Custo_Ppal       = @CUR_ValCapital
                  ,@Custo_Juros      = @CUR_InteresDev
                  ,@Cosif            = ''
                  ,@Cosif_Ger        = ''
                  ,@Conta_Sinc       = ''
                  ,@Perda_Perm       = 0
                  ,@Val_Mercado      = @CUR_ValMdo
                  ,@PDT              = (@CUR_Perd_Mercado ) * -1
                  ,@PVT              = @CUR_Util_Mercado
                  ,@Int_Año          = @CUR_InteresDevAno
                  ,@Reaj_Año         = @CUR_ReajustesDevAno
                  ,@Dif_Mcdo_Año     = @CUR_DifMercano
                  ,@Val_Comp_Año     = @CUR_ValcompAno
                  ,@Val_Venta        = @CUR_ValorVenta
                  ,@Int_x_Vta        = @CUR_InteresesporVenta
                  ,@Uti_Perd_x_Vta   = @CUR_UtilporVenta
                  ,@Mda_Orig         = @CUR_monedaor
                  ,@Observación      = ''
                  ,@Cod_Bolsa        = @CUR_cpmascara
                  ,@Nivel            = 0
                  ,@N_Docto          = LTRIM(RTRIM(CONVERT(CHAR,@CUR_cpnumdocu))) + '-' + LTRIM(RTRIM(CONVERT(CHAR,@CUR_cpcorrela)))
                  ,@Frecuencia_Cupon = @CUR_Periodicidad



          /*----------------------------------------------------------------------*/
	      /* SE INVOCARA CUENTA DE RENTA FIJA SEGUN PERFIL CONTABLE               */
		  /*----------------------------------------------------------------------*/
		    IF LTRIM(RTRIM(@CUR_inserie)) != 'BONOEX' BEGIN


		       SET @CodClas = '0'
               EXECUTE @CodClas = REPORTES.DBO.SP_ADM_DATOS_RF_TIPO_CARTERA_2
	               'BTR' 
	             , 'TMF' 
	             , 'TMCP'
	             , @CUR_cpnumdocu 
	             , @CUR_cpnumdocu
	             , @CUR_cpcorrela
				 , @FECHA



	           SELECT @Observación = CUENTA_CONTABLE 
			     FROM REPORTES.DBO.ContabilidadDevengoRentaFija('BTR'
			                                                  ,@CUR_cpnumdocu
			                                                  ,@CUR_cpcorrela  
			    		      							      ,@CUR_inserie
														      ,@CUR_dimoneda
														      ,@CodClas)
			    WHERE CORRELATIVO = 1


           END
          /*----------------------------------------------------------------------*/
	      /* SI ES BONEX SU SISTEMA CAMBIARA PARA EL PERFIL                       */
		  /*----------------------------------------------------------------------*/
			IF LTRIM(RTRIM(@CUR_inserie)) = 'BONOEX' BEGIN
			

		       SET @CodClas = '0'
               EXECUTE @CodClas = REPORTES.DBO.SP_ADM_DATOS_RF_TIPO_CARTERA_2 
	               'BEX' 
	             , 'TMF' 
	             , 'TMCP'
	             , @CUR_cpnumdocu 
	             , @CUR_cpnumdocu
	             , @CUR_cpcorrela
				 , @FECHA


	           SELECT @Observación = CUENTA_CONTABLE 
			    FROM REPORTES.DBO.ContabilidadDevengoRentaFija('BEX'
			                                                   ,@CUR_cpnumdocu
			                                                   ,@CUR_cpcorrela  
			    		   								       ,'2000'
														       ,@CUR_dimoneda
														       ,@CodClas)
			   WHERE CORRELATIVO = 5
			
						

			END        
				   
          /*----------------------------------------------------------------------*/
	      /* DETERMINAR COSIF                                                     */
		  /*----------------------------------------------------------------------*/				   
		       SET @Cosif            = ''
			   SET @Cosif_Ger        = ''
			SELECT @Cosif            = COSIF
                  ,@Cosif_Ger        = COSIF_GER 
			  FROM REPORTES.DBO.CODIGOS_COSIF(LTRIM(RTRIM(@Observación)))
				   

				   
				   
				     
          /*----------------------------------------------------------------------*/
	      /* SE INSERTAN REGISTROS                                                */
		  /*----------------------------------------------------------------------*/
		    INSERT INTO @SALIDA 
	        (FechaPro        ,Cod_Orig      ,  Cod_Papel      , Cod_EmpSinc      
            ,Fec_Emision     ,Fec_Ope       ,  Fec_Vcto       , S_Index          
            ,Tasa_Emi        ,Nom_Emi       ,  Cod_EmiSinc    , Rut_Emi         
            ,Cal_Jur         ,Pais          ,  Cartera        , Val_Comp        
            ,Custo_Ppal      ,Custo_Juros   ,  Cosif          , Cosif_Ger        
            ,Conta_Sinc      ,Perda_Perm    ,  Val_Mercado    , PDT              
            ,PVT             ,Int_Año       ,  Reaj_Año       , Dif_Mcdo_Año     
            ,Val_Comp_Año    ,Val_Venta     ,  Int_x_Vta      , Uti_Perd_x_Vta  
            ,Mda_Orig        ,Observación   ,  Cod_Bolsa      , Nivel           
            ,N_Docto         ,Frecuencia_Cupon )
			VALUES
	        (@FechaPro        ,@Cod_Orig      ,  @Cod_Papel      , @Cod_EmpSinc      
            ,@Fec_Emision     ,@Fec_Ope       ,  @Fec_Vcto       , @S_Index          
            ,@Tasa_Emi        ,@Nom_Emi       ,  @Cod_EmiSinc    , @Rut_Emi         
            ,@Cal_Jur         ,@Pais          ,  @Cartera        , @Val_Comp        
            ,@Custo_Ppal      ,@Custo_Juros   ,  @Cosif          , @Cosif_Ger        
            ,@Conta_Sinc      ,@Perda_Perm    ,  @Val_Mercado    , @PDT              
            ,@PVT             ,@Int_Año       ,  @Reaj_Año       , @Dif_Mcdo_Año     
            ,@Val_Comp_Año    ,@Val_Venta     ,  @Int_x_Vta      , @Uti_Perd_x_Vta  
            ,@Mda_Orig        ,@Observación   ,  @Cod_Bolsa      , @Nivel           
            ,@N_Docto         ,@Frecuencia_Cupon )




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
     SELECT  CONVERT(CHAR(10),FechaPro,103) AS FechaPro         
            ,Cod_Orig         
            ,Cod_Papel        
            ,Cod_EmpSinc      
            ,CONVERT(CHAR(10),Fec_Emision,103) AS Fec_Emision              
            ,CONVERT(CHAR(10),Fec_Ope,103) AS Fec_Ope
            ,CONVERT(CHAR(10),Fec_Vcto,103) AS Fec_Vcto        
            ,S_Index          
            ,Tasa_Emi         
            ,Nom_Emi          
            ,Cod_EmiSinc      
            ,Rut_Emi          
            ,Cal_Jur          
            ,Pais             
            ,Cartera          
            ,Val_Comp         
            ,Custo_Ppal       
            ,Custo_Juros      
            ,Cosif            
            ,Cosif_Ger        
            ,Conta_Sinc       
            ,Perda_Perm       
            ,Val_Mercado      
            ,PDT              
            ,PVT              
            ,Int_Año          
            ,Reaj_Año         
            ,Dif_Mcdo_Año     
            ,Val_Comp_Año     
            ,Val_Venta        
            ,Int_x_Vta        
            ,Uti_Perd_x_Vta   
            ,Mda_Orig         
            ,Observación      
            ,Cod_Bolsa        
            ,Nivel            
            ,N_Docto          
            ,Frecuencia_Cupon 
	    FROM @SALIDA


END
GO
