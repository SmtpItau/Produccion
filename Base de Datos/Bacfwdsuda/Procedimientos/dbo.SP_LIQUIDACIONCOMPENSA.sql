USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIQUIDACIONCOMPENSA]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LIQUIDACIONCOMPENSA]
       (
        @nnumope  NUMERIC ( 7 )
--      @nrutapo1 NUMERIC ( 9 ),
--      @nrutapo2 NUMERIC ( 9 )
       )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @cdigver1   CHAR ( 01 )
   DECLARE @cdigver2   CHAR ( 01 )
   DECLARE @nnomapo1   CHAR ( 30 )
   DECLARE @nnomapo2   CHAR ( 30 )
   DECLARE @xNomprop   CHAR ( 50 )
--   -------------------<< Apoderado Nro.1
--   SELECT @cdigver1 = ISNULL ( ap.apdvapo , '' ),
--          @nnomapo1 = ISNULL ( ap.apnombre, '' )
--   FROM   VIEW_CLIENTE_APODERADO ap, MFAC 
--   WHERE  MFAC.acrutprop = ap.aprutcli AND ap.aprutapo = @nrutapo1
   -------------------<< Apoderado Nro.2
--   SELECT @cdigver2 = ISNULL ( ap.apdvapo , '' ),
--          @nnomapo2 = ISNULL ( ap.apnombre, '' )
--   FROM   VIEW_CLIENTE_APODERADO ap, MFAC 
--   WHERE  MFAC.acrutprop = ap.aprutcli AND ap.aprutapo = @nrutapo2
   -------------------<< Nombre Entidad
   SELECT @xNomprop = rcnombre from VIEW_ENTIDAD
  
   -------------------<< Desde Cartera Vigente (MFCA)
   SELECT 'BANCO'          = @xNomprop                                                            ,  -- 1
          'NUMOPE'         = @nnumope                                                                                     ,  -- 2
          'FECINI'         = CONVERT ( CHAR ( 10 ), MFCA.cafecha, 103 )                                                   ,  -- 3
          'RUTBANCO'       = CONVERT ( CHAR ( 9 ), MFAC.acrutprop ) + '-' + MFAC.acdigprop                                ,  -- 4
          'DIRBANCO'       = MFAC.acdirprop                                                                               ,  -- 5
          'TELBANCO'       = MFAC.actelefono                                                                              ,  -- 6
          'FAXBANCO'       = MFAC.acfax                                                                                   ,  -- 7
          'CLIENTE'    = cl.clnombre                                                                                ,  -- 8
          'RUTCLIENTE' = CONVERT ( CHAR ( 9 ), cl.clrut ) + '-' + cl.cldv                                         ,  -- 9
          'DIRCLIENTE' = cldirecc                                                                                     ,  -- 10
          'TELCLIENTE' = cl.clfono                                                                                  ,  -- 11
          'FAXCLIENTE' = cl.clfax                                                                                   ,  -- 12
          'TIPOPE'         = MFCA.catipoper                                                                               ,  -- 13
          'FECVEN'         = CONVERT ( CHAR ( 10 ), MFCA.cafecvcto, 103 )                                                 ,  -- 14
          'MODALIDAD'      = ISNULL ( ( CASE MFCA.catipmoda WHEN 'C' THEN 'COMPENSACION' ELSE 'ENTREGA FISICA' END ), '' ),  -- 15
   'CODMON'     = mdmn1.mnnemo                                                                                 ,  -- 16
          'MTOMEX'         = MFCA.camtomon1                                                                               ,  -- 17
          'MONESCMTOMEX'   = 0                                                                                            ,  -- 18
          'TIPCAR'         = MFCA.cacodpos1                                                                               ,  -- 19
          'PREFUT'         = MFCA.caparmon2                                                                               ,  -- 20
          'CODCNV'         = mdmn2.mnnemo                                                                                 ,  -- 21
          'MTOFIN'         = MFCA.camtomon2                                   ,  -- 22
          'MONESCMTOFIN'   = 0    ,  -- 23
          'TCREFERENCIA'   = (SELECT mdmn.mnglosa FROM MFCA, VIEW_MONEDA mdmn WHERE MFCA.camdausd = mdmn.mncodmon AND MFCA.canumoper = @nnumope ), -- 24
--        'NOMAPODERADO1'  = ISNULL ( @nnomapo1, '' )                                                                     ,  -- 25
--        'RUTAPODERADO1'  = ISNULL ( CONVERT ( CHAR ( 9 ), @nrutapo1 ) + '-' + @cdigver1, '' )                           ,  -- 26
--        'NOMAPODERADO2'  = ISNULL ( @nnomapo2, '' )                                                                     ,  -- 27
--        'RUTAPODERADO2'  = ISNULL ( CONVERT ( CHAR ( 9 ), @nrutapo2 ) + '-' + @cdigver2, '' )                           ,  -- 28
          'GLOSACODMON'    = mdmn1.mnglosa                                                                                ,  -- 29
          'GLOSACODCNV'    = mdmn2.mnglosa                                                                                ,  -- 30
   'REFUSD'         = (CASE mdmn1.mnrrda WHEN 'M' THEN 3 ELSE 1 END)                                               ,  -- 31
          'NUMSINACOFI'    = ISNULL(a.clnumsinacofi,'0000')                                                               ,  -- 32
          'NOMSINACOFI'    = ISNULL(a.clnomsinacofi,'')                                                                   ,  -- 33
          'NUMSINACNV'     = ISNULL(b.clnumsinacofi,'0000')                                                               ,  -- 34
          'NOMSINACNV'     = ISNULL(b.clnomsinacofi,'')                                                                      -- 35
   INTO #temporal
   

 /* FROM MFAC   , 
        MFCA   , 
        VIEW_CLIENTE cl ,
        VIEW_TBSINACOFI a ,
        VIEW_TBSINACOFI b ,
        VIEW_MONEDA  mdmn1 ,
        VIEW_MONEDA  mdmn2
   WHERE MFCA.canumoper = @nnumope      
     AND cl.clrut     = MFCA.cacodigo 
     AND cl.clcodigo  = MFCA.cacodcli
     AND a.clrut        =* cl.clrut
     AND a.clcodigo     =* cl.clcodigo 
     AND b.clrut        =* acrutprop
     AND MFCA.cacodmon1 = mdmn1.mncodmon 
     AND MFCA.cacodmon2 = mdmn2.mncodmon */
   --RQ 7619
   FROM MFCA  , 
        VIEW_TBSINACOFI a  RIGHT OUTER JOIN VIEW_CLIENTE cl  ON a.clrut =cl.clrut AND a.clcodigo = cl.clcodigo ,
		VIEW_TBSINACOFI b  RIGHT OUTER JOIN  MFAC  ON  b.clrut = acrutprop,
		VIEW_MONEDA  mdmn1 ,
		VIEW_MONEDA  mdmn2
   WHERE MFCA.canumoper = @nnumope      
	AND cl.clrut     = MFCA.cacodigo 
	AND cl.clcodigo  = MFCA.cacodcli
	AND MFCA.cacodmon1 = mdmn1.mncodmon 
     AND MFCA.cacodmon2 = mdmn2.mncodmon 





   -------------------<< Desde Cartera Historica (MFCAH)
   INSERT INTO #temporal ( BANCO         ,  -- 1
                           NUMOPE        ,  -- 2
                           FECINI        ,  -- 3
                           RUTBANCO      ,  -- 4
                           DIRBANCO      ,  -- 5
                           TELBANCO      ,  -- 6
                           FAXBANCO      ,  -- 7
                           CLIENTE   ,  -- 8
                           RUTCLIENTE,  -- 9
                           DIRCLIENTE,  -- 10
                           TELCLIENTE,  -- 11
                           FAXCLIENTE,  -- 12
                           TIPOPE        ,  -- 13
                           FECVEN        ,  -- 14
                           MODALIDAD     ,  -- 15
                           CODMON        ,  -- 16
                           MTOMEX        ,  -- 17
                           MONESCMTOMEX  ,  -- 18
                           TIPCAR        ,  -- 19
                           PREFUT        ,  -- 20
                           CODCNV        ,  -- 21
                           MTOFIN        ,  -- 22
                           MONESCMTOFIN  ,  -- 23
                           TCREFERENCIA  ,  -- 24
--                          NOMAPODERADO1 ,  -- 25
--                          RUTAPODERADO1 ,  -- 26
--                          NOMAPODERADO2 ,  -- 27
--                          RUTAPODERADO2 ,  -- 28
                           GLOSACODMON   ,  -- 29
                           GLOSACODCNV   ,  -- 30
                           REFUSD        ,  -- 31
                           NUMSINACOFI   ,  -- 32
                           NOMSINACOFI   ,  -- 33
                           NUMSINACNV    ,  -- 34
                           NOMSINACNV       -- 35
                         )
   SELECT @xNomprop                                                           ,  -- 1
          @nnumope                                                                                      ,  -- 2
          CONVERT ( CHAR ( 10 ), MFCAH.cafecha, 103 )                                                   ,  -- 3
          CONVERT ( CHAR ( 9 ), MFAC.acrutprop ) + '-' + MFAC.acdigprop                                 ,  -- 4
          MFAC.acdirprop                                                                                ,  -- 5
          MFAC.actelefono                                                                               ,  -- 6
          MFAC.acfax                                                                                    ,  -- 7
          cl.clnombre                                                                                 ,  -- 8
          CONVERT ( CHAR ( 9 ), cl.clrut ) + '-' + cl.cldv                                          ,  -- 9
          cl.cldirecc                                                                                 ,  -- 10
          cl.clfono                                                                                   ,  -- 11
          cl.clfax                                                                                    ,  -- 12
          MFCAH.catipoper                                                                               ,  -- 13
          CONVERT ( CHAR ( 10 ), MFCAH.cafecvcto, 103 )                                                 ,  -- 14
          ISNULL (( CASE MFCAH.catipmoda WHEN 'C' THEN 'Compensacion' ELSE 'Entrega Fisica' END ), '' ) ,  -- 15
   mdmn1.mnnemo                                                                                  ,  -- 16
          MFCAH.camtomon1                                                                               ,  -- 17
          ''                                                                                            ,  -- 18
          MFCAH.cacodpos1                                                                               ,  -- 19
          MFCAH.caparmon2                                                                               ,  -- 20
          mdmn2.mnnemo                                                                                  ,  -- 21
          MFCAH.camtomon2                                                                               ,  -- 22
          ''                                                                                            ,  -- 23
          (SELECT m.mnglosa FROM MFCAH,  VIEW_MONEDA m WHERE MFCAH.camdausd = m.mncodmon AND MFCAH.canumoper = @nnumope),  -- 24
--          ISNULL ( @nnomapo1, '' )                                                                      ,  -- 25
--          ISNULL ( CONVERT ( CHAR ( 9 ), @nrutapo1 ) + '-' + @cdigver1, '' )                            ,  -- 26
--          ISNULL ( @nnomapo2, '' )                                                                      ,  -- 27
--          ISNULL ( CONVERT ( CHAR ( 9 ), @nrutapo2 ) + '-' + @cdigver2, '' )                            ,  -- 28
   mdmn1.mnglosa                                                                                 ,  -- 29
          mdmn2.mnglosa                                                                                 ,  -- 30
          (CASE mdmn1.mnrrda WHEN 'M' THEN 3 ELSE 1 END)                                                ,  -- 31
          ISNULL(a.clnumsinacofi,'0000')                                                                ,  -- 32
          ISNULL(a.clnomsinacofi,'')                                                                    ,  -- 33
          ISNULL(b.clnumsinacofi,'0000')                                                                ,  -- 34
          ISNULL(b.clnomsinacofi,'')                                                 -- 35
   


  /* FROM   MFAC    , 
          MFCAH    ,
          VIEW_CLIENTE  cl ,
          VIEW_TBSINACOFI a ,
          VIEW_TBSINACOFI b ,
   VIEW_MONEDA mdmn1  ,          
   VIEW_MONEDA mdmn2          
   WHERE MFCAH.canumoper = @nnumope       
     AND cl.clrut      = MFCAH.cacodigo 
     AND cl.clcodigo   = MFCAH.cacodcli
     AND a.clrut         =* MFCAH.cacodigo 
     AND a.clcodigo      =* MFCAH.cacodcli
     AND b.clrut         =* acrutprop
     AND MFCAH.cacodmon1 = mdmn1.mncodmon 
     AND MFCAH.cacodmon2 = mdmn2.mncodmon */
   --RQ 7619
    FROM  VIEW_CLIENTE  cl ,
          VIEW_TBSINACOFI a RIGHT OUTER JOIN  MFCAH ON a.clrut = MFCAH.cacodigo AND a.clcodigo = MFCAH.cacodcli,
          VIEW_TBSINACOFI b RIGHT OUTER JOIN MFAC ON b.clrut = acrutprop,
          VIEW_MONEDA mdmn1  ,          
	  VIEW_MONEDA mdmn2          
    WHERE MFCAH.canumoper = @nnumope       
     AND cl.clrut      = MFCAH.cacodigo 
     AND cl.clcodigo   = MFCAH.cacodcli
     AND MFCAH.cacodmon1 = mdmn1.mncodmon 
     AND MFCAH.cacodmon2 = mdmn2.mncodmon 



   SELECT * FROM #Temporal
  SET NOCOUNT OFF
END

GO
