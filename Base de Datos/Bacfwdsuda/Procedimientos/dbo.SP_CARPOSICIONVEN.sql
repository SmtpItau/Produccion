USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARPOSICIONVEN]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARPOSICIONVEN]
   (   @ncodpos     FLOAT
   ,   @ncodmda     FLOAT
   ,   @nrutcli     FLOAT
   ,   @nnumoper    FLOAT
   ,   @cFecvenc    CHAR(8)
   )
AS
BEGIN

   SET NOCOUNT ON

   /*=======================================================================*/
   DECLARE @dfecproc    DATETIME
   DECLARE @cnomprop    CHAR(40)
   DECLARE @cdirprop    CHAR(40)
   /*=======================================================================*/

   SELECT @dfecproc = acfecproc
      ,   @cnomprop = acnomprop
      ,   @cdirprop = acdirprop
    FROM  MFAC      with (nolock)

   CREATE TABLE #TMP_MFCA_TMP
   (	  canumoper NUMERIC(9)
	 ,catipoper CHAR(1)
	 ,cafecvcto DATETIME
	 ,camtomon1 FLOAT
	 ,cafecha   DATETIME	
	 ,caplazo   NUMERIC(9)
	 ,catipcam  FLOAT
	 ,camtomon2 FLOAT
	 ,cacodigo  INTEGER
	 ,cacodcli  INTEGER
	 ,cacodmon2 INTEGER
	 ,cacodmon1 INTEGER
	 ,cacodpos1 INTEGER
	 ,var_moneda2 NUMERIC(9)
   )

   INSERT INTO #TMP_MFCA_TMP
   SELECT canumoper 
	 ,catipoper 
	 ,cafecvcto 
	 ,camtomon1 
	 ,cafecha   
	 ,caplazo   
	 ,catipcam  
	 ,camtomon2 
	 ,cacodigo  
	 ,cacodcli  
	 ,cacodmon2 
	 ,cacodmon1 
	 ,cacodpos1 
	 ,var_moneda2
   FROM MFCA
   WHERE cafecvcto   = @cFecvenc 
   AND   var_moneda2 = 0
                                                 AND (cacodpos1   = @ncodpos  OR @ncodpos  = 0)   

   IF @ncodpos = 12 OR @ncodpos=0
   BEGIN
	DELETE #TMP_MFCA_TMP 
	  WHERE @ncodpos = 12

   INSERT INTO #TMP_MFCA_TMP
   SELECT canumoper 
	 ,catipoper 
	 ,cafecvcto 
	 ,camtomon1 
	 ,cafecha   
	 ,caplazo   
	 ,catipcam  
	 ,camtomon2 
	 ,cacodigo  
	 ,cacodcli  
	 ,cacodmon2 
	 ,cacodmon1 
	 ,cacodpos1 
	 ,var_moneda2
   FROM MFCA
   WHERE cafecvcto   = @cFecvenc 
   AND   var_moneda2 <> 0
   END

   IF EXISTS( SELECT 1 FROM #TMP_MFCA_TMP  WHERE      cafecvcto   = @cFecvenc
                                                 AND (cacodmon2   = @ncodmda  OR @ncodmda  = 0)
                                                 AND (cacodigo    = @nrutcli  OR @nrutcli  = 0)
                                                 AND (canumoper   = @nnumoper OR @nnumoper = 0) )
   BEGIN

      SELECT 'NroOperacion' = a.canumoper
         ,   'NomCliente'   = b.clnombre
         ,   'TipoOperacion'= a.catipoper
         ,   'FechaVcto'    = CONVERT(CHAR(10), a.cafecvcto, 103)
         ,   'MonedaConver' = c.mnnemo
         ,   'MontoOrigen'  = a.camtomon1
         ,   'Producto'     = case when var_moneda2 <> 0 then f.descripcion + ' (MX/CLP)' else f.descripcion end 
         ,   'FechaCompra'  = CONVERT(CHAR(10),a.cafecha, 103)
         ,   'FechaProceso' = CONVERT(CHAR(10),@dfecproc, 103)
         ,   'PlazoResidual'= DATEDIFF(DAY,@dfecproc,a.cafecvcto)
         ,   'Plazo'        = a.caplazo
         ,   'MonedaOrigen' = e.mnnemo
         ,   'Precio'       = a.catipcam
         ,   'MontoConver'  = a.camtomon2
         ,   'NombrePropie' = @cnomprop
         ,   'DireccPropie' = @cdirprop
         ,   'Hora Reporte' = CONVERT(CHAR(8),GETDATE(), 108)
		 ,   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
       FROM  #TMP_MFCA_TMP                         a with (nolock)
             INNER JOIN VIEW_CLIENTE               b with (nolock) ON a.cacodigo   = b.clrut AND a.cacodcli = b.clcodigo
             LEFT  JOIN VIEW_MONEDA                c with (nolock) ON c.mncodmon   = a.cacodmon2
             LEFT  JOIN VIEW_MONEDA                e with (nolock) ON e.mncodmon   = a.cacodmon1
         --> LEFT  JOIN VIEW_TABLA_GENERAL_DETALLE d with (nolock) ON d.tbcateg    = 250     AND d.tbcodigo1 = CONVERT(CHAR(2),a.cacodpos1)
             LEFT  JOIN BacParamSuda..PRODUCTO     f with (nolock) ON f.Id_Sistema = 'BFW'   AND codigo_producto = a.cacodpos1
      WHERE (a.cafecvcto   = @cFecvenc)
  --      AND (a.cacodpos1   = @ncodpos  OR @ncodpos  = 0)   
        AND (a.cacodmon2   = @ncodmda  OR @ncodmda  = 0)
        AND (a.cacodigo    = @nrutcli  OR @nrutcli  = 0)
        AND (a.canumoper   = @nnumoper OR @nnumoper = 0)
      ORDER BY a.canumoper

   END ELSE
   BEGIN

      SELECT 'NroOperacion' = 0
         ,   'NomCliente'   = ''
         ,   'TipoOperacion'= ''
         ,   'FechaVcto'    = ''
         ,   'MonedaConver' = ''
         ,   'MontoOrigen'  = 0
         ,   'Producto'     = ''
         ,   'FechaCompra'  = ''
         ,   'FechaProceso' = CONVERT(CHAR(10),@dfecproc, 103)
         ,   'PlazoResidual'= 0
         ,   'Plazo'        = 0
         ,   'MonedaOrigen' = ''
         ,   'Precio'       = 0
         ,   'MontoConver'  = 0
         ,   'NombrePropie' = @cnomprop
         ,   'DireccPropie' = @cdirprop
         ,   'Hora Reporte' = CONVERT(CHAR(8),GETDATE(),108)
		 ,   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)

   END

END


GO
