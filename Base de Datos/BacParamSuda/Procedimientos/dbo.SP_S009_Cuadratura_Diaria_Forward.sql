USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S009_Cuadratura_Diaria_Forward]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_S009_Cuadratura_Diaria_Forward]
	(	@FechaDesde			DATETIME
	,	@FechaHasta			DATETIME
	,	@MedaDistibucion	INT			= 1
	,	@RutCliente			INT			= 0
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
	, MonTransada         = mn1.mnnemo        
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
	
	IF @RutCliente > 0  BEGIN
	declare @myRut varchar(20)

		DELETE #TMP_RETORNO_ORDENADO 
		WHERE	RutCliente  <> @RutCliente
	END
    
  
	 --> Para Institucionales se Eliminan las Opciones.  


	SELECT	REPLACE(ISNULL(us.rutUsuario,''),'-','')		AS	'Operador' 
	,		Producto						AS	'Producto'
	,		MonTransada						AS	'Moneda_Transada'
	,		Numero_Operacion				AS	'Numero_Transaccion'
	,		ISNULL(LTRIM(RTRIM(STR(RutCliente))) +	LTRIM(RTRIM(DvCliente)),'')			AS	'Rut_Cliente'
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN ROUND(Monto ,2)
				ELSE 0 
			END								AS	'Monto_Compra'
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN  ISNULL(TCCierre,0)						
				ELSE 0 
			END								AS	'Spot_Compra'			
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN  ISNULL(TCCosto,0)        
				ELSE 0 
			END								AS	'TC_Costo_Compra'
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN  ISNULL(TCCierre,0)
				ELSE 0 
			END								AS	'TC_Cierre_Compra'
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN  ROUND(ResultadoMesa,0)
				ELSE 0 
			END								AS	'Utilidad_Compra'
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  ROUND(Monto ,2)
				ELSE 0 
			END								AS	'Monto_Venta'
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  ISNULL(TCCierre,0)						
				ELSE 0 
			END								AS	'Spot_Venta'						
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  ISNULL(TCCosto,0)        
				ELSE 0 
			END								AS	'TC_Costo_Venta'
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  ISNULL(TCCierre,0)
				ELSE 0 
			END								AS	'TC_Cierre_Venta'
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  ROUND(ResultadoMesa,0)        
				ELSE 0 
			END								AS	'Utilidad_Venta'
	FROM	#TMP_RETORNO_ORDENADO 
	INNER JOIN BacParamSuda.dbo.USUARIO as us
	ON Operador = us.usuario
	ORDER BY	us.rutUsuario--Operador		
	,			MonTransada	
	,			Numero_Operacion

END

GO
