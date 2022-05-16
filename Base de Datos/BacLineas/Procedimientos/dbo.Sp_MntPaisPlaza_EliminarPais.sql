USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MntPaisPlaza_EliminarPais]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MntPaisPlaza_EliminarPais    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
create procedure [dbo].[Sp_MntPaisPlaza_EliminarPais] (@CODIGOPAIS NUMERIC(5))
                                  
AS 
BEGIN
SET NOCOUNT ON
IF EXISTS(SELECT codigo_pais FROM PAIS WHERE codigo_pais = @CODIGOPAIS )
    BEGIN
    DELETE PAIS WHERE codigo_pais = @CODIGOPAIS  
        IF @@ERROR <> 0 
          BEGIN
          SELECT "ERROR"
        END ELSE
          BEGIN
          SELECT "OK"
       END 
   END    
ELSE BEGIN
   SELECT "NO EXISTE"
END
 
   SET NOCOUNT OFF
  
END






GO
