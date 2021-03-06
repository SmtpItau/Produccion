USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ELIMINA_VALIDACION_INTERFACES]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[SP_ELIMINA_VALIDACION_INTERFACES]      
(      
    @Id_interfaz int      
,   @Interfaz    varchar(20)      
,   @Sistema     varchar(3)      
,   @Tipo_campo  varchar(1)      
)      
AS      
BEGIN      
      
    IF EXISTS( SELECT 1 FROM VALIDACIONES_INTERFACES WHERE Nombre_interfaz = @Interfaz AND Sistema = @Sistema AND Tipo = @Tipo_campo )      
          
        DELETE FROM VALIDACIONES_INTERFACES       
        WHERE Nombre_interfaz = @Interfaz       
        AND   Sistema         = @Sistema       
        AND   Tipo            = @Tipo_campo           
      
END 
GO
