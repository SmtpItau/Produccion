USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLOQUEARVP]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BLOQUEARVP]
       (
        @rutcart    NUMERIC(09,0),
        @numdocu    NUMERIC(10,0),
        @correla    NUMERIC(03,0),
        @nominal    NUMERIC(19,4),
      --  @hwnd       NUMERIC(10,0),
        @usuario    CHAR(20)
       )
AS
BEGIN

   SET NOCOUNT ON

   DECLARE @retorno  CHAR(2) 
   DECLARE @retorno2 CHAR(2) 
   DECLARE @retuser  CHAR(12)
   DECLARE @rethwnd  CHAR(12)
   DECLARE @hwnd     NUMERIC(10,0)	

   SELECT @hwnd = 0


   IF EXISTS( SELECT       * 
                     FROM  mdbl
                     WHERE blrutcart  = @rutcart AND 
                           blnumdocu  = @numdocu AND 
                           blcorrela  = @correla
            ) BEGIN
	     SELECT       @retuser   = blusuario
        	         --  @rethwnd   = blhwnd
             FROM  mdbl
             WHERE blrutcart  = @rutcart AND 
                   blnumdocu  = @numdocu AND 
                   blcorrela  = @correla

      IF @retuser = @usuario BEGIN --AND @rethwnd = @hwnd AND @hwnd = 0 BEGIN
         SELECT @retorno = 'NO', @retorno2 = '1'

      END ELSE IF @retuser = @usuario BEGIN -- AND @rethwnd <> @hwnd AND @hwnd = 0 BEGIN
         SELECT @retorno = 'SI', @rethwnd = @hwnd, @retorno2 = '2'

         --UPDATE       mdbl
         --       SET   blhwnd = @hwnd
         --       WHERE blrutcart  = @rutcart AND 
         --             blnumdocu  = @numdocu AND 
         --             blcorrela  = @correla

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

   END   SELECT @retorno, @retuser, @rethwnd, @retorno2
 
        SET NOCOUNT OFF
END

/*
select * from cliente where clnombre  like 'BAN%'
SELECT * FROM MDBL
sp_bloquearinst 97018000, 48763, 1, 4000000000, 0, 'ADMINISTRA'
sp_bloquearinst 97018000, 47927, 1, 2000000000, 1252393834, 'ADMINISTRA'
sp_bloquearinst 97018000, 47927, 1, 0, 'ADMINISTRA'
sp_autoriza_ejecutar 'bacuser'
*/
GO
