USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CARTERA_PRODUCTO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFORME_CARTERA_PRODUCTO]  
   (   @dFechaProceso DATETIME  
   ,   @iUsuario      VARCHAR(15)  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
-- Swap: Guardar Como  
   DECLARE @dFechaHoy     DATETIME  
   ,       @dFecProceso   CHAR(10)  
   ,       @dFecEmision   CHAR(10)  
   ,       @dHorEmision   CHAR(10)  
  
   SELECT  @dFechaHoy     = fechaproc  
   ,       @dFecProceso   = CONVERT(CHAR(10),fechaproc,103)  
   ,       @dFecEmision   = CONVERT(CHAR(10),GETDATE(),103)  
   ,       @dHorEmision   = CONVERT(CHAR(10),GETDATE(),108)  
   FROM    SWAPGENERAL    with(nolock)  
  
   CREATE TABLE #CarteraProducto  
   (   Numero         NUMERIC(9)  
   ,   Marca          CHAR(1)  
   ,   Tipo           INTEGER  
   ,   Flujo          NUMERIC(9)  
   ,   Cartera        VARCHAR(5)  
   ,   FecInicio      DATETIME  
   ,   FecTermino     DATETIME  
   ,   Convexidad     NUMERIC(21,4)  
   ,   Macaulay       NUMERIC(21,4)  
   ,   Modificada     NUMERIC(21,4)  
   ,   Moneda         INTEGER  
   ,   Capital        NUMERIC(21,4)  
   ,   Saldo          NUMERIC(21,4)  
   ,   TipoTasa       INTEGER  
   ,   Tasa           NUMERIC(21,4)  
   ,   vRazonableMn   NUMERIC(21,4)  
   ,   vRazonableMx   NUMERIC(21,4)  
   ,   vRazNetoMn     NUMERIC(21,4)  
   ,   vRazNetoMx     NUMERIC(21,4)  
   ,   SubCartera     INTEGER  
   ,   TasaAjustada   NUMERIC(21,4)  
   ,   OrigenCurva    VARCHAR(2) )  
  
   CREATE TABLE #CarteraSwap  
   (   MiOperacion   NUMERIC(9)  
   ,   MiFlujo       NUMERIC(9)  
   ,   MiTipo        INTEGER  
   )  
  
   IF @dFechaHoy = @dFechaProceso  
   BEGIN  
  
      INSERT INTO #CarteraSwap   
      SELECT Numero_Operacion , MIN(numero_flujo) , Tipo_Flujo   
      FROM CARTERA with(nolock)  
      where ( tipo_swap <> 3 or ( tipo_swap = 3 and fechaliquidacion >= @dFechaHoy ) )  
      and Estado <> 'C'     
      GROUP BY numero_operacion , Tipo_Flujo   
      ORDER BY numero_operacion , Tipo_Flujo  
  
      INSERT INTO #CarteraProducto  
      SELECT 'Numero'            = Numero_Operacion  
      ,      'Marca'             = 'A'  
      ,      'Tipo'              = Tipo_Swap  
      ,      'Flujo'             = Numero_Flujo  
      ,      'Cartera'           = car_Cartera_Normativa  
      ,      'FecInicio'         = fecha_inicio  
      ,      'FecTermino'        = fecha_termino  
      ,      'Convexidad'        = CONVERT(NUMERIC(21,4),ROUND(vDurConvexActivo,4))  
      ,      'Macaulay'          = CONVERT(NUMERIC(21,4),ROUND(vDurMacaulActivo,4))  
      ,      'Modificada'        = CONVERT(NUMERIC(21,4),ROUND(vDurModifiActivo,4))  
      ,      'Moneda'            = compra_moneda  
      ,      'Capital'           = compra_capital  
      ,      'Saldo'             = compra_saldo /*compra_amortiza + */  
      ,      'TipoTasa'          = compra_codigo_tasa   
      ,      'Tasa'              = compra_valor_tasa + compra_spread  
      ,      'vRazonableMn'      = compra_mercado_clp     
      ,      'vRazonableMx'      = compra_mercado_usd  
      ,      'vRazNetoMn'        = Valor_RazonableCLP  
      ,      'vRazNetoMx'        = Valor_RazonableUSD  
      ,      'SubCartera'        = car_SubCartera_Normativa  
      ,      'TasaAjustada'      = vTasaActivaAjusta  
      ,      'OrigenCurva'       = OrigenCurva
      FROM   BacSwapSuda..CARTERA    with(nolock)  
             INNER JOIN #CarteraSwap ON Numero_Operacion = MiOperacion AND Numero_Flujo = MiFlujo AND Tipo_Flujo = MiTipo  
      WHERE  Tipo_Flujo          = 1   
      and estado <> 'C'  
  
      INSERT INTO #CarteraProducto  
      SELECT 'Numero'            = Numero_Operacion  
      ,      'Marca'             = 'P'  
      ,      'Tipo'              = Tipo_Swap  
      ,      'Flujo'             = Numero_Flujo  
      ,      'Cartera'           = car_Cartera_Normativa  
      ,      'FecInicio'         = fecha_inicio  
      ,      'FecTermino'        = fecha_termino  
      ,      'Convexidad'        = CONVERT(NUMERIC(21,4),ROUND(vDurConvexPasivo,4))  
      ,      'Macaulay'          = CONVERT(NUMERIC(21,4),ROUND(vDurMacaulPasivo,4))  
      ,      'Modificada'        = CONVERT(NUMERIC(21,4),ROUND(vDurModifiPasivo,4))  
      ,      'Moneda'            = venta_moneda  
      ,      'Capital'           = venta_capital  
      ,      'Saldo'             = venta_saldo /*venta_amortiza +*/   
      ,      'TipoTasa'          = venta_codigo_tasa  
      ,      'Tasa'              = venta_valor_tasa + venta_spread  
      ,      'vRazonableMn'      = venta_mercado_clp  
      ,      'vRazonableMx'      = venta_mercado_usd  
      ,      'vRazNetoMn'        = Valor_RazonableCLP  
      ,      'vRazNetoMx'        = Valor_RazonableUSD  
      ,      'SubCartera'        = car_SubCartera_Normativa  
      ,      'TasaAjustada'      = vTasaPasivaAjusta  
      ,      'OrigenCurva'       = OrigenCurva  
      FROM   BacSwapSuda..CARTERA with(nolock)  
             INNER JOIN #CarteraSwap ON Numero_Operacion = MiOperacion AND Numero_Flujo = MiFlujo AND Tipo_Flujo = MiTipo  
      WHERE  Tipo_Flujo          = 2  
             and Estado <> 'C'  
   END ELSE  
   BEGIN  
  
      INSERT INTO #CarteraSwap   
      SELECT Numero_Operacion   
      ,      MIN(numero_flujo)   
      ,      Tipo_Flujo   
      FROM BacSwapSuda..CARTERARES with(nolock)  
      WHERE Fecha_Proceso = @dFechaProceso   
      And   (tipo_swap <> 3 or ( tipo_swap = 3 and fechaliquidacion >= @dFechaHoy ))  
      GROUP BY numero_operacion , Tipo_Flujo   
      ORDER BY numero_operacion , Tipo_Flujo  
  
      INSERT INTO #CarteraProducto  
      SELECT 'Numero'            = Numero_Operacion  
      ,      'Marca'             = 'A'  
      ,      'Tipo'              = Tipo_Swap  
      ,      'Flujo'             = Numero_Flujo  
      ,      'Cartera'           = cre_cartera_normativa  
      ,      'FecInicio'         = fecha_inicio  
      ,      'FecTermino'        = fecha_termino  
      ,      'Convexidad'        = CONVERT(NUMERIC(21,4),ROUND(vDurConvexActivo,4))  
      ,      'Macaulay'          = CONVERT(NUMERIC(21,4),ROUND(vDurMacaulActivo,4))  
      ,      'Modificada'        = CONVERT(NUMERIC(21,4),ROUND(vDurModifiActivo,4))  
      ,      'Moneda'            = compra_moneda  
      ,      'Capital'           = compra_capital  
      ,      'Saldo'             = compra_saldo /*compra_amortiza +*/   
      ,      'TipoTasa'          = compra_codigo_tasa  
      ,      'Tasa'              = compra_valor_tasa + compra_spread  
      ,      'vRazonableMn'      = compra_mercado_clp     
      ,      'vRazonableMx'      = compra_mercado_usd  
      ,      'vRazNetoMn'        = Valor_RazonableCLP  
      ,      'vRazNetoMx'        = Valor_RazonableUSD  
      ,      'SubCartera'        = cre_subcartera_normativa  
      ,      'TasaAjustada'      = vTasaActivaAjusta  
      ,      'OrigenCurva'       = OrigenCurva  
      FROM   BacSwapSuda..CARTERARES with(nolock)  
             INNER JOIN #CarteraSwap ON Numero_Operacion = MiOperacion AND Numero_Flujo = MiFlujo AND Tipo_Flujo = MiTipo  
      WHERE  Fecha_Proceso       = @dFechaProceso  
      AND    Tipo_Flujo          = 1  
      And    Estado              <> 'C'  
  
      INSERT INTO #CarteraProducto  
      SELECT 'Numero'            = Numero_Operacion  
      ,      'Marca'             = 'P'  
      ,      'Tipo'              = Tipo_Swap  
      ,      'Flujo'             = Numero_Flujo  
      ,      'Cartera'           = cre_cartera_normativa  
      ,      'FecInicio'         = fecha_inicio  
      ,      'FecTermino'        = fecha_termino  
      ,      'Convexidad'        = CONVERT(NUMERIC(21,4),ROUND(vDurConvexPasivo,4))  
      ,      'Macaulay'          = CONVERT(NUMERIC(21,4),ROUND(vDurMacaulPasivo,4))  
      ,      'Modificada'        = CONVERT(NUMERIC(21,4),ROUND(vDurModifiPasivo,4))  
      ,      'Moneda'            = venta_moneda  
      ,      'Capital'           = venta_capital  
      ,      'Saldo'             = venta_saldo /*venta_amortiza +*/   
      ,      'TipoTasa'          = venta_codigo_tasa  
      ,      'Tasa'              = venta_valor_tasa + venta_spread  
,      'vRazonableMn'      = venta_mercado_clp  
      ,      'vRazonableMx'      = venta_mercado_usd  
      ,      'vRazNetoMn'        = Valor_RazonableCLP  
      ,      'vRazNetoMx'        = Valor_RazonableUSD  
      ,      'SubCartera'        = cre_subcartera_normativa  
      ,      'TasaAjustada'      = vTasaPasivaAjusta  
      ,      'OrigenCurva'       = OrigenCurva 
      FROM   BacSwapSuda..CARTERARES with(nolock)  
             INNER JOIN #CarteraSwap ON Numero_Operacion = MiOperacion AND Numero_Flujo = MiFlujo AND Tipo_Flujo = MiTipo  
      WHERE  Fecha_Proceso       = @dFechaProceso  
      AND    Tipo_Flujo          = 2  
      AND    Estado              <> 'C'  
   END  
  
   SELECT 'Relacion' = Numero  
   ,      'CorrRela' = Marca   
   ,      'NetoMonMn'= vRazNetoMn  
   ,      'NetoMonMx'= vRazNetoMx  
   INTO   #nRelNeteo  
   FROM   #CarteraProducto  
   ORDER BY Numero  
  
   UPDATE #nRelNeteo   
      SET NetoMonMn = 0.0   
      ,   NetoMonMx = 0.0   
    WHERE CorrRela  = 'P'  
  
   SELECT  CONVERT(CHAR(10),@dFechaProceso,103) as FecProceso    
   ,       Numero                          as Numero  
   ,      CASE WHEN Marca = 'A' THEN 'ACTIVO'  
               ELSE                  'PASIVO'  
          END                              as Marca  
   ,      CASE WHEN Tipo  = 1   THEN 'IRS'  
               WHEN Tipo  = 2   THEN 'CCS'  
               WHEN Tipo  = 3   THEN 'FRA'  
               WHEN Tipo  = 4   THEN 'SPC'  
          END                              as Tipo  
   ,      Flujo                            as Flujo  
   ,      CONVERT(VARCHAR(25),cA.tbglosa)  as Cartera  
   ,      CONVERT(CHAR(10),FecInicio,103)  as FecInicio  
   ,      CONVERT(CHAR(10),FecTermino,103) as FecTermino  
   ,      Convexidad                       as Convexidad  
   ,      Macaulay                         as Macaulay  
   ,      Modificada                       as Modificada  
   ,      iM.mnnemo                        as Moneda  
   ,      Capital                          as Capita  
   ,      Saldo                            as Saldo  
   ,      CONVERT(VARCHAR(15),iT.tbglosa)  as TipoTasa-- TipoTasa  
   ,      Tasa                             as Tasa  
   ,      vRazonableMn                     as vRazonableMn  
   ,      vRazonableMx                     as vRazonableMx  
   ,      @dFecProceso                     as InformeProceso  
   ,      @dFecEmision                     as InformeEmision  
   ,      @dHorEmision                     as InformeHora  
   ,      @iUsuario                        as Usuario  
   ,      CONVERT(VARCHAR(25),sC.tbglosa)  as SubCartera  
   ,      vRazNetoMn                       as vRazNetoMn  
   ,      vRazNetoMx                       as vRazNetoMx  
   ,      TasaAjustada                     as tasaajustada  
   ,      NetoMonMn                        as DifNetoMonMn  
   ,      NetoMonMx                        as DifNetoMonMx  
   ,      OrigenCurva                          as OrigenCurva  
   ,      'BannerCorto' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
   FROM   #CarteraProducto  
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE it with(nolock) ON iT.tbcateg  = 1042 AND iT.tbcodigo1 = TipoTasa  
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE ca with(nolock) ON cA.tbcateg  = 1111 AND cA.tbcodigo1 = Cartera  
          LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE sc with(nolock) ON sC.tbcateg  = 1554 AND sC.tbcodigo1 = SubCartera  
          LEFT JOIN BacParamSuda..MONEDA                im with(nolock) ON iM.mncodmon = Moneda  
          LEFT JOIN #nRelNeteo                             with(nolock) ON Numero      = Relacion AND Marca = CorrRela  
   ORDER BY Tipo , Numero , Marca  
  
-- SP_INFORME_CARTERA_PRODUCTO '20080403', 'PP'  
  
END  


GO
