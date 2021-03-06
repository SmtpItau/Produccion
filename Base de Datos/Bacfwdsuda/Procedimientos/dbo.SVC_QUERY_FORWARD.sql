USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_QUERY_FORWARD]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

--SVC_QUERY_FORWARD '20090529'
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
CREATE PROCEDURE [dbo].[SVC_QUERY_FORWARD]
--   (   @cFechaConsulta   CHAR(8)  )
   (   @dFechaConsulta   DATETIME =''  )

AS
BEGIN

   SET NOCOUNT ON

--declare @dFechaConsulta   DATETIME 
--SET @dFechaConsulta   = CONVERT(DATETIME,@cFechaConsulta ,112)    

   DECLARE @dFechaProceso    DATETIME
       SET @dFechaProceso    = (SELECT acfecproc FROM BacFwdSuda..MFAC with(nolock) )

   SELECT cacodpos1
        , cacodmon1
        , cacodmon2
        , camtomon1
        , camtomon2
        , camtocomp
        , ValorRazonableActivo
        , ValorRazonablePasivo
        , fRes_Obtenido
        , vrcambio
        , vrtasa
        , vrdevengo
        , cafecvcto
        , cacartera_normativa
        , cacodcart
        , calibro
        , caantici
        , catipmoda
   INTO #TMP_CARTERA_FORWARD
   FROM BacFwdSuda..MFCA with(nolock)

   IF @dFechaProceso <> @dFechaConsulta
   BEGIN
      DELETE FROM #TMP_CARTERA_FORWARD

      INSERT INTO #TMP_CARTERA_FORWARD
      SELECT cacodpos1
           , cacodmon1
           , cacodmon2
           , camtomon1
           , camtomon2
           , camtocomp
           , ValorRazonableActivo
           , ValorRazonablePasivo
           , fRes_Obtenido
           , vrcambio
           , vrtasa
           , vrdevengo
           , cafecvcto
           , cacartera_normativa
           , cacodcart
           , calibro
           , caantici
           , catipmoda
      FROM   BacFwdSuda..MFCARES with(nolock)
      WHERE  CaFechaProceso = @dFechaConsulta
   END

/*   

   SELECT Producto               = CASE WHEN ca.cacodpos1 = 1  THEN 'SEGUROS DE CAMBIO'
                                        WHEN ca.cacodpos1 = 2  THEN 'ARBITRAJE FUTURO'
                                        WHEN ca.cacodpos1 = 3  THEN 'SEGURO INFLACION'
                                        WHEN ca.cacodpos1 = 10 THEN 'FORWARD BOND TRADES'
                                        WHEN ca.cacodpos1 = 11 THEN 'T-LOOK'
                                        WHEN ca.cacodpos1 = 12 THEN 'ARBITRAJE MX-$'
                                        WHEN ca.cacodpos1 = 13 THEN 'SEGURO INFLACION HIPOTECARIO'
                                    END
   ,      cacartera_normativa    = nm.tbglosa
   ,      cartera_financiera     = fn.tbglosa
   ,      MonedaOperacion        = m1.mnnemo
   ,      MonedaConversion       = m2.mnnemo
   ,      DiferenciaPrecio       = SUM( ca.camtocomp )
   ,      Nocional               = SUM( ca.camtomon1 )
   ,      Conversion             = SUM( ca.camtomon2 )
   ,      vRazonableActivo       = SUM( ca.ValorRazonableActivo )
   ,      vRazonablePasivo       = SUM( ca.ValorRazonablePasivo )
   ,      vRazonableNeto         = SUM( ca.fRes_Obtenido )
   ,      VariacionMoneda        = SUM( ca.vrcambio )
   ,      VariacionTasa          = SUM( ca.vrtasa )
   ,      VariacionDevengo       = SUM( ca.vrdevengo )
   FROM   #TMP_CARTERA_FORWARD                            ca with(nolock) 
          INNER JOIN BacParamSuda..MONEDA                 m1 with(nolock) ON m1.mncodmon  = ca.cacodmon1
          INNER JOIN BacParamSuda..MONEDA                 m2 with(nolock) ON m2.mncodmon  = ca.cacodmon2
          LEFT  JOIN BacParamSuda..VALOR_MONEDA          uno with(nolock) ON uno.vmfecha  = cafecvcto AND uno.vmcodigo = ca.cacodmon1
          LEFT  JOIN BacParamSuda..VALOR_MONEDA          dos with(nolock) ON dos.vmfecha  = cafecvcto AND dos.vmcodigo = 994
          INNER JOIN BacparamSuda..TABLA_GENERAL_DETALLE  nm with(nolock) ON nm.tbcateg   = 1111      AND nm.tbcodigo1 = ca.cacartera_normativa
          INNER JOIN BacparamSuda..TABLA_GENERAL_DETALLE  fn with(nolock) ON fn.tbcateg   = 204       AND fn.tbcodigo1 = ca.cacodcart
   WHERE  caantici       <> 'A'
--   AND     ca.catipmoda    = 'C' --CBB
   AND    ca.cafecvcto    = @dFechaProceso
   GROUP BY ca.cacodpos1, ca.cacartera_normativa, nm.tbglosa, fn.tbglosa, ca.calibro, m1.mnnemo, m2.mnnemo
  
   UNION
*/   
   SELECT Producto               = CASE WHEN ca.cacodpos1 = 1  THEN 'SEGUROS DE CAMBIO'
                                        WHEN ca.cacodpos1 = 2  THEN 'ARBITRAJE FUTURO'
                                        WHEN ca.cacodpos1 = 3  THEN 'SEGURO INFLACION'
                                        WHEN ca.cacodpos1 = 10 THEN 'FORWARD BOND TRADES'
                                        WHEN ca.cacodpos1 = 11 THEN 'T-LOOK'
                                        WHEN ca.cacodpos1 = 12 THEN 'ARBITRAJE MX-$'
                                        WHEN ca.cacodpos1 = 13 THEN 'SEGURO INFLACION HIPOTECARIO'
                                    END
   ,      cacartera_normativa    = nm.tbglosa
   ,      cartera_financiera     = fn.tbglosa
   ,      MonedaOperacion        = m1.mnnemo
   ,      MonedaConversion       = m2.mnnemo
   ,      DiferenciaPrecio       = SUM( ca.camtocomp )--0 --CBB
   ,      Nocional               = SUM( ca.camtomon1 )
   ,      Conversion             = SUM( ca.camtomon2 )
   ,      vRazonableActivo       = SUM( ca.ValorRazonableActivo )
   ,      vRazonablePasivo       = SUM( ca.ValorRazonablePasivo )
   ,      vRazonableNeto         = SUM( ca.fRes_Obtenido )
   ,      VariacionMoneda        = SUM( ca.vrcambio )
   ,      VariacionTasa          = SUM( ca.vrtasa )
   ,      VariacionDevengo       = SUM( ca.vrdevengo )
   FROM   #TMP_CARTERA_FORWARD                            ca with(nolock) 
          INNER JOIN BacParamSuda..MONEDA                 m1 with(nolock) ON m1.mncodmon  = ca.cacodmon1
          INNER JOIN BacParamSuda..MONEDA                 m2 with(nolock) ON m2.mncodmon  = ca.cacodmon2
          INNER JOIN BacparamSuda..TABLA_GENERAL_DETALLE  nm with(nolock) ON nm.tbcateg   = 1111      AND nm.tbcodigo1 = ca.cacartera_normativa
          INNER JOIN BacparamSuda..TABLA_GENERAL_DETALLE  fn with(nolock) ON fn.tbcateg   = 204       AND fn.tbcodigo1 = ca.cacodcart
          LEFT  JOIN BacParamSuda..VALOR_MONEDA          uno with(nolock) ON uno.vmfecha  = cafecvcto AND uno.vmcodigo = ca.cacodmon1
          LEFT  JOIN BacParamSuda..VALOR_MONEDA          dos with(nolock) ON dos.vmfecha  = cafecvcto AND dos.vmcodigo = 994
   WHERE  caantici       <> 'A'
--   AND    ca.catipmoda    = 'C' --CBB
--   AND    ca.cafecvcto    > @dFechaProceso
   GROUP BY ca.cacodpos1, ca.cacartera_normativa, nm.tbglosa, fn.tbglosa, m1.mnnemo, m2.mnnemo
--   GROUP BY ca.cacodpos1, ca.cacartera_normativa, nm.tbglosa, fn.tbglosa, ca.calibro, m1.mnnemo, m2.mnnemo
   
END



GO
