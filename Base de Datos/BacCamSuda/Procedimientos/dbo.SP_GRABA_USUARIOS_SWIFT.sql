USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_USUARIOS_SWIFT]    Script Date: 11-05-2022 16:43:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_USUARIOS_SWIFT](
      @numero_swift NUMERIC(10) ,
      @usuario1 CHAR(15) ,
      @usuario2 CHAR(15)
     )
AS
BEGIN
 SET NOCOUNT ON
 DECLARE @agrupa  CHAR(1)
 SELECT @agrupa = ''
 IF @usuario1 <> '' OR @usuario2 <> ''
  SELECT @agrupa = 'S' 
 
 UPDATE tbtransferencia
 SET usuario  = @usuario1 ,
  usuario1 = @usuario2 
 WHERE numero_operacion = @numero_swift
 UPDATE memo
 SET moimpreso = 'S'  
 WHERE numerointerfaz = @numero_swift
 UPDATE tbtransferencia
 SET estado = 'P'
 WHERE numero_operacion = @numero_swift AND
  ( usuario = '' OR usuario1 = '' )
 
 SET NOCOUNT OFF
END

GO
