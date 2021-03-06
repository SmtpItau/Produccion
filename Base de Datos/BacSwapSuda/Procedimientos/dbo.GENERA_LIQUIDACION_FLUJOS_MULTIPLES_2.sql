USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[GENERA_LIQUIDACION_FLUJOS_MULTIPLES_2]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- GENERA_LIQUIDACION_FLUJOS_MULTIPLES_2 479, '20080619','20080619'

CREATE PROCEDURE [dbo].[GENERA_LIQUIDACION_FLUJOS_MULTIPLES_2]
   (   @Numero_Operacion    NUMERIC(9)
   ,   @FechaDesde          DATETIME
   ,   @FechaHasta          DATETIME
   )
AS

BEGIN
   -- MAP 20080418
   -- 1. Se corrigen los dias de la semana en palabras.
   -- 2. Se emite reporte para dias anteriores a las de proceso.No se permitirá emitir reporte proeyctado.
   -- 3. La fecha de búsqueda de flujos será la fecha de liquidación.
   -- GENERA_LIQUIDACION_FLUJOS_MULTIPLES_MAP 0 , '20080915', '20080916'   
   -- GENERA_LIQUIDACION_FLUJOS_MULTIPLES 0 , '20080915', '20080916'
   -- GENERA_LIQUIDACION_FLUJOS_MULTIPLES 0 , '20080909', '20080909'
   -- GENERA_LIQUIDACION_FLUJOS_MULTIPLES 0 , '20080909', '20080909'
   SET NOCOUNT ON

   DECLARE @EstadoTasa       VARCHAR(50)
   DECLARE @EstadoActTasaVar INTEGER
   DECLARE @FechaProceso     DATETIME


   SELECT  @EstadoTasa       = CASE WHEN devengo = 0 THEN 'Tasa ICP No Actualizada'
                                    WHEN devengo = 1 THEN 'Tasa ICP Actualizada'
                               END
   ,       @EstadoActTasaVar = ActTasaVarVcto
   ,       @FechaProceso     = fechaproc
  
   FROM    SWAPGENERAL

   SELECT vmfecha , vmcodigo , vmvalor INTO #Valor_Moneda
   FROM   BacParamSuda..VALOR_MONEDA  WHERE vmfecha between @FechaDesde and @FechaHasta
   
   INSERT INTO #Valor_Moneda SELECT vmfecha , 999 , 1.0
   FROM  #VALOR_MONEDA where vmcodigo = 998

   INSERT INTO #Valor_Moneda SELECT vmfecha       , 13  , vmvalor 
   FROM   #VALOR_MONEDA
   WHERE  vmcodigo = 994


   DECLARE @FlujoAdicionalActivo float
   select  @FlujoAdicionalActivo = 0 --560.23
   DECLARE @FlujoAdicionalPasivo float
   select  @FlujoAdicionalPasivo = 0 --565.08

   select 
numero_operacioN
,numero_flujo
,tipo_flujo
,rut_cliente
,codigo_cliente
,fecha_cierre
,modalidad_pago
,Compra_Moneda
,Recibimos_Moneda
,Recibimos_Documento
,Compra_Saldo 
,Compra_Amortiza
,Fecha_Inicio_Flujo
,Fecha_Vence_Flujo 
,Compra_Codigo_Tasa
,Compra_Valor_Tasa
,Compra_Base
,Compra_interes 
,compra_mercado_tasa 
,Recibimos_Monto 
,Estado   
,intercprinc   
,Compra_Flujo_Adicional
,compra_spread
,FechaLiquidacion
,TIPO_SWAP
,Pagamos_Documento
,Pagamos_Moneda
,Venta_Amortiza
,Venta_Base
,Venta_Codigo_Tasa
,Venta_Flujo_Adicional
,Venta_Interes
,Venta_mercado_tasa
,Venta_Moneda
,Venta_Saldo
,venta_spread
,Venta_Valor_Tasa

   into #Informe 
   from cartera  
   where numero_operacion = @Numero_Operacion or  @Numero_Operacion = 0 
     and FechaLiquidacion BETWEEN  @FechaDesde and  @Fechahasta

-- SELECT * FROM #Informe 

INSERT INTO #Informe 
   select 
numero_operacioN
,numero_flujo
,tipo_flujo
,rut_cliente
,codigo_cliente
,fecha_cierre
,modalidad_pago
,Compra_Moneda
,Recibimos_Moneda
,Recibimos_Documento
,Compra_Saldo 
,Compra_Amortiza
,Fecha_Inicio_Flujo
,Fecha_Vence_Flujo 
,Compra_Codigo_Tasa
,Compra_Valor_Tasa
,Compra_Base
,Compra_interes 
,compra_mercado_tasa 
,Recibimos_Monto 
,Estado   
,intercprinc   
,Compra_Flujo_Adicional
,compra_spread
,FechaLiquidacion
,TIPO_SWAP
,Pagamos_Documento
,Pagamos_Moneda
,Venta_Amortiza
,Venta_Base
,Venta_Codigo_Tasa
,Venta_Flujo_Adicional
,Venta_Interes
,Venta_mercado_tasa
,Venta_Moneda
,Venta_Saldo
,venta_spread
,Venta_Valor_Tasa

--   from carterahis  
   from carteraRES
   where numero_operacion = @Numero_Operacion or  @Numero_Operacion = 0 
     AND FECHA_PROCESO = @FechaDesde 
     and FechaLiquidacion BETWEEN  @FechaDesde and  @Fechahasta 
  

   DECLARE @iTipoSwap        INTEGER
   SELECT  @iTipoSwap        = Tipo_Swap
   FROM    #Informe           WITH (NOLOCK) 


   SELECT DISTINCT
          'Entidad'           = LTRIM(RTRIM(nombre))
   ,      'Cliente'           = clnombre
   ,      'RutCliente'        = CONVERT(CHAR(12),REPLICATE(' ', 10 - LEN(LTRIM(RTRIM(c.Rut_Cliente)))) + LTRIM(RTRIM(c.Rut_Cliente)) + '-' + LTRIM(RTRIM(c.codigo_cliente))) 
   ,      'FlujoMonedaPago'   = CONVERT(NUMERIC(21,4),0)
   ,      'MonedaFinalPago'   = CONVERT(CHAR(3),'---')
   ,      'ValorMonedaPago'   = CONVERT(NUMERIC(21,4),0)
   ,      'FormaPago'         = CONVERT(CHAR(25),'---')
   ,      'AFavordeCliente'   = CONVERT(CHAR(1),'-')
   ,      'TipoProducto'      = c.Tipo_Swap
   ,      'EstadoICP'         = CASE WHEN c.Tipo_Swap = 4 THEN @EstadoTasa ELSE @EstadoTasa END
   ,      'MaxFlujoCompra'    = (SELECT MAX(fc.Numero_Flujo) FROM #Informe fc WHERE  fc.Tipo_Flujo = 1 )
   ,      'MaxFlujoVenta'     = (SELECT MAX(fv.Numero_Flujo) FROM #Informe fv WHERE  fv.Tipo_Flujo = 2 )
   ,      'FechaCierre'       = CASE WHEN DATEPART(dw,c.Fecha_Cierre) = 2 THEN 'Lunes '
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 3 THEN 'Martes '
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 4 THEN 'Miércoles '
                            WHEN DATEPART(dw,c.Fecha_Cierre) = 5 THEN 'Jueves '
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 6 THEN 'Viernes '
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 7 THEN 'Sábado '
                                     WHEN DATEPART(dw,c.Fecha_Cierre) = 1 THEN 'Domingo '
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
   ,     Modalidad_Pago 
   ,     numero_operacion = c.numero_operacion
   INTO   #GENERAL
   FROM   #Informe  c
          LEFT JOIN BacParamSuda..CLIENTE WITH (NOLOCK) ON clrut = c.rut_cliente AND clcodigo = c.codigo_cliente
   ,      SWAPGENERAL WITH (NOLOCK)
   WHERE  FechaLiquidacion BETWEEN  @FechaDesde and  @Fechahasta


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
   ,      'vFlujo'            = (  --  c.Compra_Amortiza * c.intercprinc +  -- Amortizacion según valor Booleano MAP 20090211
                                   --  c.Compra_Flujo_Adicional          +  -- Flujo Adicional			 MAP 20090211
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
                                         else 1.0 end ) 
          / ( case when c.Recibimos_Moneda <> compra_moneda and  vmvPago.vmvalor <> 0
                                then ISNULL( vmvPago.vmvalor, 0.0 ) 
   else 1.0 end )
                    ELSE 1.0 END
                         )


   ,      'MsgActualizacion'  = CASE WHEN t.nemo <> 'S' THEN ' '
                                     ELSE 'Tasa ' + CONVERT(CHAR(08),t.tbglosa) + CASE WHEN @EstadoActTasaVar = 1 THEN ' Actualizada.' ELSE ' No Actualizada' END + ' (Mon. Rel. ' + ltrim(rtrim(mon.mnnemo)) + ')'
                                END
   ,      'bMarca'            = '-'
   ,      'Spread'            = c.compra_spread
   ,	  'TipoFlujo'         = c.Tipo_Flujo
   ,      'IntercambioNoc'    = c.IntercPrinc
   ,      'FechaLiquidacion'  = c.FechaLiquidacion
   INTO   #LiquidaciónCompra
   FROM   #Informe                                       c 
          LEFT JOIN BASE                                b ON b.Codigo     = c.Compra_Base
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE t ON t.tbcateg    = 1042 AND t.tbcodigo1 = c.Compra_Codigo_Tasa
          LEFT JOIN BacParamSuda..MONEDA              mon ON mon.mncodmon = c.Compra_Moneda
          LEFT JOIN BacParamSuda..MONEDA              pag ON pag.mncodmon = c.Recibimos_Moneda
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO       fpa ON fpa.codigo   = c.Recibimos_Documento
          LEFT JOIN #Valor_Moneda                     vmv ON vmv.vmcodigo = c.Compra_Moneda and vmv.vmfecha = c.fechaliquidacion 
          LEFT JOIN #Valor_Moneda                     vmvPago ON vmvPago.vmcodigo = c.Recibimos_Moneda and vmvPago.vmfecha = c.fechaliquidacion 
   WHERE  c.Tipo_Flujo        = 1
   and    c.FechaLiquidacion BETWEEN  @FechaDesde and  @Fechahasta



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
   ,      'vFlujo'            = ( -- c.Venta_Amortiza * c.intercprinc +  -- Amortizacion según valor Booleando  MAP 20090211
                                  -- c.Venta_Flujo_Adicional          +  -- Flujo Adicional			MAP 20090211
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
   ,	  'TipoFlujo'         = c.Tipo_Flujo
   ,      'IntercambioNoc'    = c.IntercPrinc
   ,      'FechaLiquidacion'  = c.FechaLiquidacion
   INTO   #LiquidaciónVenta
   FROM   #Informe                                       c
          LEFT JOIN BASE                                b ON b.Codigo  = c.Venta_Base
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE t ON t.tbcateg = 1042 AND t.tbcodigo1 = c.Venta_Codigo_Tasa
          LEFT JOIN BacParamSuda..MONEDA              mon ON mon.mncodmon = c.Venta_Moneda
          LEFT JOIN BacParamSuda..MONEDA              pag ON pag.mncodmon = c.Pagamos_Moneda
          LEFT JOIN BacParamSuda..FORMA_DE_PAGO       fpa ON fpa.codigo   = c.Pagamos_Documento
          LEFT JOIN #Valor_Moneda                     vmv ON vmv.vmcodigo = c.Venta_Moneda and vmv.vmfecha = c.fechaliquidacion 
          LEFT JOIN #Valor_Moneda                     vmvPago ON vmvPago.vmcodigo = c.Pagamos_Moneda and vmvPago.vmfecha = c.fechaliquidacion 

   WHERE c.Tipo_Flujo        = 2
   and   c.FechaLiquidacion BETWEEN  @FechaDesde and  @Fechahasta


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
          LEFT  JOIN #Valor_Moneda   vmv ON vmv.vmcodigo = CASE WHEN c.vFlujo >= v.vFlujo THEN c.iMonedaPago ELSE v.iMonedaPago END and vmv.vmfecha = c.fechaliquidacion 
   WHERE  c.bMarca          = 'x'



   UPDATE #GENERAL
   SET    FlujoMonedaPago   = c.vFlujo 
   ,      MonedaFinalPago   = c.cNemoMonPag
   ,      ValorMonedaPago   = ISNULL(vmv.vmvalor,0.0)
   ,      FormaPago         = c.cGlosaDocumento
   ,      AFavordeCliente   = 'E'
   FROM   #LiquidaciónCompra           c
          LEFT  JOIN #Valor_Moneda   vmv ON vmv.vmcodigo = c.iMonedaPago and vmv.vmfecha = c.fechaliquidacion 
   WHERE  c.bMarca          = '-'



   UPDATE #GENERAL
   SET    FlujoMonedaPago   = v.vFlujo 
   ,      MonedaFinalPago   = v.cNemoMonPag
   ,      ValorMonedaPago   = ISNULL(vmv.vmvalor,0.0)
   ,      FormaPago         = v.cGlosaDocumento
   ,      AFavordeCliente   = 'C'
   FROM   #LiquidaciónVenta            v
          LEFT  JOIN #Valor_Moneda   vmv ON vmv.vmcodigo = v.iMonedaPago and vmv.vmfecha = v.fechaliquidacion 
   WHERE  v.bMarca          = '-'


   SELECT iOperacion
         ,iFlujo
         ,iMoneda
         ,cNemoMonOpe
         ,iMonedaPago
         ,cNemoMonPag
         ,iFormaPago
         ,cGlosaDocumento
         ,vCapitalInicial
         ,vCapitalVigente
         ,dFechaInicio
         ,dFechaVctoFlujo
         ,iPlazo
         ,iTasa
         ,vValorTasa
         ,cGlosaTasa
         ,iBase
         ,cGlosaBase
         ,vInteres
         ,vAmortizacion
         ,vFlujoAdicional
         ,vFlujo
         ,MsgActualizacion
         ,bMarca
         ,Spread
         ,TipoFlujo
         ,IntercambioNoc
         ,FechaLiquidacion
         ,'Anticipo'         = 'N'
         ,'AntTotalParcial'  = 'N/A      '
   INTO  #RETORNO   
   FROM   #LiquidaciónCompra
   UNION
   SELECT iOperacion
         ,iFlujo
         ,iMoneda
         ,cNemoMonOpe
         ,iMonedaPago
         ,cNemoMonPag
         ,iFormaPago
         ,cGlosaDocumento
         ,vCapitalInicial
         ,vCapitalVigente
         ,dFechaInicio
         ,dFechaVctoFlujo
         ,iPlazo
         ,iTasa
         ,vValorTasa
         ,cGlosaTasa
         ,iBase
         ,cGlosaBase
         ,vInteres
         ,vAmortizacion
         ,vFlujoAdicional
         ,vFlujo
         ,MsgActualizacion
         ,bMarca
         ,Spread
         ,TipoFlujo
         ,IntercambioNoc
         ,FechaLiquidacion
         ,'Anticipo'         = 'N'
         ,'AntTotalParcial'  = 'N/A      '
   FROM  #LiquidaciónVenta       



   UPDATE #RETORNO
      SET Anticipo     = isnull( ( select max('S')       from #Informe c where  c.Estado = 'N' ) , 'N' )
        , AntTotalParcial = isnull( ( select max('PARCIAL') from #Informe c where  c.Estado <> 'N') , 'TOTAL' )


   SELECT iOperacion
         ,iFlujo
         ,iMoneda
         ,cNemoMonOpe
         ,iMonedaPago
         ,cNemoMonPag
         ,iFormaPago
         ,cGlosaDocumento
         ,vCapitalInicial
         ,vCapitalVigente
         ,dFechaInicio
         ,dFechaVctoFlujo
         ,iPlazo
         ,iTasa
         ,vValorTasa
         ,cGlosaTasa
         ,iBase
         ,cGlosaBase
         ,vInteres
         ,vAmortizacion
         ,vFlujoAdicional
         ,vFlujo
         ,MsgActualizacion
         ,bMarca
         ,Spread
         ,TipoFlujo
         ,IntercambioNoc
         ,FechaLiquidacion
         ,Anticipo
         ,AntTotalParcial
         ,Entidad
	 ,Cliente
         ,RutCliente
	 ,FlujoMonedaPago
	 ,MonedaFinalPago
	 ,ValorMonedaPago
	 ,FormaPago
	 ,AFavordeCliente
	 ,TipoProducto
	 ,EstadoICP
	 ,MaxFlujoCompra
	 ,MaxFlujoVenta
	 ,FechaCierre
	 ,Modalidad_Pago  
         ,'GlosaMonPago' = (SELECT mnglosa FROM BacParamSuda..MONEDA  WHERE  mnnemo = MonedaFinalPago )
         ,'Ciudad'       = 'Santiago, '
         ,'Fecha'        = CASE WHEN DATEPART(dw,@FechaProceso) = 2 THEN 'Lunes ' + ' '  -- MAP 20080405
                                    WHEN DATEPART(dw,@FechaProceso) = 3 THEN 'Martes  '
                                    WHEN DATEPART(dw,@FechaProceso) = 4 THEN 'Miércoles '
      WHEN DATEPART(dw,@FechaProceso) = 5 THEN 'Jueves '
                                    WHEN DATEPART(dw,@FechaProceso) = 6 THEN 'Viernes '
                                    WHEN DATEPART(dw,@FechaProceso) = 7 THEN 'Sábado '
                                    WHEN DATEPART(dw,@FechaProceso) = 1 THEN 'Domingo '
                                END
                             + ' ' + LTRIM(RTRIM(DATEPART(DAY,@FechaProceso)))
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

         ,'ParamOper'   = CASE WHEN @Numero_Operacion =0 THEN 0 ELSE  @Numero_Operacion END
         ,'Grupo'       = MonedaFinalPago + ' ' +  cliente 
         ,'FlujoSuma'   = CASE WHEN TipoFlujo =1 THEN vFlujo  ELSE - vFlujo  END
         ,'FechaDesde'  = @FechaDesde
         ,'FechaHasta'  = @Fechahasta
   INTO #RESULTADO 
   FROM #RETORNO, #GENERAL   
   WHERE iOperacion = Numero_Operacion    
--   GROUP BY Cliente, cNemoMonPag, TipoFlujo, iFlujo 
   ORDER BY Cliente, iOperacion,  cNemoMonPag,  TipoFlujo, iFlujo 

   
  IF EXISTS(SELECT  *  FROM #RESULTADO)
     SELECT * FROM #RESULTADO
  ELSE 
--   NO EXISTEN REGISTROS
     select iOperacion 		= 0
       , iFlujo     		= 0
       , iMoneda        	= 0 
       , cNemoMonOpe    	= '' 
       , iMonedaPago    	= 0
       , cNemoMonPag   	= ''
       , iFormaPago     	= 0 
       , cGlosaDocumento        = ''        
       , vCapitalInicial        = 0
       , vCapitalVigente        = 0
       , dFechaInicio           = ''     
       , dFechaVctoFlujo        = ''    
       , iPlazo                 = 0
       , iTasa                  = 0
       , vValorTasa             = 0.0
       , cGlosaTasa             = ''                            
       , iBase 			= 0
       , cGlosaBase       	= ''         
       , vInteres               = 0                                
       , vAmortizacion          = 0
       , vFlujoAdicional        = 0.0                               
       , vFlujo                 = 0.0                               
       , MsgActualizacion       = ''                          
       , bMarca                 = ''
       , Spread                 = 0.0
       , TipoFlujo              = 0 
       , IntercambioNoc         = 0
       , FechaLiquidacion  = '' 
       , Anticipo               = ''  
       , AntTotalParcial        = ''
       , Entidad                = ''                       
       , Cliente      = ''                
       , RutCliente   = ''                                
       , FlujoMonedaPago    = 0.0 
       , MonedaFinalPago        = ''
       , ValorMonedaPago        = 0.0 
       , FormaPago              = ''   
       , AFavordeCliente        = ''
       , TipoProducto       = 0 
       , EstadoICP              = ''                            
       , MaxFlujoCompra         = 0
       , MaxFlujoVenta          = 0
       , FechaCierre            = ''                                            
       , Intercprinc            = 0 
       , Modalidad_Pago         = ''
       , GlosaMonPago           = ''             
       , Ciudad                 = ''
       , Fecha                  = ''                                 
       , ParamOper              = 0 
       , Grupo                  = ''                                                    
       , FlujoSuma              = 0.0                               
       , FechaDesde             = ''     
       , FechaHasta             = '' 


END
GO
