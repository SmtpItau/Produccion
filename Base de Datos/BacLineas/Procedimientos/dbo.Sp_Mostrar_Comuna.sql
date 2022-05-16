USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Comuna]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Mostrar_Comuna    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[Sp_Mostrar_Comuna]
 ( @Codigo_CIUDAD CHAR(5)='')
AS
BEGIN 
   IF @Codigo_CIUDAD='' 
 BEGIN
    SELECT codigo_comuna, codigo_ciudad, nombre FROM COMUNA ORDER BY nombre 
 END
  ELSE
 BEGIN
    SELECT codigo_comuna, codigo_ciudad, nombre FROM COMUNA 
  WHERE Codigo_CIUDAD = CONVERT(NUMERIC(5),@Codigo_CIUDAD)
   ORDER BY nombre
 END
END






GO
