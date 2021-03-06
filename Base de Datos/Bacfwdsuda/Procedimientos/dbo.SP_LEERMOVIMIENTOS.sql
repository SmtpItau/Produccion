USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEERMOVIMIENTOS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEERMOVIMIENTOS]
   (   @dFecha      DATETIME
   ,   @Usuario     VARCHAR(15)
   )
AS
BEGIN

   SET NOCOUNT ON
   
   SELECT mocodpos1 
      ,   mocodigo 
      ,   mocodcli
      ,   mocodmon1
      ,   mocodmon2
      ,   motipoper
      ,   monumoper
      ,   motipmoda
      ,   mofecvcto
      ,   momtomon1
      ,   momtomon2
      ,   motipcam   
      ,   motasaEfectMon1
      ,   motasaEfectMon2
      ,   motipcamSpot
      ,   motipcamFwd
      ,   mofecEfectiva
      ,   mopremon1
      ,   moplazo
      ,   moparmon1
   -- ,   SUBSTRING(moobserv,LEN(moobserv)-45,60) AS moobserv
      ,   CASE WHEN CHARINDEX(CHAR(10), moobserv,1) = 0 THEN '-' 
               ELSE SUBSTRING(moobserv,CHARINDEX(CHAR(10), moobserv,1),60) 
          END  AS moobserv
   INTO   #MovimientosForward
   FROM   MFMO
   WHERE  mocodpos1 IN(1,2,3,12)
   AND    mofecha   = @dFecha

   UNION

   SELECT mocodpos1 
      ,   mocodigo 
      ,   mocodcli
      ,   mocodmon1
      ,   mocodmon2
      ,   motipoper
      ,   monumoper
      ,   motipmoda
      ,   mofecvcto
      ,   momtomon1
      ,   momtomon2
      ,   motipcam   
      ,   motasaEfectMon1
      ,   motasaEfectMon2
      ,   motipcamSpot
      ,   motipcamFwd
      ,   mofecEfectiva
      ,   mopremon1
      ,   moplazo
      ,   moparmon1
   -- ,   SUBSTRING(moobserv,LEN(moobserv)-45,60) AS moobserv
      ,   CASE WHEN CHARINDEX(CHAR(10), moobserv,1) = 0 THEN '-' ELSE SUBSTRING(moobserv,CHARINDEX(CHAR(10), moobserv,1),60) END AS moobserv
   FROM   MFMOH
   WHERE  mocodpos1 IN(1,2,3,12)
   AND    mofecha   = @dFecha

   IF (SELECT COUNT(1) FROM #MovimientosForward) = 0
   BEGIN

      SELECT 'RutCliente'       = 0
      ,      'NombreCliente'    = ' '
      ,      'Producto'         = 0
      ,      'NombreProducto'   = 'NO EXISTEN DATOS'
      ,      'TipoOperacion'    = ' '
      ,      'GlosaTipoOper'    = ' '
      ,      'Modalidad'        = ' '
      ,      'GlosaModalidad'   = ' '
      ,      'Moneda1'          = 0
      ,      'NemoMoneda1'      = ' '
      ,      'Moneda2'          = 0
      ,      'NemoMoneda2'      = ' '
      ,      'NumeroOperacion'  = 0
      ,      'FechaVencimiento' = ' '
      ,      'MontoMoneda'      = 0.0
      ,      'MontoMonedaCnv'   = 0.0
      ,      'TipoCambio'       = 0.0
      ,      'TasaMoneda'       = 0.0
      ,      'TasaMonedaConv'   = 0.0
      ,      'TipoCambioSpot'   = 0.0
      ,      'TipoCambioBfw'    = 0.0
      ,      'FechaEfectiva'    = ' '
      ,      'FechaEmision'     = convert(char(10),getdate(),103)
      ,      'FechaProceso'     = convert(char(10),acfecproc,103)
      ,      'Usuario'          = convert(char(15),UPPER(@Usuario))
      ,      'HoraEmision'      = convert(char(10),getdate(),108)
      ,      'FechaDatos'       = convert(char(10),@dFecha,103)
      ,      'Mensaje'          = '-'
	  ,      'Logo'             = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
      FROM   MFAC
      
   END ELSE
   BEGIN

      SELECT 'RutCliente'       = convert(numeric(10),Cli.clrut)
      ,      'NombreCliente'    = convert(varchar(30),Cli.clnombre)
      ,      'Producto'         = convert(numeric(3),mvt.mocodpos1)
      ,      'NombreProducto'   = convert(varchar(25),prd.descripcion)
      ,      'TipoOperacion'    = mvt.motipoper
      ,      'GlosaTipoOper'    = CASE WHEN mvt.motipoper = 'C' then 'COMPRA' ELSE 'VENTA' END
      ,      'Modalidad'        = mvt.motipmoda
      ,      'GlosaModalidad'   = CASE WHEN mvt.motipmoda = 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END
      ,      'Moneda1'          = mvt.mocodmon1
      ,      'NemoMoneda1'      = mna.mnnemo
      ,      'Moneda2'          = mvt.mocodmon2
      ,      'NemoMoneda2'      = mnb.mnnemo
      ,      'NumeroOperacion'  = mvt.monumoper
      ,      'FechaVencimiento' = CONVERT(CHAR(10),mvt.mofecvcto,103)
      ,      'MontoMoneda'      = convert(numeric(21,4),mvt.momtomon1)
      ,      'MontoMonedaCnv'   = convert(numeric(21,4),mvt.momtomon2)
      ,      'TipoCambio'       = convert(numeric(21,4),mvt.motipcam)
                                  /*
                          case when mocodpos1 = 1 then convert(numeric(21,4),mvt.motipcam)
                               when mocodpos1 = 2 then convert(numeric(21,4),mvt.moparmon1)
                               when mocodpos1 = 3 then convert(numeric(21,4),mvt.motipcam)
                          end
                                  */
      ,      'TasaMoneda'       = convert(numeric(21,4),motasaEfectMon1)
      ,      'TasaMonedaConv'   = convert(numeric(21,4),motasaEfectMon2)
      ,      'TipoCambioSpot'   = convert(numeric(21,4),motipcamSpot)
      ,      'TipoCambioBfw'    = convert(numeric(21,4),motipcamFwd)
      ,      'FechaEfectiva'    = convert(char(10),mofecEfectiva,103)
      ,      'FechaEmision'     = convert(char(10),getdate(),103)
      ,      'FechaProceso'     = convert(char(10),acfecproc,103)
      ,      'Usuario'          = convert(char(15),UPPER(@Usuario))
      ,      'HoraEmision'      = convert(char(10),getdate(),108)
      ,      'FechaDatos'       = convert(char(10),@dFecha,103)
      ,      'Mensaje'          = CASE WHEN moobserv = '-' THEN '-' ELSE 'Fuera de Rango' END --CASE WHEN isnull(ltrim(rtrim(moobserv)),'-')
	  ,      'Logo'             = (SELECT BannerCorto FROM BacParamSuda..Contratos_ParametrosGenerales)
      FROM    #MovimientosForward Mvt LEFT JOIN bacparamsuda..PRODUCTO Prd ON Prd.id_sistema = 'BFW'     AND mvt.mocodpos1 = Prd.codigo_producto
                                      LEFT JOIN bacparamsuda..CLIENTE  Cli ON Mvt.mocodigo   = Cli.clrut AND Mvt.mocodcli  = Cli.clcodigo
                                      LEFT JOIN bacparamsuda..MONEDA   MnA ON Mvt.mocodmon1  = MnA.mncodmon
                                      LEFT JOIN bacparamsuda..MONEDA   MnB ON Mvt.mocodmon2  = MnB.mncodmon
      ,       MFAC
      ORDER BY mvt.mocodpos1 , mvt.mocodmon1 , mvt.mocodmon2 , mvt.motipmoda , mvt.monumoper

   END

END





GO
