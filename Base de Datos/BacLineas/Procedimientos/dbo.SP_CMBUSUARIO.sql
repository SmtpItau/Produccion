USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CMBUSUARIO]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_CMBUSUARIO    fecha de la secuencia de comandos: 03/04/2001 15:18:00 ******/
CREATE PROCEDURE [dbo].[SP_CMBUSUARIO]
AS 
BEGIN
 SET NOCOUNT ON
 SELECT usuario
 FROM USUARIO  
 ORDER BY  usuario
SET NOCOUNT OFF
END

GO
