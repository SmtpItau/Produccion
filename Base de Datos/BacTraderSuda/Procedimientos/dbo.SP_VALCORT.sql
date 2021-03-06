USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALCORT]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_VALCORT]
   (   @nRutcart   NUMERIC(9,0)
   ,   @nNumdocu   NUMERIC(10,0)
   ,   @nCorrela   NUMERIC(5,0)
   ,   @nNominal   NUMERIC(19,4)
   )
AS
BEGIN
set nocount on

   DECLARE @inCodigo   INTEGER
       SET @inCodigo   = ( SELECT cpcodigo FROM MDCP with(nolock) WHERE cpnumdocu = @nnumdocu AND cpcorrela = @ncorrela )

   IF @inCodigo = 9 OR @inCodigo = 11 OR @inCodigo = 13 OR @inCodigo = 14
   BEGIN

      SELECT comtocort   = 1.0 
           , cocantcortd = dinominal
           , cocantcortv = @nNominal
        FROM MDCP            with(nolock) 
             INNER JOIN MDDI with(nolock) ON dinumdocu = cpnumdocu and dicorrela = cpcorrela
       WHERE cpnumdocu = @nNumdocu AND cpcorrela = @nCorrela

      RETURN
   END


   DECLARE @nCont        INTEGER
   DECLARE @nRegs        INTEGER
   DECLARE @nEstado      INTEGER
   DECLARE @nCantcortd   NUMERIC(9,0)
   DECLARE @nCantcortv   NUMERIC(9,0)
   DECLARE @nMontcort    NUMERIC(19,4)
   DECLARE @nNomiaux     NUMERIC(19,4)

CREATE TABLE #list
   (   id             INTEGER identity
   ,   cocantcortv    NUMERIC(9,0)
   ,   cocantcortd    NUMERIC(9,0)
   ,   comtocort      NUMERIC(19,4)
   ,   status         INTEGER
      )

 INSERT INTO #list ( cocantcortd, comtocort,cocantcortv,status )
   SELECT cocantcortd 
   ,      comtocort 
   ,      0  
   ,      0
   FROM   MDCO 
   WHERE  corutcart   = @nRutcart
 AND conumdocu   =   @nNumdocu   
 AND cocorrela   =   @nCorrela   
 AND cocantcortd >   0           
 AND comtocort   <=  @nNominal
   ORDER BY comtocort DESC

   SET @nRegs = @@rowcount

      IF @nRegs = 0
                 RETURN

   SET @nNomiaux = @nNominal
   SET @nCont    = 1
   SET @nEstado  = 0

      WHILE ( @nCont > 0 )
      BEGIN
      SELECT @nCantcortd = cocantcortd
      ,      @nCantcortv = cocantcortv
      ,      @nMontcort  = comtocort
      ,      @nEstado    = status
      FROM   #list 
      WHERE  id          = @nCont

           IF (@nNomiaux<0 AND @nEstado=0) OR (@nCont>@nRegs)
              BEGIN
         SET @nCont = @nCont - 1
      END ELSE

               IF ( @nEstado = 0 )
                   BEGIN
                        WHILE ( @nCantcortd > 0 )
                        BEGIN
                             IF (@nNomiaux - (@nMontcort*@nCantcortd)) >= 0
                                 BEGIN
                                      SELECT @nNomiaux = @nNomiaux - (@nMontcort*@nCantcortd)
                                      UPDATE #list SET cocantcortv = @nCantcortd,status = 1 WHERE id = @nCont
                                      BREAK
            END ELSE
                                 BEGIN
                                      SELECT @nCantcortd = @nCantcortd - 1
                                 END
                        END

                        IF ( @nCantcortd = 0 )
                           UPDATE #list SET status = 2 WHERE id = @nCont

                        SELECT @nCont = @nCont + 1
                   END ELSE

                   IF (@nEstado = 1)
                       BEGIN
                            IF (@nCantcortv-1) = 0
                                BEGIN
                                     SELECT @nNomiaux = @nNomiaux + @nMontcort
                                     UPDATE #list SET cocantcortv = 0, status = 2 WHERE id = @nCont
            SET @nCont = @nCont + 1
         END ELSE
                                BEGIN
                                     SELECT @nNomiaux = @nNomiaux - @nMontcort
                                     UPDATE #list SET cocantcortv = (@nCantcortv-1) WHERE id = @nCont
                                     SELECT @nCont = @nCont + 1
                                END
      END ELSE
                       IF (@nEstado = 2)
                       BEGIN
                           SELECT @nCont = @nCont - 1
                       END
               IF (@nNomiaux=0)
                        BREAK
      END

      IF (@nNomiaux=0)
      BEGIN
         -- incorpar registros excluidos al comienzo de la rutina.-
         INSERT INTO #list ( cocantcortd, comtocort, cocantcortv, status )
         SELECT cocantcortd
         ,      comtocort
         ,      0
         ,      0
         FROM MDCO
         WHERE  corutcart = @nRutcart
         AND    conumdocu = @nNumdocu
         AND    cocorrela = @nCorrela
         AND    comtocort > @nNominal

               -- devolver los cortes ordenados por monto.-
               SELECT comtocort, cocantcortd, cocantcortv
                      FROM #list
                      ORDER BY comtocort
      END

      SET NOCOUNT OFF
      DROP TABLE #list
      RETURN
END

GO
