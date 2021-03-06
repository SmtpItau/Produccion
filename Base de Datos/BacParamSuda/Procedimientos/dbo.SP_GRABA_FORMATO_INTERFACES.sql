USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_FORMATO_INTERFACES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_GRABA_FORMATO_INTERFACES]                
(                
    @id                    int                      
,   @interfaz              varchar(20)               
,   @nombre_largo          varchar(100)                
,   @largo_encabezado      numeric(4)                  
,   @largo_cuerpo          numeric(4)                   
,   @largo_ultimo_registro numeric(4)                   
,   @sistema               char(3)              
,   @periodicidad          int         
,   @tipo                  int      
,   @ValLargo              int      
,   @ValConsistencia       int      
,   @ValCampo              int            
)                
AS                
    
BEGIN                        
                  
    IF EXISTS(SELECT 1 FROM FORMATO_INTERFACES WHERE Nombre_interfaz = @interfaz)                
    BEGIN        
        IF @tipo= 1        
        BEGIN        
            UPDATE FORMATO_INTERFACES                
            SET    Largo_cuerpo       = @largo_cuerpo           
            WHERE  id_interfaz        = @id          
            AND    sistema            = @sistema          
        END        
        ELSE        
        BEGIN        
            UPDATE FORMATO_INTERFACES                
            SET             
                Nombre_interfaz       = @interfaz            
            ,   Nombre_largo          = @nombre_largo            
            ,   Largo_encabezado      = @largo_encabezado                
            ,   Largo_cuerpo          = @largo_cuerpo                
            ,   Largo_ultimo_registro = @largo_ultimo_registro                
            ,   Sistema               = @sistema            
            ,   Periodicidad          = @periodicidad      
            ,   ValLargo              = @ValLargo      
            ,   ValConsistencia       = @ValConsistencia      
            ,   ValCampoACampo        = @ValCampo             
            WHERE  id_interfaz        = @id          
            AND    sistema            = @sistema          
        END        
    END                
    ELSE                
    BEGIN               
        SELECT @id = MAX(id_interfaz)+1 FROM FORMATO_INTERFACES            
        WHERE  sistema     = @Sistema             
           
        INSERT INTO FORMATO_INTERFACES     
        VALUES                
        (            
            @id                
        ,   @interfaz             
        ,   @nombre_largo               
        ,   @largo_encabezado                
        ,   @largo_cuerpo                
        ,   @largo_ultimo_registro                
        ,   @sistema                
        ,   @periodicidad      
        ,   @ValLargo      
        ,   @ValConsistencia      
        ,   @ValCampo                
        )                      
    END                   
END 
GO
