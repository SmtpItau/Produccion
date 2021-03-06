USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GENERA_CNT_MOVIMIENTO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_GENERA_CNT_MOVIMIENTO]
   (   @fecha_hoy   DATETIME   )
AS
BEGIN

   SET NOCOUNT ON
-- Swap: Guardar Como
   SELECT vmvalor , vmcodigo INTO #nValMon FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @fecha_hoy
                      INSERT INTO #nValMon SELECT vmvalor , 13  FROM #nValMon WHERE vmcodigo = 994
                      INSERT INTO #nValMon SELECT 1.0     , 999 FROM #nValMon WHERE vmcodigo = 994

   INSERT INTO BAC_CNT_CONTABILIZA
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   tipo_cliente
   ,   cartera_inversion
   ,   compra_capital
   ,   venta_capital
   ,   venta_capital_Ant
   ,   devengo_utilidad
   ,   devengo_perdida
   ,   Monto_diferido_utilidad
   ,   Monto_diferido_perdida
   ,   Monto_Utilidad_Valoriza
   ,   Monto_Perdida_Valoriza
   ,   Compra_Interes
   ,   Venta_Interes
   ,   compra_moneda
   ,   venta_moneda
   ,   TipOper
   )
   SELECT 'id_sistema'                  = 'PCS'
   ,      'tipo_movimiento'             = 'MOV'
   ,      'tipo_operacion'              = '2C'
   ,      'operacion'                   = c.Numero_Operacion
   ,      'correlativo'                 = c.tipo_flujo
   ,      'codigo_instrumento'          = ''
   ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.Compra_Moneda)
   ,      'tipo_cliente'                = CASE WHEN clpais = 6 THEN '1' ELSE '2' END
   ,      'cartera_inversion'           = c.cartera_inversion
   ,      'compra_capital_200'          = (c.compra_amortiza + c.compra_saldo)
   ,      'venta_capital_201'           = (c.compra_amortiza + c.compra_saldo) * (SELECT vmvalor FROM #nValMon WHERE vmcodigo = c.compra_moneda)
   ,      'venta_capital_Ant_203'       = 0.0
   ,      'devengo_utilidad_204'        = 0.0
   ,      'devengo_perdida_205'         = 0.0
   ,      'Monto_diferido_utilidad_206' = 0.0
   ,      'Monto_diferido_perdida_207'  = 0.0
   ,      'Monto_Utilidad_Valoriza_208' = 0.0
   ,      'Monto_Perdida_Valoriza_209'  = 0.0
   ,      'Compra_Interes_210'          = 0.0
   ,      'Venta_Interes_210'           = 0.0
   ,      'compra_moneda'               = 0.0
   ,      'venta_moneda'                = 0.0
   ,      'TipOper'                     = 'H'
   FROM   CARTERA               c
          INNER JOIN CARTERA    v          ON c.numero_operacion = v.numero_operacion
                                          AND c.numero_flujo     = v.numero_flujo
                                          AND v.tipo_flujo       = 2
          LEFT  JOIN BacParamSuda..CLIENTE ON c.rut_cliente      = clrut
                                          AND c.codigo_cliente   = clcodigo
   WHERE  c.fecha_cierre       <  @fecha_hoy
   AND   (c.fecha_inicio_flujo <= @fecha_hoy AND @fecha_hoy < c.fecha_vence_flujo)
   AND    c.tipo_flujo          = 1
   AND    c.tipo_swap           = 2
   AND    c.Estado              <> 'C'

   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. MOV CCS 1'
      RETURN 1
   END

   INSERT INTO BAC_CNT_CONTABILIZA
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   tipo_cliente
   ,   cartera_inversion
   ,   compra_capital
   ,   venta_capital
   ,   venta_capital_Ant
   ,   devengo_utilidad
   ,   devengo_perdida
   ,   Monto_diferido_utilidad
   ,   Monto_diferido_perdida
   ,   Monto_Utilidad_Valoriza
   ,   Monto_Perdida_Valoriza
   ,   Compra_Interes
   ,   Venta_Interes
   ,   compra_moneda
   ,   venta_moneda
   ,   TipOper
   )
   SELECT 'id_sistema'                  = 'PCS'
   ,      'tipo_movimiento'             = 'MOV'
   ,      'tipo_operacion'              = '2V'
   ,      'operacion'                   = c.Numero_Operacion
   ,      'correlativo'                 = c.tipo_flujo
   ,      'codigo_instrumento'          = ''
   ,      'moneda_instrumento'          = CONVERT(CHAR(03),c.Venta_Moneda)
   ,      'tipo_cliente'                = CASE WHEN clpais = 6 THEN '1' ELSE '2' END
   ,      'cartera_inversion'           = c.cartera_inversion
   ,      'compra_capital_200'          = (c.venta_amortiza + c.venta_saldo)
   ,      'venta_capital_201'           = (c.venta_amortiza + c.venta_saldo) * (SELECT vmvalor FROM #nValMon WHERE vmcodigo = c.Venta_moneda)
   ,      'venta_capital_Ant_203'       = 0.0
   ,      'devengo_utilidad_204'        = 0.0
   ,      'devengo_perdida_205'         = 0.0
   ,      'Monto_diferido_utilidad_206' = 0.0
   ,      'Monto_diferido_perdida_207'  = 0.0
   ,      'Monto_Utilidad_Valoriza_208' = 0.0
   ,      'Monto_Perdida_Valoriza_209'  = 0.0
   ,      'Compra_Interes_210'          = 0.0
   ,      'Venta_Interes_210'           = 0.0
   ,      'compra_moneda'               = 0.0
   ,      'venta_moneda'                = 0.0
   ,      'TipOper'                     = 'H'
   FROM   CARTERA               c
          INNER JOIN CARTERA    v          ON c.numero_operacion = v.numero_operacion
                                          AND c.numero_flujo     = v.numero_flujo
                                          AND v.tipo_flujo       = 2
          LEFT  JOIN BacParamSuda..CLIENTE ON c.rut_cliente      = clrut
                                          AND c.codigo_cliente   = clcodigo
   WHERE  c.fecha_cierre       <  @fecha_hoy
   AND   (c.fecha_inicio_flujo <= @fecha_hoy AND @fecha_hoy < c.fecha_vence_flujo)
   AND    c.tipo_flujo          = 2
   AND    c.tipo_swap           = 2
   AND    c.Estado              <> 'C'

   IF @@ERROR <> 0
   BEGIN
      PRINT 'ERROR_PROC FALLA INICIANDO SWAPS ARCHIVO CONTABILIZA. MOV CCS 2'
      RETURN 1
   END

   INSERT INTO BAC_CNT_CONTABILIZA
   (   id_sistema
   ,   tipo_movimiento
   ,   tipo_operacion
   ,   operacion
   ,   correlativo
   ,   codigo_instrumento
   ,   moneda_instrumento
   ,   tipo_cliente
   ,   cartera_inversion
   ,   compra_capital
   ,   venta_capital
   ,   venta_capital_Ant
   ,   devengo_utilidad
   ,   devengo_perdida
   ,   Monto_diferido_utilidad
   ,   Monto_diferido_perdida
   ,   Monto_Utilidad_Valoriza
   ,   Monto_Perdida_Valoriza
   ,   Compra_Interes
   ,   Venta_Interes
   ,   TipOper
   )
   SELECT 'id_sistema'                  = 'PCS'
   ,      'tipo_movimiento'             = 'MOV'
   ,      'tipo_operacion'              = CONVERT(CHAR(1),c.tipo_swap)
   ,      'operacion'                   = c.Numero_Operacion
   ,      'correlativo'                 = c.Numero_Flujo
   ,      'codigo_instrumento'          = ''
   ,      'moneda_instrumento'          = CASE WHEN c.tipo_swap  = 1 THEN CONVERT(CHAR(03),c.compra_moneda)
                                               WHEN c.tipo_swap  = 4 THEN CONVERT(CHAR(03),c.compra_moneda)
                                               WHEN c.tipo_swap  = 2 THEN CONVERT(CHAR(03),c.compra_moneda)
                                               ELSE                       ''
                                          END
   ,      'tipo_cliente'                = CASE WHEN clpais = 6 THEN '1' ELSE '2' END
   ,      'cartera_inversion'           = c.cartera_inversion

   ,      'compra_capital_200'          = CASE WHEN c.compra_capital     <> 0.0 THEN (c.compra_amortiza + c.compra_saldo)
                                               ELSE                                  (c.venta_amortiza  + c.venta_saldo)
                                          END
   ,      'venta_capital_201'           = CASE WHEN c.compra_capital     <> 0.0 THEN (c.compra_amortiza + c.compra_saldo)
                                               ELSE                                  (c.venta_amortiza  + c.venta_saldo)
                                          END  * (SELECT vmvalor FROM #nValMon WHERE vmcodigo = c.compra_moneda)
   ,      'venta_capital_Ant_203'       = 0.0
   ,      'devengo_utilidad_204'        = 0.0
   ,      'devengo_perdida_205'         = 0.0
   ,      'Monto_diferido_utilidad_206' = 0.0
   ,      'Monto_diferido_perdida_207'  = 0.0
   ,      'Monto_Utilidad_Valoriza_208' = 0.0
   ,      'Monto_Perdida_Valoriza_209'  = 0.0
   ,      'Compra_Interes_210'          = 0.0
   ,      'Venta_Interes_210'           = 0.0
   ,      'TipOper'                     = 'H'
   FROM   CARTERA               c
          INNER JOIN CARTERA    v          ON c.numero_operacion = v.numero_operacion
                                          AND c.numero_flujo     = v.numero_flujo
                                          AND v.tipo_flujo       = 2
          LEFT  JOIN BacParamSuda..CLIENTE ON c.rut_cliente      = clrut
                                          AND c.codigo_cliente   = clcodigo
   WHERE  c.fecha_cierre       <  @fecha_hoy
   AND   (c.fecha_inicio_flujo <= @fecha_hoy AND @fecha_hoy < c.fecha_vence_flujo)
   AND    c.tipo_flujo          = 1
   AND    c.tipo_swap           IN(1,4)
   AND    c.Estado              <> 'C'
END
GO
