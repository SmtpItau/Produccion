USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[GENERA_INFORME_BASILEA_BFW_H_FME]    Script Date: 13-05-2022 10:30:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

-- GENERA_INFORME_BASILEA_BFW_H_FME 'LEO','20081030'

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[GENERA_INFORME_BASILEA_BFW_H_FME] 
   (   @MiUsuario   VARCHAR(15) = ''
   ,   @CFecProc    VARCHAR(10) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

  DECLARE @dFecProc   DATETIME
  DECLARE @dFecFME    DATETIME

      SET @dFecProc = CONVERT(DATETIME,@CFecProc)
      SET @dFecFME  = DATEADD(day, 1, @dFecProc)


   IF @dFecProc = ''
      SET @dFecProc = (SELECT acfecproc FROM MFAC)

   SELECT  vmcodigo , vmvalor INTO #Valor_Moneda                      FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dFecProc AND NOT vmcodigo = 998
                       INSERT INTO #Valor_Moneda SELECT 999 , 1.0
                       INSERT INTO #Valor_Moneda SELECT 13  , vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dFecProc AND vmcodigo = 994
                       INSERT INTO #Valor_Moneda SELECT 998 , vmvalor FROM BacParamSuda..VALOR_MONEDA WHERE vmfecha = @dFecFME  AND vmcodigo = 998

   -- CREA TABLA DE VALORES DE MONEDA NO REAJUSTABLES Tipo Cambio Contable --
   SELECT vmcodigo , vmvalor 
   INTO   #VALOR_TC_CONTABLE 
   FROM   #Valor_Moneda
   WHERE  vmcodigo IN(994,995,997,998,999)

   INSERT INTO #VALOR_TC_CONTABLE
   SELECT vmcodigo           = CASE WHEN Codigo_Moneda = 994 THEN 13 ELSE Codigo_Moneda END
   ,      vmvalor            = Tipo_Cambio
   FROM   BacParamSuda..VALOR_MONEDA_CONTABLE
   WHERE  Fecha              = @dFecFME  
   AND    Codigo_Moneda NOT IN(13,995,997,998,999)
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
   FROM	   MFCAres
           LEFT  JOIN BacParamSuda..CLIENTE                              ON cacodigo      = clrut and cacodcli	  = clcodigo
           INNER JOIN BacParamSuda..MONEDA                               ON mncodmon      = cacodmon1
           INNER JOIN BacParamSuda..TBL_AGRUPA_CLASIFICACION_RIESGO_PAIS ON mnClasificaRiesgoPais = Acrp_CodigoClasificacion
           LEFT  JOIN BacParamSuda..TBL_FACTOR_VENCIMIENTO_RESIDUAL      ON Fvr_IdSistema = 'BFW' AND Fvr_Producto = cacodpos1 and (DATEDIFF(DAY,@dFecProc,cafecvcto) BETWEEN Fvr_PlazoDesde AND Fvr_PlazoHasta)
           LEFT  JOIN #VALOR_TC_CONTABLE                                 ON vmcodigo      = cacodmon1
           LEFT  JOIN BacParamSuda..PRODUCTO                        pr   ON pr.id_sistema = 'BFW' AND CONVERT(INT,pr.codigo_producto) = cacodpos1
   WHERE   CaFechaProceso = @dFecProc
   AND     cafecvcto      > @dFecProc  
   AND 	   fres_obtenido  > 0.0
--   AND	   cacodigo	 <> 96665450
   ORDER BY cacodpos1 , catipoper , canumoper

END



GO
