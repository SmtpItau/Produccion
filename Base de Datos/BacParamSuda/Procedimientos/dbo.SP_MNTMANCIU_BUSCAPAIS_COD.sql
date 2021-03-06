USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTMANCIU_BUSCAPAIS_COD]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MntManCiu_BuscaPais_Cod    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[SP_MNTMANCIU_BUSCAPAIS_COD] ( @NOMBRE  CHAR(50))
AS
BEGIN
 SET NOCOUNT ON
  IF EXISTS(SELECT * FROM PAIS) BEGIN
   SELECT nombre,codigo_pais FROM PAIS WHERE nombre = @NOMBRE
  END
  ELSE BEGIN
   SELECT 'ERROR'
  END
 SET NOCOUNT OFF
END

GO
