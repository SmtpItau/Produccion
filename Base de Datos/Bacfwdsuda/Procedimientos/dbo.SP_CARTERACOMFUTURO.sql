USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERACOMFUTURO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CARTERACOMFUTURO]	(	@ctipope		CHAR(1)
						,	@Cartera_Inv		INT
						,	@Cat_CartNorm		CHAR(06) = ''
						,	@Cat_SubCartNorm	CHAR(06) = ''
						,	@Cat_Libro		CHAR(06) = ''
						)
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @nnomprop CHAR(50)
   DECLARE @ndirprop CHAR(50)
   DECLARE @nfecproc DATETIME
DECLARE  @observado  NUMERIC(12,04) ,
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


EXECUTE sp_parametros_reporte  @observado  OUTPUT ,
    @uf   OUTPUT ,
    @fecha_observado OUTPUT ,
    @fecha_uf  OUTPUT
   SELECT  @nnomprop = (Select rcnombre from VIEW_ENTIDAD),
           @ndirprop = a.acdirprop                        ,
           @nfecproc = a.acfecproc
   FROM    MFAC              a
   IF EXISTS(  SELECT * 
  FROM    MFCA         a,
   VIEW_CLIENTE b,
   VIEW_MONEDA  c,
   VIEW_MONEDA  d    
  WHERE  (b.clrut      = a.cacodigo   AND
   a.cacodcli   = b.clcodigo ) AND
   a.cacodmon1  = c.mncodmon   AND
   a.cacodmon2  = d.mncodmon   AND
   a.catipoper  = @ctipope     AND 
   a.cacodpos1  in ( 3,13)            AND
   a.cafecvcto  > @nfecproc    and
(   cacodcart   =  @Cartera_INV or @Cartera_INV = 0)
     )
 BEGIN
    SELECT  'Tipo Operacion'    = a.catipoper                        ,
            'Numero Operacion'  = a.canumoper                        ,
            'Nombre Cliente'    = b.clnombre                         ,
            'Fecha Inicio'      = CONVERT(CHAR(10), a.cafecha, 103)  ,
            'Fecha Termino'     = CONVERT(CHAR(10), a.cafecvcto, 103),
            'Dias Cto'          = a.caplazo                          ,
            'Plazo Residual'    = a.caplazovto                       ,
            'Mon'               = c.mnnemo                           ,
     'Monto Uf'          = a.camtomon1                        ,
            'Valor Uf Inicial'  = a.capremon1                        ,
            'Monto Clp Inicial' = a.camtomon2                        ,
            'M/N Cnv'           = d.mnnemo                           ,
            'Valor Uf Final'    = a.catipcam                         ,
            'Monto Clp Uf Fwd'  = a.caequmon1                        ,
            'Valor a Diferir'   = a.cautildiferir + caperddiferir    ,
            'Devengo Acumulado' = a.cautilacum + caperdacum          ,
            'res var multi'     = a.carevuf                          ,
            'M'                 = a.catipmoda                        ,
            'Nombre Empresa'    = @nnomprop                          ,
            'Direccion Empresa' = @ndirprop                          ,
            'Fecha Proceso'     = CONVERT(CHAR(10), @nfecproc,103)   ,
            'UF valor dia'      = @uf                                ,
            'fecha_uf'          = @fecha_uf                          ,
            'Entidad'           = (SELECT rcnombre
                                   from   VIEW_ENTIDAD
                                   where  rccodcar = a.cacodsuc1 )   ,
            'Hora'              = CONVERT(CHAR(5), getdate(),108)	,
      	    'Tipo_Cart'	 	= (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BFW' And rccodpro = cacodpos1 and rcrut = cacodcart ),
	    'Tipo_InV'	 	= @Glosa_Cartera,
	    'Dif_Dife_Total'	= (a.cautildiferir + caperddiferir) - (a.cautilacum + caperdacum),
	    'Valoriza_Dia'	= CASE WHEN @ctipope =  'C' THEN ROUND((@uf - a.capremon1)*a.camtomon1,4)+ (a.cautilacum + caperdacum)
                                       WHEN @ctipope =  'V' THEN ROUND((a.capremon1- @uf)*a.camtomon1,4)+(a.cautilacum + caperdacum) 
				       ELSE ROUND((a.capremon1- @uf)*a.camtomon1,4)-(a.cautilacum + caperdacum) END ,
		'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = cacartera_normativa),'No Especificado')	,
		'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = casubcartera_normativa),'No Especificado')	,
		'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = calibro),'No Especificado'),
		'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

    FROM    MFCA         a,
            VIEW_CLIENTE b,
            VIEW_MONEDA  c,
            VIEW_MONEDA  d    
    WHERE  (b.clrut      = a.cacodigo   AND
            a.cacodcli   = b.clcodigo ) AND
            a.cacodmon1  = c.mncodmon   AND
            a.cacodmon2  = d.mncodmon   AND
            a.catipoper  = @ctipope     AND 
            a.cacodpos1  IN (3,13)      AND
            a.cafecvcto  > @nfecproc    AND
	(   cacodcart   =  @Cartera_INV OR @Cartera_INV = 0)
 END
   ELSE
 BEGIN
    SELECT  'Tipo Operacion'    = @ctipope,
            'Numero Operacion'  = 0,
            'Nombre Cliente'    = '',
            'Fecha Inicio'      = '',
            'Fecha Termino'     = '',
            'Dias Cto'          = 0,
            'Plazo Residual'    = 0,
            'Mon'               = '',
	    'Monto Uf'          = 0,
            'Valor Uf Inicial'  = 0,
            'Monto Clp Inicial' = 0,
            'M/N Cnv'           = '',
            'Valor Uf Final'    = 0,
            'Monto Clp Uf Fwd'  = 0,
            'Valor a Diferir'   = 0,
            'Devengo Acumulado' = 0,
            'res var multi'     = 0,
      	    'M'                 = '',
            'Nombre Empresa'    = @nnomprop                          ,
            'Direccion Empresa' = @ndirprop                          ,
            'Fecha Proceso'     = CONVERT(CHAR(10), @nfecproc,103)   ,
            'UF valor dia'      = @uf                                ,
            'fecha_uf'          = @fecha_uf                          ,
            'Entidad'           = ''     ,
            'Hora'              = CONVERT(CHAR(5), getdate(),108),
      	    'Tipo_Cart'	 	= ''	,
	    'Tipo_InV'	 	= @Glosa_Cartera	,
	    'Dif_Dife_Total'	= 0.0,
	    'Valoriza_Dia'	= 0.0,
		'cartnorm'	= ''	,
		'subcart'	= ''	,
		'Libro'		= '',
		'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 END
   SET NOCOUNT OFF
END


GO
