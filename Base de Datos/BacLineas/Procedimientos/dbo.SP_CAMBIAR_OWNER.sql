USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CAMBIAR_OWNER]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO







CREATE PROCEDURE [dbo].[SP_CAMBIAR_OWNER]( @Usuario_Actual CHAR(100) ,
       @Usuario_Nuevo CHAR(100) )
AS
BEGIN
/* Objetivo : permite el cambio de owner de los objetos de la base de datos
 Autor    : Miguel Gajardo
 Fecha    : 4 de Julio de 2001
*/
 DECLARE @TOTAL INTEGER
 DECLARE @CONT INTEGER
 DECLARE @OBJETO CHAR(255)
 DECLARE @UID_USUARIO INTEGER
 IF NOT EXISTS(SELECT * FROM sysusers WHERE name = @Usuario_Actual) BEGIN
  PRINT 'Usuario Actual no existe en la base de datos'
  RETURN
 END
 IF NOT EXISTS(SELECT * FROM sysusers WHERE name = @Usuario_Nuevo) BEGIN
  PRINT 'Nuevo Dueño no existe en la base de datos'
  RETURN
 END
 SELECT @UID_USUARIO = uid FROM sysusers WHERE name = @Usuario_Actual
 SELECT @CONT = 1
 SELECT @TOTAL = COUNT(*) FROM SYSOBJECTS WHERE UID = @UID_USUARIO AND TYPE <> 'S' AND category = 0
 WHILE @CONT <= @TOTAL BEGIN
  SET ROWCOUNT @CONT
 
  SELECT @OBJETO = @Usuario_Actual + '.' + NAME FROM SYSOBJECTS WHERE UID = @UID_USUARIO AND TYPE <> 'S' AND category = 0
  SET ROWCOUNT 0
  SELECT @CONT = @CONT + 1
  EXECUTE SP_CHANGEOBJECTOWNER @OBJETO , @Usuario_Nuevo
 END
END
-- SP_CAMBIAR_OWNER 'bacuser','dbo'







GO
