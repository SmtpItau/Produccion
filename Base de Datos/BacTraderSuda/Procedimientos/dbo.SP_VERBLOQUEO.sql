USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VERBLOQUEO]    Script Date: 16-05-2022 12:48:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROC [dbo].[SP_VERBLOQUEO]
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
 IF EXISTS( SELECT * FROM MDBL WHERE blrutcart = @rutcart AND blnumdocu = @numdocu AND blcorrela = @correla )
  SELECT @retorno = 'SI'
 ELSE
  SELECT @retorno = 'NO'  
 SELECT @retorno
SET NOCOUNT OFF
END

GO
