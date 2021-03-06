USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_BALANCE_FORWARD]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_BALANCE_FORWARD]
   (   @fechafinmeshabil  CHAR(8)
   ,   @fechafinmes       CHAR(8)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   DATETIME
    SELECT @dFechaProceso   = acfecproc 
      FROM BacFwdSuda..MFAC with(Nolock)

   SET @fechafinmeshabil = @dFechaProceso --> fuerza el uso de la Fecha de Proceso

   SELECT vmcodigo, vmfecha, vmvalor INTO #VM FROM VIEW_VALOR_MONEDA with (nolock) WHERE vmfecha = @dFechaProceso AND vmcodigo not in(999,998)
   INSERT INTO #VM SELECT  999, @dFechaProceso,  1.0 
   INSERT INTO #VM SELECT  998, @dFechaProceso, 1.0 

   SELECT vmcodigo      = Codigo_Moneda
   ,      vmfecha       = Fecha
   ,      vmvalor       = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock)
   WHERE  Fecha         = @dFechaProceso
   AND    Codigo_Moneda NOT IN(998,999)

   INSERT INTO #VALOR_TC_CONTABLE
        SELECT 999 , @dFechaProceso , 1.0

   CREATE TABLE #Cartera
   (   canumoper                NUMERIC(9)
   ,   cafecha                  DATETIME
   ,   cafecvcto                DATETIME
   ,   camtomon1                NUMERIC(21,4)
   ,   camtomon2                NUMERIC(21,4)
   ,   fres_obtenido            NUMERIC(21,4)
   ,   caclpmoneda1             NUMERIC(21,4)
   ,   cacodigo                 NUMERIC(9)
   ,   cacodcli                 INT
   ,   cacodmon1                INT
   ,   cacodmon2                INT
   ,   catipoper                CHAR(1)
   ,   cafpagomn                INT
   ,   catipmoda                CHAR(1)
   ,   cacartera_normativa      CHAR(5)
   ,   casubcartera_normativa   CHAR(5)
   )

   INSERT INTO #Cartera
   SELECT canumoper
   ,      cafecha
   ,      cafecvcto
   ,      camtomon1
   ,      camtomon2
   ,      fres_obtenido
   ,      caclpmoneda1
   ,      cacodigo
   ,      cacodcli
   ,      cacodmon1
   ,      cacodmon2
   ,      catipoper
   ,      cafpagomn
   ,      catipmoda
   ,      cacartera_normativa
   ,      casubcartera_normativa
   FROM   BacFwdSuda..MFCA with (nolock) 
   WHERE  cafecvcto      > @dFechaProceso

   CREATE TABLE #InterfazBalanceFwd
   (   Documento   NUMERIC(9)
   ,   Correlativo NUMERIC(9)
   ,   Producto    VARCHAR(5)
   ,   Fecha       DATETIME
   ,   Cuenta      VARCHAR(20)
   ,   Movimiento  CHAR(1)
   ,   Monto       NUMERIC(21,4)
   ,   Moneda      INT
   ,   Campo       INT
   ,   Nocional    NUMERIC(21,4)
   ,   Conversion  NUMERIC(21,4)
   ,   FechaInicio DATETIME
   ,   NumVoucher  NUMERIC(9)
   ,   Validacion  CHAR(1)
   )

   CREATE INDEX #_ippo_InterfazBalanceFwd ON #InterfazBalanceFwd (Documento, Cuenta, Moneda, Fecha, FechaInicio, Validacion)

   --> (1.0) Vouchers del Día de Hoy
   INSERT INTO #InterfazBalanceFwd
   SELECT Documento   = vh.operacion
   ,      Correlativo = vd.correlativo
   ,      Producto    = vh.tipo_operacion
   ,      Fecha       = vh.fecha_ingreso 
   ,      Cuenta      = vd.cuenta
   ,      Movimiento  = vd.tipo_monto
   ,      Monto       = vd.monto
   ,      Moneda      = vd.moneda
   ,      Campo       = 0 --> pd.codigo_campo
   ,      Nocional    = ca.camtomon1
   ,      Conversion  = ca.camtomon2
   ,      FechaInicio = CASE WHEN ca.cafecha < vh.fecha_ingreso THEN ca.cafecha ELSE vh.fecha_ingreso END
   ,      NumVoucher  = vd.numero_voucher
   ,      Validacion  = CASE WHEN vd.cuenta = P.cuenta THEN '1' ELSE '0' END
   FROM   #Cartera                                            ca 
          INNER JOIN BacFwdSuda..VOUCHER_CNT_BALANCE          vh with (nolock) ON ca.canumoper      = vh.operacion    AND ca.cafecvcto   > vh.fecha_ingreso
          INNER JOIN BacFwdSuda..DETALLE_VOUCHER_CNT_BALANCE  vd with (nolock) ON vd.numero_voucher = vh.numero_voucher
          INNER JOIN BacParamSuda..PLAN_DE_CUENTA             pc with (nolock) ON pc.cuenta         = vd.Cuenta
          LEFT  JOIN BacFwdSuda..DETALLE_VOUCHER_CNT           P with (nolock) ON vd.numero_voucher = P.numero_voucher AND vd.correlativo = P.correlativo
   WHERE  vh.fecha_ingreso = @dFechaProceso
   AND    pc.tipo_cuenta   IN('ACT','PAS')
   AND    vd.tipo_monto    = CASE WHEN pc.tipo_cuenta = 'ACT' THEN 'D' ELSE 'H' END
   ORDER BY vh.operacion , vh.tipo_operacion , vd.correlativo , vh.fecha_ingreso

   DELETE  I
   FROM    #InterfazBalanceFwd I
           INNER JOIN #InterfazBalanceFwd P ON P.Documento = I.Documento AND P.Cuenta = I.Cuenta AND P.Moneda = I.Moneda AND P.Validacion <> I.Validacion
   WHERE  (I.Fecha > I.FechaInicio AND I.Validacion = 0)

   DECLARE @iRegistros  NUMERIC(9)
   SET     @iRegistros  = ( SELECT COUNT(1) FROM #InterfazBalanceFwd )

   SELECT 'Registros'            = @iRegistros
   ,      'T_Producto'           = 'MD01'
   ,      'Producto'             = 'MDIR'
   ,      'Nro_Operacion'        = Documento
   ,      'Fecha_Contable'       = Fecha
   ,      'Cuenta'               = LTRIM(RTRIM( Cuenta )) + '0000000'
   ,      'Indicador'            = CASE WHEN Movimiento = 'D' THEN 'D' ELSE 'C' END
   ,      'Cod_Evento_Cble'      = '0'
   ,      'S_B_Mda_Origin'       = '+'
   ,      'B_Mda_Original'       = ABS( Monto )
   ,      'S_B_Mda_Local'        = '+'
   ,      'B_Mda_Local'          = CASE WHEN Moneda <> 999 THEN round( ABS(Monto) * ISNULL(vmvalor,0.0), 0 ) ELSE round(ABS(Monto), 0) END 
   ,      'S_B_Local_Agregdo'    = '+'
   ,      'B_Local_Agregdo'      = 0
   ,      'C_Moneda'             = mncodfox
   INTO   #tmp_grupo_balance
   FROM   #InterfazBalanceFwd
          LEFT JOIN BacParamSuda..MONEDA with(nolock) ON mncodmon = Moneda
          LEFT JOIN #VALOR_TC_CONTABLE                ON vmcodigo = CASE WHEN Moneda = 13 THEN 994 ELSE Moneda END
 ORDER BY FechaInicio, Documento, Producto, Correlativo

   SELECT Registros         = Registros
      ,   T_Producto        = T_Producto
      ,   Producto          = Producto
      ,   Nro_Operacion     = Nro_Operacion
      ,   Fecha_Contable    = Fecha_Contable
      ,   Cuenta            = Cuenta
      ,   Indicador         = Indicador
      ,   Cod_Evento_Cble   = Cod_Evento_Cble
      ,   S_B_Mda_Origin    = S_B_Mda_Origin
      ,   B_Mda_Original    = SUM( B_Mda_Original )
      ,   S_B_Mda_Local     = S_B_Mda_Local
      ,   B_Mda_Local       = SUM( B_Mda_Local )
      ,   S_B_Local_Agregdo = S_B_Local_Agregdo
      ,   B_Local_Agregdo   = B_Local_Agregdo
      ,   C_Moneda          = C_Moneda
  FROM   #tmp_grupo_balance
  GROUP BY Registros
      ,    T_Producto
      ,    Producto
      ,    Nro_Operacion
      ,    Fecha_Contable
      ,    Cuenta
      ,    Indicador
      ,    Cod_Evento_Cble
      ,    S_B_Mda_Origin
      ,    S_B_Mda_Local
      ,    S_B_Local_Agregdo
      ,    B_Local_Agregdo
      ,    C_Moneda
  ORDER BY Fecha_Contable, Producto, Nro_Operacion, Indicador, Cuenta

   DROP TABLE #Cartera
   DROP TABLE #InterfazBalanceFwd

END

GO
