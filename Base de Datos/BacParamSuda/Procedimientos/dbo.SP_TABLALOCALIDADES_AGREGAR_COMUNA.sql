USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_AGREGAR_COMUNA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TABLALOCALIDADES_AGREGAR_COMUNA    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_AGREGAR_COMUNA] (
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
 
      SELECT 'ERROR'
     END ELSE
     BEGIN
   SELECT 'OK'
     END
    END ELSE
    BEGIN
  IF EXISTS(SELECT codigo_comuna, codigo_ciudad, nombre FROM COMUNA
   WHERE codigo_comuna = @codigo_comuna)-- AND nombre <> @nombre )
     BEGIN 
   UPDATE COMUNA SET nombre = @nombre, codigo_ciudad = @codigo_ciudad where codigo_comuna= @codigo_comuna
     END ELSE
     BEGIN
       SELECT 'EXISTE'
           END 
    END
   SET NOCOUNT ON 
END
GO
