USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LOAD_ERRORES_CIERRE]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_LOAD_ERRORES_CIERRE]        
 (   @Id_sistema    CHAR(3)         
 ,   @dfechaProceso DATETIME        
 )        
AS        
BEGIN        
        
    SET NOCOUNT ON        
        
    IF EXISTS ( SELECT 1 FROM BacParamSuda.dbo.LOG_INTERFACES WHERE Sistema = @Id_sistema and Fecha = @dfechaProceso )        
    BEGIN        
        SELECT -1, 'False', 'Errores en generación de Interfaces', Mensaje = 'Error : ' + LTRIM(RTRIM( Nombre_interfaz )) + ' - ' + Error_detectado    
        ,      Numero_operacion, Numero_documento, Numero_correlativo        
        FROM   BacParamSuda.dbo.LOG_INTERFACES         
        WHERE  Sistema = @Id_sistema         
        AND    Fecha   = @dfechaProceso         
    END ELSE        
    BEGIN        
        SELECT 0, 'True', 'Proceso de cierre OK', Menaje = ''        
    END        
        
END 
GO
