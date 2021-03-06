USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIA_FORMA_PV]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CAMBIA_FORMA_PV]
    (
    @nNumoper NUMERIC (9) ,
    @cTipoper CHAR (3) ,
    @nForpag NUMERIC (4)
    )
AS
BEGIN
 SET NOCOUNT ON
 IF @cTipoper='RC' OR @cTipoper='RV'
 BEGIN
  UPDATE MDMO 
  SET moforpagv = @nForpag
  WHERE monumoper=@nNumoper
 
  IF @@error<>0
  BEGIN
   ROLLBACK TRANSACTION
  END
 END
 IF @cTipoper='VC'
 BEGIN
  UPDATE MDRS
  SET rsforpagv = @nForpag
  WHERE rsnumoper=@nNumoper
  IF @@error<>0
  BEGIN
   ROLLBACK TRANSACTION
   SELECT 'NO','PROBLEMAS EN LA GRABACION'
   RETURN
  END
 END
 SET NOCOUNT OFF
 RETURN
END


GO
