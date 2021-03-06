USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_GENERAUS]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_GENERAUS] (
       @Usuario Char(10),
       @Nombre  Char(3)
          )
AS
BEGIN
 DECLARE 
   @TERMINAL  CHAR(6),
   @CONT   NUMERIC(2), 
   @TMP   CHAR(6),
   @TMP2   CHAR(6)
 SET NOCOUNT ON
 
 IF EXISTS (SELECT Usuario,Nombre FROM VIEW_CONTROL_USUARIO WHERE Usuario = @Usuario And Nombre = @Nombre  ) BEGIN
  
  DELETE FROM VIEW_CONTROL_USUARIO
         WHERE Usuario = @Usuario And Nombre = @Nombre  
  
 END
  INSERT INTO  CONTROL_USUARIO 
   VALUES (
    @Usuario,
    'BTR',
                                @NOMBRE,
    '000000',
    'N'
    )
 
 SET NOCOUNT OFF
END

GO
