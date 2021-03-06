USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S009_Cuadratura_Diaria_Resumen]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_S009_Cuadratura_Diaria_Resumen]
	(	@FechaDesde			DATETIME
	,	@FechaHasta			DATETIME
	,	@MedaDistibucion	INT				= 1
	,	@Operador			NVARCHAR(25)	= ''
	)
as
begin

--- SPOT, FWD, OPCIONES, SWAP, PACTOS.
        
	SET NOCOUNT ON        

	DECLARE @dFechaProceso   DATETIME        
	SET @dFechaProceso   = ( SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )        

	DECLARE @dFechaAnterior  DATETIME        
	SET @dFechaAnterior  = ( SELECT acfecante FROM BacTraderSuda.dbo.MDAC with(nolock) )        

	DECLARE	@Sw_Historico  INT
	SELECT	@Sw_Historico   = 0

	IF not (@FechaDesde  =   @FechaHasta and @dFechaProceso = @FechaDesde)
		SELECT @Sw_Historico = 1
		

	CREATE TABLE #RESULTADOS_MESA        
	(   Modulo           CHAR(3)                 
	,   Producto         VARCHAR(50)        
	,   Numero_Operacion NUMERIC(9)        
	,   Documento        NUMERIC(9)        
	,   Correlativo      NUMERIC(21,4)        
	,   Serie            VARCHAR(20)        
	,   RutCliente       NUMERIC(12)        
	,   CodCliente       INT        
	,   DvCliente        CHAR(1)        
	,   NombreCliente    VARCHAR(150)        
	,   TipoOperacion    VARCHAR(25)        
	,   Monto            NUMERIC(21,4)        
	,   MonTransada      CHAR(3)        
	,   MonConversion    CHAR(3)        
	,   TCCierre         NUMERIC(21,4)        
	,   TCCosto          NUMERIC(21,4)        
	,   ParidadCierre    NUMERIC(21,4)        
	,   ParidadCosto     NUMERIC(21,4)        
	,   MontoPesos       NUMERIC(21,4)        
	,   Operador         VARCHAR(15)        
	,   MontoDolares     NUMERIC(21,4)        
	,   ResultadoMesa    NUMERIC(21,4)        
	,   Fecha            DATETIME --> CHAR(10)        
	,   Relacionado      VARCHAR(35)      
	,   FolioRelacionado NUMERIC(9)        
	,	FechaEmision	 DATETIME 
	,	FechaVencimiento DATETIME 
	)    
	CREATE INDEX #ix_orden ON #RESULTADOS_MESA ( fecha, Modulo, Producto,  RutCliente, CodCliente, Numero_Operacion, Documento, Correlativo )    
   
   
   	IF	(   @FechaDesde  =   @FechaHasta ) AND (@Sw_Historico  = 0)BEGIN   ---Consulta Diaria
	
		INSERT INTO #RESULTADOS_MESA        
		SELECT Modulo              = 'BCC'        
		,   Producto            = mvto.motipmer        
		,   Numero_Operacion    = mvto.monumope        
		,   Numero_Documento    = 0        
		,   Numero_Correlativo  = 0        
		,   Serie               = ''        
		,   RutCliente          = clie.clrut        
		,   CodCliente          = clie.clcodigo        
		,   DvCliente           = clie.cldv     
		,   NombreCliente       = clie.clnombre        
		,   TipoOperacion       = mvto.motipope        
		,   Monto               = mvto.momonmo        
		,   MonTransada         = mvto.mocodmon        
		,   MonConversion       = mvto.mocodcnv        
		,   TCCierre            = mvto.moticam        
		,   TCCosto             =	CASE WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon  = 'USD' THEN mvto.CMX_TC_Costo_Trad  
									WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon <> 'USD' THEN mvto.motctra  
									ELSE mvto.motctra  
									END  
		,   ParidadCierre       = mvto.moparme        
		,   ParidadCosto        =	CASE WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon  = 'USD' THEN mvto.mopartr  
									WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon <> 'USD' THEN mvto.CMX_TC_Costo_Trad  
									ELSE mvto.mopartr  
									END  
		,   MontoPesos          = mvto.momonpe        
		,   Operador            = mvto.mooper        
		,   MontoDolares        = mvto.moussme        
		,   ResultadoMesa       = CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END       
		,   Fecha               = mvto.mofech  --> CONVERT(CHAR(10), mvto.mofech, 103)        
		,   Relacionado         =	CASE WHEN mvto.monumfut > 0 AND mvto.moterm = 'SWAP SPOT'                         THEN 'Swap Spot'         
									WHEN mvto.monumfut > 0 AND mvto.moterm = 'EMPRESAS'  AND morutcli = 96665450 THEN 'Neteo'        
									ELSE                                                                              'Sin Relación'         
									END        
		, FolioRelacionado      =	CASE WHEN mvto.monumfut > 0 AND mvto.moterm = 'SWAP SPOT'                             THEN mvto.monumfut        
									WHEN mvto.monumfut > 0 AND mvto.moterm = 'EMPRESAS' AND mvto.morutcli = 96665450 THEN mvto.monumfut        
									ELSE                                                                                  0        
									END        
		,	FechaEmision		=	mvto.mofech
		,	FechaVencimiento	=	mvto.mofech									
		FROM	BacCamSuda.dbo.MEMO mvto        
				INNER JOIN BacParamSuda.dbo.CLIENTE clie 
				ON clie.clrut = mvto.morutcli and clie.clcodigo = mvto.mocodcli        
		WHERE	mvto.moestatus     <> 'A' 
		AND		mvto.moterm <> 'FORWARD' 
		AND		mvto.moterm <> 'SWAP' 
		AND		mvto.moterm <> 'OPCIONES'         
		AND		mvto.mofech         BETWEEN @FechaDesde AND @Fechahasta        
		AND		mvto.moterm         NOT IN ('DATATEC','BOLSA')        
		
	END ELSE BEGIN					---- Consulta Histórica 
	
		INSERT INTO #RESULTADOS_MESA        
		SELECT Modulo              = 'BCC'        
		,   Producto            = mvto.motipmer        
		,   Numero_Operacion    = mvto.monumope        
		,   Numero_Documento    = 0        
		,   Numero_Correlativo  = 0        
		,   Serie               = ''        
		,   RutCliente          = clie.clrut        
		,   CodCliente          = clie.clcodigo        
		,   DvCliente           = clie.cldv        
		,   NombreCliente       = clie.clnombre        
		,   TipoOperacion       = mvto.motipope        
		,   Monto               = mvto.momonmo        
		,   MonTransada         = mvto.mocodmon        
		,   MonConversion			= mvto.mocodcnv        
		,   TCCierre            = mvto.moticam        
		,   TCCosto             =	CASE WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon  = 'USD' THEN mvto.CMX_TC_Costo_Trad  
										WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon <> 'USD' THEN mvto.motctra  
										ELSE mvto.motctra  
									END  
		,   ParidadCierre       = mvto.moparme        
		,   ParidadCosto        =	CASE WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon  = 'USD' THEN mvto.mopartr  
										WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon <> 'USD' THEN mvto.CMX_TC_Costo_Trad  
										ELSE mvto.mopartr  
									END  
		,   MontoPesos          = mvto.momonpe        
		,   Operador            = mvto.mooper        
		,   MontoDolares        = mvto.moussme        
		,   ResultadoMesa       =	CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END       
		,   Fecha               = mvto.mofech --> CONVERT(CHAR(10), mvto.mofech, 103)        
		,   Relacionado         =	CASE WHEN mvto.monumfut > 0 AND mvto.moterm = 'SWAP SPOT'                         THEN 'Swap Spot'         
									WHEN mvto.monumfut > 0 AND mvto.moterm = 'EMPRESAS'  AND morutcli = 96665450 THEN 'Neteo'        
									ELSE 'Sin Relación'         
									END        
		,   FolioRelacionado    =	CASE WHEN mvto.monumfut > 0 AND mvto.moterm = 'SWAP SPOT'                             THEN mvto.monumfut        
										WHEN mvto.monumfut > 0 AND mvto.moterm = 'EMPRESAS' AND mvto.morutcli = 96665450 THEN mvto.monumfut        
										ELSE                                                                                  0        
									END        
		,	FechaEmision		=	mvto.mofech
		,	FechaVencimiento	=	mvto.mofech
		FROM   BacCamSuda.dbo.MEMOH mvto        
			INNER JOIN BacParamSuda.dbo.CLIENTE clie 
			ON clie.clrut = mvto.morutcli and clie.clcodigo = mvto.mocodcli        
		WHERE	mvto.moestatus     <> 'A' 
		AND		mvto.moterm <> 'FORWARD' 
		AND		mvto.moterm <> 'SWAP' 
		AND		mvto.moterm <> 'OPCIONES'         
		AND		mvto.mofech     BETWEEN @FechaDesde AND @Fechahasta        
		AND		mvto.moterm         NOT IN ('DATATEC','BOLSA')        
	END
	
	IF	(   @FechaDesde  =   @FechaHasta ) BEGIN   ---Consulta Diaria
	        
		INSERT INTO #RESULTADOS_MESA        
		SELECT Modulo              = 'BFW'        
		,   Producto            = prod.descripcion        
		,   Numero_Operacion    = mvto.monumoper        
		,   Numero_Documento    = 0        
		,   Numero_Correlativo  = mvto.motipcamSpot        
		,   Serie               = ''        
		,   RutCliente          = clie.clrut        
		,   CodCliente          = clie.clcodigo        
		,   DvCliente           = clie.cldv        
		,   NombreCliente       = clie.clnombre        
		,   TipoOperacion       = mvto.motipoper        
		,   Monto               = mvto.momtomon1        
		,   MonTransada         = mon1.mnnemo        
		,   MonConversion       = mon2.mnnemo        
		,   TCCierre            =	CASE WHEN mvto.mocodpos1 = 1  THEN mvto.motipcam         
										WHEN mvto.mocodpos1 = 2  THEN mvto.mopremon1        
										WHEN mvto.mocodpos1 = 3  THEN mvto.motipcam        
										WHEN mvto.mocodpos1 = 13 THEN mvto.motipcam        
									END        
		,   TCCosto             =	CASE WHEN mvto.mocodpos1 = 1  THEN mvto.mopreciopunta        
										WHEN mvto.mocodpos1 = 2  THEN mvto.mopremon2        
										WHEN mvto.mocodpos1 = 3  THEN mvto.mopreciopunta        
										WHEN mvto.mocodpos1 = 13 THEN mvto.mopreciopunta        
									END        
		,   ParidadCierre       =	CASE WHEN mvto.mocodpos1 = 1  THEN mvto.moparmon1        
										WHEN mvto.mocodpos1 = 2  THEN mvto.motipcam         
										WHEN mvto.mocodpos1 = 3  THEN 0.0        
										WHEN mvto.mocodpos1 = 13 THEN 0.0        
									END         
		,   ParidadCosto        =	CASE WHEN mvto.mocodpos1 = 1  THEN mvto.moparmon2        
										WHEN mvto.mocodpos1 = 2  THEN mvto.moparmon1        
										WHEN mvto.mocodpos1 = 3  THEN 0.0        
										WHEN mvto.mocodpos1 = 13 THEN 0.0        
									END        
		,   MontoPesos          = mvto.moequmon1        
		,   Operador            = mvto.mooperador        
		,   MontoDolares        = CASE mvto.mocodpos1 WHEN 2 THEN mvto.momtomon2 ELSE mvto.moequusd1 END        
		,   ResultadoMesa       =	CASE WHEN mvto.mocodpos1 = 2 
										THEN	ROUND(mvto.Resultado_Mesa * vcont.tipo_cambio, 0)       
										ELSE	mvto.Resultado_Mesa      
									END        
		,   Fecha      = mvto.mofecha  --> CONVERT(CHAR(10), mvto.mofecha, 103)        
		,   Relacionado         = CASE WHEN var_moneda2  <> 0 THEN 'Operacion Relacionada MX/CLP' ELSE '--' END      
		,   FolioRelacionado    = 0        
		,	FechaEmision		=	mofecEfectiva           
		,	FechaVencimiento	=	mofecvcto               
		FROM    BacFwdSuda.dbo.MFMO                  mvto        
			INNER JOIN bacfwdsuda.dbo.mfca       cart 
			ON cart.canumoper=mvto.monumoper      
			INNER JOIN BacFwdSuda.dbo.MFAC       ctro 
			ON ctro.acfecproc  = mvto.mofecha        
			INNER JOIN BacParamSuda.dbo.CLIENTE  clie 
			ON clie.clrut      = mvto.mocodigo AND clie.clcodigo        = mvto.mocodcli        
			INNER JOIN BacParamSuda.dbo.PRODUCTO prod 
			ON prod.id_sistema = 'BFW'         AND prod.codigo_producto = mvto.mocodpos1        
			LEFT  JOIN BacParamSuda.dbo.MONEDA   mon1 
			ON mon1.mncodmon   = mvto.mocodmon1        
			LEFT  JOIN BacParamSuda.dbo.MONEDA   mon2 
			ON mon2.mncodmon   = mvto.mocodmon2        
			LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vcont 
			ON vcont.fecha         = ctro.acfecante         
			AND	vcont.codigo_moneda = 994        
		WHERE  mvto.moestado     <> 'A'        
		AND  mvto.mofecha       BETWEEN @FechaDesde AND @Fechahasta        
		
	END ELSE BEGIN     --- Consulta Histórica 
	        
		INSERT INTO #RESULTADOS_MESA        
		SELECT Modulo              = 'BFW'        
		,  Producto            = prod.descripcion       
		,   Numero_Operacion    = mvto.monumoper   
		,   Numero_Documento    = 0        
		,   Numero_Correlativo  = mvto.motipcamSpot        
		,   Serie               = ''        
		,   RutCliente          = clie.clrut        
		,   CodCliente          = clie.clcodigo        
		,   DvCliente           = clie.cldv        
		,   NombreCliente       = clie.clnombre        
		,   TipoOperacion       = mvto.motipoper        
		,   Monto               = mvto.momtomon1        
		,   MonTransada         = mon1.mnnemo        
		,   MonConversion       = mon2.mnnemo        
		,   TCCierre            =	CASE WHEN mvto.mocodpos1 = 1  THEN mvto.motipcam         
										WHEN mvto.mocodpos1 = 2  THEN mvto.mopremon1        
										WHEN mvto.mocodpos1 = 3  THEN mvto.motipcam      
										WHEN mvto.mocodpos1 = 13 THEN mvto.motipcam      
									END        
		, TCCosto               =	CASE WHEN mvto.mocodpos1 = 1  THEN mvto.mopreciopunta        
										WHEN mvto.mocodpos1 = 2  THEN mvto.mopremon2        
										WHEN mvto.mocodpos1 = 3  THEN mvto.mopreciopunta        
										WHEN mvto.mocodpos1 = 13 THEN mvto.mopreciopunta        
									END        
		,   ParidadCierre       =	CASE WHEN mvto.mocodpos1 = 1  THEN mvto.moparmon1        
										WHEN mvto.mocodpos1 = 2  THEN mvto.motipcam         
										WHEN mvto.mocodpos1 = 3  THEN 0.0        
										WHEN mvto.mocodpos1 = 13 THEN 0.0        
									END         
		,   ParidadCosto        =	CASE WHEN mvto.mocodpos1 = 1  THEN mvto.moparmon2        
										WHEN mvto.mocodpos1 = 2  THEN mvto.moparmon1        
										WHEN mvto.mocodpos1 = 3  THEN 0.0        
										WHEN mvto.mocodpos1 = 13 THEN 0.0        
									END        
		,   MontoPesos          = mvto.moequmon1        
		,   Operador            = mvto.mooperador        
		,   MontoDolares        =	CASE mvto.mocodpos1 WHEN 2 THEN MVTO.momtomon2 ELSE mvto.moequusd1 END        
		,   ResultadoMesa       =	CASE WHEN mvto.mocodpos1 = 2 
										THEN ROUND(mvto.Resultado_Mesa * vcont.tipo_cambio, 0)      
										ELSE                         mvto.Resultado_Mesa      
									END        
		,   Fecha               = mvto.mofecha --> CONVERT(CHAR(10), mvto.mofecha, 103)        
		,   Relacionado         = CASE WHEN var_moneda2  <> 0 THEN 'Operacion Relacionada MX/CLP' ELSE '--' END      
		,   FolioRelacionado    = 0        
		,	FechaEmision		=	mofecEfectiva           
		,	FechaVencimiento	=	mofecvcto               
		FROM BacFwdSuda.dbo.MFMOH                 mvto        
				INNER JOIN bacfwdsuda.dbo.mfca       cart 
					ON cart.canumoper  = mvto.monumoper      
				INNER JOIN BacFwdSuda.dbo.MFACH      ctro 
					ON ctro.acfecproc  = mvto.mofecha        
				INNER JOIN BacParamSuda.dbo.CLIENTE  clie 
					ON clie.clrut      = mvto.mocodigo 
					AND clie.clcodigo        = mvto.mocodcli        
				INNER JOIN BacParamSuda.dbo.PRODUCTO prod 
					ON prod.id_sistema = 'BFW'         
					AND prod.codigo_producto = mvto.mocodpos1        
				LEFT  JOIN BacParamSuda.dbo.MONEDA   mon1 
					ON mon1.mncodmon   = mvto.mocodmon1        
				LEFT  JOIN BacParamSuda.dbo.MONEDA   mon2 
					ON mon2.mncodmon   = mvto.mocodmon2        
				LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vcont 
					ON vcont.fecha         = ctro.acfecante         
					AND  vcont.codigo_moneda = 994        
		WHERE  mvto.moestado     <> 'A'        
		AND  mvto.mofecha       BETWEEN @FechaDesde AND @Fechahasta        
		
	END	---- Fin FORWARD 
	
	
	SELECT	canumoper, cacodpos1,  catipoper, catipmoda, cacodigo,  cacodcli, cacodmon1, cacodmon2        
	,		camtomon1, caequmon1, caequusd1, capremon1, capremon2, capreant, caspread,   camtomon2        
	,		cafecha,   cafecvcto, caestado,  caantici,  caoperador        
	,		precio_spot, caantptosfwd, caantptoscos        
	INTO #TMP_CARTERA_ANTICIPO_FORWARD        
	FROM BacFwdsuda.dbo.MFCA   unw with(nolock)        
	WHERE unw.cafecvcto BETWEEN @FechaDesde and @Fechahasta        
	AND	unw.caestado  <> 'A'        
	AND	unw.caantici   = 'A' 
	       

	INSERT INTO #TMP_CARTERA_ANTICIPO_FORWARD        
	SELECT canumoper, cacodpos1, catipoper, catipmoda, cacodigo,  cacodcli, cacodmon1, cacodmon2        
	,   camtomon1, caequmon1, caequusd1, capremon1, capremon2, capreant, caspread,  camtomon2        
	,   cafecha,   cafecvcto, caestado,  caantici,  caoperador        
	,   precio_spot, caantptosfwd = 0.0, caantptoscos = 0.0        
	FROM BacFwdsuda.dbo.MFCAH  unw with(nolock)        
	WHERE unw.cafecvcto BETWEEN @FechaDesde and @Fechahasta        
	AND	 unw.caestado  <> 'A'        
	AND  unw.caantici   = 'A'        
	AND  unw.canumoper  NOT IN(	SELECT canumoper 
								FROM #TMP_CARTERA_ANTICIPO_FORWARD)       
							
									
        
	UPDATE #RESULTADOS_MESA        
	SET Monto			= Monto        - cant.camtomon1        
	,   MontoPesos		= MontoPesos   - cant.caequmon1        
	,   MontoDolares	= MontoDolares - CASE WHEN cant.cacodpos1 = 2 and cant.camtomon1 <> 13 
															THEN cant.camtomon2 
															ELSE cant.caequusd1 
															END        
	FROM #TMP_CARTERA_ANTICIPO_FORWARD     cant        
	WHERE #RESULTADOS_MESA.Modulo           = 'BFW'        
	AND #RESULTADOS_MESA.Numero_Operacion = cant.canumoper        
        
	INSERT INTO #RESULTADOS_MESA        
	SELECT Modulo              = 'BFW'        
	,   Producto            = 'ANT ' + pro.descripcion        
	,   Numero_Operacion    = unw.canumoper        
	,   Numero_Documento    = 0        
	,   Numero_Correlativo  = 0        
	,   Serie               = ''        
	,   RutCliente          = cli.clrut        
	,   CodCliente          = cli.clcodigo        
	,   DvCliente           = cli.cldv        
	,   NombreCliente       = cli.clnombre        
	,   TipoOperacion       = unw.catipoper        
	,   Monto               = unw.camtomon1 --> 0.0 --> unw.camtomon1        
	,   MonTransada         = mn1.mnnemo        
	,   MonConversion       = mn1.mnnemo        
	,   TCCierre            =	CASE WHEN unw.cacodpos1 = 2  
									THEN unw.capremon1    
									ELSE unw.precio_spot  + unw.caantptosfwd       
								END        
	,   TCCosto             =	CASE WHEN unw.cacodpos1 = 2  
									THEN unw.capremon2    
									ELSE unw.capreant     + unw.caantptoscos       
								END        
	,   ParidadCierre       =	CASE WHEN unw.cacodpos1 = 2  
									THEN unw.precio_spot  +    unw.caantptosfwd / mn1.mnfactor  
									ELSE 1.0 
								END        
	,   ParidadCosto        =	CASE WHEN unw.cacodpos1 = 2  
									THEN unw.capreant     +    unw.caantptoscos / mn1.mnfactor  
									ELSE 1.0 
								END        
	,   MontoPesos          = unw.caequmon1 --> 0.0 --> unw.caequmon1        
	,   Operador            = unw.caoperador        
	,   MontoDolares        =	CASE WHEN unw.cacodpos1 = 2 and unw.camtomon1 <> 13 
									THEN unw.camtomon2 
									ELSE unw.caequusd1 
								END --> 0.0 --> CASE WHEN unw.cacodpos1 = 2 and unw.camtomon1 <> 13 THEN unw.camtomon2 ELSE unw.caequusd1 END     
	,   ResultadoMesa       = unw.caspread        
	,   Fecha        = unw.cafecvcto        
	,   Relacionado         = '--'        
	,   FolioRelacionado    = 0         
	,	FechaEmision		=	unw.cafecvcto
	,	FechaVencimiento	=	unw.cafecvcto
	FROM   #TMP_CARTERA_ANTICIPO_FORWARD       unw        
		LEFT JOIN BacParamSuda.dbo.PRODUCTO pro with(nolock) 
		ON pro.id_sistema = 'BFW' AND pro.codigo_producto = unw.cacodpos1        
		LEFT JOIN BacParamSuda.dbo.CLIENTE  cli with(nolock) 
		ON cli.clrut      = unw.cacodigo and cli.clcodigo = unw.cacodcli        
		LEFT JOIN BacParamSuda.dbo.MONEDA   mn1 with(nolock) 
		ON mn1.mncodmon   = unw.cacodmon1        
		LEFT JOIN BacParamSuda.dbo.MONEDA   mn2 with(nolock) 
		ON mn2.mncodmon   = unw.cacodmon2        

	DROP TABLE #TMP_CARTERA_ANTICIPO_FORWARD        
    
     
	SELECT Modulo        
	,   Producto        
	,   Numero_Operacion        
	,   'Relacionado' = Relacionado --> CASE WHEN Relacionado = 'S' THEN 'REL. FORWARD' ELSE ' ' END        
	,   'Folio Ref.'  = Correlativo --> FolioRelacionado        
	,   Serie        
	,   RutCliente        
	,   CodCliente        
	,   DvCliente        
	,   NombreCliente        
	,   TipoOperacion        
	,   Monto        
	,   MonTransada        
	,   MonConversion        
	,   TCCierre        
	,   TCCosto        
	,   ParidadCierre        
	,   ParidadCosto        
	,   MontoPesos        
	,   Operador        
	,   MontoDolares        
	,   ResultadoMesa        
	,   Fecha    
	,   Documento    
	,   Correlativo    
	,	FechaEmision
	,	FechaVencimiento
	INTO   #TMP_RETORNO_ORDENADO    
	FROM   #RESULTADOS_MESA    
		INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE tgd 
		ON tgd.tbcateg =	CASE	WHEN @MedaDistibucion = 1 	THEN 9000    
									WHEN @MedaDistibucion = 2 THEN 9001    
							ELSE 9000 END    
		AND	 tgd.tbglosa = operador      
	WHERE  Modulo <> 'OPT' 
	
	IF LEN(@Operador) > 0  BEGIN
		DELETE #TMP_RETORNO_ORDENADO 
		WHERE	LTRIM(RTRIM(Operador))  <> LTRIM(RTRIM(@Operador)) 
	END  
    
  
	 --> Para Institucionales se Eliminan las Opciones.  

	SELECT	REPLACE(ISNULL(us.rutUsuario,''),'-','')		AS	'Operador' 
	,		MonTransada						AS	'Moneda_Transada'
	,		CASE WHEN TipoOperacion = 'C'	
				THEN  SUM(ROUND(Monto ,2))
				ELSE 0 	END					AS	'Monto_Compra'
	,		CASE WHEN (TipoOperacion = 'C')--	AND MonTransada = 'USD')
				THEN  AVG(ISNULL(TCCosto,0))        
				ELSE 0 	END					AS	'TC_Costo_USD_Compra'
	,		CASE 
				WHEN TipoOperacion = 'C'--	AND MonTransada = 'USD'
				THEN  AVG(ISNULL(TCCierre,0))
				ELSE 0 
			END								AS	'TC_Cierre_USD_Compra'
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN  AVG(ISNULL(ParidadCosto,0))
				ELSE 0 
			END					AS	'Paridad_Costo_Compra'
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN  AVG(ISNULL(ParidadCierre,0))
				ELSE 0 
			END					AS	'Paridad_Cierre_Compra'
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN  SUM(ROUND(ResultadoMesa,0))
				ELSE 0 
			END					AS	'Utilidad_Compra'
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  SUM(ROUND(Monto ,2))
				ELSE 0 
			END					AS	'Monto_Venta'
	,		CASE 
				WHEN TipoOperacion = 'V'	--AND MonTransada = 'USD'
				THEN  AVG(ISNULL(TCCosto,0))        
				ELSE 0 
			END					AS	'TC_Costo_USD_Venta'
	,		CASE 
				WHEN TipoOperacion = 'V'	--AND MonTransada = 'USD'
				THEN  AVG(ISNULL(TCCierre,0))
				ELSE 0 
			END					AS	'TC_Cierre_USD_Venta'			
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  AVG(ISNULL(ParidadCosto,0))
				ELSE 0 
			END					AS	'Paridad_Costo_Venta'
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  AVG(ISNULL(ParidadCierre,0))
				ELSE 0 
			END					AS	'Paridad_Cierre_Venta'			
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  SUM(ROUND(ResultadoMesa,0) )
				ELSE 0 
			END					AS	'Utilidad_Venta'
	
	INTO    #TMP_RETORNO_ORDENADO_FINAL    
	FROM	#TMP_RETORNO_ORDENADO 
	--LEFT JOIN BacParamSuda.dbo.USUARIO as us
	INNER JOIN BacParamSuda.dbo.USUARIO as us
	ON Operador = us.usuario     
	--where TCCosto is null
	GROUP BY	us.rutUsuario						
	,			MonTransada						
	,			TipoOperacion	
	,			TCCosto        
	,			TCCierre
	,			ParidadCosto
	,			ParidadCierre
	ORDER BY	Operador						
	,			MonTransada						
	,			TipoOperacion	
	,			TCCosto        
	,			TCCierre
	,			ParidadCosto
	,			ParidadCierre


-- SE UPDATEAN LOS VALORES EN 0  PARA QUE CALCULE EL PROMEDIO SOLO CON VALORES DISTINTOS DE 0
UPDATE #TMP_RETORNO_ORDENADO_FINAL SET TC_Costo_USD_Compra = NULL
WHERE TC_Costo_USD_Compra = 0

UPDATE #TMP_RETORNO_ORDENADO_FINAL SET TC_Cierre_USD_Compra = NULL
WHERE TC_Cierre_USD_Compra = 0

UPDATE #TMP_RETORNO_ORDENADO_FINAL SET Paridad_Costo_Compra = NULL
WHERE Paridad_Costo_Compra = 0

UPDATE #TMP_RETORNO_ORDENADO_FINAL SET Paridad_Cierre_Compra = NULL
WHERE Paridad_Cierre_Compra = 0


UPDATE #TMP_RETORNO_ORDENADO_FINAL SET TC_Costo_USD_Venta = NULL
WHERE TC_Costo_USD_Venta = 0

UPDATE #TMP_RETORNO_ORDENADO_FINAL SET TC_Cierre_USD_Venta = NULL
WHERE TC_Cierre_USD_Venta = 0

UPDATE #TMP_RETORNO_ORDENADO_FINAL SET Paridad_Costo_Venta = NULL
WHERE Paridad_Costo_Venta = 0

UPDATE #TMP_RETORNO_ORDENADO_FINAL SET Paridad_Cierre_Venta = NULL
WHERE Paridad_Cierre_Venta = 0

		
	SELECT	Operador
	,		Moneda_Transada
	,		SUM(ROUND(Monto_Compra,2))   AS Monto_Compra                         
	,		ISNULL(AVG(TC_Costo_USD_Compra),0)AS  TC_Costo_USD_Compra                
	,		ISNULL(AVG(TC_Cierre_USD_Compra),0)  AS TC_Cierre_USD_Compra                  
	,		ISNULL(AVG(Paridad_Costo_Compra),0)  AS Paridad_Costo_Compra                  
	,		ISNULL(AVG(Paridad_Cierre_Compra),0)  AS Paridad_Cierre_Compra                 
	,		SUM(ROUND(Utilidad_Compra,0))  AS Utilidad_Compra                       
	,		SUM(ROUND(Monto_Venta,2))  AS  Monto_Venta                            
	,		ISNULL(AVG(TC_Costo_USD_Venta),0)  AS TC_Costo_USD_Venta                   
	,		ISNULL(AVG(TC_Cierre_USD_Venta),0) AS TC_Cierre_USD_Venta                   
	,		ISNULL(AVG(Paridad_Costo_Venta),0) AS Paridad_Costo_Venta                    
	,		ISNULL(AVG(Paridad_Cierre_Venta),0)  AS Paridad_Cierre_Venta                  
	,		SUM(ROUND(Utilidad_Venta,0))AS Utilidad_Venta
    
	FROM #TMP_RETORNO_ORDENADO_FINAL 
	GROUP BY	Operador
	,			Moneda_Transada	
	ORDER BY	Operador
	,			Moneda_Transada
	
		
 DROP TABLE #RESULTADOS_MESA
 DROP TABLE #TMP_RETORNO_ORDENADO
 DROP TABLE #TMP_RETORNO_ORDENADO_FINAL

END

GO
