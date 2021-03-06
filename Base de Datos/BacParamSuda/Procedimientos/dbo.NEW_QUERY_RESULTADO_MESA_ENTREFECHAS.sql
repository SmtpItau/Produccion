USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[NEW_QUERY_RESULTADO_MESA_ENTREFECHAS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[NEW_QUERY_RESULTADO_MESA_ENTREFECHAS]
   (   @FechaDesde        DATETIME
   ,   @FechaHasta        DATETIME
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
   (      Modulo           CHAR(3)         
      ,   Producto         VARCHAR(50)
      ,   Numero_Operacion NUMERIC(9)
      ,   Documento        NUMERIC(9)
      ,   Correlativo      INTEGER
      ,   Serie            VARCHAR(20)
      ,   RutCliente       NUMERIC(12)
      ,   CodCliente       INTEGER
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
      ,   Fecha	           DATETIME --> CHAR(10)
      ,   Relacionado      VARCHAR(15)
      ,   FolioRelacionado NUMERIC(9)
   )

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
      ,   MontoPesos          = CASE WHEN mvto.motipoper IN('VI', 'VP') THEN mvto.movalven 
                                     ELSE                                    mvto.movpresen
                                END
      ,   Operador            = mvto.mousuario
      ,   MontoDolares        = 0.0
      ,   ResultadoMesa       = mvto.moDifTran_CLP
      ,   Fecha		      = mvto.mofecpro --> CONVERT(CHAR(10), mvto.mofecpro, 103)
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
      ,   Fecha		      = mvto.mofecpro --> CONVERT(CHAR(10), mvto.mofecpro, 103)
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
      ,   TCCosto             = CASE WHEN mvto.moterm = 'COMEX' THEN mvto.CMX_TC_Costo_Trad ELSE mvto.motctra END
      ,   ParidadCierre       = mvto.moparme
      ,   ParidadCosto        = mvto.mopartr
      ,   MontoPesos          = mvto.momonpe
      ,   Operador            = mvto.mooper
      ,   MontoDolares        = mvto.moussme
      ,   ResultadoMesa       = mvto.moDifTran_Clp
      ,   Fecha		      = mvto.mofech 	--> CONVERT(CHAR(10), mvto.mofech, 103)
      ,   Relacionado         = CASE WHEN mvto.monumfut > 0 AND mvto.moterm = 'SWAP SPOT'                         THEN 'Swap Spot' 
                                     WHEN mvto.monumfut > 0 AND mvto.moterm = 'EMPRESAS'  AND morutcli = 96665450 THEN 'Neteo'
                                     ELSE                                                                              'Sin Relación' 
                                END
      ,   FolioRelacionado    = CASE WHEN mvto.monumfut > 0 AND mvto.moterm = 'SWAP SPOT'                             THEN mvto.monumfut
                                     WHEN mvto.monumfut > 0 AND mvto.moterm = 'EMPRESAS' AND mvto.morutcli = 96665450 THEN mvto.monumfut
                                     ELSE                                                                                  0
                                END
   FROM   BacCamSuda.dbo.MEMO mvto
          INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut = mvto.morutcli and clie.clcodigo = mvto.mocodcli
   WHERE  mvto.moestatus     <> 'A' and mvto.moterm <> 'FORWARD' and mvto.moterm <> 'SWAP' and mvto.moterm <> 'OPCIONES' 
     AND  mvto.mofech         BETWEEN @FechaDesde AND @Fechahasta
     AND  mvto.moterm         NOT IN ('DATATEC','BOLSA')

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
      ,   TCCosto             = CASE WHEN mvto.moterm = 'COMEX' THEN mvto.CMX_TC_Costo_Trad ELSE mvto.motctra END
      ,   ParidadCierre       = mvto.moparme
      ,   ParidadCosto        = mvto.mopartr
      ,   MontoPesos          = mvto.momonpe
      ,   Operador            = mvto.mooper
      ,   MontoDolares        = mvto.moussme
      ,   ResultadoMesa       = mvto.moDifTran_Clp
      ,   Fecha		      = mvto.mofech --> CONVERT(CHAR(10), mvto.mofech, 103)
      ,   Relacionado         = CASE WHEN mvto.monumfut > 0 AND mvto.moterm = 'SWAP SPOT'                         THEN 'Swap Spot' 
                                     WHEN mvto.monumfut > 0 AND mvto.moterm = 'EMPRESAS'  AND morutcli = 96665450 THEN 'Neteo'
                                     ELSE                                                                              'Sin Relación' 
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

   ------------------------------------------------------------------------------
   ------------------------------------------------------------------------------
   ------------------------------------------------------------------------------

   INSERT INTO #RESULTADOS_MESA
   SELECT Modulo              = 'BFW'
      ,   Producto            = prod.descripcion
      ,   Numero_Operacion    = mvto.monumoper
      ,   Numero_Documento    = 0
      ,   Numero_Correlativo  = 0
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
      ,   ResultadoMesa       = CASE WHEN mvto.mocodpos1 = 2 THEN ROUND(Resultado_Mesa * vcont.tipo_cambio, 0) 
                                     ELSE                         Resultado_Mesa
                                END
      ,   Fecha		      = mvto.mofecha 	--> CONVERT(CHAR(10), mvto.mofecha, 103)
      ,   Relacionado         = '--'
      ,   FolioRelacionado    = 0
     FROM BacFwdSuda.dbo.MFMO                  mvto
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
      ,   Producto            = prod.descripcion
      ,   Numero_Operacion    = mvto.monumoper
      ,   Numero_Documento    = 0
      ,   Numero_Correlativo  = 0
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
      ,   MontoDolares        = CASE mvto.mocodpos1 WHEN 2 THEN MVTO.momtomon2 ELSE mvto.moequusd1 END
      ,   ResultadoMesa       = CASE WHEN mvto.mocodpos1 = 2 THEN ROUND(Resultado_Mesa * vcont.tipo_cambio, 0)
                                     ELSE                         Resultado_Mesa
                                END
      ,   Fecha		      = mvto.mofecha	-->	CONVERT(CHAR(10), mvto.mofecha, 103)
      ,   Relacionado         = '--'
      ,   FolioRelacionado    = 0
     FROM BacFwdSuda.dbo.MFMOH                 mvto
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
      ,   Fecha		   = mvto.fecha_cierre 	-->	CONVERT(CHAR(10), mvto.fecha_cierre, 103)
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
      ,   Fecha		   = mvto.fecha_cierre	-->	CONVERT(CHAR(10), mvto.fecha_cierre, 103)
      ,   Relacionado      = '--'
      ,   FolioRelacionado = 0
    FROM  BacSwapSuda.dbo.MOVDIARIO               mvto
          INNER JOIN BacSwapSuda.dbo.MOVDIARIO    vent ON vent.numero_operacion = mvto.numero_operacion 
                                                      and vent.numero_flujo     = mvto.numero_flujo
                                                      and vent.tipo_flujo       = 2
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
      ,   Fecha		   = his.fecha_cierre	   -->	CONVERT(CHAR(10), mvto.fecha_cierre, 103)
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
      ,   Fecha		      = unw.cafecvcto
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
      ,   'Relacionado' = Relacionado       --> CASE WHEN Relacionado = 'S' THEN 'REL. FORWARD' ELSE ' ' END
      ,   'Folio Ref.'  = FolioRelacionado
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
   FROM   #RESULTADOS_MESA
   WHERE  operador IN( 'AKUHNB',     'APRESSAC',    'BDELIC',     'CAVENDANO', 'CSANMARTIN', 'FRIVERA',   'GHORTAL',   'GMIRANDA', 'JCUMSILLE'
                     , 'MCIFUENTES', 'RDELAFUENTE', 'SBRINCK',    'CMARSHALL', 'PVILLENA',   'FMARTINEZ', 'XTORRICO',  'OVALDES',  'ACAPRILE'
                     , 'CMONTEBRUN', 'CMONTEBRUNO', 'JJARAMILLO', 'NLABBE',    'CMAUREIRA',  'MDIAZF',    'FHINOJOSA', 'LCUEVAS',  'DTONDA'
                     , 'LMAYOL',     'MABUSLEME'
                     )
   ORDER BY fecha, Modulo, Producto,  RutCliente, CodCliente, Numero_Operacion, Documento, Correlativo

END
GO
