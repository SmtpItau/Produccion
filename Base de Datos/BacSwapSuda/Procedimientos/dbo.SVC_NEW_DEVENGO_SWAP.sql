USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_NEW_DEVENGO_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_NEW_DEVENGO_SWAP]
AS
BEGIN

   SET NOCOUNT ON

   -->     Lee la fecha de Proceso
   DECLARE @dFechaProceso     DATETIME
       SET @dFechaProceso     = ( SELECT fechaproc FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock) )

   -->     Lee la fecha Antes de Proceso (Anterior)
   DECLARE @dFechaAnterior    DATETIME
       SET @dFechaAnterior    = ( SELECT fechaant  FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock) )

   -->     Lee la fecha Proxima de Proceso
   DECLARE @dFechaProxima     DATETIME
       SET @dFechaProxima     = ( SELECT fechaprox FROM BacSwapSuda.dbo.SWAPGENERAL with(nolock) )

   -->     Determina la fecha a la cual se Devengara 
   DECLARE @dFechaCalculo     DATETIME
       SET @dFechaCalculo     = CASE WHEN MONTH(@dFechaProceso) = MONTH(@dFechaProxima) THEN @dFechaProceso
                                     ELSE DATEADD(DAY, DAY(DATEADD(MONTH, 1, @dFechaProceso )) * -1, DATEADD(MONTH, 1, @dFechaProceso) )
                                END
   -->     Fechas Asociadas al Proceso
   
   -->     Crea estructura para los valores de Monedas
   CREATE TABLE #Tmp_ValorMoneda
      (   Codigo  INTEGER    NOT NULL DEFAULT(0)
      ,   Valor   FLOAT      NOT NULL DEFAULT(0.0)
      )

   -->     Crea Indice a estructura para los valores de Monedas   
   CREATE CLUSTERED INDEX #Ix_Tmp_ValorMoneda ON #Tmp_ValorMoneda (Codigo)

   -->     Inserta los valores para el Peso, en valor 1.
   INSERT INTO #Tmp_ValorMoneda
   SELECT Codigo         = 999
      ,   Valor          = 1.0

   -->     Inserta los valores para Ivp y Dólar Acuerdo A LA FECHA DE PROCESO
   INSERT INTO #Tmp_ValorMoneda
   SELECT Codigo         = vmcodigo
      ,   Valor          = vmvalor
   FROM   BacParamSuda.dbo.VALOR_MONEDA
   WHERE  vmfecha        = @dFechaProceso
   AND    vmcodigo      IN(995, 997)

   -->     Inserta los valores para la Unidad de Fomento A LA FECHA DE PROCESO O FIN DE MES
   INSERT INTO #Tmp_ValorMoneda
   SELECT Codigo         = vmcodigo
      ,   Valor          = vmvalor
   FROM   BacParamSuda.dbo.VALOR_MONEDA
   WHERE  vmfecha        = @dFechaCalculo
   AND    vmcodigo       = 998

   -->     Inserta los valores para monedas A LA FECHA DE PROCESO
   INSERT INTO #Tmp_ValorMoneda
   SELECT Codigo         = Codigo_Moneda
       ,  Valor          = Tipo_cambio 
   FROM   BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)
   WHERE  Fecha          = @dFechaProceso
     AND  Codigo_Moneda  NOT IN(995, 997, 998, 13, 999)

   -->     Busca los Valores de Moneda Contable a la fecha o bien a la fecha aterior.
   IF @@RowCount = 0
   BEGIN
      INSERT INTO #Tmp_ValorMoneda
      SELECT Codigo        = Codigo_Moneda
          ,  Valor         = Tipo_cambio 
      FROM   BacParamSuda.dbo.VALOR_MONEDA_CONTABLE with(nolock)
      WHERE  Fecha         = @dFechaAnterior
        AND  Codigo_Moneda NOT IN(995, 997, 998, 13, 999)
   
      IF @@RowCount = 0
      BEGIN
         SELECT -1, 'No se han encontrad valores de Moneda.'
      END
   END

   -->    Crea el Valor de Moneda 13, Dólar USA, a partir del valor del Observado a la fecha de proceso.
   INSERT INTO #Tmp_ValorMoneda
   SELECT Codigo  = 13
      ,   Valor   = Valor
   FROM   #Tmp_ValorMoneda 
   WHERE  codigo  = 994
   -->    fin de proceso de valores de moneda


   -->    Crea estructura para las curvas
   CREATE TABLE #TMP_Puntos
      (   Curva      VARCHAR(50)   NOT NULL CONSTRAINT [df_TMP_Puntos_Curva]   DEFAULT('')
      ,   Plazo      NUMERIC(9)    NOT NULL CONSTRAINT [df_TMP_Puntos_Plazo]   DEFAULT(0)
      ,   Bid        FLOAT         NOT NULL CONSTRAINT [df_TMP_Puntos_Bid]     DEFAULT(0.0)
      ,   Ask        FLOAT         NOT NULL CONSTRAINT [df_TMP_Puntos_Ask]     DEFAULT(0.0)
      )

   -->    Crea indice a la estructura
   CREATE CLUSTERED INDEX #ix_Tmp_Puntos ON #TMP_Puntos (Curva, Plazo)

   -->     Determina la fecha a la cual debe leer las curvas, por defecto a la fecha proceso
   DECLARE @dFechaCurvas   DATETIME
       SET @dFechaCurvas = @dFechaProceso

   -->     Si no hay curvas a la fecha de proceso, leera la fecha anterior
   IF NOT EXISTS(SELECT TOP 1 1 FROM BacParamSuda.dbo.CURVAS with(nolock) WHERE FechaGeneracion = @dFechaProceso )
   BEGIN
      SET @dFechaCurvas   = @dFechaAnterior
   END

   INSERT INTO #TMP_Puntos
   SELECT DISTINCT cp.CodigoCurva
               ,   cu.Dias
               ,   cu.ValorBid
               ,   cu.ValorAsk
              FROM BacParamSuda.dbo.CURVAS_PRODUCTO   cp with(nolock)
                   INNER JOIN BacParamSuda.dbo.CURVAS cu with(nolock) ON cu.CodigoCurva = cp.CodigoCurva
             WHERE cp.Modulo          = 'PCS'
               AND cu.FechaGeneracion = @dFechaCurvas

   UNION

   SELECT DISTINCT cp.CurAlter
               ,   cu.Dias
               ,   cu.ValorBid
               ,   cu.ValorAsk
              FROM BacParamSuda.dbo.CURVAS_PRODUCTO   cp with(nolock)
                   INNER JOIN BacParamSuda.dbo.CURVAS cu with(nolock) ON cu.CodigoCurva = cp.CodigoCurva
             WHERE cp.Modulo          = 'PCS'
               AND cu.FechaGeneracion = @dFechaCurvas
               AND cp.CurAlter       <> ''


   CREATE TABLE #Tmp_Cartera_Swap
   (      TipoSwap          INTEGER      NOT NULL
   ,      Producto          CHAR(2)      NOT NULL
   ,      NumeroContrato    NUMERIC(9)   NOT NULL
   ,      NumeroFlujo       NUMERIC(9)   NOT NULL
   ,      TipoFlujo         INTEGER      NOT NULL
   ,      FechaInicio       DATETIME     NOT NULL
   ,      FechaVencimiento  DATETIME     NOT NULL
   ,      FechaFijacion     DATETIME     NOT NULL
   ,      PlazoRemContrato  NUMERIC(9)   NOT NULL
   ,      Moneda            INTEGER      NOT NULL
   ,      AmortizacionFlujo FLOAT        NOT NULL
   ,      SaldoFlujo        FLOAT        NOT NULL
   ,      InteresFlujo      FLOAT        NOT NULL
   ,      FlujoAdicional    FLOAT        NOT NULL
   ,      Indicador         INTEGER      NOT NULL
   ,      Valor_Tasa        FLOAT        NOT NULL
   ,      Spread            FLOAT        NOT NULL
   ,      TipoTasa          INTEGER      NOT NULL
   ,      Base              INTEGER      NOT NULL
   ,      TasaDescuento     VARCHAR(25)  NOT NULL
   ,      TasaProyeccion    VARCHAR(25)  NOT NULL
   ,      Amortizacion      FLOAT        NOT NULL
   ,      DiasReset         NUMERIC(9)   NOT NULL
   ,      FeriadoChile      INTEGER      NOT NULL
   ,      FeriadoEEUU       INTEGER      NOT NULL
   ,      FeriadoEngland    INTEGER      NOT NULL
   ,      Avr_Moneda        FLOAT        NOT NULL
   ,      Avr_Usd           FLOAT        NOT NULL
   ,      Avr_Clp           FLOAT        NOT NULL
   ,      BaseTasa          INTEGER      NOT NULL
   ,      DiasFlujo         NUMERIC(9)   NOT NULL
   ,      PlazoTir          NUMERIC(9)   NOT NULL
   ,      TasaTir           FLOAT        NOT NULL
   ,      PlazoBase         NUMERIC(9)   NOT NULL
   ,      DiasBaseTasaFwd   NUMERIC(9)   NOT NULL
   )

   CREATE CLUSTERED INDEX #ix_Tmp_Swap ON #Tmp_Cartera_Swap (TipoSwap, NumeroContrato, TipoFlujo, NumeroFlujo)

   -->     Lee la estructura de la cartera de Swap
-->   INSERT INTO #Tmp_Cartera_Swap
   SELECT 'TipoSwap'          = car.tipo_swap
   ,      'Producto'          = CASE WHEN car.tipo_swap = 1 THEN 'ST' 
                                     WHEN car.tipo_swap = 2 THEN 'SM' 
                                     WHEN car.tipo_swap = 3 THEN 'FR' 
                                     WHEN car.tipo_swap = 4 THEN 'SP' 
                                END
   ,      'NumeroContrato'    = car.numero_operacion
   ,      'NumeroFlujo'       = car.numero_flujo
   ,      'TipoFlujo'         = car.tipo_flujo
   ,      'FechaInicio'       = car.fecha_inicio_flujo
   ,      'FechaVencimiento'  = car.fecha_vence_flujo
   ,      'FechaFijacion'     = car.fecha_fijacion_tasa
   ,      'PlazoRemContrato'  = DATEDIFF( DAY, @dFechaProceso, car.fecha_vence_flujo )
   ,      'Moneda'            = CASE WHEN tipo_flujo = 1 THEN car.compra_moneda            ELSE car.venta_moneda           END
   ,      'AmortizacionFlujo' = CASE WHEN tipo_flujo = 1 THEN car.compra_amortiza          ELSE car.venta_amortiza         END
   ,      'SaldoFlujo'        = CASE WHEN tipo_flujo = 1 THEN car.compra_saldo             ELSE car.venta_saldo            END
   ,      'InteresFlujo'      = CASE WHEN tipo_flujo = 1 THEN car.compra_interes           ELSE car.venta_interes          END
   ,      'FlujoAdicional'    = CASE WHEN tipo_flujo = 1 THEN car.compra_flujo_adicional   ELSE car.venta_Flujo_Adicional  END
   ,      'Indicador'         = CASE WHEN tipo_flujo = 1 THEN car.compra_codigo_tasa       ELSE car.venta_codigo_tasa      END
   ,      'Valor_Tasa'        = CASE WHEN tipo_flujo = 1 THEN car.compra_valor_tasa        ELSE car.venta_valor_tasa       END
   ,      'Spread'            = CASE WHEN tipo_flujo = 1 THEN car.compra_spread            ELSE car.venta_spread           END
   ,      'TipoTasa'          = CASE WHEN ( car.compra_codigo_tasa + car.venta_codigo_tasa) = 0 THEN 0 ELSE 1              END --> 0 = Fija; 1 = Variable
   ,      'Base'              = CASE WHEN tipo_flujo = 1 THEN car.compra_base              ELSE car.venta_base             END
   ,      'TasaDescuento'     = CASE WHEN tipo_flujo = 1 THEN car.compra_curva_descont     ELSE car.venta_curva_descont    END
   ,      'TasaProyeccion'    = CASE WHEN tipo_flujo = 1 THEN car.compra_curva_forward     ELSE car.venta_curva_forward    END
   ,      'Amortizacion'      = ( car.compra_amortiza + car.venta_amortiza ) * car.intercprinc
   ,      'DiasReset'         = car.diasreset
   ,      'FeriadoChile'      = car.feriadoflujochile
   ,      'FeriadoEEUU'       = car.feriadoflujoeeuu
   ,      'FeriadoEngland'    = car.feriadoflujoenglan
   ,      'Avr_Moneda'        = car.valor_razonablemo
   ,      'Avr_Usd'           = car.valor_razonableusd
   ,      'Avr_Clp'           = car.valor_razonableclp
   ,      'BaseTasa'          = ISNULL( CASE WHEN bas.Base = 'A' THEN 365 ELSE bas.Base END, 360)

   -->    @CarPlazoFlujo, @DiasBase
   ,      'DiasFlujo'         = CASE WHEN car.compra_base + car.venta_base NOT IN(4, 5) THEN DateDiff( Day, car.fecha_inicio_flujo, car.fecha_vence_flujo)
                                     ELSE (( Year( car.fecha_vence_flujo ) -  Year( car.fecha_inicio_flujo )) * 360)
                                        + ((Month( car.fecha_vence_flujo ) - Month( car.fecha_inicio_flujo )) *  30)
                                        + CASE WHEN Day( car.fecha_vence_flujo  ) = 31 and Day( car.fecha_inicio_flujo ) = 31 THEN 0
                                               WHEN Day( car.fecha_vence_flujo  ) = 31                                        THEN 30 - Day( car.fecha_inicio_flujo )
                                               WHEN Day( car.fecha_inicio_flujo ) = 31                                        THEN Day( car.fecha_vence_flujo ) - 30
                                               ELSE Day( car.fecha_vence_flujo  ) - Day( car.fecha_inicio_flujo )
                                          END
                                END
   ,      'PlazoTir'          = CASE WHEN car.tipo_flujo = 1 AND car.compra_codigo_tasa  = 0 THEN DateDiff(Day, @dFechaCalculo, car.fecha_Termino )
                                     WHEN car.tipo_flujo = 1 AND car.compra_codigo_tasa <> 0 THEN DateDiff(Day, @dFechaCalculo, car.fecha_vence_flujo )
                                     WHEN car.tipo_flujo = 2 AND car.venta_codigo_tasa   = 0 THEN DateDiff(Day, @dFechaCalculo, car.fecha_Termino )
                                     WHEN car.tipo_flujo = 2 AND car.venta_codigo_tasa  <> 0 THEN DateDiff(Day, @dFechaCalculo, car.fecha_vence_flujo )
                                END
   ,      'TasaTir'           = 0.0
   ,      'PlazoBase'         = CASE WHEN car.compra_base + car.venta_base NOT IN(4, 5) THEN DateDiff( Day, car.fecha_inicio_flujo, car.fecha_vence_flujo)
                                     ELSE (( Year( car.fecha_vence_flujo ) -  Year( car.fecha_inicio_flujo )) * 360)
                                        + ((Month( car.fecha_vence_flujo ) - Month( car.fecha_inicio_flujo )) *  30)
                                        + CASE WHEN Day( car.fecha_vence_flujo  ) = 31 and Day( car.fecha_inicio_flujo ) = 31 THEN 0
                                               WHEN Day( car.fecha_vence_flujo  ) = 31                                        THEN 30 - Day( car.fecha_inicio_flujo )
                                               WHEN Day( car.fecha_inicio_flujo ) = 31                                        THEN Day( car.fecha_vence_flujo ) - 30
                                               ELSE Day( car.fecha_vence_flujo  ) - Day( car.fecha_inicio_flujo )
                                          END
                                END
   ,      'DiasBaseTasaFwd'   = CASE WHEN ind.tbcodigo1 <> 13 THEN isnull(per.dias, 1) ELSE 0.0 END

--> Datos para Promedio Camara
   ,      'SaldoK'    	      = CASE WHEN tipo_flujo = 1 THEN car.compra_Saldo+car.compra_amortiza     ELSE   car.venta_Saldo+car.venta_amortiza      END --> Se puede reemplazar
   ,      'FlujoMin'  	      = FlujoMin.MinFlujo

   FROM   BacSwapSuda.dbo.CARTERA                          car with(nolock)
    	  INNER JOIN (	SELECT 	numero_operacion  AS Oper 
			,	MIN(numero_flujo) AS MinFlujo 
			  FROM  BacSwapSuda.dbo.CARTERA with(nolock)                         
			 WHERE  Estado    <> 'N'
		      GROUP BY  numero_operacion   ) FlujoMin ON  FlujoMin.Oper = car.numero_operacion  
          LEFT JOIN BASE                                   bas with(nolock) ON bas.codigo  = CASE WHEN tipo_flujo = 1 THEN car.compra_base ELSE car.venta_base END
          LEFT JOIN BacParamSuda.dbo.TABLA_GENERAL_DETALLE ind with(nolock) ON ind.tbcateg = 1042  AND ind.tbcodigo1 = CASE WHEN tipo_flujo = 1 THEN car.compra_codigo_tasa ELSE car.venta_codigo_tasa END
          LEFT JOIN BacParamSuda.dbo.PERIODO_AMORTIZACION  per with(nolock) ON per.sistema = 'PCS' AND per.tabla = 1044 and per.codigo = ind.tbtasa
   WHERE  car.Estado         <> 'N'

END
GO
