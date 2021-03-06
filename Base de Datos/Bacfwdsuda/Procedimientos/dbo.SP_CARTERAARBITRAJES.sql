USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERAARBITRAJES]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[SP_CARTERAARBITRAJES]	(	@Cartera_Inv		Int
						,	@Cat_CartNorm		CHAR(06) = ''
						,	@Cat_SubCartNorm	CHAR(06) = ''
						,	@Cat_Libro		CHAR(06) = ''
						)
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @nnomprop CHAR(50)
   DECLARE @ndirprop CHAR(50)
   DECLARE @nfecproc DATETIME,
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

  
   SELECT @nnomprop = (Select rcnombre from VIEW_ENTIDAD),
          @ndirprop = acdirprop                          ,
          @nfecproc = acfecproc
   FROM   MFAC

   IF EXISTS(  SELECT *
  FROM   MFCA  a,
   VIEW_CLIENTE  b,
   VIEW_MONEDA   c,
   VIEW_MONEDA   d,
   VIEW_MONEDA   e 
  WHERE (b.clrut      = a.cacodigo   AND
   a.cacodcli   = b.clcodigo ) AND
   a.camdausd   = c.mncodmon   AND
   a.cacodmon2  = d.mncodmon   AND
   a.cacodmon1  = e.mncodmon   AND
   a.cacodpos1  = 2            AND
   a.cafecvcto <> @nfecproc     AND 
(   cacodcart   =  @Cartera_INV or @Cartera_INV = 0)
     )
 BEGIN
    SELECT 'Tipo Operacion'         = a.catipoper                         ,
           'Numero Operacion'       = a.canumoper                         ,
           'Nombre Cliente'         = b.clnombre                          ,
           'Fecha Inicio'           = CONVERT(CHAR(10), a.cafecha, 103)   ,
           'Fecha Termino'          = CONVERT(CHAR(10), a.cafecvcto, 103) ,
           'Dias Cnt'               = a.caplazo                           ,
           'PRM'                    = c.mnnemo                            ,
           'TipoCambioInicio'       = a.capremon2                         ,
           'ParidadFutura'          = a.catipcam                          ,
           'TipoCambioValorizacion' = ( SELECT vmvalor
                                        FROM   VIEW_VALOR_MONEDA
                                        WHERE  vmcodigo = 994 AND
                                               vmfecha  = @nfecproc )     , 
           'ParidadValorizacion'    = a.catipcamval                       ,
           'M/X ope'                = e.mnnemo                            ,
           'Monto Operacion'        = a.camtomon1                         ,
           'M/X CNV'                = d.mnnemo                            ,
           'MontoConversion'        = a.camtomon2                         ,
           'Art84'     = CASE a.catipoper WHEN 'C' THEN ROUND(a.caequmon1 - a.caequmon2,0) ELSE ROUND(a.caequmon2 - a.caequmon1,0) END,
           'Valorizacion'           = a.cavalordia                        ,
           'M'                      = a.catipmoda                         ,
           'Nombre Empresa'         = @nnomprop                           ,
           'Direccion Empresa'      = @ndirprop                           ,
           'Fecha Proceso'          = CONVERT(CHAR(10), @nfecproc, 103)   ,
           'Observado'              = ( SELECT vmvalor
                                        FROM   VIEW_VALOR_MONEDA
                                        WHERE  vmcodigo = 994 AND
                                               vmfecha  = @nfecproc )     , 
           'Entidad'                = ( SELECT rcnombre
                                        from   VIEW_ENTIDAD
                                        where  rccodcar = a.cacodsuc1 )   ,
           'Hora'                   = CONVERT(CHAR(5), getdate(),108)     ,
      	   'Tipo_Cart'	 	    = (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BFW' And rccodpro = cacodpos1 and rcrut = cacodcart ),
	   'Tipo_InV'	 	    = @Glosa_Cartera	,
		'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = cacartera_normativa),'No Especificado')	,
		'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = casubcartera_normativa),'No Especificado')	,
		'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = calibro),'No Especificado') 
    FROM   MFCA  a,
           VIEW_CLIENTE  b,
           VIEW_MONEDA   c,
           VIEW_MONEDA   d,
           VIEW_MONEDA   e 
    WHERE (b.clrut      = a.cacodigo   AND
           a.cacodcli   = b.clcodigo ) AND
           a.camdausd   = c.mncodmon   AND
           a.cacodmon2  = d.mncodmon   AND
           a.cacodmon1  = e.mncodmon   AND
           a.cacodpos1  = 2            AND
           a.cafecvcto <> @nfecproc    AND 
	(cacodcart   =  @Cartera_INV or @Cartera_INV = 0) 
 END
   ELSE
 
 BEGIN
    SELECT 'Tipo Operacion'         = '',
           'Numero Operacion'       = 0,
           'Nombre Cliente'         = '',
           'Fecha Inicio'           = '',
           'Fecha Termino'          = '',
           'Dias Cnt'               = 0,
           'PRM'                    = '',
           'TipoCambioInicio'       = 0,
           'ParidadFutura'          = 0,
           'TipoCambioValorizacion' = 0, 
           'ParidadValorizacion'    = 0,
           'M/X ope'                = '',
           'Monto Operacion'        = 0,
           'M/X CNV'                = '',
           'MontoConversion'        = 0,
           'Art84'     = 0,
           'Valorizacion'           = 0,
           'M'                      = '',
           'Nombre Empresa'         = @nnomprop                           ,
           'Direccion Empresa'      = @ndirprop                           ,
           'Fecha Proceso'          = CONVERT(CHAR(10), @nfecproc, 103)   ,
           'Observado'              = 0, 
           'Entidad'                = '',
           'Hora'                   = CONVERT(CHAR(5), getdate(),108)     ,
	   'Tipo_Cart'	 	    = '' ,
   	   'Tipo_InV'	 	    = @Glosa_Cartera	,
		   'cartnorm'	= ''	,
		   'subcart'	= ''	,
		   'Libro'		= '' 

 END
   SET NOCOUNT OFF    
END


GO
