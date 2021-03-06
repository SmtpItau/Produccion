USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACRIEPAIS_BUSCADATOS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BacRiePais_BuscaDatos    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
CREATE PROCEDURE [dbo].[SP_BACRIEPAIS_BUSCADATOS] ( @codigo  NUMERIC (5),
         @nombre  CHAR   (50))
AS
BEGIN
 SET NOCOUNT ON
 IF EXISTS (SELECT 1 FROM RIESGO_PAIS WHERE codigo_pais=@codigo AND nombre = @nombre) BEGIN
  SELECT  
   codigo_pais,
   nombre,
   porcentaje,
   totalasignado,
   totalocupado,
   totaldisponible,
   totalexceso
  FROM RIESGO_PAIS WHERE codigo_pais=@codigo AND nombre = @nombre 
 END
 ELSE BEGIN
  SELECT 'ERROR'
 END
 SET NOCOUNT OFF
END
GO
