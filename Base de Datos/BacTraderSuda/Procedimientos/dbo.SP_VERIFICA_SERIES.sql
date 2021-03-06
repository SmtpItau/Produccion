USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERIFICA_SERIES]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
/****** Objeto:  procedimiento  almacenado dbo.Sp_Verifica_Series    fecha de la secuencia de comandos: 05/04/2001 13:13:57 ******/
CREATE PROCEDURE [dbo].[SP_VERIFICA_SERIES]
AS
BEGIN 
   CREATE TABLE #TEMP1
         (texto CHAR(20) NULL,
          instser char(10) NULL,
          serie char(10) NULL)
   DECLARE @nCont  NUMERIC (10)
   DECLARE @x   INTEGER
   DECLARE @cInstser  CHAR(10)
   DECLARE @cmascara  CHAR(10)
   DECLARE @cserie  CHAR(10)
   DECLARE @cSeriado    CHAR(1)
   DECLARE @mdtd CHAR(1)
   DECLARE @nCodigo INTEGER
   SELECT @x = 0
   SELECT @nCont = 0
   WHILE @X=0
   BEGIN
 SELECT @cInstser='*'
 SET ROWCOUNT 1
 SELECT  @cInstser = cpinstser  ,
  @nCont   = cpcontador  ,
  @cSeriado = cpseriado  ,
  @cMascara       = cpmascara
 FROM MDCP
 WHERE cpcontador > @nCont 
 ORDER BY cpcontador
 SET ROWCOUNT 0
 IF @cInstser = '*' BREAK
 SELECT @cSerie = ' '
 IF @cSeriado='S' 
           BEGIN
     SELECT @cSerie=semascara, @mdtd=inmdtd FROM VIEW_SERIE, VIEW_INSTRUMENTO WHERE semascara=@cMascara and secodigo = incodigo
  IF @cserie = ' ' 
                   BEGIN
   INSERT INTO #TEMP1
   SELECT 'CP NO EXISTE SERIE ' , @cInstser,@cSerie
     END
  ELSE BEGIN
     SELECT @cSerie = ' '
     IF @mdtd = 'S'
                      BEGIN
      SELECT @cSerie=TDmascara FROM VIEW_TABLA_DESARROLLO WHERE TDmascara=@cMascara and TDCUPON = 1
   IF @cserie = ' ' 
                       BEGIN
            INSERT INTO #TEMP1
           SELECT 'CP TD' , @cInstser,@cSerie
                           END
                      END
                   END
    END
   END
 PRINT '*****************************************************************************'
    PRINT 'TERMINO CP'
 PRINT '*****************************************************************************'
    PRINT 'INICIO CI'
 PRINT '*****************************************************************************'
   SELECT @x = 0
   SELECT @nCont = 0
   WHILE @X=0
   BEGIN
 SELECT @cInstser='*'
 SET ROWCOUNT 1
 SELECT  @cInstser = CIinstser  ,
  @nCont   = CIcontador  ,
  @cSeriado = CIseriado  ,
  @cMascara       = CImascara
 FROM MDCI
 WHERE CIcontador > @nCont 
 ORDER BY CIcontador
 SET ROWCOUNT 0
 IF @cInstser = '*' BREAK
 SELECT @cSerie = ' '
 IF @cSeriado='S' 
           BEGIN
     SELECT @cSerie=semascara, @mdtd=inmdtd FROM VIEW_SERIE, VIEW_INSTRUMENTO WHERE semascara=@cMascara and secodigo = incodigo
  IF @cserie = ' ' 
                   BEGIN
   INSERT INTO #TEMP1
   SELECT 'CI NO EXISTE SERIE ' , @cInstser,@cSerie
     END
  ELSE BEGIN
     SELECT @cSerie = ' '
     IF @mdtd = 'S'
                      BEGIN
      SELECT @cSerie=TDmascara FROM VIEW_TABLA_DESARROLLO WHERE tdmascara=@cMascara and TDCUPON = 1
   IF @cserie = ' ' 
                       BEGIN
            INSERT INTO #TEMP1
           SELECT 'CI TD' , @cInstser,@cSerie
                           END
                      END
                   END
    END
   END
 PRINT '*****************************************************************************'
    PRINT 'TERMINO CI'
 PRINT '*****************************************************************************'
 SELECT texto,instser FROM #TEMP1 GROUP by texto,instser
END
-- select * FROM mdTD
-- select * FROM mdSE where SEmascara='PRC-7D0994'
-- select * FROM mdTD where substring(TDmascara,1,3) ='STG'
-- SELECT * FROM MDCI 


GO
