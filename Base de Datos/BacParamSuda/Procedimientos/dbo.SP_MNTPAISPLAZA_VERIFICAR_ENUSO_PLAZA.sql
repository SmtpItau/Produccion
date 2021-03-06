USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTPAISPLAZA_VERIFICAR_ENUSO_PLAZA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Objeto:  procedimiento  almacenado dbo.Sp_MntPaisPlaza_Verificar_EnUso_Plaza    fecha de la secuencia de comandos: 03/04/2001 15:18:10 ******/
CREATE PROCEDURE [dbo].[SP_MNTPAISPLAZA_VERIFICAR_ENUSO_PLAZA] (@CODIGOPLAZA NUMERIC(5))
                                  
AS 
BEGIN
SET NOCOUNT ON
IF EXISTS(SELECT CORRESPONSAL.codigo_plaza FROM CORRESPONSAL WHERE CORRESPONSAL.codigo_plaza = @CODIGOPLAZA  )
      
        IF @@ERROR <> 0 
          BEGIN
          SELECT 'ERROR'
        END ELSE
          BEGIN
          SELECT 'OK'
       END 
       
ELSE BEGIN
   SELECT 'NO EXISTE'
END
 
   SET NOCOUNT OFF
END  

GO
