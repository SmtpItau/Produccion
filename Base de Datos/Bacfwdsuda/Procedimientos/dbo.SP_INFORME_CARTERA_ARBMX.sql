USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORME_CARTERA_ARBMX]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_INFORME_CARTERA_ARBMX]
   (   @iCarteraFinanciera   INT   
   ,   @cUsuario             VARCHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProceso   CHAR(10)
       SET @dFechaProceso   = (SELECT CONVERT(CHAR(10),acfecproc,103) FROM MFAC with (nolock)) 

   DECLARE @dFechaEmision   CHAR(10)
       SET @dFechaEmision   = CONVERT(CHAR(10),GETDATE(),103)

   DECLARE @hHoraEmision    CHAR(10)
       SET @hHoraEmision    = CONVERT(CHAR(10),GETDATE(),108)

   DECLARE @Glosacartera    VARCHAR(50)
       SET @Glosacartera    = CASE WHEN @iCarteraFinanciera = 0 THEN 'TODAS LAS CARTERAS'
                                   ELSE (SELECT DISTINCT rcnombre FROM BacParamSuda..TIPO_CARTERA with (nolock) WHERE rcsistema = 'BFW' AND rcrut = @iCarteraFinanciera)
                              END

   SELECT 'Contrato'             = a.canumoper
      ,   'Movimiento'           = CASE WHEN a.catipoper = 'C' THEN 'COMPRA' ELSE 'VENTA' END
      ,   'Producto'             = a.cacodpos1
      ,   'GlosaProducto'        = CONVERT(VARCHAR(25),f.descripcion)
      ,   'Modalidad'            = CASE WHEN a.catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
      ,   'Rut'                  = CONVERT(VARCHAR(15),LTRIM(RTRIM(b.clrut)) + '-' + LTRIM(RTRIM(b.cldv)))
      ,   'Nombre'               = CONVERT(VARCHAR(30),b.clnombre)
      ,   'FechaInicio'          = a.cafecha
      ,   'PlazoOperacion'       = a.caplazo
      ,   'PlazoRemanente'       = a.caplazovto
      ,   'FechaVencimiento'     = a.cafecvcto
      ,   'FechaEfectiva'        = a.cafecEfectiva
      ,   'Moneda'               = d.mnnemo --> a.cacodmon1
      ,   'Nocional'             = a.camtomon1
      ,   'MonedaCnv'            = e.mnnemo --> a.cacodmon2
      ,   'Conversion'           = a.camtomon2 * CONVERT(NUMERIC(21,4),a.catipcam*a.capremon2)
      ,   'Precio'               = CONVERT(NUMERIC(21,4),a.catipcam*a.capremon2)
      ,   'Paridad'              = CONVERT(NUMERIC(21,4),a.caparmon2)
      ,   'Dolar'                = CONVERT(NUMERIC(21,4),a.capremon2)
      ,   'TipoCambioForward'    = CONVERT(NUMERIC(21,4),a.catipcamFwd)
      ,   'vRazonable'           = a.fres_obtenido
      ,   'vPrecio'              = CONVERT(NUMERIC(21,4),a.fval_obtenido)
      ,   'TasaMoneda1'          = CONVERT(NUMERIC(21,4),a.catasaEfectMon1)
      ,   'TasaMoneda2'          = CONVERT(NUMERIC(21,4),a.catasaEfectMon2)
      ,   'FPagoMn'              = CONVERT(VARCHAR(30),ISNULL(p.glosa,''))
      ,   'FPagoMx'              = CONVERT(VARCHAR(30),ISNULL(q.glosa,''))
      ,   'CarteraNormativa'     = CONVERT(VARCHAR(20),ISNULL(n.tbglosa,'No Definida'))
      ,   'SubcarteraNormativa'  = CONVERT(VARCHAR(20),ISNULL(m.tbglosa,'No Definida'))
      ,   'LibroNegociacion'     = CONVERT(VARCHAR(20),ISNULL(t.tbglosa,'No Definida'))
      ,   'FechaProceso'         = @dFechaProceso
      ,   'FechaEmision'         = @dFechaEmision
      ,   'HoraEmision'          = @hHoraEmision
      ,   'Usuario'              = @cUsuario
      ,   'CarteraFinanciera'    = @Glosacartera
      ,   'Dolares'              = a.camtomon2 -- caequusd1
   INTO    #TMP_INF_CARTERA_ARBMX
   FROM    MFCA                                  a with (nolock)
           LEFT JOIN BacParamSuda..CLIENTE       b ON b.clrut      = a.cacodigo AND b.clcodigo        = a.cacodcli
           LEFT JOIN BacParamSuda..PRODUCTO      f ON f.id_sistema = 'BFW'      AND f.codigo_producto = a.cacodpos1
           LEFT JOIN BacParamSuda..TIPO_CARTERA  h ON h.rcsistema  = 'BFW'      AND h.rccodpro        = a.cacodpos1 AND h.rcrut = a.cacodcart
           LEFT JOIN BacParamSuda..MONEDA        d ON d.mncodmon   = a.cacodmon1
           LEFT JOIN BacParamSuda..MONEDA        e ON e.mncodmon   = a.cacodmon2
           LEFT JOIN VIEW_TABLA_GENERAL_DETALLE  n ON n.tbcateg    = '1111'     AND n.tbcodigo1 = a.cacartera_normativa
           LEFT JOIN VIEW_TABLA_GENERAL_DETALLE  m ON m.tbcateg    = '1554'     AND m.tbcodigo1 = a.casubcartera_normativa
           LEFT JOIN VIEW_TABLA_GENERAL_DETALLE  t ON t.tbcateg    = '1552'     AND t.tbcodigo1 = a.calibro
           LEFT JOIN BacParamSuda..FORMA_DE_PAGO p ON p.codigo     = a.cafpagomn
           LEFT JOIN BacParamSuda..FORMA_DE_PAGO q ON q.codigo     = a.cafpagomx
   WHERE   a.cacodpos1           = 2 and var_moneda2 > 0
--     AND   a.caestado            = ''
     AND  (a.cacodcart           = @iCarteraFinanciera OR @iCarteraFinanciera = 0)
   ORDER BY a.canumoper 


   IF EXISTS( SELECT 1 FROM #TMP_INF_CARTERA_ARBMX)
   BEGIN
      SELECT * 
        FROM #TMP_INF_CARTERA_ARBMX
   END ELSE
   BEGIN
      SELECT 'Contrato'             = ''
         ,   'Movimiento'           = ''
         ,   'Producto'             = ''
         ,   'GlosaProducto'        = ''
         ,   'Modalidad'            = ''
         ,   'Rut'                  = ''
         ,   'Nombre'               = ''
         ,   'FechaInicio'          = ''
         ,   'PlazoOperacion'       = ''
         ,   'PlazoRemanente'       = ''
         ,   'FechaVencimiento'     = ''
         ,   'FechaEfectiva'        = ''
         ,   'Moneda'               = ''
         ,   'Nocional'             = ''
         ,   'MonedaCnv'            = ''
         ,   'Conversion'           = ''
         ,   'Precio'               = ''
         ,   'Paridad'              = ''
         ,   'Dolar'                = ''
         ,   'TipoCambioForward'    = ''
         ,   'vRazonable'           = ''
         ,   'vPrecio'              = ''
         ,   'TasaMoneda1'          = ''
         ,   'TasaMoneda2'          = ''
         ,   'FPagoMn'              = ''
         ,   'FPagoMx'              = ''
         ,   'CarteraNormativa'     = ''
         ,   'SubcarteraNormativa'  = ''
         ,   'LibroNegociacion'     = ''
         ,   'FechaProceso'         = @dFechaProceso
         ,   'FechaEmision'         = @dFechaEmision
         ,   'HoraEmision'          = @hHoraEmision
         ,   'Usuario'              = @cUsuario
         ,   'CarteraFinanciera'    = @Glosacartera
         ,   'Dolares'              = ''
   END

END

GO
