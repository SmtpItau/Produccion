USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_VALIDACION_INTERFAZ]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_GRABA_VALIDACION_INTERFAZ]                  
(              
    @id_interfaz   int                  
,   @interfaz      varchar(20)               
,   @sistema       varchar(20)                 
,   @tipo          int                  
,   @tipo_interfaz char(1)                  
,   @id            numeric(3,0)                     
,   @Descripcion   varchar(100)                  
,   @Tipo_dato     varchar(20)                  
,   @largo         numeric(4,0)                  
,   @desde         numeric(4,0)                  
,   @hasta         numeric(4,0)                  
,   @definicion    varchar(300)   --                  
,   @validacion    varchar(20)                  
,   @inicio1       numeric(4,0)                  
,   @largo1        numeric(4,0)                  
,   @operador      varchar(3)                 
,   @id2           numeric(3,0)                 
,   @inicio2       numeric(4,0)                  
,   @largo2        numeric(4,0)                  
,   @resultado     varchar(100)          
,   @habilitacampo int                  
)                  
AS                  
BEGIN                  
                       
    IF @tipo = 1                   
    BEGIN          
        INSERT INTO VALIDACIONES_INTERFACES                   
        (              
               Id_interfaz                  
        ,      Nombre_interfaz                  
        ,      Sistema              
        ,      Tipo                  
        ,      Id_campo                  
        ,      Descripcion_campo                  
        ,      Tipo_Dato                  
        ,      Largo                  
        ,      Desde                  
        ,      Hasta                  
        ,      Definicion_campo                
        ,      Validacion                  
        ,      Inicio1                
        ,      Largo1                
        ,      Operador     
        ,      Id_campo2               
        ,      Inicio2                
        ,      Largo2                
        ,      Resultado_esperado      
        ,      Habilita_CampoACampo                
        )                  
        VALUES                  
        (              
               @id_interfaz                  
        ,      @interfaz              
        ,      @sistema                  
        ,      @tipo_interfaz                   
        ,      @id                              
        ,      @Descripcion                     
        ,      @Tipo_dato                       
        ,      @largo                           
        ,      @desde                           
        ,      @hasta                           
        ,      @definicion                   
        ,      @validacion                
        ,      @inicio1                
        ,      @largo1                
        ,      @operador    
        ,      @id2                
        ,      @inicio2                 
        ,      @largo2                    
        ,      @resultado          
        ,      @habilitacampo            
        )                    
    END                  
    ELSE IF @tipo = 2                   
    BEGIN                  
        UPDATE VALIDACIONES_INTERFACES                  
        SET    descripcion_campo    = @Descripcion                  
        ,      tipo_dato            = @Tipo_dato                  
        ,      definicion_campo     = @definicion                             
        WHERE  Id_interfaz          = @Id_interfaz                
        AND    Sistema              = @Sistema                
        AND    Tipo                 = @tipo_interfaz                  
        AND    Id_campo             = @id                  
                  
    END            
    ELSE IF @tipo = 3            
    BEGIN            
        UPDATE VALIDACIONES_INTERFACES                  
        SET    descripcion_campo    = @Descripcion             
        ,      validacion           = @validacion                  
        ,      inicio1              = @inicio1                 
        ,      largo1               = @largo1                  
        ,      operador             = @operador                
        ,      id_campo2            = @id2         
        ,      inicio2              = @inicio2                  
        ,      largo2               = @largo2                  
        ,      resultado_esperado   = @resultado                  
        WHERE  Id_interfaz          = @Id_interfaz                
        AND    Sistema              = @Sistema                
        AND    Tipo                 = @tipo_interfaz                  
        AND    Id_campo             = @id              
    END            
    ELSE IF @tipo = 4            
    BEGIN            
        UPDATE VALIDACIONES_INTERFACES                  
        SET    Habilita_campoacampo = @habilitacampo                           
        WHERE  Id_interfaz          = @Id_interfaz                
        AND    Sistema              = @Sistema                
        AND    Tipo                 = @tipo_interfaz                  
        AND    Id_campo             = @id              
    END        
    ELSE IF @tipo = 5        
    BEGIN        
        IF EXISTS(SELECT 1 FROM VALIDACIONES_INTERFACES WHERE Id_interfaz = @id_interfaz and Sistema = @sistema)            
        BEGIN        
            DELETE FROM VALIDACIONES_INTERFACES         
            WHERE Id_interfaz = @id_interfaz         
            and   Sistema     = @sistema        
        END        
    END            
                  
END 
GO
