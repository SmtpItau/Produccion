USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_RESPONSABLE_INTERFAZ]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
        
CREATE PROCEDURE [dbo].[SP_GRABA_RESPONSABLE_INTERFAZ]        
(    @interfaz        INT       
 ,   @nombre_interfaz VARCHAR(20)       
 ,   @responsable     CHAR(15)        
 ,   @Sistema         CHAR(3)        
 ,   @tipo            INT        
 )        
AS         
BEGIN        
        
 SET NOCOUNT ON        
        
    IF @tipo = 1        
    BEGIN  
        IF EXISTS( SELECT 1 FROM RESPONSABLE_INTERFACES WHERE Id_interfaz = @interfaz AND Sistema = @Sistema )              
            DELETE FROM RESPONSABLE_INTERFACES        
            WHERE  id_interfaz = @interfaz        
            AND    sistema     = @Sistema        
    END         
        
    IF @tipo = 2        
    BEGIN        
        IF EXISTS( SELECT 1 FROM RESPONSABLE_INTERFACES WHERE Id_interfaz = @interfaz AND Sistema = @Sistema AND Responsable = @responsable)        
            DELETE FROM RESPONSABLE_INTERFACES WHERE Id_interfaz = @interfaz AND Sistema = @Sistema AND Responsable = @responsable        
        
            INSERT INTO RESPONSABLE_INTERFACES        
            (    Id_interfaz      
            ,    Nombre_interfaz        
            ,    Responsable        
            ,    Sistema        
            )        
            VALUES        
            (    @interfaz        
            ,    @nombre_interfaz      
            ,    @responsable        
            ,    @Sistema        
            )         
    END        
        
END 
GO
