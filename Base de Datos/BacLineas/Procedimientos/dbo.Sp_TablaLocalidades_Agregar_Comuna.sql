USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Agregar_Comuna]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TablaLocalidades_Agregar_Comuna    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Agregar_Comuna] (
           @codigo_comuna   int,
           @codigo_ciudad   int,  
           @nombre          char(50) 
              )
AS
BEGIN
 SET NOCOUNT OFF
    IF NOT EXISTS(SELECT codigo_comuna, codigo_ciudad, nombre FROM COMUNA
  WHERE codigo_comuna = @codigo_comuna)-- or nombre = @nombre )
    BEGIN 
  INSERT INTO COMUNA (codigo_comuna,codigo_ciudad,nombre)
  VALUES (@codigo_comuna, @codigo_ciudad, @nombre)
  IF @@ERROR <> 0 
     BEGIN
 
      SELECT "ERROR"
     END ELSE
     BEGIN
   SELECT "OK"
     END
    END ELSE
    BEGIN
  IF EXISTS(SELECT codigo_comuna, codigo_ciudad, nombre FROM COMUNA
   WHERE codigo_comuna = @codigo_comuna)-- AND nombre <> @nombre )
     BEGIN 
   UPDATE COMUNA SET nombre = @nombre, codigo_ciudad = @codigo_ciudad where codigo_comuna= @codigo_comuna
     END ELSE
     BEGIN
       SELECT "EXISTE"
           END 
    END
   SET NOCOUNT ON 
END






GO
