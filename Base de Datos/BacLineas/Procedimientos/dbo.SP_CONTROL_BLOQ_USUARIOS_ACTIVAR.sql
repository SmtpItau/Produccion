USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_ACTIVAR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_ACTIVAR]
              (
                    @USUARIO      CHAR(10)
              ,     @ID_SISTEMA   CHAR(3)
              ,     @FECHAPROCESO DATETIME
              ,     @FECHASISTEMA DATETIME
              )
       
AS
BEGIN
 DECLARE @NOMBRE     CHAR(50)
 ,       @TERMINAL   CHAR(6)
 ,       @CONT       NUMERIC(2)
 ,       @TMP        CHAR(6)
 ,       @TMP2       CHAR(6)
 ,       @NOMBRE_US  CHAR(50) 

 SET NOCOUNT ON
  SET @TMP    ='111111'   
  SET @TMP2   ='100000'   
  SET @CONT   = (SELECT COUNT(*) FROM VIEW_USUARIO_ACTIVO WHERE usuario = @USUARIO) +1
  
  
  SET @TERMINAL = RIGHT(@TMP2,6)
  SET @TERMINAL= RIGHT(@TMP,@CONT) + @TERMINAL  
  SET @CONT = 1  
CAMBIO_TERMINAL:
  
  
  IF @CONT < 7 BEGIN 

  IF EXISTS (SELECT 1 FROM VIEW_USUARIO_ACTIVO WHERE usuario = @USUARIO AND terminal = @CONT) BEGIN
   SET @CONT = @CONT +1  
   GOTO CAMBIO_TERMINAL
    
  END
  IF EXISTS(SELECT 1 FROM VIEW_USUARIO WHERE usuario = @USUARIO) BEGIN 
    SET @NOMBRE_US = (SELECT nombre FROM VIEW_USUARIO WHERE usuario = @Usuario)
  END 
  ELSE BEGIN
   SET @NOMBRE_US = (SELECT nombre FROM VIEW_USUARIO WHERE usuario = LEFT(@USUARIO,LEN(@USUARIO)))
  END

  INSERT INTO VIEW_USUARIO_ACTIVO (
    Usuario      ,
    Id_Sistema   ,
    Terminal     ,
    FechaProceso ,
    FechaSistema
    )
   VALUES 
    (
    @USUARIO      ,
    @ID_SISTEMA   ,
    @CONT         ,
    @FECHAPROCESO ,
    @FECHASISTEMA
    )

  SELECT @CONT,@USUARIO  

  IF @@ERROR <> 0 BEGIN
   SELECT 'ERROR'
  
  END

    END
    ELSE BEGIN
       SELECT 'LLENO','LLENO'
    END 
 SET NOCOUNT OFF
END
GO
