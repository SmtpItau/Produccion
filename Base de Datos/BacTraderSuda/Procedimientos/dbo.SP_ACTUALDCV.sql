USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ACTUALDCV]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ACTUALDCV]
                           (    @nOpcion INTEGER  ,
    @nNumdocu NUMERIC (10,0) ,
    @nCorrela INTEGER  ,
    @cDcv  CHAR (01)) WITH RECOMPILE
AS
BEGIN
  SET NOCOUNT ON 
 IF @nOpcion=0
  SELECT cpnumdocu  ,
   cpcorrela  ,
   cpinstser  ,
   cptircomp  ,
   ISNULL(cpdcv,'N')
  FROM MDCP 
  ORDER BY cpinstser
 ELSE
 BEGIN
  UPDATE MDCP SET cpdcv=@cDcv WHERE cpnumdocu=@nNumdocu AND cpcorrela=@nCorrela
  IF @@ERROR<>0
  BEGIN 
   ROLLBACK TRANSACTION
                        SELECT 'NO', 'PROCESO DE ACTUALIZACI¢N DCV ABORTADO'
   SET NOCOUNT OFF
   RETURN
  END
 END
   SELECT 'OK'
   SET NOCOUNT OFF
END


GO
