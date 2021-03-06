USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERACONTRAPARTEMONETARIA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


-- sp_carteracontrapartemonetaria 1,'1','1111','1554','1552'
CREATE PROCEDURE [dbo].[SP_CARTERACONTRAPARTEMONETARIA]	(	@ncartera		FLOAT	
							,	@Cartera_Inv		Integer
							,	@Cat_CartNorm		CHAR(06) = ''
							,	@Cat_SubCartNorm	CHAR(06) = ''
							,	@Cat_Libro		CHAR(06) = ''
							)
AS
BEGIN 
   SET NOCOUNT ON
   DECLARE @nnomprop  CHAR(50)
   DECLARE @ndirprop  CHAR(50)
   DECLARE @codigouf  NUMERIC(3)
   DECLARE @codigoobs  NUMERIC(3)
   DECLARE @nfecproc  DATETIME
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
   SELECT @nnomprop = (Select rcnombre from VIEW_ENTIDAD),
          @ndirprop = (Select rcdirecc from VIEW_ENTIDAD),
          @nfecproc = acfecproc     ,
   @codigouf = accodmonuf    ,
   @codigoobs = accodmondolobs    
   FROM   MFAC   
   IF EXISTS(  SELECT  *    
  FROM    MFCA         a,
   VIEW_CLIENTE b,
   VIEW_MONEDA  c,
   VIEW_MONEDA  d 
  WHERE (b.clrut      = a.cacodigo   AND
   a.cacodcli   = b.clcodigo ) AND
   a.cacodmon1  = c.mncodmon   AND
   a.cacodmon2  = d.mncodmon   AND
   a.cacodpos1  = @ncartera    AND
   a.cacodmon2  <> 13       AND
   a.cafecvcto  > @nfecproc and
(   cacodcart   =  @Cartera_INV or @Cartera_INV = 0)
     ) 
 BEGIN
     SELECT 'Tipo Operacion'               = a.catipoper                        ,
            'Numero Operacion'             = a.canumoper                        ,
            'Nombre Cliente'               = b.clnombre                         ,
            'Fecha Inicio'                 = CONVERT(CHAR(10), a.cafecha, 103)  ,
            'Fecha Termino'                = CONVERT(CHAR(10), a.cafecvcto, 103),
            'Plazo'                        = a.caplazo                          ,
            'Plazo Residual'               = datediff(dd,@nfecproc,a.cafecvcto) ,
            'Monto CNV Finales'            = a.camtomon2fin                     ,
            'Monto CNV Iniciales'           = a.camtomon2ini                     ,
            'Tasa USD'                     = a.catasausd                        ,
            'tasa CNV'                     = a.catasacon                        ,
            'Precio Spot'                  = CASE a.cacodmon2 WHEN @codigouf THEN a.capremon2 ELSE a.capremon1 END            ,
            'Precio Futuro'                = a.caprecal                         ,
            'Moneda1'                      = c.mnnemo                           ,
            'Moneda2'                      = d.mnnemo                           ,
            'Monto a Diferir en CNV'       = ABS(a.diferido_cnv)                ,
            'Devengo Acumulado en CNV'     = ABS(a.devengo_acum_cnv_hoy)        ,
            'valorizacion'                 = a.carevuf                          ,
            'Nombre Empresa'               = @nnomprop                          ,
            'Direccion Empresa'            = @ndirprop                          ,
            'Fecha Proceso'                = CONVERT(CHAR(10), @nfecproc, 103 ) ,
            'Observado'                    = @observado         ,
            'valor UF'                     = @uf           ,
            'Entidad'                      = ( SELECT rcnombre
                                               from   VIEW_ENTIDAD
                                               where  rccodcar = a.cacodsuc1 )  ,
            'Hora'                         =  CONVERT(CHAR(5), getdate(),108)   ,
     'Tipo Cartera'   = @ncartera           ,
       'fecha_observado'   = @fecha_observado        ,
       'fecha_uf'    = @fecha_uf	,
    'Tipo_Cart'	           = (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BFW' And rccodpro = cacodpos1 and rcrut = cacodcart ),
    'Tipo_InV'	 	   = @Glosa_Cartera	,
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
   a.cacodpos1  = @ncartera    AND
   a.cacodmon2  <> 13       AND
   a.cafecvcto  > @nfecproc  and
(   cacodcart   =  @Cartera_INV or @Cartera_INV = 0)
 END
   ELSE
 BEGIN
     SELECT 'Tipo Operacion'               = '',
            'Numero Operacion'             = 0,
            'Nombre Cliente'			   = '',
            'Fecha Inicio'                 = '',
            'Fecha Termino'                = '',
            'Plazo'                        = 0,
            'Plazo Residual'               = 0,
            'Monto CNV Finales'            = 0,
            'Monto CNV Iniciales'          = 0,
            'Tasa USD'                     = 0,
            'tasa CNV'                     = 0,
            'Precio Spot'                  = 0,
            'Precio Futuro'                = 0,
            'Moneda1'                      = '',
            'Moneda2'                      = '',
            'Monto a Diferir en CNV'       = 0,
            'Devengo Acumulado en CNV'     = 0,
            'valorizacion'                 = 0,
            'Nombre Empresa'               = @nnomprop                          ,
            'Direccion Empresa'            = @ndirprop                          ,
            'Fecha Proceso'                = CONVERT(CHAR(10), @nfecproc, 103 ) ,
            'Observado'                    = @observado         ,
            'valor UF'                     = @uf           ,
            'Entidad'                      = '',
            'Hora'                         =  CONVERT(CHAR(5), getdate(),108)   ,
     'Tipo Cartera'   = @ncartera           ,
       'fecha_observado'   = @fecha_observado        ,
       'fecha_uf'    = @fecha_uf ,
    'Tipo_Cart'	           = ' '	,
    'Tipo_InV'	 	   = @Glosa_Cartera		,
			'cartnorm'	= ''	,
			'subcart'	= ''	,
			'Libro'		= ''

 END
   SET NOCOUNT OFF
END


GO
