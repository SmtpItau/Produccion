USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOVDEOP1446]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


-- sp_MovDeOp1446 5 , '20050330' , '1111' , '1554' , '1552'
CREATE PROCEDURE [dbo].[SP_MOVDEOP1446]	(	@tipo			FLOAT
					,	@dfecdesde		CHAR(08)
					,	@Cat_CartNorm		CHAR(06)
					,	@Cat_SubCartNorm	CHAR(06)
					,	@Cat_Libro		CHAR(06)
                                   )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @cnomprop      CHAR ( 40 )
   DECLARE @cdirprop      CHAR ( 40 )
   DECLARE @cfecproc      CHAR ( 10 )
   DECLARE @dfecproc      CHAR ( 8 )
   DECLARE @ENCONTRO1  CHAR (  1 )
   DECLARE @ENCONTRO2  CHAR (  1 )
  
   SELECT      @cnomprop  = (Select rcnombre from VIEW_ENTIDAD),
               @cdirprop  = acdirprop                          ,
               @dfecproc  = CONVERT( CHAR(08), acfecproc, 112 ),
               @cfecproc  = CONVERT( CHAR(10), acfecproc, 103 )                      
          FROM MFAC
 SELECT @encontro1 = 'S' 
 SELECT @encontro2 = 'S'
   IF @dfecdesde = @dfecproc 
   BEGIN
  IF NOT EXISTS( SELECT 1 
         FROM   MFMO         a,
                VIEW_CLIENTE c,
                VIEW_MONEDA  g,
                VIEW_MONEDA  h
         WHERE  a.mocodpos1  = @tipo        AND
               (a.mocodigo   = c.clrut      AND
                a.mocodcli   = c.clcodigo ) AND
                a.mocodmon1  = g.mncodmon   AND
                a.mocodmon2  = h.mncodmon
   )
   SELECT @ENCONTRO1 = 'N'
  ELSE 
        SELECT 'Numero Contrato'  = a.monumoper   , 
               'Rut Cliente'      = c.clrut       ,
               'DV'               = c.cldv        ,
               'Nombre Cliente'   = c.clnombre    ,
               'Fecha Inicio'     = CONVERT(CHAR(10),a.mofecha,103),
               'Fecha Termino'    = CONVERT(CHAR(10),a.mofecvcto,103),
               'Dias'             = a.moplazo     ,                
               'M/X'              = g.mnnemo      ,
               'Monto M/X'        = a.momtomon1   ,
               'M/N cnv'          = h.mnnemo      , 
               'Precio'           = a.moprecal    ,
               'T/C Final'        = a.motipcam    ,
               'Monto Final'      = a.momtomon2   ,
               'mod.cumplimiento' = a.motipmoda   ,
               'Pago M/N'         = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.mofpagomn )),
               'Pago M/X'         = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.mofpagomx )),
               'Nombre Empresa'   = @cnomprop     ,
               'Tipo de Operacion'= a.motipoper   ,
               'Spread'           = a.mospread    ,
               'Direccion'        = @cdirprop     ,
               'Fecha de Proceso' = @cfecproc     , 
               'Monto USD Finales'    = a.momtomon1      ,
               'Monto USD Iniciales'  = a.momtomon1ini   ,  
               'Tasa USD'             = a.motasausd      ,
               'Tasa CNV'             = a.motasacon      ,
               'Precio Spot'          = a.mopremon1      ,
               'Precio Futuro'        = a.motipcam       ,                  
               'Entidad'          = @cnomprop            ,
               'Hora'             = CONVERT(CHAR(08),GETDATE(),108),
               'Fecha_Cons' = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103),
		       'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = mocartera_normativa),'No Especificado')	,
		       'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = mosubcartera_normativa),'No Especificado')	,
		       'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = molibro),'No Especificado') 
        FROM   MFMO         a,
               VIEW_CLIENTE c,
               VIEW_MONEDA  g,
               VIEW_MONEDA  h
        WHERE  a.mocodpos1  = @tipo        AND
              (a.mocodigo   = c.clrut      AND
               a.mocodcli   = c.clcodigo ) AND
               a.mocodmon1  = g.mncodmon   AND
               a.mocodmon2  = h.mncodmon
   END
   ELSE
   BEGIN
  IF NOT EXISTS( SELECT 1
         FROM   MFMOH a,
                VIEW_CLIENTE c,
                VIEW_MONEDA  g,
                VIEW_MONEDA  h
         WHERE  a.mocodpos1  = @tipo        AND
               (a.mocodigo   = c.clrut      AND
                a.mocodcli   = c.clcodigo ) AND
                a.mocodmon1  = g.mncodmon   AND
                a.mocodmon2  = h.mncodmon   AND
                a.mofecha    = @dfecdesde
    )
   SELECT @ENCONTRO2 = 'N'
  ELSE
        SELECT 'Numero Contrato'      = a.monumoper   , 
               'Rut Cliente'          = c.clrut       ,
               'DV'                   = c.cldv        ,
               'Nombre Cliente'       = c.clnombre    ,
               'Fecha Inicio'         = CONVERT(CHAR(10),a.mofecha,103),
               'Fecha Termino'        = CONVERT(CHAR(10),a.mofecvcto,103),
               'Dias'                 = a.moplazo     ,                
               'M/X'                  = g.mnnemo      ,
               'Monto M/X'            = a.momtomon1   ,
               'M/N cnv'              = h.mnnemo      , 
               'Precio'               = a.moprecal    ,
               'T/C Final'            = a.motipcam    ,
               'Monto Final'          = a.momtomon2   ,
               'mod.cumplimiento'     = a.motipmoda   ,
               'Pago M/N'             = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.mofpagomn )),
               'Pago M/X'             = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.mofpagomx )),
               'Nombre Empresa'       = @cnomprop     ,
               'Tipo de Operacion'    = a.motipoper   ,
               'Spread'               = a.mospread    ,
               'Direccion'            = @cdirprop     ,
               'Fecha de Proceso'     = @cfecproc     ,
               'Monto USD Finales'    = a.momtomon1    ,
			   'Monto USD Iniciales'  = a.momtomon1ini ,  
               'Tasa USD'             = a.motasausd    ,
               'Tasa CNV'             = a.motasacon    ,
               'Precio Spot'          = a.mopremon1    ,
               'Precio Futuro'        = a.motipcam     ,                  
               'Entidad'              = @cnomprop     ,
               'Hora'                 =  CONVERT(CHAR(08),GETDATE(),108),
               'Fecha_Cons' = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103),
		       'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = mocartera_normativa),'No Especificado')	,
		       'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = mosubcartera_normativa),'No Especificado')	,
		       'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = molibro),'No Especificado') 
        FROM   MFMOH a,
               VIEW_CLIENTE c,
               VIEW_MONEDA  g,
               VIEW_MONEDA  h
        WHERE  a.mocodpos1  = @tipo        AND
              (a.mocodigo   = c.clrut      AND
               a.mocodcli   = c.clcodigo ) AND
               a.mocodmon1  = g.mncodmon   AND
               a.mocodmon2  = h.mncodmon   AND
               a.mofecha    = @dfecdesde
   END
   IF @encontro1 = 'N' OR @encontro2 = 'N'
        SELECT 'Numero Contrato'      = 0, 
               'Rut Cliente'          = 0,
               'DV'                   = '',
               'Nombre Cliente'       = '',
               'Fecha Inicio'         = '',
               'Fecha Termino'        = '',
               'Dias'                 = 0,                
               'M/X'                  = '',
               'Monto M/X'            = 0,
               'M/N cnv'              = '', 
               'Precio'               = 0,
               'T/C Final'            = 0,
               'Monto Final'          = 0,
               'mod.cumplimiento'     = '',
               'Pago M/N'             = '',
               'Pago M/X'             = '',
               'Nombre Empresa'       = @cnomprop     ,
               'Tipo de Operacion'    = '',
               'Spread'               = 0,
               'Direccion'            = @cdirprop     ,
               'Fecha de Proceso'     = @cfecproc     ,
               'Monto USD Finales'    = 0,
			   'Monto USD Iniciales'  = 0,  
               'Tasa USD'             = 0,
			   'Tasa CNV'             = 0,
			   'Precio Spot'          = 0,
               'Precio Futuro'        = 0,                  
               'Entidad'              = @cnomprop     ,
               'Hora'                 =  CONVERT(CHAR(08),GETDATE(),108),
               'Fecha_Cons' = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103),
			   'cartnorm'	= '',
		       'subcart'	= '',
		       'Libro'		= ''

   SET NOCOUNT OFF
END


GO
