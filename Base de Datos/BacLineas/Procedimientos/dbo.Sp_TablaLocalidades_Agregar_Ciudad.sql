USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TablaLocalidades_Agregar_Ciudad]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_TablaLocalidades_Agregar_Ciudad    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[Sp_TablaLocalidades_Agregar_Ciudad] (
            @codigo_ciudad   int,
                  @codigo_region   int,  
                @nombre          char(50) 
              )
AS
BEGIN
 SET NOCOUNT OFF
    IF NOT EXISTS(SELECT codigo_ciudad FROM CIUDAD
  WHERE codigo_ciudad = @codigo_ciudad )
    BEGIN
  INSERT INTO CIUDAD (codigo_ciudad,codigo_region,nombre)
  VALUES (@codigo_ciudad  , @codigo_region, @nombre)
 END ELSE
  BEGIN
  IF EXISTS(SELECT codigo_ciudad, codigo_region, nombre FROM CIUDAD
   WHERE codigo_ciudad = @codigo_ciudad)-- AND nombre <> @nombre and codigo_region = @codigo_region)
     BEGIN
   UPDATE CIUDAD SET nombre = @nombre, codigo_region = @codigo_region  where codigo_ciudad= @codigo_ciudad --and codigo_REGION = @codigo_REGION
    END ELSE
    BEGIN
 
      SELECT "EXISTE"
    END
   END
   SET NOCOUNT ON 
END






GO
