USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINARCLIENTE]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_ELIMINARCLIENTE]
    ( @RUT NUMERIC(9),
             @CODIGO NUMERIC(9) )
AS
BEGIN
SET NOCOUNT ON
    IF EXISTS(SELECT * FROM VIEW_CLIENTE WHERE clcodigo = @CODIGO AND clrut = @RUT)BEGIN
 BEGIN TRANSACTION
                DELETE VIEW_CLIENTE WHERE clcodigo = @CODIGO AND clrut = @RUT    
  IF @@ERROR <> 0
  BEGIN
           ROLLBACK TRANSACTION
                        SELECT  'MA'
                 RETURN
  END
 COMMIT TRANSACTION
           SELECT 'OK'
      END
      ELSE 
      BEGIN
           SELECT 'NO'
      END
SET NOCOUNT OFF
END

GO
