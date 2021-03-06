USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACRIEPAIS_BUSCA]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BACRIEPAIS_BUSCA    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_BACRIEPAIS_BUSCA    fecha de la secuencia de comandos: 14/02/2001 09:58:22 ******/
CREATE PROCEDURE [dbo].[SP_BACRIEPAIS_BUSCA] ( @codigo   NUMERIC (5),
           @nombre   CHAR   (50)) 
AS
BEGIN
 SET NOCOUNT ON
 IF @codigo <> 0 BEGIN
 
  SELECT 
   codigo_pais,
   nombre
 
   FROM PAIS 
   WHERE codigo_pais = @codigo ORDER BY codigo_pais
 
 END
 
 IF @nombre <> '' BEGIN
 
  SELECT 
   codigo_pais,
   nombre
   
   FROM PAIS WHERE nombre = @nombre ORDER BY nombre
 
 END
 
 SET NOCOUNT OFF
END

GO
