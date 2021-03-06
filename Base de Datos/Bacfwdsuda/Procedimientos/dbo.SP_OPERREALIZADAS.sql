USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_OPERREALIZADAS]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


-- sp_OperRealizadas 1,0,0,'1111','1554','1552','','',''
-- sp_OperRealizadas 2,0,0,'1111','1554','1552','','',''
-- sp_OperRealizadas 3,0,0,'1111','1554','1552','','',''

CREATE PROCEDURE [dbo].[SP_OPERREALIZADAS]	(	
						@tipo               FLOAT
					,	@ncodmda    		FLOAT
					,	@nrutcli    		FLOAT
					,	@Cat_CartNorm		CHAR(06)
					,	@Cat_SubCartNorm	CHAR(06)
					,	@Cat_Libro		CHAR(06)
					,	@Id_CartNorm		CHAR(06)
					,	@Id_SubCartNorm		CHAR(06)
					,	@Id_Libro		CHAR(06)
										)
AS
BEGIN
   SET NOCOUNT ON

   DECLARE @cnomprop   CHAR ( 40 )
   DECLARE @cdirprop   CHAR ( 40 )
   DECLARE @cfecproc   CHAR ( 10 )
   DECLARE @dfecproc   DATETIME

   DECLARE @observado		NUMERIC(12,04)	,
           @uf			NUMERIC(12,04)	,
           @fecha_observado	CHAR(10)	,
           @fecha_uf		CHAR(10)	,
	   @Glosa_Libro		CHAR(50)	

   EXECUTE sp_parametros_reporte @observado  OUTPUT ,
     @uf   OUTPUT ,
     @fecha_observado OUTPUT ,
     @fecha_uf  OUTPUT

   SELECT      @cnomprop = (Select rcnombre from VIEW_ENTIDAD),
               @cdirprop = acdirprop                          ,
               @dfecproc = acfecproc                          ,
               @cfecproc = CONVERT( CHAR(10), acfecproc, 103 ) 
   FROM MFAC

  IF  @id_libro = '' BEGIN
	SELECT @Glosa_libro = '< TODOS >'	
  END 
  ELSE BEGIN
	SELECT	@Glosa_libro	= tbglosa
	FROM	VIEW_TABLA_GENERAL_DETALLE
	WHERE	tbcateg		= @Cat_Libro 
	AND	tbcodigo1	= @Id_Libro
  END

   /*IF EXISTS(  SELECT  1 FROM    MFCA         a,
				 VIEW_CLIENTE c,
				 VIEW_MONEDA  f,
				 VIEW_MONEDA  g,
				 VIEW_MONEDA  h
			 WHERE	a.cacodpos1  = @tipo        AND
				(a.cacodigo   = c.clrut      AND
				a.cacodcli   = c.clcodigo ) AND
				a.camdausd   *= f.mncodmon   AND
				(a.cacodmon1  = g.mncodmon   AND
				a.cacodmon2  = h.mncodmon ) AND
				 a.cafecha   = @dfecproc     )  BEGIN */


	--RQ_7619
	 IF EXISTS(  SELECT  1 FROM    MFCA  a LEFT OUTER JOIN  VIEW_MONEDA  f ON  a.camdausd   = f.mncodmon ,
				 VIEW_CLIENTE c,
				 VIEW_MONEDA  g,
				 VIEW_MONEDA  h
			     WHERE	a.cacodpos1  = @tipo        AND
				(a.cacodigo   = c.clrut         AND
				 a.cacodcli   = c.clcodigo )    AND
				(a.cacodmon1  = g.mncodmon      AND
				 a.cacodmon2  = h.mncodmon )    AND
				a.cafecha   = @dfecproc     )  BEGIN

	SELECT	'Tipo de Operacion'= CASE	WHEN a.catipoper = 'C' THEN 'Compra' 
						WHEN a.catipoper = 'V' THEN 'Venta'  END,
		'Numero Operacion'  = a.canumoper   , 
		'Fecha Termino'    = CONVERT(CHAR(10),a.cafecvcto,103),
		'Dias'             = a.caplazo     ,
		'Monto M/X'        = a.camtomon1  ,  
		'Calce'		       = CASE WHEN a.camtocalzado <> a.camtomon1 THEN 'Abierta' ELSE 'Calzada' END,             
		'Precio'           = CONVERT(NUMERIC(15,2),a.caprecal)   ,
		'Nombre Cliente'   = c.clnombre    ,
		'Modalidad'	       = CASE a.catipmoda WHEN 'C'THEN 'Compensación' ELSE 'Entrega Física' END   ,
		'Monto Final'      = a.camtomon2   ,
		'Moneda'           = ISNULL(f.mnnemo,'N/D')   , 
		'Paridad Spot'     = a.caparmon1   ,
		'Paridad Futuro'   = a.catipcam    ,
		'Producto' 	       = @tipo  ,
		'Codigo Moneda1'   = a.cacodmon1 ,
		'Codigo MonedaCnv' = a.cacodmon2 , 
		'Rut Cliente'      = c.clrut       ,
		'DV'               = c.cldv        ,
		'Fecha Inicio'     = CONVERT(CHAR(10),a.cafecha,103),                             
		'M/X'              = g.mnnemo      ,
		'M/N cnv'          = h.mnnemo      , 
		'T/C Final'        = Round(a.catipcam,4)    ,
		'Pago M/N'         = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.cafpagomn )),
		'Pago M/X'         = (SELECT ISNULL(glosa2,'N/D') FROM VIEW_FORMA_DE_PAGO WHERE codigo = CONVERT(NUMERIC(03,00),a.cafpagomx )),
		'Nombre Empresa'   = @cnomprop     ,             
		'Spread'           = a.caspread    ,
		'Direccion'        = @cdirprop     ,
		'Fecha de Proceso' = @cfecproc     ,
		'Entidad'          = @cnomprop     ,
		'Hora'             = CONVERT(CHAR(08),GETDATE(),108),
		'Observado'        = @observado   ,
		'valor UF'         = @uf    ,
		'fecha_Observado'  = @fecha_observado  ,
		'fecha_UF'         = @fecha_uf   ,
		'cahora'		= a.cahora	,
		'cartnorm'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm AND tbcodigo1 = cacartera_normativa),'No Especificado')	,
		'subcart'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_SubCartNorm  AND tbcodigo1 = casubcartera_normativa),'No Especificado')	,
		'Libro'			= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro  AND tbcodigo1 = calibro),'No Especificado') , 
		'Glosa_Libro'		= @Glosa_Libro
	/*FROM	MFCA         a,
		VIEW_CLIENTE c,
		VIEW_MONEDA  f,
		VIEW_MONEDA  g,
		VIEW_MONEDA  h
	WHERE	a.cacodpos1		= @tipo
	AND	(a.cacodigo		= c.clrut      
	AND	a.cacodcli		= c.clcodigo ) 
	AND	a.camdausd		*= f.mncodmon   
	AND	(a.cacodmon1		= g.mncodmon   
	AND	a.cacodmon2		= h.mncodmon ) 
	AND	a.cafecha		= @dfecproc  
	AND	(cacartera_normativa	= @Id_CartNorm		OR @Id_CartNorm		= '')
	AND	(caSubCartera_Normativa	= @Id_SubCartNorm	OR @Id_SubCartNorm	= '')
	AND	(calibro		= @id_libro		OR @id_libro		= '')*/

	--RQ 7619
	FROM MFCA a LEFT OUTER JOIN  VIEW_MONEDA  f ON  a.camdausd = f.mncodmon  ,
		 VIEW_CLIENTE c,
		 VIEW_MONEDA  g,
		 VIEW_MONEDA  h
	WHERE	a.cacodpos1		= @tipo
	AND		(a.cacodigo		= c.clrut      
	AND		a.cacodcli		= c.clcodigo ) 
	AND		(a.cacodmon1	= g.mncodmon   
	AND		a.cacodmon2		= h.mncodmon ) 
	AND		a.cafecha		= @dfecproc  
	AND		(cacartera_normativa	= @Id_CartNorm		OR @Id_CartNorm		= '')
	AND		(caSubCartera_Normativa	= @Id_SubCartNorm	OR @Id_SubCartNorm	= '')
	AND	(calibro		= @id_libro		OR @id_libro		= '')

 END
 ELSE BEGIN

  SELECT 'Tipo de Operacion'= '',
   'Numero Operacion' = 0, 
   'Fecha Termino'    = '',
   'Dias'             = 0,
   'Monto M/X'        = 0,  
   'Calce'            = '',             
   'Precio'           = 0,
   'Nombre Cliente'   = '',
   'Modalidad'        = '',
   'Monto Final'      = 0,
   'Moneda'           = '', 
   'Paridad Spot'     = 0,
   'Paridad Futuro'   = 0,
   'Producto'         = @tipo  ,
   'Codigo Moneda1'   = 0,
   'Codigo MonedaCnv' = 0, 
   'Rut Cliente'      = 0,
   'DV'               = '',
   'Fecha Inicio'     = '',                             
   'M/X'              = '',
   'M/N cnv'          = '', 
   'T/C Final'        = 0,
   'Pago M/N'         = '',
   'Pago M/X'         = '',
   'Nombre Empresa'   = @cnomprop     ,             
   'Spread'           = 0,
   'Direccion'        = @cdirprop     ,
   'Fecha de Proceso' = @cfecproc     ,
   'Entidad'          = @cnomprop     ,
   'Hora'             = CONVERT(CHAR(08),GETDATE(),108),
   'Observado'        = @observado   ,
   'valor UF'         = @uf   ,
   'fecha_Observado'  = @fecha_observado  ,
   'fecha_UF'         = @fecha_uf   ,
   'cahora'	      = ''	,
   'cartnorm'	      = ''	,
   'subcart'	      = ''	,
   'Libro'	      = ''	,
   'Glosa_Libro'      = @Glosa_Libro
    END 

 SET NOCOUNT OFF
END


GO
