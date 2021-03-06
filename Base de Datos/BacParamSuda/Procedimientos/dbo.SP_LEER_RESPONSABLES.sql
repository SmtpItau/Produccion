USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_RESPONSABLES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
   
CREATE PROCEDURE [dbo].[SP_LEER_RESPONSABLES]    
(     
    @cUsuario VARCHAR(15) = ''    
)    
AS    
BEGIN    
     
   SET NOCOUNT ON    
     
   SELECT Usuario  = Usuario     
   ,      Nombre   = CONVERT(VARCHAR(80), ISNULL( Nombre, usuario ))    
   ,      Cargo    = Descripcion    
   ,      Email    = isnull(Email, '')    
   ,      Tipo     = 1    
   FROM   BacParamSuda.dbo.USUARIO  usr     
   INNER JOIN GEN_TIPOS_USUARIO tip ON tip.Tipo_Usuario = usr.Tipo_Usuario    
   WHERE  (Usuario = @cUsuario OR @cUsuario = '')     
    
   UNION    
    
   SELECT Usuario  = UPPER( Usuario  )    
   ,      Nombre   = CONVERT(VARCHAR(80), UPPER( Responsable ) )    
   ,      Cargo    = UPPER( Cargo )    
   ,      Email    = Email    
   ,      Tipo     = 2    
   FROM   dbo.TBL_RESPONSABLES    
   WHERE  (Usuario = @cUsuario OR @cUsuario = '')    
   ORDER BY Tipo DESC    
    
END 
GO
