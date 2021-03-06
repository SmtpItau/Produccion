USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MOSTRAR_PLAZA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_Mostrar_Plaza    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[SP_MOSTRAR_PLAZA]
 ( @Codigo_PAIS CHAR(5)='')
AS
BEGIN 
   IF @Codigo_PAIS = '' 
 BEGIN
    SELECT codigo_plaza, codigo_pais, nombre, glosa  FROM PLAZA ORDER BY nombre
 END
  ELSE
 BEGIN
    SELECT codigo_plaza, codigo_pais, nombre, glosa FROM PLAZA
  WHERE codigo_pais = CONVERT(NUMERIC(5),@Codigo_PAIS)
   ORDER BY nombre
 END
END

GO
