USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERACOMFUTURO_HISTORICO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_CARTERACOMFUTURO_HISTORICO]
   (    @FechaProceso           DATETIME
   ,    @ctipope		CHAR(1)
   ,	@Cartera_Inv		INT
   ,	@Cat_CartNorm		CHAR(06) = ''
   ,	@Cat_SubCartNorm	CHAR(06) = ''
   ,	@Cat_Libro		CHAR(06) = ''
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nnomprop        CHAR(50)
   DECLARE @ndirprop        CHAR(50)
   DECLARE @nfecproc        DATETIME
   DECLARE @observado       NUMERIC(12,04)
   DECLARE @uf              NUMERIC(12,04)
   DECLARE @fecha_observado CHAR(10)
   DECLARE @fecha_uf        CHAR(10)
   DECLARE @Glosa_Cartera   CHAR(20)

   SELECT @Glosa_Cartera = '' 

   SELECT DISTINCT
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema      = 'BFW'
   AND    rcrut          = @Cartera_INV
   --ORDER BY rcrut

  IF @Glosa_Cartera = '' 
      SELECT @Glosa_Cartera = '< TODAS >'

   EXECUTE SP_PARAMETROS_REPORTE_HISTORICO  @FechaProceso           ,
                                            @observado       OUTPUT ,
                                            @uf              OUTPUT ,
                                            @fecha_observado OUTPUT ,
                                            @fecha_uf        OUTPUT

   SELECT  @nnomprop = (SELECT rcnombre from VIEW_ENTIDAD)
      ,    @ndirprop = a.acdirprop
      ,    @nfecproc = @FechaProceso --> a.acfecproc
   FROM    MFAC              a

   SELECT * INTO #TMP_CARTERA_PASO FROM MFCARES
                                  WHERE cafechaproceso = @FechaProceso
                                    AND cacodpos1      IN(3, 13)
                                    AND catipoper      = @ctipope
                                    AND cafecvcto      > @nfecproc

   SELECT   'Tipo Operacion'    = a.catipoper
      ,     'Numero Operacion'  = a.canumoper
      ,     'Nombre Cliente'    = b.clnombre
      ,     'Fecha Inicio'      = CONVERT(CHAR(10), a.cafecha,   103)
      ,     'Fecha Termino'     = CONVERT(CHAR(10), a.cafecvcto, 103)
      ,     'Dias Cto'          = a.caplazo
      ,     'Plazo Residual'    = a.caplazovto
      ,     'Mon'               = c.mnnemo
      ,     'Monto Uf'          = a.camtomon1
      ,     'Valor Uf Inicial'  = a.capremon1
      ,     'Monto Clp Inicial' = a.camtomon2
      ,     'M/N Cnv'           = d.mnnemo
      ,     'Valor Uf Final'    = a.catipcam
      ,     'Monto Clp Uf Fwd'  = a.caequmon1
      ,     'Valor a Diferir'   = a.cautildiferir + caperddiferir
      ,     'Devengo Acumulado' = a.cautilacum    + caperdacum
      ,     'res var multi'     = a.carevuf
      ,     'M'                 = a.catipmoda
      ,     'Nombre Empresa'    = @nnomprop
      ,     'Direccion Empresa' = @ndirprop
      ,     'Fecha Proceso'     = CONVERT(CHAR(10), @nfecproc, 103)
      ,     'UF valor dia'      = @uf
      ,     'fecha_uf'          = @fecha_uf
      ,     'Entidad'           = (SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar = a.cacodsuc1)
      ,     'Hora'              = CONVERT(CHAR(5), GETDATE(),108)
      ,     'Tipo_Cart'	 	= (SELECT DISTINCT isnull(rcnombre,'') FROM BacParamSuda..TIPO_CARTERA 
                                    WHERE rcsistema = 'BFW' AND rccodpro = cacodpos1 and rcrut = cacodcart )
      ,     'Tipo_InV'	 	= @Glosa_Cartera
      ,     'Dif_Dife_Total'	= (a.cautildiferir + caperddiferir) - (a.cautilacum + caperdacum)
      ,     'Valoriza_Dia'	= CASE WHEN @ctipope = 'C' THEN ROUND((@uf          - a.capremon1)* a.camtomon1, 4) + (a.cautilacum + caperdacum)
                                       WHEN @ctipope = 'V' THEN ROUND((a.capremon1  - @uf)        * a.camtomon1, 4) + (a.cautilacum + caperdacum) 
				       ELSE                     ROUND((a.capremon1  - @uf)        * a.camtomon1, 4) - (a.cautilacum + caperdacum) 
                                  END
      ,     'cartnorm'	        = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = cacartera_normativa),    'No Especificado')
      ,     'subcart'	        = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = casubcartera_normativa), 'No Especificado')
      ,     'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = calibro),                'No Especificado')
    FROM    #TMP_CARTERA_PASO       a
            INNER JOIN VIEW_CLIENTE b ON b.clrut     = a.cacodigo AND a.cacodcli = b.clcodigo
            INNER JOIN VIEW_MONEDA  c ON a.cacodmon1 = c.mncodmon
            INNER JOIN VIEW_MONEDA  d ON a.cacodmon2 = d.mncodmon
    WHERE   (a.cacodcart = @Cartera_INV OR @Cartera_INV = 0)

END

GO
