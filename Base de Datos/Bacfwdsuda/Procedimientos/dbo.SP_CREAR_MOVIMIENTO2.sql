USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CREAR_MOVIMIENTO2]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
-- SP_CREAR_MOVIMIENTO2 '20101008',''
CREATE PROCEDURE [dbo].[SP_CREAR_MOVIMIENTO2]
       (
        @dfecmov      DATETIME   ,
        @cTipoReporte CHAR ( 30 )
       )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @CodPais INT
   SELECT  @CodPais = 6       -- segun mdtc.tbcateg = 180 (CHILE)
   SELECT 'canumope' = canumoper                                                      ,
          'catipcar' = tbglosa                                                        ,
          'catipope' = CASE catipoper WHEN 'C' THEN 'COMPRA    ' ELSE 'VENTA     ' END,
          'cafecini' = CONVERT ( CHAR ( 10 ), cafecha, 103 )                          ,
          'canomcli' = clnombre                                                       ,
          'catipcli' = cltipcli                                                       ,
          'calocext' = CASE clpais WHEN @CodPais THEN 'L' ELSE 'E' END
   INTO  #temporal
   FROM  MFCA, VIEW_CLIENTE, VIEW_TABLA_GENERAL_DETALLE, VIEW_GEN_FOLIOS
   WHERE cafecha            = @dfecmov  AND
         (clrut             = cacodigo  AND
         clcodigo           = cacodcli) AND
         cacodpos1          < 3         AND
         ( RTRIM ( codigo ) = '72BC'    OR
           RTRIM ( codigo ) = '72EM' )  AND
         tbcateg            = 50        AND
         convert(CHAR(2),cacodpos1) = tbcodigo1
   INSERT INTO #temporal ( canumope,
                           catipcar,
                           catipope,
                           cafecini,
                           canomcli,
                           catipcli,
                           calocext
                         )
   SELECT canumoper                                                        ,
          tbglosa                                                          ,
          (CASE catipoper WHEN 'C' THEN 'COMPRA    ' ELSE 'VENTA     ' END),
          CONVERT ( CHAR ( 10 ), cafecha, 103 )                            ,
          clnombre                                                         ,
          a.cltipcli                                                       ,
          CASE clpais WHEN @CodPais THEN 'L' ELSE 'E' END
   FROM   MFCAH, VIEW_CLIENTE a, VIEW_TABLA_GENERAL_DETALLE, VIEW_GEN_FOLIOS
   WHERE  cafecha            = @dfecmov   AND
          (clrut             = cacodigo   AND
          clcodigo           = cacodcli)  AND         
          cacodpos1          < 3          AND
--          cltipcli           = folio      AND
          (RTRIM ( codigo ) = '72BC'      OR
           RTRIM ( codigo ) = '72EM' )    AND
          tbcateg  = 50         AND
          convert(CHAR(2),cacodpos1) = tbcodigo1
   SELECT DISTINCT * FROM #Temporal
   SET NOCOUNT OFF
END

GO
