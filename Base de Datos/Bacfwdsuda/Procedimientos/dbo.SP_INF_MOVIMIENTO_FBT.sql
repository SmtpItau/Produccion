USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_MOVIMIENTO_FBT]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_INF_MOVIMIENTO_FBT]
   (   @dFecha   DATETIME
   ,   @Usuario  VARCHAR(15) = 'ADMINISTRA'
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @iFound        INTEGER
   DECLARE @FechaProceso  CHAR(10)
   ,       @FechaEmision  CHAR(10)
   ,       @HoraEmision   CHAR(10)
   ,       @dFecProc      DATETIME
   ,       @SubTitulo     VARCHAR(100)

   SELECT  @FechaProceso  = CONVERT(CHAR(10),acfecproc,103)
   ,       @FechaEmision  = CONVERT(CHAR(10),getdate(),103)
   ,       @HoraEmision   = CONVERT(CHAR(10),getdate(),108)
   ,       @dFecProc      = acfecproc
   FROM    MFAC

   SELECT  @SubTitulo     = 'AL DIA ' + CONVERT(CHAR(10),@dFecha,103)

   IF @dFecha = @dFecProc
   BEGIN

      SELECT  @iFound        = 0
      SELECT  @iFound        = 1
      FROM    MFMO   mov   LEFT JOIN bacparamsuda..CLIENTE       cli   ON mov.mocodigo    = cli.clrut AND mov.mocodcli  = cli.clcodigo
                           LEFT JOIN bacparamsuda..PRODUCTO      prod  ON prod.id_sistema = 'BFW'     AND mov.mocodpos1 = prod.codigo_producto
                           LEFT JOIN bacparamsuda..MONEDA        mon1  ON mov.mocodmon1   = mon1.mncodmon
                           LEFT JOIN bacparamsuda..MONEDA        mon2  ON mov.mocodmon2   = mon2.mncodmon
                           LEFT JOIN bacparamsuda..FORMA_DE_PAGO fpago ON mov.mofpagomn   = fpago.codigo
                           LEFT JOIN bacparamsuda..TIPO_CARTERA  tcar  ON tcar.rcsistema  = 'BFW'     AND mov.mocodpos1 = tcar.rccodpro AND mov.mocodcart = tcar.rcrut
      WHERE   (mov.mocodpos1 = 10 OR mov.mocodpos1 = 11)
      AND     mov.mofecha   = @dFecha

      IF @iFound = 1
      BEGIN

         SELECT 'monumoper'     = mov.monumoper
         ,      'mocodcart'     = mov.mocodcart
         ,      'mortera'       = ltrim(rtrim(CONVERT(CHAR(20),rcnombre)))
         ,      'motipoper'     = mov.motipoper
         ,      'TipoOperacion' = CASE WHEN mov.motipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END
         ,      'motipmoda'     = mov.motipmoda
         ,      'ModalidadPago' = CASE WHEN mov.motipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END 
         ,      'Cliente'       = ltrim(rtrim(CONVERT(CHAR(40),cli.clnombre)))
         ,      'Producto'      = ltrim(rtrim(CONVERT(CHAR(25),prod.descripcion)))
         ,      'Serie'         = mov.moserie
         ,      'Seriado'       = mov.moseriado
         ,      'MonInst'       = mov.mocodmon1
         ,      'GloMonInst'    = ltrim(rtrim(convert(char(20),mon1.mnglosa)))
         ,      'NemMonInst'    = mon1.mnnemo
         ,      'MonPago'       = mov.mocodmon2
         ,      'GloMonPago'    = ltrim(rtrim(convert(char(20),mon2.mnglosa)))
         ,      'NemMonPago'    = mon2.mnnemo
         ,      'ForPago'       = mov.mofpagomn
         ,      'GloFPago'      = fpago.glosa
         ,      'FecIni'        = convert(char(10),mov.mofecha,103)
         ,      'FecVen'        = convert(char(10),mov.mofecvcto,103)
         ,      'Plazo'         = mov.moplazo
         ,      'Nominales'     = mov.momtomon1
         ,      'TForward'      = round(convert(numeric(21,4),mov.motipcam),4)
         ,      'TMercado'      = round(convert(numeric(21,4),mov.mopremon1),4)
         ,      'VPresente'     = mov.moequmon1
         ,      'VMercado'      = mov.moequusd2
         ,      'VVariacion'    = mov.moequmon2
         ,      'dFecProc'      = @FechaProceso
         ,      'dFecEmi'       = @FechaEmision
         ,      'dHorEmi'       = @HoraEmision
         ,      'dUser'         = @Usuario
         ,      'SubTitulo'     = @SubTitulo
		 ,      'Logo' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
         FROM    MFMO   mov   LEFT JOIN bacparamsuda..CLIENTE       cli   ON mov.mocodigo    = cli.clrut AND mov.mocodcli  = cli.clcodigo
                              LEFT JOIN bacparamsuda..PRODUCTO      prod  ON prod.id_sistema = 'BFW'     AND mov.mocodpos1 = prod.codigo_producto
                              LEFT JOIN bacparamsuda..MONEDA        mon1  ON mov.mocodmon1   = mon1.mncodmon
                              LEFT JOIN bacparamsuda..MONEDA        mon2  ON mov.mocodmon2   = mon2.mncodmon
                              LEFT JOIN bacparamsuda..FORMA_DE_PAGO fpago ON mov.mofpagomn   = fpago.codigo
                              LEFT JOIN bacparamsuda..TIPO_CARTERA  tcar  ON tcar.rcsistema  = 'BFW'     AND mov.mocodpos1 = tcar.rccodpro AND mov.mocodcart = tcar.rcrut
         WHERE   (mov.mocodpos1 = 10 OR mov.mocodpos1 = 11)
         AND     mov.mofecha   = @dFecha
         ORDER BY mov.motipoper
         ,        mov.motipmoda
         ,        mov.mocodmon1

      END ELSE
      BEGIN

         SELECT 'monumoper'     = 0
         ,      'mocodcart'     = 0
         ,      'mortera'       = 'NO EXISTE INFORMACION '
         ,      'motipoper'     = ' '
         ,      'TipoOperacion' = ' '
         ,      'motipmoda'     = ' '
         ,      'ModalidadPago' = ' '
         ,      'Cliente'       = ' '
         ,      'Producto'      = ' '
         ,      'Serie'         = ' '
         ,      'Seriado'       = ' '
         ,      'MonInst'       = 0
         ,      'GloMonInst'    = ' '
         ,      'NemMonInst'    = ' '
         ,      'MonPago'       = ' '
         ,      'GloMonPago'    = ' '
         ,      'NemMonPago'    = ' '
         ,      'ForPago'       = 0
         ,      'GloFPago'      = ' '
         ,      'FecIni'        = ' '
         ,      'FecVen'        = ' '
         ,      'Plazo'         = 0
         ,      'Nominales'     = 0
         ,      'TForward'      = 0.0
         ,      'TMercado'      = 0.0
         ,      'VPresente'     = 0.0
         ,      'VMercado'      = 0.0
         ,      'VVariacion'    = 0.0
         ,      'dFecProc'      = @FechaProceso
         ,      'dFecEmi'       = @FechaEmision
         ,      'dHorEmi'       = @HoraEmision
         ,      'dUser'         = @Usuario
         ,      'SubTitulo'     = @SubTitulo
		 ,      'Logo' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)

      END

   END ELSE
   BEGIN

      SELECT  @iFound        = 0
      SELECT  @iFound        = 1
      FROM    MFMOH  mov   LEFT JOIN bacparamsuda..CLIENTE       cli   ON mov.mocodigo    = cli.clrut AND mov.mocodcli  = cli.clcodigo
                           LEFT JOIN bacparamsuda..PRODUCTO      prod  ON prod.id_sistema = 'BFW'     AND mov.mocodpos1 = prod.codigo_producto
                           LEFT JOIN bacparamsuda..MONEDA        mon1  ON mov.mocodmon1   = mon1.mncodmon
                           LEFT JOIN bacparamsuda..MONEDA        mon2  ON mov.mocodmon2   = mon2.mncodmon
                           LEFT JOIN bacparamsuda..FORMA_DE_PAGO fpago ON mov.mofpagomn   = fpago.codigo
                           LEFT JOIN bacparamsuda..TIPO_CARTERA  tcar  ON tcar.rcsistema  = 'BFW'     AND mov.mocodpos1 = tcar.rccodpro AND mov.mocodcart = tcar.rcrut
      WHERE   (mov.mocodpos1 = 10 OR mov.mocodpos1 = 11)
      AND     mov.mofecha   = @dFecha

      IF @iFound = 1
      BEGIN

         SELECT 'monumoper'     = mov.monumoper
         ,      'mocodcart'     = mov.mocodcart
         ,      'mortera'       = ltrim(rtrim(CONVERT(CHAR(20),rcnombre)))
         ,      'motipoper'     = mov.motipoper
         ,      'TipoOperacion' = CASE WHEN mov.motipoper = 'C' THEN 'COMPRA'       ELSE 'VENTA'          END
         ,      'motipmoda'     = mov.motipmoda
         ,      'ModalidadPago' = CASE WHEN mov.motipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END 
         ,      'Cliente'       = ltrim(rtrim(CONVERT(CHAR(40),cli.clnombre)))
         ,      'Producto'      = ltrim(rtrim(CONVERT(CHAR(25),prod.descripcion)))
         ,      'Serie'         = mov.moserie
         ,      'Seriado'       = mov.moseriado
         ,      'MonInst'       = mov.mocodmon1
         ,      'GloMonInst'    = ltrim(rtrim(convert(char(20),mon1.mnglosa)))
         ,      'NemMonInst'    = mon1.mnnemo
         ,      'MonPago'  = mov.mocodmon2
         ,      'GloMonPago'    = ltrim(rtrim(convert(char(20),mon2.mnglosa)))
         ,      'NemMonPago'    = mon2.mnnemo
         ,      'ForPago'       = mov.mofpagomn
         ,      'GloFPago'      = fpago.glosa
         ,      'FecIni'        = convert(char(10),mov.mofecha,103)
         ,      'FecVen'        = convert(char(10),mov.mofecvcto,103)
         ,      'Plazo'         = mov.moplazo
         ,      'Nominales'     = mov.momtomon1
         ,      'TForward'      = round(convert(numeric(21,4),mov.motipcam),4)
         ,      'TMercado'      = round(convert(numeric(21,4),mov.mopremon1),4)
         ,      'VPresente'     = mov.moequmon1
         ,      'VMercado'      = mov.moequusd2
         ,      'VVariacion'    = mov.moequmon2
         ,      'dFecProc'      = @FechaProceso
         ,      'dFecEmi'       = @FechaEmision
         ,      'dHorEmi'       = @HoraEmision
         ,      'dUser'         = @Usuario
         ,      'SubTitulo'     = @SubTitulo
		 ,      'Logo' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
         FROM    MFMOH  mov   LEFT JOIN bacparamsuda..CLIENTE       cli   ON mov.mocodigo    = cli.clrut AND mov.mocodcli  = cli.clcodigo
                              LEFT JOIN bacparamsuda..PRODUCTO      prod  ON prod.id_sistema = 'BFW'     AND mov.mocodpos1 = prod.codigo_producto
                              LEFT JOIN bacparamsuda..MONEDA        mon1  ON mov.mocodmon1   = mon1.mncodmon
                              LEFT JOIN bacparamsuda..MONEDA        mon2  ON mov.mocodmon2   = mon2.mncodmon
                              LEFT JOIN bacparamsuda..FORMA_DE_PAGO fpago ON mov.mofpagomn   = fpago.codigo
                              LEFT JOIN bacparamsuda..TIPO_CARTERA  tcar  ON tcar.rcsistema  = 'BFW'     AND mov.mocodpos1 = tcar.rccodpro AND mov.mocodcart = tcar.rcrut
         WHERE   (mov.mocodpos1 = 10 OR mov.mocodpos1 = 11)
         AND     mov.mofecha   = @dFecha
         ORDER BY mov.motipoper
         ,        mov.motipmoda
         ,        mov.mocodmon1

      END ELSE
      BEGIN

         SELECT 'monumoper'     = 0
         ,      'mocodcart'     = 0
         ,      'mortera'       = 'NO EXISTE INFORMACION '
         ,      'motipoper'     = ' '
         ,      'TipoOperacion' = ' '
         ,      'motipmoda'     = ' '
         ,      'ModalidadPago' = ' '
         ,      'Cliente'       = ' '
         ,      'Producto'      = ' '
         ,      'Serie'         = ' '
         ,      'Seriado'       = ' '
         ,      'MonInst'       = 0
         ,      'GloMonInst'    = ' '
         ,      'NemMonInst'    = ' '
         ,      'MonPago'       = ' '
         ,      'GloMonPago'    = ' '
         ,      'NemMonPago'    = ' '
         ,      'ForPago'       = 0
         ,      'GloFPago'      = ' '
         ,      'FecIni'        = ' '
         ,      'FecVen'        = ' '
         ,      'Plazo'         = 0
         ,      'Nominales'     = 0
         ,      'TForward'      = 0.0
         ,      'TMercado'      = 0.0
         ,      'VPresente'     = 0.0
         ,      'VMercado'      = 0.0
         ,      'VVariacion'    = 0.0
         ,      'dFecProc'      = @FechaProceso
         ,      'dFecEmi'       = @FechaEmision
         ,      'dHorEmi'       = @HoraEmision
         ,      'dUser'         = @Usuario
         ,      'SubTitulo'     = @SubTitulo
		 ,      'Logo' = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)

      END

   END

END


GO
