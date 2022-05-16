USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BORRAR_FORMAPAGO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.SP_BORRAR_FORMAPAGO    fecha de la secuencia de comandos: 03/04/2001 15:17:58 ******/
/****** Objeto:  procedimiento  almacenado dbo.SP_BORRAR_FORMAPAGO    fecha de la secuencia de comandos: 14/02/2001 09:58:23 ******/
CREATE PROCEDURE [dbo].[SP_BORRAR_FORMAPAGO]( @codigo INTEGER )
AS
BEGIN
     DELETE FROM FORMA_DE_PAGO WHERE codigo = @codigo
                
     IF @@ERROR <> 0  
        SELECT -1, 'ERROR no se puede borrar Apoderado'
END  
GO
