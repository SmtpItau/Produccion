USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLOQUEARVP]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_BLOQUEARVP]
       (
        @rutcart    NUMERIC(09,0),
        @numdocu    NUMERIC(10,0),
        @correla    NUMERIC(03,0),
        @nominal    NUMERIC(19,4),
        @hwnd       NUMERIC(10,0),
        @usuario    CHAR(20)
       )
AS
BEGIN
   SET NOCOUNT ON
   DECLARE @retorno  CHAR(2) 
   DECLARE @retorno2 CHAR(2) 
   DECLARE @retuser  CHAR(12)
   DECLARE @rethwnd  CHAR(12)
   IF EXISTS( SELECT       * 
                     FROM  mdbl
                     WHERE blrutcart  = @rutcart AND 
                           blnumdocu  = @numdocu AND 
                           blcorrela  = @correla
            ) BEGIN
      SELECT       @retuser   = blusuario,
                   @rethwnd   = blhwnd
             FROM  mdbl
             WHERE blrutcart  = @rutcart AND 
                   blnumdocu  = @numdocu AND 
                   blcorrela  = @correla
     IF @retuser = @usuario AND @rethwnd = @hwnd AND @hwnd = 0 BEGIN
        SELECT @retorno = 'NO', @retorno2 = '1'
     END
     IF @retuser = @usuario  AND @rethwnd <> @hwnd AND @rethwnd = 0 BEGIN
--SELECT 1, @usuario, @rethwnd, @hwnd, @rutcart, @numdocu, @correla
        SELECT @retorno = 'SI', @rethwnd = @hwnd, @retorno2 = '2'
        UPDATE       mdbl
               SET   blhwnd = @hwnd
               WHERE blrutcart  = @rutcart AND 
                     blnumdocu  = @numdocu AND 
                     blcorrela  = @correla
     END ELSE IF @retuser <> @usuario BEGIN
         SELECT @retorno = 'NO', @retorno2 = '3'
      END
   END ELSE IF NOT EXISTS( 
                          SELECT       * 
                                 FROM  mdbl
                                 WHERE blrutcart  = @rutcart AND
                                       blnumdocu  = @numdocu AND
                                       blcorrela  = @correla
                         ) BEGIN
      INSERT INTO mdbl
             VALUES( @rutcart, @numdocu, @correla, @hwnd, @usuario )
      SELECT @retorno = 'SI', @retuser = @usuario, @rethwnd = @hwnd, @retorno2 = '4'
   END
   SELECT @retorno, @retuser, @rethwnd, @retorno2
 
        SET NOCOUNT OFF
END
/*
sp_bloquearVP 97018000, 47927, 1, 2000000000, 'ADMINISTRA'
select * from mdbl
sp_autoriza_ejecutar 'bacuser'
*/

GO
