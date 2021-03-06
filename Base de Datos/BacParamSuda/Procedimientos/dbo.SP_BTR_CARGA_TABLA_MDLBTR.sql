USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BTR_CARGA_TABLA_MDLBTR]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BTR_CARGA_TABLA_MDLBTR]
AS 
BEGIN
	
   SET NOCOUNT ON

   DECLARE @fc_proceso  DATETIME
       SET @fc_proceso  = (SELECT acfecproc FROM BacTraderSuda..MDAC with (nolock))

   /* ** Crea tablas Temporales para los Movimientos ** */
   CREATE TABLE #TEMP_MDLBTR
   (   fecha                DATETIME       NOT NULL
   ,   sistema              CHAR(03)       NOT NULL
   ,   tipo_mercado         CHAR(12)       NOT NULL
   ,   tipo_operacion       CHAR(06)       NOT NULL
   ,   estado_envio         CHAR(01)       NOT NULL
   ,   numero_operacion     NUMERIC(9,0)   NOT NULL
   ,   rut_cliente          NUMERIC(9,0)   NOT NULL
   ,   codigo_cliente       NUMERIC(9,0)   NOT NULL
   ,   moneda               NUMERIC(5,0)   NOT NULL
   ,   monto_operacion      NUMERIC(21,4)  NOT NULL
   ,   forma_pago           NUMERIC(5,0)   NOT NULL
   ,   fecha_operacion	    DATETIME	   NOT NULL
   ,   fecha_vencimiento    DATETIME	   NOT NULL
   ,   liquidada            CHAR(01) 	   NOT NULL
   ,   Tipo_Movimiento      CHAr(01)	   NOT NULL
   ,   Anticipo             Char(150)      NOT NULL DEFAULT('')
   )

   CREATE INDEX #ixt_TEMP_MDLBTR ON #TEMP_MDLBTR (fecha, sistema, tipo_operacion, numero_operacion, tipo_Movimiento, tipo_mercado)
   CREATE INDEX #ixw_TEMP_MDLBTR ON #TEMP_MDLBTR (forma_pago)

   CREATE TABLE #TMPBTR
   (   fecha                DATETIME       NOT NULL
   ,   tipo_mercado         CHAR(12)       NOT NULL
   ,   tipo_operacion       CHAR(06)       NOT NULL
   ,   numero_operacion     NUMERIC(9,0)   NOT NULL
   ,   rut_cliente          NUMERIC(9,0)   NOT NULL
   ,   codigo_cliente       NUMERIC(9,0)   NOT NULL
   ,   forma_pago           NUMERIC(5,0)   NOT NULL
   ,   moneda2              NUMERIC(5,0)   NOT NULL
   ,   moneda3              NUMERIC(5,0)   NOT NULL
   ,   monto_operacion      NUMERIC(21,4)  NOT NULL
   ,   fecha_operacion	    DATETIME	   NOT NULL
   ,   fecha_vencimiento    DATETIME	   NOT NULL
   ,   liquidada            CHAR(01) 	   NOT NULL
   ,   Tipo_Movimiento      CHAr(01)	   NOT NULL
   ,   Anticipo             Char(150)      NOT NULL DEFAULT('')
   )

   CREATE INDEX #ixt_TMPBTR_NumOpe ON #TMPBTR (numero_operacion)

   -- **** Spot **** --
   -- Genera los Cargos en Moneda Extranjera Para el Motor de Pago --
   INSERT INTO #TEMP_MDLBTR
   SELECT mofech
   ,      'BCC'
   ,      motipmer
   ,      'motipope' = CASE WHEN motipope = 'V' THEN 'ITF/MX' END
   ,      'P'
   ,      monumope
   ,      morutcli
   ,      mocodcli
   ,      mncodmon
   ,      momonmo
   ,      moentre
   ,      mofech
   ,      mofech
   ,      ' '
   ,      'C'
   ,      ' '
   FROM	  BacCamSuda..MEMO  --(Index = ix_MEMO_Operacion) 
          LEFT JOIN BacParamSuda..MONEDA with (nolock)  ON mocodmon = mnnemo
   WHERE  mofech      = @fc_proceso
   AND    motipmer    IN('PTAS','EMPR')
   AND    motipope    = 'V'
   AND    mocodmon    = 'USD'
   AND    mocodcnv    = 'CLP'
   AND    moestatus  <> 'P'
   AND    moentre    IN( SELECT DISTINCT Codigo_FormaPago FROM BacParamSuda..FPAGO_CANAL with (nolock) )
   AND    moterm     <> 'CORREDORA'
   
   -->    ORDER BY mofech, motipmer, motipope, mocodmon, mocodcnv, moentre, moestatus
   -- Genera los Cargos en Moneda Extranjera Para el Motor de Pago --
   -- **** Spot **** --

   --> Insert Registros de Op. Forward Bond Trades
   INSERT INTO #TEMP_MDLBTR
   SELECT cafecvcto
   ,      plbtr.id_sistema
   ,      plbtr.producto
   ,      plbtr.Producto_LBTR
   ,      'P'
   ,      canumoper
   ,      cacodigo
   ,      cacodcli
   ,      cacodmon2
   ,      ABS(camtocomp) --> ABS(cavalordia)
   ,      cafpagomn
   ,      cafecha
   ,     'cafecvcto' = @fc_proceso
   ,      ' '
   ,      CASE WHEN camtocomp >= 0 THEN 'A'
               WHEN camtocomp <  0 THEN 'C'
          END
   ,      ' '
   FROM	  BacFwdSuda..MFCA                             with (nolock) --> (Index = ix_MFCA_canumoper)
          INNER JOIN BacParamSuda..PRODUCTO_LBTR plbtr with (nolock) ON plbtr.id_sistema = 'BFW'
                                                                    AND plbtr.producto   = CONVERT(CHAR(5),cacodpos1)
                                                                    AND plbtr.operacion  = catipoper
                                                                    AND plbtr.movimiento = 'V'
   WHERE  cacodpos1         IN(10)
   AND    cafecvcto          = @fc_proceso
   AND    caestado          <> 'P'
   AND    catipmoda          = 'C' 
   AND    caantici          <> 'A'
   AND    cafpagomn         IN(SELECT DISTINCT Codigo_FormaPago FROM BacParamSuda..FPAGO_CANAL with (nolock) )
   --> Insert Registros de Op. Forward Bond Trades

   /*******************************************************************************************************************/
   /*********************************************** SWAP PROMEDIO CAMARA **********************************************/
   /*******************************************************************************************************************/
   -- SI DEVENGO FUE REALIZADO Y LA FECHA DE PROCESO DE PARAMETROS IGUAL A LA DE SWAP
   DECLARE @Fec_Proc_Swap	DATETIME
   DECLARE @Status_Devengo_Swap	NUMERIC(1)

   SELECT  @Fec_Proc_Swap       = fechaproc
   ,	   @Status_Devengo_Swap	= Vencimientos --> devengo
   FROM	   BacSwapSuda..SWAPGENERAL  with (nolock) 

   IF  @Fec_Proc_Swap = @fc_proceso AND @Status_Devengo_Swap = 1 
   BEGIN
      SELECT Numero_Operacion
      ,      Rut_Cliente
      ,      Codigo_Cliente
      ,      Pagamos_Moneda
      ,      Pagamos_Documento
      ,      Fecha_Inicio_Flujo
      ,      Fecha_Vence_Flujo
      ,      Devengo_Monto_Peso
      INTO   #ENTREGAMOS
      FROM   BacSwapSuda..CARTERA                         with (nolock)
             INNER JOIN BacParamSuda..PRODUCTO_LBTR plbtr with (nolock)  ON plbtr.id_sistema = 'PCS' AND plbtr.producto = 'SP' AND plbtr.movimiento = 'V'
      WHERE  tipo_swap         = 4
      AND    tipo_flujo        = 2
      AND    estado           <> 'P'
      AND    Modalidad_Pago    = 'C'
      AND    fecha_vence_flujo = @fc_proceso

      SELECT Numero_Operacion   AS Oper
      ,      Devengo_Monto_Peso AS Monto
      INTO   #RECIBIMOS
      FROM   BacSwapSuda..CARTERA                         with (nolock)
             INNER JOIN BacParamSuda..PRODUCTO_LBTR plbtr with (nolock)  ON plbtr.id_sistema = 'PCS' AND plbtr.producto = 'SP' AND plbtr.movimiento = 'V'
      WHERE  tipo_swap         = 4
      AND    tipo_flujo        = 1
      AND    estado           <> 'P'
      AND    Modalidad_Pago    = 'C'
      AND    fecha_vence_flujo = @fc_proceso

      UPDATE #ENTREGAMOS
         SET Devengo_Monto_Peso = (Monto - Devengo_Monto_Peso)
        FROM #RECIBIMOS
       WHERE Numero_Operacion   = Oper

      INSERT INTO #TEMP_MDLBTR
      SELECT @fc_proceso
      ,      plbtr.id_sistema
      ,      plbtr.producto
      ,      plbtr.Producto_LBTR
      ,      'P'
      ,      Numero_Operacion
      ,      Rut_Cliente
      ,      Codigo_Cliente
      ,      CASE WHEN Pagamos_Moneda <> 999 THEN 999 ELSE Pagamos_Moneda END 
      ,      ABS(Devengo_Monto_Peso)
      ,      Pagamos_Documento
      ,      Fecha_Inicio_Flujo
      ,      Fecha_Vence_Flujo
      ,      ' '
      ,      'C'
      ,      ' '
      FROM   #ENTREGAMOS
             INNER JOIN BacParamSuda..PRODUCTO_LBTR plbtr with (nolock) ON plbtr.id_sistema = 'PCS' AND plbtr.producto = 'SP' AND plbtr.movimiento = 'V'
      WHERE  Pagamos_Documento   IN(SELECT DISTINCT Codigo_FormaPago FROM BacParamSuda..FPAGO_CANAL with (nolock) )
      AND    Devengo_Monto_Peso  < 0.0

   END
   /*******************************************************************************************************************/
   /*********************************************** FORWARD ***********************************************************/
   /*******************************************************************************************************************/

   /*  Pagamos*/
   INSERT INTO #TEMP_MDLBTR
   SELECT cafecvcto
   ,      plbtr.id_sistema 
   ,      plbtr.producto
   ,      plbtr.Producto_LBTR
   ,      'P'
   ,      canumoper
   ,      cacodigo
   ,      cacodcli
   ,      CASE WHEN cacodmon2 = 998 THEN 999 ELSE cacodmon2 END
   ,      ABS(camtocomp)
   ,      cafpagomn
   ,      cafecha
   ,     'cafecvcto' = @fc_proceso
   ,      ' '
   ,      'C'
   ,      ' '
   FROM	  BacFwdSuda..MFCA                             with (nolock)       -->             (Index = ix_MFCA_canumoper)
          INNER JOIN BacParamSuda..PRODUCTO_LBTR plbtr with (nolock) ON plbtr.id_sistema = 'BFW'
                                                                    AND plbtr.producto   = CONVERT(CHAR(5),cacodpos1)
                                                                    AND plbtr.operacion  = catipoper
                                                                    AND plbtr.movimiento = 'V'
   WHERE  cacodpos1         IN(1, 3, 12)
   AND    cafecvcto          = @fc_proceso
   AND    cacodmon2         IN(999,998)
   AND    camtocomp          < 0
   AND    caestado          <> 'P'
   AND    catipmoda          = 'C' 
   AND    caantici          <> 'A'
   AND    cafpagomn         IN(SELECT DISTINCT Codigo_FormaPago FROM BacParamSuda..FPAGO_CANAL with (nolock) )

   /*  Recibimos */
   INSERT INTO #TEMP_MDLBTR
   SELECT cafecvcto
   ,      'BFW'
   ,      cacodpos1
   ,      'VFUT'
   ,      'P'
   ,      canumoper
   ,      cacodigo
   ,      cacodcli
   ,      CASE WHEN cacodmon2 = 998 THEN 999 ELSE cacodmon2 END
   ,      ABS(camtocomp)
   ,      cafpagomn
   ,      cafecha
   ,      'cafecvcto'   = @fc_proceso
   ,      ' '
   ,      'A'
   ,      ' '
   FROM	  BacFwdSuda..MFCA   with (nolock)       --> (Index = ix_MFCA_canumoper)
   WHERE  cacodpos1     IN(1, 3, 12)
   AND    cafecvcto     = @fc_proceso
   AND    cacodmon2     IN(999,998)
   AND    caestado     <> 'P'
   AND    catipmoda     = 'C'
   AND    caantici     <> 'A'
   AND    camtocomp     > 0
   AND    cafpagomn     IN(SELECT DISTINCT Codigo_FormaPago FROM BacParamSuda..FPAGO_CANAL with (nolock) )

   /*  Pagamos Anticipo*/
   INSERT INTO #TEMP_MDLBTR
   SELECT cafecvcto
   ,      plbtr.id_sistema
   ,      plbtr.producto
   ,      plbtr.Producto_LBTR
   ,      'P'
   ,      NumeroContratoCliente
   ,      cacodigo
   ,      cacodcli
   ,      Moneda_Compensacion
   ,      ABS(CaAntMtoMdaComp)
   ,      CaAntForPagMdaComp
   ,      cafecha
   ,     'cafecvcto' = @fc_proceso
   ,      ' '
   ,      'C'
   ,      'Contrato Num. ' + RTRIM(LTRIM( CONVERT(CHAR(10), numerocontratocliente))) 
                           + ' Anexo ' 
                           + RTRIM(LTRIM(CONVERT(CHAR(10),canumoper)))
   FROM	  BacFwdSuda..MFCA                             with (nolock)       -->                     (Index = ix_MFCA_canumoper)
          INNER JOIN BacParamSuda..PRODUCTO_LBTR plbtr with (nolock) ON plbtr.id_sistema  = 'BFW'
                                                                    AND plbtr.producto    = CONVERT(CHAR(5),cacodpos1)
                                                                    AND plbtr.operacion   = catipoper
                                                                    AND plbtr.movimiento  = 'V'
   WHERE  caantmtomdacomp    < 0
   AND    caantforpagmdacomp IN(SELECT DISTINCT Codigo_FormaPago FROM BacParamSuda..FPAGO_CANAL with (nolock) )
   AND    cafecvcto          = @fc_proceso
   AND    caestado          <> 'P'
   AND    caantici           = 'A'


   /* ** Inserta los movimientos de Spot [ Entregamos ] ** */
   INSERT INTO #TEMP_MDLBTR
   SELECT mofech
   ,      plbtr.id_sistema
   ,      plbtr.Producto
   ,  plbtr.Producto_LBTR
   ,      'P'
   ,      monumope
   ,      morutcli
   ,      mocodcli
   ,      999   
   ,      momonpe
   ,      moentre
   ,      mofech
   ,     'cafecvcto' = mofech
   ,      ' '
   ,      'C'
   ,      ' '
   FROM	  BacCamSuda..MEMO        -- (Index = ix_MEMO_Operacion)
          INNER JOIN BacParamSuda..PRODUCTO_LBTR plbtr with (nolock) ON plbtr.id_sistema = 'BCC'
                                                                    AND plbtr.Producto   = motipmer
                                                                    AND plbtr.Operacion  = motipope
                                                                    AND plbtr.Movimiento = 'M'
   WHERE  mofech           =  @fc_proceso
   AND    motipmer        IN('PTAS','EMPR')
   AND    motipope         =  'C'
   AND    mocodmon         =  'USD'
   AND    mocodcnv         =  'CLP'      --> Moneda Conversion CLP
   AND    moestatus       <> 'P'
   AND    moentre         IN( SELECT DISTINCT Codigo_FormaPago FROM BacParamSuda..FPAGO_CANAL with (nolock) )
   AND    moterm          <> 'CORREDORA'

   /* ** Inserta los movimientos de Spot [ Recibimos ] ** */
   INSERT INTO #TEMP_MDLBTR
   SELECT mofech
   ,      'BCC'
   ,      motipmer
   ,      'motipope' = CASE WHEN motipope = 'V' THEN 'VSPOT' END
   ,      'P'
   ,      monumope
   ,      morutcli
   ,      mocodcli
   ,      999   
   ,      momonpe
   ,      morecib
   ,      mofech
   ,      mofech
   ,      ' '
   ,      'A'
   ,      ' '
   FROM	  BacCamSuda..MEMO   --(Index = ix_MEMO_Operacion)
   WHERE  mofech      = @fc_proceso
   AND    motipmer    IN('PTAS','EMPR')
   AND    motipope    = 'V'
   AND    mocodmon    = 'USD'
   AND    mocodcnv    = 'CLP'
   AND    morecib     IN(SELECT DISTINCT Codigo_FormaPago FROM BacParamSuda..FPAGO_CANAL with (nolock) )
   AND    moestatus  <> 'P'
   AND    moterm     <> 'CORREDORA'

   /*******************************************************************************************************************/
   /*********************************************** OPCIONES **********************************************************/
   /*******************************************************************************************************************/

   /*  Pagamos*/ 
    INSERT INTO #TEMP_MDLBTR
    SELECT   @fc_proceso
      ,      plbtr.id_sistema
      ,      plbtr.producto
      ,      plbtr.Producto_LBTR
      ,      'P' 
      ,      A.CaNumContrato
      ,      B.CaRutCliente
      ,      B.CaCodigo
      ,      A.CaCajMdaM1         
      ,      ABS(SUM(A.CaCajMtoMon1))
      ,      A.CaCajFormaPagoMon1 
      ,      A.CaCajFechaGen      
      ,      A.CaCajFecPago       
      ,      ' '
      ,      'C'
      ,      ' '
      FROM   LnkOpc.CbMdbOpc.dbo.cacaja A                   with (nolock)
             INNER JOIN LnkOpc.CbMdbOpc.dbo.CaEncContrato B with (nolock)  ON A.CaNumContrato = B.CaNumContrato
             INNER JOIN BacParamSuda..PRODUCTO_LBTR plbtr   with (nolock)  ON plbtr.id_sistema = 'OPT' AND plbtr.producto = 'OPT' AND plbtr.movimiento = 'V'
      WHERE  B.CaEstado       = '' -- MAP 04 Nov. 2009 Solo vigentes
      AND    A.CaCajModalidad = 'C'
      AND    A.CaCajMdaM1     = 999   
      AND    A.CaCajFecPago   = @fc_proceso
      AND    A.CaCajFormaPagoMon1 IN(SELECT DISTINCT Codigo_FormaPago FROM BacParamSuda..FPAGO_CANAL with (nolock) )   -- 06 Oct. 2009  Deben enviarse al motor de pagos solo los Contratos con formas de Pago que se encuetren en tabla FPAGO_CANAL
      AND    A.CaCajMtoMon1   < 0
      GROUP BY
             plbtr.id_sistema
      ,      plbtr.producto
      ,      plbtr.Producto_LBTR
      ,      A.CaNumContrato
      ,      B.CaRutCliente
      ,      B.CaCodigo
      ,      A.CaCajMdaM1     
      ,      A.CaCajFormaPagoMon1 
      ,      A.CaCajFechaGen      
      ,      A.CaCajFecPago       


   /*  Recibimos*/ 
    INSERT INTO #TEMP_MDLBTR
    SELECT   @fc_proceso
      ,      plbtr.id_sistema
      ,      plbtr.producto
      ,      plbtr.Producto_LBTR
      ,      'P' 
      ,      A.CaNumContrato
      ,      B.CaRutCliente
      ,      B.CaCodigo
      ,      A.CaCajMdaM1         
      ,      ABS(SUM(A.CaCajMtoMon1))
      ,      A.CaCajFormaPagoMon1 
      ,      A.CaCajFechaGen      
      ,      A.CaCajFecPago       
      ,      ' '
      ,      'A'
      ,      ' '
      FROM   LnkOpc.CbMdbOpc.dbo.cacaja A                   with (nolock)
             INNER JOIN LnkOpc.CbMdbOpc.dbo.CaEncContrato B with (nolock)  ON A.CaNumContrato = B.CaNumContrato
             INNER JOIN BacParamSuda..PRODUCTO_LBTR plbtr   with (nolock)  ON plbtr.id_sistema = 'OPT' AND plbtr.producto = 'OPT' AND plbtr.movimiento = 'V'
      WHERE  B.CaEstado       = '' -- MAP 04 Nov. 2009 Solo vigentes
      AND    A.CaCajModalidad = 'C'
      AND    A.CaCajMdaM1     = 999   
      AND    A.CaCajFecPago   = @fc_proceso
      AND    A.CaCajFormaPagoMon1 IN(SELECT DISTINCT Codigo_FormaPago FROM BacParamSuda..FPAGO_CANAL with (nolock) )   -- 06 Oct. 2009  Deben enviarse al motor de pagos solo los Contratos con formas de Pago que se encuetren en tabla FPAGO_CANAL
      AND    A.CaCajMtoMon1   > 0
      GROUP BY
             plbtr.id_sistema
      ,      plbtr.producto
      ,      plbtr.Producto_LBTR
      ,      A.CaNumContrato
      ,      B.CaRutCliente
      ,      B.CaCodigo
      ,      A.CaCajMdaM1     
      ,      A.CaCajFormaPagoMon1 
      ,      A.CaCajFechaGen      
      ,      A.CaCajFecPago       



     delete MDLBTR 
     where tipo_mercado = 'OPT' 
     and   sistema = 'OPT'
     and   fecha = @fc_proceso
     and   estado_envio = 'P'

 



   /*******************************************************************************************************************/

   --  ** Inserta los movimientos de Renta Fija [ INTERBANCARIOS , PACTOS ] ** --
   /* [Pagamos] */
   --  se sacan operaciones de renta fija para agruparlas por Nro Operacion
   INSERT INTO #TMPBTR
   SELECT mofecpro
   ,      motipoper
   ,      plbtr.Producto_LBTR
   ,      monumoper
   ,      morutcli
   ,      mocodcli
   ,      moforpagi
   ,      momonpact
   ,      momonpact -- momonemi
   ,      'movpresen' = CASE WHEN motipoper = 'CI'  THEN SUM(movpresen)                
		             WHEN motipoper = 'IB'  THEN SUM(movpresen)
		             WHEN motipoper = 'RC'  THEN SUM(movalvenp)
		             WHEN motipoper = 'RCA' THEN SUM(movalvenp)
		        END
   ,      mofecinip
   ,      'fecha_vcto' = @fc_proceso
   ,      ' '
   ,      'C'
   ,      ' ' --> CER Anticipo
   FROM	  BacTraderSuda..MDMO                          with (nolock)
          INNER JOIN BacParamSuda..PRODUCTO_LBTR plbtr with (nolock) ON  plbtr.id_sistema = 'BTR' 
                                                                    AND (plbtr.producto   = motipoper OR plbtr.producto = moinstser)
                                                                    AND  plbtr.Movimiento = 'M'
   WHERE (motipoper         IN('CI','RC','RCA')
      OR  moinstser         =  'ICOL')
   AND    moforpagi         IN(SELECT DISTINCT Codigo_FormaPago FROM FPAGO_CANAL with (nolock) )
   AND    momonpact         <> 13
   AND    mostatreg         <> 'P'
   AND    mofecpro          = @fc_proceso
   GROUP BY mofecpro  , motipoper        , monumoper
   ,        morutcli  , mocodcli	 , moforpagi , moforpagv, momonpact
   ,        mofecinip , plbtr.Producto_LBTR

   --> InterBancario en Dolares(Mov. Icol) -- Agregado 2005 11 14
   INSERT INTO #TMPBTR
   SELECT mofecpro
   ,      motipoper
   ,     'ITF/MX'
   ,      monumoper
   ,      morutcli
   ,      mocodcli
   ,      moforpagi
   ,      momonpact
   ,      momonpact
   ,     'movpresen'  = SUM(movpresen)
   ,      mofecinip
   ,     'fecha_vcto' = @fc_proceso
 ,      ' '
   ,      'C'
   ,      ' ' --> CER Anticipo
   FROM	  BacTraderSuda..MDMO            with (nolock)
   INNER JOIN PRODUCTO_LBTR plbtr with (nolock) ON  plbtr.id_sistema  = 'BTR' 
                                                      AND (plbtr.producto    = motipoper OR plbtr.producto = moinstser)
                                                      AND  plbtr.Movimiento  =  'M'
   WHERE  moinstser         =  'ICOL'
   AND    moforpagi         IN( SELECT DISTINCT Codigo_FormaPago from FPAGO_CANAL with (nolock) )
   AND    momonpact         = 13
   AND    mostatreg        <> 'P'
   AND    mofecpro          = @fc_proceso
   GROUP BY mofecpro  , motipoper        , monumoper
   ,        morutcli  , mocodcli	 , moforpagi , moforpagv, momonpact
   ,        mofecinip , plbtr.Producto_LBTR


   /* [Recibimos] */
--  se sacan operaciones de renta fija para agruparlas por Nro Operacion
   INSERT INTO #TMPBTR
   SELECT mofecpro
   ,      motipoper
   ,      'motipoper' = CASE WHEN motipoper = 'VI'  THEN 'VPAC'
		             WHEN motipoper = 'RV'  THEN 'VPACT'
		             WHEN motipoper = 'RVA' THEN 'VPACT'
		             WHEN motipoper = 'IB'  THEN 'ICAP'
		             ELSE                        motipoper
		        END
   ,      monumoper
   ,      morutcli
   ,      mocodcli
   ,      moforpagi
   ,      momonpact
   ,      momonpact
   ,      'movpresen'  = CASE WHEN motipoper = 'VI'  THEN SUM(movpresen)
		              WHEN motipoper = 'IB'  THEN SUM(movpresen)
                              WHEN motipoper = 'RV'  THEN SUM(movalvenp)
		              WHEN motipoper = 'RVA' THEN SUM(movalvenp)
		        END
   ,      mofecinip
   ,      'fecha_vcto' = @fc_proceso
   ,      ' '
   ,      'A'
   ,      ' '
   FROM	  BacTraderSuda..MDMO with (nolock)
   WHERE (motipoper    IN('VI','RV','RVA')
      OR  moinstser     = 'ICAP')
   AND    moforpagi    IN(SELECT DISTINCT Codigo_FormaPago FROM FPAGO_CANAL with (nolock) )
   AND    mofecpro      = @fc_proceso
   AND    mostatreg    <> 'P'
   AND    momonpact    <> 13
   GROUP BY mofecpro , motipoper , monumoper
   ,        morutcli , mocodcli	 , moforpagi , moforpagv, momonpact
   ,        mofecinip

   /* ** Inserta los movimientos de Renta Fija [ CARTERA PROPIA ] ** */
   /* Pagamos */
   INSERT INTO #TMPBTR
   SELECT (CASE WHEN fecha_pagomañana = mofecpro THEN mofecpro ELSE Fecha_PagoMañana END)
   ,      motipoper	
   ,      plbtr.Producto_LBTR
   ,      monumoper
   ,      morutcli
   ,      mocodcli
   ,      moforpagi
   ,      momonpact
   ,      999
   ,      SUM(movpresen)
   ,      mofecpro
   ,      'fecha_vcto' = @fc_proceso
   ,      CASE WHEN (PagoMañana = 'S' AND Fecha_PagoMañana = @fc_proceso) THEN '*' ELSE '' END
   ,      'C'
   ,      ' '
   FROM	  BacTraderSuda..MDMO                          with (nolock)
          INNER JOIN BacParamSuda..PRODUCTO_LBTR plbtr with (nolock) ON plbtr.id_sistema = 'BTR'
                                                                    AND plbtr.producto   = motipoper
                                                                    AND plbtr.Movimiento = 'M'
                                                                    AND Fecha_PagoMañana = @fc_proceso
   WHERE  motipoper         =  'CP'
   AND    moforpagi        IN( SELECT DISTINCT Codigo_FormaPago from FPAGO_CANAL with (nolock) )
   AND    mostatreg        <>  'P'
   GROUP BY mofecpro , motipoper , monumoper
   ,        morutcli , mocodcli	 , moforpagi , momonpact
   ,        plbtr.Producto_LBTR  , PagoMañana, Fecha_PagoMañana 
   ORDER BY monumoper

   /* Recibimos */
   INSERT INTO #TMPBTR
   SELECT (case when fecha_pagomañana = mofecpro then mofecpro else fecha_pagomañana end  ) 	-- mofecpro	
   ,      motipoper	
   ,      motipoper	
   ,      monumoper	
   ,      morutcli	
   ,      mocodcli	
   ,      moforpagi	
   ,      momonpact	
   ,      999		
   , SUM(movalven)
   ,      mofecpro	
   ,      'fecha_vcto' =  @fc_proceso
   ,      CASE WHEN (PagoMañana ='S' AND Fecha_PagoMañana = @fc_proceso) THEN '*' ELSE '' END	
   ,      'A'
   ,      ' '
   FROM	  BacTraderSuda..MDMO   with (nolock)
   WHERE  motipoper        = 'VP'
   AND    moforpagi       IN(SELECT DISTINCT Codigo_FormaPago from FPAGO_CANAL with (nolock) )	
   AND    mostatreg       <> 'P'
   AND    Fecha_PagoMañana = @fc_proceso 	
   GROUP BY mofecpro , motipoper , monumoper
   ,        morutcli , mocodcli	 , moforpagi , momonpact,PagoMañana, Fecha_PagoMañana
   ORDER BY monumoper

   UPDATE #TMPBTR 
   SET    tipo_mercado = moinstser
   FROM	  #TMPBTR      as a
   ,      VIEW_MDMO    as b
   WHERE  b.monumoper  = a.numero_operacion 
   AND    b.moinstser  IN('ICOL','ICAP')

   /* ** Inserta los movimientos de Renta Fija [ VCTOS. ] ** */
   -- se agregan recompras
   /* Pagamos */
   INSERT INTO #TMPBTR
   SELECT rsfecha
   ,      rsinstser
   ,      CASE WHEN rsmonpact = 999 THEN plbtr.Producto_LBTR
               WHEN rsmonpact = 13  THEN 'ITF/MX'
          END
   ,      rsnumoper
   ,      rsrutcli
   ,      rscodcli
   ,      rsforpagv
   ,      rsmonpact
   ,      rsmonpact
   ,      SUM(rsvppresenx)
   ,      rsfecinip
   ,      'fecha_vcto' = @fc_proceso
   ,      ' '
   ,      'C'
   ,      ' '
   FROM   BacTraderSuda..MDRS            with (nolock) 
          INNER JOIN PRODUCTO_LBTR plbtr with (nolock) ON plbtr.id_sistema = 'BTR'
                                                      AND plbtr.producto   = rsinstser
                                                      AND plbtr.Movimiento = 'V'
   WHERE  rsfecha           = @fc_proceso
   AND    rsinstser         = 'ICAP'
   AND    rstipoper         = 'VC'
   AND    rsforpagv        IN(SELECT DISTINCT Codigo_FormaPago FROM FPAGO_CANAL with (nolock) )
   GROUP BY rsfecha,   rsinstser, rstipoper, rsnumoper
   ,        rsrutcli,  rscodcli,  rsforpagv, rsmonpact
   ,        rsfecinip, plbtr.Producto_LBTR

   /* Recibimos */
   INSERT INTO #TMPBTR
   SELECT rsfecha
   ,      rsinstser
   ,      'rstipoper' = CASE rsinstser WHEN 'ICOL' THEN 'VICOL' END
   ,      rsnumoper
   ,      rsrutcli
   ,      rscodcli
   ,      rsforpagv
   ,      rsmonpact
   ,      rsmonpact
   ,      SUM(rsvppresenx)
   ,      rsfecinip
   ,      'fechavcto' = @fc_proceso
   ,      ' '
   ,      'A'
   ,      ' '
   FROM   BacTraderSuda..MDRS with (nolock) 
   WHERE  rsfecha     = @fc_proceso
   AND    rsinstser   = 'ICOL'
   AND    rstipoper   = 'VC'
   AND    rsforpagv  IN(SELECT DISTINCT Codigo_FormaPago FROM FPAGO_CANAL with (nolock) )
   GROUP BY rsfecha,  rsinstser, rstipoper, rsnumoper
   ,        rsrutcli, rscodcli,  rsforpagv, rsmonpact
   ,        rsfecinip

   /* ** Traspasa operaciones para generar operaciones LBTR ** */
   --  se ingresan a tablas temporal para pasar luego a MDLBTR
   INSERT INTO #TEMP_MDLBTR
   SELECT fecha
   ,      'BTR'
   ,      tipo_mercado
   ,      tipo_operacion
   ,      'P'
   ,      numero_operacion
   ,      rut_cliente
   ,      codigo_cliente  
   ,      CASE WHEN tipo_operacion IN('CI','VI') THEN moneda2
	       ELSE                                   moneda3
          END
   ,      monto_operacion
   ,      forma_pago
   ,      fecha_operacion
   ,      fecha_vencimiento
   ,      liquidada --' '
   ,      tipo_Movimiento
   ,      Anticipo
   FROM	  #TMPBTR

   --   Calcula fecha de Vencimiento   --
   SELECT 'fecha'            = fecha
   ,      'sistema'          = sistema
   ,      'tipo_mercado'     = tipo_mercado
   ,      'tipo_operacion'   = tipo_operacion
   ,      'estado_envio'     = estado_envio
   ,      'numero_operacion' = numero_operacion
   ,      'rut_cliente'      = rut_cliente
   ,      'codigo_cliente'   = codigo_cliente
   ,      'moneda'           = moneda
   ,      'monto_operacion'  = monto_operacion
 ,      'forma_pago'       = forma_pago
   ,      'fecha_operacion'  = fecha_operacion
   ,      'fecha_vencimiento'= fecha_vencimiento
   ,      'liquidada'        = liquidada
   ,      'Tipo_Movimiento'  = Tipo_Movimiento
   ,      'Anticipo'         = Anticipo
   ,      'iDiasValor_i'     = diasvalor
   ,      'iMoneda_i'        = Moneda
   ,      'Correlativo'      = identity(INT)
   INTO   #TEMPORAL_LBTR
   FROM   #TEMP_MDLBTR
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO with (nolock) ON forma_pago = codigo

   CREATE INDEX #ixt_TEMPORAL_LBTR ON #TEMPORAL_LBTR (Correlativo)

   DECLARE @iRegistros  NUMERIC(9)
   ,       @iRegistro   NUMERIC(9)
   ,       @iMoneda     NUMERIC(5)
   ,       @dFechaVcto  DATETIME
   ,       @iDiasVal    INTEGER
   
   SELECT  @iRegistros  = MAX(Correlativo)
   ,       @iRegistro   = MIN(Correlativo)
   FROM    #TEMPORAL_LBTR

   WHILE @iRegistros >= @iRegistro
   BEGIN

      SELECT @iDiasVal   = iDiasValor_i --> diasvalor
      ,      @iMoneda    = iMoneda_i    --> Moneda 
      FROM   #TEMPORAL_LBTR 
         --> LEFT JOIN bacparamsuda..FORMA_DE_PAGO ON forma_pago = codigo
      WHERE  Correlativo = @iRegistro
      
      IF @iMoneda = 13 
      BEGIN
         EXECUTE BacCamSuda..SP_BUSCA_FECHA_HABIL @fc_proceso, @iDiasVal, 225, @dFechaVcto OUTPUT      
      END ELSE 
      BEGIN
         EXECUTE BacTraderSuda..SP_BUSCA_FECHA_HABIL @fc_proceso , @iDiasVal , @dFechaVcto OUTPUT
      END

      UPDATE #TEMPORAL_LBTR
      SET    fecha_vencimiento = @dFechaVcto
      WHERE  Correlativo       = @iRegistro

      SET @iRegistro = @iRegistro + 1
   END

   DELETE #TEMP_MDLBTR

   INSERT INTO #TEMP_MDLBTR
   SELECT fecha
   ,      sistema
   ,      tipo_mercado
   ,      tipo_operacion
   ,      estado_envio
   ,      numero_operacion
   ,      rut_cliente
   ,      codigo_cliente
   ,      moneda
   ,      monto_operacion
   ,      forma_pago
   ,      fecha_operacion
   ,      fecha_vencimiento
   ,      liquidada
   ,      tipo_Movimiento 
   ,      Anticipo
   FROM   #TEMPORAL_LBTR
   --   Calcula fecha de Vencimiento   --

   DELETE #TEMP_MDLBTR
   FROM	  #TEMP_MDLBTR       a
   ,      MDLBTR             b 
   WHERE  a.fecha	     = b.fecha 
   AND    a.sistema          = b.sistema 
   AND    a.tipo_operacion   = b.tipo_operacion
   AND    a.numero_operacion = b.numero_operacion
   AND    a.tipo_Movimiento  = b.tipo_Movimiento
   AND    b.tipo_mercado    <> '10'  

   --> forward bond trades
   DELETE MDLBTR
   FROM	  #TEMP_MDLBTR       a
   ,      MDLBTR             b
   WHERE  a.fecha	     = a.fecha
   AND    a.sistema	     = b.sistema
   AND    a.tipo_operacion   = b.tipo_operacion
   AND    a.numero_operacion = b.numero_operacion
   AND    b.tipo_mercado     = '10'    
   AND    b.estado_envio     = 'P'

   DELETE #TEMP_MDLBTR
   FROM	  #TEMP_MDLBTR       a
   ,      MDLBTR             b
   WHERE  a.fecha	     = a.fecha
   AND    a.sistema	     = b.sistema
   AND    a.tipo_operacion   = b.tipo_operacion
   AND    a.numero_operacion = b.numero_operacion
   AND    b.tipo_mercado     = '10'    
   AND    b.estado_envio     IN('E','A')
   --> forward bond trades

   UPDATE MDLBTR 
   SET    estado_envio      = 'A'
   FROM	  MDLBTR              as a
   ,      BacTraderSuda..MDMO as b
   WHERE  b.monumoper       = a.numero_operacion 
   AND    b.mostatreg       = 'A' 

   UPDATE MDLBTR 
   SET    estado_envio      = 'A'
   FROM	  MDLBTR              as a
   ,      BacCamSuda..MEMO    as b
   WHERE  b.monumope        = a.numero_operacion 
   AND    b.moestatus       = 'A' 

   UPDATE MDLBTR 
   SET    estado_envio      = 'A'
   FROM	  MDLBTR              as a
   ,      BacFwdSuda..MFMO    as b
   WHERE  b.monumoper       = a.numero_operacion 
   AND    b.moestado        = 'A' 

   /* ** Traspasa operaciones para generar operaciones LBTR ** */   
   INSERT INTO MDLBTR
   SELECT 'fecha'             = fecha
   ,      'sistema'           = sistema
   ,      'tipo_mercado'    = tipo_mercado
   ,      'tipo_operacion'    = tipo_operacion
   ,      'estado_envio'      = estado_envio
   ,      'numero_operacion'  = numero_operacion
   ,      'rut_cliente'       = rut_cliente
   ,      'codigo_cliente'    = codigo_cliente
   ,      'moneda'            = moneda
   ,      'monto_operacion'   = monto_operacion
   ,      'forma_pago'        = forma_pago
   ,      'fecha_operacion'   = fecha_operacion
   ,      'fecha_vencimiento' = fecha_vencimiento
   ,      'liquidada'         = liquidada
   ,      'RecRutBanco'       = CASE WHEN cltipcli = 1 THEN clrut           ELSE ISNULL(RutBancoReceptor,0) END
   ,      'RecCodBanco'       = CASE WHEN cltipcli = 1 THEN clcodigo        ELSE ISNULL(CodBancoReceptor,0) END
   ,      'RecCodSwift'       = CASE WHEN cltipcli = 1 THEN UPPER(clswift)  ELSE ' '                        END
   ,      'BenDireccion'      = UPPER(cldirecc)
   ,      'BenCtaCte'	      = CASE WHEN clctacte      = '0' OR clctacte = ' ' THEN ' ' 
                                     WHEN LEN(clctacte) = 0						THEN ' '
                                     ELSE											 UPPER(clctacte)
                                END 
   ,      'tipo_Movimiento'   = tipo_Movimiento
   ,      'Anticipo'          = Anticipo
   ,      'Id_Paquete'        = 0
   ,      'Estado_Paquete'    = 'D'
   ,      'Reservado'         = ''
   ,	  'Secuencia'		  = 1
   FROM   #TEMP_MDLBTR
          INNER JOIN BacParamSuda..CLIENTE with (nolock) ON clrut = rut_cliente AND clcodigo = codigo_cliente
   ORDER BY sistema, numero_operacion

    UPDATE A
       SET RecCodSwift  = SUBSTRING(clswift, 1, 50)
      FROM MDLBTR A 
           INNER JOIN CLIENTE ON clrut = RecRutBanco and clcodigo = RecCodBanco
     WHERE Fecha = @fc_proceso


   --   Completa Swift de Moneda Mx   --
   DECLARE @iContadorMx           INTEGER
   ,       @iRegistrosMx          INTEGER
   ,       @iOperacion            NUMERIC(9)
   ,       @cSistema              CHAR(3)
   ,       @CtaContale            VARCHAR(60)

   DECLARE @BancoReceptor         VARCHAR(50)
   ,       @SwiftReceptor         VARCHAR(50)
   ,       @CtaContable           VARCHAR(50)
   ,       @SwiftIntermediario    VARCHAR(50)
   ,       @BcoIntermediario      VARCHAR(50)
   ,       @CtaCte                VARCHAR(50)
   ,       @SwiftBeneficiario     VARCHAR(50)
   ,       @BcoBeneficiario       VARCHAR(50)
   ,       @DirBeneficiario       VARCHAR(50)
   ,       @CiuBeneficiario       VARCHAR(50)


   DELETE
   FROM    MDLBTR
   WHERE   fecha    = @fc_proceso
   AND    (sistema <> 'BCC' AND moneda <> 999)
   AND    (sistema <> 'GPI' AND sistema <>'FFMM' AND sistema <>'CDB')

   CREATE TABLE #Temporal_MtMx
   (   Columna1   VARCHAR(50)
   ,   Columna2   VARCHAR(50)
   ,   Columna3   VARCHAR(50)
   ,   Columna4   VARCHAR(50)
   )

   DELETE 
   FROM   MDLBTR_MX
   WHERE  BancoReceptor      = ''
   AND    SwiftReceptor      = ''
   AND    CtaContable        = ''
   AND    SwiftIntermediario = ''
   AND    BancoIntermediario = ''
   AND    CtaCte             = ''
   AND    BancoBeneficiario  = ''

   SELECT Sistema
   ,      numero_operacion
   ,      CtaContable      = CASE WHEN morutcli = 96665450 THEN 745 ELSE anula_motivo END
   ,      identity(int)    as Identificador
   INTO   #TmpSwiftMx
   FROM   MDLBTR                     with (nolock)
          LEFT JOIN BacCamSuda..MEMO with (nolock) ON monumope = numero_operacion
   WHERE  moneda           <> 999
   and    fecha             = @fc_proceso
   and    Sistema           = 'BCC'

   INSERT INTO #TmpSwiftMx
   SELECT Sistema
   ,      numero_operacion
   ,      CtaContable       = 745   --> Defecto Wachovia
   FROM   MDLBTR                        with (nolock)
          LEFT JOIN BacTraderSuda..MDMO with (nolock) ON monumopeR = numero_operacion
 WHERE  moneda           <> 999
   and    fecha    = @fc_proceso
 and   Sistema           = 'BTR'

      SET @iContadorMx  = 0
      SET @iRegistrosMx = 0

   SELECT @iRegistrosMx = MAX(Identificador)
   ,      @iContadorMx  = 1
  FROM   #TmpSwiftMx

   WHILE @iRegistrosMx >= @iContadorMx
   BEGIN

      SELECT @iOperacion   = numero_operacion
      ,      @cSistema     = Sistema
      ,      @CtaContale   = CtaContable
      FROM   #TMPSWIFTMX
      WHERE  Identificador = @iContadorMx

      IF NOT EXISTS( SELECT 1 FROM MDLBTR_MX with (nolock) WHERE Sistema = @cSistema AND Operacion = @iOperacion )
      BEGIN
         IF @cSistema = 'BCC'
         BEGIN
            
            EXECUTE BacCamSuda..SP_CARGA_MOVIMIENTO_SWIFT_MOTORPAGOS 
                                        @iOperacion
                              ,         @BancoReceptor          OUTPUT
                              ,         @SwiftReceptor          OUTPUT
                              ,         @CtaContable            OUTPUT
                              ,         @SwiftIntermediario     OUTPUT
                              ,         @BcoIntermediario       OUTPUT
                              ,         @CtaCte                 OUTPUT
                              ,         @SwiftBeneficiario      OUTPUT
                              ,         @BcoBeneficiario        OUTPUT
                              ,         @DirBeneficiario        OUTPUT
                              ,         @CiuBeneficiario        OUTPUT

            IF ( LTRIM(RTRIM(@BancoReceptor))      <> ''
             OR  LTRIM(RTRIM(@SwiftReceptor))      <> ''
             OR  LTRIM(RTRIM(@CtaContable))        <> ''
             OR  LTRIM(RTRIM(@SwiftIntermediario)) <> ''
             OR  LTRIM(RTRIM(@BcoIntermediario))   <> ''
             OR  LTRIM(RTRIM(@BcoBeneficiario))    <> ''
               )
            BEGIN
               IF EXISTS(SELECT 1 FROM BacParamSuda..CORRESPONSAL with (nolock) WHERE codigo_swift = @SwiftReceptor)
               BEGIN
                  SET @BancoReceptor = ( SELECT TOP 1 nombre FROM BacParamSuda..CORRESPONSAL with (nolock) WHERE codigo_swift = @SwiftReceptor ) --> 'CITIUS33'
               END

               INSERT INTO MDLBTR_MX
               SELECT @cSistema
               ,      @iOperacion
               ,      @BancoReceptor
               ,      @SwiftReceptor
               ,      @CtaContable
               ,      ISNULL(@SwiftIntermediario,'')
               ,      ISNULL(@BcoIntermediario,'')
               ,      ISNULL(@CtaCte,'')
               ,      ISNULL(@SwiftBeneficiario,'')
               ,      ISNULL(@BcoBeneficiario,'')
               ,      ISNULL(@DirBeneficiario,'')
               ,      ISNULL(@CiuBeneficiario,'')

            END
         END

         IF NOT EXISTS( SELECT 1 FROM MDLBTR_MX with (nolock) WHERE Sistema = @cSistema AND Operacion = @iOperacion )
         BEGIN
            SET ROWCOUNT 1

            INSERT INTO #Temporal_MtMx ( Columna1 , Columna2 , Columna3 )
            EXECUTE SP_MNT_MDLBTR_MX @iOperacion , @cSistema , 1 , @CtaContale

            SELECT @BancoReceptor = Columna1
            ,      @SwiftReceptor = Columna2
            ,      @CtaContable   = Columna3
            FROM   #Temporal_MtMx
            
            DELETE #Temporal_MtMx
   
            INSERT INTO #Temporal_MtMx ( Columna1 , Columna2 , Columna3 )
            EXECUTE SP_MNT_MDLBTR_MX @iOperacion , @cSistema , 2 , @CtaContale

            SELECT @SwiftIntermediario = Columna1
            ,      @BcoIntermediario   = Columna2
            ,      @CtaCte             = Columna3
            FROM   #Temporal_MtMx            

            DELETE #Temporal_MtMx

            INSERT INTO #Temporal_MtMx ( Columna1 , Columna2 , Columna3 , Columna4 ) 
            EXECUTE SP_MNT_MDLBTR_MX @iOperacion , @cSistema , 3 , @CtaContale

            SELECT @SwiftBeneficiario = Columna1
            ,      @BcoBeneficiario   = Columna2
            ,      @DirBeneficiario   = Columna3
            ,      @CiuBeneficiario   = Columna4
            FROM   #Temporal_MtMx

            DELETE FROM #Temporal_MtMx

            SET ROWCOUNT 0

            INSERT INTO MDLBTR_MX
            SELECT @cSistema
            ,      @iOperacion
            ,      @BancoReceptor
            ,      @SwiftReceptor
            ,      @CtaContable
            ,      @SwiftIntermediario
            ,      @BcoIntermediario
            ,      ISNULL(@CtaCte,'')
            ,      ISNULL(@SwiftBeneficiario,'')
            ,      ISNULL(@BcoBeneficiario,'')
            ,      ISNULL(@DirBeneficiario,'')
            ,      ISNULL(@CiuBeneficiario,'')
         END

      END

      SET @iContadorMx = @iContadorMx + 1
   END
   --   Completa Swift de Moneda Mx   --

   DROP TABLE #Temporal_MtMx

   DELETE FROM MDLBTR_MX
         WHERE BancoReceptor      = ''
           AND SwiftReceptor      = ''
           AND CtaContable        = ''
           AND SwiftIntermediario = ''
           AND BancoIntermediario = ''
           AND CtaCte             = ''
           AND BancoBeneficiario  = ''

END
GO
