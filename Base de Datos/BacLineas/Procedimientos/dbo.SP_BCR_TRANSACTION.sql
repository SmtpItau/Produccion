USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BCR_TRANSACTION]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BCR_TRANSACTION]
                (
                 @sw CHAR(1)
                )
AS BEGIN
 
 IF @sw<>'B' AND @sw<>'C' AND @sw<>'R'
    BEGIN
        SELECT sw='NO HAY'
    END
 ELSE
    BEGIN
  IF @sw='B'
    BEGIN
      BEGIN TRANSACTION
      SELECT sw=@sw
    END
  IF @sw='C'
     BEGIN
       COMMIT TRANSACTION
       SELECT sw=@sw
     END
         
  IF @sw='R'
  BEGIN
   ROLLBACK TRANSACTION
   SELECT sw=@sw
  END
 END
END


GO
