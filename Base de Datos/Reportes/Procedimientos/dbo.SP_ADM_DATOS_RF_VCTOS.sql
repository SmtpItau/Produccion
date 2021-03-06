USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_DATOS_RF_VCTOS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create PROCEDURE [dbo].[SP_ADM_DATOS_RF_VCTOS]  
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
     --EXEC Reportes.dbo.SP_ADM_DATOS_RF_VCTOS '2015-12-30'
	 
   
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
	  ,fechavta          DATETIME )

	 

   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE REGISTROS                                                        */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO #CARTERA_RF
	  SELECT  'fechaProceso'	      = @FechaRep  
			, 'Sistema'	              = 'BTR' 
			, 'rsrutcart'		      = rsrutcart
			, 'rsnumdocu'		      = rsnumdocu
			, 'rscorrela'		      = rscorrela
			, 'TIPO_CARTERA'          = MIN(rstipcart)
			, 'Fecproc'		          = @FechaRep
			, 'CodOrigen'		      = 'RNIII'
			, 'inserie'			      = MIN(b.inserie)
			, 'CodEmpresa'		      = '0769'
			, 'FecEmi'			      = MIN(rsfecemis)
			, 'fecha_compra_original' = MIN(rsfeccomp)
			, 'fecvenc'				  = MIN(rsfecvcto)
			, 'mnnemo'				  = MIN(c.mnnemo)
			, 'TasEmi'				  = MIN(rstasemi)
			, 'Emisor'				  = (SELECT Emnombre FROM bactradersuda.dbo.view_emisor WHERE emrut = Min(rsrutemis))
			, 'CodEmisor'			  = '0000'
			, 'Rutemi'				  = MIN(rsrutemis)
			, 'CalJur'				  = '  '
			, 'Pais'				  = CONVERT(VARCHAR(80),'')
		    , 'Cartera'               = CASE WHEN codigo_carterasuper = 'P' THEN 'AV'
									       WHEN codigo_carterasuper = 'A' THEN 'HD'
									       WHEN codigo_carterasuper = 'T' THEN 'TR'
										   ELSE 'TR'										    
							          END
			, 'Valcomp'				 = CONVERT(NUMERIC(19,4),0) -- VGS 03/12/2008 SUM(VALCOMP),
			, 'ValCapital'           = CONVERT(NUMERIC(19,4),0)
			, 'InteresDev'	         = ISNULL(CONVERT(FLOAT,0),0)
			, 'Cosif'	             = SPACE(12)
			, 'Cosif_Ger'            = SPACE(12)
			, 'ValMdo'				 = CONVERT(NUMERIC(19,4),0)
			, 'Util_Mercado'         = CONVERT(NUMERIC(19,4),0)
			, 'Perd_Mercado'         = CONVERT(NUMERIC(19,4),0)
			, 'InteresDevAno'		 = ISNULL(CONVERT(NUMERIC(19,4),0),0)
			, 'ReajustesDevAno'      = CONVERT(NUMERIC(19,4),0)
			, 'DifMercano'           = CONVERT(NUMERIC(19,4),0)
			, 'ValcompAno'           = ISNULL(CONVERT(NUMERIC(19,4),0),0)
			, 'ValorVenta'           = CONVERT(NUMERIC(19,4),0)
			, 'InteresesporVenta'	 = SUM(rsflujo)
			, 'UtilporVenta'         = CONVERT(NUMERIC(19,4),0)
			, 'monedaor'             = 'CLP'
			, 'CtaAltamira'			 = SPACE(12)
			, 'moinstser'			 = MIN(rsinstser)
			, 'momonemi'			 = MIN(rsmonemi)
			, 'Prog'				 = 'SP_'+ MIN(inprog)
			, 'mocodigo'			 = MIN(rscodigo)
			, 'difecsal'			 = '1900-01-01'
			, 'BasEmi'				 = MIN(rsbasemi)
			, 'monominal'			 = SUM(rsnominal)
			, 'tir_compra_original'  = MIN(rstir)
			, 'movalcomu'			 = CONVERT(NUMERIC(19,4),0)
			, 'Valor_Contable'		 = CONVERT(NUMERIC(19,4),0)
			, 'Tasa_Contrato'		 = MIN(ISNULL(Tasa_Contrato,0))
			, 'cpmascara'			 = MIN(rsmascara)
			, 'cpseriado'			 = CASE WHEN MIN(b.inmdse) = 'S' THEN 'S' ELSE 'N' END
			, 'Fecha_PagoMañana'     = MIN(Fecha_PagoMañana)
			, 'cpfecpcup'			 = MIN(rsfecpcup)
			, 'cpFecucup'			 = MIN(rsfecucup)
			, 'Pendiente_Pago'		 = 'N'
			, 'Codigo_Producto'      = CASE WHEN MIN(rscodigo) = 98 THEN 33 ELSE 29 END
			, 'Monto_Pago'           = CONVERT(NUMERIC(17,2),0)
			, 'Rut_Cliente'          = CONVERT(NUMERIC(30),0) 
			, 'PERIODICIDAD'		 = CASE WHEN   MIN(b.inserie) =  'BCP'  THEN 'SEMESTRAL' 
											 WHEN  MIN(b.inserie) =  'BCU'  THEN 'SEMESTRAL' 					
											 WHEN  MIN(b.inserie) =  'BTP'  THEN 'SEMESTRAL' 
											 WHEN  MIN(b.inserie) =  'BTU'  THEN 'SEMESTRAL' 
											 WHEN  MIN(b.inserie) =  'PRC'  THEN 'SEMESTRAL' 

											 WHEN  MIN(b.inserie) =  'BONOS'THEN 'SEMESTRAL' 
											 WHEN  MIN(b.inserie) =  'LCHR' THEN 'TRIMESTRAL' 

											 
											 WHEN  MIN(b.inserie) =  'CERO' THEN 'OUTRO'
											 WHEN  MIN(b.inserie) =  'DPF'  THEN 'OUTRO'
											 WHEN  MIN(b.inserie) =  'DPR'  THEN 'OUTRO'
											 WHEN  MIN(b.inserie) =  'PDBC' THEN 'OUTRO'
											 WHEN  MIN(b.inserie) =  'DPX'  THEN 'OUTRO'
										ELSE 'OUTRO'
			                		   END
			,  'dvEmisor'		   = ' '			                		   
			, 'fechavta'			 = MIN(rsfecvcto)
	 FROM bactradersuda.dbo.mdrs WITH (NOLOCK), bactradersuda.dbo.view_instrumento b WITH (NOLOCK), bactradersuda.dbo.view_moneda c WITH (NOLOCK)
	WHERE  YEAR(rsfecha)  = YEAR(@FechaRep)
			AND rstipoper = 'VC' 
			AND rscartera in('111','114','159') 
			AND rsvppresenx = 0
			AND rscodigo = b.incodigo
			AND rsmonemi = c.mncodmon
	GROUP BY rsrutcart, rsnumdocu,rscorrela,mdrs.codigo_carterasuper



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
	 DECLARE @anno          INT
			,@dFecAnoAnt    DATETIME
			,@nMtoCortes	NUMERIC(19,4)
			,@dFecMcdo      DATETIME
			,@ValMcdo	    NUMERIC(19,4)
			,@nNominalAnt   NUMERIC(19,4)





   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DEL CURSOR                                         */
   /*-----------------------------------------------------------------------------*/
      DECLARE @CUR_ID                INT
	         ,@CUR_cpfeccomp         DATETIME
			 ,@CUR_cprutcart         NUMERIC(10)
			 ,@CUR_cpnumdocu         NUMERIC(10)
			 ,@CUR_cpcorrela         NUMERIC(05)
			 ,@CUR_cpcodigo          NUMERIC(5)
	         ,@CUR_dimoneda          INT
			 ,@CUR_cpnominal         NUMERIC(30, 4)
			 ,@CUR_cpmascara         VARCHAR(10)
			 ,@CUR_Fecha_PagoManana  DATETIME
			 ,@CUR_InteresesporVenta numeric (30, 4)
			 ,@CUR_cpseriado         CHAR(01)
			 ,@CUR_inserie           VARCHAR(30)
			 ,@CUR_cptipcart         INT
			 ,@CUR_FecEmi            DATETIME
			 			 			 


   /*-----------------------------------------------------------------------------*/
   /* SE INICIARA CURSOR PARA LOGRAR DETERMINAR VALORES EN LA CONSULTA            */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_OPERACIONES CURSOR LOCAL FOR
      SELECT ID                
	        ,cpfeccomp         
			,cprutcart         
			,cpnumdocu         
			,cpcorrela         
			,cpcodigo          
	        ,dimoneda          
			,cpnominal         
			,cpmascara         
			,Fecha_PagoManana  
			,InteresesporVenta 
			,cpseriado         
			,inserie           
			,cptipcart  
			,FecEmi           
        FROM #CARTERA_RF
	   


        OPEN CURSOR_OPERACIONES
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_ID                
	                                          ,@CUR_cpfeccomp         
			                                  ,@CUR_cprutcart         
			                                  ,@CUR_cpnumdocu         
			                                  ,@CUR_cpcorrela         
			                                  ,@CUR_cpcodigo          
	                                          ,@CUR_dimoneda          
			                                  ,@CUR_cpnominal         
			                                  ,@CUR_cpmascara         
			                                  ,@CUR_Fecha_PagoManana  
			                                  ,@CUR_InteresesporVenta 
			                                  ,@CUR_cpseriado         
			                                  ,@CUR_inserie           
			                                  ,@CUR_cptipcart  
											  ,@CUR_FecEmi       
	                                          
			                                  
			                                  
	                                          
			                                  
			                                  
			                                  
			                                  
			                                  
			                                  


   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN


	   /*-----------------------------------------------------------------*/
	   /* CALCULO FECHAS                                                  */
	   /*-----------------------------------------------------------------*/
        SELECT @anno       = YEAR(@cFecRep)
		SELECT @dFecAnoAnt = STR(YEAR(@cFecRep)-1,4)+'1231'


		IF YEAR(@CUR_cpfeccomp) = @anno BEGIN
			SELECT @dFecMcdo = CASE WHEN @CUR_cpfeccomp < @CUR_Fecha_PagoManana and @CUR_cpfeccomp < @cFecRep THEN @CUR_Fecha_PagoManana ELSE @CUR_cpfeccomp END
		END
		ELSE BEGIN
			SELECT @dFecMcdo = @dFecAnoAnt
		END

		SELECT 	@ValMcdo     = 0		


	   /*-----------------------------------------------------------------*/
	   /* VALORIZACION DE MERCADO                                         */
	   /*-----------------------------------------------------------------*/
	       SET @nNominalAnt  = 0
		   SET @ValMcdo      = 0
		SELECT 	@ValMcdo     = ISNULL(SUM(valor_mercado),0)
			   ,@nNominalAnt = SUM(valor_nominal)
		  FROM bactradersuda.dbo.VALORIZACION_MERCADO
		 WHERE fecha_valorizacion = @FECHAREP
		   and rmrutcart          = @CUR_cprutcart AND
		       rmnumdocu          = @CUR_cpnumdocu AND
			   rmcorrela          = @CUR_cpcorrela
		GROUP BY rmrutcart,rmnumdocu,rmcorrela
		

		--SELECT @FECHAREP,@CUR_cprutcart,@CUR_cpnumdocu,@CUR_cpcorrela,@ValMcdo,@nNominalAnt



		SELECT @ValMcdo = ROUND((@CUR_cpnominal/@nNominalAnt) * @ValMcdo,0)
		


	   /*-----------------------------------------------------------------*/
	   /* CALCULO DESCUENTA CUPONES                                       */
	   /*-----------------------------------------------------------------*/
		SELECT @nMtoCortes = 0.0
		IF @CUR_cpseriado = 'S' BEGIN

			IF @tc_rep_cnt = 'S' AND @CUR_dimoneda = 994 BEGIN
			   EXECUTE bactradersuda.dbo.Sp_Descuenta_Cupones_tcrc @CUR_dimoneda,@CUR_cpnominal,@dFecMcdo,@cFecRep,@CUR_cpmascara,@CUR_FecEmi,@CUR_cpcodigo,@nMtoCortes OUTPUT
			END 
			ELSE BEGIN
  			   EXECUTE bactradersuda.dbo.Sp_Descuenta_Cupones @CUR_dimoneda,@CUR_cpnominal,@dFecMcdo,@cFecRep,@CUR_cpmascara,@CUR_FecEmi,@CUR_cpcodigo,@nMtoCortes OUTPUT
			END
		END

		


	   /*-----------------------------------------------------------------*/
	   /* ACTUALIZACION DE REGISTROS EN TABLA                             */
	   /*-----------------------------------------------------------------*/
		 UPDATE #CARTERA_RF
		   SET	DifMercano	= ISNULL((@CUR_InteresesporVenta - (@ValMcdo-@nMtoCortes)),0)
		 WHERE ID = @CUR_ID



       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_ID                
	                                          ,@CUR_cpfeccomp         
			                                  ,@CUR_cprutcart         
			                                  ,@CUR_cpnumdocu         
			                                  ,@CUR_cpcorrela         
			                                  ,@CUR_cpcodigo          
	                                          ,@CUR_dimoneda          
			                                  ,@CUR_cpnominal         
			                                  ,@CUR_cpmascara         
			                                  ,@CUR_Fecha_PagoManana  
			                                  ,@CUR_InteresesporVenta 
			                                  ,@CUR_cpseriado         
			                                  ,@CUR_inserie           
			                                  ,@CUR_cptipcart  
											  ,@CUR_FecEmi     



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
	        ,fechavta --difecsal          
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
