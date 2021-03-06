USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_CAMPO_COMPARACION]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_TRAE_CAMPO_COMPARACION]          
(             
    @interfaz varchar(20)        
,   @sistema  char(3)    
,   @id_campo numeric(3,0)        
,   @tipo     int          
)          
AS           
BEGIN          
          
   IF @tipo = 1        
       SELECT Id_campo, Descripcion_campo          
       FROM   VALIDACIONES_INTERFACES          
       WHERE  id_interfaz = @interfaz     
       AND    sistema     = @sistema      
       ORDER BY Id_campo asc         
      
   ELSE IF @tipo = 2        
       SELECT Id_campo, Descripcion_campo, desde, largo          
       FROM   VALIDACIONES_INTERFACES          
       WHERE  id_interfaz = @interfaz    
       AND    sistema     = @sistema     
       AND    Id_campo    = @id_campo       
       ORDER BY Id_campo asc       
          
END
GO
