USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[GENERA_INFORME_BASILEA_BFW_HISTORICO]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[GENERA_INFORME_BASILEA_BFW_HISTORICO]
   (   @Fecha       DATETIME
   ,   @MiUsuario   VARCHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFecProc   DATETIME
       SET @dFecProc   = (SELECT acfecproc FROM MFAC with(nolock))

   DECLARE @iRutCorpCapital   NUMERIC(9)
       SET @iRutCorpCapital   = 96665450

   SELECT canumoper
      ,   cacodigo
      ,   cacodcli
      ,   catipoper
      ,   cacodpos1
      ,   camtomon1
      ,   cafecha
      ,   cafecvcto
      ,   capremon1
      ,   fres_Obtenido
      ,   cacodmon1
     INTO #MFCA_TMP_BASILEA
     FROM MFCA          with(nolock)
    WHERE cafecvcto     > @dFecProc  
      AND fres_obtenido > 0.0
--      AND cacodigo     <> @iRutCorpCapital --> Corp Capital Corredoras de Bolsa

   IF @Fecha <> @dFecProc
   BEGIN
      DELETE FROM #MFCA_TMP_BASILEA

      INSERT INTO #MFCA_TMP_BASILEA
      SELECT canumoper
         ,   cacodigo
         ,   cacodcli
         ,   catipoper
         ,   cacodpos1
         ,   camtomon1
         ,   cafecha
         ,   cafecvcto
         ,   capremon1
         ,   fres_Obtenido
         ,   cacodmon1
        FROM MFCARES        with(nolock)
       WHERE CaFechaProceso = @Fecha
         AND cafecvcto      > @Fecha
         AND fres_obtenido  > 0.0
--         AND cacodigo      <> @iRutCorpCapital --> Corp Capital Corredoras de Bolsa
   END

   SELECT  vmcodigo , vmvalor INTO #Valor_Moneda                      FROM BacParamSuda..VALOR_MONEDA with (nolock) WHERE vmfecha = @dFecProc
                       INSERT INTO #Valor_Moneda SELECT 999 , 1.0
                       INSERT INTO #Valor_Moneda SELECT 13  , vmvalor FROM BacParamSuda..VALOR_MONEDA with (nolock) WHERE vmfecha = @dFecProc AND vmcodigo = 994

   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --
   SELECT vmcodigo , vmvalor 
   INTO   #VALOR_TC_CONTABLE 
   FROM   #Valor_Moneda
   WHERE  vmcodigo IN(994,995,997,998,999)

   INSERT INTO #VALOR_TC_CONTABLE
   SELECT vmcodigo           = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
   ,      vmvalor            = Tipo_Cambio
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE   with (nolock)
   WHERE  Fecha              = @dFecProc
   AND    Codigo_Moneda      NOT IN(13,995,997,998,999)
   AND    Tipo_Cambio       <> 0.0

   
   SELECT  MiContrato   = canumoper
   ,       MiRutCliente = CONVERT(CHAR(11),REPLICATE('0', 9 - LEN(LTRIM(RTRIM(cacodigo)))) + LTRIM(RTRIM(CONVERT(CHAR(10),cacodigo))) + '-' + CONVERT(CHAR(1),cldv))
   ,       MiCliente    = CONVERT(CHAR(40),ISNULL(clnombre,'Cliente No Encontrado'))
   ,       MiTipoOper   = catipoper
   ,       MiProducto   = cacodpos1
   ,       MiGlosaProd  = CONVERT(CHAR(20),pr.descripcion)
   ,       MiNocional   = camtomon1
   ,       MiMoneda     = mnnemo
   ,       MiFecha      = cafecha
   ,       MiVcto       = cafecvcto
   ,       MiPlazo      = DATEDIFF(DAY,@dFecProc,cafecvcto)
   ,       MiPrecio     = CONVERT(NUMERIC(21,4),capremon1)
   ,       MiValMon     = CONVERT(NUMERIC(21,4),vmvalor)
   ,       MiFactor     = CASE WHEN cacodpos1        = 10 THEN Fvr_Factor1
                               WHEN Acrp_CodigoGrupo = 1  THEN Fvr_Factor1 
                               ELSE                            Fvr_Factor2
                          END
   ,       MiVRazonable = CONVERT(NUMERIC(21,0),ROUND(fres_Obtenido,0))
   ,       MiMontoMatriz= CASE WHEN cacodpos1        = 10 THEN (((camtomon1 * vmvalor) * Fvr_Factor1)/100.0)
                               WHEN Acrp_CodigoGrupo = 1  THEN (((camtomon1 * vmvalor) * Fvr_Factor1)/100.0)
                               ELSE                            (((camtomon1 * vmvalor) * Fvr_Factor2)/100.0)
                          END
   ,       MiCalculoA   = CASE WHEN cacodpos1        = 10 THEN ((((camtomon1 * vmvalor) * Fvr_Factor1)/100.0) + CONVERT(NUMERIC(21,0),ROUND(fres_Obtenido,0)))
                    WHEN Acrp_CodigoGrupo = 1  THEN ((((camtomon1 * vmvalor) * Fvr_Factor1)/100.0) + CONVERT(NUMERIC(21,0),ROUND(fres_Obtenido,0)))
                               ELSE                            ((((camtomon1 * vmvalor) * Fvr_Factor2)/100.0) + CONVERT(NUMERIC(21,0),ROUND(fres_Obtenido,0)))
                          END
   ,       FechaProceso = CONVERT(CHAR(10),@dFecProc,103)
   ,       FechaEmision = CONVERT(CHAR(10),GETDATE(),103)
   ,       HoraEmision  = CONVERT(CHAR(10),GETDATE(),108)
   ,       Usuario      = @MiUsuario
   ,       FechaDatos   = CONVERT(CHAR(10),@Fecha,103)
   FROM	   #MFCA_TMP_BASILEA --> MFCA                                    with (nolock) 
           LEFT  JOIN BacParamSuda..CLIENTE                              with (nolock) ON cacodigo      = clrut and cacodcli	  = clcodigo
           INNER JOIN BacParamSuda..MONEDA                               with (nolock) ON mncodmon      = cacodmon1
           INNER JOIN BacParamSuda..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS with (nolock) ON mnClasificaRiesgoPais = Acrp_CodigoClasificacion
           LEFT  JOIN BacParamSuda..TBL_FACTOR_VENCIMIENTO_RESIDUAL      with (nolock) ON Fvr_IdSistema = 'BFW' AND Fvr_Producto = cacodpos1 and (DATEDIFF(DAY,@dFecProc,cafecvcto) BETWEEN Fvr_PlazoDesde AND Fvr_PlazoHasta)
           LEFT  JOIN #VALOR_TC_CONTABLE                                 with (nolock) ON vmcodigo      = cacodmon1
           LEFT  JOIN BacParamSuda..PRODUCTO                        pr   with (nolock) ON pr.id_sistema = 'BFW' AND CONVERT(INT,pr.codigo_producto) = cacodpos1
   ORDER BY cacodpos1 , catipoper , canumoper

END



GO
