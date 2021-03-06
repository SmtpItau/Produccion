USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VCTOS_ML_EX_LISTADO_CARTERA]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_VCTOS_ML_EX_LISTADO_CARTERA]
   (   @Fechac	 CHAR(10)   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @Pais          INT
   ,       @banco         CHAR(30)
   ,       @Fecha         DATETIME
   ,       @FechaProceso  DATETIME
   ,       @USDDia        FLOAT

   DECLARE @FechaEmision  CHAR(10)
   ,       @HoraEmision   CHAR(10)

   SELECT  @Pais         = acpais
   ,       @Banco        = acnomprop
   ,       @Fecha        = @Fechac
   ,       @FechaProceso = acfecproc
   ,       @FechaEmision = CONVERT(CHAR(10),GETDATE(),103)
   ,       @HoraEmision  = CONVERT(CHAR(10),GETDATE(),108)
   FROM    MFAC

   SELECT  @USDDia       = VmValor
   FROM    BacParamSuda..VALOR_MONEDA 
   WHERE   vmcodigo      = 994
   AND     vmfecha       = @Fechac

   SELECT  canumoper
   ,       catipoper
   ,       catipmoda
   ,       cacodpos1
   ,       camtomon1
   ,       cavalordia
   ,       fres_obtenido
   ,       cafecha
   ,       cafecvcto
   ,       cafecefectiva
   ,       caplazo
   ,       cacodmon1
   ,       cacodmon2
   ,       cacodigo
   ,       cacodcli
   ,       cacodcart
   INTO    #MiCartera
   FROM    MFCA
   WHERE   cafecefectiva  >= @Fecha
     and   cafecvcto > @Fecha

   IF @Fecha < @FechaProceso
   BEGIN
      DELETE #MiCartera
      
      INSERT INTO #MiCartera
      SELECT  canumoper 
      ,       catipoper 
      ,       catipmoda 
      ,       cacodpos1 
      ,       camtomon1 
      ,       cavalordia 
      ,       fres_obtenido 
      ,       cafecha 
      ,       cafecvcto 
      ,       cafecefectiva
      ,       caplazo
      ,       cacodmon1
      ,       cacodmon2
      ,       cacodigo
      ,       cacodcli
      ,       cacodcart
      FROM    MFCARES
      WHERE   cafechaproceso  = @Fecha
      AND     cafecefectiva  >= @Fecha
 and   cafecvcto > @Fecha
   END

   DECLARE @SegCam_AvrPositivo   NUMERIC(21,4)
   ,       @SegCam_AvrNegativo   NUMERIC(21,4)
   DECLARE @SegInf_AvrPositivo   NUMERIC(21,4)
   ,       @SegInf_AvrNegativo   NUMERIC(21,4)
   DECLARE @Arbitr_AvrPositivo   NUMERIC(21,4)
   ,       @Arbitr_AvrNegativo   NUMERIC(21,4)
   DECLARE @ForBon_AvrPositivo   NUMERIC(21,4)
   ,       @ForBon_AvrNegativo   NUMERIC(21,4)
   DECLARE @TLooks_AvrPositivo   NUMERIC(21,4)
   ,       @TLooks_AvrNegativo   NUMERIC(21,4)

   SELECT @SegCam_AvrPositivo = ISNULL(SUM(fres_obtenido),0.0) FROM #MiCartera WHERE fres_obtenido >= 0.0 AND cacodpos1 = 1  GROUP BY cacodpos1
   SELECT @SegCam_AvrNegativo = ISNULL(SUM(fres_obtenido),0.0) FROM #MiCartera WHERE fres_obtenido  < 0.0 AND cacodpos1 = 1  GROUP BY cacodpos1
   SELECT @Arbitr_AvrPositivo = ISNULL(SUM(fres_obtenido),0.0) FROM #MiCartera WHERE fres_obtenido >= 0.0 AND cacodpos1 = 2  GROUP BY cacodpos1
   SELECT @Arbitr_AvrNegativo = ISNULL(SUM(fres_obtenido),0.0) FROM #MiCartera WHERE fres_obtenido  < 0.0 AND cacodpos1 = 2  GROUP BY cacodpos1
   SELECT @SegInf_AvrPositivo = ISNULL(SUM(fres_obtenido),0.0) FROM #MiCartera WHERE fres_obtenido >= 0.0 AND cacodpos1 = 3  GROUP BY cacodpos1
   SELECT @SegInf_AvrNegativo = ISNULL(SUM(fres_obtenido),0.0) FROM #MiCartera WHERE fres_obtenido  < 0.0 AND cacodpos1 = 3  GROUP BY cacodpos1
   SELECT @ForBon_AvrPositivo = ISNULL(SUM(fres_obtenido),0.0) FROM #MiCartera WHERE fres_obtenido >= 0.0 AND cacodpos1 = 10 GROUP BY cacodpos1
   SELECT @ForBon_AvrNegativo = ISNULL(SUM(fres_obtenido),0.0) FROM #MiCartera WHERE fres_obtenido  < 0.0 AND cacodpos1 = 10 GROUP BY cacodpos1
   SELECT @TLooks_AvrPositivo = ISNULL(SUM(fres_obtenido  ),0.0) FROM #MiCartera WHERE fres_obtenido >= 0.0 AND cacodpos1 = 11 GROUP BY cacodpos1
   SELECT @TLooks_AvrNegativo = ISNULL(SUM(fres_obtenido  ),0.0) FROM #MiCartera WHERE fres_obtenido  < 0.0 AND cacodpos1 = 11 GROUP BY cacodpos1
   
   SELECT 'Operación'                               = ca.canumoper
   ,      'TipoOp'                                  = ca.catipoper
   ,      'Modalidad'                               = ca.catipmoda
   ,      'Producto'                                = ca.cacodpos1
   ,      'Cartera'                                 = SUBSTRING(tc.rcnombre,1,3)
   ,      'Cliente'                                 = CONVERT(CHAR(35),cl.clnombre)
   ,      'MontoNo'                                 = ca.camtomon1
   ,      'ValorLibro'                              = ca.cavalordia          
   ,      'mk2mkt'                                  = ROUND(ca.fres_obtenido ,0.0)
   ,      'FechaIni'                                = CONVERT(CHAR(10),ca.cafecha,103)
   ,      'FechaVcto'                               = CONVERT(CHAR(10),ca.cafecvcto,103)
   ,      'FechaEfec'                               = CONVERT(CHAR(10),ca.cafecefectiva,103)
   ,      'Plazo_OP'                                = ca.caplazo
   ,      'Plazo_FR'                                = DATEDIFF(d,@Fecha ,ca.cafecvcto)
   ,      'Moneda'                                  = mon.mnnemo
   ,      'Contramon'                               = con.mnnemo
   ,      'MercadoCl'                               = CASE WHEN @Pais         = cl.clpais THEN 'L' ELSE 'X' END
   ,      'MercadoMon'                              = CASE WHEN ca.cacodmon1 in(999,998,994) or ca.cacodmon2 in(999,998,994) THEN 'L' ELSE 'X' END
   ,      'FechaCon'                                = CONVERT(CHAR(10),@Fecha,103)
   ,      'Banco'	                            = @Banco
   ,      'FecProceso'                              = CONVERT(CHAR(10),@FechaProceso,103)
   ,      'FecEmision'                              = @FechaEmision
   ,      'HorEmision'                              = @HoraEmision
   ,      'DesProducto'                             = CONVERT(CHAR(20),ISNULL(pro.descripcion,''))
   ,      'SegCam_Avr_Pos'                          = ISNULL(@SegCam_AvrPositivo,0.0)
   ,      'SegCam_Avr_Neg'                          = ISNULL(@SegCam_AvrNegativo,0.0)
   ,      'Arbitr_Avr_Pos'                          = ISNULL(@Arbitr_AvrPositivo,0.0)
   ,      'Arbitr_Avr_Neg'                          = ISNULL(@Arbitr_AvrNegativo,0.0)
   ,      'SegInf_Avr_Pos'                          = ISNULL(@SegInf_AvrPositivo,0.0)
   ,      'SegInf_Avr_Neg'                          = ISNULL(@SegInf_AvrNegativo,0.0)
   ,      'ForBon_Avr_Pos'                          = ISNULL(@ForBon_AvrPositivo,0.0)
   ,      'ForBon_Avr_Neg'                          = ISNULL(@ForBon_AvrNegativo,0.0)
   ,      'TLooks_Avr_Pos'                          = ISNULL(@TLooks_AvrPositivo,0.0)
   ,      'TLooks_Avr_Neg'                          = ISNULL(@TLooks_AvrNegativo,0.0)
   FROM    #MiCartera                            ca
           LEFT  JOIN BacParamSuda..CLIENTE      cl ON cl.clrut       = ca.cacodigo AND cl.clcodigo = ca.cacodcli
           INNER JOIN BacParamSuda..TIPO_CARTERA tc ON tc.rcsistema   = 'BFW'       AND tc.rccodpro = ca.cacodpos1 AND tc.rcrut = ca.cacodcart
           INNER JOIN BacParamSuda..MONEDA      mon ON ca.cacodmon1   = mon.mncodmon
           INNER JOIN BacParamSuda..MONEDA      con ON ca.cacodmon2   = con.mncodmon
           LEFT  JOIN BacParamSuda..PRODUCTO    pro ON pro.id_sistema = 'BFW'       AND ca.cacodpos1= CONVERT(INT,pro.codigo_producto)
   WHERE   ca.cafecefectiva                         >= @Fecha
   AND     ca.cacodpos1                             IN(1,2,3,7,10,11)
   ORDER BY ca.cacodpos1 , ca.canumoper

END




GO
