USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_AGREGAR_PLAZA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TABLALOCALIDADES_AGREGAR_PLAZA    fecha de la secuencia de comandos: 03/04/2001 15:18:11 ******/
CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_AGREGAR_PLAZA] (
           @codigo_plaza    int,
                         @glosa    varchar(10),
        @nombre          varchar(50),
        @codigo_pais     int
                                        )
AS 
BEGIN
 SET NOCOUNT OFF
 --SELECT * FROM PLAZA
 
    IF NOT EXISTS(SELECT codigo_plaza, codigo_pais FROM PLAZA
  WHERE codigo_plaza = @codigo_plaza)-- or nombre = @nombre and codigo_pais = @codigo_Pais)
  --WHERE codigo_region = @codigo_region and codigo_pais = @codigo_Pais)
    BEGIN
  INSERT INTO PLAZA(codigo_plaza, glosa, nombre, codigo_pais)
  VALUES (@codigo_plaza, @glosa, @nombre, @codigo_pais)
  IF @@ERROR <> 0 
     BEGIN
 
      SELECT 'ERROR'
     END ELSE
     BEGIN
   SELECT 'OK'
     END
    END ELSE
    BEGIN
  IF EXISTS(SELECT codigo_plaza, codigo_pais FROM PLAZA
  WHERE codigo_plaza = @codigo_plaza) -- AND codigo_pais = @codigo_Pais
    BEGIN
   UPDATE PLAZA SET nombre = @nombre, glosa = @glosa, codigo_pais = @codigo_pais  where codigo_plaza = @codigo_plaza --and codigo_pais = @codigo_PAIS
    END ELSE
    BEGIN
     SELECT 'EXISTE'
    end
   END
   SET NOCOUNT ON 
END
GO
