USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERADERIVADOS_HISTORICO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CARTERADERIVADOS_HISTORICO]
   (   @dFechaProceso      DATETIME 
   ,   @Cat_CartNorm       CHAR(06) = ''
   ,   @Cat_SubCartNorm	   CHAR(06) = ''
   ,   @Cat_Libro	   CHAR(06) = ''
   )

AS
BEGIN

   SET NOCOUNT ON

   DECLARE @CONT     INT 
   DECLARE @nnomprop CHAR(50)
   DECLARE @ndirprop CHAR(50)
   DECLARE @nfecproc DATETIME

   SELECT  @CONT = 0

   SELECT @nnomprop = (SELECT rcnombre FROM VIEW_ENTIDAD)
      ,   @ndirprop = acdirprop
      ,   @nfecproc = @dFechaProceso
   FROM   MFAC   

   SELECT * INTO #TMP_CARTERA_PASO FROM MFCARES 
                                  WHERE cafechaproceso = @dFechaProceso
                                    AND cacodpos1      IN(1, 2, 3, 7)
                                    AND cafecvcto      > @nfecproc 

   SELECT 'Tipo_Operacion'            = a.catipoper
      ,   'Numero_Operacion'          = a.canumoper
      ,   'Nombre_Cliente'            = b.clnombre
      ,   'Fecha_Termino'             = CONVERT(CHAR(10), a.cafecvcto, 103)
      ,   'Dias'                      = a.caplazo
      ,   'Plazo '                    = CASE WHEN a.caplazo <= 90 THEN 1 ELSE 2 END
      ,   'Tipo_de_Mercado'           = CASE WHEN b.clpais = 6 THEN 'MERCADO LOCAL' ELSE 'MERCADO EXTERNO' END
      ,   'Moneda1'                   = c.mnnemo
      ,   'Moneda2'                   = d.mnnemo
      ,   'moneda'                    = d.mnnemo
      ,   'MonedaUSD'                 = (SELECT mnnemo FROM view_moneda WHERE mncodmon = a.camdausd)
      ,   'Monto'                     = a.camtomon1
      ,   'Final'                     = a.catipcam
      ,   'Monto_Final_CNV'           = a.camtomon2
      ,   'Modalidad_Cumplimiento'    = a.catipmoda
      ,   'Nombre_Empresa'            = @nnomprop
      ,   'Direccion_Empresa'         = @ndirprop
      ,   'Fecha_Proceso'             = CONVERT(CHAR(10), @nfecproc, 103)
      ,   'Codigo_Producto'           = CASE a.cacodpos1 WHEN 7 THEN 1 ELSE a.cacodpos1 END
      ,   'Hora'                      = CONVERT(CHAR(08),GETDATE(),108)
      ,   'sw'                        = '0'
      ,   'Fecha Proceso'             = @nfecproc
      ,   'cartnorm'	              = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = cacartera_normativa),'No Especificado')
      ,   'subcart'	              = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = casubcartera_normativa),'No Especificado')
      ,   'Libro'		      = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = calibro),'No Especificado')
   FROM   #TMP_CARTERA_PASO   a
      ,   VIEW_CLIENTE        b
      ,   VIEW_MONEDA         c
      ,   VIEW_MONEDA         d
   WHERE  (b.clrut                    = a.cacodigo AND b.clcodigo = a.cacodcli)
      AND  a.cacodmon1                = c.mncodmon
      AND  a.cacodmon2                = d.mncodmon
      AND  a.cafecvcto                > @nfecproc 
  ORDER BY a.caplazo

END

GO
