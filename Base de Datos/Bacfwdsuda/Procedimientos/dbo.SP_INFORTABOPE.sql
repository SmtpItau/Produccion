USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFORTABOPE]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- sp_InforTabOpe '20050330' , '1111','1554','1552'
CREATE PROCEDURE [dbo].[SP_INFORTABOPE]	(	@dfecdesde			CHAR(08)
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
   SELECT      @cnomprop = (Select rcnombre from VIEW_ENTIDAD)  ,
               @cdirprop = acdirprop                            ,
               @dfecproc = CONVERT( CHAR(08), acfecproc, 112 )  ,
               @cfecproc = CONVERT( CHAR(10), acfecproc, 103 )
   FROM MFAC
   IF @dfecdesde = @dfecproc
   BEGIN
 IF EXISTS( SELECT 1 
     /*FROM   MFMO a ,
     VIEW_CLIENTE c ,
     VIEW_MONEDA  f ,
     VIEW_MONEDA  g ,
     VIEW_MONEDA  h ,
     VIEW_PRODUCTO i                           
     WHERE  (a.mocodigo  = c.clrut       AND
     a.mocodcli   = c.clcodigo )  AND
     a.momdausd   *= f.mncodmon   AND         
      a.mocodmon1  = g.mncodmon    AND
     a.mocodmon2  = h.mncodmon    AND
     a.mocodpos1  = i.codigo_producto */


	--RQ 7619
     FROM   MFMO a LEFT OUTER JOIN VIEW_MONEDA  f ON a.momdausd   = f.mncodmon ,
     VIEW_CLIENTE c ,
     VIEW_MONEDA  g ,
     VIEW_MONEDA  h ,
     VIEW_PRODUCTO i                           
     WHERE  (a.mocodigo  = c.clrut AND
     a.mocodcli   = c.clcodigo )   AND
     a.mocodmon1  = g.mncodmon     AND
     a.mocodmon2  = h.mncodmon     AND
     a.mocodpos1  = i.codigo_producto
   )
  BEGIN
 
        SELECT 'Numero Contrato'  = a.monumoper                             ,
               'Nombre Cliente'   = c.clnombre                              ,
               'CodigoProducto'   = i.descripcion                           ,
               'Codigo'           = i.codigo_producto                       ,
               'Tipo de Operacion'= a.motipoper                             ,
               'Fecha Inicio'     = CONVERT(CHAR(10),a.mofecha,103)         ,
               'Monto M/X'        = a.momtomon1                             ,
               'Dias'             = a.moplazo                               ,
               'Vencimiento'      = CONVERT(CHAR(10),a.mofecvcto,103)       ,
               'TipoMonedaM/X'    = g.mnnemo              ,
			   'TipoMonedaCnv'    = h.mnnemo                           ,           
               'Moneda'           = ISNULL(f.mnnemo,'N/D')                  ,
               'Precio'           = CASE a.mocodpos1 WHEN 2 THEN a.moparmon1 
           WHEN 3 THEN a.mopremon1 ELSE a.moprecal end ,
               'M/N cnv'          = h.mnnemo                                ,
               'T/C Final'        = a.motipcam                              ,
               'Monto Final CNV'  = a.momtomon2               ,
               'ModCumplimiento'  = a.motipmoda               ,
               'Pago M/N'         = ISNULL ((SELECT glosa2 FROM VIEW_FORMA_DE_PAGO WHERE codigo = a.mofpagomn ),'N/A'),
               'Pago M/X'         = ISNULL ((SELECT glosa2 FROM VIEW_FORMA_DE_PAGO WHERE codigo = a.mofpagomx ),'N/A'),
			   'Spread'           = a.mospread                              ,
               'Fecha de Proceso' = @cfecproc                               ,
               'Operador'         = a.mooperador                            ,
               'Hora_Reporte'     = CONVERT(CHAR(08),GETDATE(),108)         ,
			   'Hora_Operacion'   = a.mohora      ,
			   'Tasa Punta'       = a.mopreciopunta     ,
               'Modalidad'        = CASE a.motipmoda WHEN  'C' THEN
                                          'COMPENSACION'
                                    WHEN 'E' THEN
             'ENTREGA FISICA'
                                    ELSE 
                                          ' '
                                    END ,
		'entidad' = @cnomprop ,
	       'cartnorm'	  = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = mocartera_normativa),'No Especificado')	,
	       'subcart'	  = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = mosubcartera_normativa),'No Especificado')	,
	       'Libro'		  = ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = molibro),'No Especificado') ,
		   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
   /*FROM   MFMO         a ,
               VIEW_CLIENTE c ,
               VIEW_MONEDA  f ,
               VIEW_MONEDA  g ,
               VIEW_MONEDA  h ,
               VIEW_PRODUCTO i                             
   WHERE  (a.mocodigo  = c.clrut       AND
    a.mocodcli   = c.clcodigo )  AND
    a.momdausd   *= f.mncodmon   AND         
    a.mocodmon1  = g.mncodmon    AND
    a.mocodmon2  = h.mncodmon    AND
    a.mocodpos1  = i.codigo_producto */
   --RQ 7619
   FROM   MFMO         a LEFT OUTER JOIN  VIEW_MONEDA  f ON  a.momdausd = f.mncodmon  ,
          VIEW_CLIENTE c ,
          VIEW_MONEDA  g ,
          VIEW_MONEDA  h ,
          VIEW_PRODUCTO i                             
   WHERE  (a.mocodigo  = c.clrut AND
    a.mocodcli   = c.clcodigo )  AND
    a.mocodmon1  = g.mncodmon    AND
    a.mocodmon2  = h.mncodmon    AND
    a.mocodpos1  = i.codigo_producto
  END
 ELSE
  BEGIN
        SELECT 'Numero Contrato'  = 0,
               'Nombre Cliente'   = '',
               'CodigoProducto'   = '',
               'Codigo'           = 0,
               'Tipo de Operacion'= '',
               'Fecha Inicio'     = '',
               'Monto M/X'        = 0,
               'Dias'             = 0,
               'Vencimiento'      = '',
               'TipoMonedaM/X'    = '',
               'TipoMonedaCnv'    = '',           
               'Moneda'           = '',
               'Precio'           = 0,
               'M/N cnv'          = '',
               'T/C Final'        = 0,
               'Monto Final CNV'  = 0,
               'ModCumplimiento'  = '',
               'Pago M/N'         = '',
               'Pago M/X'         = '',
               'Spread'           = 0,
               'Fecha de Proceso' = @cfecproc                               ,
               'Operador'         = '',
               'Hora_Reporte'     = CONVERT(CHAR(08),GETDATE(),108)         ,
               'Hora_Operacion'   = '' ,
               'Tasa Punta' = 0,
               'Modalidad'        = '',
		'entidad' = @cnomprop ,
	       'cartnorm'	= '',
	       'subcart'	= '',
	       'Libro'		= '',
		   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 
  END
   END
   ELSE
   BEGIN
 IF EXISTS( SELECT 1
    /* FROM   mfmoh a,
     VIEW_CLIENTE c ,
     VIEW_MONEDA  f ,
     VIEW_MONEDA  g ,
     VIEW_MONEDA  h ,
     VIEW_PRODUCTO i                
     WHERE  (a.mocodigo  = c.clrut     AND
     a.mocodcli   = c.clcodigo ) AND
     a.momdausd   *= f.mncodmon   AND         
     a.mocodmon1  = g.mncodmon   AND
     a.mocodmon2  = h.mncodmon   AND
     a.mofecha    = @dfecdesde   AND
     a.mocodpos1  = i.codigo_producto */

	--RQ 7619 
     FROM   mfmoh a LEFT OUTER JOIN  VIEW_MONEDA  f ON a.momdausd = f.mncodmon ,
     VIEW_CLIENTE c ,
     VIEW_MONEDA  g ,
     VIEW_MONEDA  h ,
     VIEW_PRODUCTO i                
     WHERE  (a.mocodigo  = c.clrut		AND
     a.mocodcli   = c.clcodigo )		AND
     a.mocodmon1  = g.mncodmon			AND
     a.mocodmon2  = h.mncodmon			AND
     a.mofecha    = @dfecdesde			AND
     a.mocodpos1  = i.codigo_producto

  )
  BEGIN
     SELECT    'Numero Contrato'  = a.monumoper                             ,
               'Nombre Cliente'   = c.clnombre                              ,
               'CodigoProducto'   = i.descripcion                           ,
               'Codigo'           = i.codigo_producto                       ,
               'Tipo de Operacion'= a.motipoper                             ,
               'Fecha Inicio'     = CONVERT(CHAR(10),a.mofecha,103)         ,
               'Monto M/X'        = a.momtomon1                             ,
               'Dias'             = a.moplazo                 ,
               'Vencimiento'      = CONVERT(CHAR(10),a.mofecvcto,103)       ,
               'TipoMonedaM/X'    = g.mnnemo                                ,
			   'TipoMonedaCnv'    = h.mnnemo                           ,
               'Moneda'           = ISNULL(f.mnnemo,'N/D')              ,
               'Precio'           = CASE a.mocodpos1 when 2 then a.moparmon1 else a.moprecal end ,
               'M/N cnv'          = h.mnnemo                  ,
               'T/C Final'        = a.motipcam                              ,
               'Monto Final CNV'  = a.momtomon2               ,
               'ModCumplimiento'  = a.motipmoda               ,
               'Pago M/N'         = ISNULL ((SELECT glosa2 FROM VIEW_FORMA_DE_PAGO WHERE codigo = a.mofpagomn ),'N/A'),
               'Pago M/X'         = ISNULL ((SELECT glosa2 FROM VIEW_FORMA_DE_PAGO WHERE codigo = a.mofpagomx ),'N/A'),
               'Spread'           = a.mospread                ,
               'Fecha de Proceso' = @cfecproc                 ,
               'Operador'         = a.mooperador                ,
               'Hora_Reporte'     = CONVERT(CHAR(08),GETDATE(),108)         ,
               'Hora_Operacion'   = a.mohora      ,
               'Tasa Punta' = a.mopreciopunta     ,
               'Modalidad'        = CASE a.motipmoda WHEN  'C' THEN
                         'COMPENSACION'
                                    WHEN 'E' THEN
                                          'ENTREGA FISICA'
                                    ELSE 
                                          ' '
                                    END ,
		'entidad' = @cnomprop ,
	       'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = mocartera_normativa),'No Especificado')	,
	       'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = mosubcartera_normativa),'No Especificado')	,
	       'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = molibro),'No Especificado') ,
		   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
      /*FROM   mfmoh a,
      VIEW_CLIENTE c ,
      VIEW_MONEDA  f ,
      VIEW_MONEDA  g ,
      VIEW_MONEDA  h ,
      VIEW_PRODUCTO i                
     WHERE  (a.mocodigo  = c.clrut     AND
     a.mocodcli   = c.clcodigo ) AND
     a.momdausd   *= f.mncodmon   AND         
     a.mocodmon1  = g.mncodmon   AND
     a.mocodmon2  = h.mncodmon   AND
     a.mofecha    = @dfecdesde   AND
     a.mocodpos1  = i.codigo_producto */

	--RQ 7619
      FROM   mfmoh a LEFT OUTER JOIN  VIEW_MONEDA  f ON a.momdausd = f.mncodmon ,
      VIEW_CLIENTE c ,
      VIEW_MONEDA  g ,
      VIEW_MONEDA  h ,
      VIEW_PRODUCTO i                
     WHERE  (a.mocodigo  = c.clrut         AND
     a.mocodcli   = c.clcodigo )	   AND
     a.mocodmon1  = g.mncodmon		   AND
     a.mocodmon2  = h.mncodmon		   AND
     a.mofecha    = @dfecdesde		   AND
     a.mocodpos1  = i.codigo_producto
  END
 ELSE
  BEGIN
     SELECT    'Numero Contrato'  = 0,
               'Nombre Cliente'   = '',
               'CodigoProducto'   = '',
               'Codigo'           = 0,
               'Tipo de Operacion'= '',
               'Fecha Inicio'     = '',
               'Monto M/X'        = 0,
               'Dias'             = 0,
               'Vencimiento'      = '',
               'TipoMonedaM/X'    = '',
               'TipoMonedaCnv'    = '',
               'Moneda'           = '',
               'Precio'           = 0,
               'M/N cnv'          = '',
               'T/C Final'        = 0,
               'Monto Final CNV'  = 0,
               'ModCumplimiento'  = '',
               'Pago M/N'         = '',
               'Pago M/X'         = '',
               'Spread'           = 0,
               'Fecha de Proceso' = @cfecproc                 ,
               'Operador'         = '',
               'Hora_Reporte'     = CONVERT(CHAR(08),GETDATE(),108)         ,
               'Hora_Operacion'   = '',
               'Tasa Punta' = 0,
               'Modalidad'        = '',
		'entidad' = @cnomprop ,
	       'cartnorm'	= '',
	       'subcart'	= '',
	       'Libro'		= '',
		   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
  END
   END
SET NOCOUNT OFF
END





GO
