USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_CARTERA_FBT]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




CREATE PROCEDURE [dbo].[SP_INF_CARTERA_FBT]
   (   @dFecha   DATETIME
   ,   @Tioper   CHAR(1)     = ' '
   ,   @BacUser  VARCHAR(15) = 'ADMINISTRA'
   )
AS
BEGIN


   SET NOCOUNT ON

   DECLARE @iFound        INT
   DECLARE @FechaProceso  CHAR(10)
   ,       @FechaEmision  CHAR(10)
   ,       @HoraEmision   CHAR(10)

   SELECT  @FechaProceso  = CONVERT(CHAR(10),acfecproc,103)
   ,       @FechaEmision  = CONVERT(CHAR(10),getdate(),103)
   ,       @HoraEmision   = CONVERT(CHAR(10),getdate(),108)
   FROM    MFAC

   SELECT  @iFound = 0
   SELECT  @iFound = 1
   FROM    MFCA cart LEFT JOIN bacparamsuda..CLIENTE  cli        ON cart.cacodigo   = cli.clrut AND cart.cacodcli = cli.clcodigo
                     LEFT JOIN bacparamsuda..PRODUCTO prod       ON prod.id_sistema = 'BFW' AND cart.cacodpos1 = prod.codigo_producto
                     LEFT JOIN bacparamsuda..MONEDA   mon1       ON cart.cacodmon1  = mon1.mncodmon
                     LEFT JOIN bacparamsuda..MONEDA   mon2       ON cart.cacodmon2  = mon2.mncodmon
                     LEFT JOIN bacparamsuda..FORMA_DE_PAGO fpago ON cart.cafpagomn  = fpago.codigo
                     LEFT JOIN bacparamsuda..TIPO_CARTERA  tcar  ON tcar.rcsistema = 'BFW' and cart.cacodpos1 = tcar.rccodpro and cart.cacodcart = tcar.rcrut
   WHERE  (cart.cacodpos1 = 10 OR cart.cacodpos1 = 11)
   AND    (cart.catipoper = @Tioper or @Tioper = '')
   AND     cart.cafecvcto > @dFecha

   IF @iFound = 1
   BEGIN

      SELECT 'canumoper'     = cart.canumoper
      ,      'cacodcart'     = cart.cacodcart
      ,      'Cartera'       = ltrim(rtrim(CONVERT(CHAR(20),rcnombre)))
      ,      'catipoper'     = cart.catipoper
      ,      'TipoOperacion' = case when cart.catipoper = 'C' then 'COMPRA'       ELSE 'VENTA'          END
      ,      'Catipmoda'     = cart.catipmoda
      ,      'ModalidadPago' = case when cart.catipmoda = 'C' then 'COMPENSACION' ELSE 'ENTREGA FISICA' END 
      ,      'Cliente'       = ltrim(rtrim(CONVERT(CHAR(40),cli.clnombre)))
      ,      'Producto'      = ltrim(rtrim(CONVERT(CHAR(25),prod.descripcion)))
      ,      'Serie'         = cart.caserie
      ,      'Seriado'       = cart.caseriado
      ,      'MonInst'       = cart.cacodmon1
      ,      'GloMonInst'    = ltrim(rtrim(convert(char(20),mon1.mnglosa)))
      ,      'NemMonInst'    = mon1.mnnemo
      ,      'MonPago'       = cart.cacodmon2
      ,      'GloMonPago'    = ltrim(rtrim(convert(char(20),mon2.mnglosa)))
      ,      'NemMonPago'    = mon2.mnnemo
      ,      'ForPago'       = cart.cafpagomn
      ,      'GloFPago'      = fpago.glosa
      ,      'FecIni'        = convert(char(10),cart.cafecha,103)
      ,      'FecVen'        = convert(char(10),cart.cafecvcto,103)
      ,      'Plazo'         = cart.caplazo
      ,      'Nominales'     = cart.camtomon1
      ,      'TForward'      = round(convert(numeric(21,4),cart.catipcam),4)
      ,      'TMercado'      = round(convert(numeric(21,4),cart.catasa_efectiva_moneda1),4) -- MAP 20061023 
--      ,      'VPresente'     = CASE WHEN devengo_acum_usd_hoy = 0 THEN caequmon1 ELSE devengo_acum_usd_hoy END
--      ,      'VMercado'      = CASE WHEN devengo_acum_cnv_hoy = 0 THEN caequusd2 ELSE devengo_acum_cnv_hoy END
	-- MAP 20061023
      ,      'VPresente'     = CASE WHEN Cart.CaTipOper = 'C' then ValorRazonablePasivo Else ValorRazonableActivo  END
      ,      'VMercado'      = CASE WHEN Cart.CaTipOper = 'C' then ValorRazonableActivo Else ValorRazonablePasivo END

--      ,      'VarDia'        = pesos_devengo_usd
	-- MAP 20061023
      ,      'VarDia'        = ( CASE WHEN Cart.CaTipOper = 'C' then ValorRazonablePasivo Else ValorRazonableActivo  END )
                               - ( CASE WHEN Cart.CaTipOper = 'C' then ValorRazonableActivo Else ValorRazonablePasivo END )
      ,      'ReaDia'        = pesos_devengo_cnv
      ,      'VarDiaAcum'    = pesos_devengo_acum_usd
      ,      'ReaDiaAcum'    = pesos_devengo_acum_cnv
      ,      'dFecProc'      = @FechaProceso
      ,      'dFecEmi'       = @FechaEmision
      ,      'dHorEmi'       = @HoraEmision
      ,      'dUser'         = @BacUser
      FROM   MFCA cart LEFT JOIN bacparamsuda..CLIENTE  cli        ON cart.cacodigo   = cli.clrut AND cart.cacodcli = cli.clcodigo
                       LEFT JOIN bacparamsuda..PRODUCTO prod   ON prod.id_sistema = 'BFW' AND cart.cacodpos1 = prod.codigo_producto
                       LEFT JOIN bacparamsuda..MONEDA   mon1       ON cart.cacodmon1  = mon1.mncodmon
                       LEFT JOIN bacparamsuda..MONEDA   mon2       ON cart.cacodmon2  = mon2.mncodmon
                       LEFT JOIN bacparamsuda..FORMA_DE_PAGO fpago ON cart.cafpagomn  = fpago.codigo
                       LEFT JOIN bacparamsuda..TIPO_CARTERA  tcar  ON tcar.rcsistema = 'BFW' and cart.cacodpos1 = tcar.rccodpro and cart.cacodcart = tcar.rcrut
      WHERE (cart.cacodpos1 = 10 OR cart.cacodpos1 = 11)
      AND   (cart.catipoper = @Tioper or @Tioper = '')
      AND    cart.cafecvcto > @dFecha
      ORDER BY cart.catipoper
      ,        cart.catipmoda
      ,        cart.canumoper
      ,        cart.cacodpos1 

   END ELSE
   BEGIN

      SELECT 'canumoper'     = 0
      ,      'cacodcart'     = 0
      ,      'Cartera'       = 'NO EXISTE INFORMACION '
      ,      'catipoper'     = ' '
      ,      'TipoOperacion' = ' '
      ,      'Catipmoda'     = ' '
      ,      'ModalidadPago' = ' '
      ,      'Cliente'       = ' '
      ,      'Producto'      = ' '
      ,      'Serie'         = ' '
      ,      'Seriado'       = ' '
      ,      'MonInst'       = 0
      ,      'GloMonInst'    = ' '
      ,      'NemMonInst'    = ' '
      ,      'MonPago'       = 0
      ,      'GloMonPago'    = ' '
      ,      'NemMonPago'    = ' '
      ,      'ForPago'       = 0
      ,      'GloFPago'      = ' '
      ,      'FecIni'        = ' '
      ,      'FecVen'        = ' '
      ,      'Plazo'         = 0
      ,      'Nominales'     = 0.0
      ,      'TForward'      = 0.0
      ,      'TMercado'      = 0.0
      ,      'VPresente'     = 0
      ,      'VMercado'      = 0
      ,      'VarDia'        = 0
      ,      'ReaDia'        = 0
      ,      'VarDiaAcum'    = 0
      ,      'ReaDiaAcum'    = 0
      ,      'dFecProc'      = @FechaProceso
      ,      'dFecEmi'       = @FechaEmision
      ,      'dHorEmi'       = @HoraEmision
      ,      'dUser'         = @BacUser

   END


END

GO
