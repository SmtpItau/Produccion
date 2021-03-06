USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_EMISOR]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_ELIMINA_EMISOR    fecha de la secuencia de comandos: 03/04/2001 15:18:02 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_ELIMINA_EMISOR    fecha de la secuencia de comandos: 14/02/2001 09:58:25 ******/
CREATE PROCEDURE [dbo].[SP_ELIMINA_EMISOR]
                  (@nrut NUMERIC(9))
AS
BEGIN
      SET NOCOUNT ON
 DELETE EMISOR WHERE emrut = @nrut
      SET NOCOUNT OFF
 IF @@ERROR<> 0  SELECT 'NO'
 ELSE   SELECT 'SI'
END
GO
