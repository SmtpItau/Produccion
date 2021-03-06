USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES2]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIMITES2]
AS
BEGIN
CREATE TABLE #PASO2(
 CCORRELATIVO  INT   NOT NULL DEFAULT (0),
 CCLIENTE  CHAR (70) NOT NULL DEFAULT (' '),
 CTIPO  CHAR (1) NOT NULL DEFAULT (' '),
 CFECHAINI CHAR(10) NOT NULL DEFAULT (' '),
 CFECHAVEN CHAR(10) NOT NULL DEFAULT (' '),
 CMONTO1  FLOAT  NOT NULL DEFAULT (0),
 CMONTO2  FLOAT  NOT NULL DEFAULT (0),
 CMONTO3  FLOAT  NOT NULL DEFAULT (0),
 CMONTO4  FLOAT  NOT NULL DEFAULT (0),
 VCLIENTE  CHAR (70) NOT NULL DEFAULT (' '),
 VTIPO  CHAR (1) NOT NULL DEFAULT (' '),
 VFECHAINI CHAR(10) NOT NULL DEFAULT (' '),
 VFECHAVEN CHAR(10) NOT NULL DEFAULT (' '),
 VMONTO1  FLOAT  NOT NULL DEFAULT (0),
 VMONTO2  FLOAT  NOT NULL DEFAULT (0),
 VMONTO3  FLOAT  NOT NULL DEFAULT (0),
 VMONTO4  FLOAT  NOT NULL DEFAULT (0) 
)
DECLARE @TOTALC INT
DECLARE @TOTALV INT
DECLARE @CONTADOR INT
DECLARE @CCLIENTE  CHAR (70)
DECLARE @CTIPO  CHAR (1)
DECLARE @CFECHAINI CHAR(10)
DECLARE @CFECHAVEN CHAR(10)
DECLARE @CMONTO1 FLOAT
DECLARE @CMONTO2 FLOAT
DECLARE @CMONTO3 FLOAT
DECLARE @CMONTO4 FLOAT
DECLARE @VCLIENTE  CHAR (70)
DECLARE @VTIPO  CHAR (1)
DECLARE @VFECHAINI CHAR(10)
DECLARE @VFECHAVEN CHAR(10)
DECLARE @VMONTO1 FLOAT
DECLARE @VMONTO2 FLOAT
DECLARE @VMONTO3 FLOAT
DECLARE @VMONTO4 FLOAT
SELECT  @TOTALC = 0
SELECT  @TOTALV = 0
SELECT  @TOTALC = @TOTALC + 1 FROM MFCA WHERE CATIPOPER = 'C'
SELECT  @TOTALV = @TOTALV + 1 FROM MFCA WHERE CATIPOPER = 'V'
--SELECT  @TOTALC
--SELECT  @TOTALV
--select * from BacTrdTokyo..mdcl
--- VENTAS
SELECT
 'correlativo' =  identity(int),
 'cCliente' =  (select clnombre from BacTrdTokyo..mdcl where cacodigo = clrut ),
 'cTipoOper' =  catipoper, 
 'cFecIni' =  CONVERT(CHAR,cafecha,103),
 'cFecVcto' =  CONVERT(CHAR,cafecvcto,103),
 'cMtoUsd' =  camtomon1,
 'cTCSpot' =  catipcam,
 'cTCFrw' =  capremon1,
 'cLimi_Disp' =  lim_dispon_inter --insertar campo de tu nueva tabla 
INTO
 #TMPV
FROM  
 Mfca    , 
 BacTrdTokyo..ResumenLimites 
WHERE 
 CATIPOPER = 'V'
--SELECT * FROM #TMPV
--- COMPRAS
SELECT
 'correlativo' =  identity(int),
 'cCliente' =  (select clnombre from BacTrdTokyo..mdcl where cacodigo = clrut),
 'cTipoOper' =  catipoper, 
 'cFecIni' =  CONVERT(CHAR,cafecha,103),
 'cFecVcto' =  CONVERT(CHAR,cafecvcto,103),
 'cMtoUsd' =  camtomon1,
 'cTCSpot' =  catipcam,
 'cTCFrw' =  capremon1,
 'cLimi_Disp' =  lim_dispon_inter --insertar campo de tu nueva tabla 
INTO
 #TMPC
FROM  
 Mfca    , 
 BacTrdTokyo..ResumenLimites 
WHERE 
 CATIPOPER = 'C'
--SELECT * FROM #TMPC
-- SP_LIMITES
IF @TOTALC > @TOTALV
 BEGIN
  SELECT @CONTADOR = 1
  WHILE @CONTADOR <= @TOTALC 
   BEGIN
    SELECT   
      @CCLIENTE  = cCliente,
             @CTIPO     = cTipoOper ,
      @CFECHAINI = cFecIni ,
      @CFECHAVEN = cFecVcto ,
      @CMONTO1   = cMtoUsd ,
      @CMONTO2   = cTCSpot ,
      @CMONTO3   = cTCFrw ,
      @CMONTO4   = cLimi_Disp 
     FROM 
     #TMPC
     WHERE
     correlativo = @CONTADOR 
    
    INSERT INTO #PASO2(
      CCORRELATIVO ,
      CCLIENTE ,
             CTIPO   ,
      CFECHAINI ,
      CFECHAVEN ,
      CMONTO1  ,
      CMONTO2  ,
      CMONTO3  ,
      CMONTO4   
      )
    VALUES
      (
      @CONTADOR ,
      ISNULL(@CCLIENTE,'') ,
             ISNULL(@CTIPO,'C') ,
      ISNULL(@CFECHAINI,'') ,
      ISNULL(@CFECHAVEN,'') ,
      ISNULL(@CMONTO1,0) ,
      ISNULL(@CMONTO2,0) ,
      ISNULL(@CMONTO3,0) ,
      ISNULL(@CMONTO4,0) 
      )
   SELECT @CONTADOR =  @CONTADOR + 1
   END
   
   SELECT @CONTADOR = 1 
   WHILE @CONTADOR <= @TOTALV
    BEGIN 
    SELECT   
      @VCLIENTE  = cCliente,
             @VTIPO     = cTipoOper ,
      @VFECHAINI = cFecIni ,
      @VFECHAVEN = cFecVcto ,
      @VMONTO1   = cMtoUsd ,
      @VMONTO2   = cTCSpot ,
      @VMONTO3   = cTCFrw ,
      @VMONTO4   = cLimi_Disp 
     FROM 
     #TMPV
     WHERE
     correlativo = @CONTADOR 
   
    UPDATE #PASO2 SET VCLIENTE  = ISNULL(@VCLIENTE,'') ,
       VTIPO    = ISNULL(@VTIPO,'V')  ,
       VFECHAINI = ISNULL(@VFECHAINI,'') ,
       VFECHAVEN = ISNULL(@VFECHAVEN,'') ,
       VMONTO1   = ISNULL(@VMONTO1,0)  ,
       VMONTO2   = ISNULL(@VMONTO2,0)  ,
       VMONTO3   = ISNULL(@VMONTO3,0)  , 
       VMONTO4   = ISNULL(@VMONTO4,0)
    WHERE CCORRELATIVO = @CONTADOR 
    SELECT @CONTADOR = @CONTADOR + 1
   END
 END
IF @TOTALC < @TOTALV
 BEGIN
  SELECT @CONTADOR = 1
  WHILE @CONTADOR <= @TOTALV 
   BEGIN
    SELECT   
      @VCLIENTE  = cCliente,
             @VTIPO     = cTipoOper ,
      @VFECHAINI = cFecIni ,
      @VFECHAVEN = cFecVcto ,
      @VMONTO1   = cMtoUsd ,
      @VMONTO2   = cTCSpot ,
      @VMONTO3   = cTCFrw ,
      @VMONTO4   = cLimi_Disp 
     FROM 
     #TMPV
     WHERE
     correlativo = @CONTADOR 
    
    INSERT INTO #PASO2(
      CCORRELATIVO ,
      VCLIENTE ,
             VTIPO   ,
      VFECHAINI ,
      VFECHAVEN ,
      VMONTO1  ,
      VMONTO2  ,
      VMONTO3  ,
      VMONTO4   
      )
    VALUES
      (
      @CONTADOR ,
      ISNULL(@VCLIENTE,'') ,
             ISNULL(@VTIPO,'V') ,
      ISNULL(@VFECHAINI,'') ,
      ISNULL(@VFECHAVEN,'') ,
      ISNULL(@VMONTO1,0) ,
      ISNULL(@VMONTO2,0) ,
      ISNULL(@VMONTO3,0) ,
      ISNULL(@VMONTO4,0) 
      )
   SELECT @CONTADOR =  @CONTADOR + 1
   END
   
   SELECT @CONTADOR = 1 
   WHILE @CONTADOR <= @TOTALC
    BEGIN 
    SELECT   
      @CCLIENTE  = cCliente,
             @CTIPO     = cTipoOper ,
      @CFECHAINI = cFecIni ,
      @CFECHAVEN = cFecVcto ,
      @CMONTO1   = cMtoUsd ,
      @CMONTO2   = cTCSpot ,
      @CMONTO3   = cTCFrw ,
      @CMONTO4   = cLimi_Disp 
     FROM 
     #TMPV
     WHERE
     correlativo = @CONTADOR 
   
    UPDATE #PASO2 SET CCLIENTE  = ISNULL(@CCLIENTE,'') ,
       CTIPO    = ISNULL(@CTIPO,'C')  ,
       CFECHAINI = ISNULL(@CFECHAINI,'') ,
       CFECHAVEN = ISNULL(@CFECHAVEN,'') ,
       CMONTO1   = ISNULL(@CMONTO1,0)  ,
       CMONTO2   = ISNULL(@CMONTO2,0)  ,
       CMONTO3   = ISNULL(@CMONTO3,0)  , 
       CMONTO4   = ISNULL(@CMONTO4,0)
    WHERE CCORRELATIVO = @CONTADOR 
    SELECT @CONTADOR = @CONTADOR + 1
    
   END
 END
SELECT * FROM #PASO2
DROP TABLE #TMPV
DROP TABLE #TMPC
DROP TABLE #PASO2
END
-- SP_LIMITES
/*CCORRELATIVO,CCLIENTE,CTIPO,CFECHAINI,CFECHAVEN,CMONTO1,CMONTO2,CMONTO3,CMONTO4,VCLIENTE,
VTIPO,VFECHAINI,VFECHAVEN,VMONTO1,VMONTO2,VMONTO3,VMONTO4
*/
/*SELECT * FROM MFCA where catipoper = 'C'
SELECT * FROM MFCC
*/
GO
