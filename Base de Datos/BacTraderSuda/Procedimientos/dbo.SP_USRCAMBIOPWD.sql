USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_USRCAMBIOPWD]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_USRCAMBIOPWD]
   ( @cUsuario CHAR (10) ,
    @cPassword CHAR (10) )
AS
BEGIN
 BEGIN TRANSACTION
 UPDATE BACUSER
 SET password = @cPassword
 WHERE usuario=@cUsuario
 IF @@ERROR<>0
 BEGIN
  ROLLBACK TRANSACTION
  RETURN
 END
 COMMIT TRANSACTION       
END

GO
