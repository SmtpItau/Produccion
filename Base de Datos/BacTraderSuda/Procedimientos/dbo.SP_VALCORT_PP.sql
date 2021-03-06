USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALCORT_PP]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALCORT_PP]
                           ( @nRutcart   NUMERIC  (9,0) ,
                             @nNumdocu   NUMERIC (10,0) ,
                             @nCorrela   NUMERIC  (5,0) ,
                             @nNominal   NUMERIC (19,4) )
AS
BEGIN
set nocount on
      DECLARE @nCont      INTEGER        ,
              @nRegs      INTEGER        ,
              @nEstado    INTEGER        ,
              @nCantcortd NUMERIC ( 5,0) ,
              @nCantcortv NUMERIC ( 5,0) ,
              @nMontcort  NUMERIC (19,4) ,
              @nNomiaux   NUMERIC (19,4)
CREATE TABLE #list(
                   id          INTEGER IDENTITY,
                   cocantcortv NUMERIC ( 5,0)  ,
                   cocantcortd NUMERIC ( 5,0)  ,
                   comtocort   NUMERIC (19,4)  ,
                   status      INTEGER
      )
 INSERT INTO #list ( cocantcortd, comtocort,cocantcortv,status )
 SELECT 
  cocantcortd , 
  comtocort ,
  0  ,
  0
 FROM 
  MDCO 
 WHERE  
  corutcart   =   @nRutcart   
 AND conumdocu   =   @nNumdocu   
 AND cocorrela   =   @nCorrela   
 AND cocantcortd >   0           
 AND comtocort   <=  @nNominal
 ORDER BY 
  comtocort DESC
      SELECT @nRegs = @@ROWCOUNT
      IF @nRegs = 0
                 RETURN
      SELECT @nNomiaux = @nNominal
      select '1'
      SELECT @nCont    = 1
      SELECT @nEstado  = 0
      WHILE ( @nCont > 0 )
      BEGIN
           SELECT @nCantcortd = cocantcortd ,
                  @nCantcortv = cocantcortv ,
                  @nMontcort  = comtocort   ,
                  @nEstado    = status
                  FROM #list WHERE id = @nCont
           IF (@nNomiaux<0 AND @nEstado=0) OR (@nCont>@nRegs)
              BEGIN
                   SELECT @nCont = @nCont - 1
              END
           ELSE
               IF ( @nEstado = 0 )
                   BEGIN
                        select '2'
                        WHILE ( @nCantcortd > 0 )
                        BEGIN
                             IF (@nNomiaux - (@nMontcort*@nCantcortd)) >= 0
                                 BEGIN
                                      SELECT @nNomiaux = @nNomiaux - (@nMontcort*@nCantcortd)
                                      UPDATE #list SET cocantcortv = @nCantcortd,status = 1 WHERE id = @nCont
                                      BREAK
                                 END
                             ELSE
                                 BEGIN
                                      SELECT @nCantcortd = @nCantcortd - 1
                                 END
                        END
                        IF ( @nCantcortd = 0 )
                           UPDATE #list SET status = 2 WHERE id = @nCont
                        SELECT @nCont = @nCont + 1
                   END
               ELSE
                   IF (@nEstado = 1)
                       BEGIN
				select '3'
                            IF (@nCantcortv-1) = 0
                                BEGIN
                                     SELECT @nNomiaux = @nNomiaux + @nMontcort
                                     UPDATE #list SET cocantcortv = 0, status = 2 WHERE id = @nCont
                                     SELECT @nCont = @nCont + 1
                                END
                            ELSE
                                BEGIN
                                     SELECT @nNomiaux = @nNomiaux - @nMontcort
                                     UPDATE #list SET cocantcortv = (@nCantcortv-1) WHERE id = @nCont
                                     SELECT @nCont = @nCont + 1
                                END
                       END
                   ELSE
                       IF (@nEstado = 2)
                       BEGIN
                           SELECT @nCont = @nCont - 1
                       END
               IF (@nNomiaux=0)
                        BREAK
      END
      IF (@nNomiaux=0)
          BEGIN
            select '4'
               -- incorpar registros excluidos al comienzo de la rutina.-
               INSERT INTO #list ( cocantcortd, comtocort, cocantcortv, status )
                            SELECT cocantcortd, comtocort, 0          , 0
                            FROM MDCO
                            WHERE corutcart    =  @nRutcart   AND
                                  conumdocu    =  @nNumdocu   AND
                                  cocorrela    =  @nCorrela   AND
                                  comtocort    >  @nNominal
               -- devolver los cortes ordenados por monto.-
               SELECT comtocort, cocantcortd, cocantcortv
                      FROM #list
                      ORDER BY comtocort
         END
--      SELECT 'OK'
      set nocount off
      DROP TABLE #list
      RETURN
END

GO
