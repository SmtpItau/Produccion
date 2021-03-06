USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[QUERY_RESULTADO_MESA_ENTREFECHAS_PrePaso]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[QUERY_RESULTADO_MESA_ENTREFECHAS_PrePaso]
   (   @FechaDesde        DATETIME
   ,   @FechaHasta        DATETIME
   ,   @MedaDistibucion   INT = 1
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = ( SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )

   DECLARE @dFechaAnterior  DATETIME
       SET @dFechaAnterior  = ( SELECT acfecante FROM BacTraderSuda.dbo.MDAC with(nolock) )

   IF @dFechaProceso < @FechaDesde or @dFechaProceso < @FechaHasta
   BEGIN
      RETURN
   END

	CREATE TABLE #RESULTADOS_MESA        
	(	Modulo           CHAR(3)
	,	Producto         VARCHAR(50)
	,	Numero_Operacion NUMERIC(9)
	,	Documento        NUMERIC(9)
	,	Correlativo      NUMERIC(21,4)
	,   Serie            VARCHAR(20)
	,   RutCliente       NUMERIC(12)
	,   CodCliente       INT
	,   DvCliente        CHAR(1)
	,   NombreCliente    VARCHAR(150)
	,   TipoOperacion    VARCHAR(25)
	,   Monto            NUMERIC(21,4)
	,   MonTransada      CHAR(5)
	,   MonConversion    CHAR(5)
	,   TCCierre         NUMERIC(21,4)
	,   TCCosto          NUMERIC(21,4)
	,   ParidadCierre    NUMERIC(21,4)
	,   ParidadCosto     NUMERIC(21,4)
	,   MontoPesos       NUMERIC(21,4)
	,   Operador         VARCHAR(15)
	,   MontoDolares     NUMERIC(21,4)
	,   ResultadoMesa    NUMERIC(21,4)
	,   Fecha            DATETIME
	,   Relacionado      VARCHAR(35)
	,   FolioRelacionado NUMERIC(9)
	)

	CREATE INDEX #ix_orden ON #RESULTADOS_MESA ( fecha, Modulo, Producto,  RutCliente, CodCliente, Numero_Operacion, Documento, Correlativo )


/*
   INSERT INTO #RESULTADOS_MESA        
   SELECT Modulo              = 'BTR'        
      ,   Producto            = CASE WHEN mvto.motipoper = 'CP' THEN 'COMPRA PROPIA'        
                                     WHEN mvto.motipoper = 'CI' THEN 'COMPRA C/ PACTO'        
                                     WHEN mvto.motipoper = 'VP' THEN 'VENTA PROPIA'        
                                     WHEN mvto.motipoper = 'VI' THEN 'VENTA C/ PACTO'        
                                     WHEN mvto.motipoper = 'IB' THEN 'INTERBANCARIO'        
                                END        
      ,   Numero_Operacion    = mvto.monumoper        
      ,   Numero_Documento    = mvto.monumdocu        
      ,   Numero_Correlativo  = mvto.mocorrela        
      ,   Serie               = mvto.moinstser        
      ,   RutCliente          = clie.clrut        
      ,   CodCliente          = clie.clcodigo        
      ,   DvCliente           = clie.cldv        
      ,   NombreCliente       = clie.clnombre        
      ,   TipoOperacion       = CASE WHEN mvto.motipoper = 'CP' THEN 'C'        
                                     WHEN mvto.motipoper = 'CI' THEN 'C'        
                                     WHEN mvto.motipoper = 'VP' THEN 'V'        
                                     WHEN mvto.motipoper = 'VI' THEN 'V'        
                                     WHEN mvto.motipoper = 'IB' THEN mvto.moinstser        
                                END        
      ,   Monto               = mvto.movpresen        
      ,   MonTransada         = mone.mnnemo        
      ,   MonConversion       = mone.mnnemo        
      ,   TCCierre            = mvto.motir        
      ,   TCCosto             = mvto.moTirTran        
      ,   ParidadCierre       = 0.0        
      ,   ParidadCosto    = 0.0        
      ,   MontoPesos          = CASE WHEN mvto.motipoper IN('VI', 'VP') THEN mvto.movalven         
                                     ELSE                              mvto.movpresen        
                                END        
      ,   Operador            = mvto.mousuario        
      ,   MontoDolares        = 0.0        
     ,   ResultadoMesa       = mvto.moDifTran_CLP        
      ,   Fecha        = mvto.mofecpro --> CONVERT(CHAR(10), mvto.mofecpro, 103)     
      ,   Relacionado         = '--'        
      ,   FolioRelacionado    = 0        
     FROM BacTraderSuda.dbo.MDMO mvto        
          INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut    = mvto.morutcli and clie.clcodigo = mvto.mocodcli        
          LEFT  JOIN BacParamSuda.dbo.MONEDA  mone ON mone.mncodmon = mvto.momonemi        
    WHERE mvto.motipoper      IN('CP', 'CI', 'VP', 'VI', 'IB')        
      AND mvto.mostatreg     <> 'A'        
 AND mvto.mofecpro       BETWEEN @FechaDesde AND @Fechahasta        
    ORDER BY mvto.monumoper, mvto.monumdocu, mvto.mocorrela        
        
   INSERT INTO #RESULTADOS_MESA        
   SELECT Modulo              = 'BTR'        
      ,   Producto            = CASE WHEN mvto.motipoper = 'CP' THEN 'COMPRA PROPIA'        
                                     WHEN mvto.motipoper = 'CI' THEN 'COMPRA C/ PACTO'        
                                     WHEN mvto.motipoper = 'VP' THEN 'VENTA PROPIA'        
                                     WHEN mvto.motipoper = 'VI' THEN 'VENTA C/ PACTO'        
                                     WHEN mvto.motipoper = 'IB' THEN 'INTERBANCARIO'        
                                END        
      ,   Numero_Operacion    = mvto.monumoper        
      ,   Numero_Documento    = mvto.monumdocu        
      ,   Numero_Correlativo  = mvto.mocorrela        
      ,   Serie               = mvto.moinstser        
      ,   RutCliente          = clie.clrut        
      ,   CodCliente          = clie.clcodigo        
      ,   DvCliente           = clie.cldv        
      ,   NombreCliente       = clie.clnombre        
      ,   TipoOperacion       = CASE WHEN mvto.motipoper = 'CP' THEN 'C'        
                                     WHEN mvto.motipoper = 'CI' THEN 'C'        
                                     WHEN mvto.motipoper = 'VP' THEN 'V'        
                                     WHEN mvto.motipoper = 'VI' THEN 'V'        
                                     WHEN mvto.motipoper = 'IB' THEN mvto.moinstser        
                                END        
      ,   Monto               = mvto.movpresen        
      ,   MonTransada         = mone.mnnemo        
      ,   MonConversion       = mone.mnnemo        
      ,   TCCierre            = mvto.motir        
      ,   TCCosto             = mvto.moTirTran        
      ,   ParidadCierre       = 0.0        
      ,   ParidadCosto        = 0.0        
      ,   MontoPesos          = CASE WHEN mvto.motipoper in('VI', 'VP') THEN mvto.movalven         
                                     ELSE                                    mvto.movpresen        
                                END        
      ,   Operador            = mvto.mousuario        
      ,   MontoDolares        = 0.0        
      ,   ResultadoMesa       = mvto.moDifTran_CLP        
      ,   Fecha        = mvto.mofecpro --> CONVERT(CHAR(10), mvto.mofecpro, 103)        
      ,   Relacionado         = '--'        
      ,   FolioRelacionado    = 0        
     FROM BacTraderSuda.dbo.MDMH mvto        
          INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut    = mvto.morutcli and clie.clcodigo = mvto.mocodcli        
          LEFT  JOIN BacParamSuda.dbo.MONEDA  mone ON mone.mncodmon = mvto.momonemi        
    WHERE mvto.motipoper      IN('CP', 'CI', 'VP', 'VI', 'IB')        
      AND mvto.mostatreg      <> 'A'        
      AND mvto.mofecpro       BETWEEN @FechaDesde AND @Fechahasta        
    ORDER BY mvto.monumoper, mvto.monumdocu, mvto.mocorrela        
        
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
      ,   TCCosto             = CASE WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon  = 'USD' THEN mvto.CMX_TC_Costo_Trad  
                                     WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon <> 'USD' THEN mvto.motctra  
                                     ELSE mvto.motctra  
                                END  
                             -- CASE WHEN mvto.moterm = 'COMEX' THEN mvto.CMX_TC_Costo_Trad ELSE mvto.motctra END      
      ,   ParidadCierre       = mvto.moparme        
      ,   ParidadCosto        = CASE WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon  = 'USD' THEN mvto.mopartr  
                                     WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon <> 'USD' THEN mvto.CMX_TC_Costo_Trad  
                                     ELSE mvto.mopartr  
                                END  
                             -- mvto.mopartr  
      ,   MontoPesos          = mvto.momonpe        
      ,   Operador            = mvto.mooper        
      ,   MontoDolares        = mvto.moussme        
      ,   ResultadoMesa       = CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END       
      ,   Fecha               = mvto.mofech  --> CONVERT(CHAR(10), mvto.mofech, 103)        
      ,   Relacionado         = CASE WHEN mvto.monumfut > 0 AND mvto.moterm = 'SWAP SPOT'                         THEN 'Swap Spot'         
                                     WHEN mvto.monumfut > 0 AND mvto.moterm = 'EMPRESAS'  AND morutcli = 96665450 THEN 'Neteo'        
                                     ELSE                                                                              'Sin Relación'         
                                END        
      , FolioRelacionado      = CASE WHEN mvto.monumfut > 0 AND mvto.moterm = 'SWAP SPOT'                             THEN mvto.monumfut        
                                     WHEN mvto.monumfut > 0 AND mvto.moterm = 'EMPRESAS' AND mvto.morutcli = 96665450 THEN mvto.monumfut        
                                     ELSE                                                                                  0        
                                END        
   FROM   BacCamSuda.dbo.MEMO mvto        
          INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut = mvto.morutcli and clie.clcodigo = mvto.mocodcli        
   WHERE  mvto.moestatus     <> 'A' and mvto.moterm <> 'FORWARD' and mvto.moterm <> 'SWAP' and mvto.moterm <> 'OPCIONES'         
     AND  mvto.mofech         BETWEEN @FechaDesde AND @Fechahasta        
     AND  mvto.moterm         NOT IN ('DATATEC','BOLSA')        
--     AND  mvto.moterm         <> 'FICTICIO' --> and moDifTran_Mo = 0      
      
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
      ,   MonConversion    = mvto.mocodcnv        
      ,   TCCierre            = mvto.moticam        
      ,   TCCosto             = CASE WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon  = 'USD' THEN mvto.CMX_TC_Costo_Trad  
                                     WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon <> 'USD' THEN mvto.motctra  
                                     ELSE mvto.motctra  
                                END  
                             -- CASE WHEN mvto.moterm = 'COMEX' THEN mvto.CMX_TC_Costo_Trad ELSE mvto.motctra END      
      ,   ParidadCierre       = mvto.moparme        
      ,   ParidadCosto        = CASE WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon  = 'USD' THEN mvto.mopartr  
                                     WHEN mvto.moterm = 'COMEX' AND mvto.mocodmon <> 'USD' THEN mvto.CMX_TC_Costo_Trad  
                                     ELSE mvto.mopartr  
                                END  
                             -- mvto.mopartr  
      ,   MontoPesos          = mvto.momonpe        
      ,   Operador            = mvto.mooper        
      ,   MontoDolares        = mvto.moussme        
      ,   ResultadoMesa       = CASE WHEN mvto.moterm = 'COMEX' THEN mvto.moResultado_Comercial_Clp ELSE mvto.moDifTran_Clp END       
      ,   Fecha               = mvto.mofech --> CONVERT(CHAR(10), mvto.mofech, 103)        
      ,   Relacionado         = CASE WHEN mvto.monumfut > 0 AND mvto.moterm = 'SWAP SPOT'                         THEN 'Swap Spot'         
                                     WHEN mvto.monumfut > 0 AND mvto.moterm = 'EMPRESAS'  AND morutcli = 96665450 THEN 'Neteo'        
                                     ELSE 'Sin Relación'         
  END        
      ,   FolioRelacionado    = CASE WHEN mvto.monumfut > 0 AND mvto.moterm = 'SWAP SPOT'                             THEN mvto.monumfut        
                                     WHEN mvto.monumfut > 0 AND mvto.moterm = 'EMPRESAS' AND mvto.morutcli = 96665450 THEN mvto.monumfut        
                                     ELSE                                                                                  0        
                                END        
   FROM   BacCamSuda.dbo.MEMOH mvto        
          INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut = mvto.morutcli and clie.clcodigo = mvto.mocodcli        
   WHERE  mvto.moestatus     <> 'A' and  mvto.moterm <> 'FORWARD' and mvto.moterm <> 'SWAP' and mvto.moterm <> 'OPCIONES'         
     AND  mvto.mofech         BETWEEN @FechaDesde AND @Fechahasta        
     AND  mvto.moterm         NOT IN ('DATATEC','BOLSA')        
--     AND  mvto.moterm         <> 'FICTICIO' --> and moDifTran_Mo = 0      
      
   ------------------------------------------------------------------------------        
   ------------------------------------------------------------------------------        
   ------------------------------------------------------------------------------        
        
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
      ,   TCCierre            = CASE WHEN mvto.mocodpos1 = 1  THEN mvto.motipcam         
                                     WHEN mvto.mocodpos1 = 2  THEN mvto.mopremon1        
                                     WHEN mvto.mocodpos1 = 3  THEN mvto.motipcam        
                                     WHEN mvto.mocodpos1 = 13 THEN mvto.motipcam        
                                END        
      ,   TCCosto             = CASE WHEN mvto.mocodpos1 = 1  THEN mvto.mopreciopunta        
                                     WHEN mvto.mocodpos1 = 2  THEN mvto.mopremon2        
                                     WHEN mvto.mocodpos1 = 3  THEN mvto.mopreciopunta        
                                     WHEN mvto.mocodpos1 = 13 THEN mvto.mopreciopunta        
                                END        
      ,   ParidadCierre       = CASE WHEN mvto.mocodpos1 = 1  THEN mvto.moparmon1        
                                     WHEN mvto.mocodpos1 = 2  THEN mvto.motipcam         
                                     WHEN mvto.mocodpos1 = 3  THEN 0.0        
                                     WHEN mvto.mocodpos1 = 13 THEN 0.0        
                                END         
      ,   ParidadCosto        = CASE WHEN mvto.mocodpos1 = 1  THEN mvto.moparmon2        
                                     WHEN mvto.mocodpos1 = 2  THEN mvto.moparmon1        
                                     WHEN mvto.mocodpos1 = 3  THEN 0.0        
                                     WHEN mvto.mocodpos1 = 13 THEN 0.0        
                                END        
      ,   MontoPesos          = mvto.moequmon1        
      ,   Operador            = mvto.mooperador        
      ,   MontoDolares        = CASE mvto.mocodpos1 WHEN 2 THEN mvto.momtomon2 ELSE mvto.moequusd1 END        
      ,   ResultadoMesa       = CASE WHEN mvto.mocodpos1 = 2 THEN ROUND(mvto.Resultado_Mesa * vcont.tipo_cambio, 0)       
                                     ELSE                         mvto.Resultado_Mesa      
                                END        
      ,   Fecha      = mvto.mofecha  --> CONVERT(CHAR(10), mvto.mofecha, 103)        
      ,   Relacionado         = CASE WHEN var_moneda2  <> 0 THEN 'Operacion Relacionada MX/CLP' ELSE '--' END      
      ,   FolioRelacionado    = 0        
  FROM    BacFwdSuda.dbo.MFMO                  mvto        
          INNER JOIN bacfwdsuda.dbo.mfca       cart ON cart.canumoper=mvto.monumoper      
          INNER JOIN BacFwdSuda.dbo.MFAC       ctro ON ctro.acfecproc  = mvto.mofecha        
          INNER JOIN BacParamSuda.dbo.CLIENTE  clie ON clie.clrut      = mvto.mocodigo AND clie.clcodigo        = mvto.mocodcli        
          INNER JOIN BacParamSuda.dbo.PRODUCTO prod ON prod.id_sistema = 'BFW'         AND prod.codigo_producto = mvto.mocodpos1        
          LEFT  JOIN BacParamSuda.dbo.MONEDA   mon1 ON mon1.mncodmon   = mvto.mocodmon1        
          LEFT  JOIN BacParamSuda.dbo.MONEDA   mon2 ON mon2.mncodmon   = mvto.mocodmon2        
          LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vcont ON vcont.fecha         = ctro.acfecante         
                                                                 and vcont.codigo_moneda = 994        
   WHERE  mvto.moestado     <> 'A'        
     AND  mvto.mofecha       BETWEEN @FechaDesde AND @Fechahasta        
        
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
      ,   TCCierre            = CASE WHEN mvto.mocodpos1 = 1  THEN mvto.motipcam         
                                     WHEN mvto.mocodpos1 = 2  THEN mvto.mopremon1        
                                     WHEN mvto.mocodpos1 = 3  THEN mvto.motipcam      
                                     WHEN mvto.mocodpos1 = 13 THEN mvto.motipcam      
                                END        
      , TCCosto               = CASE WHEN mvto.mocodpos1 = 1  THEN mvto.mopreciopunta        
                                     WHEN mvto.mocodpos1 = 2  THEN mvto.mopremon2        
                                     WHEN mvto.mocodpos1 = 3  THEN mvto.mopreciopunta        
                                     WHEN mvto.mocodpos1 = 13 THEN mvto.mopreciopunta        
                                END        
      ,   ParidadCierre       = CASE WHEN mvto.mocodpos1 = 1  THEN mvto.moparmon1        
                                     WHEN mvto.mocodpos1 = 2  THEN mvto.motipcam         
                                     WHEN mvto.mocodpos1 = 3  THEN 0.0        
                                     WHEN mvto.mocodpos1 = 13 THEN 0.0        
                                END         
      ,   ParidadCosto        = CASE WHEN mvto.mocodpos1 = 1  THEN mvto.moparmon2        
                                     WHEN mvto.mocodpos1 = 2  THEN mvto.moparmon1        
                                     WHEN mvto.mocodpos1 = 3  THEN 0.0        
                                     WHEN mvto.mocodpos1 = 13 THEN 0.0        
                                END        
      ,   MontoPesos          = mvto.moequmon1        
      ,   Operador            = mvto.mooperador        
      ,   MontoDolares        = CASE mvto.mocodpos1 WHEN 2 THEN MVTO.momtomon2 ELSE mvto.moequusd1 END        
      ,   ResultadoMesa       = CASE WHEN mvto.mocodpos1 = 2 THEN ROUND(mvto.Resultado_Mesa * vcont.tipo_cambio, 0)      
                                     ELSE                         mvto.Resultado_Mesa      
                                END        
      ,   Fecha               = mvto.mofecha --> CONVERT(CHAR(10), mvto.mofecha, 103)        
      ,   Relacionado         = CASE WHEN var_moneda2  <> 0 THEN 'Operacion Relacionada MX/CLP' ELSE '--' END      
      ,   FolioRelacionado    = 0        
     FROM BacFwdSuda.dbo.MFMOH                 mvto        
          INNER JOIN bacfwdsuda.dbo.mfca       cart ON cart.canumoper  = mvto.monumoper      
          INNER JOIN BacFwdSuda.dbo.MFACH      ctro ON ctro.acfecproc  = mvto.mofecha        
          INNER JOIN BacParamSuda.dbo.CLIENTE  clie ON clie.clrut      = mvto.mocodigo AND clie.clcodigo        = mvto.mocodcli        
          INNER JOIN BacParamSuda.dbo.PRODUCTO prod ON prod.id_sistema = 'BFW'         AND prod.codigo_producto = mvto.mocodpos1        
          LEFT  JOIN BacParamSuda.dbo.MONEDA   mon1 ON mon1.mncodmon   = mvto.mocodmon1        
          LEFT  JOIN BacParamSuda.dbo.MONEDA   mon2 ON mon2.mncodmon   = mvto.mocodmon2        
          LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vcont ON vcont.fecha         = ctro.acfecante         
                                                                 and vcont.codigo_moneda = 994        
   WHERE  mvto.moestado     <> 'A'        
     AND  mvto.mofecha       BETWEEN @FechaDesde AND @Fechahasta        
        
        
   INSERT INTO #RESULTADOS_MESA        
   SELECT Modulo           = 'PCS'        
      ,   Producto         = CASE WHEN mvto.tipo_swap = 1 THEN 'SWAP DE TASAS'        
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
    FROM  BacSwapSuda.dbo.MOVHISTORICO            mvto        
          INNER JOIN BacSwapSuda.dbo.MOVHISTORICO vent ON vent.numero_operacion = mvto.numero_operacion         
                                                      and vent.numero_flujo = mvto.numero_flujo        
                                                      and vent.tipo_flujo       = 2        
          INNER JOIN BacParamSuda.dbo.CLIENTE     clie ON clie.clrut = mvto.rut_cliente and clie.clcodigo = mvto.codigo_cliente         
          LEFT  JOIN BacParamSuda.dbo.MONEDA      mon1 ON mon1.mncodmon = mvto.compra_moneda        
          LEFT  JOIN BacParamSuda.dbo.MONEDA      mon2 ON mon2.mncodmon = vent.venta_moneda        
   WHERE  mvto.estado           <> 'C'        
     AND  mvto.fecha_cierre     BETWEEN @FechaDesde AND @Fechahasta        
     AND  mvto.tipo_flujo       = 1        
     AND  mvto.numero_flujo     = (SELECT MIN( ctlf.numero_flujo ) FROM BacSwapSuda.dbo.MOVHISTORICO ctlf         
                                    WHERE ctlf.fecha_cierre      BETWEEN @FechaDesde AND @Fechahasta        
                                      AND ctlf.numero_operacion  = mvto.numero_operacion         
                                      AND ctlf.tipo_flujo        = 1)        
        
        
   INSERT INTO #RESULTADOS_MESA        
   SELECT Modulo           = 'PCS'        
      ,   Producto         = CASE WHEN mvto.tipo_swap = 1 THEN 'SWAP DE TASAS'        
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
    FROM  BacSwapSuda.dbo.MOVDIARIO     mvto        
          INNER JOIN BacSwapSuda.dbo.MOVDIARIO    vent ON vent.numero_operacion = mvto.numero_operacion         
                                                      and vent.numero_flujo     = mvto.numero_flujo        
                                                      and vent.tipo_flujo = 2        
     INNER JOIN BacParamSuda.dbo.CLIENTE     clie ON clie.clrut = mvto.rut_cliente and clie.clcodigo = mvto.codigo_cliente         
          LEFT  JOIN BacParamSuda.dbo.MONEDA      mon1 ON mon1.mncodmon = mvto.compra_moneda        
          LEFT  JOIN BacParamSuda.dbo.MONEDA      mon2 ON mon2.mncodmon = vent.venta_moneda        
   WHERE  mvto.estado           <> 'C'        
     AND  mvto.fecha_cierre     BETWEEN @FechaDesde AND @Fechahasta        
     AND  mvto.tipo_flujo       = 1        
     AND  mvto.numero_flujo     = (SELECT MIN( ctlf.numero_flujo ) FROM BacSwapSuda.dbo.MOVDIARIO ctlf         
                                    WHERE --   ctlf.fecha_cierre = @FechaMovimiento         
                                          ctlf.fecha_cierre      BETWEEN @FechaDesde AND @Fechahasta        
                                      AND ctlf.numero_operacion  = mvto.numero_operacion         
                                      AND ctlf.tipo_flujo        = 1)        
        
   -->    ---PCS--   <--        
   -->    ANTICIPOS  <--        
   -->    ---PCS--   <--        
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
      ,   TCCosto          = 0.0 --> his.Tasa_Transfer        
      ,   ParidadCierre    = vta.venta_valor_tasa        
      ,   ParidadCosto     = 0.0 --> vta.Tasa_Transfer         
      ,   MontoPesos       = vta.venta_capital        
      ,   Operador         = his.operador        
      ,   MontoDolares     = 0        
      ,   ResultadoMesa    = unw.ResMesa --> his.Res_Mesa_Dist_CLP         
      ,   Fecha     = his.fecha_cierre    --> CONVERT(CHAR(10), mvto.fecha_cierre, 103)        
      ,   Relacionado      = '--'        
      ,   FolioRelacionado = 0        
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
        
        
--> *******************************OPCIONES*************************    
    
  SELECT * into #AnuladasyAnticipadas from  LNKOPC.CbMdbOpc.dbo.MoHisEncContrato      
     where  moTipoTransaccion = 'ANULA' or moTipoTransaccion = 'ANTICIPA'      
     AND MoFechaContrato >= @FechaDesde       
     AND MoFechaContrato <= @FechaHasta      
     
  SELECT * into #AnuladasyAnticipadasII from  LNKOPC.CbMdbOpc.dbo.MoEncContrato    
     where  moTipoTransaccion = 'ANULA' or moTipoTransaccion = 'ANTICIPA'    
     AND MoFechaContrato >= @FechaDesde     
     AND MoFechaContrato <= @FechaHasta    
  
  
  
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
 FROM LNKOPC.CbMdbOpc.dbo.MoHisEncContrato   mvto      
            INNER JOIN BacParamSuda.dbo.CLIENTE    clie ON clie.clrut  = mvto.MoRutCliente and clie.clcodigo = mvto.MoCodigo      
            INNER JOIN LNKOPC.CbMdbOpc.dbo.MoHisDetContrato ctro ON mvto.MoNumFolio = ctro.MoNumFolio and ctro.MoNumEstructura=1      
   LEFT  JOIN BacParamSuda.dbo.MONEDA    mon1 ON mon1.mncodmon   = ctro.MoCodMon1      
   LEFT  JOIN BacParamSuda.dbo.MONEDA    mon2 ON mon2.mncodmon   = ctro.MoCodMon2     
 WHERE mvto.MoFechaContrato between @FechaDesde  and @FechaHasta    
 AND  mvto.MoResultadoVentasML <> 0    
 AND  mvto.MoNumContrato not in ( select MoNumcontrato from #AnuladasyAnticipadas )       
 and  mvto.moestado <> 'C'  
  
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
        FROM            LNKOPC.CbMdbOpc.dbo.MoEncContrato            mvto    
                        INNER JOIN LNKOPC.CbMdbOpc.dbo.MoDetContrato ctro ON ctro.MoNumFolio = mvto.MoNumFolio and ctro.MoNumEstructura=1    
                        INNER JOIN BacParamSuda.dbo.CLIENTE      clie ON clie.clrut      = mvto.MoRutCliente and clie.clcodigo = mvto.MoCodigo    
   LEFT  JOIN BacParamSuda.dbo.MONEDA      mon1 ON mon1.mncodmon   = ctro.MoCodMon1    
   LEFT  JOIN BacParamSuda.dbo.MONEDA      mon2 ON mon2.mncodmon   = ctro.MoCodMon2   
 WHERE         mvto.MoFechaContrato between @FechaDesde  and @FechaHasta  
 AND  mvto.MoResultadoVentasML <> 0  
 AND             mvto.MoNumContrato       not in ( select MoNumcontrato from #AnuladasyAnticipadasII )     
        AND             mvto.MoEstado            <> 'C'  
  
     DROP TABLE #AnuladasyAnticipadas      
    
--> -------------    
      
   -->    ---BFW---    <--======================================================================================================        
   -->    ANTICIPOS    <--======================================================================================================        
   -->    ---BFW---    <--======================================================================================================        
   SELECT canumoper, cacodpos1,  catipoper, catipmoda, cacodigo,  cacodcli, cacodmon1, cacodmon2        
      ,   camtomon1, caequmon1, caequusd1, capremon1, capremon2, capreant, caspread,   camtomon2        
      ,   cafecha,   cafecvcto, caestado,  caantici,  caoperador        
      ,   precio_spot, caantptosfwd, caantptoscos        
     INTO #TMP_CARTERA_ANTICIPO_FORWARD        
     FROM BacFwdsuda.dbo.MFCA   unw with(nolock)        
    WHERE unw.cafecvcto BETWEEN @FechaDesde and @Fechahasta        
      and unw.caestado  <> 'A'        
      and unw.caantici   = 'A'        
        
   INSERT INTO #TMP_CARTERA_ANTICIPO_FORWARD        
   SELECT canumoper, cacodpos1, catipoper, catipmoda, cacodigo,  cacodcli, cacodmon1, cacodmon2        
      ,   camtomon1, caequmon1, caequusd1, capremon1, capremon2, capreant, caspread,  camtomon2        
      ,   cafecha,   cafecvcto, caestado,  caantici,  caoperador        
      ,   precio_spot, caantptosfwd = 0.0, caantptoscos = 0.0        
     FROM BacFwdsuda.dbo.MFCAH  unw with(nolock)        
    WHERE unw.cafecvcto BETWEEN @FechaDesde and @Fechahasta        
      and unw.caestado  <> 'A'        
      and unw.caantici   = 'A'        
      and unw.canumoper  NOT IN(SELECT canumoper FROM #TMP_CARTERA_ANTICIPO_FORWARD)        
        
   UPDATE #RESULTADOS_MESA        
      SET Monto                             = Monto        - cant.camtomon1        
      ,   MontoPesos                        = MontoPesos   - cant.caequmon1        
      ,   MontoDolares                      = MontoDolares - CASE WHEN cant.cacodpos1 = 2 and cant.camtomon1 <> 13 THEN cant.camtomon2 ELSE cant.caequusd1 END        
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
      ,   TCCierre            = CASE WHEN unw.cacodpos1 = 2  THEN unw.capremon1    ELSE unw.precio_spot  + unw.caantptosfwd       END        
      ,   TCCosto             = CASE WHEN unw.cacodpos1 = 2  THEN unw.capremon2    ELSE unw.capreant     + unw.caantptoscos       END        
      ,   ParidadCierre       = CASE WHEN unw.cacodpos1 = 2  THEN unw.precio_spot  +    unw.caantptosfwd / mn1.mnfactor  ELSE 1.0 END        
      ,   ParidadCosto        = CASE WHEN unw.cacodpos1 = 2  THEN unw.capreant     +    unw.caantptoscos / mn1.mnfactor  ELSE 1.0 END        
      ,   MontoPesos          = unw.caequmon1 --> 0.0 --> unw.caequmon1        
      ,   Operador            = unw.caoperador        
      ,   MontoDolares        = CASE WHEN unw.cacodpos1 = 2 and unw.camtomon1 <> 13 THEN unw.camtomon2 ELSE unw.caequusd1 END --> 0.0 --> CASE WHEN unw.cacodpos1 = 2 and unw.camtomon1 <> 13 THEN unw.camtomon2 ELSE unw.caequusd1 END     
      ,   ResultadoMesa       = unw.caspread        
      ,   Fecha        = unw.cafecvcto        
      ,   Relacionado         = '--'        
      ,   FolioRelacionado    = 0         
   FROM   #TMP_CARTERA_ANTICIPO_FORWARD       unw        
          LEFT JOIN BacParamSuda.dbo.PRODUCTO pro with(nolock) ON pro.id_sistema = 'BFW' AND pro.codigo_producto = unw.cacodpos1        
          LEFT JOIN BacParamSuda.dbo.CLIENTE  cli with(nolock) ON cli.clrut      = unw.cacodigo and cli.clcodigo = unw.cacodcli        
          LEFT JOIN BacParamSuda.dbo.MONEDA   mn1 with(nolock) ON mn1.mncodmon   = unw.cacodmon1        
          LEFT JOIN BacParamSuda.dbo.MONEDA   mn2 with(nolock) ON mn2.mncodmon   = unw.cacodmon2        
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
   INTO   #TMP_RETORNO_ORDENADO    
   FROM   #RESULTADOS_MESA    
          INNER JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE tgd ON tgd.tbcateg = CASE WHEN @MedaDistibucion = 1 THEN 9000    
                                                                                      WHEN @MedaDistibucion = 2 THEN 9001    
                                                                                      ELSE 9000 END    
                                                               and tgd.tbglosa = operador      
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
   FROM   #RESULTADOS_MESA    
   WHERE  Modulo = 'OPT'    
  
   --> Para Institucionales se Eliminan las Opciones.  
   IF @MedaDistibucion = 2  
   BEGIN  
      DELETE FROM #TMP_RETORNO_ORDENADO   
            WHERE Modulo = 'OPT'  
   END  
  
  
   SELECT Modulo    
      ,   Producto        
      ,   Numero_Operacion        
      ,   'Relacionado' = Relacionado    
      ,   'Folio Ref.'  = Correlativo    
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
     FROM #TMP_RETORNO_ORDENADO    
 ORDER BY fecha, Modulo, Producto,  RutCliente, CodCliente, Numero_Operacion, Documento, Correlativo         
*/


	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo              = 'BTR'        
		,   Producto            = CASE	WHEN Movto.motipoper = 'CP' THEN 'COMPRA PROPIA'
										WHEN Movto.motipoper = 'CI' THEN 'COMPRA C/ PACTO'
										WHEN Movto.motipoper = 'VP' THEN 'VENTA PROPIA'
										WHEN Movto.motipoper = 'VI' THEN 'VENTA C/ PACTO'
										WHEN Movto.motipoper = 'IB' THEN 'INTERBANCARIO'
									END
		,   Numero_Operacion    = Movto.monumoper
		,   Numero_Documento    = Movto.monumdocu
		,   Numero_Correlativo  = Movto.mocorrela
		,   Serie               = Movto.moinstser
		,   RutCliente          = clie.clrut
		,   CodCliente          = clie.clcodigo
		,   DvCliente           = clie.cldv
		,   NombreCliente       = clie.clnombre
		,   TipoOperacion       = CASE	WHEN Movto.motipoper = 'CP' THEN 'C'
										WHEN Movto.motipoper = 'CI' THEN 'C'
										WHEN Movto.motipoper = 'VP' THEN 'V'
										WHEN Movto.motipoper = 'VI' THEN 'V'
										WHEN Movto.motipoper = 'IB' THEN Movto.moinstser
									END
		,   Monto               = Movto.movpresen
		,   MonTransada         = Mone.mnnemo
		,   MonConversion       = Mone.mnnemo
		,   TCCierre            = Movto.motir
		,   TCCosto             = Movto.moTirTran
		,   ParidadCierre       = 0.0
		,   ParidadCosto        = 0.0
		,   MontoPesos          = CASE WHEN Movto.motipoper in('VI', 'VP') THEN Movto.movalven ELSE Movto.movpresen END
		,   Operador            = Movto.mousuario
		,   MontoDolares        = 0.0
		,   ResultadoMesa       = Movto.moDifTran_CLP
		,   Fecha				= Movto.mofecpro
		,   Relacionado         = '--'
		,   FolioRelacionado    = 0
	FROM	(	select	mofecpro,  motipoper, monumoper, monumdocu,		mocorrela,	moinstser,	movpresen, motir
					,	moTirTran, movalven,  mousuario, moDifTran_CLP, morutcli,	mocodcli,	momonemi
				from	BacTraderSuda.dbo.MDMO	with(nolock)
				where	mofecpro   BETWEEN @FechaDesde AND @Fechahasta
				and		motipoper  IN('CP', 'CI', 'VP', 'VI', 'IB')
				and		mostatreg  <> 'A'

				union

				select	mofecpro,  motipoper, monumoper, monumdocu,		mocorrela,	moinstser,	movpresen, motir
					,	moTirTran, movalven,  mousuario, moDifTran_CLP, morutcli,	mocodcli,	momonemi
				from	BacTraderSuda.dbo.MDMH	with(nolock)
				where	mofecpro   BETWEEN @FechaDesde AND @Fechahasta
				and		motipoper  IN('CP', 'CI', 'VP', 'VI', 'IB')
				and		mostatreg  <> 'A'
			)	Movto
			inner join  ( select clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
							from BacParamSuda.dbo.cliente with(nolock)
						) Clie	On	Clie.clrut		= Movto.morutcli 
								and Clie.clcodigo	= Movto.mocodcli        

			inner join	( select mncodmon, mnnemo = ltrim(rtrim( mnnemo ))
							from BacParamSuda.dbo.Moneda
						) Mone On Mone.mncodmon = Movto.momonemi


	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo              = 'BCC'        
		,   Producto            = Spot.motipmer
		,   Numero_Operacion    = Spot.monumope
		,   Numero_Documento    = 0        
		,   Numero_Correlativo  = 0        
		,   Serie               = ''        
		,   RutCliente          = clie.clrut
		,   CodCliente          = clie.clcodigo
		,   DvCliente           = clie.cldv
		,   NombreCliente       = clie.clnombre
		,   TipoOperacion       = Spot.motipope
		,   Monto               = Spot.momonmo
		,   MonTransada         = Spot.mocodmon
		,   MonConversion       = Spot.mocodcnv
		,   TCCierre            = Spot.moticam
		,   TCCosto             = CASE	WHEN Spot.moterm = 'COMEX' AND Spot.mocodmon  = 'USD' THEN Spot.CMX_TC_Costo_Trad
										WHEN Spot.moterm = 'COMEX' AND Spot.mocodmon <> 'USD' THEN Spot.motctra
										ELSE Spot.motctra
									END
		,   ParidadCierre       = Spot.moparme
		,   ParidadCosto        = CASE	WHEN Spot.moterm = 'COMEX' AND Spot.mocodmon  = 'USD' THEN Spot.mopartr
										WHEN Spot.moterm = 'COMEX' AND Spot.mocodmon <> 'USD' THEN Spot.CMX_TC_Costo_Trad
										ELSE Spot.mopartr  
									END
		,   MontoPesos          = Spot.momonpe
		,   Operador            = Spot.mooper
		,   MontoDolares        = Spot.moussme
		,   ResultadoMesa       = CASE WHEN Spot.moterm = 'COMEX' THEN Spot.moResultado_Comercial_Clp ELSE Spot.moDifTran_Clp END
		,   Fecha               = Spot.mofech
		,   Relacionado         = CASE	WHEN Spot.monumfut > 0 AND Spot.moterm = 'SWAP SPOT'								THEN 'Swap Spot'
										WHEN Spot.monumfut > 0 AND Spot.moterm = 'EMPRESAS' AND Spot.morutcli = 96665450	THEN 'Neteo'
										ELSE																					 'Sin Relación'         
									END
		,	FolioRelacionado    = CASE	WHEN Spot.monumfut > 0 AND Spot.moterm = 'SWAP SPOT'								THEN Spot.monumfut
										WHEN Spot.monumfut > 0 AND Spot.moterm = 'EMPRESAS' AND Spot.morutcli = 96665450	THEN Spot.monumfut
										ELSE																					 0
									END
	FROM	(	select	monumope, motipmer, motipope, mocodmon, mocodcnv, moterm, momonmo, moussme, moticam, motctra, moparme, mopartr, momonpe
					,	cmx_tc_costo_trad, moresultado_comercial_clp, modiftran_clp
					,	morutcli, mocodcli, mooper, monumfut, mofech
				from	BacCamSuda.dbo.Memo		with(nolock)
				where	mofech		BETWEEN @FechaDesde and @Fechahasta
				and		moestatus	<> 'A' 
				and		moterm		NOT IN('FORWARD', 'SWAP', 'OPCIONES', 'DATATEC', 'BOLSA')

				union

				select	monumope, motipmer, motipope, mocodmon, mocodcnv, moterm, momonmo, moussme, moticam, motctra, moparme, mopartr, momonpe
					,	cmx_tc_costo_trad, moresultado_comercial_clp, modiftran_clp
					,	morutcli, mocodcli, mooper, monumfut, mofech
				from	BacCamSuda.dbo.Memoh	with(nolock)
				where	mofech		BETWEEN @FechaDesde and @Fechahasta
				and		moestatus	<> 'A' 
				and		moterm		NOT IN('FORWARD', 'SWAP', 'OPCIONES', 'DATATEC', 'BOLSA')
			)	Spot

			inner join  ( select clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
							from BacParamSuda.dbo.cliente with(nolock)
						) Clie	On	Clie.clrut		= Spot.morutcli
								and Clie.clcodigo	= Spot.mocodcli


	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo              = 'BFW'
		,	Producto            = prod.descripcion
		,   Numero_Operacion    = Forward.monumoper
		,   Numero_Documento    = 0
		,   Numero_Correlativo  = Forward.motipcamSpot
		,   Serie               = ''
		,   RutCliente          = clie.clrut
		,   CodCliente          = clie.clcodigo
		,   DvCliente           = clie.cldv
		,   NombreCliente       = clie.clnombre
		,   TipoOperacion       = Forward.motipoper
		,   Monto               = Forward.momtomon1
		,   MonTransada         = mon1.mnnemo
		,   MonConversion       = mon2.mnnemo
		,   TCCierre            = CASE	WHEN Forward.mocodpos1 = 1  THEN Forward.motipcam
										WHEN Forward.mocodpos1 = 2  THEN Forward.mopremon1
										WHEN Forward.mocodpos1 = 3  THEN Forward.motipcam
										WHEN Forward.mocodpos1 = 13 THEN Forward.motipcam
									END
		,   TCCosto             = CASE	WHEN Forward.mocodpos1 = 1  THEN Forward.mopreciopunta        
										WHEN Forward.mocodpos1 = 2  THEN Forward.mopremon2        
										WHEN Forward.mocodpos1 = 3  THEN Forward.mopreciopunta        
										WHEN Forward.mocodpos1 = 13 THEN Forward.mopreciopunta        
									END
		,   ParidadCierre       = CASE	WHEN Forward.mocodpos1 = 1  THEN Forward.moparmon1
										WHEN Forward.mocodpos1 = 2  THEN Forward.motipcam
										WHEN Forward.mocodpos1 = 3  THEN 0.0
										WHEN Forward.mocodpos1 = 13 THEN 0.0
									END
		,   ParidadCosto        = CASE	WHEN Forward.mocodpos1 = 1  THEN Forward.moparmon2
										WHEN Forward.mocodpos1 = 2  THEN Forward.moparmon1
										WHEN Forward.mocodpos1 = 3  THEN 0.0
										WHEN Forward.mocodpos1 = 13 THEN 0.0
									END
		,   MontoPesos          = Forward.moequmon1
		,   Operador            = Forward.mooperador
		,   MontoDolares        = CASE Forward.mocodpos1 WHEN 2 THEN Forward.momtomon2 ELSE Forward.moequusd1 END
		,   ResultadoMesa       = CASE	WHEN Forward.mocodpos1 = 2 THEN ROUND(Forward.Resultado_Mesa * Forward.tipo_cambio, 0)
										ELSE							Forward.Resultado_Mesa
									END
		,   Fecha               = Forward.mofecha
		,   Relacionado         = CASE WHEN Cartera.var_moneda2  <> 0 THEN 'Operacion Relacionada MX/CLP' ELSE '--' END
		,   FolioRelacionado    = 0
	FROM	(	select	mofecha,  mocodpos1, monumoper, motipoper, mooperador, momtomon1, momtomon2, moequusd1, moequmon1, motipcamSpot
					,	motipcam, mopremon1, mopremon2, moparmon1, moparmon2, mopreciopunta, mocodmon1, mocodmon2
					,	mocodigo, mocodcli, Resultado_Mesa, Tipo_Cambio = vcont.tipo_cambio
				from	BacFwdSuda.dbo.Mfmo		with(nolock)
						inner join BacFwdSuda.dbo.Mfac					  ctro	On	ctro.acfecproc		= mofecha
						left  join BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vcont	On	vcont.fecha			= ctro.acfecante
																				and	vcont.codigo_moneda = 994
				where	mofecha			between @FechaDesde and @Fechahasta
				and		moestado		<> 'A'

				union 

				select	mofecha,  mocodpos1, monumoper, motipoper, mooperador, momtomon1, momtomon2, moequusd1, moequmon1, motipcamSpot
					,	motipcam, mopremon1, mopremon2, moparmon1, moparmon2, mopreciopunta, mocodmon1, mocodmon2
					,	mocodigo, mocodcli, Resultado_Mesa, Tipo_Cambio = vcont.tipo_cambio
				from	BacFwdSuda.dbo.MfmoH	with(nolock)
						inner join BacFwdSuda.dbo.MFACH					  ctro	On	ctro.acfecproc		= mofecha
						left  join BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vcont On	vcont.fecha			= ctro.acfecante         
																				and vcont.codigo_moneda = 994

				where	mofecha			between @FechaDesde and @Fechahasta
				and		moestado		<> 'A'
			)	Forward

			inner join ( select canumoper, var_moneda2
						 from	BacFwdSuda.dbo.Mfca	with(nolock)
					   ) Cartera ON Cartera.canumoper  = Forward.monumoper      

			inner join ( select clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
						 from	BacParamSuda.dbo.cliente with(nolock)
						) Clie	On	Clie.clrut		= Forward.mocodigo
								and Clie.clcodigo	= Forward.mocodcli

			inner join	( select codigo_producto, descripcion from BacParamSuda.dbo.Producto with(nolock)
							where Id_Sistema = 'BFW'
						) Prod On Prod.codigo_producto = Forward.mocodpos1

			left  join ( select mncodmon, mnnemo from BacParamSuda.dbo.Moneda ) mon1 ON mon1.mncodmon = Forward.mocodmon1        
            left  join ( select mncodmon, mnnemo from BacParamSuda.dbo.Moneda ) mon2 ON mon2.mncodmon = Forward.mocodmon2        



	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo				= 'PCS'        
		,   Producto			= CASE	WHEN Swap.tipo_swap = 1 THEN 'SWAP DE TASAS'        
										WHEN Swap.tipo_swap = 2 THEN 'SWAP DE MONEDAS'        
										WHEN Swap.tipo_swap = 3 THEN 'FORWARD RATE AGREETMEN'        
										WHEN Swap.tipo_swap = 4 THEN 'SWAP PROMEDIO CAMARA'        
									END
		,   Numero_Operacion	= Swap.numero_operacion        
		,   Documento			= 0        
		,   Correlativo			= 0        
		,   Serie				= ''        
		,   RutCliente			= clie.clrut        
		,   CodCliente			= clie.clcodigo        
		,   DvCliente			= clie.cldv        
		,   NombreCliente		= clie.clnombre        
		,   TipoOperacion		= 'C'        
		,   Monto				= Swap.compra_capital        
		,   MonTransada			= Swap.compra_moneda
		,   MonConversion		= Swap.venta_moneda
		,   TCCierre			= Swap.compra_valor_tasa        
		,   TCCosto				= Swap.Tasa_Transfer        
		,   ParidadCierre		= Swap.venta_valor_tasa        
		,   ParidadCosto		= Swap.Tasa_Transfer        
		,   MontoPesos			= Swap.venta_capital        
		,   Operador			= Swap.operador        
		,   MontoDolares		= 0        
		,   ResultadoMesa		= Swap.Res_Mesa_Dist_CLP         
		,   Fecha				= Swap.fecha_cierre
		,   Relacionado			= '--'        
		,   FolioRelacionado	= 0        
	from	(	select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa, Compra.Tasa_Transfer
				,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador,		Compra.Res_Mesa_Dist_CLP, Compra.fecha_cierre
				,		Venta_Moneda	= Venta.Venta_Moneda
				,		Compra_Moneda	= Mon.mnnemo
				,		compra.Rut_Cliente, compra.codigo_cliente
				from	BacSwapSuda.dbo.MovDiario	Compra	with(nolock)
						inner join (	select	Contrato = numero_operacion, Flujo = Min( numero_flujo )
										from	BacSwapSuda.dbo.MovDiario	with(nolock)
										where	fecha_cierre BETWEEN @FechaDesde AND @Fechahasta
										and		Estado <> 'C' and tipo_flujo = 1
										group by numero_operacion
									)	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
												and	GrpSwap.Flujo		= Compra.numero_flujo

						inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo
										from	BacSwapSuda.dbo.MovDiario	with(nolock)
												inner join (	select	mncodmon, mnnemo 
																from	BacParamSuda.dbo.Moneda with(nolock)
															)	Mon On	Mon.mncodmon	= Venta_Moneda
										where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
										and		Estado			<> 'C'
										and		tipo_flujo		= 2
									)	Venta	On	Venta.numero_operacion	= Compra.numero_operacion
												and	Venta.numero_flujo		= Compra.numero_flujo
						inner join (	select	mncodmon, mnnemo
										from	BacParamSuda.dbo.Moneda with(nolock)
									)	Mon On	Mon.mncodmon	= Compra.compra_Moneda
				where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
				and		Estado			<> 'C'
				and		tipo_flujo		= 1

				union

				select	Compra.numero_operacion, Compra.tipo_swap,		Compra.compra_capital,	Compra.compra_valor_tasa, Compra.Tasa_Transfer
				,		Venta.venta_valor_tasa,  Venta.venta_capital,	Compra.operador,		Compra.Res_Mesa_Dist_CLP, Compra.fecha_cierre
				,		Venta_Moneda	= Venta.Venta_Moneda
				,		Compra_Moneda	= Mon.mnnemo
				,		compra.Rut_Cliente, compra.codigo_cliente
				from	BacSwapSuda.dbo.MovHistorico	Compra	with(nolock)
						inner join (	select	Contrato = numero_operacion, Flujo = Min( numero_flujo )
										from	BacSwapSuda.dbo.MovHistorico	with(nolock)
										where	fecha_cierre BETWEEN @FechaDesde AND @Fechahasta
										and		Estado <> 'C' and tipo_flujo = 1
										group by numero_operacion
									)	GrpSwap	On	GrpSwap.Contrato	= Compra.numero_operacion
												and	GrpSwap.Flujo		= Compra.numero_flujo

						inner join	(	select  numero_operacion, numero_flujo, venta_capital, venta_valor_tasa, Venta_Moneda = Mon.mnnemo
										from	BacSwapSuda.dbo.MovHistorico	with(nolock)
												inner join (	select	mncodmon, mnnemo 
																from	BacParamSuda.dbo.Moneda with(nolock)
															)	Mon On	Mon.mncodmon	= Venta_Moneda
										where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
										and		Estado			<> 'C'
										and		tipo_flujo		= 2
									)	Venta	On	Venta.numero_operacion	= Compra.numero_operacion
												and	Venta.numero_flujo		= Compra.numero_flujo
						inner join (	select	mncodmon, mnnemo
										from	BacParamSuda.dbo.Moneda with(nolock)
									)	Mon On	Mon.mncodmon	= Compra.compra_Moneda
				where	fecha_cierre	BETWEEN @FechaDesde AND @Fechahasta
				and		Estado			<> 'C'
				and		tipo_flujo		= 1
			)	Swap

			inner join ( select clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
						 from	BacParamSuda.dbo.cliente with(nolock)
						) Clie	On	Clie.clrut		= Swap.Rut_Cliente
								and Clie.clcodigo	= Swap.codigo_cliente


   -->    ---PCS--   <--
   -->    ANTICIPOS  <--
   -->    ---PCS--   <--
	INSERT INTO #RESULTADOS_MESA
	select	Modulo				= 'PCS'
	,		Producto			= 'ANT ' + Prod.Glosa
	,		Numero_Operacion	= his.numero_operacion
	,		Documento			= 0
	,		Correlativo			= 0
	,		Serie				= ''
	,		RutCliente			= clie.Rut
	,		CodCliente			= clie.Codigo
	,		DvCliente			= clie.Dv
	,		NombreCliente		= clie.Nombre
	,		TipoOperacion		= 'C'
	,		Monto				= his.compra_capital
	,		MonTransada			= mon1.mnnemo
	,		MonConversion		= mon2.mnnemo
	,		TCCierre			= his.compra_valor_tasa
	,		TCCosto				= 0.0
	,		ParidadCierre		= venta.venta_valor_tasa
	,		ParidadCosto		= 0.0
	,		MontoPesos			= venta.venta_capital
	,		Operador			= Anticipo.operador			--> his.operador
	,		MontoDolares		= His.compra_capital
	,		ResultadoMesa		= Anticipo.Monto
	,		Fecha				= his.fecha_cierre
	,		Relacionado			= '--'
	,		FolioRelacionado	= 0
	from	BacSwapSuda.dbo.CarteraHis His	with(nolock)
			inner join (	select	numero_operacion, numero_flujo, tipo_flujo, venta_capital, venta_valor_tasa, venta_moneda
							from	BacSwapSuda.dbo.CarteraHis	with(nolock)
						)	Venta	On	Venta.numero_operacion = His.numero_operacion
									and	Venta.numero_flujo     = His.numero_flujo
									and	Venta.tipo_flujo       = 2

			inner join (	select		Contrato		= Numero_Operacion
							,			Flujo			= Min( Numero_Flujo ) - 1
							,			Tipo			= Tipo_Flujo
							,			Monto			= Min( Devengo_Recibido_Mda_Val )
							,			operador		= Min( operador )
							from		BacSwapSuda.dbo.Cartera_Unwind	with(nolock)
							where		FechaAnticipo	BETWEEN @FechaDesde AND @Fechahasta
							and			Tipo_Flujo		= 1
							group by	Numero_Operacion, Tipo_Flujo
						)	Anticipo	On	Anticipo.Contrato	= His.Numero_Operacion
										and	Anticipo.Flujo		= His.Numero_Flujo
										and	Anticipo.Tipo		= His.Tipo_Flujo

			inner join	(	select Producto		=	Case	when codigo_producto = 'ST' then 1
															when codigo_producto = 'SM' then 2
															when codigo_producto = 'FR' then 3
															when codigo_producto = 'SP' then 4
													end
							,		Glosa		=	Descripcion
							from	BacParamSuda.dbo.Producto	with(nolock)
							where	Id_Sistema	= 'PCS'
						)	Prod	On Prod.Producto = His.tipo_swap

			inner join  (	select	Rut			= clrut
								,	Codigo		= clcodigo
								,	Dv			= cldv
								,	Nombre		= clnombre
							from	BacParamSuda.dbo.Cliente	with(nolock)
						)	Clie	On 	Clie.Rut = His.Rut_Cliente and Clie.codigo = His.Codigo_Cliente

			Left Join	(	select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon1 ON mon1.mncodmon = his.compra_moneda
			Left Join	(	select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon2 ON mon2.mncodmon = Venta.venta_moneda

	where	His.Estado				<> ''
	and		His.Tipo_Flujo			= 1

	INSERT INTO #RESULTADOS_MESA
	select  Modulo				= 'OPT'
	,		Producto			= CASE	WHEN Opciones.MoRelacionaPAE = 1 THEN 'PAE BONIFICADO' 
										ELSE Estr.OpcEstDsc
									END	-->  Opciones.MoCallPut

	,		Numero_Operacion	= LTRIM(RTRIM( Opciones.MoNumContrato ))
	,		Documento			= 0
	,		Correlativo			= 0
	,		Serie				= ''
	,		RutCliente			= LTRIM(RTRIM(CONVERT(CHAR(10),clie.Clrut)))
	,		CodCliente			= Opciones.MoCodigo
	,		DvCliente			= LTRIM(RTRIM(clie.Cldv))
	,		NombreCliente		= LTRIM(RTRIM(clie.Clnombre)) + SPACE(60 - LEN(LTRIM(RTRIM(clie.Clnombre))))
	,		TipoOperacion		= CASE WHEN Opciones.MoVinculacion ='Individual' THEN Opciones.MoCVOpc ELSE '' END
	,		Monto				= Opciones.MoMontoMon1
	,		MonTransada			= Opciones.MonTransada
	,		MonConversion		= Opciones.MonConversion
	,		TCCierre			= Opciones.MoStrike
	,		TCCosto				= 0.0
	,		ParidadCierre		= 0.0
	,		ParidadCosto		= 0.0
	,		MontoPesos			= Opciones.MoMontoMon2
	,		Operador			= Opciones.mooperador
	,		MontoDolares		= Opciones.MoMontoMon1
	,		ResultadoMesa		= ISNULL( Opciones.MoResultadoVentasML, 0)
	,		Fecha				= CONVERT(CHAR(8), Opciones.MoFechaContrato, 112)
	,		Relacionado			= '--'
	,		FolioRelacionado	= 0
	from	(	select	mvto.MoNumContrato,	mvto.mooperador, mvto.MoResultadoVentasML, mvto.MoFechaContrato
					,	mvto.MoRutCliente,	mvto.MoCodigo
					,	ctro.MoCallPut,	ctro.MoStrike, ctro.MoVinculacion, ctro.MoCVOpc, ctro.MoMontoMon1, ctro.MoMontoMon2
					,	MonTransada	  = Mon1.mnnemo, MonConversion = Mon2.mnnemo
					,	mvto.MoRelacionaPAE, mvto.mocodestructura
				from	LNKOPC.CbMdbOpc.dbo.MoEncContrato mvto
						inner join LNKOPC.CbMdbOpc.dbo.MoDetContrato ctro ON mvto.MoNumFolio = ctro.MoNumFolio and ctro.MoNumEstructura = 1
						inner join ( select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon1 On Mon1.mncodmon = ctro.MoCodMon1
						inner join ( select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon2 On Mon2.mncodmon = ctro.MoCodMon2
				where	mvto.MoFechaContrato		between @FechaDesde and @FechaHasta
				and		mvto.MoResultadoVentasML	<> 0    
				and		mvto.MoNumContrato			not in (	select	MoNumcontrato 
																from	LNKOPC.CbMdbOpc.dbo.MoEncContrato
																where	(	moTipoTransaccion = 'ANULA' 
																		or	moTipoTransaccion = 'ANTICIPA'	
																		)
																and		MoFechaContrato >= @FechaDesde and MoFechaContrato <= @FechaHasta
															)
				and		mvto.moestado				<> 'C'

				union

				select	mvto.MoNumContrato,	mvto.mooperador, mvto.MoResultadoVentasML, mvto.MoFechaContrato
					,	mvto.MoRutCliente,	mvto.MoCodigo
					,	ctro.MoCallPut,	ctro.MoStrike, ctro.MoVinculacion, ctro.MoCVOpc, ctro.MoMontoMon1, ctro.MoMontoMon2
					,	MonTransada	  = Mon1.mnnemo, MonConversion = Mon2.mnnemo
					,	mvto.MoRelacionaPAE, mvto.mocodestructura
				from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato mvto
						inner join LNKOPC.CbMdbOpc.dbo.MoHisDetContrato ctro ON mvto.MoNumFolio = ctro.MoNumFolio and ctro.MoNumEstructura = 1
						inner join ( select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon1 On Mon1.mncodmon = ctro.MoCodMon1
						inner join ( select mncodmon, mnnemo from BacParamSuda.dbo.Moneda with(nolock) ) Mon2 On Mon2.mncodmon = ctro.MoCodMon2
				where	mvto.MoFechaContrato		between @FechaDesde and @FechaHasta
				and		mvto.MoResultadoVentasML	<> 0    
				and		mvto.MoNumContrato			not in (	select	MoNumcontrato 
																from	LNKOPC.CbMdbOpc.dbo.MoHisEncContrato
																where	(	moTipoTransaccion = 'ANULA' 
																		or	moTipoTransaccion = 'ANTICIPA'	
																		)
																and		MoFechaContrato >= @FechaDesde and MoFechaContrato <= @FechaHasta
															)
				and		mvto.moestado				<> 'C'

			)	Opciones

			left  join LNKOPC.CbMdbOpc.dbo.OpcionEstructura Estr ON Estr.OpcEstCod = Opciones.mocodestructura

			inner join ( select clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
						 from	BacParamSuda.dbo.cliente with(nolock)
						) Clie	On	Clie.clrut		= Opciones.MoRutCliente
								and Clie.clcodigo	= Opciones.MoCodigo

	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo              = 'BFW'        
	,		Producto            = 'ANT ' + Prod.descripcion
	,		Numero_Operacion    = unwind.canumoper
	,		Numero_Documento    = 0
	,		Numero_Correlativo  = 0
	,		Serie               = ''
	,		RutCliente          = Clie.clrut
	,		CodCliente          = Clie.clcodigo
	,		DvCliente           = Clie.cldv
	,		NombreCliente       = Clie.clnombre
	,		TipoOperacion       = unwind.catipoper
	,		Monto               = unwind.camtomon1
	,		MonTransada         = Mon1.mnnemo
	,		MonConversion       = Mon2.mnnemo
	,		TCCierre            = CASE WHEN unwind.cacodpos1 = 2  THEN unwind.capremon1    ELSE unwind.precio_spot  + unwind.caantptosfwd       END
	,		TCCosto             = CASE WHEN unwind.cacodpos1 = 2  THEN unwind.capremon2    ELSE unwind.capreant     + unwind.caantptoscos       END
	,		ParidadCierre       = CASE WHEN unwind.cacodpos1 = 2  THEN unwind.precio_spot  +    unwind.caantptosfwd / Mon1.mnfactor  ELSE 1.0 END
	,		ParidadCosto        = CASE WHEN unwind.cacodpos1 = 2  THEN unwind.capreant     +    unwind.caantptoscos / Mon1.mnfactor  ELSE 1.0 END
	,		MontoPesos          = unwind.caequmon1
	,		Operador            = unwind.caoperador
	,		MontoDolares        = CASE WHEN unwind.cacodpos1 = 2 and unwind.camtomon1 <> 13 THEN unwind.camtomon2 ELSE unwind.caequusd1 END
	,		ResultadoMesa       = unwind.caspread
	,		Fecha				= unwind.cafecvcto
	,		Relacionado         = '--'
	,		FolioRelacionado    = 0
	FROM	(	select	canumoper,	 cacodpos1,		catipoper, camtomon1, camtomon2, caequusd1, caequmon1, capremon1, capremon2, capreant
				,		precio_spot, caantptosfwd,	caantptoscos
				,		caspread,	 cafecvcto,		caoperador, cacodigo, cacodcli, cacodmon1, cacodmon2
				from	BacFwdsuda.dbo.MFCA   with(nolock)
				where	cafecvcto BETWEEN @FechaDesde and @Fechahasta
				and		caantici   = 'A'
				and		caestado  <> 'A'

				union

				select	canumoper,	 cacodpos1,		catipoper, camtomon1, camtomon2, caequusd1, caequmon1, capremon1, capremon2, capreant
				,		precio_spot, caantptosfwd = 0.0, caantptoscos = 0.0
				,		caspread,	 cafecvcto,		caoperador, cacodigo, cacodcli, cacodmon1, cacodmon2
				from	BacFwdsuda.dbo.MFCAH  with(nolock)
				where	cafecvcto BETWEEN @FechaDesde and @Fechahasta
				and		caantici   = 'A'
				and		caestado  <> 'A'
			)	unwind

			inner join ( select clrut, clcodigo, cldv, clnombre = substring(clnombre, 1,100) 
						 from	BacParamSuda.dbo.cliente with(nolock)
						) Clie	On	Clie.clrut		= unwind.cacodigo
								and Clie.clcodigo	= unwind.cacodcli

			left  join	( select codigo_producto, descripcion from BacParamSuda.dbo.Producto with(nolock)
						   where Id_Sistema = 'BFW'
						) Prod On Prod.codigo_producto = unwind.cacodpos1

			Left  Join	(	select mncodmon, mnnemo, mnfactor from BacParamSuda.dbo.Moneda with(nolock) ) Mon1 ON mon1.mncodmon = unwind.cacodmon1
			Left  Join	(	select mncodmon, mnnemo, mnfactor from BacParamSuda.dbo.Moneda with(nolock) ) Mon2 ON mon2.mncodmon = unwind.cacodmon2


	update	#RESULTADOS_MESA
	set		Monto		 = Monto			- Anticipo.nMonto
	,		MontoPesos	 = MontoPesos		- Anticipo.nPesos
	,		MontoDolares = MontoDolares		- Anticipo.nDolares
	from	( select	Contrato	= Numero_Operacion
					,	nMonto		= Monto
					,	nPesos		= MontoPesos
					,	nDolares	= MontoDolares
				from	#RESULTADOS_MESA  
				where	Modulo		= 'BFW' 
				and		Producto	like 'Ant%'
			)	Anticipo
	where	Modulo				= 'BFW'
	and		Producto			not like 'Ant%'
	and		Numero_Operacion	= Anticipo.Contrato

	INSERT INTO #RESULTADOS_MESA
	SELECT	Modulo              = 'BCC'
	,		Producto            = 'SPOT WEB'
	,		Numero_Operacion    = opx.FolioContrato
	,		Numero_Documento    = 0
	,		Numero_Correlativo  = 0
	,		Serie               = ''
	,		RutCliente          = opx.RutCliente
	,		CodCliente          = 0
	,		DvCliente           = cli.xdig
	,		NombreCliente       = opx.NombreCliente
	,		TipoOperacion       = opx.TipoTransaccion
	,		Monto               = opx.MtoDolares
	,		MonTransada         = 'USD'
	,		MonConversion       = 'CLP'
	,		TCCierre            = opx.TipoCambio
	,		TCCosto             = CASE	WHEN opx.TipoTransaccion = 'C' THEN (opx.TipoCambio + opx.SpreadComercial)
										ELSE								(opx.TipoCambio - opx.SpreadComercial)
									END
	,		ParidadCierre       = 1.0
	,		ParidadCosto        = 1.0
	,		MontoPesos          = opx.MtoPesos
	,		Operador            = 'E-Bank'
	,		MontoDolares        = opx.MtoDolares
	,		ResultadoMesa       = CASE	WHEN opx.TipoTransaccion = 'C' THEN ROUND(((opx.TipoCambio + opx.SpreadComercial) - opx.TipoCambio) * opx.MtoDolares, 0)
										ELSE   								ROUND(((opx.TipoCambio - opx.SpreadComercial) - opx.TipoCambio) * opx.MtoDolares, 0)	
								END 	
	,		Fecha               = opx.Fecha
	,		Relacionado         = '--'
	,		FolioRelacionado    = 0
	FROM	BacCamSuda.dbo.TBL_OPERACIONES_OMA_EXTERNAS opx with(nolock)
			INNER JOIN (	SELECT		xRut = clrut
							,			xDig = MIN( cldv )
							FROM		BacParamSuda.dbo.CLIENTE 
							GROUP BY	clrut 
						)	cli		ON cli.xRut = opx.RutCliente
	WHERE  opx.Fecha	      BETWEEN @FechaDesde AND @Fechahasta

	SELECT	Modulo				= RetornoFinal.Modulo
		,   Producto			= RetornoFinal.Producto
		,   Numero_Operacion	= RetornoFinal.Numero_Operacion
		,   Relacionado			= RetornoFinal.Relacionado
		,   FolioRef			= RetornoFinal.FolioRef
		,   Serie				= RetornoFinal.Serie
		,   RutCliente			= RetornoFinal.RutCliente
		,   CodCliente			= RetornoFinal.CodCliente
		,   DvCliente			= RetornoFinal.DvCliente
		,   NombreCliente		= RetornoFinal.NombreCliente
		,   TipoOperacion		= RetornoFinal.TipoOperacion
		,   Monto				= RetornoFinal.Monto
		,   MonTransada			= RetornoFinal.MonTransada
		,   MonConversion		= RetornoFinal.MonConversion
		,   TCCierre			= RetornoFinal.TCCierre
		,   TCCosto				= RetornoFinal.TCCosto
		,   ParidadCierre		= RetornoFinal.ParidadCierre
		,   ParidadCosto		= RetornoFinal.ParidadCosto
		,   MontoPesos			= RetornoFinal.MontoPesos
		,   Operador			= RetornoFinal.Operador
		,   MontoDolares		= RetornoFinal.MontoDolares
		,   ResultadoMesa		= RetornoFinal.ResultadoMesa
		,   Fecha				= RetornoFinal.Fecha
	FROM	(	SELECT	Modulo				= Result.Modulo
					,   Producto			= Result.Producto
					,   Numero_Operacion	= Result.Numero_Operacion
					,   Relacionado			= Result.Relacionado
					,   FolioRef			= Result.Correlativo
					,   Serie				= Result.Serie
					,   RutCliente			= Result.RutCliente
					,   CodCliente			= Result.CodCliente
					,   DvCliente			= Result.DvCliente
					,   NombreCliente		= Result.NombreCliente
					,   TipoOperacion		= Result.TipoOperacion
					,   Monto				= Result.Monto
					,   MonTransada			= Result.MonTransada
					,   MonConversion		= Result.MonConversion
					,   TCCierre			= Result.TCCierre
					,   TCCosto				= Result.TCCosto
					,   ParidadCierre		= Result.ParidadCierre
					,   ParidadCosto		= Result.ParidadCosto
					,   MontoPesos			= Result.MontoPesos
					,   Operador			= Result.Operador
					,   MontoDolares		= Result.MontoDolares
					,   ResultadoMesa		= Result.ResultadoMesa
					,   Fecha				= Result.Fecha
					,   Documento			= Result.Documento
					,   Correlativo			= Result.Correlativo
				FROM	#RESULTADOS_MESA	Result
						inner join (	select	Usuario = tbglosa 
										from	BacParamSuda.dbo.Tabla_General_Detalle with(nolock)
										where	tbcateg	= case	when @MedaDistibucion = 1 then 9000 
																when @MedaDistibucion = 2 then 9001
																else 9000 end
									)	Filtro	On Filtro.Usuario = Result.operador
				WHERE  Result.Modulo		<> 'OPT'

				UNION

				SELECT	Modulo				= Result.Modulo
					,   Producto			= Result.Producto
					,   Numero_Operacion	= Result.Numero_Operacion
					,   Relacionado			= Result.Relacionado
					,   FolioRef			= Result.Correlativo
					,   Serie				= Result.Serie
					,   RutCliente			= Result.RutCliente
					,   CodCliente			= Result.CodCliente
					,   DvCliente			= Result.DvCliente
					,   NombreCliente		= Result.NombreCliente
					,   TipoOperacion		= Result.TipoOperacion
					,   Monto				= Result.Monto
					,   MonTransada			= Result.MonTransada
					,   MonConversion		= Result.MonConversion
					,   TCCierre			= Result.TCCierre
					,   TCCosto				= Result.TCCosto
					,   ParidadCierre		= Result.ParidadCierre
					,   ParidadCosto		= Result.ParidadCosto
					,   MontoPesos			= Result.MontoPesos
					,   Operador			= Result.Operador
					,   MontoDolares		= Result.MontoDolares
					,   ResultadoMesa		= Result.ResultadoMesa
					,   Fecha				= Result.Fecha
					,   Documento			= Result.Documento
					,   Correlativo			= Result.Correlativo
				FROM	#RESULTADOS_MESA	Result
				WHERE	Result.Modulo		= 'OPT'
				AND		@MedaDistibucion	= 1
			)	RetornoFinal
		ORDER BY	RetornoFinal.fecha
			,		RetornoFinal.Modulo
			,		RetornoFinal.Producto
			,		RetornoFinal.RutCliente
			,		RetornoFinal.CodCliente
			,		RetornoFinal.Numero_Operacion
			,		RetornoFinal.Documento
			,		RetornoFinal.Correlativo

END
GO
