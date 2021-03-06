USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_APODERADO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BORRAR_APODERADO    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_BORRAR_APODERADO    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BORRAR_APODERADO]( @nrutcli     NUMERIC(9)
        )
                                     
AS
BEGIN
     DELETE FROM CLIENTE_APODERADO WHERE aprutcli = @nrutcli 
  
     IF @@ERROR <> 0  
        SELECT -1, 'ERROR no se puede borrar Apoderado'
END  
GO
