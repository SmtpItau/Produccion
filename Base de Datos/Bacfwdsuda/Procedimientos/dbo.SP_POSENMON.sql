USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_POSENMON]    Script Date: 13-05-2022 10:30:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_POSENMON]
       (
        @nentidad    NUMERIC(03)
       )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @ncodmon        NUMERIC ( 03, 00 )
   DECLARE @ntotact        FLOAT
   DECLARE @ntotpas        FLOAT
   DECLARE @cnomentidad    CHAR ( 25 )
   DECLARE @cnomprop       CHAR ( 40 )
   DECLARE @cdirprop       CHAR ( 40 )
   DECLARE @cfecproc       CHAR ( 10 )
   DECLARE @nvaloruf       FLOAT
   SELECT      @cnomprop = acnomprop,
               @cdirprop = acdirprop,
               @cfecproc = CONVERT( CHAR(10), acfecproc, 103 ) 
   FROM MFAC
   SELECT      @nvaloruf = vmvalor
   FROM        VIEW_VALOR_MONEDA,
               MFCA
   WHERE  vmcodigo = 998     AND
          vmfecha  = cafecha
  
   IF @nentidad <> 999 BEGIN
      SELECT 'ncodmon' = cacodmon1 INTO #tempuno FROM MFCA WHERE cacodsuc1 = @nentidad
      INSERT INTO #tempuno ( ncodmon ) SELECT cacodmon2 FROM MFCA WHERE cacodsuc1 = @nentidad
      CREATE TABLE #tempdos (
                             entidad     CHAR ( 25 ),
                             moneda      CHAR ( 35 ), 
                             totalactivo FLOAT      ,
                             totalpasivo FLOAT      ,
                             neto        FLOAT      ,
                             nomprop     CHAR ( 40 ),
                             dirprop     CHAR ( 40 ),
                             fechproc    CHAR ( 10 ),
                             valoruf     FLOAT      ,
                             codmon      NUMERIC ( 03, 00 )                                  
                             )
      DECLARE cur_prueba SCROLL CURSOR
      FOR SELECT DISTINCT ( ncodmon )
      FROM #tempuno
      OPEN cur_prueba
      FETCH FIRST FROM cur_prueba INTO @ncodmon
 
      WHILE (@@FETCH_STATUS = 0)
      BEGIN
      
         SELECT @cnomentidad = rcnombre
         FROM   VIEW_ENTIDAD
         WHERE  @nentidad    = rccodcar 
         SELECT @ntotact = 0
         SELECT @ntotpas = 0
         SELECT @ntotact = ISNULL ( SUM ( camtomon1 ), 0 ) + @ntotact
         FROM   MFCA
         WHERE  @ncodmon  = cacodmon1 AND
                catipoper = 'C'       AND
                cacodsuc1 = @nentidad
         SELECT @ntotpas = ISNULL ( SUM ( camtomon2 ), 0 ) + @ntotpas
         FROM   MFCA
         WHERE  @ncodmon  = cacodmon2 AND
                catipoper = 'C'       AND
                cacodsuc1 = @nentidad
         SELECT @ntotpas = ISNULL ( SUM ( camtomon1 ), 0 ) + @ntotpas
         FROM   MFCA
         WHERE  @ncodmon  = cacodmon1 AND
                catipoper = 'V'       AND
                cacodsuc1 = @nentidad
         SELECT @ntotact = ISNULL ( SUM ( camtomon2 ), 0 ) + @ntotact
         FROM   MFCA
         WHERE  @ncodmon  = cacodmon2 AND
                catipoper = 'V'       AND
                cacodsuc1 = @nentidad
         INSERT INTO #tempdos
         SELECT  @cnomentidad                     ,
                 mnglosa                          ,
                 ISNULL ( @ntotact, 0 )           ,
                 ISNULL ( @ntotpas, 0 )           ,
                 ISNULL ( @ntotact - @ntotpas, 0 ),
                 @cnomprop                        ,
                 @cdirprop                        ,
                 @cfecproc                        ,
                 @nvaloruf                        ,
                 @ncodmon
         FROM    VIEW_MONEDA
         WHERE   mncodmon = @ncodmon
         FETCH NEXT FROM cur_prueba INTO @ncodmon   
      END
      CLOSE cur_prueba
      DEALLOCATE cur_prueba
      SELECT * FROM #tempdos
   END ELSE IF @nentidad = 999 BEGIN
      SELECT 'ncodmon' = cacodmon1 INTO #temptres FROM MFCA
      INSERT INTO #temptres ( ncodmon ) SELECT cacodmon2 FROM MFCA
      CREATE TABLE #tempcuatro (
                                entidad     CHAR ( 25 ),
                                moneda      CHAR ( 35 ), 
                                totalactivo FLOAT      ,
                                totalpasivo FLOAT      ,
                                neto        FLOAT      ,
                                nomprop     CHAR ( 40 ),
                                dirprop     CHAR ( 40 ),
                                fechproc    CHAR ( 10 ),
                                valoruf     FLOAT      ,
                                codmon      NUMERIC ( 03, 00 ) 
                                )
      DECLARE cur_prueba SCROLL CURSOR
      FOR SELECT DISTINCT ( ncodmon )
      FROM #temptres
      OPEN cur_prueba
      FETCH FIRST FROM cur_prueba INTO @ncodmon
      WHILE (@@FETCH_STATUS = 0)
      BEGIN
         
         SELECT @ntotact = 0
         SELECT @ntotpas = 0
         SELECT @ntotact = ISNULL ( SUM ( camtomon1 ), 0 ) + @ntotact
         FROM   MFCA
         WHERE  @ncodmon  = cacodmon1 AND
                catipoper = 'C'
         SELECT @ntotpas = ISNULL ( SUM ( camtomon2 ), 0 ) + @ntotpas
         FROM   MFCA
         WHERE  @ncodmon  = cacodmon2 AND
                catipoper = 'C'
         SELECT @ntotpas = ISNULL ( SUM ( camtomon1 ), 0 ) + @ntotpas
         FROM   MFCA
         WHERE  @ncodmon  = cacodmon1 AND
                catipoper = 'V'
         SELECT @ntotact = ISNULL ( SUM ( camtomon2 ), 0 ) + @ntotact
         FROM   MFCA
         WHERE  @ncodmon  = cacodmon2 AND
                catipoper = 'V'
         INSERT INTO #tempcuatro
         SELECT 'TODAS LAS ENTIDADES'             ,
                 mnglosa                          ,
                 ISNULL ( @ntotact, 0 )           ,
                 ISNULL ( @ntotpas, 0 )           ,
                 ISNULL ( @ntotact - @ntotpas, 0 ),
                 @cnomprop                        ,
                 @cdirprop                        ,
                 @cfecproc                        ,
                 @nvaloruf                        ,
                 @ncodmon
         FROM    VIEW_MONEDA
         WHERE   mncodmon = @ncodmon
         FETCH NEXT FROM cur_prueba INTO @ncodmon   
      END
      CLOSE cur_prueba
      DEALLOCATE cur_prueba
      SELECT * FROM #tempcuatro
   END
   SET NOCOUNT OFF
END

GO
