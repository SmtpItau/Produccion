USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACRIEPAIS_BUSCAP]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BACRIEPAIS_BUSCAP    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_BACRIEPAIS_BUSCAP    fecha de la secuencia de comandos: 14/02/2001 09:58:22 ******/
CREATE PROCEDURE [dbo].[SP_BACRIEPAIS_BUSCAP] (  @nombre   CHAR   (50)) 
AS
BEGIN
 SET NOCOUNT ON
  IF EXISTS (SELECT 1 FROM PAIS WHERE nombre = @nombre) BEGIN
   SELECT 
    codigo_pais,
    nombre
 
    FROM PAIS WHERE nombre = @nombre ORDER BY nombre
  END
  ELSE BEGIN
   SELECT 'ERROR'
  END
 SET NOCOUNT OFF
END
GO
