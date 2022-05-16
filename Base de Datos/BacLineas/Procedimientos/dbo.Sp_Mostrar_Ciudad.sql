USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Ciudad]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_Mostrar_Ciudad    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[Sp_Mostrar_Ciudad]
   ( @Codigo_Region CHAR(5)='')
AS
BEGIN
   IF @Codigo_Region = '' 
 BEGIN
    SELECT codigo_ciudad, codigo_region, nombre FROM CIUDAD ORDER BY nombre
 END
   ELSE
 BEGIN
    SELECT codigo_ciudad, codigo_region, nombre FROM CIUDAD 
  WHERE codigo_region = CONVERT(NUMERIC(5),@Codigo_Region)
  ORDER BY nombre
 END
END






GO
