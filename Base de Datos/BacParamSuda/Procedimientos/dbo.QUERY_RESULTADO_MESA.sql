USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[QUERY_RESULTADO_MESA]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[QUERY_RESULTADO_MESA]
   (   @FechaMovimiento   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON

   UPDATE BacCamSuda.dbo.MEMO
      SET moDifTran_Mo  =       CASE WHEN motipmer = 'EMPR' AND mocodcnv = 'USD' AND motipope = 'C' THEN (mousstr - moussme)
                                     WHEN motipmer = 'EMPR' AND mocodcnv = 'USD' AND motipope = 'V' THEN (moussme - mousstr)
                                     WHEN motipmer = 'EMPR' AND mocodcnv = 'CLP' AND motipope = 'C' THEN (mousstr - moussme)
                                     WHEN motipmer = 'EMPR' AND mocodcnv = 'CLP' AND motipope = 'V' THEN (moussme - mousstr)

                                     WHEN motipmer = 'ARBI'                      AND motipope = 'C' THEN (mopartr - moparme)
                                     WHEN motipmer = 'ARBI'                      AND motipope = 'V' THEN (moparme - mopartr)
                                END

      ,   moDifTran_Clp = ROUND(CASE WHEN motipmer = 'EMPR' AND mocodcnv = 'USD' AND motipope = 'C' THEN (mousstr  - moussme)  * moticam
                                     WHEN motipmer = 'EMPR' AND mocodcnv = 'USD' AND motipope = 'V' THEN (moussme  - mousstr)  * moticam
                                     WHEN motipmer = 'EMPR' AND mocodcnv = 'CLP' AND motipope = 'C' THEN (motctra  - moticam)  * moussme
                                     WHEN motipmer = 'EMPR' AND mocodcnv = 'CLP' AND motipope = 'V' THEN (moticam  - motctra)  * moussme

                                     WHEN motipmer = 'ARBI'                      AND motipope = 'C' THEN (mopartr  - moparme)  * moticam * momonmo
                                     WHEN motipmer = 'ARBI'                      AND motipope = 'V' THEN (moparme  - mopartr)  * moticam * momonmo
                                END, 0)
   WHERE  motipmer <> 'PTAS'

   DECLARE @dFechaProceso   DATETIME
       SET @dFechaProceso   = ( SELECT acfecproc FROM BacTraderSuda.dbo.MDAC with(nolock) )

   DECLARE @dFechaAnterior  DATETIME
       SET @dFechaAnterior  = ( SELECT acfecante FROM BacTraderSuda.dbo.MDAC with(nolock) )

   IF @dFechaProceso < @FechaMovimiento
   BEGIN
      SELECT -1, 'Fecha de Criterio es mayor a la fecha de proceso'
      RETURN
   END

   DECLARE @TipoCambio   NUMERIC(21,4)
       SET @TipoCambio   = ( SELECT Tipo_Cambio
                               FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)
                              WHERE Fecha         = CASE WHEN @dFechaProceso = @FechaMovimiento THEN @dFechaProceso
                                                         ELSE @FechaMovimiento
                                                    END
                                AND Codigo_Moneda = 994)

   IF @TipoCambio IS NULL
   BEGIN
       SET @TipoCambio   = ( SELECT Tipo_Cambio
                               FROM BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)
                              WHERE Fecha         = CASE WHEN @dFechaProceso = @FechaMovimiento THEN @dFechaAnterior
                                                         ELSE @FechaMovimiento
                                                    END
                                AND Codigo_Moneda = 994)
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
      ,   ParidadCosto    NUMERIC(21,4)
      ,   MontoPesos       NUMERIC(21,4)
      ,   Operador         VARCHAR(15)
      ,   MontoDolares     NUMERIC(21,4)
      ,   ResultadoMesa    NUMERIC(21,4)
      ,	  Fecha		   DATETIME --> CHAR(10)
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
      ,   Fecha		      = mvto.mofecpro -->	CONVERT(CHAR(10), mvto.mofecpro, 103)
     FROM BacTraderSuda.dbo.MDMO mvto
          INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut    = mvto.morutcli and clie.clcodigo = mvto.mocodcli
          LEFT  JOIN BacParamSuda.dbo.MONEDA  mone ON mone.mncodmon = mvto.momonemi
    WHERE mvto.motipoper      IN('CP', 'CI', 'VP', 'VI', 'IB')
      AND mvto.mostatreg      = ''
      AND mvto.mofecpro       = @FechaMovimiento
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
      ,   Fecha		      = mvto.mofecpro	-->	CONVERT(CHAR(10), mvto.mofecpro, 103)
     FROM BacTraderSuda.dbo.MDMH mvto
          INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut    = mvto.morutcli and clie.clcodigo = mvto.mocodcli
          LEFT  JOIN BacParamSuda.dbo.MONEDA  mone ON mone.mncodmon = mvto.momonemi
    WHERE mvto.motipoper      IN('CP', 'CI', 'VP', 'VI', 'IB')
      AND mvto.mostatreg      = ''
      AND mvto.mofecpro       = @FechaMovimiento
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
      ,   TCCosto             = mvto.motctra
      ,   ParidadCierre       = mvto.moparme
      ,   ParidadCosto        = mvto.mopartr
      ,   MontoPesos          = mvto.momonpe
      ,   Operador            = mvto.mooper
      ,   MontoDolares        = mvto.moussme
      ,   ResultadoMesa       = mvto.moDifTran_Clp
      ,   Fecha		      = mvto.mofech	-->	CONVERT(CHAR(10), mvto.mofech, 103)
   FROM   BacCamSuda.dbo.MEMO mvto
          INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut = mvto.morutcli and clie.clcodigo = mvto.mocodcli
   WHERE  mvto.moestatus      = ''
     AND  mvto.mofech         = @FechaMovimiento


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
      ,   TCCosto             = mvto.motctra
      ,   ParidadCierre       = mvto.moparme
      ,   ParidadCosto        = mvto.mopartr
      ,   MontoPesos          = mvto.momonpe
      ,   Operador            = mvto.mooper
      ,   MontoDolares        = mvto.moussme
      ,   ResultadoMesa       = mvto.moDifTran_Clp
      ,   Fecha		      = mvto.mofech	-->	CONVERT(CHAR(10), mvto.mofech, 103)
   FROM   BacCamSuda.dbo.MEMOH mvto
          INNER JOIN BacParamSuda.dbo.CLIENTE clie ON clie.clrut = mvto.morutcli and clie.clcodigo = mvto.mocodcli
   WHERE  mvto.moestatus      = ''
     AND  mvto.mofech         = @FechaMovimiento

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
      ,   MontoDolares        = mvto.moequusd1
      ,   ResultadoMesa       = CASE WHEN mvto.mocodpos1 = 2 THEN ROUND(Resultado_Mesa * vcont.tipo_cambio, 0) 
                                     ELSE                         Resultado_Mesa
                                END
      ,   Fecha		      = mvto.mofecha	-->	CONVERT(CHAR(10), mvto.mofecha, 103)
     FROM BacFwdSuda.dbo.MFMO                  mvto
          INNER JOIN BacFwdSuda.dbo.MFAC       ctro ON ctro.acfecproc  = mvto.mofecha
          INNER JOIN BacParamSuda.dbo.CLIENTE  clie ON clie.clrut      = mvto.mocodigo AND clie.clcodigo        = mvto.mocodcli
          INNER JOIN BacParamSuda.dbo.PRODUCTO prod ON prod.id_sistema = 'BFW'         AND prod.codigo_producto = mvto.mocodpos1
          LEFT  JOIN BacParamSuda.dbo.MONEDA   mon1 ON mon1.mncodmon   = mvto.mocodmon1
          LEFT  JOIN BacParamSuda.dbo.MONEDA   mon2 ON mon2.mncodmon   = mvto.mocodmon2
          LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vcont ON vcont.fecha         = ctro.acfecante 
                                                                 and vcont.codigo_moneda = 994
   WHERE  mvto.moestado      = ''
     AND  mvto.mofecha       = @FechaMovimiento

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
      ,   MontoDolares        = mvto.moequusd1
      ,   ResultadoMesa       = CASE WHEN mvto.mocodpos1 = 2 THEN ROUND(Resultado_Mesa * vcont.tipo_cambio, 0)
                                     ELSE                         Resultado_Mesa
                                END
      ,   Fecha		      = mvto.mofecha	-->	CONVERT(CHAR(10), mvto.mofecha, 103)
     FROM BacFwdSuda.dbo.MFMOH                 mvto
          INNER JOIN BacFwdSuda.dbo.MFACH      ctro ON ctro.acfecproc  = mvto.mofecha
          INNER JOIN BacParamSuda.dbo.CLIENTE  clie ON clie.clrut      = mvto.mocodigo AND clie.clcodigo        = mvto.mocodcli
          INNER JOIN BacParamSuda.dbo.PRODUCTO prod ON prod.id_sistema = 'BFW'         AND prod.codigo_producto = mvto.mocodpos1
          LEFT  JOIN BacParamSuda.dbo.MONEDA   mon1 ON mon1.mncodmon   = mvto.mocodmon1
          LEFT  JOIN BacParamSuda.dbo.MONEDA   mon2 ON mon2.mncodmon   = mvto.mocodmon2
          LEFT  JOIN BacParamSuda.dbo.VALOR_MONEDA_CONTABLE vcont ON vcont.fecha         = ctro.acfecante 
                                                                 and vcont.codigo_moneda = 994
   WHERE  mvto.moestado      = ''
     AND  mvto.mofecha       = @FechaMovimiento

   INSERT INTO #RESULTADOS_MESA
   SELECT Modulo           = 'PCS'
      ,   Producto         = CASE WHEN mvto.tipo_swap = 1 THEN 'SWAP DE TASAS'
                                  WHEN mvto.tipo_swap = 2 THEN 'SWAP DE MONEDAS'
                                  WHEN mvto.tipo_swap = 3 THEN 'FORWARD RATE AGREETMEN'
                                  WHEN mvto.tipo_swap = 1 THEN 'SWAP PROMEDIO CAMARA'
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
      , TCCosto          = mvto.Tasa_Transfer
      ,   ParidadCierre    = vent.venta_valor_tasa
      ,   ParidadCosto     = vent.Tasa_Transfer
      ,   MontoPesos       = vent.venta_capital
      ,   Operador         = mvto.operador
      ,   MontoDolares     = 0
      ,   ResultadoMesa    = mvto.Res_Mesa_Dist_CLP 
      ,   Fecha		   = mvto.fecha_cierre	-->	CONVERT(CHAR(10), mvto.fecha_cierre, 103)
    FROM  BacSwapSuda.dbo.MOVHISTORICO            mvto
          INNER JOIN BacSwapSuda.dbo.MOVHISTORICO vent ON vent.numero_operacion = mvto.numero_operacion 
                 and vent.numero_flujo     = mvto.numero_flujo
                                                      and vent.tipo_flujo       = 2
          INNER JOIN BacParamSuda.dbo.CLIENTE     clie ON clie.clrut = mvto.rut_cliente and clie.clcodigo = mvto.codigo_cliente 
          LEFT  JOIN BacParamSuda.dbo.MONEDA      mon1 ON mon1.mncodmon = mvto.compra_moneda
          LEFT  JOIN BacParamSuda.dbo.MONEDA      mon2 ON mon2.mncodmon = vent.venta_moneda
   WHERE  mvto.fecha_cierre     = @FechaMovimiento
     AND  mvto.tipo_flujo       = 1
     AND  mvto.numero_flujo     = (SELECT MIN( ctlf.numero_flujo ) 
                                     FROM BacSwapSuda.dbo.MOVHISTORICO ctlf 
                                    WHERE ctlf.fecha_cierre      = @FechaMovimiento 
                                      AND ctlf.numero_operacion  = mvto.numero_operacion 
                                      AND ctlf.tipo_flujo        = 1)


   INSERT INTO #RESULTADOS_MESA
   SELECT Modulo           = 'PCS'
      ,   Producto         = CASE WHEN mvto.tipo_swap = 1 THEN 'SWAP DE TASAS'
                                  WHEN mvto.tipo_swap = 2 THEN 'SWAP DE MONEDAS'
                                  WHEN mvto.tipo_swap = 3 THEN 'FORWARD RATE AGREETMEN'
                                  WHEN mvto.tipo_swap = 1 THEN 'SWAP PROMEDIO CAMARA'
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
    FROM  BacSwapSuda.dbo.MOVDIARIO               mvto
          INNER JOIN BacSwapSuda.dbo.MOVDIARIO    vent ON vent.numero_operacion = mvto.numero_operacion 
                                                      and vent.numero_flujo     = mvto.numero_flujo
                                                      and vent.tipo_flujo       = 2
          INNER JOIN BacParamSuda.dbo.CLIENTE     clie ON clie.clrut = mvto.rut_cliente and clie.clcodigo = mvto.codigo_cliente 
          LEFT  JOIN BacParamSuda.dbo.MONEDA      mon1 ON mon1.mncodmon = mvto.compra_moneda
          LEFT  JOIN BacParamSuda.dbo.MONEDA      mon2 ON mon2.mncodmon = vent.venta_moneda
   WHERE  mvto.fecha_cierre     = @FechaMovimiento
     AND  mvto.tipo_flujo       = 1
     AND  mvto.numero_flujo     = (SELECT MIN( ctlf.numero_flujo ) 
                                     FROM BacSwapSuda.dbo.MOVDIARIO ctlf 
                                    WHERE ctlf.fecha_cierre = @FechaMovimiento 
                                      AND ctlf.numero_operacion  = mvto.numero_operacion 
                            AND ctlf.tipo_flujo        = 1)


   SELECT Modulo
      ,   Producto
      ,   Numero_Operacion
      ,   Documento
      ,   Correlativo
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
      ,	  Fecha
     FROM #RESULTADOS_MESA
   ORDER BY Modulo, Producto, RutCliente, CodCliente, Numero_Operacion, Documento, Correlativo

END


GO
