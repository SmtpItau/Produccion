USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_FAMILIA_INS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_FAMILIA_INS    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
CREATE PROCEDURE [dbo].[SP_FAMILIA_INS]
  (@EMRUT NUMERIC(10))
 
AS
BEGIN 
 SET NOCOUNT OFF
 SELECT emgeneric,emcodigo
 FROM EMISOR
 WHERE emrut =@EMRUT
 SET NOCOUNT ON
END
GO
