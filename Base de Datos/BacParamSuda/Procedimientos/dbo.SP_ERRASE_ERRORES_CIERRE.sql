USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ERRASE_ERRORES_CIERRE]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[SP_ERRASE_ERRORES_CIERRE]    
 ( @Id_sistema    CHAR(3)     
 , @dfechaProceso DATETIME    
 )    
AS    
BEGIN    
    
   SET NOCOUNT ON    
    
   DELETE FROM BacParamSuda.dbo.LOG_INTERFACES    
   WHERE Sistema = @Id_sistema     
   AND   Fecha   = @dfechaProceso     
    
END 
GO
