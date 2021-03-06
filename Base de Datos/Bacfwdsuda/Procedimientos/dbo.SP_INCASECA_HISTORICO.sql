USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INCASECA_HISTORICO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_INCASECA_HISTORICO]
   (   @FechaProceso      DATETIME
   ,   @cTipOpe 	  CHAR(1)
   ,   @producto	  INT
   ,   @Cartera_Inv	  INT
   ,   @Cat_CartNorm	  CHAR(06) = '1111'
   ,   @Cat_SubCartNorm   CHAR(06) = '1554'
   ,   @Cat_Libro	  CHAR(06) = '1552'
   )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @nvaluf           FLOAT  
   DECLARE @nvalob           FLOAT
   DECLARE @cnomprop         CHAR(40)
   DECLARE @cdirprop         CHAR(40)
   DECLARE @cfecproc         CHAR(10)
   DECLARE @dfecproc         DATETIME
   DECLARE @nspotuhoy        FLOAT
   DECLARE @observado        NUMERIC(12,04)
   DECLARE @uf               NUMERIC(12,04) 
   DECLARE @fecha_observado  CHAR(10) 
   DECLARE @fecha_uf         CHAR(10) 	
   DECLARE @Glosa_Cartera    Char(20)

   SET @Glosa_Cartera = '' 

   SELECT DISTINCT
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema      = 'BFW'
   AND    rcrut          = @Cartera_INV
  -- ORDER BY rcrut

   IF @Glosa_Cartera = '' 
      SET @Glosa_Cartera = '< TODAS >'

   EXECUTE SP_PARAMETROS_REPORTE_HISTORICO   @FechaProceso           ,
                                             @observado       OUTPUT ,
				             @uf              OUTPUT ,
				             @fecha_observado OUTPUT ,
				             @fecha_uf        OUTPUT
  
   SELECT @cnomprop = (SELECT rcnombre FROM VIEW_ENTIDAD)
      ,   @cdirprop = a.acdirprop
      ,   @dfecproc = @FechaProceso
      ,   @cfecproc = CONVERT( CHAR(10), @FechaProceso, 103 )
   FROM   MFAC a            

   EXECUTE SP_DIV @observado, @uf, @nspotuhoy OUTPUT

   SELECT  @nspotuhoy = ROUND(@nspotuhoy, 11)
   SELECT  @nspotuhoy = ISNULL(@nspotuhoy, 1)
   SELECT  @nspotuhoy = CASE @nspotuhoy WHEN 0 THEN 1 ELSE @nspotuhoy END


   SELECT * INTO #TMP_CARTERA_PASO FROM MFCARES
                                  WHERE cafechaproceso = @FechaProceso
                                    AND cacodpos1      = @producto
                                    AND catipoper      = @ctipope
                                    AND cafecvcto      > @dfecproc

   SELECT 'Numero'               = car.canumoper
      ,   'Operacion'            = car.catipoper
      ,   'Cliente'              = ISNULL( cli.clnombre,' ')
      ,   'Fecha Inicio'         = CONVERT(CHAR(10), car.cafecha,103)
      ,   'Fecha Termino'        = CONVERT(CHAR(10), car.cafecvcto,103)
      ,   'M/X'                  = ISNULL(mn1.mnnemo,'N/D')
      ,   'Mto M/X Comprado'     = car.camtomon1
      ,   'Moneda'               = ISNULL(mon.mnnemo,'N/D')
      ,   'T/C Obs Ini'          = car.capremon1
      ,   'Mto CLP Inicial T/C'  = car.caequmon1
      ,   'M/N CNV'              = ISNULL(mn2.mnnemo,'N/D')
      ,   'T/C Inicial'          = CASE WHEN car.cacodmon2 = 998 THEN car.capremon2 ELSE car.catipcam END
      ,   'Monto CNV'            = car.camtomon2
      ,   'Monto CNV En Pesos'   = car.caequmon2
      ,   'Valor a Diferir'      = car.cautildiferir + car.caperddiferir
      ,   'Devengo Acumulado'    = car.cautilacum    + car.caperdacum
      ,   'Ajuste Variacion UF'  = car.carevuf
      ,   'Valorizacion'         = car.carevtot
      ,   'Modalidad'            = car.catipmoda
      ,   'Tasa'                 = car.caprecal
      ,   'Dias'                 = car.caplazo
      ,   'Dias residuales'      = car.caplazovto
      ,   'Precio Equilibrio'    = CASE WHEN car.cacodmon2 = 998 THEN ROUND(((( car.catipcam / @nspotuhoy) - 1) * 36000) / (CASE WHEN car.caplazovto = 0 THEN 1 ELSE car.caplazovto END), 11)
                                        ELSE car.catipcam
                                   END
      ,   'Fecha Proceso'        = @cfecproc
      ,   'Nombre Empresa'       = @cnomprop
      ,   'Direccion Empresa'    = @cdirprop
      ,   'Valor UF'             = @uf
      ,   'Valor Observado'      = @observado
      ,   'fecha_UF'             = @fecha_uf
      ,   'fecha_Observado'      = @fecha_observado
      ,   'Entidad'              = ( SELECT rcnombre FROM VIEW_ENTIDAD WHERE rccodcar = car.cacodsuc1)
      ,   'Hora'                 = CONVERT(CHAR(5), GETDATE(), 108)
      ,   'producto'		 = @producto
      ,   'glosa_producto'	 = pro.descripcion
      ,   'Tipo_Cart'	 	 = (SELECT DISTINCT ISNULL(rcnombre,'') FROM BacParamSuda..TIPO_CARTERA WHERE rcsistema = 'BFW' And rccodpro = car.cacodpos1 and rcrut = car.cacodcart)
      ,   'Tipo_InV'	 	 = @Glosa_Cartera
      ,   'cartnorm'	         = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = cacartera_normativa),    'No Especificado')
      ,   'subcart'	         = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = casubcartera_normativa), 'No Especificado')
      ,   'Libro'		 = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = calibro),                'No Especificado') 
      FROM #TMP_CARTERA_PASO                    car with(nolock)
           INNER JOIN BacParamSuda.dbo.CLIENTE  cli with(nolock) ON cli.clrut      = car.cacodigo and cli.clcodigo = car.cacodcli
           LEFT  JOIN BacParamSuda.dbo.PRODUCTO pro with(nolock) ON pro.id_sistema = 'BFW'        and pro.codigo_producto = car.cacodpos1
           INNER JOIN BacParamSuda.dbo.MONEDA   mn1 with(nolock) ON mn1.mncodmon   = car.cacodmon1
           INNER JOIN BacParamSuda.dbo.MONEDA   mn2 with(nolock) ON mn2.mncodmon   = car.cacodmon2
           INNER JOIN BacParamSuda.dbo.MONEDA   mon with(nolock) ON mon.mncodmon   = car.camdausd
     WHERE (cacodcart          = @Cartera_INV OR @Cartera_INV = 0)

END

GO
