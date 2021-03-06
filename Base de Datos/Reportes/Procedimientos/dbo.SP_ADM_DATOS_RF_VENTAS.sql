USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_DATOS_RF_VENTAS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ADM_DATOS_RF_VENTAS]  
                      @cFecRep DATETIME

AS    
BEGIN    


    
	SET NOCOUNT ON   

	 
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS      : CARTERA RENTA FIJA SEGUN FECHA                              */
   /* AUTOR          : ROBERTO MORA DROGUETT                                       */
   /* FECHA CREACION : 04/03/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     --EXEC Reportes.dbo.SP_ADM_DATOS_RF_VENTAS '2015-12-30'
	 
   
   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
	 DECLARE @DO_TC      FLOAT
            ,@QUERY      VARCHAR(MAX)
	        ,@tc_rep_cnt VARCHAR(01)
			,@FechaRep   DATETIME


   /*-----------------------------------------------------------------------------*/
   /* MDCA TEMPORAL PARA CALCULOS                                                 */
   /*-----------------------------------------------------------------------------*/
     CREATE TABLE #MDAC
	 (acfecprox               DATETIME
	 ,acfecproc               DATETIME)



   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA SEGUN FECHA MDCP                                          */
   /*-----------------------------------------------------------------------------*/
     SET @QUERY = 'INSERT INTO #MDAC '
	 SET @QUERY = @QUERY + 'SELECT '
	 SET @QUERY = @QUERY + 'acfecprox' 
	 SET @QUERY = @QUERY + ',acfecproc'
	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDAC' + SUBSTRING(CONVERT(CHAR(8),@cFecRep,112),5,4)


	 EXEC (@QUERY)




   /*-----------------------------------------------------------------------------*/
   /* CALCULOS DE FECHAS Y VARIANTES                                              */
   /*-----------------------------------------------------------------------------*/
     SELECT @DO_TC   = isnull(Tipo_Cambio,0)     /* Dolar T/C Rep. Contable */
       FROM BacParamSuda..VALOR_MONEDA_CONTABLE,#MDAC WITH (NOLOCK)
      WHERE Codigo_Moneda = 994 
	    AND Fecha = acfecprox

	DECLARE @bFinAno		BIT 
		SET @bFinAno		= 0		
	

	DECLARE @dFecProx		DATETIME
		SET @dFecProx		= (SELECT acfecprox FROM #MDAC);
		
	DECLARE @dFecProc		DATETIME
		SET @dFecProc		= (SELECT acfecproc FROM #MDAC);		  

		
		IF YEAR(@dFecProc) != YEAR(@dFecProx) BEGIN
			SET @bFinAno	= 1
			SET @dFecProx	= CONVERT(DATETIME,Str(DATEPART(YEAR,@dFecProc),4)+'1231') 		
		END  

		
	    IF @DO_TC= 0  BEGIN
           SELECT @tc_rep_cnt = 'N'   /* SE OCUPA T/C OBS */
        END 
	    ELSE BEGIN
		   SELECT @tc_rep_cnt = 'S'   /* SE OCUPA T/C REP CONTABLE */
	    END



     SELECT @FechaRep = CONVERT(DATETIME,@cFecRep)
	DECLARE @contable NUMERIC(19,4)
	 SELECT @contable = vmc.Tipo_Cambio
	   FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vmc 
	  WHERE vmc.Fecha = @dFecProc  
	    AND vmc.Codigo_Moneda = 994



   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA GLOBAL EN DONDE DESDE OTRA EJECUCION SE CONSULTARA        */
   /*-----------------------------------------------------------------------------*/
     CREATE TABLE #CARTERA_RF
	 ( ID                INT                IDENTITY
	  ,fechaProceso      datetime           NOT NULL
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
	  ,dvEmisor          VARCHAR (10)
	  ,fechavta          DATETIME)
	 

   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE REGISTROS DE VENCIMIENTOS                                        */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO #CARTERA_RF
	  SELECT  'fechaProceso'	      = @FechaRep 
			, 'Sistema'	              = 'BTR' 
		    , 'RUT_CARTERA'	          = RUT_CARTERA
		    , 'NUMDOCU'		          = NUMDOCU
		    , 'CORRELA'		          = CORRELA
		    , 'TIPO_CARTERA'          = MIN(TIPO_CARTERA)
		    , 'Fecproc'	              = @FechaRep
		    , 'CodOrigen'	          = 'RNIII'
		    , 'inserie'		          = MIN(b.inserie)
		    , 'CodEmpresa'	          = '0769'
		    , 'FecEmi'		          = CASE WHEN MIN(SERIADO) = 'S' THEN (SELECT ISNULL(sefecemi,'19000101') FROM bactradersuda.dbo.VIEW_SERIE WHERE MIN(MASCARA) = semascara)
		    				        								 ELSE (SELECT ISNULL(nsfecemi,'19000101') FROM bactradersuda.dbo.VIEW_NOSERIE WHERE nsrutcart = RUT_CARTERA AND nsnumdocu = NUMDOCU AND nscorrela = CORRELA)
							            END
		    , 'fecha_compra_original' = MIN(FECCOMP)
		    , 'fecvenc'				  = CASE WHEN MIN(SERIADO) = 'S' THEN MIN(FECPCUP)
		    														ELSE (SELECT nsfecven FROM bactradersuda.dbo.VIEW_NOSERIE Where nsrutcart = RUT_CARTERA AND nsnumdocu = NUMDOCU AND nscorrela = CORRELA)
									    END
		    , 'mnnemo'				  = MIN(c.mnnemo)
		    , 'TasEmi'				  = CASE WHEN MIN(SERIADO) = 'S' THEN (SELECT setasemi FROM bactradersuda.dbo.VIEW_SERIE Where MIN(MASCARA) = semascara)
		    						 								ELSE MIN(TIRCOMP)
									    END
		    , 'Emisor'				  = (SELECT Emnombre from bactradersuda.dbo.view_emisor WHERE emrut = MIN(RUTEMIS))
		    , 'CodEmisor'			  = '0000'
		    , 'Rutemi'				  = CASE WHEN MIN(SERIADO) = 'S' THEN (SELECT serutemi FROM bactradersuda.dbo.VIEW_SERIE Where MIN(MASCARA) = semascara)
		    								ELSE (SELECT nsrutemi FROM bactradersuda.dbo.VIEW_NOSERIE Where nsrutcart = RUT_CARTERA AND nsnumdocu = NUMDOCU AND nscorrela = CORRELA)
									    END
			, 'CalJur'				  = '  '
		    , 'Pais'			      = CONVERT(VARCHAR(80),'')
			, 'Cartera'				  = CASE WHEN MIN(TIPO_CARTERA) = 1 THEN 'TR'
		    								 WHEN MIN(TIPO_CARTERA) = 2 THEN 'AV'
		    								 WHEN MIN(TIPO_CARTERA) = 4 THEN 'HD'
		    								 ELSE							 'TR'
		    							 END 
		    , 'Valcomp'				  = SUM(ISNULL(VALORCONTABLE,0)) -- VGS 03/12/2008 SUM(VALCOMP),
		    , 'ValCapital'			  = SUM(ISNULL(VALORCONTABLE,0))
		    , 'InteresDev'			  = ISNULL(CONVERT(FLOAT,0),0)
		    , 'Cosif'				  = SPACE(12)
		    , 'Cosif_Ger'			  = SPACE(12)
		    , 'ValMdo'				  = SUM(ISNULL(VALMERCADO,0))
		    , 'Util_Mercado'          = SUM(ISNULL(UTIL_MCDO,0))
		    , 'Perd_Mercado'          = SUM(ISNULL(PER_MCDO,0))
		    , 'InteresDevAno'	      = SUM(ISNULL(INTDEVANNO,0))
		    , 'ReajustesDevAno'       = SUM(ISNULL(READEVANNO,0))
		    , 'DifMercano'            = SUM(ISNULL(DIFMCDOANNO,0))
		    , 'ValcompAno'            = SUM(ISNULL(VALCOMPANNO,0))
		    , 'ValorVenta'            = SUM(ISNULL(VENTAVALOR,0))
		    , 'InteresesporVenta'	  = SUM(ISNULL(INTERESVENTA,0))
		    , 'UtilporVenta'          = CASE WHEN SUM(UTIL_X_VENTA) > 0 THEN SUM(UTIL_X_VENTA) ELSE SUM(PERD_X_VENTA) END
		    , 'monedaor'			  = 'CLP'
		    , 'CtaAltamira'			  = SPACE(12)
		    , 'moinstser'			  = MIN(INSTSER)
		    , 'momonemi'			  = MIN(MONEMIS)
		    , 'Prog'				  = 'SP_'+Min(inprog)
		    , 'mocodigo'			  = MIN(CODIGO)
		    , 'mofecven'			  = MIN(FECVENC)
		    , 'BasEmi'				  = CASE WHEN Min(SERIADO) = 'S' THEN (SELECT sebasemi FROM bactradersuda.dbo.VIEW_SERIE Where Min(MASCARA) = semascara)
		    								ELSE (SELECT nsbasemi FROM bactradersuda.dbo.VIEW_NOSERIE Where nsrutcart = RUT_CARTERA AND nsnumdocu = NUMDOCU AND nscorrela = CORRELA)
										END
		    , 'monominal'			  = SUM(NOMINAL)
		    , 'tir_compra_original'   = MIN(TIRCOMP)
		    , 'movalcomu'			  = SUM(VALCOMU)
		    , 'Valor_Contable'		  = SUM(VALORCONTABLE)
		    , 'Tasa_Contrato'		  = MIN(TASACONTRATO)
		    , 'cpmascara'			  = MIN(ISNULL(MASCARA,0))
		    , 'cpseriado'			  = MIN(ISNULL(SERIADO,0))
		    , 'Fecha_PagoMañana'	  = CASE WHEN MIN(FECCOMP) < CONVERT(DATETIME,'20070115') THEN MIN(VENTAFECPAGO) ELSE MIN(FECCOMP) END
		    , 'cpfecpcup'             = MIN(FECPCUP)
		    , 'cpFecucup'             = MIN(FECUCUP)
		    , 'Pendiente_Pago'		  = CASE WHEN MIN(VENTAFECPAGO)<= @FechaRep   THEN CONVERT(VARCHAR(10),'N') ELSE CONVERT(VARCHAR(10),'S') END
		    , 'Codigo_Producto'		  = CASE WHEN MIN(CODIGO) = 98 THEN 33 ELSE 29 END
		    , 'Monto_Pago'			  = CASE WHEN MIN(VENTAFECPAGO)<= @FechaRep THEN CONVERT(NUMERIC(17,2),0) ELSE SUM(NOMINAL) END
		    , 'Rut_Cliente'			  = CASE WHEN MIN(VENTAFECPAGO)<= @FechaRep THEN CONVERT(NUMERIC(30),0)  
																				ELSE (CASE WHEN Min(SERIADO) = 'S' THEN (SELECT serutemi FROM bactradersuda.dbo.VIEW_SERIE   WHERE MIN(MASCARA) = semascara)
		     																									   ELSE (SELECT nsrutemi FROM bactradersuda.dbo.VIEW_NOSERIE WHERE nsrutcart = RUT_CARTERA AND nsnumdocu = NUMDOCU AND nscorrela = CORRELA)
																			   END) 
										END
		    , 'PERIODICIDAD'          = CASE WHEN MIN(b.inserie) =  'BCP'  THEN 'SEMESTRAL' 
		    								 WHEN MIN(b.inserie) =  'BCU'  THEN 'SEMESTRAL' 					
		    								 WHEN MIN(b.inserie) =  'BTP'  THEN 'SEMESTRAL' 
		    								 WHEN MIN(b.inserie) =  'BTU'  THEN 'SEMESTRAL' 
		    								 WHEN MIN(b.inserie) =  'PRC'  THEN 'SEMESTRAL' 
						     				 WHEN MIN(b.inserie) =  'LCHR' THEN 'TRIMESTRAL'
						     			     WHEN MIN(b.inserie)=  'BONOS'THEN 'SEMESTRAL' 
		    								 WHEN MIN(b.inserie) =  'CERO' THEN 'OUTRO'
		    								 WHEN MIN(b.inserie) =  'DPF'  THEN 'OUTRO'
		    								 WHEN MIN(b.inserie) =  'DPR'  THEN 'OUTRO'
		    								 WHEN MIN(b.inserie) =  'PDBC' THEN 'OUTRO'
		    								 WHEN MIN(b.inserie) =  'DPX'  THEN 'OUTRO'
		    						    ELSE 'OUTRO'
		                                END
			 ,'dvEmisor' = ' '	
			 ,'fechavta'			  = MIN(VENTAFECHAREAL)
	    FROM bactradersuda.dbo.mdvp WITH (NOLOCK), bactradersuda.dbo.view_instrumento b WITH (NOLOCK), bactradersuda.dbo.view_moneda c WITH (NOLOCK)
	   WHERE YEAR(VENTAFECHAREAL) = YEAR(@cFecRep)
		 AND CODIGO = incodigo
		 AND MONEMIS = mncodmon
		 AND 1=2
	   GROUP BY RUT_CARTERA,NUMDOCU,CORRELA



   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZAR REGISTROS DE CLIENTE SOBRE TABLA DE RENTA FIJA                   */
   /*-----------------------------------------------------------------------------*/
   	 UPDATE #CARTERA_RF
	    SET CalJur = 
			CASE 
			WHEN cltipcli = 8 THEN 'PF'
			WHEN cltipcli = 1 THEN 'IF'
			WHEN cltipcli = 2 THEN 'IF'
			WHEN cltipcli = 3 THEN 'IF'
			WHEN cltipcli = 4 THEN 'IF'
			WHEN cltipcli = 5 THEN 'IF'
			WHEN cltipcli = 6 THEN 'IF'
			WHEN cltipcli = 7 THEN 'PJ'
			WHEN cltipcli = 9 THEN 'PJ'
			WHEN cltipcli = 10 THEN 'PJ'
			WHEN cltipcli = 11 THEN 'PJ'
			WHEN cltipcli = 12 THEN 'PJ'
			WHEN cltipcli = 13 THEN 'PJ'
			ELSE  'PJ'
		END 
		 , Pais   = COD_ITAU
		 ,dvEmisor = cldv
	FROM  bactradersuda.dbo.VIEW_CLIENTE
	     ,BACPARAMSUDA.DBO.PAIS 
	WHERE clrut = Rutemi 
	  AND clpais = codigo_pais




   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES AUXILIARES                                         */
   /*-----------------------------------------------------------------------------*/
	 DECLARE @nUf_Hoy	    FLOAT
		    ,@nUf_comp	    FLOAT
			,@ValCapitalUm  FLOAT
			,@nReajustesDev NUMERIC(19,4)




   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DEL CURSOR                                         */
   /*-----------------------------------------------------------------------------*/
      DECLARE @CUR_ID               INT
	         ,@CUR_dimoneda         INT
			 ,@CUR_inserie          VARCHAR(30)
			 ,@CUR_cptipcart        INT
	         ,@CUR_cpfeccomp        DATETIME
			 ,@CUR_fechavta         DATETIME
			 ,@CUR_ValCapital       NUMERIC(19,4)
			 ,@CUR_cpseriado        CHAR(01)
			 ,@CUR_cpmascara        VARCHAR(10)
			 ,@CUR_cpfecucup        DATETIME
			 ,@CUR_Fecha_PagoManana DATETIME

			 


   /*-----------------------------------------------------------------------------*/
   /* SE INICIARA CURSOR PARA LOGRAR DETERMINAR VALORES EN LA CONSULTA            */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_OPERACIONES CURSOR LOCAL FOR
      SELECT ID               
	        ,dimoneda         
			,inserie          
			,cptipcart        
	        ,cpfeccomp        
			,fechavta         
			,ValCapital       
			,cpseriado        
			,cpmascara        
			,cpfecucup        
			,Fecha_PagoManana 
        FROM #CARTERA_RF
	   


        OPEN CURSOR_OPERACIONES
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_ID               
	                                          ,@CUR_dimoneda         
			                                  ,@CUR_inserie          
			                                  ,@CUR_cptipcart        
	                                          ,@CUR_cpfeccomp        
			                                  ,@CUR_fechavta         
			                                  ,@CUR_ValCapital       
			                                  ,@CUR_cpseriado        
			                                  ,@CUR_cpmascara        
			                                  ,@CUR_cpfecucup        
			                                  ,@CUR_Fecha_PagoManana 


   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN


	   /*-----------------------------------------------------------------*/
	   /* CALCULO VALORES DE MONEDA                                       */
	   /*-----------------------------------------------------------------*/
		 IF @tc_rep_cnt = 'S' AND @CUR_dimoneda= 994	
		 BEGIN
			 SELECT @nUf_Hoy  =  Tipo_Cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK) WHERE Codigo_Moneda = @CUR_dimoneda and Fecha = @CUR_fechavta
	         SELECT @nUf_comp =  Tipo_Cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK) WHERE Codigo_Moneda = @CUR_dimoneda and Fecha = @CUR_cpfeccomp
	     END 
		 ELSE BEGIN 

			SELECT @nUf_Hoy   =  vmvalor FROM BacTraderSuda.dbo.view_Valor_moneda WITH (NOLOCK) WHERE vmcodigo = @CUR_dimoneda and Vmfecha = @CUR_fechavta
        	SELECT @nUf_comp  =  vmvalor FROM BacTraderSuda.dbo.view_Valor_moneda WITH (NOLOCK) WHERE vmcodigo = @CUR_dimoneda and Vmfecha = @CUR_cpfeccomp
		 END


		 IF @CUR_dimoneda = 13 OR @CUR_dimoneda = 999 BEGIN
			SELECT @nUf_Hoy  = 1
			SELECT @nUf_comp = 1
		END	

	   /*-----------------------------------------------------------------*/
	   /* SETEO DE VALORES                                                */
	   /*-----------------------------------------------------------------*/
		SELECT @ValCapitalUm = ROUND(@CUR_ValCapital/@nUf_comp,4)

	    
	   /*-----------------------------------------------------------------*/
	   /* CALCULO DE INTERES                                              */
	   /*-----------------------------------------------------------------*/
		SELECT @nReajustesDev  = CASE WHEN (@CUR_dimoneda <> 999 AND @CUR_dimoneda <> 13)  THEN ROUND(( @nUf_Hoy - @nUf_comp ) * @ValCapitalUm, 0) ELSE 0.0 END


	   /*-----------------------------------------------------------------*/
	   /* ACTUALIZO INTERES                                               */
	   /*-----------------------------------------------------------------*/
		 UPDATE #CARTERA_RF
		    SET	InteresDev  = ISNULL(InteresDev + @nReajustesDev,0)
		  WHERE ID = @CUR_ID



       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_ID               
	                                          ,@CUR_dimoneda         
			                                  ,@CUR_inserie          
			                                  ,@CUR_cptipcart        
	                                          ,@CUR_cpfeccomp        
			                                  ,@CUR_fechavta         
			                                  ,@CUR_ValCapital       
			                                  ,@CUR_cpseriado        
			                                  ,@CUR_cpmascara        
			                                  ,@CUR_cpfecucup        
			                                  ,@CUR_Fecha_PagoManana   



     END
     CLOSE CURSOR_OPERACIONES
     DEALLOCATE CURSOR_OPERACIONES




   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE TABLA TEMPORAL                                                    */
   /*-----------------------------------------------------------------------------*/
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
	   FROM #CARTERA_RF

END
GO
