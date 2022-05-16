USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MntManCiu_BuscaPais]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MntManCiu_BuscaPais    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[Sp_MntManCiu_BuscaPais]
AS
BEGIN
 SET NOCOUNT ON
  IF EXISTS(SELECT * FROM PAIS) BEGIN
   SELECT nombre,codigo_pais FROM PAIS ORDER BY nombre
  END
  ELSE BEGIN
   SELECT "ERROR"
  END
 SET NOCOUNT OFF
END






GO
