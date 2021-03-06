USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_BCA_COR]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SVC_BCA_COR]
                           ( @nRutcart   NUMERIC  (9,0) ,
                             @nNumdocu   NUMERIC (10,0) ,
                             @nCorrela   NUMERIC  (5,0) ,
                             @nNominal   NUMERIC (19,4) ,
			     @nNumoper   NUMERIC  (10,0))
AS
-- Autor		: MIRIAM MORENO
-- Objetivo		: BUSCA CORTES
-- Fecha de Creacion	: 12-12-2003
-- Modificaciones	:
-- Primera Modificacion	: 17-07-2003
-- Segunda Modificacion	: 17-07-2003
-- Antecedentes Generales : 

BEGIN

      set nocount on

      DECLARE @nCont      INTEGER        ,
              @nRegs      INTEGER        ,
              @nEstado    INTEGER        ,
              @nCantcortd NUMERIC (19,4) ,
              @nCantcortv NUMERIC (19,4) ,
              @nMontcort  NUMERIC (19,4) ,
              @nNomiaux   NUMERIC (19,4)


CREATE TABLE #list(
		id          INTEGER IDENTITY,
		cocantcortv NUMERIC (19,4)  ,
		cocantcortd NUMERIC (19,4)  ,
		comtocort   NUMERIC (19,4)  ,
		status      INTEGER
	)



	INSERT INTO #list ( cocantcortd, comtocort,cocantcortv,status )
	SELECT
		CVCANTCORT	,
		CVMTOCORT	,
		0		,
		0
	FROM
		MDCV
	WHERE
		CVRUTCART   =   @nRutcart
	AND	CVNUMDOCU   =   @nNumdocu
	AND	CVCORRELA   =   @nCorrela
	AND	CVCANTCORT  >   0
	AND	CVMTOCORT   <=  @nNominal
	AND     CVNUMOPER   =   @nNumoper
	ORDER BY 
		CVMTOCORT asc


	
	SELECT @nRegs = COUNT(*) FROM #list

	IF @nRegs = 0
	BEGIN
		set nocount off
		RETURN
	END


	SELECT @nNomiaux = @nNominal
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
                   SELECT @nCont = 0 --@nCont - 1
              END
           ELSE
               IF ( @nEstado = 0 )
                   BEGIN
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

               INSERT INTO #list ( cocantcortd, comtocort, cocantcortv, status )
                            SELECT CVCANTCORT, CVMTOCORT, 0          , 0
                  FROM MDCV
                            WHERE CVRUTCART    =  @nRutcart   AND
                                  CVNUMDOCU    =  @nNumdocu   AND
                                  CVCORRELA    =  @nCorrela   AND
		                  CVMTOCORT    >  @nNominal   AND
			  	  CVNUMOPER   =   @nNumoper

               SELECT comtocort, cocantcortd, cocantcortv
                      FROM #list
                      ORDER BY comtocort desc


      set nocount off
      DROP TABLE #list
      RETURN

END

GO
