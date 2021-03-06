USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERAOPER1446]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


-- sp_carteraoper1446 1 ,'1111','1554','1552'
CREATE PROCEDURE [dbo].[SP_CARTERAOPER1446]		(	@Cartera_Inv		INT
						,	@Cat_CartNorm		CHAR(06) = ''
						,	@Cat_SubCartNorm	CHAR(06) = ''
						,	@Cat_Libro		CHAR(06) = ''
						)
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @nvaluf     FLOAT  
   DECLARE @nvalob     FLOAT
   DECLARE @cnomprop   CHAR(40)
   DECLARE @cdirprop   CHAR(40)
   DECLARE @cfecproc   CHAR(10)
   DECLARE @dfecproc   DATETIME
   DECLARE @observado  NUMERIC(12,04) ,
    @uf   NUMERIC(12,04) ,
    @fecha_observado CHAR(10) ,
    @fecha_uf  CHAR(10) ,
  	 @Glosa_Cartera Char   (20)

	Select @Glosa_Cartera = '' 

   SELECT Distinct
	  @Glosa_Cartera = IsNull(rcnombre,'')
   FROM   BacParamSuda..TIPO_CARTERA
   WHERE  rcsistema = 'BFW'
     And  rcrut     = @Cartera_INV
   --ORDER BY rcrut

  if @Glosa_Cartera = '' 
	Select @Glosa_Cartera = '< TODAS >'

   EXECUTE sp_parametros_reporte @observado  OUTPUT ,
     @uf   OUTPUT ,
     @fecha_observado OUTPUT ,
     @fecha_uf  OUTPUT
   
   SELECT @cnomprop = a.acnomprop                          ,
          @cdirprop = a.acdirprop                          ,
          @cfecproc = CONVERT( CHAR(10), a.acfecproc, 103 ),
          @dfecproc = a.acfecproc
   FROM   MFAC a             
   IF EXISTS(  SELECT * 
  FROM   MFCA         a,
   VIEW_CLIENTE b,
   VIEW_MONEDA  c,
   VIEW_MONEDA  d
  WHERE (b.clrut      = a.cacodigo   AND
   a.cacodcli   = b.clcodigo ) AND
   a.cacodmon1  = c.mncodmon   AND
   a.cacodmon2  = d.mncodmon   AND
   a.cacodpos1  = 5            AND
   a.cafecvcto  > @dfecproc    and
(   cacodcart   =  @Cartera_INV or @Cartera_INV = 0)
     ) 
 BEGIN
 
  SELECT 'Tipo Operacion'               = a.catipoper                              ,
            'Numero Operacion'             = a.canumoper                              ,
            'Nombre Cliente'               = b.clnombre                               ,
            'Fecha Inicio'                 = CONVERT(CHAR(10), a.cafecha, 103)        ,
            'Fecha Termino'                = CONVERT(CHAR(10), a.cafecvcto, 103)      ,
            'Plazo'                        = a.caplazo                                ,
            'Plazo Residual'               = datediff(dd,@dfecproc,a.cafecvcto)       ,
            'Monto USD Finales'            = a.camtomon1fin                           ,
            'Monto USD Iniciles'           = a.camtomon1ini                           ,
            'Tasa USD'                     = a.catasausd                              ,
            'Precio Spot'                  = a.capremon1                              ,
            'Monto a Diferir en Dolares'   = ABS(a.diferido_usd)                     ,
            'Devengo Acumulado en dolares' = ABS(a.devengo_acum_usd_hoy)              ,
            'valorizacion'                 = a.carevusd                               ,
            'Nombre Empresa'               = @cnomprop                                ,
            'Direccion Empresa'            = @cdirprop                                ,
            'Fecha Proceso'                = @cfecproc                                ,
            'Observado'                    = @observado                               ,
            'valor UF'                     = @uf                                      ,
            'fecha_Observado'              = @fecha_observado                         ,
            'fecha_UF'                     = @fecha_uf                                ,
            'Entidad'                      = (SELECT rcnombre from VIEW_ENTIDAD where rccodcar = a.cacodsuc1)  ,
            'Hora'                         = CONVERT(CHAR(5), getdate(),108) ,
      	    'Tipo_Cart'	 		   = (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BFW' And rccodpro = cacodpos1 and rcrut = cacodcart ),
	    'Tipo_InV'	 	           = @Glosa_Cartera	,
			'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = cacartera_normativa),'No Especificado')	,
			'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = casubcartera_normativa),'No Especificado')	,
			'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = calibro),'No Especificado') 

  FROM   MFCA         a,
   VIEW_CLIENTE b,
   VIEW_MONEDA  c,
   VIEW_MONEDA  d
  WHERE (b.clrut      = a.cacodigo   AND
   a.cacodcli   = b.clcodigo ) AND
   a.cacodmon1  = c.mncodmon   AND
   a.cacodmon2  = d.mncodmon   AND
   a.cacodpos1  = 5            AND
  a.cafecvcto  > @dfecproc     and
(   cacodcart   =  @Cartera_INV or @Cartera_INV = 0)
 END
    ELSE
 BEGIN
  SELECT 'Tipo Operacion'				   = '',
            'Numero Operacion'             = 0,
            'Nombre Cliente'               = '',
            'Fecha Inicio'                 = '',
            'Fecha Termino'                = '',
            'Plazo'                        = 0,
            'Plazo Residual'               = '',
            'Monto USD Finales'            = 0,
            'Monto USD Iniciles'           = 0,
            'Tasa USD'                     = 0,
         'Precio Spot'                  = 0,
            'Monto a Diferir en Dolares'   = 0,
            'Devengo Acumulado en dolares' = 0,
            'valorizacion'                 = 0,
            'Nombre Empresa'               = @cnomprop                                ,
            'Direccion Empresa'            = @cdirprop                                ,
            'Fecha Proceso'                = @cfecproc                                ,
            'Observado'                    = @observado                               ,
            'valor UF'                     = @uf                                      ,
            'fecha_Observado'              = @fecha_observado                         ,
            'fecha_UF'                     = @fecha_uf                                ,
            'Entidad'                      = ''										  ,
            'Hora'                         = CONVERT(CHAR(5), getdate(),108) 	      ,
      	    'Tipo_Cart'	 		   = ' '				      ,
	    'Tipo_InV'	 		   = @Glosa_Cartera				,
			'cartnorm'				       = ''										  ,
			'subcart'	                   = ''										  ,
			'Libro'						   = ''

 END
   SET NOCOUNT OFF
END


GO
