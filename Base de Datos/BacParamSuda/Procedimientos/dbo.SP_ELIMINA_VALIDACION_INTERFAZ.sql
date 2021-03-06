USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_VALIDACION_INTERFAZ]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_ELIMINA_VALIDACION_INTERFAZ]    
(    
    @id      int    
,   @sistema char(3)    
,   @campo   int    
,   @tipo    int    
,   @largob  int    
)    
AS    
BEGIN    
    IF @tipo = 1    
    BEGIN    
        DELETE FROM VALIDACIONES_INTERFACES    
        WHERE  Id_interfaz  = @id    
        AND    sistema      = @sistema    
        AND    Id_campo     = @campo    
    
        UPDATE FORMATO_INTERFACES    
        SET    largo_cuerpo = @largob    
        WHERE  Id_interfaz  = @id    
        AND    sistema      = @sistema     
    END    
END 
GO
