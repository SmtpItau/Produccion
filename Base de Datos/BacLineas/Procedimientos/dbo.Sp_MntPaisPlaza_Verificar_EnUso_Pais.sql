USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[Sp_MntPaisPlaza_Verificar_EnUso_Pais]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO






/****** Objeto:  procedimiento  almacenado dbo.Sp_MntPaisPlaza_Verificar_EnUso_Pais    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
create procedure [dbo].[Sp_MntPaisPlaza_Verificar_EnUso_Pais] (@CODIGOPAIS NUMERIC(5))
                                  
AS 
BEGIN
SET NOCOUNT ON
IF EXISTS(SELECT CORRESPONSAL.codigo_pais FROM CORRESPONSAL WHERE CORRESPONSAL.codigo_pais = @CODIGOPAIS )
      
        IF @@ERROR <> 0 
          BEGIN
          SELECT "ERROR"
        END ELSE
          BEGIN
          SELECT "OK"
       END 
       
ELSE BEGIN
   SELECT "NO EXISTE"
END
 
   SET NOCOUNT OFF
END  






GO
