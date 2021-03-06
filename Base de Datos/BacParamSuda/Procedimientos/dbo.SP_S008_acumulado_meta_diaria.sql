USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S008_acumulado_meta_diaria]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_S008_acumulado_meta_diaria]
	(	@FechaDesde        DATETIME
	,	@FechaHasta        DATETIME
	,	@MedaDistibucion   INT		= 1
	)
AS        
BEGIN

	SET NOCOUNT ON        

	DECLARE @dFechaProceso   DATETIME        
	SET @dFechaProceso   = ( SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )        

	DECLARE @dFechaAnterior  DATETIME        
	SET @dFechaAnterior  = ( SELECT acfecante FROM BacTraderSuda.dbo.MDAC with(nolock) )        

	DECLARE	@Sw_Historico  INT
	SELECT	@Sw_Historico   = 0

	IF not (@dFechaProceso = @FechaDesde and @FechaDesde = @FechaHasta )
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
   
   /*
	IF	(   @FechaDesde  =   @FechaHasta ) AND (@Sw_Historico  = 0) BEGIN   ---Consulta Diaria
		INSERT INTO #RESULTADOS_MESA        
		SELECT Modulo              = 'BTR'        
		,   Producto            =	CASE	WHEN mvto.motipoper = 'VP' THEN 'VENTA PROPIA'        
											WHEN mvto.motipoper = 'VI' THEN 'VENTA C/ PACTO'        
											---WHEN mvto.motipoper = 'IB' THEN 'INTERBANCARIO'        
									END        
		,   Numero_Operacion    = mvto.monumoper        
		,   Numero_Documento    = mvto.monumdocu        
		,   Numero_Correlativo  = mvto.mocorrela        
		,   Serie               = mvto.moinstser        
		,   RutCliente          = clie.clrut        
		,   CodCliente          = clie.clcodigo        
		,   DvCliente           = clie.cldv        
		,   NombreCliente       = clie.clnombre        
		,   TipoOperacion       =	CASE	WHEN mvto.motipoper = 'VP' THEN 'V'        
											WHEN mvto.motipoper = 'VI' THEN 'V'        
											---WHEN mvto.motipoper = 'IB' THEN mvto.moinstser        
									END        
		,   Monto               = mvto.movpresen        
		,   MonTransada         = mone.mnnemo        
		,   MonConversion       = mone.mnnemo        
		,   TCCierre            = mvto.motir        
		,   TCCosto             = mvto.moTirTran        
		,   ParidadCierre       = 0.0        
		,   ParidadCosto        = 0.0        
		,   MontoPesos          =	CASE WHEN mvto.motipoper IN('VI', 'VP') 
										THEN	mvto.movalven         
										ELSE	mvto.movpresen        
									END        
		,   Operador            = mvto.mousuario        
		,   MontoDolares        = 0.0        
		,   ResultadoMesa       = mvto.moDifTran_CLP        
		,   Fecha        = mvto.mofecpro --> CONVERT(CHAR(10), mvto.mofecpro, 103)     
		,   Relacionado         = '--'        
		,   FolioRelacionado    = 0        
		,	FechaEmision		=	mofecemi
		,	FechaVencimiento	=	mofecven 
		FROM BacTraderSuda.dbo.MDMO mvto        
			INNER JOIN BacParamSuda.dbo.CLIENTE clie 
			ON clie.clrut    = mvto.morutcli and clie.clcodigo = mvto.mocodcli        
			LEFT  JOIN BacParamSuda.dbo.MONEDA  mone 
			ON mone.mncodmon = mvto.momonemi        
		WHERE
		-- mvto.motipoper      IN('VP', 'VI')	---, 'IB')        
		-- AND
		mvto.mostatreg     <> 'A'        
		AND mvto.mofecpro       BETWEEN @FechaDesde AND @Fechahasta        
		ORDER BY mvto.monumoper, mvto.monumdocu, mvto.mocorrela
		
	END
	*/
	/*
	ELSE BEGIN

		INSERT INTO #RESULTADOS_MESA        
		SELECT	Modulo              = 'BTR'        
		,		Producto            =	CASE	WHEN mvto.motipoper = 'VP' THEN 'VENTA PROPIA'        
												WHEN mvto.motipoper = 'VI' THEN 'VENTA C/ PACTO'        
											---	WHEN mvto.motipoper = 'IB' THEN 'INTERBANCARIO'        
										END        
		,   Numero_Operacion    = mvto.monumoper        
		,   Numero_Documento    = mvto.monumdocu        
		,   Numero_Correlativo  = mvto.mocorrela        
		,   Serie               = mvto.moinstser        
		,   RutCliente          = clie.clrut        
		,   CodCliente          = clie.clcodigo        
		,   DvCliente           = clie.cldv        
		,   NombreCliente       = clie.clnombre        
		,   TipoOperacion       =	CASE	WHEN mvto.motipoper = 'VP' THEN 'V'        
											WHEN mvto.motipoper = 'VI' THEN 'V'        
											---WHEN mvto.motipoper = 'IB' THEN mvto.moinstser        
									END        
		,   Monto               = mvto.movpresen        
		,   MonTransada         = mone.mnnemo        
		,   MonConversion       = mone.mnnemo        
		,   TCCierre            = mvto.motir        
		,   TCCosto             = mvto.moTirTran        
		,   ParidadCierre       = 0.0        
		,   ParidadCosto        = 0.0        
		,   MontoPesos          =	CASE	WHEN mvto.motipoper in('VI', 'VP') THEN mvto.movalven         
										ELSE                                    mvto.movpresen        
									END        
		,   Operador            = mvto.mousuario        
		,   MontoDolares        = 0.0        
		,   ResultadoMesa       = mvto.moDifTran_CLP        
		,   Fecha        = mvto.mofecpro --> CONVERT(CHAR(10), mvto.mofecpro, 103)        
		,   Relacionado         = '--'        
		,   FolioRelacionado    = 0        
		,	FechaEmision		=	mofecemi
		,	FechaVencimiento	=	mofecven 
		FROM BacTraderSuda.dbo.MDMH mvto        
			INNER JOIN BacParamSuda.dbo.CLIENTE clie 
				ON clie.clrut    = mvto.morutcli 
				AND clie.clcodigo = mvto.mocodcli        
			LEFT  JOIN BacParamSuda.dbo.MONEDA  mone 
				ON mone.mncodmon = mvto.momonemi        
		WHERE	mvto.motipoper      IN('VP', 'VI') ---, 'IB')        
		AND		mvto.mostatreg      <> 'A'        
		AND		mvto.mofecpro       BETWEEN @FechaDesde AND @Fechahasta        
		ORDER BY mvto.monumoper, mvto.monumdocu, mvto.mocorrela        
	END
	*/
	

	
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
		,   ParidadCierre   = mvto.moparme        
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
		--AND		mvto.motipope  = 'V'		--- Solo las Ventas?!?!?!?!?!
		AND		mvto.moterm <> 'FORWARD' 
		AND		mvto.moterm <> 'SWAP' 
		AND		mvto.moterm <> 'OPCIONES'         
		AND		mvto.mofech         BETWEEN @FechaDesde AND @Fechahasta        
		AND		mvto.moterm         NOT IN ('DATATEC','BOLSA')        
		
	END
	/*
	 ELSE BEGIN					---- Consulta Histórica 
	
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
		AND		mvto.motipope  = 'V'		--- Solo las Ventas
		AND		mvto.moterm <> 'FORWARD' 
		AND		mvto.moterm <> 'SWAP' 
		AND		mvto.moterm <> 'OPCIONES'         
		AND		mvto.mofech         BETWEEN @FechaDesde AND @Fechahasta        
		AND		mvto.moterm         NOT IN ('DATATEC','BOLSA')        
	END
      
	  */
   -------------- FORWARD ----- FORWARD --- FORWARD -----------------------------------------------        

   
	IF	(   @FechaDesde  =   @FechaHasta )AND (@Sw_Historico  = 0) BEGIN   ---Consulta Diaria
	        
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
		--,   ResultadoMesa       =	CASE WHEN mvto.mocodpos1 = 2 
		--								THEN	ROUND(mvto.Resultado_Mesa * vcont.tipo_cambio, 0)       
		--								ELSE	mvto.Resultado_Mesa      
		--							END        
		,	ResultadoMesa		= mvto.Resultado_Mesa
		,   Fecha      = mvto.mofecha  --> CONVERT(CHAR(10), mvto.mofecha, 103)        
		,   Relacionado         = CASE WHEN var_moneda2  <> 0 THEN 'Operacion Relacionada MX/CLP' ELSE '--' END      
		,   FolioRelacionado    = 0        
		,	FechaEmision		=	mofecEfectiva           
		,	FechaVencimiento	=	mofecvcto               
		FROM    BacFwdSuda.dbo.MFMO  mvto        
			INNER JOIN bacfwdsuda.dbo.mfca   cart 
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
		WHERE	mvto.moestado     <> 'A'        
		AND		mvto.mofecha       BETWEEN @FechaDesde AND @Fechahasta        
		--AND		mvto.motipoper  = 'V' -->Solamente las Ventas?!?!?!?!?
		
	END
	ELSE BEGIN     --- Consulta Histórica 
	        
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
					ON clie.clrut  = mvto.mocodigo 
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
		WHERE	mvto.moestado     <> 'A'        
		--AND		mvto.motipoper  = 'V'
		AND		mvto.mofecha       BETWEEN @FechaDesde AND @Fechahasta        
		
	END	---- Fin FORWARD 

	---------------------------------------------------------------------------------------
	----------SWAP --- SWAP --- SWAP --- SWAP --- SWAP --- SWAP --- SWAP ------------------
        
		/*
	IF	(   @FechaDesde  =   @FechaHasta ) AND (@Sw_Historico  = 0) BEGIN   ---Consulta Diaria		
        
		INSERT INTO #RESULTADOS_MESA        
		SELECT Modulo           = 'PCS'        
		,   Producto         =	CASE	WHEN mvto.tipo_swap = 1 THEN 'SWAP DE TASAS'        
								 		WHEN mvto.tipo_swap = 2 THEN 'SWAP DE MONEDAS'        
										WHEN mvto.tipo_swap = 3 THEN 'FORWARD RATE AGREETMEN'        
										WHEN mvto.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'        
								END        
		,   Numero_Operacion = mvto.numero_operacion        
		,   Documento        = 0        
		,   Correlativo      = 0        
		,   Serie            = ''        
		,   RutCliente       = clie.clrut        
		,   CodCliente       = clie.clcodigo        
		,   DvCliente        = clie.cldv        
		,   NombreCliente    = clie.clnombre        
		,   TipoOperacion    = 'C'        
		,   Monto            = mvto.compra_capital        
		,   MonTransada      = mon1.mnnemo        
		,   MonConversion    = mon2.mnnemo        
		,   TCCierre         = mvto.compra_valor_tasa        
		,   TCCosto          = mvto.Tasa_Transfer        
		,   ParidadCierre    = vent.venta_valor_tasa        
		,   ParidadCosto     = vent.Tasa_Transfer        
		,   MontoPesos       = vent.venta_capital        
		,   Operador         = mvto.operador        
		,   MontoDolares     = 0        
		,   ResultadoMesa    = mvto.Res_Mesa_Dist_CLP         
		,   Fecha     = mvto.fecha_cierre --> CONVERT(CHAR(10), mvto.fecha_cierre, 103)        
		,   Relacionado      = '--'        
		,   FolioRelacionado = 0        
		,	FechaEmision		=	vent.fecha_inicio        
		,	FechaVencimiento	=	vent.fecha_termino            		
		FROM  BacSwapSuda.dbo.MOVDIARIO     mvto        
			INNER JOIN BacSwapSuda.dbo.MOVDIARIO    vent 
				ON	vent.numero_operacion = mvto.numero_operacion         
				AND vent.numero_flujo     = mvto.numero_flujo        
				AND	vent.tipo_flujo = 2        
			INNER JOIN BacParamSuda.dbo.CLIENTE     clie 
				ON clie.clrut = mvto.rut_cliente 
				AND clie.clcodigo = mvto.codigo_cliente         
			LEFT  JOIN BacParamSuda.dbo.MONEDA      mon1 
				ON mon1.mncodmon = mvto.compra_moneda        
			LEFT  JOIN BacParamSuda.dbo.MONEDA      mon2 
				ON mon2.mncodmon = vent.venta_moneda        
		WHERE	mvto.estado           <> 'C'        
		AND		mvto.tipo_operacion = 'V'
		AND		mvto.fecha_cierre     BETWEEN @FechaDesde AND @Fechahasta        
		AND		mvto.tipo_flujo       = 1        
		AND		mvto.numero_flujo     = (	SELECT MIN( ctlf.numero_flujo ) FROM BacSwapSuda.dbo.MOVDIARIO ctlf         
										WHERE	ctlf.fecha_cierre      BETWEEN @FechaDesde AND @Fechahasta        
										AND		ctlf.numero_operacion  = mvto.numero_operacion         
										AND		ctlf.tipo_flujo        = 1)        
		                              
	END ELSE BEGIN    ----- Consulta Histórica                                   
                                      
		INSERT INTO #RESULTADOS_MESA        
		SELECT Modulo    = 'PCS'        
		,   Producto         =	CASE WHEN mvto.tipo_swap = 1 THEN 'SWAP DE TASAS'        
									WHEN mvto.tipo_swap = 2 THEN 'SWAP DE MONEDAS'        
									WHEN mvto.tipo_swap = 3 THEN 'FORWARD RATE AGREETMEN'        
									WHEN mvto.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'        
								END        
		,   Numero_Operacion = mvto.numero_operacion        
		,   Documento        = 0        
		,   Correlativo      = 0        
		,   Serie            = ''        
		,   RutCliente       = clie.clrut        
		,   CodCliente       = clie.clcodigo        
		,   DvCliente        = clie.cldv        
		,   NombreCliente    = clie.clnombre        
		,   TipoOperacion    = 'C'        
		,   Monto            = mvto.compra_capital        
		,   MonTransada      = mon1.mnnemo        
		,   MonConversion    = mon2.mnnemo        
		,   TCCierre         = mvto.compra_valor_tasa        
		,   TCCosto          = mvto.Tasa_Transfer        
		,   ParidadCierre    = vent.venta_valor_tasa        
		,   ParidadCosto     = vent.Tasa_Transfer        
		,   MontoPesos       = vent.venta_capital        
		,   Operador         = mvto.operador        
		,   MontoDolares     = 0        
		,   ResultadoMesa    = mvto.Res_Mesa_Dist_CLP         
		,   Fecha     = mvto.fecha_cierre  --> CONVERT(CHAR(10), mvto.fecha_cierre, 103)        
		,   Relacionado      = '--'        
		,   FolioRelacionado = 0        
		,	FechaEmision		=	mvto.fecha_inicio        
		,	FechaVencimiento	=	mvto.fecha_termino            		
		FROM  BacSwapSuda.dbo.MOVHISTORICO            mvto        
			INNER JOIN BacSwapSuda.dbo.MOVHISTORICO vent ON vent.numero_operacion = mvto.numero_operacion         
			and vent.numero_flujo = mvto.numero_flujo        
			and vent.tipo_flujo       = 2        
			INNER JOIN BacParamSuda.dbo.CLIENTE     clie ON clie.clrut = mvto.rut_cliente and clie.clcodigo = mvto.codigo_cliente         
			LEFT  JOIN BacParamSuda.dbo.MONEDA      mon1 ON mon1.mncodmon = mvto.compra_moneda        
			LEFT  JOIN BacParamSuda.dbo.MONEDA      mon2 ON mon2.mncodmon = vent.venta_moneda        
		WHERE	mvto.estado           <> 'C'        
		AND		mvto.tipo_operacion = 'V'
		AND		mvto.fecha_cierre     BETWEEN @FechaDesde AND @Fechahasta        
		AND		mvto.tipo_flujo       = 1        
		AND		mvto.numero_flujo     = (	SELECT MIN( ctlf.numero_flujo ) 
										FROM BacSwapSuda.dbo.MOVHISTORICO ctlf         
										WHERE ctlf.fecha_cierre      BETWEEN @FechaDesde AND @Fechahasta        
										AND ctlf.numero_operacion  = mvto.numero_operacion         
										AND ctlf.tipo_flujo        = 1)        
	END  ---- FIN SWAP
		
                                  
   ----- PCS -----  ANTICIPOS  ----  --PCS--   <--        
   
   INSERT INTO #RESULTADOS_MESA        
   SELECT Modulo           = 'PCS'        
      ,   Producto         = CASE WHEN his.tipo_swap = 1 THEN 'ANT SWAP DE TASAS'        
                                  WHEN his.tipo_swap = 2 THEN 'ANT SWAP DE MONEDAS'        
                                  WHEN his.tipo_swap = 3 THEN 'ANT FORWARD RATE AGREETMEN'        
                                  WHEN his.tipo_swap = 4 THEN 'ANT SWAP PROMEDIO CAMARA'        
                             END        
      ,   Numero_Operacion = his.numero_operacion        
      ,   Documento        = 0        
      ,   Correlativo      = 0        
      ,   Serie            = ''        
      ,   RutCliente       = clie.clrut        
      ,   CodCliente       = clie.clcodigo        
      ,   DvCliente        = clie.cldv        
      ,   NombreCliente    = clie.clnombre        
      ,   TipoOperacion    = 'C'        
      ,   Monto            = his.compra_capital        
      ,   MonTransada      = mon1.mnnemo        
      ,   MonConversion    = mon2.mnnemo      
      ,   TCCierre         = his.compra_valor_tasa      
      ,   TCCosto    = 0.0 --> his.Tasa_Transfer        
     ,   ParidadCierre    = vta.venta_valor_tasa        
      ,   ParidadCosto     = 0.0 --> vta.Tasa_Transfer         
      ,   MontoPesos       = vta.venta_capital        
      ,   Operador         = his.operador        
      ,   MontoDolares     = 0        
      ,   ResultadoMesa    = unw.ResMesa --> his.Res_Mesa_Dist_CLP         
      ,   Fecha     = his.fecha_cierre    --> CONVERT(CHAR(10), mvto.fecha_cierre, 103)        
      ,   Relacionado      = '--'        
      ,   FolioRelacionado = 0        
      ,	  FechaEmision		=	his.fecha_inicio        
	  ,	  FechaVencimiento	=	his.fecha_termino            		
   FROM   BacSwapsuda.dbo.CARTERAHIS            his        
          INNER JOIN BacSwapsuda.dbo.CARTERAHIS vta ON vta.numero_operacion = his.numero_operacion         
                                                   AND vta.numero_flujo     = his.numero_flujo        
                                                   AND vta.tipo_flujo       = 2        
        
          INNER JOIN ( SELECT numero_operacion as NumCon, MIN(numero_flujo) -1 as FluCon, tipo_flujo as TipCon, MIN( Devengo_Recibido_Mda_Val /*Principal_Mda_Val*/ ) as ResMesa        
                         FROM BacswapSuda.dbo.CARTERA_UNWIND        
                        WHERE FechaAnticipo BETWEEN @FechaDesde AND @Fechahasta        
                          AND tipo_flujo = 1 GROUP BY numero_operacion, tipo_flujo ) unw ON unw.NumCon  = his.numero_operacion        
                                                              AND unw.FluCon  = his.numero_flujo        
                                                                                        AND unw.TipCon  = his.tipo_flujo        
          INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut    = his.rut_cliente AND clie.clcodigo = his.codigo_cliente        
          LEFT  JOIN BacParamSuda.dbo.MONEDA  mon1 ON mon1.mncodmon = his.compra_moneda        
          LEFT  JOIN BacParamSuda.dbo.MONEDA  mon2 ON mon2.mncodmon = vta.venta_moneda        
   WHERE  his.estado      <> 'C'  
   AND  his.tipo_flujo   = 1        
   AND	his.Tipo_Operacion = 'V'
   AND (@Sw_Historico  = 1)
        
        
	--> *******************************OPCIONES*************************    
    
	SELECT * 
	INTO	#AnuladasyAnticipadas 
	FROM	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato      
	WHERE	moTipoTransaccion = 'ANULA' or moTipoTransaccion = 'ANTICIPA'      
	AND		MoFechaContrato >= @FechaDesde       
	AND		MoFechaContrato <= @FechaHasta      

	SELECT	* 
	INTO	#AnuladasyAnticipadasII from  LNKOPC.CbMdbOpc.dbo.MoEncContrato    
	WHERE	moTipoTransaccion = 'ANULA' or moTipoTransaccion = 'ANTICIPA'    
	AND		MoFechaContrato >= @FechaDesde     
	AND		MoFechaContrato <= @FechaHasta    

  
	IF	(   @FechaDesde  =   @FechaHasta ) AND (@Sw_Historico  = 0) BEGIN   ---Consulta Diaria		
  
		INSERT INTO #RESULTADOS_MESA   
		SELECT          Modulo   = 'OPT'   
		,  Producto  = MoCallPut  
		,  Numero_Operacion = LTRIM(RTRIM(mvto.MoNumContrato))    
		,  Documento  = 0  
		,  Correlativo  = 0  
		,  Serie   = ''  
		,  RutCliente  = LTRIM(RTRIM(CONVERT(CHAR(10),clie.Clrut)))  
		,  CodCliente  = MoCodigo  
		,  DvCliente  = LTRIM(RTRIM(clie.Cldv))  
		,  NombreCliente  = LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre))))  
		,  TipoOperacion  = CASE WHEN ctro.MoVinculacion ='Individual' THEN ctro.MoCVOpc ELSE '' END  
		,  Monto   = ctro.MoMontoMon1  
		,  MonTransada  = mon1.mnnemo  
		,  MonConversion  = mon2.mnnemo  
		,  TCCierre  = ctro.MoStrike  
		,  TCCosto   = 0.0  
		,  ParidadCierre  = 0.0  
		,  ParidadCosto  = 0.0  
		,  MontoPesos  = ctro.MoMontoMon2    
		,  Operador  = mooperador  
		,  MontoDolares  = ctro.MoMontoMon1    
		,  ResultadoMesa  = ISNULL(mvto.MoResultadoVentasML,0)  
		,  Fecha   = CONVERT(CHAR(8),mvto.MoFechaContrato,112)  
		,  Relacionado  = '--' 
		,  FolioRelacionado = 0 --mvto.MoNumFolio    
		,  FechaEmision		=	CONVERT(CHAR(8),mvto.MoFechaContrato,112)     
		,  FechaVencimiento	=	CONVERT(CHAR(8),mvto.MoFechaContrato,112)   
		FROM	LNKOPC.CbMdbOpc.dbo.MoEncContrato            mvto    
			INNER JOIN LNKOPC.CbMdbOpc.dbo.MoDetContrato ctro 
			ON ctro.MoNumFolio = mvto.MoNumFolio and ctro.MoNumEstructura=1    
			INNER JOIN BacParamSuda.dbo.CLIENTE      clie 
			ON clie.clrut      = mvto.MoRutCliente and clie.clcodigo = mvto.MoCodigo    
			LEFT  JOIN BacParamSuda.dbo.MONEDA      mon1 
			ON mon1.mncodmon   = ctro.MoCodMon1    
			LEFT  JOIN BacParamSuda.dbo.MONEDA      mon2 
			ON mon2.mncodmon   = ctro.MoCodMon2   
		WHERE	mvto.MoFechaContrato between @FechaDesde  and @FechaHasta  
		AND		mvto.MoCVEstructura = 'V'
		AND		mvto.MoResultadoVentasML <> 0  
		AND     mvto.MoNumContrato       not in ( select MoNumcontrato from #AnuladasyAnticipadasII )     
		AND     mvto.MoEstado            <> 'C'  
		
	END ELSE BEGIN
	
		INSERT INTO #RESULTADOS_MESA     
		SELECT  Modulo    = 'OPT'     
		,  Producto   = MoCallPut    
		,  Numero_Operacion = LTRIM(RTRIM(mvto.MoNumContrato))      
		,  Documento   = 0    
		,  Correlativo   = 0    
		,  Serie    = ''    
		,  RutCliente   = LTRIM(RTRIM(CONVERT(CHAR(10),clie.Clrut)))    
		,  CodCliente   = MoCodigo    
		,  DvCliente   = LTRIM(RTRIM(clie.Cldv))    
		,  NombreCliente  = LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre))))    
		,  TipoOperacion  = CASE WHEN ctro.MoVinculacion ='Individual' THEN ctro.MoCVOpc ELSE '' END    
		,  Monto    = ctro.MoMontoMon1    
		,  MonTransada   = mon1.mnnemo    
		,  MonConversion  = mon2.mnnemo    
		,  TCCierre   = ctro.MoStrike    
		,  TCCosto    = 0.0    
		,  ParidadCierre  = 0.0    
		,  ParidadCosto  = 0.0    
		,  MontoPesos   = ctro.MoMontoMon2      
		,  Operador   = mooperador    
		,  MontoDolares  = ctro.MoMontoMon1      
		,  ResultadoMesa  = ISNULL(mvto.MoResultadoVentasML,0)    
		,  Fecha    = CONVERT(CHAR(8),mvto.MoFechaContrato,112)    
		,  Relacionado   = '--'      
		,  FolioRelacionado = 0 --mvto.MoNumFolio      
		,  FechaEmision		=	CONVERT(CHAR(8),mvto.MoFechaContrato,112)     
		,  FechaVencimiento	=	CONVERT(CHAR(8),mvto.MoFechaContrato,112)   
		FROM LNKOPC.CbMdbOpc.dbo.MoHisEncContrato   mvto      
			INNER JOIN BacParamSuda.dbo.CLIENTE    clie 
			ON clie.clrut  = mvto.MoRutCliente and clie.clcodigo = mvto.MoCodigo      
			INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato ctro 
			ON mvto.MoNumFolio = ctro.MoNumFolio and ctro.MoNumEstructura=1      
			LEFT  JOIN BacParamSuda.dbo.MONEDA    mon1 
			ON mon1.mncodmon   = ctro.MoCodMon1      
			LEFT  JOIN BacParamSuda.dbo.MONEDA    mon2 
			ON mon2.mncodmon   = ctro.MoCodMon2     
		WHERE	mvto.MoFechaContrato between @FechaDesde  and @FechaHasta    
		AND		mvto.moestado <> 'C'  
		AND		mvto.MoCVEstructura = 'V'
		AND		mvto.MoResultadoVentasML <> 0    
		AND		mvto.MoNumContrato not in ( select MoNumcontrato from #AnuladasyAnticipadas )       
		
	END		
	
	
	--> ---BFW ---- ANTICIPOS  ---BFW---    
	DROP TABLE #AnuladasyAnticipadas      
	*/
	

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
	,   cafecha, cafecvcto, caestado,  caantici,  caoperador        
	,   precio_spot, caantptosfwd = 0.0, caantptoscos = 0.0        
	FROM BacFwdsuda.dbo.MFCAH  unw with(nolock)        
	WHERE unw.cafecvcto BETWEEN @FechaDesde and @Fechahasta  
	AND	(@Sw_Historico  = 1)      
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
    
	UNION    
    
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
	FROM   #RESULTADOS_MESA    
	WHERE  Modulo = 'OPT'    
  
	 --> Para Institucionales se Eliminan las Opciones.  
	IF @MedaDistibucion = 2     BEGIN  
		DELETE FROM #TMP_RETORNO_ORDENADO   
		WHERE Modulo = 'OPT'  
	END  
	

	SELECT	Operador							AS	'Operador'			
	,		Producto							AS	'Producto'		---Se ACTIVA PARA REVISIÓN
	--,		ROUND(SUM((MontoPesos / 1000.0)),0)	AS	'Monto' --cambiar con la confirmacion del usuario.
	,		ROUND(SUM((ResultadoMesa)),0)	AS	'Monto' --cambiar con la confirmacion del usuario.
	,		ISNULL((SELECT	CASE 
							WHEN Clasificacion =	'Flow'		THEN 'SI'
							WHEN Clasificacion =	'No Flow'	THEN 'NO' 
							ELSE 'NO CLASIFICADO'
							END
					FROM	PivotalProductoFlow	
					WHERE	Familia		= Producto	),
					'NO CLASIFICADO')				AS	'Flow'					--->SI</Flow>
	INTO #TMP_RETORNO_ORDENADO_AGRUPADO
	FROM	#TMP_RETORNO_ORDENADO    
	GROUP BY Operador , Fecha, Producto
	ORDER BY fecha , Operador ,Producto


	SELECT 		--dus.Operador		AS	'Operador' --
	REPLACE(ISNULL(us.rutUsuario,''),'-','')		AS	'Operador'     
	--,			SUM(dus.Monto )		AS	'Monto'
	
	
	,CONVERT(NUMERIC(21,0),(SUM(dus.Monto ))	)	AS	'Monto'
	--,CONVERT(NUMERIC(21,0),(SUM(dus.ResultadoMesa ))	)	AS	'Monto'
	
	,			dus.Flow			As	'Flow'

	FROM	#TMP_RETORNO_ORDENADO_AGRUPADO as dus
	INNER JOIN BacParamSuda.dbo.USUARIO as us
	ON dus.Operador = us.usuario
	--GROUP BY Operador, Flow
	GROUP BY us.RutUsuario, dus.Flow

END

GO
