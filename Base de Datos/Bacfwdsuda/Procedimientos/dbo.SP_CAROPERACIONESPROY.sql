USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAROPERACIONESPROY]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CAROPERACIONESPROY]  
   (   @cFecproy   CHAR(10)  
   ,   @P2    NUMERIC(2)  
   )  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   DECLARE @dfecproc    DATETIME  
   DECLARE @cnomprop    CHAR(40)  
   DECLARE @cdirprop    CHAR(40)  
  
   SELECT  @dfecproc = acfecproc  
        ,  @cnomprop = acnomprop  
        ,  @cdirprop = acdirprop  
   FROM    MFAC      with (nolock)  
  
 CREATE TABLE #TMP_MFCA_TMP  
 (      canumoper NUMERIC(9)  
    ,catipoper CHAR(1)  
    ,cafecvcto DATETIME  
    ,camtomon1 FLOAT  
    ,cafecha   DATETIME  
    ,catipcam  FLOAT  
    ,catipmoda CHAR(1)  
    ,camtomon2 FLOAT  
    ,cacodigo		INT
    ,cacodcli		INT
    ,cacodmon2		INT
    ,cacodmon1		INT
    ,cacodpos1		INT
    ,caplazo		INT
    ,var_moneda2 NUMERIC(9)  
 )  
   
 INSERT #TMP_MFCA_TMP  
    SELECT
	 canumoper  
    ,catipoper  
    ,cafecvcto  
    ,camtomon1  
    ,cafecha  
    ,catipcam  
    ,catipmoda  
    ,camtomon2  
    ,cacodigo  
    ,cacodcli  
    ,cacodmon2  
    ,cacodmon1  
    ,cacodpos1  
    ,caplazo  
    ,var_moneda2  
 FROM MFCA  
 WHERE (cafecvcto <= @cFecproy AND cafecvcto > @dfecproc)  
   AND   var_moneda2 = 0  
    AND  (cacodpos1   = @P2  OR @P2  = 0)    
  
  IF @P2 = 12 OR @P2 = 0  
    BEGIN  
  DELETE #TMP_MFCA_TMP   
     WHERE cacodpos1 = 12  
    
  INSERT INTO #TMP_MFCA_TMP  
    SELECT     
      canumoper  
     ,catipoper  
     ,cafecvcto  
     ,camtomon1  
     ,cafecha  
     ,catipcam  
     ,catipmoda  
     ,camtomon2  
     ,cacodigo  
     ,cacodcli  
     ,cacodmon2  
     ,cacodmon1  
     ,cacodpos1  
     ,caplazo  
     ,var_moneda2  
     FROM MFCA  
     WHERE (cafecvcto <= @cFecproy AND cafecvcto > @dfecproc)  
     AND   var_moneda2 <> 0  
 END  
  
  
 SELECT 'NroOperacion' = a.canumoper  
 ,   'NomCliente'   = b.clnombre  
 ,   'TipoOperacion'= a.catipoper  
 ,   'FechaVcto'    = CONVERT(CHAR(10), a.cafecvcto, 103)  
 ,   'MonedaConver' = c.mnnemo  
 ,   'MontoOrigen'  = a.camtomon1  
   ,   'Producto'     = CASE WHEN a.var_moneda2 <> 0 THEN d.descripcion + ' (MX/CLP)' ELSE d.descripcion END  
 ,   'FechaCompra'  = CONVERT(CHAR(10), a.cafecha, 103)  
 ,   'FechaProceso' = CONVERT(CHAR(10), @dfecproc, 103)  
 ,   'Plazo'        = a.caplazo  
 ,   'Plazo Residual' = datediff(dd,@dfecproc, a.cafecvcto)  
 ,   'MonedaOrigen' = e.mnnemo  
 ,   'Hora'         = CONVERT(CHAR(8), GETDATE(), 108)  
 ,   'Precio'       = a.catipcam  
 ,   'Modalidad'    = CASE WHEN a.catipmoda = 'C' THEN 'Compensación' ELSE 'Entrega Física' END  
 ,   'MontoConver'  = a.camtomon2  
 ,   'NombrePropie' = @cnomprop  
 ,   'DireccPropie' = @cdirprop  
 ,   'Fecha'        = SUBSTRING(@cFecproy ,7,2) + '/' + SUBSTRING(@cFecproy ,5,2) + '/' + SUBSTRING( @cFecproy , 1 , 4 )   
 ,   'DateOrder'    = a.cafecvcto,
 'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
  INTO #VENCIMIENTOS  
  FROM  #TMP_MFCA_TMP         a with (nolock)  
              INNER JOIN VIEW_CLIENTE b with (nolock) ON b.clrut           = a.cacodigo AND b.clcodigo = a.cacodcli  
              LEFT  JOIN VIEW_MONEDA c with (nolock) ON c.mncodmon        = a.cacodmon2  
              LEFT  JOIN VIEW_MONEDA e with (nolock) ON e.mncodmon        = a.cacodmon1  
              INNER JOIN VIEW_PRODUCTO d with (nolock) ON d.codigo_producto = a.cacodpos1  
WHERE   a.cafecvcto BETWEEN  @dfecproc AND @cFecproy
--WHERE  (a.cafecvcto <= @cFecproy AND a.cafecvcto > @dfecproc)  
 AND a.cacodpos1 <> 13  
  
IF @P2 = 0 OR @P2 = 13 
   BEGIN  
   
  INSERT #VENCIMIENTOS  
  SELECT 'NroOperacion' = a.canumoper  
  ,   'NomCliente'   = b.clnombre  
  ,   'TipoOperacion'= a.catipoper  
  ,   'FechaVcto'    = CONVERT(CHAR(10), f.Ctf_Fecha_Vencimiento, 103)  
  ,   'MonedaConver' = c.mnnemo  
  ,   'MontoOrigen'  = f.Ctf_Monto_Principal  
  ,   'Producto'     = d.descripcion  
  ,   'FechaCompra'  = CONVERT(CHAR(10), a.cafecha, 103)  
  ,   'FechaProceso' = CONVERT(CHAR(10), @dfecproc, 103)  
  ,   'Plazo'        = f.Ctf_Plazo  
  ,   'Plazo Residual' = datediff(dd,@dfecproc, f.Ctf_Fecha_Vencimiento)  
  ,   'MonedaOrigen' = e.mnnemo  
  ,   'Hora'         = CONVERT(CHAR(8), GETDATE(), 108)  
  ,   'Precio'       = a.catipcam  
  ,   'Modalidad'    = CASE WHEN a.catipmoda = 'C' THEN 'Compensación' ELSE 'Entrega Física' END  
  ,   'MontoConver'  = f.Ctf_Monto_Secundario  
  ,   'NombrePropie' = @cnomprop  
  ,   'DireccPropie' = @cdirprop  
  ,   'Fecha'        = SUBSTRING(@cFecproy ,7,2) + '/' + SUBSTRING(@cFecproy ,5,2) + '/' + SUBSTRING( @cFecproy , 1 , 4 )   
  ,	  'DateOrder'	 = a.cafecvcto,
  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
  FROM #TMP_MFCA_TMP  a with (nolock)   
                          INNER JOIN VIEW_CLIENTE  b with (nolock) ON b.clrut           = a.cacodigo AND b.clcodigo = a.cacodcli  
        LEFT  JOIN VIEW_MONEDA  c with (nolock) ON c.mncodmon        = a.cacodmon2  
        LEFT  JOIN VIEW_MONEDA  e with (nolock) ON e.mncodmon        = a.cacodmon1  
        INNER JOIN VIEW_PRODUCTO d with (nolock) ON d.codigo_producto = a.cacodpos1  
  , TBL_CARTERA_FLUJOS f  
  WHERE A.canumoper = f.Ctf_Numero_OPeracion   
  AND   f.Ctf_Fecha_Vencimiento	 BETWEEN @dfecproc AND @cFecproy
--AND  (f.Ctf_Fecha_Vencimiento <= @cFecproy AND f.Ctf_Fecha_Vencimiento > @dfecproc)  
  AND a.cacodpos1  = 13  

 END  
   
  
 IF (SELECT COUNT(1) FROM #VENCIMIENTOS) = 0 BEGIN  
  SELECT 'NroOperacion' = 0  
  ,   'NomCliente'   = ''  
  ,   'TipoOperacion'= ''  
  ,   'FechaVcto'    = ''  
  ,   'MonedaConver' = ''  
  ,   'MontoOrigen'  = 0  
  ,   'Producto'     = ''  
  ,   'FechaCompra'  = ''  
  ,   'FechaProceso' = CONVERT(CHAR(10), @dfecproc, 103)  
  ,   'Plazo'        = 0  
  ,   'Plazo Residual' = 0  
  ,   'MonedaOrigen' = ''  
  ,   'Hora'         = CONVERT(CHAR(8), GETDATE(), 108)  
  ,   'Precio'       = 0  
  ,   'Modalidad'    = ''  
  ,   'MontoConver'  = 0  
  ,   'NombrePropie' = @cnomprop  
  ,   'DireccPropie' = ''  
  ,   'Fecha'        = SUBSTRING(@cFecproy ,7,2) + '/' + SUBSTRING(@cFecproy ,5,2) + '/' + SUBSTRING( @cFecproy , 1 , 4 )   
  ,   'DateOrder'    = @dfecproc,
  'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
 END ELSE 
 BEGIN  
  SELECT *   
	--FROM	#VENCIMIENTOS Order by NroOperacion
	  FROM	#VENCIMIENTOS 
	  ORDER BY DateOrder
 END  
    
   RETURN 0  
END

GO
