USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERVTASBCCH]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


-- sp_cartervtasbcch 3 ,'1111','1554','1552'
CREATE PROCEDURE [dbo].[SP_CARTERVTASBCCH]	(	@Cartera_Inv		INT
					,	@Cat_CartNorm		CHAR(06) = ''
					,	@Cat_SubCartNorm	CHAR(06) = ''
					,	@Cat_Libro		CHAR(06) = ''
					)
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @cnomprop   CHAR(40)
   DECLARE @cdirprop   CHAR(40)
   DECLARE @cfecproc   CHAR(10)
   DECLARE @dfecproc   DATETIME
   DECLARE @observado  NUMERIC(12,04) ,
 	   @uf   NUMERIC(12,04) ,
 	   @fecha_observado CHAR(10) ,
 	   @fecha_uf  CHAR(10) 	,
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
   SELECT      @cnomprop = (Select rcnombre from VIEW_ENTIDAD)  ,
               @cdirprop = a.acdirprop                          ,
               @dfecproc = a.acfecproc                          ,
               @cfecproc = CONVERT( CHAR(10), a.acfecproc, 103 )
   FROM        MFAC a             
 IF EXISTS( SELECT * 
     FROM    MFCA              a,
   VIEW_CLIENTE      b,
   VIEW_MONEDA       c,
   VIEW_MONEDA       d,
   VIEW_MONEDA       e
     WHERE  
   (a.cacodpos1  = 8          ) AND
   a.catipoper  = 'V'          AND
   (a.cacodigo   = b.clrut      AND
   a.cacodcli   = b.clcodigo ) AND
   a.camdausd   = c.mncodmon   AND   
   a.cacodmon1  = d.mncodmon   AND
   a.cacodmon2  = e.mncodmon   AND
   a.cafecvcto <> @dfecproc    and
(   cacodcart   =  @Cartera_INV or @Cartera_INV = 0)
     ) 
  BEGIN
   SELECT  'Numero Operacion'     = a.canumoper                      ,
    'Tipo Operacion'       = a.catipoper                      ,
    'Cliente'              = ISNULL(clnombre,' ')             ,
    'Fecha Inicio'         = CONVERT(CHAR(10),a.cafecha,103)  ,
    'Fecha Termino'        = CONVERT(CHAR(10),a.cafecvcto,103),
    'M/X'                  = ISNULL(d.mnnemo,'N/D')           ,
    'Mto M/X Vendido'       = a.camtomon1                      ,
    'T/C Obs Ini'          = a.capremon1                      ,  --En Realidad es el TCR de Entrada
    'Mto CLP Inicial T/C'  = a.caequmon1                      ,
    'M/N CNV'              = ISNULL(e.mnnemo,'N/D')           ,
    'T/C Final  '          = CASE a.cacodmon2 WHEN 998 THEN
         a.capremon2
        ELSE
         a.catipcam
        END                              ,
    'Monto CNV'            = a.camtomon2                      ,
    'Monto CNV En Pesos'   = a.caequmon2                      ,
    'Valor a Diferir'      = a.cautildiferir + a.caperddiferir,
    'Devengo Acumulado'    = a.cautilacum + a.caperdacum      ,
    'Ajuste Variacion UF'  = a.carevuf                        ,
    'Valorizacion'         = a.carevtot                       ,
    'Modalidad'            = a.catipmoda                      ,
    'Fecha Proceso'        = @cfecproc                        ,
    'Nombre Empresa'       = @cnomprop                        ,
    'Direccion Empresa'    = @cdirprop                        ,         
    'Valor UF'             = @uf                              ,
    'Valor Observado'      = @observado                       ,
    'fecha_UF'             = @fecha_uf                        ,
    'fecha_Observado'      = @fecha_observado                 ,
    'Entidad'              = ( SELECT rcnombre
       FROM   VIEW_ENTIDAD
       WHERE  rccodcar = a.cacodsuc1 ),
    'Hora'                 = CONVERT(CHAR(5),GETDATE(),108 )	,
    'Tipo_Cart'	           = (SELECT Distinct IsNull(rcnombre,'') FROM   BacParamSuda..TIPO_CARTERA WHERE  rcsistema = 'BFW' And rccodpro = cacodpos1 and rcrut = cacodcart ),
    'Tipo_InV'	 	   = @Glosa_Cartera	,
	'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = cacartera_normativa),'No Especificado')	,
	'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = casubcartera_normativa),'No Especificado')	,
	'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = calibro),'No Especificado') 
   FROM    MFCA              a,
    VIEW_CLIENTE      b,
    VIEW_MONEDA       c,
    VIEW_MONEDA       d,
    VIEW_MONEDA       e
   WHERE  
    (a.cacodpos1  = 8          ) AND
    a.catipoper  = 'V'          AND
    (a.cacodigo   = b.clrut      AND
    a.cacodcli   = b.clcodigo ) AND
    a.camdausd   = c.mncodmon   AND   
    a.cacodmon1  = d.mncodmon   AND
    a.cacodmon2  = e.mncodmon   AND
    a.cafecvcto <> @dfecproc    and
(   cacodcart   =  @Cartera_INV or @Cartera_INV = 0)
  END
 ELSE
  BEGIN
   SELECT  'Numero Operacion'     = 0,
    'Tipo Operacion'       = '',
    'Cliente'              = '',
    'Fecha Inicio'         = '',
    'Fecha Termino'        = '',
    'M/X'                  = '',
    'Mto M/X Vendido'       =0,
    'T/C Obs Ini'          = 0,  --En Realidad es el TCR de Entrada
    'Mto CLP Inicial T/C'  = 0,
    'M/N CNV'           = '',
    'T/C Final  '          = 0,
    'Monto CNV'            = 0,
    'Monto CNV En Pesos'   = 0,
    'Valor a Diferir'      = 0,
    'Devengo Acumulado'    = 0,
    'Ajuste Variacion UF'  = 0,
    'Valorizacion'         = 0,
    'Modalidad'            = '',
    'Fecha Proceso'        = @cfecproc                        ,
    'Nombre Empresa'       = @cnomprop                        ,
    'Direccion Empresa'    = @cdirprop                        ,         
    'Valor UF'             = @uf                              ,
    'Valor Observado'      = @observado                       ,
    'fecha_UF'             = @fecha_uf                        ,
    'fecha_Observado'      = @fecha_observado                 ,
    'Entidad'              = '',
    'Hora'                 = CONVERT(CHAR(5),GETDATE(),108 )  ,
    'Tipo_Cart'	 	   = ''	,
    'Tipo_InV'	 	   = @Glosa_Cartera	,
	'cartnorm'	= ''	,
	'subcart'	= ''	,
	'Libro'		= '' 

  END
   SET NOCOUNT OFF
END


GO
