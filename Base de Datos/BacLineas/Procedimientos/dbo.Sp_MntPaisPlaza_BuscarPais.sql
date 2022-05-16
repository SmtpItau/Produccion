USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MntPaisPlaza_BuscarPais]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MntPaisPlaza_BuscarPais    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[Sp_MntPaisPlaza_BuscarPais] 
   ( @CODIGOPAIS NUMERIC(5))
AS 
BEGIN
 SET NOCOUNT ON
 SELECT codigo_pais,nombre
 FROM PAIS
 WHERE codigo_pais = @CODIGOPAIS
 SET NOCOUNT OFF
END 






GO
