USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[GENERA_INFORME_BASILEA_PCS]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- GENERA_INFORME_BASILEA_PCS 'CBB'

CREATE PROCEDURE [dbo].[GENERA_INFORME_BASILEA_PCS]
   (   @MiUsuario   VARCHAR(15)   )
AS
BEGIN

   SET NOCOUNT ON
-- Swap: Guardar Como
   DECLARE @dFecProc   DATETIME
   SELECT  @dFecProc   = fechaproc
   FROM    SWAPGENERAL

   DECLARE @iFound      INTEGER
   SELECT  @iFound      = -1
   SELECT  @iFound      = 0
   FROM    BacParamSuda..VALOR_MONEDA_CONTABLE
   WHERE   Fecha        = @dFecProc
   AND     Tipo_Cambio <> 0

   IF @iFound = -1
   BEGIN
      RAISERROR('¡ NO EXISTEN VALORES DE MONEDAS CONTABLES A LA FECHA DE HOY. ! ',16,6,'ERROR.')
      RETURN
   END

   SELECT  vmcodigo
   ,       vmvalor
   INTO    #Valor_Moneda
   FROM    BacParamSuda..VALOR_MONEDA
   WHERE   vmfecha = @dFecProc

   INSERT INTO #Valor_Moneda
   SELECT 999 , 1.0

   INSERT INTO #Valor_Moneda
   SELECT 13
   ,      vmvalor
   FROM   BacParamSuda..VALOR_MONEDA
   WHERE  vmfecha  = @dFecProc
   AND    vmcodigo = 994

   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --
   SELECT vmcodigo = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
   ,      vmvalor  = Tipo_Cambio
   INTO   #VALOR_TC_CONTABLE
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE 
   WHERE  Fecha    = @dFecProc
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)

   -- INSERTA VALORES DE MONEDA REAJUSTABLES Tipo Cambio del día          --
   INSERT INTO #VALOR_TC_CONTABLE
   SELECT vmcodigo
   ,      vmvalor
   FROM   #Valor_Moneda
   WHERE  vmcodigo  IN(994,995,997,998,999)

   SELECT  DISTINCT
           MiContrato   = c.Numero_Operacion
   ,       MiRutCliente = clrut
   ,       MiCliente    = CONVERT(CHAR(40),isnull(clnombre,'Cliente No Encontrado'))
   ,       MiProducto   = c.Tipo_Swap
   ,       MiGlosaProd  = CASE WHEN c.Tipo_Swap = 1  THEN 'SWAP DE TASAS'
                               WHEN c.Tipo_Swap = 2  THEN 'SWAP DE MONEDAS'
                               WHEN c.Tipo_Swap = 3  THEN 'FORWARD RATE AGREETMEN'
                               WHEN c.Tipo_Swap = 4  THEN 'SWAP PROMEDIO CAMARA'
                          END
   ,       MiNocional   = CASE WHEN c.Tipo_Flujo = 1 THEN c.compra_capital ELSE c.venta_capital END
   ,       MiMoneda     = mnnemo
   ,       MiFecha      = c.Fecha_Inicio
   ,       MiVcto       = c.Fecha_Termino
   ,       MiPlazo      = DATEDIFF(DAY,@dFecProc,c.Fecha_Termino)
   ,       MiValMon     = CONVERT(NUMERIC(21,4),vmvalor)
   ,       MiFactor     = CASE WHEN c.Tipo_Swap     <> 2 THEN Fvr_Factor1
                               WHEN Acrp_CodigoGrupo = 1 THEN Fvr_Factor1
                               ELSE                           Fvr_Factor2
                          END
   ,       MiMontoMatriz= CASE WHEN c.Tipo_Swap      <> 2 AND c.Tipo_Flujo = 1 THEN (((c.compra_capital * vmvalor) * Fvr_Factor1)/100.0)
  --                             WHEN c.Tipo_Swap      <> 2 AND c.Tipo_Flujo = 2 THEN (((c.venta_capital  * vmvalor) * Fvr_Factor1)/100.0)
                               WHEN Acrp_CodigoGrupo  = 1 AND c.Tipo_Flujo = 1 THEN (((c.compra_capital * vmvalor) * Fvr_Factor1)/100.0)
  --                             WHEN Acrp_CodigoGrupo  = 1 AND c.Tipo_Flujo = 2 THEN (((c.venta_capital  * vmvalor) * Fvr_Factor1)/100.0)
                               WHEN Acrp_CodigoGrupo <> 1 AND c.Tipo_Flujo = 1 THEN (((c.compra_capital * vmvalor) * Fvr_Factor2)/100.0)
  --                             WHEN Acrp_CodigoGrupo <> 1 AND c.Tipo_Flujo = 2 THEN (((c.venta_capital  * vmvalor) * Fvr_Factor2)/100.0)
                          END
   ,       MiVRazonable = CONVERT(NUMERIC(21,0),ROUND(c.Valor_RazonableCLP,0))        -->   CONVERT(NUMERIC(21,0),ROUND(c.Valor_RazonableCLP,0))
   ,       MiCalculoA   = CASE WHEN c.Tipo_Swap      <> 2 AND c.Tipo_Flujo = 1 THEN (((c.compra_capital * vmvalor) * Fvr_Factor1)/100.0)
                               WHEN Acrp_CodigoGrupo  = 1 AND c.Tipo_Flujo = 1 THEN (((c.compra_capital * vmvalor) * Fvr_Factor1)/100.0)
                               WHEN Acrp_CodigoGrupo <> 1 AND c.Tipo_Flujo = 1 THEN (((c.compra_capital * vmvalor) * Fvr_Factor2)/100.0)
                          END + CONVERT(NUMERIC(21,0),ROUND(c.Valor_RazonableCLP,0))

/*   ,       MiCalculoA   = CASE WHEN c.Tipo_Swap      <> 2 AND c.Tipo_Flujo = 1 THEN (((c.compra_capital * vmvalor) * Fvr_Factor1)/100.0)
                                 WHEN c.Tipo_Swap      <> 2 AND c.Tipo_Flujo = 2 THEN (((c.venta_capital  * vmvalor) * Fvr_Factor1)/100.0)
                                 WHEN Acrp_CodigoGrupo  = 1 AND c.Tipo_Flujo = 1 THEN (((c.compra_capital * vmvalor) * Fvr_Factor1)/100.0)
                                 WHEN Acrp_CodigoGrupo  = 1 AND c.Tipo_Flujo = 2 THEN (((c.venta_capital  * vmvalor) * Fvr_Factor1)/100.0)
                                 WHEN Acrp_CodigoGrupo <> 1 AND c.Tipo_Flujo = 1 THEN (((c.compra_capital * vmvalor) * Fvr_Factor2)/100.0)
                                 WHEN Acrp_CodigoGrupo <> 1 AND c.Tipo_Flujo = 2 THEN (((c.venta_capital  * vmvalor) * Fvr_Factor2)/100.0)
                            END  + CONVERT(NUMERIC(21,0),ROUND(c.Valor_RazonableCLP,0)) --> + CONVERT(NUMERIC(21,0),ROUND(c.Valor_RazonableCLP,0))
*/ 

   ,       FechaProceso = CONVERT(CHAR(10),@dFecProc,103)
   ,       FechaEmision = CONVERT(CHAR(10),GETDATE(),103)
   ,       HoraEmision  = CONVERT(CHAR(10),GETDATE(),108)
   ,       Usuario      = @MiUsuario
   FROM	   CARTERA c
           LEFT JOIN BacParamSuda..CLIENTE     				ON c.rut_cliente = clrut and c.codigo_cliente = clcodigo
           LEFT JOIN BacParamSuda..MONEDA      				ON mncodmon      = CASE WHEN c.Tipo_Flujo = 1 THEN c.compra_moneda ELSE c.venta_moneda END
           LEFT JOIN #VALOR_TC_CONTABLE  		 		ON vmcodigo      = mncodmon
           LEFT JOIN BacParamSuda..TBL_FACTOR_VENCIMIENTO_RESIDUAL      ON Fvr_IdSistema = 'PCS' AND Fvr_Producto = c.Tipo_Swap and (DATEDIFF(DAY,@dFecProc,c.Fecha_Termino) BETWEEN Fvr_PlazoDesde AND Fvr_PlazoHasta)
           LEFT JOIN BacParamSuda..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS ON mnClasificaRiesgoPais = Acrp_CodigoClasificacion
   WHERE   
           c.Valor_RazonableCLP > 0          --> c.Valor_RazonableCLP > 0
--   AND     rut_cliente      <> 96665450      --> R.U.T. de la Corredora Corp Banca
   AND     Estado           <> 'C'
   AND     tipo_Flujo          =  1
END




GO
