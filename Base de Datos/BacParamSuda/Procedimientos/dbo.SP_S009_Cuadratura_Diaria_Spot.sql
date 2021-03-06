USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_S009_Cuadratura_Diaria_Spot]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[SP_S009_Cuadratura_Diaria_Spot]
(	@FechaDesde			DATETIME
,	@FechaHasta			DATETIME
,	@MedaDistibucion	INT = 1
,	@RutCliente			INT = 0
)
AS
BEGIN

--- SPOT, FWD, OPCIONES, SWAP, PACTOS.
        
	SET NOCOUNT ON        

	DECLARE @dFechaProceso   DATETIME        
	SET @dFechaProceso   = ( SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )        

	DECLARE @dFechaAnterior  DATETIME        
	SET @dFechaAnterior  = ( SELECT acfecante FROM BacTraderSuda.dbo.MDAC with(nolock) )        

	DECLARE	@Sw_Historico  INT
	SELECT	@Sw_Historico   = 0

	IF not (@dFechaProceso = @FechaDesde and @FechaDesde = @FechaHasta)
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
		AND		mvto.mofech         BETWEEN @FechaDesde AND @Fechahasta        
		AND		mvto.moterm    NOT IN ('DATATEC','BOLSA')        
	END
      
   
	
	--> ---BFW ---- ANTICIPOS  ---BFW---    
	---DROP TABLE #AnuladasyAnticipadas      
	
			
        

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

		DELETE #TMP_RETORNO_ORDENADO 
		WHERE	RutCliente  <> @RutCliente
	END
    

	SELECT	REPLACE(ISNULL(us.rutUsuario,''),'-','')		AS	'Operador' --Operador						AS	'Operador'
	,		MonTransada						AS	'Moneda_Transada'
	,		Numero_Operacion				AS	'Numero_Transaccion'
	,		LTRIM(RTRIM(STR(RutCliente)))
		+	LTRIM(RTRIM(DvCliente))			AS	'Rut_Cliente'
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN  ROUND(Monto ,2)
				ELSE 0 
			END					AS	'Monto_Compra'
				
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN  TCCosto        
				ELSE 0 
			END					AS	'TC_Costo_Compra'
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN  TCCierre
				ELSE 0 
			END					AS	'TC_Cierre_Compra'
	,		CASE 
				WHEN TipoOperacion = 'C'	
				THEN  ROUND(ResultadoMesa,0)
				ELSE 0 
			END					AS	'Utilidad_Compra'
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  ROUND(Monto ,2)
				ELSE 0 
			END					AS	'Monto_Venta'
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  TCCosto        
				ELSE 0 
			END					AS	'TC_Costo_Venta'
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  TCCierre
				ELSE 0 
			END					AS	'TC_Cierre_Venta'
	,		CASE 
				WHEN TipoOperacion = 'V'	
				THEN  ROUND(ResultadoMesa,0)        
				ELSE 0 
			END					AS	'Utilidad_Venta'
	FROM	#TMP_RETORNO_ORDENADO  
	INNER JOIN BacParamSuda.dbo.USUARIO as us
	ON Operador = us.usuario    
	ORDER BY	us.rutUsuario		
	,			MonTransada	
	,			Numero_Operacion

END

GO
