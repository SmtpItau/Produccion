USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEINFSEGCAM]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_LEEINFSEGCAM]	(	@tipo			FLOAT
					,	@dfecdesde		CHAR(08)
					,	@Cat_CartNorm		CHAR(06)
					,	@Cat_SubCartNorm	CHAR(06)
					,	@Cat_Libro		CHAR(06)
					)
AS
BEGIN
   SET NOCOUNT ON
  
   DECLARE @cnomprop   CHAR ( 40 )
   DECLARE @cdirprop   CHAR ( 40 )
   DECLARE @cfecproc   CHAR ( 10 )
   DECLARE @dfecproc   CHAR (  8 )
   DECLARE @ENCONTRO1  CHAR (  1 )
   DECLARE @ENCONTRO2  CHAR (  1 )

   SELECT      @cnomprop = (Select rcnombre from VIEW_ENTIDAD),
               @cdirprop = acdirprop                          ,
               @dfecproc = CONVERT( CHAR(08), acfecproc, 112 ),
               @cfecproc = CONVERT( CHAR(10), acfecproc, 103 ) 
          FROM MFAC

 SELECT @encontro1 = 'S' 
 SELECT @encontro2 = 'S'

   IF @dfecdesde = @dfecproc BEGIN
	IF NOT EXISTS( SELECT 1 
		       FROM   MFMO         a,
		              VIEW_CLIENTE c,
		              VIEW_MONEDA  f,
		              VIEW_MONEDA  g,
		              VIEW_MONEDA  h
		       WHERE  a.mocodpos1  = @tipo        AND
		             (a.mocodigo  = c.clrut       AND
		              a.mocodcli   = c.clcodigo ) AND
		              a.momdausd   = f.mncodmon   AND   
		              a.mocodmon1  = g.mncodmon   AND
		              a.mocodmon2  = h.mncodmon  ) BEGIN

		SELECT @ENCONTRO1 = 'N'
	END
        ELSE
  
		SELECT	'Numero Contrato'  = convert( numeric(10), a.monumoper )  , 
			'Rut Cliente'      = c.clrut       ,
			'DV'               = c.cldv        ,
			'Nombre Cliente'   = c.clnombre    ,
			'Fecha Inicio'     = CONVERT(CHAR(10),a.mofecha,103),
			'Fecha Termino'    = CONVERT(CHAR(10),a.mofecvcto,103),
			'Dias'             = a.moplazo     ,                
			'Moneda'           = ISNULL(f.mnnemo,'N/D')   , 
			'M/X'              = g.mnnemo      ,
			'Monto M/X'        = a.momtomon1  ,
			'M/N cnv'          = h.mnnemo      , 
			'Precio'           = a.moprecal    ,
			'T/C Final'        = a.motipcam    ,
			'Monto Final'      = a.momtomon2   ,
			'mod.cumplimiento' = a.motipmoda   ,
			'Pago M/N'         = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.mofpagomn )),
			'Pago M/X'         = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.mofpagomx )),
			'Nombre Empresa'   = @cnomprop     ,
			'Tipo de Operacion'= case when a.motipoper = 'C' then 'Compras' else 'Ventas' end    , -- Obs.3 5522
			'Spread'           = a.mospread    ,
			'Direccion'        = @cdirprop     ,
			'Fecha de Proceso' = @cfecproc     ,
			'Entidad'          = @cnomprop     ,
			'Hora'             =  CONVERT(CHAR(08),GETDATE(),108),
			'Fecha_Cons'	= CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103),
			'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm AND tbcodigo1 = mocartera_normativa),'No Especificado')	,
			'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartNorm  AND tbcodigo1 = mosubcartera_normativa),'No Especificado')	,
			'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro    AND tbcodigo1 = molibro),'No Especificado') ,
            'Producto'      = a.mocodpos1,     
            'PtsFwd'        = case when a.mocodpos1 = 14 then MoPuntosFwdCierre else 0.0 end ,                          -- Obs. 3 5522
            'FchStarting'   = CONVERT(CHAR(10), case when a.mocodpos1 = 14 then MoFechaStarting   else '19000101' end, 103 ), -- Obs. 3 5522
			'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
   
		FROM	MFMO         a,
			VIEW_CLIENTE c,
			VIEW_MONEDA  f,
			VIEW_MONEDA  g,
			VIEW_MONEDA  h 
		WHERE	a.mocodpos1  = @tipo        AND
			(a.mocodigo  = c.clrut       AND
			a.mocodcli   = c.clcodigo ) AND
			a.momdausd   = f.mncodmon   AND   
			a.mocodmon1  = g.mncodmon   AND
			a.mocodmon2  = h.mncodmon
   END
   ELSE BEGIN
	IF EXISTS( SELECT 1
		   FROM   mfmoh a,
		          VIEW_CLIENTE c,
		          VIEW_MONEDA  f,
		          VIEW_MONEDA  g,
		          VIEW_MONEDA h
		   WHERE  a.mocodpos1  = @tipo        AND
	 	          (a.mocodigo   = c.clrut     AND
		          a.mocodcli   = c.clcodigo ) AND
			  a.momdausd   = f.mncodmon   AND   
		          a.mocodmon1  = g.mncodmon   AND
		          a.mocodmon2  = h.mncodmon   AND
		          a.mofecha    = @dfecdesde  ) 
	
	 	SELECT	'Numero Contrato'  = convert( numeric(10), a.monumoper )  , 
			'Rut Cliente'      = c.clrut       ,
			'DV'               = c.cldv        ,
			'Nombre Cliente'   = c.clnombre    ,
			'Fecha Inicio'     = CONVERT(CHAR(10),a.mofecha,103),
			'Fecha Termino'    = CONVERT(CHAR(10),a.mofecvcto,103),
			'Dias'             = a.moplazo     ,                
			'Moneda'           = ISNULL(f.mnnemo,'N/D')   , 
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
			'Tipo de Operacion'= case when a.motipoper = 'C' then 'Compras' else 'Ventas' end    , -- Obs.3 5522
			'Spread'           = a.mospread    ,
			'Direccion'        = @cdirprop     ,
			'Fecha de Proceso' = @cfecproc     ,
			'Entidad'          = @cnomprop     ,
			'Hora'             =  CONVERT(CHAR(08),GETDATE(),108),
			'Fecha_Cons' = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103),
			'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm AND tbcodigo1 = mocartera_normativa),'No Especificado')	,
			'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = mosubcartera_normativa),'No Especificado')	,
			'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro    AND tbcodigo1 = molibro),'No Especificado') ,
            'Producto'      = a.mocodpos1,
            'PtsFwd'        = ( case when a.mocodpos1 = 14 then MoPuntosFwdCierre else 0.0 end ) ,       -- Obs. 3 5522
            'FchStarting'   = CONVERT(CHAR(10), case when a.mocodpos1 = 14 then MoFechaStarting   else '19000101' end, 103  ), -- Obs. 3 5522
			'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

		FROM	mfmoh a,
			VIEW_CLIENTE c,
			VIEW_MONEDA  f,
			VIEW_MONEDA  g,
			VIEW_MONEDA h
		WHERE	a.mocodpos1  = @tipo        AND
			(a.mocodigo   = c.clrut      AND
			a.mocodcli   = c.clcodigo ) AND
			a.momdausd   = f.mncodmon   AND   
			a.mocodmon1  = g.mncodmon   AND
			a.mocodmon2  = h.mncodmon   AND
			a.mofecha    = @dfecdesde
	ELSE ------------------------------------------------------
		SELECT @ENCONTRO2 = 'N'
	END

	IF @encontro1 = 'N' OR @encontro2 = 'N' 
		SELECT	'Numero Contrato'  = convert( numeric(10), 0) , 
			'Rut Cliente'      = 0,
			'DV'               = '',
			'Nombre Cliente'   = '',
			'Fecha Inicio'     = '',
			'Fecha Termino'    = '',
			'Dias'             = 0,                
			'Moneda'           = '', 
			'M/X'              = '',
			'Monto M/X'        = 0,
			'M/N cnv'          = '', 
			'Precio'           = 0,
			'T/C Final'        = 0,
			'Monto Final'      = 0,
			'mod.cumplimiento' = '',
			'Pago M/N'         = '',
			'Pago M/X'         = '',
			'Nombre Empresa'   = @cnomprop     ,
			'Tipo de Operacion'= '       ',  -- Obs.3 5522
			'Spread'           = 0,
			'Direccion'        = @cdirprop     ,
			'Fecha de Proceso' = @cfecproc     ,
			'Entidad'          = @cnomprop     ,
			'Hora'             =  CONVERT(CHAR(08),GETDATE(),108),
			'Fecha_Cons' = CONVERT(CHAR(10),CONVERT(DATETIME,@dfecdesde),103),
			'cartnorm'   = ''	,
			'subcart'    = ''	,
			'Libro'         = ''	,
            'Producto'      = 0,
            'PtsFwd'        = convert( float, 0.0 ),
            'FchStarting'   =  CONVERT(CHAR(10), '19000101', 103 ),
			'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)



 
   SET NOCOUNT OFF
END


GO
