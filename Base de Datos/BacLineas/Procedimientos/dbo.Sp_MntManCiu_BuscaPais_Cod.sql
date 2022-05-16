USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MntManCiu_BuscaPais_Cod]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MntManCiu_BuscaPais_Cod    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[Sp_MntManCiu_BuscaPais_Cod] ( @NOMBRE  CHAR(50))
AS
BEGIN
 SET NOCOUNT ON
  IF EXISTS(SELECT * FROM PAIS) BEGIN
   SELECT nombre,codigo_pais FROM PAIS WHERE nombre = @NOMBRE
  END
  ELSE BEGIN
   SELECT "ERROR"
  END
 SET NOCOUNT OFF
END






GO
