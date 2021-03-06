USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_DATOS_INTERFACE]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[SP_TRAE_DATOS_INTERFACE]               
 (   @sistema     CHAR(3)         
 ,   @interfaz    INT    
 ,   @tipo        INT    
 ,   @nominterfaz VARCHAR(20)    
 )    
AS    
BEGIN    
      
    SET NOCOUNT ON    
        
    IF @tipo =1         
    BEGIN            
    SELECT Id_campo    
    ,      Descripcion_campo    
    ,      Tipo_Dato    
    ,      Largo    
    ,      Desde    
    ,      Hasta    
    ,      resultado_esperado    
    ,      validacion    
    ,      operador    
    ,      inicio2    
    ,      largo2    
    ,      Id_campo2    
    ,      inicio1    
    ,      largo1    
    ,      definicion_campo    
    ,      habilita_campoacampo    
    FROM   VALIDACIONES_INTERFACES    
    WHERE  Id_interfaz  = @interfaz    
    AND    Sistema      = @sistema  
	AND    Tipo         = 'B'  
    ORDER BY Id_campo ASC         
 END    
    
    IF @tipo = 2    
    BEGIN        
        IF (SELECT COUNT(id_interfaz) FROM FORMATO_INTERFACES WHERE Sistema = @Sistema AND nombre_interfaz = @nominterfaz) > 0    
        BEGIN    
            SELECT Codigo   = id_interfaz    
            , Estado        = 1    
            , Glosa         = 'Interfaz Antes Registrada'    
            FROM FORMATO_INTERFACES    
            WHERE Sistema        = @Sistema    
            AND  nombre_interfaz = @nominterfaz    
        END ELSE    
        BEGIN    
            SELECT Codigo   = MAX( id_interfaz ) + 1    
            ,      Estado   = -1    
            ,      Glosa    = 'Nuevo Registro'    
            FROM   FORMATO_INTERFACES    
            WHERE  Sistema  = @Sistema            
        END    
    END    
    
    IF @tipo = 3        
    BEGIN    
        SELECT Codigo   = Id_interfaz    
        ,      Estado   = 1    
        ,      Glosa    = 'Interfaz Antes Registrada'    
        FROM   FORMATO_INTERFACES    
        WHERE  Sistema         = @Sistema    
        AND    Nombre_interfaz = @nominterfaz    
    END    
    
END 
GO
