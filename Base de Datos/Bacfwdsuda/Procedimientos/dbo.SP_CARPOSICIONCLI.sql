USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARPOSICIONCLI]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CARPOSICIONCLI]
       (
         @ncodpos     FLOAT
        ,@ncodmda     FLOAT -- numeric(3)  
        ,@nrutcli     FLOAT -- numeric(9) 
        ,@nnumoper    FLOAT -- numeric(10) 
        ,@nCodCli     FLOAT -- numeric(9)  
       )
AS
BEGIN 

   SET NOCOUNT ON

   /*=======================================================================*/
   DECLARE @dfecproc    DATETIME
   DECLARE @cnomprop    CHAR(40)
   DECLARE @cdirprop    CHAR(40)
   /*=======================================================================*/
   SELECT      @dfecproc = acfecproc  ,
               @cnomprop = acnomprop  ,
               @cdirprop = acdirprop   
          FROM MFAC

	CREATE TABLE #TMP_MFCA_TMP
	(	 canumoper NUMERIC(9)
		,catipoper CHAR(1)	
		,cafecvcto DATETIME
		,camtomon1 FLOAT
		,cafecha   DATETIME	
		,caplazo   DATETIME
		,catipcam  FLOAT
		,camtomon2 NUMERIC(21,4)
		,cacodigo  NUMERIC(9, 0)
		,cacodcli  NUMERIC(9, 0)
		,cacodmon2 NUMERIC(3, 0)
		,cacodmon1 NUMERIC(3, 0)
		,cacodpos1 NUMERIC(2, 0)
		,var_moneda2 NUMERIC(21, 0)
 	)
	
	INSERT INTO #TMP_MFCA_TMP
	SELECT   canumoper
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
	WHERE cafecvcto   > @dfecproc 
	AND   var_moneda2 = 0
	AND  (cacodpos1   = @ncodpos  OR @ncodpos  = 0)  


	IF @ncodpos = 12 OR @ncodpos=0
	BEGIN
		DELETE #TMP_MFCA_TMP WHERE cacodpos1 = 12

		INSERT INTO #TMP_MFCA_TMP
		SELECT   canumoper
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
   		WHERE cafecvcto   > @dfecproc 
   		AND   var_moneda2 <> 0
   	END

 IF EXISTS( SELECT  * FROM       MFCA a,
         VIEW_CLIENTE b,
         VIEW_MONEDA  c,
         BacParamSuda..Producto d,
             VIEW_MONEDA  e
            WHERE  (a.cacodigo = b.clrut         AND
            a.cacodcli   = b.clcodigo )   AND  
            a.cacodmon2  = c.mncodmon      AND
            a.cacodmon1  = e.mncodmon      AND
            d.Id_Sistema = 'BFW' 		 AND 
	    d.codigo_producto  = a.cacodpos1	 AND
           (a.cacodmon2  = @ncodmda         OR @ncodmda     = 0          )    AND
           (a.cacodigo   = @nrutcli         OR @nrutcli     = 0          )    AND
           (a.canumoper  = @nnumoper        OR @nnumoper    = 0          )    AND
            a.cafecvcto  > @dfecproc     AND
            a.cacodcli   = @ncodcli  ) 

  BEGIN

      SELECT           'NroOperacion' = a.canumoper                                ,
                       'NomCliente'   = b.clnombre                                 ,
                       'TipoOperacion'= a.catipoper                                ,
                       'FechaVcto'    = CONVERT( CHAR(10), a.cafecvcto, 103 )      ,
                       'MonedaConver' = c.mnnemo                                   ,
                       'MontoOrigen'  = a.camtomon1                                ,
                       'Producto'     = CASE WHEN var_moneda2 <> 0 THEN d.descripcion + ' (MX/CLP)' ELSE d.descripcion END,
                       'FechaCompra'  = CONVERT(CHAR(10),a.cafecha, 103 )          , 
                       'FechaProceso' = CONVERT(CHAR(10),@dfecproc, 103 )          ,
                       'Plazo'        = a.caplazo                                  ,
                       'Pzo Residual' = datediff( dd,   @dfecproc,a.cafecvcto ),
                       'MonedaOrigen' = e.mnnemo                                   ,
                       'Precio'       = a.catipcam                                 ,
                       'MontoConver'  = a.camtomon2                                , 
                       'NombrePropie' = @cnomprop                                  ,
                       'DireccPropie' = @cdirprop     ,
	               'horareporte1' = CONVERT(CHAR(8), GETDATE(),108),
				   'RazonSocial' = (SELECT RazonSocial FROM BacParamSuda..Contratos_ParametrosGenerales)
            FROM      #TMP_MFCA_TMP  	  	 a,
                      VIEW_CLIENTE b,
                      VIEW_MONEDA  c,
                      BacParamSuda..Producto	 d,
                      VIEW_MONEDA  e
     WHERE       (a.cacodigo            = b.clrut AND a.cacodcli = b.clcodigo )    AND  
                       a.cacodmon2            = c.mncodmon      AND
                       a.cacodmon1            = e.mncodmon      AND
 		       d.Id_Sistema 	  = 'BFW' 			  AND 
		       d.codigo_producto  = a.cacodpos1			  AND
                      (a.cacodmon2        = @ncodmda  OR @ncodmda = 0 )    AND
                      (a.cacodigo         = @nrutcli  OR @nrutcli = 0 )    AND
	              (a.canumoper        = @nnumoper OR @nnumoper = 0 )   AND 
		       a.cafecvcto        > @dfecproc AND a.cacodcli = @ncodcli
            ORDER BY a.canumoper
	END  

	ELSE
	
  BEGIN

      SELECT           'NroOperacion' = 0,
                       'NomCliente'   = '',
                       'TipoOperacion'= '',
                       'FechaVcto'    = '',
                       'MonedaConver' = '',
                       'MontoOrigen'  = 0,
                       'Producto'     = '',
                       'FechaCompra'  = '', 
                       'FechaProceso' = CONVERT(CHAR(10),@dfecproc, 103 )          ,
                       'Plazo'        = 0,
                       'Pzo Residual' = 0,
                       'MonedaOrigen' = '',
                       'Precio'       = 0,
                       'MontoConver'  = 0, 
                       'NombrePropie' = @cnomprop                                  ,
                       'DireccPropie' = @cdirprop    ,
					   'horareporte'  = CONVERT(CHAR(8),GETDATE(),108),
					   'RazonSocial' = ''
  END
   /*=======================================================================*/
   RETURN 0
END

GO
