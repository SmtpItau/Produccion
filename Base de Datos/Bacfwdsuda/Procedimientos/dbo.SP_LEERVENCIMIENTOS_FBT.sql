USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERVENCIMIENTOS_FBT]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_LEERVENCIMIENTOS_FBT]
   (   @dFecha    DATETIME
   ,   @Usuario   VARCHAR(15) = 'ADMINISTRA'
   ,   @Agrupado  CHAR(1)     = 'N'
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @FechaProceso   CHAR(10)
   ,       @FechaEmision   CHAR(10)
   ,       @HoraEmision    CHAR(10)
   ,       @Titulo         VARCHAR(45)
   ,       @SubTitulo      VARCHAR(45)

   SELECT  @FechaProceso   = CONVERT(CHAR(10),acfecproc,103)
   ,       @FechaEmision   = CONVERT(CHAR(10),GETDATE(),103)
   ,       @HoraEmision    = CONVERT(CHAR(10),GETDATE(),108)
   ,       @Titulo         = 'INFORME DE VENCIMIENTOS FORWARD BOND TRADES'
   ,       @SubTitulo      = CASE WHEN @Agrupado = 'N' THEN 'AL ' + CONVERT(CHAR(10),@dFecha,103)
                                  ELSE                      'AGRUPADO  AL ' + CONVERT(CHAR(10),@dFecha,103)
                             END 
   FROM    MFAC

   IF EXISTS( SELECT 1 FROM MFCA car LEFT JOIN bacparamsuda..CLIENTE  cli        ON car.cacodigo  = cli.clrut AND car.cacodcli = cli.clcodigo
                                     LEFT JOIN bacparamsuda..PRODUCTO pro        ON CONVERT(VARCHAR(5),car.cacodpos1) = pro.codigo_producto
                                     LEFT JOIN bacparamsuda..MONEDA  mon1        ON car.cacodmon1 = mon1.mncodmon
                                     LEFT JOIN bacparamsuda..MONEDA  mon2        ON car.cacodmon2 = mon2.mncodmon
                                     LEFT JOIN bacparamsuda..FORMA_DE_PAGO fPago ON car.cafpagomn = fPago.codigo
                                     LEFT JOIN bacparamsuda..TIPO_CARTERA tipcar ON tipcar.rcsistema = 'BFW' AND car.cacodpos1 = tipcar.rccodpro AND car.cacodcart = tipcar.rcrut
                                     LEFT JOIN bacparamsuda..INSTRUMENTO  inst   ON car.cabroker = inst.incodigo
                       WHERE  car.cafecvcto <= @dFecha
                       AND    car.cacodpos1  = 10 )
   BEGIN

      IF @Agrupado = 'N'
      BEGIN

         SELECT 'NumDocu'     = car.canumoper
         ,      'Producto'    = pro.descripcion
         ,      'TipOpe'      = CASE WHEN car.catipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA' END
         ,      'TipModa'     = CASE WHEN car.catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
         ,      'ClNombre'    = CONVERT(VARCHAR(30),cli.clnombre)
         ,      'ClRut'       = cli.clrut
         ,      'ClDv'        = cli.cldv
         ,      'ClCodigo'    = cli.clcodigo
         ,      'FecIni'      = CONVERT(CHAR(10),car.cafecha,103)
         ,      'FecVen'      = CONVERT(CHAR(10),car.cafecvcto,103)
         ,      'Serie'       = car.caserie
         ,      'Nominales'   = car.camtomon1
         ,      'TasaForwar'  = ROUND(CONVERT(NUMERIC(21,4),car.catipcam),4)
         ,      'VPresente'   = ROUND(CONVERT(NUMERIC(21,0),car.caequmon1),0)
         ,      'CapitalUm'   = car.camtomon2
         ,      'TasaMercado' = ROUND(CONVERT(NUMERIC(21,4),car.capremon1),4)
         ,      'ValMercado'  = ROUND(CONVERT(NUMERIC(21,0),car.caequusd2),0)
         ,      'ValDiferir'  = ROUND(CONVERT(NUMERIC(21,0),car.caequmon2),0)
         ,      'MonedaInst'  = mon1.mnglosa
         ,      'MonedaPago'  = mon2.mnglosa
         ,      'FormaPago'   = CONVERT(VARCHAR(20),fPago.glosa)
         ,      'TipoCartea'  = tipcar.rcnombre
         ,      'CodMonIns'   = car.cacodmon1
         ,      'CodMonPag'   = car.cacodmon2
         ,      'GlosaInst'   = inst.inglosa
         ,      'FechaProc'   = @FechaProceso
         ,      'FecEmis'     = @FechaEmision
         ,      'HoraEmis'    = @HoraEmision
         ,      'Usuario'     = @Usuario
         ,      'Titulo'      = @Titulo
         ,      'SubTitulo'   = @SubTitulo
         FROM   MFCA car LEFT JOIN bacparamsuda..CLIENTE  cli        ON car.cacodigo  = cli.clrut AND car.cacodcli = cli.clcodigo
                         LEFT JOIN bacparamsuda..PRODUCTO pro        ON CONVERT(VARCHAR(5),car.cacodpos1) = pro.codigo_producto
                         LEFT JOIN bacparamsuda..MONEDA  mon1        ON car.cacodmon1 = mon1.mncodmon
                         LEFT JOIN bacparamsuda..MONEDA  mon2        ON car.cacodmon2 = mon2.mncodmon
                         LEFT JOIN bacparamsuda..FORMA_DE_PAGO fPago ON car.cafpagomn = fPago.codigo
                         LEFT JOIN bacparamsuda..TIPO_CARTERA tipcar ON tipcar.rcsistema = 'BFW' AND car.cacodpos1 = tipcar.rccodpro AND car.cacodcart = tipcar.rcrut
                         LEFT JOIN bacparamsuda..INSTRUMENTO  inst   ON car.cabroker = inst.incodigo
         WHERE  car.cafecvcto <= @dFecha
         AND    car.cacodpos1  = 10
         ORDER BY car.canumoper

      END ELSE
      BEGIN

         SELECT 'Producto'    = pro.descripcion
         ,      'TipOpe'      = CASE WHEN car.catipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END
         ,      'TipModa'     = CASE WHEN car.catipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
         ,      'ClNombre'    = CONVERT(VARCHAR(30),cli.clnombre)
         ,      'ClRut'       = cli.clrut
         ,      'ClDv'        = cli.cldv
         ,      'ClCodigo'    = cli.clcodigo
         ,      'Nominales'   = SUM( car.camtomon1 )
         ,      'TasaForwar'  = SUM( ROUND(CONVERT(NUMERIC(21,4),car.catipcam),4) * car.camtomon1 ) / SUM( car.camtomon1 )
         ,      'VPresente'   = SUM( ROUND(CONVERT(NUMERIC(21,0),car.caequmon1),0) )
         ,      'CapitalUm'   = SUM( car.camtomon2 ) 
         ,      'TasaMercado' = SUM( ROUND(CONVERT(NUMERIC(21,4),car.capremon1),4) * car.camtomon1 ) / SUM( car.camtomon1 )
         ,      'ValMercado'  = SUM( ROUND(CONVERT(NUMERIC(21,0),car.caequusd2),0) )
         ,      'ValDiferir'  = SUM( ROUND(CONVERT(NUMERIC(21,0),car.caequmon2),0) )
         ,      'MonedaInst'  = mon1.mnnemo
         ,      'MonedaPago'  = mon2.mnnemo
         ,      'CodMonIns'   = car.cacodmon1
         ,      'FechaProc'   = @FechaProceso
         ,      'FecEmis'     = @FechaEmision
         ,      'HoraEmis'    = @HoraEmision
         ,      'Usuario'     = @Usuario
         ,      'Titulo'      = @Titulo
         ,      'SubTitulo'   = @SubTitulo
         FROM   MFCA car LEFT JOIN bacparamsuda..CLIENTE  cli        ON car.cacodigo  = cli.clrut AND car.cacodcli = cli.clcodigo
                         LEFT JOIN bacparamsuda..PRODUCTO pro        ON CONVERT(VARCHAR(5),car.cacodpos1) = pro.codigo_producto
                         LEFT JOIN bacparamsuda..MONEDA  mon1        ON car.cacodmon1 = mon1.mncodmon
                         LEFT JOIN bacparamsuda..MONEDA  mon2        ON car.cacodmon2 = mon2.mncodmon
                         LEFT JOIN bacparamsuda..FORMA_DE_PAGO fPago ON car.cafpagomn = fPago.codigo
                         LEFT JOIN bacparamsuda..TIPO_CARTERA tipcar ON tipcar.rcsistema = 'BFW' AND car.cacodpos1 = tipcar.rccodpro AND car.cacodcart = tipcar.rcrut
                         LEFT JOIN bacparamsuda..INSTRUMENTO  inst   ON car.cabroker = inst.incodigo
         WHERE  car.cafecvcto <= @dFecha
         AND    car.cacodpos1  = 10
         GROUP BY pro.descripcion
         ,        car.catipoper
         ,        car.catipmoda
         ,        cli.clnombre
         ,        cli.clrut
         ,        cli.cldv
         ,        cli.clcodigo
         ,        mon1.mnnemo
         ,        mon2.mnnemo
         ,        car.cacodmon1
         ORDER BY car.catipoper , car.catipmoda , cli.clnombre

      END

   END ELSE
   BEGIN

      IF @Agrupado = 'N'
      BEGIN

         SELECT 'NumDocu'     = 0
         ,      'Producto'    = ' '
         ,      'TipOpe'      = ' '
         ,      'TipModa'     = ' '
         ,      'ClNombre'    = ' '
         ,      'ClRut'       = ' ' 
         ,      'ClDv'        = ' '
         ,      'ClCodigo'    = ' '
         ,      'FecIni'      = ' '
         ,      'FecVen'      = ' '
      ,      'Serie'       = ' '
         ,      'Nominales'   = 0
         ,      'TasaForwar'  = 0
         ,      'VPresente'   = 0
         ,      'CapitalUm'   = 0
         ,      'TasaMercado' = 0
         ,      'ValMercado'  = 0
         ,      'ValDiferir'  = 0
         ,      'MonedaInst'  = ' '
         ,      'MonedaPago'  = ' '
         ,      'FormaPago'   = ' '
         ,      'TipoCartea'  = ' '
         ,      'CodMonIns'   = 0
         ,      'CodMonPag'   = 0
         ,      'GlosaInst'   = 'NO EXISTE INFORMACION'
         ,      'FechaProc'   = @FechaProceso
         ,      'FecEmis'     = @FechaEmision
         ,      'HoraEmis'    = @HoraEmision
         ,      'Usuario'     = @Usuario
         ,      'Titulo'      = @Titulo
         ,      'SubTitulo'   = @SubTitulo

      END ELSE
      BEGIN

         SELECT 'Producto'    = ' '
         ,      'TipOpe'      = ' '
         ,      'TipModa'     = ' '
         ,      'ClNombre'    = ' '
         ,      'ClRut'       = ' '
         ,      'ClDv'        = ' '
         ,      'ClCodigo'    = ' '
         ,      'Nominales'   = 0
         ,      'TasaForwar'  = 0
         ,      'VPresente'   = 0
         ,      'CapitalUm'   = 0
         ,      'TasaMercado' = 0
         ,      'ValMercado'  = 0
         ,      'ValDiferir'  = 0
         ,      'MonedaInst'  = ' '
         ,      'MonedaPago'  = ' '
         ,      'CodMonIns'   = 0
         ,      'FechaProc'   = @FechaProceso
         ,      'FecEmis'     = @FechaEmision
         ,      'HoraEmis'    = @HoraEmision
         ,      'Usuario'     = @Usuario
         ,      'Titulo'      = @Titulo
         ,      'SubTitulo'   = @SubTitulo

      END

   END   

   SET NOCOUNT OFF

END


GO
