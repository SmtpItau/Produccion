USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_FORMATO_INTERFACES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[SP_ELIMINA_FORMATO_INTERFACES]        
(        
    @Sistema char(3)        
,   @Interfaz varchar(20)        
)        
AS        
BEGIN        
        
    IF EXISTS(SELECT 1 FROM FORMATO_INTERFACES WHERE nombre_interfaz = @interfaz and sistema = @sistema )          
    BEGIN        
             
        DELETE FROM FORMATO_INTERFACES     WHERE nombre_interfaz = @interfaz AND sistema = @sistema        
        
    END       
 IF EXISTS(SELECT 1 FROM RESPONSABLE_INTERFACES WHERE nombre_interfaz = @interfaz and sistema = @sistema )          
    BEGIN        
          
        DELETE FROM RESPONSABLE_INTERFACES WHERE nombre_interfaz = @interfaz AND sistema = @sistema   
   
    END   
        
END 
GO
