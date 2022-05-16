USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_DATOS_RF_BONES]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_ADM_DATOS_RF_BONES]  
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
     --EXEC Reportes.dbo.SP_ADM_DATOS_RF_BONES '2015-12-30'
	 
     DECLARE @FechaRep DATETIME = @cFecRep

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
	  ,dvEmisor          VARCHAR (10))
	 
   /*-----------------------------------------------------------------------------*/
   /* INGRESO DE REGISTROS                                                        */
   /*-----------------------------------------------------------------------------*/
     INSERT INTO #CARTERA_RF
      SELECT 'fechaProceso'	        =  @FechaRep 
		   , 'Sistema'	            =  'BTR' 
		   , 'cprutcart'	        =  rsrutcart 
	       , 'cpnumdocu'	        =  rsnumdocu
		   , 'cpcorrela'	        =  rscorrelativo
		   , 'cptipcart'              =  CASE WHEN cc.codigo_carterasuper = 'P' THEN 1
									          WHEN cc.codigo_carterasuper = 'A' THEN 2
									          WHEN cc.codigo_carterasuper = 'H' THEN 4										  
									          ELSE 1 
							           END

		   , 'Fecproc'              =  @FechaRep
		   , 'CodOrigen'            =  'RNIII'
		   , 'inserie'              =  ISNULL((SELECT i.Nom_Familia FROM BacBonosExtSuda..text_fml_inm i  WITH (NOLOCK) WHERE i.cod_familia = cc.cod_familia),'') 
		   , 'CodEmpresa'           =  '0769' 
		   , 'FecEmi'               =  ISNULL((SELECT ISNULL(s.fecha_emis,'19000101') FROM BacBonosExtSuda..text_ser s  WITH (NOLOCK) WHERE  cod_nemo = cc.cod_nemo),mofecemi)		 		  
	       , 'cpfeccomp'            =  rsfeccomp 
		   , 'fecvenc'              =  ISNULL((SELECT s.fecha_vcto FROM BacBonosExtSuda..text_ser s  WITH (NOLOCK) WHERE  cod_nemo = cc.cod_nemo),mofecven)	 								
		   , 'mnnemo'		        =  ISNULL((SELECT mnnemo		FROM BacParamSuda.dbo.MONEDA  WITH (NOLOCK) WHERE mncodmon = rsmonemi),'')			 	
		   
		   , 'TasEmi'		        =  ISNULL((SELECT tasa_emis	FROM BacBonosExtSuda..text_ser		 WITH (NOLOCK)  WHERE cod_nemo = cc.cod_nemo),0) 
	       , 'Emisor'		        =  ISNULL((SELECT substring(nom_emi,1,40)	FROM BacBonosExtSuda..text_emi_itl	 WITH (NOLOCK)  WHERE rut_emi	= morutemi),'')
		   , 'CodEmisor'            =  '0000'
		   , 'Rutemi'               =  morutemi
		   , 'CalJur'               =  '  '
		   , 'Pais'                 =  CONVERT(VARCHAR(50),'') 
		   , 'Cartera'               = CASE WHEN cc.codigo_carterasuper = 'P' THEN 'AV'
									        WHEN cc.codigo_carterasuper = 'A' THEN 'HD'
									        WHEN cc.codigo_carterasuper = 'T' THEN 'TR'
										    ELSE 'TR'										    
							          END
		   , 'Valcomp'		        =  ISNULL(rsvalcomu,0) 
		   , 'ValCapital'		    =  ISNULL(rsvalcomu,0) 
		   , 'InteresDev'	        =  ISNULL(CONVERT(FLOAT,0),0)
		   , 'Cosif'		        =  SPACE(12)  
		   , 'Cosif_Ger'	        =  SPACE(12) 
		   , 'ValMdo'	            =  CONVERT(NUMERIC(19,4),0) 
		   , 'Util_Mercado'         =  CONVERT(NUMERIC(19,4),0) 
		   , 'Perd_Mercado'         =  CONVERT(NUMERIC(19,4),0) 
		   , 'InteresDevAno'	    =  ISNULL(CONVERT(NUMERIC(19,4),0),0)
		   , 'ReajustesDevAno'      =  CONVERT(NUMERIC(19,4),0) 
		   , 'DifMercano'		    =  CONVERT(NUMERIC(19,4),0) 
		   , 'ValcompAno'           =  CASE WHEN YEAR(rsfeccomp) = YEAR(@FechaRep) THEN ISNULL(rsvalcomu,0) ELSE ISNULL(CONVERT(NUMERIC(19,4),0),0) END 
		   , 'ValorVenta'		    =  CONVERT(NUMERIC(19,4),0)
		   , 'InteresesporVenta'    =  CONVERT(NUMERIC(19,4),0)
		   , 'UtilporVenta'         =  CONVERT(NUMERIC(19,4),0)
		   , 'monedaor'             = 'CLP' 
		   , 'CtaAltamira'          =  SPACE(12) 
		   , 'cpinstser'		    = cc.id_instrum
		   , 'dimoneda'			    = rsmonemi   
		   , 'Prog'                 = '_val_ins' --b.inprog	   											--PENDIENTE
		   , 'cpcodigo'             = cc.cod_familia  
		   , 'difecsal'             = '' 
		   , 'BasEmi'               = ISNULL((SELECT s.base_tasa_emi FROM BacBonosExtSuda..text_ser s  WITH (NOLOCK) WHERE  cod_nemo = cc.cod_nemo),0) 
		   , 'cpnominal'            = rsnominal 	
		   , 'cptircomp'            = motir 	
		   , 'cpvalcomu'            = rsvalcomu 
		   , 'Valor_Contable'       = rsvalcomu 
		   , 'Tasa_Contrato'        = motir
		   , 'cpmascara'            = cc.id_instrum 
		   , 'cpseriado'            = 'S' 
		   , 'Fecha_PagoMañana'     = rsfecpago
		   , 'cpfecpcup'		    = rsfecpcup
		   , 'cpFecucup'		    = rsFecucup
		   , 'Pendiente_Pago'       = CASE WHEN rsfecpago <= @FechaRep THEN 'N' ELSE 'S' END 
		   , 'Codigo_Producto'      = 0																			       --PENDIENTE
		   , 'Monto_Pago'           = CASE WHEN rsfecpago <= @FechaRep THEN CONVERT(NUMERIC(17,2),0) ELSE rsnominal END
		   , 'Rut_Cliente'          = 0 																				--PENDIENTE
		   , 'PERIODICIDAD'         = CASE WHEN (SELECT ts.per_cupones 
												 FROM	BacBonosExtSuda..text_ser ts 
												 WHERE	ts.Cod_familia	= cc.cod_familia
										 		  AND	ts.cod_nemo		= cc.cod_nemo ) = 6 
										 	THEN 'SEMESTRAL'
										 	ELSE 'OUTRO' 
		                              END
		  , 'dvEmisor'		 = ' '					
      FROM BacBonosExtSuda.dbo.text_rsu          cc
	 INNER JOIN BacBonosExtSuda.dbo.text_mvt_dri tmd 
	    ON tmd.monumdocu     =  cc.rsnumdocu
	   AND tmd.monumoper     =  cc.rsnumoper
	   AND tmd.mocorrelativo =  cc.rscorrelativo
	   AND tmd.motipoper     ='CP'
	 WHERE CC.rsfecpro       = @FechaRep 
	   AND CC.rsnominal      > 0



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
