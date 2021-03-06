USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARTERADERIVADOS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- sp_carteraderivados '1111','1554','1552'
CREATE PROCEDURE [dbo].[SP_CARTERADERIVADOS]	(	@Cat_CartNorm		CHAR(06) = ''
						,	@Cat_SubCartNorm	CHAR(06) = ''
						,	@Cat_Libro		CHAR(06) = ''
						)

AS
BEGIN
  SET NOCOUNT ON
   /*=======================================================================*/
   /*=======================================================================*/
    DECLARE @CONT     INT 
    DECLARE @nnomprop CHAR(50)
    DECLARE @ndirprop CHAR(50)
    DECLARE @nfecproc DATETIME
    SELECT  @CONT = 0
    SELECT      @nnomprop = (Select rcnombre from VIEW_ENTIDAD),
                @ndirprop = acdirprop                          ,
                @nfecproc = acfecproc
           FROM MFAC   
   /*=======================================================================*/
   /*=======================================================================*/ 
    IF EXISTS(  SELECT 1
  FROM   MFCA  a,
   VIEW_CLIENTE  b,
   VIEW_MONEDA   c,
   VIEW_MONEDA   d
  WHERE  ( a.cacodpos1 = 1 OR
   a.cacodpos1   = 2 OR
   a.cacodpos1   = 3        OR
   a.cacodpos1 = 7)  AND
   (b.clrut = a.cacodigo    AND
   b.clcodigo = a.cacodcli )AND 
   a.cacodmon1 = c.mncodmon AND
   a.cacodmon2 = d.mncodmon AND
   a.cafecvcto > @nfecproc 
              )    
 BEGIN
     SELECT    'Tipo_Operacion'               = a.catipoper                         ,
               'Numero_Operacion'             = a.canumoper                         ,
               'Nombre_Cliente'               = b.clnombre                          ,
               'Fecha_Termino'                = CONVERT(CHAR(10), a.cafecvcto, 103) ,
               'Dias'                         = a.caplazo                           ,
        'Plazo '        = CASE WHEN a.caplazo <= 90 THEN 1
           ELSE 2 END      ,
        'Tipo_de_Mercado'       = CASE WHEN b.clpais = 6 THEN 'MERCADO LOCAL'
           ELSE 'MERCADO EXTERNO'    END    ,
               'Moneda1'                      = c.mnnemo                            ,
               'Moneda2'                      = d.mnnemo                            ,                                                            
               'moneda'                       = d.mnnemo          ,
        'MonedaUSD'       = (SELECT mnnemo FROM view_moneda WHERE mncodmon = a.camdausd),
               'Monto'                      = a.camtomon1                         ,
               'Final'                        = a.catipcam                          ,
               'Monto_Final_CNV'              = a.camtomon2                         ,        
               'Modalidad_Cumplimiento'       = a.catipmoda                         ,    
               'Nombre_Empresa'               = @nnomprop                           ,
               'Direccion_Empresa'            = @ndirprop                           ,
               'Fecha_Proceso'                = CONVERT(CHAR(10), @nfecproc, 103)   ,
        'Codigo_Producto'              = CASE a.cacodpos1 WHEN 7 THEN 1 ELSE a.cacodpos1 end    ,
        'Hora'        = CONVERT(CHAR(08),GETDATE(),108)    ,
        'sw'        = '0'       ,
        'Fecha Proceso'       = @nfecproc ,
		       'cartnorm'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_cartnorm     AND tbcodigo1 = cacartera_normativa),'No Especificado')	,
		       'subcart'	= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_subcartnorm  AND tbcodigo1 = casubcartera_normativa),'No Especificado')	,
		       'Libro'		= ISNULL((SELECT tbglosa FROM VIEW_TABLA_GENERAL_DETALLE WHERE tbcateg = @cat_libro        AND tbcodigo1 = calibro),'No Especificado') ,
			   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

    FROM   MFCA  a,
  VIEW_CLIENTE  b,
  VIEW_MONEDA   c,
  VIEW_MONEDA   d
    WHERE  ( a.cacodpos1 = 1 OR
    a.cacodpos1   = 2 OR
    a.cacodpos1   = 3        OR
    a.cacodpos1 = 7)  AND
    (b.clrut = a.cacodigo    AND
    b.clcodigo = a.cacodcli )AND 
    a.cacodmon1 = c.mncodmon AND
    a.cacodmon2 = d.mncodmon AND
    a.cafecvcto > @nfecproc 
    ORDER BY a.caplazo
 END
    ELSE
 BEGIN
     SELECT    'Tipo_Operacion'               = '',
               'Numero_Operacion'             = 0,
               'Nombre_Cliente'               = '',
               'Fecha_Termino'                = '',
               'Dias'                         = 0,
        'Plazo '        = 0,
               'Tipo_de_Mercado'			  = '',
               'Moneda1'                      = '',
               'Moneda2'                      = '',                                                            
               'moneda'                       = '',
               'MonedaUSD'					  = '',
               'Monto'                      = 0,
               'Final'                        = 0,
               'Monto_Final_CNV'              = 0,        
               'Modalidad_Cumplimiento'       = '',    
               'Nombre_Empresa'               = @nnomprop                           ,
               'Direccion_Empresa'            = @ndirprop                           ,
               'Fecha_Proceso'                = CONVERT(CHAR(10), @nfecproc, 103)   ,
        'Codigo_Producto'              = 0,
        'Hora'        = CONVERT(CHAR(08),GETDATE(),108)    ,
        'sw'        = '0'       ,
        'Fecha Proceso'       = @nfecproc,
		       'cartnorm'					  = '',
		       'subcart'					  = '',
		       'Libro'						  = '',
			   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

 END 
SET NOCOUNT OFF
END




GO
