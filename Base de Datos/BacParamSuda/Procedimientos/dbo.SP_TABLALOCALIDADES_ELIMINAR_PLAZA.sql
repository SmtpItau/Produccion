USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TABLALOCALIDADES_ELIMINAR_PLAZA]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_TABLALOCALIDADES_ELIMINAR_PLAZA    fecha de la secuencia de comandos: 03/04/2001 15:18:12 ******/
CREATE PROCEDURE [dbo].[SP_TABLALOCALIDADES_ELIMINAR_PLAZA](@codigo_plaza INT)
AS 
BEGIN
   SET NOCOUNT OFF
   IF EXISTS(SELECT codigo_plaza FROM PLAZA
  WHERE codigo_plaza = @codigo_plaza)
   BEGIN
       DELETE PLAZA WHERE codigo_plaza = @codigo_plaza
 
   END ELSE
   BEGIN
    SELECT 'NO EXISTE'
   END
   SET NOCOUNT ON
END
GO
