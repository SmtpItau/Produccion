USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_DATOS_RF_CARTERA]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ADM_DATOS_RF_CARTERA]
	(	@cFecRep DATETIME	)
AS
BEGIN

	SET NOCOUNT ON

	declare @dFecha_Gen_Tablas	datetime
		set @dFecha_Gen_Tablas	= (case	when month(@cFecRep) = 12 and day(@cFecRep) = 30 then '20161230'
										when month(@cFecRep) = 12 and day(@cFecRep) = 31 then '20161230'
										else @cFecRep
								   end)
 
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
   /* OBJETIVOS      : CARTERA RENTA FIJA SEGUN FECHA                              */
   /* AUTOR          : ROBERTO MORA DROGUETT                                       */
   /* FECHA CREACION : 04/03/2016                                                  */
   /*-----------------------------------------------------------------------------*/
   /*-----------------------------------------------------------------------------*/
     --EXEC Reportes.dbo.SP_ADM_DATOS_RF_CARTERA '2015-12-30'
	 
   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES                                                    */
   /*-----------------------------------------------------------------------------*/
	 DECLARE @DO_TC             FLOAT
            ,@QUERY             VARCHAR(MAX)
	        ,@tc_rep_cnt        VARCHAR(01)
			,@FechaRep          DATETIME
			,@FechaValorizacion Datetime

   /*-----------------------------------------------------------------------------*/
   /* MDCA TEMPORAL PARA CALCULOS                                                 */
   /*-----------------------------------------------------------------------------*/
	CREATE TABLE #MDAC
	(	acfecprox               DATETIME
	,	acfecproc               DATETIME
	)

	insert into #MDAC
	(	acfecprox
	,	acfecproc
	)
	select	FechasProceso.acfecprox
		,	FechasProceso.acfecproc
	from
	(	select	acfecante	= Fechas.acfecante
			,	acfecproc	= Fechas.acfecproc
			,	acfecprox	= Fechas.acfecprox
			,	acfecvalmer	= case	when month(Fechas.acfecproc) = month(Fechas.acfecprox) then Fechas.acfecproc 
									else dateadd(day, -1,dateadd(month, 1, dateadd(day, 1, dateadd(day, day(Fechas.acfecproc)*-1, Fechas.acfecproc ))))
		 	           		  end
		from
			(			select acfecante, acfecproc, acfecprox from BacTraderSuda.dbo.fechas_proceso with(nolock) 
				union	select acfecante, acfecproc, acfecprox from BacTradersuda.dbo.MDAC with(nolock)
			)	Fechas
		where	Fechas.acfecproc = @cFecRep
	)	FechasProceso

	if @@ROWCOUNT = 0
	begin
		insert into #MDAC
		(	acfecprox
		,	acfecproc
		)
		select	acfecprox
			,	acfecproc 
		from	BacTraderSuda.dbo.mdac with(nolock)
	end


	--> ************************************************************ <-- 
	-->	Esto hace reprocesable de Verdad la extraccion de las Fechas <-- 
	--> ************************************************************ <-- 
	
	/*
	   /*-----------------------------------------------------------------------------*/
	   /* CREACION DE TABLA SEGUN FECHA MDCP                                          */
	   /*-----------------------------------------------------------------------------*/
		 SET @QUERY = 'INSERT INTO #MDAC '
		 SET @QUERY = @QUERY + 'SELECT '
		 SET @QUERY = @QUERY + 'acfecprox' 
		 SET @QUERY = @QUERY + ',acfecproc'
	--	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDAC' + SUBSTRING(CONVERT(CHAR(8),@cFecRep,112),5,4)
		 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDAC' + SUBSTRING(CONVERT(CHAR(8),@dFecha_Gen_Tablas,112),5,4)

		EXEC(@QUERY)
	*/

	DECLARE @dFecProx		DATETIME
		SET @dFecProx		= (SELECT acfecprox FROM #MDAC);
		
	DECLARE @dFecProc		DATETIME
		SET @dFecProc		= (SELECT acfecproc FROM #MDAC);		  


	/*-----------------------------------------------------------------------------*/
	/* CALCULOS DE FECHAS Y VARIANTES                                              */
	/*-----------------------------------------------------------------------------*/

	/* Dolar T/C Rep. Contable */
	/*	
	SELECT @DO_TC = isnull(Tipo_Cambio,0)
       FROM BacParamSuda..VALOR_MONEDA_CONTABLE
		,	#MDAC WITH (NOLOCK)
      WHERE Codigo_Moneda = 994 
	    AND Fecha = acfecprox
	*/

	SET @DO_TC = isnull((	select	Tipo_Cambio 
	                     	from	BacParamSuda.dbo.valor_moneda_contable with(nolock) 
	                     	where	fecha			= @dFecProx 
	                     	and		codigo_moneda	= 994
						),	0.0)


	DECLARE @bFinAno		BIT 
		SET @bFinAno		= 0		

	IF YEAR(@dFecProc) != YEAR(@dFecProx) 
	BEGIN
		SET @bFinAno	= 1
		SET @dFecProx	= CONVERT(DATETIME,Str(DATEPART(YEAR,@dFecProc),4)+'1231') 		
	END  

	IF @DO_TC = 0
	BEGIN
		SELECT @tc_rep_cnt = 'N'   /* SE OCUPA T/C OBS */
	END ELSE 
	BEGIN
		SELECT @tc_rep_cnt = 'S'   /* SE OCUPA T/C REP CONTABLE */
	END


	SELECT	@FechaRep			= CONVERT(DATETIME,@cFecRep)

	DECLARE @contable			NUMERIC(19,4)
/*
	SELECT	@contable			= vmc.Tipo_Cambio
	FROM	BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vmc 
	WHERE	vmc.Fecha			= @dFecProc  
	AND		vmc.Codigo_Moneda	= 994
*/

	SET @contable = isnull((	select	Tipo_Cambio 
	                     		from	BacParamSuda.dbo.valor_moneda_contable with(nolock) 
	                     		where	fecha			= @dFecProc 
	                     		and		codigo_moneda	= 994
							),	0.0)



   /*-----------------------------------------------------------------------------*/
   /* CALCULO DE FECHA DE VALORIZACION PARA FINES ESPECIALES                      */
   /*-----------------------------------------------------------------------------*/
	/*
	SELECT	@FechaValorizacion = CASE	WHEN DATEPART(MONTH, contol.fechaproc) = DATEPART(MONTH, contol.fechaprox) THEN contol.fechaproc
										ELSE DATEADD( DAY, DAY(DATEADD(MONTH, 1, contol.fechaproc)) *-1, DATEADD(MONTH, 1, contol.fechaproc) )
									END
	FROM   
		(	select	fechaproc = @FechaRep
				,	fechaprox = @dFecProx
		)	contol

	set @FechaValorizacion	= (case	when month(@cFecRep) = 12 and day(@cFecRep) = 30 then '20161231'
									when month(@cFecRep) = 12 and day(@cFecRep) = 31 then '20161231'
									else @cFecRep
								end)
	*/


	set		@FechaValorizacion	= 
	(	select	acfecvalmer	= case	when month(Fechas.acfecproc) = month(Fechas.acfecprox) then Fechas.acfecproc 
									else dateadd(day, -1,dateadd(month, 1, dateadd(day, 1, dateadd(day, day(Fechas.acfecproc)*-1, Fechas.acfecproc ))))
								end
		from
			(	select	acfecprox, acfecproc
			 	from	#MDAC
			)	Fechas
		where	Fechas.acfecproc = @cFecRep
	)
	

	IF OBJECT_ID('tempdb..##CARTERA_RF') IS NOT NULL 
	BEGIN	
		DROP TABLE ##CARTERA_RF
	END

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
	  ,Fecha_PagoManana  datetime       NOT NULL
	  ,cpfecpcup         datetime           NOT NULL
	  ,cpFecucup         datetime           NOT NULL
	  ,Pendiente_Pago    char    (1)        NOT NULL
	  ,Codigo_Producto   int                NOT NULL
	  ,Monto_Pago        NUMERIC            NOT NULL
	  ,Rut_Cliente       NUMERIC            NOT NULL
	  ,Periodicidad      varchar (50)       NOT NULL
	  ,dvEmisor          VARCHAR (10))
	 

   /*-----------------------------------------------------------------------------*/
   /* CREACION DE ESTRUCTURA DE TABLA DINAMICA                                    */
   /*-----------------------------------------------------------------------------*/
     CREATE TABLE #MDCP
	 (cprutcart               NUMERIC
	 ,cpnumdocu               NUMERIC
	 ,cpcorrela               NUMERIC
	 ,cptipcart               INT
	 ,cpseriado               VARCHAR(02)
	 ,cpfeccomp               DATETIME
	 ,cpfecpcup               DATETIME
	 ,cpFecucup               DATETIME
	 ,cpmascara               VARCHAR(20)
	 ,codigo_carterasuper     VARCHAR(02)
	 ,cpinstser               VARCHAR(20)
	 ,cpcodigo                INT
	 ,cptircomp               FLOAT
	 ,cpvalcomu               NUMERIC
	 ,Fecha_PagoMañana        DATETIME
	 ,cpnominal               NUMERIC
	 ,cpvalcomp               NUMERIC)


   /*-----------------------------------------------------------------------------*/
   /* CREACION DE ESTRUCTURA DE TABLA DINAMICA                                    */
   /*-----------------------------------------------------------------------------*/
     CREATE TABLE #MDDI
	 (dirutcart               NUMERIC
	 ,dinumdocu               NUMERIC
	 ,dicorrela               NUMERIC
	 ,dimoneda                INT
	 ,difecsal                DATETIME)



   /*-----------------------------------------------------------------------------*/
   /* CREACION DE ESTRUCTURA DE TABLA DINAMICA                                    */
   /*-----------------------------------------------------------------------------*/
     CREATE TABLE #MDVI
	 (virutcart               NUMERIC
	 ,vinumdocu               NUMERIC
	 ,vicorrela               NUMERIC
	 ,vivalcomp               NUMERIC
	 ,vinominal               NUMERIC)
	 


   
   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA SEGUN FECHA MDCP                                          */
   /*-----------------------------------------------------------------------------*/
     SET @QUERY = 'INSERT INTO #MDCP '
	 SET @QUERY = @QUERY + 'SELECT '
	 SET @QUERY = @QUERY + 'cprutcart' 
	 SET @QUERY = @QUERY + ',cpnumdocu'
	 SET @QUERY = @QUERY + ',cpcorrela'
	 SET @QUERY = @QUERY + ',cptipcart'
	 SET @QUERY = @QUERY + ',cpseriado'
	 SET @QUERY = @QUERY + ',cpfeccomp'
	 SET @QUERY = @QUERY + ',cpfecpcup'
	 SET @QUERY = @QUERY + ',cpFecucup'
	 SET @QUERY = @QUERY + ',cpmascara'
	 SET @QUERY = @QUERY + ',codigo_carterasuper'
	 SET @QUERY = @QUERY + ',cpinstser'          
	 SET @QUERY = @QUERY + ',cpcodigo'           
	 SET @QUERY = @QUERY + ',cptircomp'          
	 SET @QUERY = @QUERY + ',cpvalcomu'          
	 SET @QUERY = @QUERY + ',Fecha_PagoMañana'   
	 SET @QUERY = @QUERY + ',cpnominal' 
	 SET @QUERY = @QUERY + ',cpvalcomp' 
--	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDCP' + SUBSTRING(CONVERT(CHAR(8),@FechaRep,112),5,4)
	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDCP' + SUBSTRING(CONVERT(CHAR(8),@dFecha_Gen_Tablas,112),5,4)

	 EXEC (@QUERY)

   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA SEGUN FECHA MDCP                                          */
   /*-----------------------------------------------------------------------------*/
     SET @QUERY = 'INSERT INTO #MDDI '
	 SET @QUERY = @QUERY + 'SELECT '
	 SET @QUERY = @QUERY + 'dirutcart' 
	 SET @QUERY = @QUERY + ',dinumdocu'
	 SET @QUERY = @QUERY + ',dicorrela'
	 SET @QUERY = @QUERY + ',dimoneda'
	 SET @QUERY = @QUERY + ',difecsal'
--	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDDI' + SUBSTRING(CONVERT(CHAR(8),@FechaRep,112),5,4)
	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDDI' + SUBSTRING(CONVERT(CHAR(8),@dFecha_Gen_Tablas,112),5,4)

	 EXEC (@QUERY)

   /*-----------------------------------------------------------------------------*/
   /* CREACION DE TABLA SEGUN FECHA MDCP                                          */
   /*-----------------------------------------------------------------------------*/
     SET @QUERY = 'INSERT INTO #MDVI '
	 SET @QUERY = @QUERY + 'SELECT '
	 SET @QUERY = @QUERY + 'virutcart' 
	 SET @QUERY = @QUERY + ',vinumdocu'
	 SET @QUERY = @QUERY + ',vicorrela'
	 SET @QUERY = @QUERY + ',vivalcomp'
	 SET @QUERY = @QUERY + ',vinominal'
--	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDVI' + SUBSTRING(CONVERT(CHAR(8),@FechaRep,112),5,4)
	 SET @QUERY = @QUERY + ' FROM bactradersuda.dbo.MDVI' + SUBSTRING(CONVERT(CHAR(8),@dFecha_Gen_Tablas,112),5,4)
	 
	 EXEC (@QUERY)

   /*-----------------------------------------------------------------------------*/
   /* SALIDA DE DATOS                                                             */
   /*-----------------------------------------------------------------------------*/
      INSERT INTO #CARTERA_RF
	  SELECT 'fechaProceso'	        = @FechaRep 	
		   , 'Sistema'	            = 'BTR' 
		   ,  'cprutcart'	        = cprutcart 
	       , 'cpnumdocu'	        = cpnumdocu
		   , 'cpcorrela'	        = cpcorrela
		   , 'cptipcart'	        = cptipcart
		   , 'Fecproc'              = @FechaRep
		   , 'CodOrigen'            = 'RNIII'
		   , 'inserie'              =  CONVERT(VARCHAR(30), IT.inserie) 
		   , 'CodEmpresa'           = '0769'
		   , 'FecEmi'               = CASE WHEN cpseriado = 'S' THEN (SELECT ISNULL(sefecemi, '19000101') 
		                                                               FROM bactradersuda.dbo.VIEW_SERIE WITH(NOLOCK)
																	  Where semascara =  CP.cpmascara)
		    				      	 	   ELSE (SELECT ISNULL(nsfecemi, '19000101') 
										           FROM bactradersuda.dbo.VIEW_NOSERIE  WITH(NOLOCK)
												  Where nsrutcart = CP.cprutcart 
												    AND nsnumdocu = CP.cpnumdocu 
													AND nscorrela = CP.cpcorrela)
							          END
	       , 'cpfeccomp'            = cpfeccomp
		   , 'fecvenc'              = CASE WHEN cpseriado = 'S' THEN cpfecpcup
							                                    ELSE (SELECT nsfecven 
																        FROM bactradersuda.dbo.VIEW_NOSERIE  WITH(NOLOCK)
																	   WHERE nsrutcart = CP.cprutcart 
																	     AND nsnumdocu = CP.cpnumdocu 
																		 AND nscorrela = CP.cpcorrela)
				   		              END
		   , 'mnnemo'		        = MO.mnnemo
		   , 'TasEmi'		        = CASE WHEN cpseriado = 'S' THEN (SELECT setasemi 
		                                                                FROM bactradersuda.dbo.VIEW_SERIE  WITH(NOLOCK) 
																	   WHERE semascara = CP.cpmascara )
		   					      	 						 ELSE cptircomp
		   				              END
	      ,  'Emisor'		        = (SELECT Emnombre 
		                                 from bactradersuda.dbo.view_emisor 
										WHERE emrut = (CASE WHEN cpseriado = 'S' THEN ( SELECT serutemi 
							    					 								      FROM bactradersuda.dbo.VIEW_SERIE WITH (NOLOCK)
							    														 WHERE  semascara = cpmascara) 
							    							ELSE (SELECT nsrutemi 
							    							        FROM bactradersuda.dbo.VIEW_NOSERIE WITH (NOLOCK)
							    							 	   WHERE nsrutcart = CP.cprutcart 
																     AND nsnumdocu = CP.cpnumdocu 
																	 AND nscorrela = CP.cpcorrela) 
							    					   END))
		   , 'CodEmisor'            = '0000'
		   , 'Rutemi'               = CASE WHEN cpseriado = 'S' THEN (SELECT serutemi 
		                                          FROM bactradersuda.dbo.VIEW_SERIE    WITH(NOLOCK) 
																	   WHERE  semascara = CP.cpmascara )
							      	 						    ELSE (SELECT nsrutemi 
																        FROM bactradersuda.dbo.VIEW_NOSERIE  WITH(NOLOCK) 
																	   WHERE nsrutcart = cprutcart 
																	     AND nsnumdocu = cpnumdocu 
																		 AND nscorrela = cpcorrela)
		                              END
		  , 'CalJur'                = '  '
		  , 'Pais'                  = CONVERT(VARCHAR(50),'')
		  , 'Cartera'               = CASE WHEN CP.codigo_carterasuper = 'P' THEN 'AV'
									       WHEN CP.codigo_carterasuper = 'A' THEN 'HD'
									       WHEN CP.codigo_carterasuper = 'T' THEN 'TR'
										   ELSE 'TR'										    
							          END
		   , 'Valcomp'		        = cpValcomp
		   , 'ValCapital'		    = cpValcomp
		   , 'InteresDev'	        = ISNULL(CONVERT(FLOAT,0),0)
		   , 'Cosif'		        = SPACE(12)
		   , 'Cosif_Ger'	        = SPACE(12)
		   , 'ValMdo'	            = CONVERT(NUMERIC(19,4),0)
		   , 'Util_Mercado'         = CONVERT(NUMERIC(19,4),0)
		   , 'Perd_Mercado'         = CONVERT(NUMERIC(19,4),0)
		   , 'InteresDevAno'	    = ISNULL(CONVERT(NUMERIC(19,4),0),0)
		   , 'ReajustesDevAno'      = CONVERT(NUMERIC(19,4),0)
		   , 'DifMercano'		    = CONVERT(NUMERIC(19,4),0)
		   , 'ValcompAno'           = CASE WHEN YEAR(cpfeccomp) = YEAR(@FechaRep) THEN ISNULL(cpvalcomp,0) ELSE ISNULL(CONVERT(NUMERIC(19,4),0),0) END
		   , 'ValorVenta'		    = CONVERT(NUMERIC(19,4),0)
		   , 'InteresesporVenta'    = CONVERT(NUMERIC(19,4),0)
		   , 'UtilporVenta'         = CONVERT(NUMERIC(19,4),0)
		   , 'monedaor'             = 'CLP'
		   , 'CtaAltamira'          = SPACE(12)
		   , 'cpinstser'		    = CONVERT(VARCHAR(30),cpinstser)
		   , 'dimoneda'			    = dimoneda
		   , 'Prog'                 = 'SP_'+ IT.inprog
		   , 'cpcodigo'             = CP.cpcodigo
		   , 'difecsal'             = DI.difecsal
		   , 'BasEmi'               = CASE WHEN CP.cpseriado = 'S' THEN (SELECT sebasemi 
		                                                                   FROM bactradersuda.dbo.VIEW_SERIE   
																		  WHERE cpmascara = semascara)
		   											  	           ELSE (SELECT nsbasemi 
																           FROM bactradersuda.dbo.VIEW_NOSERIE 
																		  WHERE nsrutcart = CP.cprutcart 
																		    AND nsnumdocu = CP.cpnumdocu 
																			AND nscorrela = CP.cpcorrela)
		   						      END
		   , 'cpnominal'            = cpnominal
		   , 'cptircomp'            = cptircomp
		   , 'cpvalcomu'            = cpvalcomu
		   , 'Valor_Contable'       = cpvalcomp
		   , 'Tasa_Contrato'        = cptircomp
		   , 'cpmascara'            = CONVERT(VARCHAR(20),cpmascara)
		   , 'cpseriado'            =  cpseriado
		   , 'Fecha_PagoMañana'     = CASE WHEN cpfeccomp < CONVERT(DATETIME,'20070115') THEN Fecha_PagoMañana ELSE cpfeccomp END
		   , 'cpfecpcup'		    = cpfecpcup
		   , 'cpFecucup'		    = cpFecucup
		   , 'Pendiente_Pago'       = CASE WHEN Fecha_PagoMañana <= @FechaRep THEN 'N' ELSE 'S' END
		   , 'Codigo_Producto'      = CASE WHEN cpcodigo = 98 THEN 33 ELSE 29 END   
		   , 'Monto_Pago'           = CASE WHEN Fecha_PagoMañana <= @FechaRep THEN CONVERT(NUMERIC(17,2),0) ELSE cpnominal END
		   , 'Rut_Cliente'          = CASE WHEN Fecha_PagoMañana <= @FechaRep  THEN CONVERT(NUMERIC(30),0)
										   ELSE (CASE WHEN cpseriado = 'S' THEN (SELECT serutemi
																				   FROM bactradersuda.dbo.VIEW_SERIE 
																				  WHERE semascara = CP.cpmascara)
		                						  ELSE (SELECT nsrutemi
													      FROM bactradersuda.dbo.VIEW_NOSERIE 
														 WHERE nsrutcart = CP.cprutcart 
														   AND nsnumdocu = CP.cpnumdocu 
														   AND nscorrela = CP.cpcorrela)
												  END)
									  END
		   ,'PERIODICIDAD'          = CASE WHEN IT.inserie = 'BCP'  THEN 'SEMESTRAL' 
						     			   WHEN IT.inserie = 'BCU'  THEN 'SEMESTRAL' 					
						     			   WHEN IT.inserie = 'BTP'  THEN 'SEMESTRAL' 
						     			   WHEN IT.inserie = 'BTU'  THEN 'SEMESTRAL' 
						     			   WHEN IT.inserie = 'PRC'  THEN 'SEMESTRAL'
						     			   WHEN IT.inserie = 'LCHR' THEN 'TRIMESTRAL'
						     			   WHEN IT.inserie = 'BONOS'THEN 'SEMESTRAL'
						     			   WHEN IT.inserie = 'BR'   THEN 'OUTRO'
						     			   WHEN IT.inserie = 'CERO' THEN 'OUTRO'
						     			   WHEN IT.inserie = 'DPF'  THEN 'OUTRO'
						     			   WHEN IT.inserie = 'DPR'  THEN 'OUTRO'
						     			   WHEN IT.inserie = 'PDBC' THEN 'OUTRO'
						     			   WHEN IT.inserie = 'DPX'  THEN 'OUTRO'
						     			   ELSE 'OUTRO'
		                              END
			,'dvEmisor' = ' ' 	
	    FROM #MDCP CP WITH(NOLOCK)
			INNER JOIN #MDDI DI WITH(NOLOCK) ON DI.dinumdocu = CP.cpnumdocu
											AND DI.dicorrela = CP.cpcorrela
											AND DI.dirutcart = CP.cprutcart
			INNER JOIN bactradersuda.dbo.view_instrumento IT WITH(NOLOCK) ON IT.incodigo  = CP.cpcodigo
			INNER JOIN bactradersuda.dbo.view_moneda      MO WITH(NOLOCK) ON MO.mncodmon  = DI.dimoneda
	-- WHERE CP.cpnumdocu IN( 103608,103148)


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
   /* ACTUALIZACIONES DE MONTOS                                                   */
   /*-----------------------------------------------------------------------------*/
	 SELECT  'virutcart' = virutcart
	 	    ,'vinumdocu' = vinumdocu
		    ,'vicorrela' = vicorrela
		    ,'vivalcomp' = SUM(ISNULL(vivalcomp,0))
		    ,'vivalcomu' = SUM(ISNULL(vivalcomu,0))
		    ,'vinominal' = SUM(ISNULL(vinominal,0))
		    ,'VContable' = SUM(ISNULL(VContable,0))
	   INTO #TmpVi
	   FROM (SELECT 'virutcart' = virutcart
				   ,'vinumdocu' = vinumdocu
				   ,'vicorrela' = vicorrela
				   ,'vivalcomp' = vivalcomp 
				   ,'vivalcomu' = vivalcomp
				   ,'vinominal' = vinominal
				   ,'VContable' = vivalcomp 
		       FROM #MDVI 
		      UNION  all
		     SELECT 'virutcart' = rsrutcart
				   ,'vinumdocu' = rsnumdocu
				   ,'vicorrela' = rscorrela
				   ,'vivalcomp' = case when Valor_Contable = 0 THEN rsvalcomp ELSE Valor_Contable   END 
				   ,'vivalcomu' = case when Valor_Contable = 0 THEN rsvalcomp ELSE Valor_Contable END 
				   ,'vinominal' = rsnominal
				   ,'VContable' = case when Valor_Contable = 0 THEN rsvalcomp ELSE Valor_Contable END 
		       FROM BacTraderSuda.dbo.mdrs 
		      WHERE rscartera=159 AND rsfecha = @FechaValorizacion --@dFecProx --@FECHAREP
		  ) AS Tbl
	 GROUP BY virutcart,vinumdocu,vicorrela 



   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZACIONES DE MONTOS                                                   */
   /*-----------------------------------------------------------------------------*/	
	 UPDATE #CARTERA_RF
	    SET Valcomp    = ISNULL(Valcomp    + vivalcomp,0)
		   ,ValCapital = ISNULL(ValCapital + vivalcomu,0)
		   ,ValcompAno = ValcompAno + (CASE WHEN YEAR(cpfeccomp) = YEAR(@FechaRep) THEN ISNULL(Valor_Contable,0) ELSE 0 END)
		   ,cpnominal  = ISNULL(cpnominal  + vinominal,0)
		   ,cpvalcomu  = ISNULL(cpvalcomu  + vivalcomu,0)
		   ,Valor_Contable = Valor_Contable + VContable
	   FROM	#TmpVi WITH (NOLOCK)
	  WHERE cprutcart = virutcart 
	    AND cpnumdocu = vinumdocu 
		AND cpcorrela = vicorrela 

   /*-----------------------------------------------------------------------------*/
   /* ELIMINAR NOMINALES QUE SEAN 0                                               */
   /*-----------------------------------------------------------------------------*/	
     DELETE #CARTERA_RF WHERE cpnominal = 0
	
   /*-----------------------------------------------------------------------------*/
   /* SE BUSCARN REGISTROS EN LA VALORIZACION                            */
   /*-----------------------------------------------------------------------------*/	
	 SELECT 'rmrutcart'  = rmrutcart
	 	   ,'rmnumdocu'  = rmnumdocu
		   ,'rmcorrela'  = rmcorrela
		   ,'rmvalmcdo'  = SUM(valor_mercado)
		   ,'rmdifmcdop' = SUM(CASE WHEN diferencia_mercado > 0 THEN diferencia_mercado ELSE 0 END)
		   ,'rmdifmcdon' = SUM(CASE WHEN diferencia_mercado < 0 THEN ABS(diferencia_mercado) ELSE 0 END)
	   INTO #TmpViMtm
	   FROM BacTraderSuda.dbo.VALORIZACION_MERCADO vm WITH (NOLOCK)
	  WHERE Fecha_Valorizacion = @FechaValorizacion --@FechaRep 
	    AND tipo_operacion IN ( 'VI','CG') 
	GROUP BY rmrutcart,rmnumdocu,rmcorrela

	
   /*-----------------------------------------------------------------------------*/
   /* ACTUALIZACION DE VALORES                                                    */
   /*-----------------------------------------------------------------------------*/
	 UPDATE #CARTERA_RF
	    SET ValMdo        = valor_mercado
		   ,Util_Mercado  = CASE WHEN diferencia_mercado > 0 THEN diferencia_mercado ELSE 0 END
		   ,Perd_Mercado  = CASE WHEN diferencia_mercado < 0 THEN Abs(diferencia_mercado) ELSE 0 END
	   FROM BacTraderSuda.dbo.VALORIZACION_MERCADO vm WITH (NOLOCK)
	  WHERE Fecha_Valorizacion = @FechaValorizacion --@FechaRep  
	    AND rmrutcart          = cprutcart 
		AND rmnumdocu          = cpnumdocu 
		AND rmnumoper          = cpnumdocu 
		AND rmcorrela          = cpcorrela 
		AND tipo_operacion     = 'CP'


	 UPDATE #CARTERA_RF
	    SET ValMdo       = ValMdo + rmvalmcdo 
		   ,Util_Mercado = Util_Mercado + rmdifmcdop
		   ,Perd_Mercado = Perd_Mercado + rmdifmcdon
	   FROM #TmpViMtm WITH (NOLOCK)
	  WHERE rmrutcart = cprutcart 
		AND rmnumdocu = cpnumdocu 
		AND rmcorrela = cpcorrela


   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES AUXILIARES                                         */
   /*-----------------------------------------------------------------------------*/
	 DECLARE @anno          INT
	        ,@dFecCalc      DATETIME
			,@nUf_Hoy	    FLOAT
	        ,@nUf_Pag	    FLOAT
		    ,@nUf_comp	    FLOAT
			,@ValCapitalUm  FLOAT
			,@nReajAnno	    FLOAT
		    ,@nIntAnno	    FLOAT
			,@nIntereses    NUMERIC(19,4)
			,@nReajustesDev NUMERIC(19,4)
			,@nCupon		INTEGER
		    ,@dUltFecCup	DATETIME
			,@dFeccal       DATETIME
			,@dFecAnoAnt    DATETIME
			,@nMtoCortes	NUMERIC(19,4)
			,@nFlujo		NUMERIC(19,4)
			,@dFecMcdo      DATETIME
			,@ValMcdo	    NUMERIC(19,4)
			,@nNominalAnt   NUMERIC(19,4)



   /*-----------------------------------------------------------------------------*/
   /* DECLARACION DE VARIABLES DEL CURSOR                                         */
   /*-----------------------------------------------------------------------------*/
      DECLARE @CUR_ID               INT
	         ,@CUR_cpfeccomp        DATETIME
			 ,@CUR_dimoneda         INT
			 ,@CUR_Fecha_PagoManana DATETIME
			 ,@CUR_Valor_Contable   FLOAT
			 ,@CUR_Tasa_Contrato    FLOAT
			 ,@CUR_cpseriado        CHAR(01)
			 ,@CUR_inserie          VARCHAR(30)
			 ,@CUR_cpmascara        VARCHAR(10)
			 ,@CUR_cpfecucup        DATETIME
			 ,@CUR_cpinstser        VARCHAR(12)
			 ,@CUR_cpnominal        NUMERIC(19,4)
			 ,@CUR_cprutcart        NUMERIC(10)
			 ,@CUR_cpcorrela        NUMERIC(05)
			 ,@CUR_cpnumdocu        NUMERIC(10)
			 ,@CUR_FecEmi           DATETIME
			 ,@CUR_cpcodigo         NUMERIC(5)
			 ,@CUR_cpFecpcup        DATETIME
            


   /*-----------------------------------------------------------------------------*/
   /* SE INICIARA CURSOR PARA LOGRAR DETERMINAR VALORES EN LA CONSULTA            */
   /*-----------------------------------------------------------------------------*/
     DECLARE CURSOR_OPERACIONES CURSOR LOCAL FOR
      SELECT ID
	        ,cpfeccomp
			,dimoneda
			,Fecha_PagoManana
			,Valor_Contable
			,Tasa_Contrato
			,cpseriado
			,inserie
			,cpmascara
			,cpfecucup
			,cpinstser
			,cpnominal
			,cprutcart      
			,cpcorrela      
			,cpnumdocu 
			,FecEmi
			,cpcodigo
			,cpFecpcup
        FROM #CARTERA_RF
	   


        OPEN CURSOR_OPERACIONES
       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_ID
	                                          ,@CUR_cpfeccomp 
											  ,@CUR_dimoneda 
											  ,@CUR_Fecha_PagoManana
											  ,@CUR_Valor_Contable
											  ,@CUR_Tasa_Contrato
											  ,@CUR_cpseriado
											  ,@CUR_inserie
											  ,@CUR_cpmascara
											  ,@CUR_cpfecucup
											  ,@CUR_cpinstser
											  ,@CUR_cpnominal
											  ,@CUR_cprutcart      
			                                  ,@CUR_cpcorrela      
			                                  ,@CUR_cpnumdocu 
											  ,@CUR_FecEmi  
											  ,@CUR_cpcodigo
											  ,@CUR_cpFecpcup   


   /*-----------------------------------------------------------------------------*/
   /* INICIO DE CICLO CONTABLE                                                    */
   /*-----------------------------------------------------------------------------*/
     WHILE @@FETCH_STATUS  = 0 BEGIN


	   /*-----------------------------------------------------------------*/
	   /* CALCULO DE INTERES DEVENGADOS EN EL AÑO O DESDE LA FECHA DE     */
	   /* COMPRA SI EL INSTRUMENTO FUE COMPRADO EN EL AÑO                 */
	   /*-----------------------------------------------------------------*/
	     IF YEAR(@CUR_cpfeccomp) = YEAR(@cFecRep) BEGIN
		    SELECT @dFecCalc = @CUR_cpfeccomp
		 END 
		 ELSE BEGIN
			SELECT @anno = YEAR(@cFecRep)-1
			SELECT @dFecCalc = CONVERT(DATETIME,Str(@anno,4)+'1231')
		 END


	   /*-----------------------------------------------------------------*/
	   /* CALCULO VALORES DE MONEDA                                       */
	   /*-----------------------------------------------------------------*/
		 IF @tc_rep_cnt = 'S' AND @CUR_dimoneda= 994	
		 BEGIN
			 SELECT @nUf_Hoy  =  Tipo_Cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK) WHERE Codigo_Moneda = @CUR_dimoneda and Fecha = @cFecRep
	         SELECT @nUf_Pag  =  Tipo_Cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK) WHERE Codigo_Moneda = @CUR_dimoneda and Fecha = @dFecCalc
	         SELECT @nUf_comp =  Tipo_Cambio FROM BacParamSuda..VALOR_MONEDA_CONTABLE WITH (NOLOCK) WHERE Codigo_Moneda  = (CASE WHEN @CUR_cpfeccomp < CONVERT(DATETIME,'20070115') THEN @CUR_Fecha_PagoManana 
																																										ELSE @CUR_cpfeccomp END) and Codigo_Moneda = @CUR_dimoneda
	     END 
		 ELSE 
		 BEGIN 

			SELECT @nUf_Hoy  =  vmvalor FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) WHERE vmcodigo = @CUR_dimoneda and Vmfecha = @cFecRep
        	SELECT @nUf_Pag  =  vmvalor FROM BacParamSuda..VALOR_MONEDA WITH (NOLOCK) WHERE vmcodigo = @CUR_dimoneda and Vmfecha = @dFecCalc
            SELECT @nUf_comp =  CASE WHEN @CUR_dimoneda in(999,13) THEN 1 ELSE ISNULL((SELECT vmvalor 
																						  FROM BacParamSuda..VALOR_MONEDA
																						  WHERE vmfecha =(CASE WHEN @CUR_cpfeccomp < CONVERT(DATETIME,'20070115') THEN @CUR_Fecha_PagoManana 
																																							 ELSE @CUR_cpfeccomp END) and vmcodigo=@CUR_dimoneda),1) END
		 END


		 IF @CUR_dimoneda = 13 OR @CUR_dimoneda = 999 BEGIN
			
			SELECT @nUf_Hoy  = 1
		    SELECT @nUf_Pag  = 1
			SELECT @nUf_comp = 1
		END	

	   /*-----------------------------------------------------------------*/
	   /* SETEO DE VALORES                                                */
	   /*-----------------------------------------------------------------*/
		SELECT @ValCapitalUm = ROUND(@CUR_Valor_Contable/@nUf_comp,4)

		SELECT @nIntAnno     = ROUND( (@ValCapitalUm * (@CUR_Tasa_Contrato/36000) * DATEDIFF(dd,@dFecCalc,@cFecRep))* @nUf_Hoy,0)
		SELECT @nReajAnno    = CASE WHEN (@CUR_dimoneda <> 999 AND @CUR_dimoneda <> 13)  THEN ROUND(( @nUf_Hoy - @nUf_Pag ) * @ValCapitalUm, 0) ELSE 0.0 END


	   /*-----------------------------------------------------------------*/
	   /* INTERES Y REAJUSTE DE VALORES DEVENGADOS                        */
	   /*-----------------------------------------------------------------*/
		SELECT @nIntereses = 0
		      ,@nReajustesDev = 0
		SELECT @nCupon     = 0
		SELECT @dUltFecCup = CONVERT(DATETIME,'')

	   /*-----------------------------------------------------------------*/
	   /* DEFINICION POR SERIADOS                                         */
	   /*-----------------------------------------------------------------*/
	   	 IF @CUR_cpseriado = 'S' BEGIN


			IF @CUR_inserie <> 'LCHR' BEGIN

					SET ROWCOUNT 1
			     		SELECT @nCupon     = ISNULL(tdcupon,0)
							 , @dUltFecCup = ISNULL(Tdfecven,'')
			     		 FROM BacTraderSuda.dbo.VIEW_TABLA_DESARROLLO
			     		WHERE tdmascara = @CUR_cpmascara 
						  AND tdfecven  < @CUR_cpFecpcup
						ORDER BY tdfecven DESC
				   SET ROWCOUNT 0

			END 
			ELSE BEGIN
				SELECT @dUltFecCup = @CUR_cpfecucup
			END


			SELECT @dUltFecCup = CASE WHEN @CUR_Fecha_PagoManana > @dUltFecCup THEN @CUR_Fecha_PagoManana ELSE @dUltFecCup END
			SELECT @dFeccal = (CASE WHEN (CHARINDEX('&',@CUR_cpinstser)>0 Or CHARINDEX('*',@CUR_cpinstser)>0) THEN @CUR_Fecha_PagoManana ELSE @dUltFecCup END )


		 END 
		 ELSE BEGIN
  			  SELECT @dFeccal = @CUR_Fecha_PagoManana
	   	 END

	   /*-----------------------------------------------------------------*/
	   /* DEFINICION POR MONEDA DOLAR                                     */
	   /*-----------------------------------------------------------------*/
         IF @CUR_dimoneda <>13 BEGIN
			SELECT @nIntereses = ROUND((((@ValCapitalUm*(@CUR_Tasa_Contrato/100)) / 360) * (DATEDIFF(dd,@dFeccal,@cFecRep)+1)) * @nUf_Hoy , 0)
		 END
		 ELSE BEGIN
			SELECT @nIntereses = ROUND((((@ValCapitalUm*(@CUR_Tasa_Contrato/100)) / 360) * (DATEDIFF(dd,@dFeccal,@cFecRep)+1)) * @nUf_Hoy , 2)
		 END

		SELECT @nReajustesDev = CASE WHEN (@CUR_dimoneda <> 999 AND @CUR_dimoneda <> 13)  THEN ROUND(( @nUf_Hoy - @nUf_comp ) * @ValCapitalUm, 0) ELSE 0.0 END



	   /*-----------------------------------------------------------------*/
	   /* VALOR DE MERCADO ANTERIOR O FECHA COMPRA                        */
	   /*-----------------------------------------------------------------*/
		SELECT @anno       = YEAR(@cFecRep)
		SELECT @dFecAnoAnt = STR(YEAR(@cFecRep)-1,4)+'1231'

		IF YEAR(@CUR_cpfeccomp) = @anno BEGIN
			SELECT @dFecMcdo = CASE WHEN @CUR_cpfeccomp < @CUR_Fecha_PagoManana and @CUR_cpfeccomp < @cFecRep THEN @CUR_Fecha_PagoManana ELSE @CUR_cpfeccomp END
		END
		ELSE BEGIN
			SELECT @dFecMcdo = @dFecAnoAnt
		END


		SELECT @ValMcdo     = 0
		SELECT @ValMcdo     = ISNULL(SUM(valor_mercado),0)
			 , @nNominalAnt = SUM(valor_nominal)
		  FROM BacTraderSuda.dbo.VALORIZACION_MERCADO WITH (NOLOCK)
		 WHERE fecha_valorizacion = @FechaValorizacion --@FECHAREP
		   AND rmrutcart = @CUR_cprutcart 
		   AND rmnumdocu = @CUR_cpnumdocu 
		   AND rmcorrela = @CUR_cpcorrela
		 GROUP BY rmrutcart,rmnumdocu,rmcorrela


		SELECT @ValMcdo = ROUND((@CUR_cpnominal/@nNominalAnt) * @ValMcdo,0)

		SELECT @nMtoCortes = 0.0
		SELECT @nFlujo     = 0


	   /*-----------------------------------------------------------------*/
	   /* CALCULO DE DESCUENTOS                                           */
	   /*-----------------------------------------------------------------*/
		 IF @CUR_cpseriado = 'S' BEGIN

         	IF @tc_rep_cnt = 'S' AND @CUR_dimoneda = 994 BEGIN
			   EXECUTE BacTraderSuda.dbo.Sp_Descuenta_Cupones_tcrc @CUR_dimoneda,@CUR_cpnominal,@dFecMcdo,@cFecRep,@CUR_cpmascara,@CUR_FecEmi,@CUR_cpcodigo,@nMtoCortes OUTPUT  -- Se creo SP [Sp_Descuenta_Cupones_tcrc] **
	        END 
			ELSE BEGIN
  		       EXECUTE BacTraderSuda.dbo.Sp_Descuenta_Cupones @CUR_dimoneda,@CUR_cpnominal,@dFecMcdo,@cFecRep,@CUR_cpmascara,@CUR_FecEmi,@CUR_cpcodigo,@nMtoCortes OUTPUT
			END
	   

			SELECT @nFlujo = SUM(rsflujo)
			  FROM BacTraderSuda.dbo.MDRS  WITH (NOLOCK)
			 WHERE rsnumdocu = @CUR_cpnumdocu 
			   AND rscorrela = @CUR_cpcorrela 
			   AND rscartera in('111','114') 
			   AND rstipoper = 'VC' 
			   AND rsfecha BETWEEN @dFecMcdo AND @cFecRep 
			   AND rsfecvcto > @cFecRep
				GROUP BY rsnumdocu,rscorrela

		END

	   /*-----------------------------------------------------------------*/
	   /* ACTUALIZAR CALCULOS EN TABLA TEMPORAL                           */
	   /*-----------------------------------------------------------------*/
		UPDATE #CARTERA_RF
		   SET InteresDevAno 	  = ISNULL(@nIntAnno,0)
			  ,ReajustesDevAno    = ISNULL(@nReajAnno,0)
			  ,DifMercano 	      = ISNULL((ValMdo - (@ValMcdo-@nFlujo)),0)
			  ,InteresesporVenta  = ISNULL(InteresesporVenta + @nFlujo,0)
			  ,InteresDev		  = ISNULL(@nIntereses + @nReajustesDev,0)
		  WHERE ID = @CUR_ID



       FETCH NEXT FROM CURSOR_OPERACIONES INTO @CUR_ID
	                                          ,@CUR_cpfeccomp 
											  ,@CUR_dimoneda 
											  ,@CUR_Fecha_PagoManana
											  ,@CUR_Valor_Contable
											  ,@CUR_Tasa_Contrato
											  ,@CUR_cpseriado
											  ,@CUR_inserie
											  ,@CUR_cpmascara
											  ,@CUR_cpfecucup
											  ,@CUR_cpinstser
											  ,@CUR_cpnominal
											  ,@CUR_cprutcart      
			                                  ,@CUR_cpcorrela      
			                                  ,@CUR_cpnumdocu 
											  ,@CUR_FecEmi  
											  ,@CUR_cpcodigo  
											  ,@CUR_cpFecpcup 



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
