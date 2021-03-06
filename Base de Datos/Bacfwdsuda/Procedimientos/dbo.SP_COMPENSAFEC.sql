USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_COMPENSAFEC]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_COMPENSAFEC] 
    (
     @dfecdesde  CHAR (8),
     @dfechasta  CHAR (8)
     
    )
AS
BEGIN
   SET NOCOUNT ON
     DECLARE @nnomprop CHAR(50)
     DECLARE @ndirprop CHAR(50)
     DECLARE @nfecproc DATETIME    
    
   SELECT
   @nnomprop = (Select rcnombre from VIEW_ENTIDAD),
          @ndirprop = acdirprop                          ,
          @nfecproc = acfecproc     
   FROM   MFAC
 
 SELECT 'Tipo Operacion'         = a.catipoper                         ,
  'Numero Operacion'       = a.canumoper                         ,
  'Nombre Cliente'         = b.clnombre                          ,
  'Fecha Inicio'           = CONVERT(CHAR(10), a.cafecha, 103)   ,
  'Fecha Vencimiento'      = CONVERT(CHAR(10), a.cafecvcto, 103) ,
  'Moneda'                 = (select mnnemo from view_moneda where mncodmon = cacodmon1)     ,                     
  'Monto M/X'              = a.camtomon1                         ,
  'Monto Compensado'       = a.camtocomp         ,                         
  'Producto'   = f.descripcion    ,
  'Modalidad'              =  CASE  a.catipmoda WHEN 'C' THEN 'Compensación' ELSE 'E. Física' END   ,
  'Nombre Empresa'         = @nnomprop                           ,
  'Direccion Empresa'      = @ndirprop                           ,
  'Fecha desde'            = SUBSTRING(@dfecdesde,7,2)+ '/' + SUBSTRING(@dfecdesde,5,2)+ '/' + SUBSTRING(@dfecdesde,1,4)  ,
  'Fecha hasta'            = SUBSTRING(@dfechasta,7,2)+ '/' + SUBSTRING(@dfechasta,5,2)+ '/' + SUBSTRING(@dfechasta,1,4)  ,  
  'Fecha Proceso'          = CONVERT(CHAR(10), @nfecproc, 103)   ,   
  'Entidad'                = ( SELECT rcnombre
                                        from   VIEW_ENTIDAD
                                        where  rccodcar = a.cacodsuc1 )   ,
  'Hora'                   = CONVERT(CHAR(5), getdate(),108) 
 INTO #tmp1
 --RQ 7619
 FROM   MFCAH  a LEFT OUTER JOIN VIEW_MONEDA   c ON a.camdausd   = c.mncodmon,
  VIEW_CLIENTE  b,
  --VIEW_MONEDA   c,
  VIEW_MONEDA   d,
  VIEW_MONEDA   e,
  VIEW_PRODUCTO f      
 WHERE (b.clrut      = a.cacodigo   AND
  a.cacodcli   = b.clcodigo ) AND             
 -- a.camdausd   *= c.mncodmon   AND
  a.cacodmon2  = d.mncodmon   AND
  a.cacodmon1  = e.mncodmon   AND
  a.cacodpos1  = f.codigo_producto AND
  ( a.cafecvcto <= @dfechasta AND
  a.cafecvcto >= @dfecdesde )
  ORDER BY a.cafecvcto
   
 SELECT 'Tipo Operacion'         = a.catipoper                         ,
  'Numero Operacion'       = a.canumoper                         ,
  'Nombre Cliente'         = b.clnombre                          ,
  'Fecha Inicio'           = CONVERT(CHAR(10), a.cafecha, 103)   ,
  'Fecha Vencimiento'      = CONVERT(CHAR(10), a.cafecvcto, 103) ,
  'Moneda'                 = (select mnnemo from view_moneda where mncodmon = cacodmon1)     ,                     
  'Monto M/X'              = a.camtomon1                         ,
  'Monto Compensado'       = a.camtocomp         ,                         
  'Producto'     = f.descripcion + ' ' + g.rcnombre  ,
  'Modalidad'              =  CASE
      a.catipmoda WHEN 'C' THEN 'Compensación' ELSE 'E. Física' END   ,
  'Nombre Empresa'         = @nnomprop                           ,
  'Direccion Empresa'      = @ndirprop                           ,
  'Fecha desde'			   = SUBSTRING(@dfecdesde,7,2)+ '/' + SUBSTRING(@dfecdesde,5,2)+ '/' + SUBSTRING(@dfecdesde,1,4)  ,
  'Fecha hasta'			   = SUBSTRING(@dfechasta,7,2)+ '/' + SUBSTRING(@dfechasta,5,2)+ '/' + SUBSTRING(@dfechasta,1,4)  ,  
  'Fecha Proceso'          = CONVERT(CHAR(10), @nfecproc, 103)   ,   
  'Entidad'                = ( SELECT rcnombre
                                        from   VIEW_ENTIDAD
                                        where  rccodcar = a.cacodsuc1 )   ,
  'Hora'                   = CONVERT(CHAR(5), getdate(),108) 
 INTO #tmp2
 -- RQ 7619
 FROM    MFCA  a LEFT OUTER JOIN  view_moneda   c ON a.camdausd   = c.mncodmon,
  view_cliente  b  ,
  --view_moneda   c  ,
  view_moneda   d  ,
  view_moneda   e  ,
  view_producto f  ,
  view_tipo_cartera g
 WHERE (b.clrut      = a.cacodigo   AND
  a.cacodcli   = b.clcodigo ) AND             
  --a.camdausd   *= c.mncodmon   AND
  a.cacodmon2  = d.mncodmon   AND
  a.cacodmon1  = e.mncodmon   AND
  a.cacodpos1  = f.codigo_producto AND
  ( a.cacodpos1 = g.rccodpro  AND
    a.cacodcart = g.rcrut     ) AND
  ( a.cafecvcto <= @dfechasta AND
  a.cafecvcto >= @dfecdesde )
  ORDER BY a.cafecvcto
   IF NOT EXISTS( SELECT * FROM #tmp1
    UNION
    SELECT * FROM #tmp2 ) 
 BEGIN
     SELECT
			'Tipo Operacion'         = '',
           'Numero Operacion'       = 0,
			'Nombre Cliente'         = '',
			'Fecha Inicio'           = '',
			'Fecha Vencimiento'      = '',
			'Moneda'                 = '',                     
           'Monto M/X'              = 0,
           'Monto Compensado'       = 0,                         
			'Producto'     = '',
			'Modalidad'              =  '',
           'Nombre Empresa'         = @nnomprop                           ,
           'Direccion Empresa'      = @ndirprop                           ,
			'Fecha desde'     = SUBSTRING(@dfecdesde,7,2)+ '/' + SUBSTRING(@dfecdesde,5,2)+ '/' + SUBSTRING(@dfecdesde,1,4)  ,
			'Fecha hasta'     = SUBSTRING(@dfechasta,7,2)+ '/' + SUBSTRING(@dfechasta,5,2)+ '/' + SUBSTRING(@dfechasta,1,4)  ,  
           'Fecha Proceso'          = CONVERT(CHAR(10), @nfecproc, 103)   ,   
			'Entidad'                = '',
           'Hora'                   = CONVERT(CHAR(5), GETDATE(),108) 
    END
   ELSE
 BEGIN
  SELECT * FROM #tmp1
  UNION
  SELECT * FROM #tmp2
 END
    SET NOCOUNT OFF    
END 

GO
