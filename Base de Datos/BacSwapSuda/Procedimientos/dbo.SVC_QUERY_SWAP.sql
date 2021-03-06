USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_QUERY_SWAP]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SVC_QUERY_SWAP]
   (   @dFechaCartera   DATETIME   = ''  )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso    DATETIME
       SET @dFechaProceso    = (SELECT fechaproc FROM BacSwapSuda..SWAPGENERAL with(nolock) )

   DECLARE @dFechaAnterior   DATETIME
       SET @dFechaAnterior   = CASE WHEN @dFechaProceso = @dFechaCartera THEN ( SELECT fechaant FROM BacSwapSuda..SWAPGENERAL    with(nolock) )
                                    ELSE                                      ( SELECT fechaant FROM BacSwapSuda..SWAPGENERALHIS with(nolock) WHERE fechaproc = @dFechaCartera )
                               END

   SELECT @dFechaCartera               AS Fecha_Proceso
      ,   car.car_Cartera_Normativa    AS cre_cartera_normativa
      ,   car.Numero_Operacion, car.numero_flujo,   car.tipo_flujo,        car.Tipo_Swap,         car.cartera_inversion, car.Fecha_Vence_Flujo
      ,   car.compra_moneda,    car.compra_capital, car.vRazActivoAjus_Mn, car.compra_amortiza,   car.compra_interes,    car.compra_flujo_adicional
      ,   car.venta_moneda,     car.venta_capital,  car.vRazPasivoAjus_Mn, car.venta_amortiza,    car.venta_interes,     car.venta_flujo_adicional
      ,   car.intercprinc,      car.Valor_RazonableCLP, RevvRaz = CONVERT(FLOAT,0.0)
      ,   car.Fecha_Cierre,     car.Fecha_Inicio_Flujo, cli.clnombre
   INTO   #CARTERA_UNION
   FROM   CARTERA        car with(nolock)
          INNER JOIN BacParamsuda..CLIENTE cli with(nolock) ON cli.clrut = car.rut_cliente and cli.clcodigo = car.codigo_cliente
   WHERE  car.Estado        <> 'C'
   AND    car.numero_flujo   = ( SELECT MIN(fil.numero_flujo) FROM CARTERA fil with(nolock) 
                                                            WHERE fil.tipo_flujo = 1 and fil.numero_operacion = car.numero_operacion )
   ORDER BY car.Numero_Operacion

   IF @dFechaCartera <> @dFechaProceso
   BEGIN
      DELETE FROM #CARTERA_UNION

      INSERT INTO #CARTERA_UNION
      SELECT car.Fecha_Proceso         AS Fecha_Proceso
         ,   car.cre_cartera_normativa AS cre_cartera_normativa
         ,   car.Numero_Operacion, car.numero_flujo,   car.tipo_flujo,        car.Tipo_Swap,         car.cartera_inversion, car.Fecha_Vence_Flujo
         ,   car.compra_moneda,    car.compra_capital, car.vRazActivoAjus_Mn, car.compra_amortiza,   car.compra_interes,    car.compra_flujo_adicional
         ,   car.venta_moneda,     car.venta_capital,  car.vRazPasivoAjus_Mn, car.venta_amortiza,    car.venta_interes,     car.venta_flujo_adicional
         ,   car.intercprinc,      car.Valor_RazonableCLP, RevvRaz = CONVERT(FLOAT,0.0)
         ,   car.Fecha_Cierre,     car.Fecha_Inicio_Flujo, cli.clnombre
      FROM   CARTERARES  car with(nolock)
             INNER JOIN BacParamsuda..CLIENTE cli with(nolock) ON cli.clrut = car.rut_cliente and cli.clcodigo = car.codigo_cliente
      WHERE  car.Fecha_Proceso  = @dFechaCartera 
      AND    car.Estado        <> 'C'
      AND    car.numero_flujo   = ( SELECT MIN(fil.numero_flujo) FROM CARTERARES fil with(nolock) 
                                                                WHERE fil.Fecha_Proceso = @dFechaCartera AND fil.tipo_flujo = 1 AND fil.numero_operacion = car.numero_operacion)
      ORDER BY car.Numero_Operacion
   END

   UPDATE #CARTERA_UNION
   SET    RevvRaz              = car.Valor_RazonableCLP
   FROM   CARTERARES car
   WHERE  car.Fecha_Proceso    = @dFechaAnterior
   AND    car.Numero_Operacion = #CARTERA_UNION.Numero_Operacion
   AND    car.numero_flujo     = #CARTERA_UNION.numero_flujo
   AND    car.tipo_flujo       = #CARTERA_UNION.tipo_flujo

   CREATE TABLE #TMP_CARTERA_SWAP
   (   Contrato      NUMERIC(9)
   ,   Tipo          CHAR(3)
   ,   Normativa     VARCHAR(50)    
   ,   Financiera    VARCHAR(50)    
   ,   MonedaAct     CHAR(3)
   ,   MonedaPas     CHAR(3)
   ,   NocionalAct   FLOAT
   ,   NocionalPas   FLOAT
   ,   vRazonable    FLOAT
   ,   vRazReversa   FLOAT
   ,   DifPrecio     FLOAT
   ,   FechaCierre   DATETIME
   ,   FechaInicio   DATETIME
   ,   Cliente       VARCHAR(70)    
   ,   Puntero       NUMERIC(9) Identity(1,1)
   )

   CREATE INDEX #ix_TMP_CARTERA_SWAP ON #TMP_CARTERA_SWAP (Contrato)

   INSERT INTO #TMP_CARTERA_SWAP
   SELECT DISTINCT Contrato      = numero_operacion
                 , Tipo          = CASE WHEN Tipo_Swap = 1 THEN 'IRS'
                                        WHEN Tipo_Swap = 2 THEN 'CCS'
                                        WHEN Tipo_Swap = 3 THEN 'FRA'
                                        WHEN Tipo_Swap = 4 THEN 'SPC'
                                   END
                 , Normativa     = fn.tbglosa --> cartera_inversion
                 , Financiera    = nm.tbglosa --> cre_cartera_normativa
                 , MonedaAct     = 0
                 , MonedaPas     = 0
                 , NocionalAct   = 0
                 , NocionalPas   = 0
                 , vRazonable    = 0
                 , vRazReversa   = 0
                 , DifPrecio     = 0
                 , FechaCierre   = Fecha_Cierre
                 , FechaInicio   = Fecha_Inicio_Flujo
                 , Cliente       = clnombre
           FROM  #CARTERA_UNION
                 INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE fn with(nolock) ON fn.tbcateg = 204  AND fn.tbcodigo1 = cartera_inversion
                 INNER JOIN BacParamSuda..TABLA_GENERAL_DETALLE nm with(nolock) ON nm.tbcateg = 1111 AND nm.tbcodigo1 = cre_cartera_normativa
           WHERE Fecha_Proceso    = @dFechaCartera 
        ORDER BY numero_operacion

   DECLARE @nInicio   NUMERIC(9)
       SET @nInicio   = (SELECT MIN(Puntero) FROM #TMP_CARTERA_SWAP)
   DECLARE @nTermino  NUMERIC(9)
       SET @nTermino  = (SELECT MAX(Puntero) FROM #TMP_CARTERA_SWAP)

   DECLARE @FechaVence   DATETIME
   DECLARE @nContrato    NUMERIC(9)
   DECLARE @Moneda       CHAR(3)
   DECLARE @Nocional     FLOAT
   DECLARE @vRazonable   FLOAT
   DECLARE @nDifPrecio   FLOAT

   WHILE @nTermino >= @nInicio
   BEGIN

      SET @nContrato = (SELECT contrato FROM #TMP_CARTERA_SWAP WHERE Puntero = @nInicio)

      SELECT @FechaVence      = Fecha_Vence_Flujo
         ,   @Moneda          = mn.mnnemo          --> compra_moneda
         ,   @Nocional        = compra_capital
         ,   @vRazonable      = Valor_RazonableCLP --> vRazActivoAjus_Mn
         ,   @nDifPrecio      = (compra_amortiza * intercprinc + compra_interes + compra_flujo_adicional)
      FROM   #CARTERA_UNION
             INNER JOIN BacParamSuda..MONEDA mn with(nolock) ON mn.mncodmon = compra_moneda
      WHERE  Fecha_Proceso    = @dFechaCartera 
      AND    Numero_Operacion = @nContrato 
      AND    Tipo_Flujo       = 1

      UPDATE #TMP_CARTERA_SWAP
         SET MonedaAct        = @Moneda
         ,   NocionalAct      = @Nocional
         ,   vRazonable       = @vRazonable
         ,   DifPrecio        = CASE WHEN @FechaVence = @dFechaCartera THEN @nDifPrecio ELSE 0.0 END
       WHERE Puntero          = @nInicio

      SELECT @FechaVence      = Fecha_Vence_Flujo
         ,   @Moneda          = mn.mnnemo --> venta_moneda
         ,   @Nocional        = venta_capital
         ,   @nDifPrecio      = (venta_amortiza * intercprinc + venta_interes + venta_flujo_adicional)
         ,   @vRazonable      = RevvRaz
      FROM   #CARTERA_UNION
             INNER JOIN BacParamSuda..MONEDA mn with(nolock) ON mn.mncodmon = venta_moneda
      WHERE  Fecha_Proceso    = @dFechaCartera 
      AND    Numero_Operacion = @nContrato 
      AND    tipo_flujo       = 2

      UPDATE #TMP_CARTERA_SWAP
         SET MonedaPas        = @Moneda
         ,   NocionalPas      = @Nocional
         ,   DifPrecio        = CASE WHEN @FechaVence = @dFechaCartera THEN DifPrecio - @nDifPrecio ELSE 0.0 END
         ,   vRazReversa      = @vRazonable
       WHERE Puntero          = @nInicio

      SET @nInicio = @nInicio + 1 
   END

   UPDATE #TMP_CARTERA_SWAP
      SET NocionalAct   = ROUND(NocionalAct   / 1000, 0)
      ,   NocionalPas   = ROUND(NocionalPas   / 1000, 0)
      ,   vRazonable    = ROUND(vRazonable    / 1000, 0)
      ,   vRazReversa   = ROUND(vRazReversa   / 1000, 0)
      ,   DifPrecio     = ROUND(DifPrecio     / 1000, 0)

   SELECT Contrato
        , Tipo
        , Normativa
        , Financiera
        , MonedaAct
        , MonedaPas
        , NocionalAct
        , NocionalPas
        , vRazonable
        , vRazReversa
        , UtilPer = (vRazonable - vRazReversa), DifPrecio
        , FechaCierre = CONVERT(CHAR(10),FechaCierre,103)
        , FechaInicio = CONVERT(CHAR(10),FechaInicio, 103)
        , Cliente
   FROM   #TMP_CARTERA_SWAP 
-- WHERE  Contrato IN(473,474) --> 
   ORDER BY Normativa, Financiera, Tipo, MonedaAct, MonedaPas, Contrato

   DROP TABLE #TMP_CARTERA_SWAP
   DROP TABLE #CARTERA_UNION

END
GO
