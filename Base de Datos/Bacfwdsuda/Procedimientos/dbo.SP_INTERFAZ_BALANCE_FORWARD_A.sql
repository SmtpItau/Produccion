USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_BALANCE_FORWARD_A]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INTERFAZ_BALANCE_FORWARD_A]
   (   @FECHAFINMESHabil  CHAR(8)
   ,   @FECHAFINMES       CHAR(8)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Cuenta            CHAR(20)
   ,       @Tipo_Monto        CHAR(1)
   ,       @Numero_Voucher    NUMERIC(9)
   ,       @Correlativo       NUMERIC(5)
   ,       @Moneda            NUMERIC(5)
   ,       @Monto             FLOAT
   ,       @Operacion         NUMERIC(9)
   ,       @Tipo_Operacion    CHAR(5)
   ,       @Glosa             CHAR(70)
   ,       @Tipo_Voucher      CHAR(1)
   ,       @Numero            NUMERIC(5)
   ,       @x                 INTEGER
   ,       @num_oper          NUMERIC(9)
   ,       @tip_oper          CHAR(1)
   ,       @cod_pro           CHAR(4)
   ,       @T_prod            CHAR(4)
   ,       @max               INTEGER
   ,       @FECHA             DATETIME
   ,       @vDolar_obsFinMes  FLOAT
   ,       @vUF_FinMes        FLOAT
   ,       @cal_monto         FLOAT
   ,       @signo             CHAR(1)
   ,       @T_monto           CHAR(1) 
   ,       @cMoneda           NUMERIC(5)
   ,       @TIP               CHAR(1)

   SELECT  @FECHA = acfecante -- acfecproc 
   FROM    MFAC

   SELECT @vDolar_obsFinMes = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 994 AND vmfecha = @FECHAFINMESHabil),0)
   SELECT @vUF_FinMes       = ISNULL((SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmcodigo = 998 AND vmfecha = @FECHA),0)

   SELECT vmptacmp 
   ,      mnrefusd 
   ,      mncodmon 
   ,      vmvalor
   INTO   #tipocambio
   FROM   VIEW_VALOR_MONEDA 
   ,      VIEW_MONEDA
   WHERE  vmcodigo = mncodmon 
   AND    vmfecha  = @FECHAFINMESHabil

   CREATE TABLE #TEMP_INTERFAZ
   (   T_Producto           CHAR(4)
   ,   Producto             CHAR(4)
   ,   Nro_Operacion        VARCHAR(20)
   ,   Fecha_Contable       DATETIME
   ,   Cuenta               CHAR(20)
   ,   Indicador            CHAR(1)
   ,   Cod_Evento_Cble      CHAR(3)
   ,   S_B_Mda_Origin       CHAR(1)
   ,   B_Mda_Original       FLOAT
   ,   S_B_Mda_Local        CHAR(1)
   ,   B_Mda_Local          FLOAT
   ,   S_B_Local_Agregdo    CHAR(1)
   ,   B_Local_Agregdo      FLOAT
   ,   C_Moneda             NUMERIC(2)
   )

   -->   ( 0 ) Movimientos
   INSERT INTO #TEMP_INTERFAZ
   SELECT 'T_Producto'           = 'MD01'
   ,      'Producto'             = 'MDIR'
   ,      'Nro_Operacion'        = c.canumoper
   ,      'Fecha_Contable'       = @fecha
   ,      'Cuenta'               = LTRIM(RTRIM(P.codigo_cuenta)) + '0000000'
   ,      'Indicador'            = 'D'
   ,      'Cod_Evento_Cble'      = '0'
   ,      'S_B_Mda_Origin'       = '+'
   ,      'B_Mda_Original'       = ABS(c.camtomon1)
   ,      'S_B_Mda_Local'        = '+'
   ,      'B_Mda_Local'          = ABS(c.caclpmoneda1)
   ,      'S_B_Local_Agregdo'    = '+'
   ,      'B_Local_Agregdo'      = 0
   ,      'C_Moneda'             = CASE WHEN c.cacodpos1 = 10 and c.cacodmon1 = 998 THEN '00'
                                        ELSE m.mncodfox
                                   END
   FROM   MFCARES c
          INNER JOIN VOUCHER_CNT                      d ON c.canumoper      = d.operacion
          INNER JOIN BacParamSuda..PERFIL_CNT         n ON n.Folio_Perfil   = d.Folio_Perfil AND n.tipo_movimiento = 'MOV'
          INNER JOIN BacParamSuda..PERFIL_DETALLE_CNT p ON p.Folio_Perfil   = d.Folio_Perfil
          INNER JOIN DETALLE_VOUCHER_CNT              l ON d.Numero_Voucher = l.Numero_Voucher AND l.Cuenta = p.codigo_cuenta
          INNER JOIN BacParamSuda..MONEDA             m ON m.mncodmon       = l.Moneda
   WHERE  c.CaFechaProceso         = @fecha
   AND    c.cafecha                = @fecha
   AND    d.Fecha_Ingreso          = @fecha
   AND    n.tipo_movimiento        = 'MOV'
   AND    p.tipo_movimiento_cuenta = 'D'
   AND    p.codigo_campo           = CASE WHEN c.cacodpos1 IN(3,10) THEN 301 ELSE 300 END
   AND    l.Tipo_Monto             = 'D'

   -->   ( 1 ) Devengos
   INSERT INTO #TEMP_INTERFAZ
   SELECT 'T_Producto'             = 'MD01'
   ,      'Producto'               = 'MDIR'
   ,      'Nro_Operacion'          = c.canumoper
   ,      'Fecha_Contable'         = @fecha
   ,      'Cuenta'                 = LTRIM(RTRIM(P.codigo_cuenta)) + '0000000'
   ,      'Indicador'              = CASE WHEN c.fres_obtenido >= 0 THEN 'D' ELSE 'C' END
   ,      'Cod_Evento_Cble'        = '0'
   ,      'S_B_Mda_Origin'         = '+'
   ,      'B_Mda_Original'         = ABS(ROUND(c.fres_obtenido,0))
   ,      'S_B_Mda_Local'          = '+'
   ,      'B_Mda_Local'            = ABS(ROUND(c.fres_obtenido,0))
   ,      'S_B_Local_Agregdo'      = '+'
   ,      'B_Local_Agregdo'        = 0
   ,      'C_Moneda'               = CASE WHEN c.cacodpos1 = 10 and c.cacodmon1 = 998 THEN '00'
                                          ELSE m.mncodfox
                                     END
   FROM   MFCARES c
          INNER JOIN VOUCHER_CNT                      d ON c.canumoper      = d.operacion
          INNER JOIN BacParamSuda..PERFIL_CNT         n ON n.Folio_Perfil   = d.Folio_Perfil
          INNER JOIN BacParamSuda..PERFIL_DETALLE_CNT p ON p.Folio_Perfil   = d.Folio_Perfil
          INNER JOIN DETALLE_VOUCHER_CNT              l ON d.Numero_Voucher = l.Numero_Voucher AND l.Cuenta = p.codigo_cuenta
          INNER JOIN BacParamSuda..MONEDA             m ON m.mncodmon       = l.Moneda
   WHERE  c.CaFechaProceso         = @fecha
   AND    c.cafecvcto              > @fecha
   AND    d.Fecha_Ingreso          = @fecha
   AND    n.tipo_movimiento        = 'DEV'
   AND    p.codigo_campo           = CASE WHEN c.fres_obtenido >= 0 THEN 304 ELSE 305 END
   AND    p.tipo_movimiento_cuenta = CASE WHEN c.fres_obtenido >= 0 THEN 'D' ELSE 'H' END
   AND    l.Tipo_Monto             = CASE WHEN c.fres_obtenido >= 0 THEN 'D' ELSE 'H' END

   -->   ( 2 ) Devengos
   INSERT INTO #TEMP_INTERFAZ
   SELECT 'T_Producto'             = 'MD01'
   ,      'Producto'               = 'MDIR'
   ,      'Nro_Operacion'          = c.canumoper
   ,      'Fecha_Contable'         = @fecha
   ,      'Cuenta'                 = LTRIM(RTRIM(l.codigo_cuenta)) + '0000000'
   ,      'Indicador'              = CASE WHEN l.tipo_movimiento_cuenta = 'D' THEN 'D' ELSE 'C' END
   ,      'Cod_Evento_Cble'        = '0'
   ,      'S_B_Mda_Origin'         = '+'
   ,      'B_Mda_Original'         = ABS(Monto)
   ,      'S_B_Mda_Local'          = '+'
   ,      'B_Mda_Local'            = ABS(Monto)
   ,      'S_B_Local_Agregdo'      = '+'
   ,      'B_Local_Agregdo'        = 0
   ,      'C_Moneda'               = CASE WHEN c.cacodpos1 = 10 and c.cacodmon1 = 998 THEN '00'
                                          ELSE m.mncodfox
                                     END
   FROM  MFCARES c
         INNER JOIN VOUCHER_CNT                      v ON c.canumoper      = v.operacion
         INNER JOIN DETALLE_VOUCHER_CNT              d ON v.Numero_Voucher = d.Numero_Voucher
         INNER JOIN BacParamSuda..PERFIL_CNT         p ON v.Folio_Perfil   = p.Folio_Perfil
         INNER JOIN BacParamSuda..PERFIL_DETALLE_CNT l ON p.Folio_Perfil   = l.Folio_Perfil AND d.cuenta = l.codigo_cuenta AND d.Tipo_Monto = l.tipo_movimiento_cuenta
         INNER JOIN BacParamSuda..MONEDA             m ON m.mncodmon       = d.Moneda
   WHERE c.CaFechaProceso         = @fecha
   AND    v.Fecha_Ingreso          = @fecha
   AND   c.cafecvcto              > @fecha
   AND   l.codigo_campo           IN(311,301)
   ORDER BY d.Numero_Voucher , d.Correlativo

/*
   SELECT 'CaNumOper'             = canumoper
   ,      'CaCodPos1'             = caCodPos1
   ,      'Fecha_Contable'        = ' ' -- @fecha
   ,      'TipoOperacion'         = ltrim( rtrim( CaCodPos1 ) ) + ltrim( rtrim( CaTipOper ) )
   ,      'MontoMO'               = ABS(CaMtoMon1)
-- ,      'MontoML'               = ABS(CaMtoMon1) * (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = @fecha and VmCodigo =  case when CaCodMon1 = 13 then 994 else CaCodMon1 end )
   ,      'MontoML'               = ABS(CaMtoMon1) * (SELECT vmvalor FROM VIEW_VALOR_MONEDA WHERE vmfecha = @FECHAFINMESHabil and VmCodigo =  case when CaCodMon1 = 13 then 994 else CaCodMon1 end )
   ,      'cacodmon1'             = cacodmon1
   ,      'cacodmon2'             = cacodmon2 
   INTO   #CarNoReajustable            
   FROM   MFCARES
   WHERE  CaFechaProceso         =  @fecha
   AND    cafecha                <  @fecha                  -- Envio de Nocionales suscritos en fechas anteriores a la de proceso
   AND    cacodmon1              <> 998                     -- Las UF llegan a través de los vouchers
   AND    cafecvcto              >  @fecha                  -- Nunca se envían los forwards vencidos

   INSERT INTO #TEMP_INTERFAZ      --> Por mienras hasta que estemos listos, hay que decomentar
   SELECT DISTINCT  
          'T_Producto'             = 'MD01'
   ,      'Producto'               = 'MDIR'
   ,      'Nro_Operacion'          = c.canumoper
   ,      'Fecha_Contable'         = @fecha
   ,      'Cuenta'                 = LTRIM(RTRIM(l.codigo_cuenta)) + '0000000'
   ,      'Indicador'              = CASE WHEN l.tipo_movimiento_cuenta = 'D' THEN 'D' ELSE 'C' END
   ,      'Cod_Evento_Cble'        = '0'
   ,      'S_B_Mda_Origin'         = '+'
   ,      'B_Mda_Original'         = ABS(MontoMO)
   ,      'S_B_Mda_Local'          = '+'
   ,      'B_Mda_Local'            = ABS(round(MontoML,0))
   ,      'S_B_Local_Agregdo'      = '+'
   ,      'B_Local_Agregdo'        = 0
   ,      'C_Moneda'               = CASE WHEN c.cacodpos1 = 10 and c.cacodmon1 = 998 THEN '00'
                                          ELSE m.mncodfox
                                     END
   FROM   #CarNoReajustable                c 
   ,      BacParamSuda..PERFIL_CNT         p
   ,      BacParamSuda..PERFIL_DETALLE_CNT l 
   ,      BacParamSuda..MONEDA             m
   WHERE  p.id_sistema            = 'BFW'
   AND    p.tipo_movimiento       = 'MOV'
   AND    p.tipo_operacion        = c.TipoOperacion  
   AND    p.Codigo_instrumento    = c.cacodmon2
   AND    p.Folio_Perfil          = l.Folio_Perfil
   AND    m.mncodmon              = c.cacodmon1
   AND    l.codigo_campo          = 300 
   AND   (( CONVERT(NUMERIC(9),SUBSTRING(L.Codigo_cuenta,1,2))  = 99  AND l.tipo_movimiento_cuenta = 'H' )
       OR ( CONVERT(NUMERIC(9),SUBSTRING(L.Codigo_cuenta,1,2))  = 98  AND l.tipo_movimiento_cuenta = 'D' )
         )
*/

   SELECT @MAX = COUNT(*) 
   FROM   #TEMP_INTERFAZ

   SELECT @MAX
   ,      T_Producto
   ,      Producto
   ,      Nro_Operacion
   ,      Fecha_Contable
   ,      Cuenta
   ,      Indicador
   ,      Cod_Evento_Cble
   ,      S_B_Mda_Origin
   ,      B_Mda_Original
   ,      S_B_Mda_Local
   ,      B_Mda_Local
   ,      S_B_Local_Agregdo
   ,      B_Local_Agregdo
   ,      C_Moneda
   FROM   #temp_interfaz 
   ORDER BY Nro_Operacion

END
GO
