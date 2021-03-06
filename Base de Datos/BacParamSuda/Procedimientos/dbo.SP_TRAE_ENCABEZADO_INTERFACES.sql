USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_ENCABEZADO_INTERFACES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_TRAE_ENCABEZADO_INTERFACES]             
(            
    @Sistema    char(3)            
,   @IdInterfaz int            
)            
AS             
BEGIN            
          
    IF @IdInterfaz > 0           
    BEGIN          
          
             SELECT           
                   id_interfaz          
            ,      nombre_interfaz          
            ,      nombre_largo            
            ,      largo_encabezado            
            ,      largo_cuerpo            
            ,      largo_ultimo_registro         
            ,      periodicidad       
            ,      isnull(ValLargo, 0)    
            ,      isnull(ValConsistencia, 0)    
            ,      isnull(ValCampoACampo, 0)    
               
            FROM   FORMATO_INTERFACES F            
            INNER JOIN SISTEMA_CNT S ON F.sistema = S.id_sistema            
            WHERE  F.SISTEMA     = @Sistema            
            AND    F.ID_INTERFAZ = @IdInterfaz          
    END          
    ELSE          
    BEGIN           
            SELECT           
                   id_interfaz          
            ,      nombre_interfaz            
            ,      nombre_largo          
            ,      largo_encabezado            
            ,      largo_cuerpo            
            ,      largo_ultimo_registro          
            ,      periodicidad        
            ,      isnull(ValLargo, 0)    
            ,      isnull(ValConsistencia, 0)    
            ,      isnull(ValCampoACampo, 0)            
               
            FROM   FORMATO_INTERFACES F            
            INNER JOIN SISTEMA_CNT S ON F.sistema = S.id_sistema            
            WHERE  F.SISTEMA     = @Sistema               
               
    END          
             
END
GO
