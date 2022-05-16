USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACRIEPAIS_AYUDACODPAIS]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_BacriePais_AyudaCodPais    fecha de la secuencia de comandos: 03/04/2001 15:17:57 ******/
/****** Objeto:  procedimiento  almacenado dbo.Sp_BacriePais_AyudaCodPais    fecha de la secuencia de comandos: 14/02/2001 09:58:22 ******/
CREATE PROCEDURE [dbo].[SP_BACRIEPAIS_AYUDACODPAIS]
AS
BEGIN
 SET NOCOUNT ON
 
 SELECT  codigo_pais,
  nombre 
 FROM PAIS ORDER BY codigo_pais,nombre
 
 SET NOCOUNT OFF
END
GO
