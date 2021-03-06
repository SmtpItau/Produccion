USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_OPERACIONES_CONTRATO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_OPERACIONES_CONTRATO]
   (   @iTag               INT
   ,   @dFechaBusqueda     DATETIME
   ,   @iNumeroOperacion   NUMERIC(9) = 0
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @dFechaProc   DATETIME
   DECLARE @fechavctoins  DATETIME
   DECLARE @serie   VARCHAR(12)
   SELECT  @dFechaProc   = acfecproc
   FROM    MFAC

   IF @iTag = 1
   BEGIN
      SELECT canumoper                                AS NumeroOperacion
      ,      case when caCodpos1 = 10 then 'BOND FORWARD TRADE' else 'FORWARD T-LOCK'  end               AS Producto
      ,      CASE WHEN catipoper = 'C' THEN 'COMPRA'
                  ELSE                      'VENTA'
             END                                      AS TipoOperacion
      ,      CONVERT(CHAR(10),cafecha,103)            AS FechaInicio
      ,      clnombre                                 AS Cliente
      ,      clrut                                    AS RutCliente
      ,      clcodigo                                 AS CodigoCliente
      ,	     clFechaFirma_cond		      AS fecha_condiciones_generales
      FROM   MFCA
             LEFT JOIN BacParamSuda..CLIENTE ON clrut = cacodigo AND clcodigo = cacodcli
      WHERE  cacodpos1 IN( 10 ,11)
      AND    cafecha   = @dFechaBusqueda
      ORDER BY canumoper

      RETURN
   END


   DECLARE @FechaDeHoy   VARCHAR(50)
   SELECT  @FechaDeHoy   = CASE WHEN LEN(RTRIM(LTRIM(DATEPART(DAY,@dFechaBusqueda)))) = 1 THEN '0' + RTRIM(LTRIM(DATEPART(DAY,@dFechaBusqueda)))
                                ELSE                                                             RTRIM(LTRIM(DATEPART(DAY,@dFechaBusqueda)))
                           END + ' de ' +
                           CASE WHEN DATEPART(MONTH,@dFechaBusqueda) = 1  THEN 'Enero'
                                WHEN DATEPART(MONTH,@dFechaBusqueda) = 2  THEN 'Febrero'
                                WHEN DATEPART(MONTH,@dFechaBusqueda) = 3  THEN 'Marzo'
                                WHEN DATEPART(MONTH,@dFechaBusqueda) = 4  THEN 'Abril'
                                WHEN DATEPART(MONTH,@dFechaBusqueda) = 5  THEN 'Mayo'
                                WHEN DATEPART(MONTH,@dFechaBusqueda) = 6  THEN 'Junio'
                                WHEN DATEPART(MONTH,@dFechaBusqueda) = 7  THEN 'Julio'
                                WHEN DATEPART(MONTH,@dFechaBusqueda) = 8  THEN 'Agosto'
                                WHEN DATEPART(MONTH,@dFechaBusqueda) = 9  THEN 'Septiembre'
                                WHEN DATEPART(MONTH,@dFechaBusqueda) = 10 THEN 'Octubre'
                                WHEN DATEPART(MONTH,@dFechaBusqueda) = 11 THEN 'Noviembre'
                                WHEN DATEPART(MONTH,@dFechaBusqueda) = 12 THEN 'Diciembre'
                           END + ' del ' + LTRIM(RTRIM(DATEPART(YEAR,@dFechaBusqueda)))

	SELECT  @serie = caserie FROM MFCA WHERE canumoper=@iNumeroOperacion
	SELECT 	@fechavctoins = sefecven FROM BACPARAMSUDA..SERIE WHERE semascara=@serie

   SELECT /*01*/ 'FechaContrato'    = @FechaDeHoy
   ,      /*02*/ 'Cliente'          = ltrim(rtrim(C.clnombre))
   ,      /*03*/ 'TipoEntidad'      = CASE WHEN C.cltipcli IN(1,2,3) THEN 'Empresa Bancaria' ELSE 'Empresa' END
   ,      /*04*/ 'DirCliente'       = LTRIM(C.Cldirecc)
   ,      /*05*/ 'CiuCliente'       = 'Santiago'
   ,      /*06*/ 'ComCliente'       = LTRIM(cc.nombre)
   ,      /*07*/ 'Entidad'          = LTRIM(RTRIM(acnomprop))
   ,      /*08*/ 'TipoCliente'      = CASE WHEN E.cltipcli IN(1,2,3) THEN 'Empresa Bancaria' ELSE 'Empresa' END
   ,      /*09*/ 'DirEntidad'       = LTRIM(RTRIM(acdirprop))
   ,      /*10*/ 'ComEntidfad'      = LTRIM(ce.nombre)
   ,      /*11*/ 'Serie'            = case WHEN cacodpos1 =  10 THEN (SELECT inserie FROM BacParamSuda..INSTRUMENTO WHERE incodigo = cabroker )
                                           WHEN cacodpos1 =  11 then caserie
                                         END 
  ,      /*12*/ 'OrigInsttrum'     = 'Renta Fija'
   ,      /*13*/ 'MonReajuste'      = mnglosa
   ,      /*14*/ 'Bursatil'         = caserie
   ,      /*15*/ 'FechaVcto'        = cafecvcto
   ,      /*16*/ 'Valorizador'      = CASE WHEN cacodpos1 =  10 THEN  'Bolsa de Comercio de Santiago.' 
                                           WHEN cacodpos1 =  11 THEN  'Bloomberg'
                                      END
   ,      /*17*/ 'FechaPago'        = cafecvcto
   ,      /*18*/ 'NemoMon'          = CASE WHEN cacodmon1 = 999 THEN '$'
                                           WHEN cacodmon1 = 998 THEN 'U.F.'
                                           WHEN cacodmon1 =  13 THEN 'US$'
                                           WHEN cacodmon1 = 994 THEN 'US$'
                                           WHEN cacodmon1 = 995 THEN 'US$'
                                           ELSE                     ' '
                                       END
   ,      /*19*/ 'MontoContrato'    = camtomon1
   ,      /*20*/ 'TasaContrato'     = capremon2
   ,      /*21*/ 'TasaRef'          = capremon1
   ,      /*22*/ 'TasFlotEst'       = 'N/A'
   ,      /*23*/ 'PagadValPact'     = CASE WHEN catipoper = 'V' THEN LTRIM(RTRIM(c.clnombre)) ELSE LTRIM(RTRIM(e.clnombre)) END
   ,      /*24*/ 'PagadValRefe'     = CASE WHEN catipoper = 'V' THEN LTRIM(RTRIM(e.clnombre)) ELSE LTRIM(RTRIM(c.clnombre)) END
   ,      /*25*/ 'BancoRef'         = ''
   ,      /*26*/ 'FormaPago'        = glosa
   ,      /*27*/ 'Lugar'            = 'Santiago.'
   ,      /*28*/ 'Obserbaciones'    = 'S/O.'
   ,      /*29*/ 'Liquidacion'      = CASE WHEN catipmoda = 'C' THEN 'Compensación' ELSE 'Entrega Física' END
   ,      /*30*/ 'NombreCliente_P1' = ltrim(rtrim(C.clnombre))
   ,      /*31*/ 'NombreEntidad_P1' = ltrim(rtrim(E.clnombre))
   ,      /*32*/ 'DirCliente_P1'    = LTRIM(C.Cldirecc)
   ,      /*33*/ 'DirEntidad_P1'    = LTRIM(RTRIM(acdirprop))
   ,      /*34*/ 'FonoCliente_P10'  = c.Clfono
   ,      /*35*/ 'FonoEntidad_P10'  = e.Clfono
   ,      /*36*/ 'FaxCliente_P10'   = c.Clfax
   ,      /*37*/ 'FaxEntidad_P10'   = e.Clfax
   ,      /*38*/ 'RutCliente_P1'    = RTRIM(LTRIM(c.clrut)) + '-' + RTRIM(LTRIM(c.cldv))
   ,      /*39*/ 'RutEntidad_P1'    = RTRIM(LTRIM(e.clrut)) + '-' + RTRIM(LTRIM(e.cldv))
   ,	  /*40*/ 'fecha_cond_gnrales'=c.clFechaFirma_cond
   ,		 'fecha_vcto_instrum'=@fechavctoins
   FROM   MFCA
          LEFT JOIN BacParamSuda..CLIENTE C     ON C.clrut          = cacodigo AND C.clcodigo   = cacodcli
          LEFT JOIN BacParamSuda..COMUNA  cc    ON cc.codigo_comuna = C.Clcomuna
         -- LEFT JOIN BacParamSuda..INSTRUMENTO   ON incodigo         = cabroker
          LEFT JOIN BacParamSuda..SERIE         ON seserie          = caserie
          LEFT JOIN BacParamSuda..MONEDA        ON semonemi         = mncodmon
          LEFT JOIN BacParamSuda..FORMA_De_PAGO ON codigo = cafpagomn
   ,      MFAC
          LEFT JOIN BacParamSuda..CLIENTE E     ON E.clrut          = acrutprop and E.clcodigo = 1
          LEFT JOIN BacParamSuda..COMUNA  ce    ON ce.codigo_comuna = e.Clcomuna
   WHERE  canumoper = @iNumeroOperacion

END





GO
