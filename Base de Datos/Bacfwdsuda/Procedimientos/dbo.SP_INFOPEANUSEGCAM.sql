USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INFOPEANUSEGCAM]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INFOPEANUSEGCAM] (
          @dfecha   char(8)
               )
AS
BEGIN
   SET NOCOUNT ON   
 IF EXISTS( SELECT * 
    
  /*  FROM  MFCA_LOG  a ,
    VIEW_CLIENTE  b ,
    VIEW_MONEDA  c ,
    VIEW_FORMA_DE_PAGO d ,
    VIEW_FORMA_DE_PAGO e ,
    MFAC   f ,  
    VIEW_MONEDA  g ,    
    VIEW_MONEDA  h ,
    VIEW_PRODUCTO  i
    WHERE a.cafecmod  =  @dfecha     AND
    a.caestado  =  'A'           AND
    (a.cacodigo  =  b.clrut     AND
    a.cacodcli  =  b.clcodigo )    AND          
    a.cacodmon1 *=  c.mncodmon    AND
    a.cafpagomn *= d.codigo   AND
    a.cafpagomx *= e.codigo  AND
    a.cacodmon1 =  g.mncodmon   AND
    a.cacodmon2 =  h.mncodmon   AND
    a.cacodpos1 =  i.codigo_producto */

	-- Rq 7619
    FROM  MFCA_LOG  a LEFT OUTER JOIN  VIEW_MONEDA  c        ON a.cacodmon1 =  c.mncodmon 
		      LEFT OUTER JOIN  VIEW_FORMA_DE_PAGO d  ON a.cafpagomn = d.codigo 
		      LEFT OUTER JOIN  VIEW_FORMA_DE_PAGO e  ON a.cafpagomx = e.codigo ,
    VIEW_CLIENTE  b ,
    MFAC   f ,  
    VIEW_MONEDA  g ,    
    VIEW_MONEDA  h ,
    VIEW_PRODUCTO  i
    WHERE a.cafecmod  =  @dfecha        AND
    a.caestado  =  'A'			AND
    (a.cacodigo  =  b.clrut		AND
    a.cacodcli  =  b.clcodigo )		AND          
    a.cacodmon1 =  g.mncodmon		AND
    a.cacodmon2 =  h.mncodmon		AND
    a.cacodpos1 =  i.codigo_producto
  )
  BEGIN
  
   SELECT  'Numoper'	= a.canumoper							,
    'Nombre'			= b.clnombre							,
    'TipOper'			= a.catipoper							,
    'Plazo'				= a.caplazo								,
    'FecVen'			= CONVERT(CHAR(10),a.cafecvcto,103)		,
    'Nemo'				= ISNULL ( c.mnnemo, ' ' )              ,
    'MtoMex'			= a.camtomon1							,
    'Precio'			= catipcam                              ,
    'Preciofinal'		= catipcam								,
    'MtoCnv'			= a.camtomon2							,      
    'Modal'				= a.catipmoda							,                
    'FPMN'				= ISNULL( d.glosa,'N/A' )				,
    'FPMX'				= ISNULL( e.glosa,'N/A' )				, 
    'Operador'			= a.caoperador							,
    'NomProp'			= (Select rcnombre from VIEW_ENTIDAD)   ,
    'FecPro'			= CONVERT(CHAR(10),f.acfecproc,103)		,
    'CodMon'			= g.mnnemo								,
    'CodCnv'			= h.mnnemo								,
    'Hora'				= a.cahora                              ,
    'Estado'			= ' '									,
    'Observacion'		= a.caobserv							,
    'Hora_reporte'		= CONVERT(CHAR(08),GETDATE(),108)       ,
    'Producto'			= i.descripcion							,
    'Fecha_Consulta'	= CONVERT(CHAR(10),CONVERT( DATETIME,@dfecha),103),
	'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
   
  /* FROM  MFCA_LOG  a ,
    VIEW_CLIENTE  b ,
    VIEW_MONEDA  c ,
    VIEW_FORMA_DE_PAGO d ,
    VIEW_FORMA_DE_PAGO e ,
    MFAC   f ,  
    VIEW_MONEDA  g ,    
    VIEW_MONEDA  h ,
    VIEW_PRODUCTO  i
   WHERE a.cafecmod  =  @dfecha     AND
    a.caestado  =  'A'           AND
    (a.cacodigo  =  b.clrut     AND
    a.cacodcli  =  b.clcodigo )    AND          
    a.cacodmon1 *=  c.mncodmon    AND
    a.cafpagomn *= d.codigo   AND
    a.cafpagomx *= e.codigo  AND
    a.cacodmon1 =  g.mncodmon   AND
    a.cacodmon2 =  h.mncodmon   AND
    a.cacodpos1 =  i.codigo_producto */

   --Rq 7619
    FROM  MFCA_LOG  a  LEFT OUTER JOIN  VIEW_MONEDA  c ON  a.cacodmon1 =  c.mncodmon 
		       LEFT OUTER JOIN  VIEW_FORMA_DE_PAGO d ON  a.cafpagomn = d.codigo 
		       LEFT OUTER JOIN  VIEW_FORMA_DE_PAGO e ON  a.cafpagomx = e.codigo ,
    VIEW_CLIENTE  b ,
    MFAC   f ,  
    VIEW_MONEDA  g ,    
    VIEW_MONEDA  h ,
    VIEW_PRODUCTO  i
    WHERE a.cafecmod  =  @dfecha    AND
    a.caestado  =  'A'				AND
   (a.cacodigo  =  b.clrut			AND
    a.cacodcli  =  b.clcodigo )		AND          
    a.cacodmon1 =  g.mncodmon		AND
    a.cacodmon2 =  h.mncodmon		AND
    a.cacodpos1 =  i.codigo_producto


  END
 ELSE
  BEGIN
   SELECT  'Numoper'	= 0,
    'Nombre'			= '',
    'TipOper'			= '',
    'Plazo'			= 0,
    'FecVen'			= '',
    'Nemo'			= '',
    'MtoMex'			= 0,
    'Precio'			= 0,
    'Preciofinal'		= 0,
    'MtoCnv'			= 0,      
    'Modal'			= '',                
    'FPMN'			= '',
    'FPMX'			= '', 
    'Operador'			= '',
    'NomProp'			= (Select rcnombre from VIEW_ENTIDAD),
    'FecPro'			= CONVERT(CHAR(10),f.acfecproc,103)    ,
    'CodMon'			= '',
    'CodCnv'			= '',
    'Hora'			= '',
    'Estado'			= ' '        ,
    'Observacion'		= '',
    'Hora_reporte'		= CONVERT(CHAR(08),GETDATE(),108)                               ,
    'Producto'			= '',
    'Fecha_Consulta'	= CONVERT(CHAR(10),CONVERT( DATETIME,@dfecha),103),
	'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
   FROM mfac f
  END
   SET NOCOUNT OFF
END


GO
