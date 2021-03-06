USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[GENERA_LIQUIDACION]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[GENERA_LIQUIDACION]
   (   @Numero_Operacion    NUMERIC(9)
   ,   @FechaProceso        DATETIME
   )
AS

BEGIN
   -- MAP 20080418
   -- 1. Se corrigen los dias de la semana en palabras.
   -- 2. Se emite reporte para dias anteriores a las de proceso.No se permitirá emitir reporte proeyctado.
   -- 3. La fecha de búsqueda de flujos será la fecha de liquidación.
   -- GENERA_LIQUIDACION 427 , '20090203'   
   SET NOCOUNT ON

   DECLARE @EstadoTasa       VARCHAR(50)
   DECLARE @EstadoActTasaVar INTEGER

   SELECT  @EstadoTasa       = CASE WHEN devengo = 0 THEN 'Tasa ICP No Actualizada'
                                    WHEN devengo = 1 THEN 'Tasa ICP Actualizada'
                               END
   ,       @EstadoActTasaVar = ActTasaVarVcto
  
   FROM    SWAPGENERAL

   SELECT vmfecha , vmcodigo , vmvalor INTO #Valor_Moneda
   FROM   BacParamSuda..VALOR_MONEDA  WHERE vmfecha = @FechaProceso
   
   INSERT INTO #Valor_Moneda SELECT @FechaProceso , 999 , 1.0
   INSERT INTO #Valor_Moneda SELECT vmfecha       , 13  , vmvalor 
   FROM   #VALOR_MONEDA
   WHERE  vmcodigo = 994

   DECLARE @FlujoAdicionalActivo float
   select  @FlujoAdicionalActivo = 0 --560.23
   DECLARE @FlujoAdicionalPasivo float
   select  @FlujoAdicionalPasivo = 0 --565.08

   select * 
into #Informe from cartera  where fechaliquidacion >= @FechaProceso and numero_operacion = @Numero_Operacion 
   union
   select *
 from carterahis  where fechaliquidacion >= @FechaProceso and numero_operacion = @Numero_Operacion

   

   DECLARE @iTipoSwap        INTEGER
   SELECT  @iTipoSwap        = Tipo_Swap
   FROM    #Informe           WITH (NOLOCK) 
   WHERE   numero_operacion  = @Numero_Operacion

   SELECT DISTINCT
          'Entidad'           = LTRIM(RTRIM(nombre))
   ,      'Cliente'           = clnombre
   ,      'FlujoMonedaPago'   = CONVERT(NUMERIC(21,4),0)
   ,      'MonedaFinalPago'   = CONVERT(CHAR(3),'---')
   ,      'ValorMonedaPago'   = CONVERT(NUMERIC(21,4),0)
   ,      'FormaPago'         = CONVERT(CHAR(25),'---')
   ,      'AFavordeCliente'   = CONVERT(CHAR(1),'-')
   ,      'TipoProducto'      = c.Tipo_Swap
   ,      'EstadoICP'         = CASE WHEN c.Tipo_Swap = 4 THEN @EstadoTasa ELSE @EstadoTasa END
   ,      'MaxFlujoCompra'    = (SELECT MAX(fc.Numero_Flujo) FROM #Informe fc WHERE  fc.Tipo_Flujo = 1 )
   ,      'MaxFlujoVenta'     = (SELECT MAX(fv.Numero_Flujo) FROM #Informe fv WHERE  fv.Tipo_Flujo = 2 )
   ,      'FechaCierre'       = CASE WHEN DATEPART(dw,c.Fecha_Cierre) = 2 THEN 'Lunes. '
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 3 THEN 'Martes. '
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 4 THEN 'Miércoles. '
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 5 THEN 'Jueves. '
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 6 THEN 'Viernes. '
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 7 THEN 'Sábado. '
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 1 THEN 'Domingo. '
                                END
                              + ' ' + LTRIM(RTRIM(DATEPART(DAY,c.Fecha_Cierre)))
                              + ' de '
                              + CASE WHEN DATEPART(MONTH,c.Fecha_Cierre) = 1  THEN 'Enero '
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 2  THEN 'Febrero '
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 3  THEN 'Marzo '
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 4  THEN 'Abril '
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 5  THEN 'Mayo '
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 6  THEN 'Junio '
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 7  THEN 'Julio '
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 8  THEN 'Agosto '
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 9  THEN 'Septiembre '
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 10 THEN 'Octubre '
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 11 THEN 'Noviembre '
                                     WHEN DATEPART(MONTH,c.Fecha_Cierre) = 12 THEN 'Diciembre '
                                 END
                             +   ' del ' + LTRIM(RTRIM(DATEPART(YEAR,c.Fecha_Cierre)))
   ,     Intercprinc
   ,     Modalidad_Pago 
   INTO   #GENERAL
   FROM   #Informe  c
          LEFT JOIN BacParamSuda..CLIENTE WITH (NOLOCK) ON clrut = c.rut_cliente AND clcodigo = c.codigo_cliente
   ,      SWAPGENERAL WITH (NOLOCK)
   WHERE  c.Numero_Operacion   = @Numero_Operacion
   AND    @FechaProceso        = c.FechaLiquidacion 

   SELECT 'iOperacion'        = c.Numero_Operacion
   ,      'iFlujo'            = c.Numero_Flujo
   ,      'iMoneda'           = c.Compra_Moneda
   ,      'cNemoMonOpe'       = mon.mnnemo
   ,      'iMonedaPago'       = c.Recibimos_Moneda
   ,      'cNemoMonPag'       = pag.mnnemo
   ,      'iFormaPago'        = c.Recibimos_Documento
   ,      'cGlosaDocumento'   = fpa.glosa
   ,      'vCapitalInicial'   = c.Compra_Saldo + c.Compra_Amortiza
   ,      'vCapitalVigente'   = c.Compra_Saldo
   ,      'dFechaInicio'      = c.Fecha_Inicio_Flujo
   ,      'dFechaVctoFlujo'   = c.Fecha_Vence_Flujo 
   ,      'iPlazo'            = DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)
   ,      'iTasa'             = c.Compra_Codigo_Tasa
   ,      'vValorTasa'        = c.Compra_Valor_Tasa
   ,      'cGlosaTasa'        = ISNULL(t.tbglosa,'')
   ,      'iBase'             = c.Compra_Base
   ,      'cGlosaBase'        = ISNULL(b.glosa,'')
   ,      'vInteres'          = CASE WHEN @iTipoSwap = 3   THEN c.Compra_interes / ( 1 + DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)/ 360.0 * compra_mercado_tasa / 100.0 )
                                     WHEN Estado     = 'N' THEN c.Recibimos_Monto -- MAP 20071227 Anticipo
                                     ELSE                       c.Compra_Interes 
                                END
   ,      'vAmortizacion'     = c.Compra_Amortiza
   ,      'vFlujoAdicional'   = c.Compra_Flujo_Adicional
   ,      'vFlujo'            = (    --c.Compra_Amortiza * c.intercprinc +  -- Amortizacion según valor Booleano MAP 20090211
                                     --c.Compra_Flujo_Adicional          +  -- Flujo Adicional MAP 20090211
                                     CASE 
                                       -- Monto Para FRA
                                       WHEN @iTipoSwap = 3   THEN c.Compra_interes / ( 1 + DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)/ 360.0 * compra_mercado_tasa / 100.0 )
                                       -- Monto Para Anticipo
                                       WHEN c.Estado   = 'N' THEN c.Recibimos_Monto  
                                       -- Monto de interes 
                                       ELSE c.Compra_Interes 
                                            + c.Compra_Amortiza * c.intercprinc   -- Amortizacion según valor MAP 20090211
                                            + c.Compra_Flujo_Adicional            -- Flujo Adicional MAP 20090211
                                      END
                                 )    -- Se convierte si no es anticipo y las monedas son distintas
                                 * ( CASE WHEN estado <> 'N' THEN   ( case when c.Recibimos_Moneda <> compra_moneda 
                                                                              then  ISNULL( vmv.vmvalor, 0.0 ) 
                                                                              else 1 end ) 
                                                                  / ( case when c.Recibimos_Moneda <> compra_moneda and  vmvPago.vmvalor <> 0
                                                                               then ISNULL( vmvPago.vmvalor, 0.0 ) 
                                                                               else 1 end )
                    ELSE 1.0 END
                                    )


   ,      'MsgActualizacion'  = CASE WHEN t.nemo <> 'S' THEN ' '
                                     ELSE 'Tasa ' + CONVERT(CHAR(08),t.tbglosa) + CASE WHEN @EstadoActTasaVar = 1 THEN ' Actualizada.' ELSE ' No Actualizada' END + ' (Mon. Rel. ' + ltrim(rtrim(mon.mnnemo)) + ')'
                                END
   ,      'bMarca'            = '-'
   ,      'Spread'            = c.compra_spread
   INTO   #LiquidaciónCompra
   FROM   #Informe                                       c 
          LEFT JOIN BASE                                b ON b.Codigo     = c.Compra_Base
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE t ON t.tbcateg    = 1042 AND t.tbcodigo1 = c.Compra_Codigo_Tasa
          LEFT JOIN BacParamSuda..MONEDA              mon ON mon.mncodmon = c.Compra_Moneda
          LEFT JOIN BacParamSuda..MONEDA              pag ON pag.mncodmon = c.Recibimos_Moneda
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO       fpa ON fpa.codigo   = c.Recibimos_Documento
          LEFT JOIN #Valor_Moneda                     vmv ON vmv.vmcodigo = c.Compra_Moneda 
          LEFT JOIN #Valor_Moneda                     vmvPago ON vmvPago.vmcodigo = c.Recibimos_Moneda
   WHERE  c.Numero_Operacion  = @Numero_Operacion
   AND    @FechaProceso       = c.FechaLiquidacion 
   AND    c.Tipo_Flujo        = 1


   SELECT 'iOperacion'        = c.Numero_Operacion
   ,      'iFlujo'            = c.Numero_Flujo
   ,      'iMoneda'           = c.Venta_Moneda
   ,      'cNemoMonOpe'       = mon.mnnemo
   ,      'iMonedaPago'       = c.Pagamos_Moneda
   ,      'cNemoMonPag'       = pag.mnnemo
   ,      'iFormaPago'        = c.Pagamos_Documento
   ,      'cGlosaDocumento'   = fpa.glosa
   ,      'vCapitalInicial'   = c.Venta_Saldo + c.Venta_Amortiza
   ,      'vCapitalVigente'   = c.Venta_Saldo 
   ,      'dFechaInicio'      = c.Fecha_Inicio_Flujo
   ,      'dFechaVctoFlujo'   = c.Fecha_Vence_Flujo 
   ,      'iPlazo'            = DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)
   ,      'iTasa'             = c.Venta_Codigo_Tasa
   ,      'vValorTasa'        = c.Venta_Valor_Tasa
   ,      'cGlosaTasa'        = ISNULL(t.tbglosa,'')
   ,      'iBase'             = c.Venta_Base
   ,      'cGlosaBase'        = ISNULL(b.glosa,'')
   ,      'vInteres'          = CASE WHEN @iTipoSwap = 3   THEN c.Venta_interes / ( 1 + DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)/ 360.0 * Venta_mercado_tasa / 100.0 )  
                                     WHEN Estado     = 'N' THEN 0.0 -- MAP 20071227 Anticipo
                                     ELSE                       c.Venta_Interes 
                                END
   ,      'vAmortizacion'     = c.Venta_Amortiza
   ,      'vFlujoAdicional'   = c.Venta_Flujo_Adicional
   ,      'vFlujo'            = ( --c.Venta_Amortiza * c.intercprinc +  -- Amortizacion según valor Booleando MAP 20090211
                                  --c.Venta_Flujo_Adicional          +  -- Flujo Adicional MAP 20090211
                                  CASE 
                                  -- Monto Para FRA
                                  WHEN @iTipoSwap = 3   THEN c.Venta_interes / ( 1 + DATEDIFF(DAY,c.Fecha_Inicio_Flujo,c.Fecha_Vence_Flujo)/ 360.0 * Venta_mercado_tasa / 100.0 ) 
                                  -- Monto Para Anticipo
                                  WHEN c.Estado   = 'N' THEN 0.0  
                                  -- Monto de interes
                                  ELSE c.Venta_Interes 
                                            + c.Venta_Amortiza * c.intercprinc   -- Amortizacion según valor MAP 20090211
                       + c.Venta_Flujo_Adicional            -- Flujo Adicional MAP 20090211
                                END )
                                -- Se convierte si las monedas son distintas, si es anticipo el valor ya viene en cero 
                                * ( case when c.Pagamos_Moneda <> c.venta_moneda 
                                              then  ISNULL( vmv.vmvalor, 0.0 ) 
                                              else 1.0 end )
                                  / ( case when c.Pagamos_Moneda <> c.venta_moneda and  vmvPago.vmvalor <> 0
                                              then  isnull( vmvPago.vmvalor, 0.0 ) 
                                              else 1.0 end )      

   ,      'MsgActualizacion'  = CASE WHEN t.nemo <> 'S' THEN ' '
                                     ELSE 'Tasa ' + CONVERT(CHAR(08),t.tbglosa) + CASE WHEN @EstadoActTasaVar = 1 THEN ' Actualizada.' ELSE ' No Actualizada' END + ' (Mon. Rel. ' + ltrim(rtrim(mon.mnnemo)) + ')'
                                END
   ,      'bMarca'            = '-'
   ,      'Spread'            = c.venta_spread
   INTO   #LiquidaciónVenta
   FROM   #Informe                                       c
          LEFT JOIN BASE                                b ON b.Codigo  = c.Venta_Base
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE t ON t.tbcateg = 1042 AND t.tbcodigo1 = c.Venta_Codigo_Tasa
          LEFT JOIN BacParamSuda..MONEDA              mon ON mon.mncodmon = c.Venta_Moneda
          LEFT JOIN BacParamSuda..MONEDA              pag ON pag.mncodmon = c.Pagamos_Moneda
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO       fpa ON fpa.codigo   = c.Pagamos_Documento
          LEFT JOIN #Valor_Moneda                     vmv ON vmv.vmcodigo = c.Venta_Moneda
          LEFT JOIN #Valor_Moneda                     vmvPago ON vmvPago.vmcodigo = c.Pagamos_Moneda

   WHERE  c.Numero_Operacion  = @Numero_Operacion
   AND    @FechaProceso       = c.FechaLiquidacion 
   AND    c.Tipo_Flujo        = 2



   UPDATE #LiquidaciónCompra
   SET    bMarca                       = 'x'
   FROM   #LiquidaciónVenta
   WHERE  #LiquidaciónVenta.iOperacion = #LiquidaciónCompra.iOperacion

   UPDATE #LiquidaciónVenta
   SET    bMarca                       = 'x'
   FROM   #LiquidaciónCompra
   WHERE  #LiquidaciónVenta.iOperacion = #LiquidaciónCompra.iOperacion          

   UPDATE #GENERAL
   SET    FlujoMonedaPago   = (c.vFlujo - v.vFlujo) 
   ,      MonedaFinalPago   = CASE WHEN c.vFlujo >= v.vFlujo THEN c.cNemoMonPag     ELSE v.cNemoMonPag     END
   ,      ValorMonedaPago   = ISNULL(vmv.vmvalor,0.0)
   ,      FormaPago         = CASE WHEN c.vFlujo >= v.vFlujo THEN c.cGlosaDocumento ELSE v.cGlosaDocumento END
   ,      AFavordeCliente   = CASE WHEN c.vFlujo >= v.vFlujo THEN 'E'               ELSE 'C'               END
   FROM   #LiquidaciónCompra           c
          INNER JOIN #LiquidaciónVenta v ON v.iOperacion = c.iOperacion          
          LEFT  JOIN #Valor_Moneda   vmv ON vmv.vmcodigo = CASE WHEN c.vFlujo >= v.vFlujo THEN c.iMonedaPago ELSE v.iMonedaPago END
   WHERE  c.bMarca          = 'x'

   UPDATE #GENERAL
   SET    FlujoMonedaPago   = c.vFlujo 
   ,      MonedaFinalPago   = c.cNemoMonPag
   ,      ValorMonedaPago   = ISNULL(vmv.vmvalor,0.0)
   ,      FormaPago         = c.cGlosaDocumento
   ,      AFavordeCliente   = 'E'
   FROM   #LiquidaciónCompra           c
          LEFT  JOIN #Valor_Moneda   vmv ON vmv.vmcodigo = c.iMonedaPago
   WHERE  c.bMarca          = '-'

   UPDATE #GENERAL
   SET    FlujoMonedaPago   = v.vFlujo 
   ,      MonedaFinalPago   = v.cNemoMonPag
   ,      ValorMonedaPago   = ISNULL(vmv.vmvalor,0.0)
   ,      FormaPago         = v.cGlosaDocumento
   ,      AFavordeCliente   = 'C'
   FROM   #LiquidaciónVenta            v
          LEFT  JOIN #Valor_Moneda   vmv ON vmv.vmcodigo = v.iMonedaPago
   WHERE  v.bMarca          = '-'
   
   SELECT 'C_NumOper'        = ISNULL((SELECT ISNULL(c.iOperacion,0)           FROM #LiquidaciónCompra   c ),0)
   ,      'C_NumFlujo'       = ISNULL((SELECT ISNULL(c.iFlujo,0)               FROM #LiquidaciónCompra   c ),0)
   ,      'C_MonOper'        = ISNULL((SELECT ISNULL(c.cNemoMonOpe,'')         FROM #LiquidaciónCompra   c ),'')
   ,      'C_MonPago'        = ISNULL((SELECT ISNULL(c.cNemoMonPag,'')         FROM #LiquidaciónCompra   c ),'')
   ,      'C_FPago'          = ISNULL((SELECT ISNULL(c.cGlosaDocumento,'')     FROM #LiquidaciónCompra   c ),'')
   ,      'C_CapitalIni'     = ISNULL((SELECT ISNULL(c.vCapitalInicial,0.0)    FROM #LiquidaciónCompra   c ),0.0)
   ,      'C_CapitalVig'     = ISNULL((SELECT ISNULL(c.vCapitalVigente,0.0)    FROM #LiquidaciónCompra   c ),0.0)
   ,      'C_FecIni'         = ISNULL((SELECT ISNULL(c.dFechaInicio,'')        FROM #LiquidaciónCompra   c ),'')
   ,      'C_FecVcto'        = ISNULL((SELECT ISNULL(c.dFechaVctoFlujo,'')     FROM #LiquidaciónCompra   c ),'')
   ,      'C_Plazo'          = ISNULL((SELECT ISNULL(c.iPlazo,0)               FROM #LiquidaciónCompra   c ),0.0)
   ,      'C_ValorTasa'      = ISNULL((SELECT ISNULL(c.vValorTasa,0.0)         FROM #LiquidaciónCompra   c ),0.0)
   ,      'C_GlosaTasa'      = ISNULL((SELECT ISNULL(c.cGlosaTasa,'')          FROM #LiquidaciónCompra   c ),'')
   ,      'C_GlosaBase'      = ISNULL((SELECT ISNULL(c.cGlosaBase,'')          FROM #LiquidaciónCompra   c ),'')
   ,      'C_Interes'        = ISNULL((SELECT ISNULL(c.vInteres,0.0)           FROM #LiquidaciónCompra   c ),0.0)
   ,      'C_Amortiza'       = ISNULL((SELECT ISNULL(c.vAmortizacion,0.0)      FROM #LiquidaciónCompra   c ),0.0)
   ,      'C_Flujo'          = ISNULL((SELECT ISNULL(c.vFlujo,0.0)             FROM #LiquidaciónCompra   c ),0.0)
   ,      'C_MsgTVar'        = ISNULL((SELECT ISNULL(c.MsgActualizacion,'')    FROM #LiquidaciónCompra   c ),'')

   ,      'V_NumOper'        = ISNULL((SELECT ISNULL(v.iOperacion,0)           FROM #LiquidaciónVenta    v ),0)
   ,      'V_NumFlujo'       = ISNULL((SELECT ISNULL(v.iFlujo,0)               FROM #LiquidaciónVenta    v ),0)
   ,      'V_MonOper'        = ISNULL((SELECT ISNULL(v.cNemoMonOpe,'')         FROM #LiquidaciónVenta    v ),'')
   ,      'V_MonPago'        = ISNULL((SELECT ISNULL(v.cNemoMonPag,'')         FROM #LiquidaciónVenta    v ),'')
   ,      'V_FPago'          = ISNULL((SELECT ISNULL(v.cGlosaDocumento,'')     FROM #LiquidaciónVenta    v ),'')
   ,      'V_CapitalIni'     = ISNULL((SELECT ISNULL(v.vCapitalInicial,0.0)    FROM #LiquidaciónVenta    v ),0.0)
   ,      'V_CapitalVig'     = ISNULL((SELECT ISNULL(v.vCapitalVigente,0.0)    FROM #LiquidaciónVenta    v ),0.0)
   ,      'V_FecIni'         = ISNULL((SELECT ISNULL(v.dFechaInicio,'')        FROM #LiquidaciónVenta    v ),'')
   ,      'V_FecVcto'        = ISNULL((SELECT ISNULL(v.dFechaVctoFlujo,'')     FROM #LiquidaciónVenta    v ),'')
   ,      'V_Plazo'          = ISNULL((SELECT ISNULL(v.iPlazo,0)               FROM #LiquidaciónVenta    v ),0.0)
   ,      'V_ValorTasa'      = ISNULL((SELECT ISNULL(v.vValorTasa,0.0)         FROM #LiquidaciónVenta    v ),0.0)
   ,      'V_GlosaTasa'      = ISNULL((SELECT ISNULL(v.cGlosaTasa,'')          FROM #LiquidaciónVenta    v ),'')
   ,      'V_GlosaBase'      = ISNULL((SELECT ISNULL(v.cGlosaBase,'')          FROM #LiquidaciónVenta    v ),'')
   ,      'V_Interes'        = ISNULL((SELECT ISNULL(v.vInteres,0.0)           FROM #LiquidaciónVenta    v ),0.0)
   ,      'V_Amortiza'       = ISNULL((SELECT ISNULL(v.vAmortizacion,0.0)      FROM #LiquidaciónVenta    v ),0.0)
   ,      'V_Flujo'          = ISNULL((SELECT ISNULL(v.vFlujo,0.0)             FROM #LiquidaciónVenta    v ),0.0)
   ,      'V_MsgTVar'        = ISNULL((SELECT ISNULL(v.MsgActualizacion,'')    FROM #LiquidaciónVenta    v ),'')

   ,      'G_Entidad'        = g.Entidad
   ,      'G_Cliente'        = g.Cliente
   ,      'G_FlujMonPago'    = ABS(g.FlujoMonedaPago)
   ,      'G_MonFinPago'     = g.MonedaFinalPago
   ,      'G_ValMonPago'     = g.ValorMonedaPago
   ,      'G_FPago'          = g.FormaPago
   ,      'G_Favor'          = g.AFavordeCliente
   ,      'G_TipoProducto'   = g.TipoProducto
   ,      'G_EstadoICP'      = g.EstadoICP
   ,      'Ciudad'           = 'Santiago, '
   ,      'Fecha'            = CASE WHEN DATEPART(dw,@FechaProceso) = 2 THEN 'Lunes. '  -- MAP 20080405
                                    WHEN DATEPART(dw,@FechaProceso) = 3 THEN 'Martes. '
                                    WHEN DATEPART(dw,@FechaProceso) = 4 THEN 'Miércoles. '
                                    WHEN DATEPART(dw,@FechaProceso) = 5 THEN 'Jueves. '
                                    WHEN DATEPART(dw,@FechaProceso) = 6 THEN 'Viernes. '
                                    WHEN DATEPART(dw,@FechaProceso) = 7 THEN 'Sábado. '
                                    WHEN DATEPART(dw,@FechaProceso) = 1 THEN 'Domingo. '
                                END
                             +  LTRIM(RTRIM(DATEPART(DAY,@FechaProceso)))
                             +  ' de '
                             +  CASE WHEN DATEPART(MONTH,@FechaProceso) = 1  THEN 'Enero '
                                     WHEN DATEPART(MONTH,@FechaProceso) = 2  THEN 'Febrero '
                                     WHEN DATEPART(MONTH,@FechaProceso) = 3  THEN 'Marzo '
                                     WHEN DATEPART(MONTH,@FechaProceso) = 4  THEN 'Abril '
                                     WHEN DATEPART(MONTH,@FechaProceso) = 5  THEN 'Mayo '
                                     WHEN DATEPART(MONTH,@FechaProceso) = 6  THEN 'Junio '
                                     WHEN DATEPART(MONTH,@FechaProceso) = 7  THEN 'Julio '
                                     WHEN DATEPART(MONTH,@FechaProceso) = 8  THEN 'Agosto '
                                     WHEN DATEPART(MONTH,@FechaProceso) = 9  THEN 'Septiembre '
                                     WHEN DATEPART(MONTH,@FechaProceso) = 10 THEN 'Octubre '
                                     WHEN DATEPART(MONTH,@FechaProceso) = 11 THEN 'Noviembre '
                                     WHEN DATEPART(MONTH,@FechaProceso) = 12 THEN 'Diciembre '
                                END
                             +   ' del ' + LTRIM(RTRIM(DATEPART(YEAR,@FechaProceso)))
   ,      'G_MaxFlujoCom'    = MaxFlujoCompra
   ,      'G_MaxFlujoVta'    = MaxFlujoVenta
   ,      'G_FechaCierre'    = FechaCierre
   ,      'G_GlosaMonPago'   = pag.mnglosa
   ,      'Anticipo'         = 'N'
   ,      'AntTotalParcial'  = 'N/A      '
   ,      'C_Spread'         = ISNULL((SELECT ISNULL(c.Spread, 0.0) FROM #LiquidaciónCompra c), 0.0)
   ,      'V_Spread'         = ISNULL((SELECT ISNULL(v.Spread, 0.0) FROM #LiquidaciónVenta  v), 0.0)
   ,      'C_flujoAdicional' = ISNULL((SELECT ISNULL(c.vFlujoAdicional, 0.0) FROM #LiquidaciónCompra c), 0.0)
   ,      'V_flujoAdicional' = ISNULL((SELECT ISNULL(v.vFlujoAdicional, 0.0) FROM #LiquidaciónVenta  v), 0.0)

   ,      intercprinc
   ,      modalidad_Pago

   INTO   #RETORNO
   FROM   #GENERAL           g
          LEFT JOIN BacParamSuda..MONEDA pag ON pag.mnnemo = g.MonedaFinalPago 

   UPDATE #RETORNO
   SET    G_ValMonPago = vmvalor
   FROM   #Valor_Moneda
   WHERE  ltrim(rtrim(G_MonFinPago)) = 'CLP'
   AND    ltrim(rtrim(G_Favor))      = 'C'
   AND    ltrim(rtrim(C_MonOper))    = 'UF'
   AND     vmcodigo                  = 998

   UPDATE #RETORNO
   SET    G_ValMonPago = vmvalor 
   FROM   #Valor_Moneda
   WHERE  ltrim(rtrim(G_MonFinPago)) = 'CLP'
   AND    ltrim(rtrim(G_Favor))      = 'E'
   AND    ltrim(rtrim(V_MonOper))    = 'UF'
   AND    vmcodigo             = 998

   UPDATE #retorno
      SET Anticipo        = isnull( ( select max('S')       from #Informe c where  c.Estado = 'N' ) , 'N' )
        , AntTotalParcial = isnull( ( select max('PARCIAL') from #Informe c where  c.Estado <> 'N') , 'TOTAL' )

   SELECT #RETORNO.*   
   ,      'mnglosa' = rtrim( mnglosa ) + case when G_TipoProducto = '3' then 
                    ' (T. Desc:' + rtrim( convert( char(8) , ( select max(compra_mercado_tasa) from #Informe  ) ) )+ ')'
                    else ' ' end
   FROM   #RETORNO
          LEFT JOIN BacParamSuda..MONEDA ON mnnemo = CASE WHEN G_Favor = 'C' THEN (CASE WHEN C_MonOper = '' THEN V_MonOper ELSE C_MonOper END)
                                                          ELSE            (CASE WHEN V_MonOper = '' THEN C_MonOper ELSE V_MonOper END)
                                                     END
END

GO
