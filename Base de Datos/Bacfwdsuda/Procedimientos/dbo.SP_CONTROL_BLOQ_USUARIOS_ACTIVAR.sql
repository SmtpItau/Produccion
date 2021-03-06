USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_BLOQ_USUARIOS_ACTIVAR]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_BLOQ_USUARIOS_ACTIVAR](
       @Usuario Char(10),
       @Id_Sistema Char(3),
       @FechaProceso DateTime,
       @FechaSistema DateTime)
       
AS
BEGIN
 DECLARE 
   @NOMBRE   CHAR(50), 
   @TERMINAL  CHAR(6),
   @CONT   NUMERIC(2), 
   @TMP   CHAR(6),
   @TMP2   CHAR(6),
   @Nombre_Us  CHAR(50) 
 SET NOCOUNT ON
    SET @TMP='111111'   
  SET @TMP2='100000'   
  SET @CONT= (SELECT COUNT(*) FROM VIEW_USUARIO_ACTIVO WHERE USUARIO = @USUARIO) +1
  
  
  SET @TERMINAL = RIGHT(@TMP2,6)
  SET @TERMINAL= RIGHT(@TMP,@CONT) + @TERMINAL  
  SET @CONT = 1  
CAMBIO_TERMINAL:
  
  
     IF @CONT < 7 BEGIN --NOT EXISTS(SELECT 1 FROM USUARIO_ACTIVO WHERE TERMINAL = '6' AND USUARIO = @USUARIO) BEGIN 
  IF EXISTS (SELECT 1 FROM VIEW_USUARIO_ACTIVO WHERE USUARIO = @USUARIO AND TERMINAL = @CONT) BEGIN
   SET @CONT = @CONT +1  
   GOTO CAMBIO_TERMINAL
    
  END
  IF EXISTS(SELECT 1 FROM VIEW_USUARIO WHERE USUARIO = @USUARIO) BEGIN 
 
   SET @NOMBRE_US = (SELECT NOMBRE FROM VIEW_USUARIO WHERE Usuario=@Usuario)
  END 
  ELSE BEGIN
   SET @NOMBRE_US = (SELECT NOMBRE FROM VIEW_USUARIO WHERE Usuario= LEFT(@Usuario,LEN(@USUARIO)))
  END
  INSERT INTO VIEW_USUARIO_ACTIVO (
    Usuario,
    Id_Sistema,
    Terminal,
    FechaProceso,
    FechaSistema
    )
   VALUES (
    @Usuario,
    @Id_Sistema,
    @CONT,
    @FechaProceso,
    @FechaSistema
    )
  SELECT @CONT,@Usuario  
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
