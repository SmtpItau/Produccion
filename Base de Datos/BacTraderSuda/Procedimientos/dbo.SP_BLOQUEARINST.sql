USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BLOQUEARINST]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_BLOQUEARINST]
                          (@rutcart NUMERIC(09,0),
                           @numdocu NUMERIC(10,0),
                           @correla NUMERIC(03,0),
                           @nominal NUMERIC(19,4),
                           @hwnd NUMERIC(10,0),
                           @usuario CHAR(20)       )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @retorno CHAR(2) 
 IF EXISTS( SELECT * FROM mdbl WHERE blrutcart = @rutcart AND blnumdocu = @numdocu AND blcorrela = @correla AND blusuario = @usuario) BEGIN
  SELECT @retorno = 'NO'
 
 END ELSE BEGIN
   IF NOT EXISTS(SELECT * FROM mdbl WHERE blrutcart = @rutcart AND blnumdocu = @numdocu AND blcorrela = @correla AND blusuario <> @usuario) BEGIN
   INSERT INTO tbtr_inm_blq
   SELECT  @rutcart,
    @numdocu,
    @correla,
    @hwnd,
    @usuario
   SELECT @retorno = 'SI'  
   END
 END
 SELECT @retorno 
 
        SET NOCOUNT OFF
END


GO
