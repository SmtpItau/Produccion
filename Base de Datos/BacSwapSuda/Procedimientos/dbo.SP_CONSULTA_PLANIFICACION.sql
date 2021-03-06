USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONSULTA_PLANIFICACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONSULTA_PLANIFICACION]
   (   @FechaDesde     DATETIME = '' 
   ,   @FechaHasta     DATETIME = ''
   )
AS
BEGIN

    SET NOCOUNT ON

   IF @FechaDesde = null or @FechaDesde = ''
	set @FechaDesde = getdate()

   IF @FechaHasta = null or @FechaHasta = ''
	set @FechaHasta = '19000101'

    SELECT FechaCierre = CONVERT(CHAR(10), car.Fecha_Cierre, 103)
      ,    Contrato    = car.numero_operacion
      ,    Producto    = car.tipo_swap
      ,    RutCliente  = car.rut_cliente
      ,    Cliente     = SUBSTRING( cli.clnombre, 1, 35)
      ,    MonedaAct   = mon.mnnemo
      ,    TipoTasaAct = CASE WHEN car.compra_codigo_tasa = 0 THEN 'FIJA' ELSE 'VARIABLE' END
      ,    IndicadorAct= SUBSTRING( tas.tbglosa, 1, 15) --> car.compra_codigo_tasa
      ,    TasaAct     = MIN(car.compra_valor_tasa)
      ,    Nocional    = car.compra_capital
      ,    vRazAct     = SUM(car.Activo_FlujoCLP)
      ,    AvrContrato = SUM(car.Valor_RazonableCLP)
      ,    FechaInicio = CONVERT(CHAR(10), car.Fecha_Inicio, 103)
      ,    FechaTermino= CONVERT(CHAR(10), car.Fecha_Termino, 103)
      ,    AvrOrigen   = SUM(res.Valor_RazonableCLP)
     INTO  #TMP_COMPRAS_SWAP
     FROM  CARTERA                                       car WITH(NOLOCK)
           LEFT JOIN BacParamSuda..CLIENTE               cli WITH(NOLOCK) ON cli.clrut = rut_cliente and cli.clcodigo = codigo_cliente
           LEFT JOIN BacParamSuda..MONEDA                mon WITH(NOLOCK) ON mon.mncodmon = car.compra_moneda
           LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE tas WITH(NOLOCK) ON tas.tbcateg = 1042 AND tas.tbcodigo1 = car.compra_codigo_tasa
           LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE tgd WITH(NOLOCK) ON tgd.TBCATEG = 1041 AND tgd.tbcodigo1 = car.compra_codigo_tasa
           LEFT JOIN CARTERARES                          res WITH(NOLOCK) ON res.Fecha_Proceso    = car.Fecha_Cierre 
                                                                         AND res.numero_operacion = car.numero_operacion
                                                                         AND res.numero_flujo     = car.numero_flujo
                                                                         AND res.tipo_flujo       = car.tipo_flujo
    WHERE  car.Fecha_Cierre BETWEEN @FechaDesde AND @FechaHasta
      AND  car.estado    <> 'C'
      AND  car.tipo_flujo = 1
    GROUP BY car.Fecha_Cierre, car.numero_operacion, car.tipo_swap, car.rut_cliente, cli.clnombre, mon.mnnemo, car.compra_codigo_tasa, tas.tbglosa, car.compra_capital, car.Fecha_Inicio, car.Fecha_Termino
    ORDER BY car.rut_cliente, car.numero_operacion 

    SELECT FechaCierre = CONVERT(CHAR(10), car.Fecha_Cierre, 103)
      ,    Contrato    = car.numero_operacion
      ,    Producto    = car.tipo_swap
      ,    RutCliente  = car.rut_cliente
      ,    Cliente     = SUBSTRING( cli.clnombre, 1, 35)
      ,    MonedaPas   = mon.mnnemo
      ,    TipoTasaPas = CASE WHEN car.venta_codigo_tasa = 0 THEN 'FIJA' ELSE 'VARIABLE' END
      ,    IndicadorPas= SUBSTRING( tas.tbglosa, 1, 15) --> car.venta_codigo_tasa
      ,    TasaPas     = MIN(car.venta_valor_tasa)
      ,    Nocional    = car.venta_capital
      ,    vRazPas     = SUM(car.Pasivo_FlujoCLP)
      ,    AvrContrato = SUM(car.Valor_RazonableCLP)
      ,    FechaInicio = CONVERT(CHAR(10), car.Fecha_Inicio, 103)
      ,    FechaTermino= CONVERT(CHAR(10), car.Fecha_Termino, 103)
      ,    AvrOrigen   = SUM(res.Valor_RazonableCLP)
     INTO  #TMP_VENTAS_SWAP
     FROM  CARTERA                                       car WITH(NOLOCK)
           LEFT JOIN BacParamSuda..CLIENTE               cli WITH(NOLOCK) ON cli.clrut = rut_cliente and cli.clcodigo = codigo_cliente
           LEFT JOIN BacParamSuda..MONEDA                mon WITH(NOLOCK) ON mon.mncodmon = car.venta_moneda
           LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE tas WITH(NOLOCK) ON tas.tbcateg = 1042 AND tas.tbcodigo1 = car.venta_codigo_tasa
           LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE tgd WITH(NOLOCK) ON tgd.TBCATEG = 1041 AND tgd.tbcodigo1 = car.venta_codigo_tasa
           LEFT JOIN CARTERARES                          res WITH(NOLOCK) ON res.Fecha_Proceso    = car.Fecha_Cierre 
                                                                         AND res.numero_operacion = car.numero_operacion
                                                                         AND res.numero_flujo     = car.numero_flujo
                                                                         AND res.tipo_flujo       = car.tipo_flujo
    WHERE  car.Fecha_Cierre BETWEEN @FechaDesde AND @FechaHasta
      AND  car.estado    <> 'C'
      AND  car.tipo_flujo = 2
    GROUP BY car.Fecha_Cierre, car.numero_operacion, car.tipo_swap, car.rut_cliente, cli.clnombre, mon.mnnemo, car.venta_codigo_tasa, tas.tbglosa, car.venta_capital, car.Fecha_Inicio, car.Fecha_Termino
    ORDER BY car.rut_cliente, car.numero_operacion 


   SELECT [FechaCierre]               = com.FechaCierre
      ,   [No. Contrato]              = com.Contrato
      ,   [Producto]                  = CASE WHEN com.Producto = 1 THEN 'SWAP DE TASAS' 
                                             WHEN com.Producto = 2 THEN 'SWAP DE MONEDAS' 
                                             WHEN com.Producto = 4 THEN 'PROMEDIO CAMARA' 
                                             ELSE                       'FRA'
                                        END
      ,   [RutCliente]                = com.RutCliente
      ,   [Cliente]                   = com.Cliente
      ,   [Moneda Activo]             = com.MonedaAct
      ,   [Tipo Tasa Act]             = com.TipoTasaAct
      ,   [Tasa Activo]               = com.IndicadorAct
      ,   [Valor Tasa]                = com.TasaAct
      ,   [Nocional]                  = com.Nocional
      ,   [Moneda Pasivo]             = ven.MonedaPas
      ,   [Tipo Tasa Pas]             = ven.TipoTasaPas
      ,   [Tasa Pasivo]               = ven.IndicadorPas
      ,   [Valor Tasa]                = ven.TasaPas
      ,   [Nocional]                  = ven.Nocional
      ,   [Valor Razonable Activo]    = com.vRazAct
      ,   [Valor Razonable Activo]    = com.vRazAct
      ,   [Valor Razonable Pasivo]    = ven.vRazPas
      ,   [AVR Contrato]              = com.AvrContrato
      ,   [AVR Original del Contrato] = com.AvrOrigen
      ,   [FechaInicio]               = com.FechaInicio
      ,   [FechaTermino]              = com.FechaTermino
   FROM   #TMP_COMPRAS_SWAP          com
          LEFT JOIN #TMP_VENTAS_SWAP ven ON com.Contrato = ven.Contrato


END

GO
