USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_GENERAUS]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_GENERAUS]
        ( @USUARIO Char(10),
   @NOMBRE Char(3) )
AS
BEGIN
 DECLARE  @TERMINAL  CHAR(6),
   @CONT   NUMERIC(2), 
   @TMP   CHAR(6),
   @TMP2   CHAR(6)
 SET NOCOUNT ON
 
 IF EXISTS (SELECT Usuario, Nombre FROM VIEW_CONTROL_USUARIO WHERE usuario = @USUARIO AND nombre = @NOMBRE  ) BEGIN
  DELETE FROM VIEW_CONTROL_USUARIO
         WHERE usuario = @USUARIO AND nombre = @NOMBRE  
 END
  INSERT INTO  CONTROL_USUARIO 
   VALUES (
    @USUARIO,
    'BTR',
                                @NOMBRE,
    '000000',
    'N'
    )
 SET NOCOUNT OFF
END

GO
