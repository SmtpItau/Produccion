USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DESCALCEOPEPRODUCTO]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_DESCALCEOPEPRODUCTO]
AS
BEGIN
 SET NOCOUNT ON
   /*=======================================================================*/
   DECLARE   @nnumero       NUMERIC(10)
 DECLARE   @nnumoper      NUMERIC(10)
 DECLARE   @nparmon2cmp   NUMERIC (21,4)
 DECLARE   @nparmon2vta   NUMERIC (21,4)
 DECLARE   @ctipoper      CHAR(1)
 DECLARE   @ntipopercmp   CHAR(1)
 DECLARE   @ntipopervta   CHAR(1)  
 DECLARE   @ncodpos       CHAR(3)
 DECLARE   @ncodmda       CHAR(3)
 DECLARE   @ntotregist    INTEGER
 
 /*=======================================================================*/
  CREATE TABLE #tmpdescalces
         (
          tmpnumopercmp  NUMERIC(10)      NOT NULL,
          tmpnombrecmp   CHAR(60)         NOT NULL,
          tmptipopercmp  CHAR(1)          NOT NULL,
          tmpfecvcto     CHAR(10)         NOT NULL,
          tmpmonto       NUMERIC(21,4)    NOT NULL, 
          tmpglosa       CHAR(50)         NOT NULL,
          tmpparmon2cmp  NUMERIC(14,10)   NOT NULL,
          tmpsaldo       NUMERIC(21,4)    NOT NULL,
          tmpfechacmp    CHAR(10)         NOT NULL,
          tmpfecproc     CHAR(10)         NOT NULL,
          tmpnomprop     CHAR(50)         NOT NULL,
          tmpdirprop     CHAR(50)         NOT NULL,   
          tmpnumopervta  NUMERIC(10)      NOT NULL,
          tmpnombrevta   CHAR(60)         NOT NULL,
          tmptipopervta  CHAR(1)          NOT NULL,
          tmpparmon2vta  NUMERIC(14,10)   NOT NULL,
          tmpfechavta    CHAR(10)         NOT NULL,
          tmpmontovta    NUMERIC(21,4)    NOT NULL, 
          tmpsaldo2      NUMERIC(21,4)    NOT NULL,
          tmpglosavta    CHAR(50)         NOT NULL,
          tmpfecvctovta  CHAR(10)         NOT NULL,
          tmpcodigo      NUMERIC(2)       NOT NULL,
          tmpcodigo2     NUMERIC(2)       NOT NULL,
   tmpmonact      CHAR(03)   NOT NULL,
   tmpmonpas  CHAR(03)         NOT NULL,  
   tmpfecorden    CHAR(8)          NOT NULL,
   tmpValorizaCMP NUMERIC(21)   NOT NULL,
   tmpValorizaVTA NUMERIC(21)   NOT NULL
         ) 
 /*=======================================================================*/
 /*=======================================================================*/
 INSERT INTO 
 #tmpdescalces
        SELECT cac.canumoper         ,
  clc.clnombre         ,
  cac.catipoper         ,
  CONVERT(CHAR(10), cac.cafecvcto, 103)      ,
  cac.camtomon1 - cac.camtocalzado      ,
  b.tbglosa         ,
  CASE 
  WHEN cac.cacodpos1 = 1 
  THEN cac.catipcam 
  WHEN cac.cacodpos1 = 5 
  THEN 0
  ELSE cac.caprecal 
  END                ,
  cac.camtomon1                               ,
  CONVERT(CHAR(10), cac.cafecvcto, 103)       ,
  CONVERT(CHAR(10), c.acfecproc, 103)         ,
  UPPER(c.acnomprop)        ,
  c.acdirprop                                 ,
  0                                           ,
  ''                                          ,
  ''                                          ,
  0                                           ,
  ''                                          ,
  0                                           ,
  0                                           ,
  ''                                          ,
  ''                                          ,
  cac.cacodpos1                               ,
  0           ,
  e.mnnemo         ,
  ''          ,
   CONVERT(CHAR(8),cac.cafecvcto, 112)      ,
  (cac.cavalordia * (( cac.camtomon1 - cac.camtocalzado ) / cac.camtomon1 ) ) ,
  0
 FROM MFAC  c    ,
  MFCA  cac   ,
  VIEW_CLIENTE  clc  ,
  VIEW_TABLA_GENERAL_DETALLE  b ,
  VIEW_MONEDA  e
        WHERE (cac.catipoper = 'C'   OR
  cac.catipoper = 'O' )  AND
  cac.cafecvcto > c.acfecproc  AND 
  (cac.cacodigo  = clc.clrut  AND
  cac.cacodcli  = clc.clcodigo )  AND
  cac.cacodmon2  = e.mncodmon  AND
  (cac.cacodpos1 = 1                   OR
  cac.cacodpos1 = 4                    OR
  cac.cacodpos1 = 5                    OR
  cac.cacodpos1 = 6                    OR
  cac.cacodpos1 = 7)                   AND  
  ( b.tbcateg      = 213   AND
  CONVERT(NUMERIC(6),b.tbcodigo1)    = cac.cacodpos1)      AND
  cac.camtomon1 - cac.camtocalzado > 0
  /*=======================================================================*/ 
  /*=======================================================================*/ 
 INSERT  INTO #tmpdescalces
        SELECT 0                                           ,
  ''                                          ,
  ''                                          ,
  CONVERT(CHAR(10), cav.cafecvcto, 103)       ,
  0                                           ,
  ''                                          ,
  0                                           ,
  0                                           ,
  ''                                          ,
  CONVERT(CHAR(10), c.acfecproc, 103)         ,
  UPPER(c.acnomprop)        ,
  c.acdirprop                                 ,
  cav.canumoper                               ,
  clv.clnombre                                ,
  cav.catipoper                               ,
  CASE 
  WHEN cav.cacodpos1 = 1 
  THEN cav.catipcam 
  WHEN cav.cacodpos1 = 5 
  THEN 0
  ELSE cav.caprecal 
  END                ,
  CONVERT(CHAR(10), cav.cafecha, 103)         ,
  cav.camtomon1 - cav.camtocalzado            ,
  cav.camtomon1                               ,
  n.tbglosa                                   ,
  CONVERT(CHAR(10), cav.cafecvcto, 103)       ,
  0                                           ,
  cav.cacodpos1                               ,
  ''          ,
   CONVERT(CHAR(3),e.mnnemo)         ,
   CONVERT(CHAR(8),cav.cafecvcto, 112)      ,
  0          ,
  (cav.cavalordia * (( cav.camtomon1 - cav.camtocalzado ) / cav.camtomon1 ) ) 
        FROM MFAC  c    ,
  MFCA  cav   ,
  VIEW_CLIENTE  clv  ,
  VIEW_TABLA_GENERAL_DETALLE  n ,
  VIEW_MONEDA  e                      
        WHERE (cav.catipoper = 'V'   OR
  cav.catipoper = 'A'   )               AND
  cav.cafecvcto > c.acfecproc  AND 
  (cav.cacodigo  = clv.clrut            AND
  cav.cacodcli  = clv.clcodigo    )    AND
  cav.cacodmon2 = e.mncodmon            AND
  (cav.cacodpos1 = 1                    OR
  cav.cacodpos1 = 4                     OR
  cav.cacodpos1 = 5                     OR
  cav.cacodpos1 = 6                     OR
  cav.cacodpos1 = 7)                    AND  
  ( n.tbcateg  = 213                      AND 
    CONVERT(NUMERIC(6),n.tbcodigo1 ) = cav.cacodpos1 ) AND
  cav.camtomon1 - cav.camtocalzado > 0
  /*=============================================================================*/
   DELETE #tmpdescalces WHERE tmpmonto <= 0 AND  tmpmontovta <= 0 
  /*=============================================================================*/
 SELECT tmpnumopercmp       ,
               tmpnombrecmp        ,
               tmptipopercmp       ,
               tmpfecvcto          ,
               tmpmonto            ,              
               tmpglosa            ,
               tmpparmon2cmp       ,
               tmpsaldo            ,
               tmpfechacmp         ,
               tmpfecproc          ,
               tmpnomprop          ,
               tmpdirprop          ,          
               tmpnumopervta       ,
               tmpnombrevta        ,
               tmptipopervta       ,
               tmpparmon2vta       ,
               tmpfechavta         ,
               tmpmontovta         ,
               tmpsaldo2           ,
               tmpglosavta         ,
               tmpfecvctovta       ,
               tmpcodigo           ,
               tmpcodigo2          ,
        tmpmonact     ,
        tmpmonpas     , 
  tmpValorizaCMP      , 
  tmpValorizaVTA      ,
  'HORA'  = CONVERT(CHAR(08),GETDATE(),108)
        FROM  #tmpdescalces
        ORDER BY tmpfecorden    
    DROP TABLE #tmpdescalces
    RETURN 0
 SET NOCOUNT OFF
END

GO
