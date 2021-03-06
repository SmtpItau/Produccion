USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RTECNICA_BLOQUEA_INST]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_RTECNICA_BLOQUEA_INST]
                          (@rutcart NUMERIC(09,0),
                           @numdocu NUMERIC(10,0),
                           @correla NUMERIC(03,0),
                           @hwnd NUMERIC(10,0),
                           @usuario CHAR(20),
      @sqlcode INTEGER OUTPUT )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @retorno CHAR(2) 
 
 IF EXISTS( SELECT * FROM MDBL WHERE blrutcart = @rutcart AND blnumdocu = @numdocu AND blcorrela = @correla AND blusuario = @usuario) 
 BEGIN
  
  SET @sqlcode = 2
  RETURN @sqlcode 
 END
 IF NOT EXISTS( SELECT * FROM MDBL WHERE blrutcart = @rutcart AND blnumdocu = @numdocu AND blcorrela = @correla ) BEGIN
  
   INSERT INTO MDBL
  SELECT  @rutcart,
   @numdocu,
   @correla,
   @hwnd,
   @usuario
  
  SET @sqlcode = 0 
  RETURN @sqlcode 
 END
 
 SET @sqlcode = 1 
 RETURN @sqlcode 
 
        SET NOCOUNT OFF
END


GO
