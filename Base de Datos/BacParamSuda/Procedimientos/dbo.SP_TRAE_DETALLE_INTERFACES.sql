USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_DETALLE_INTERFACES]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_TRAE_DETALLE_INTERFACES]      
 (   @Interfaz VARCHAR(20)      
 ,   @Sistema CHAR(3)      
 )      
AS      
BEGIN      
       
 SET NOCOUNT ON      
      
    SELECT usuario         = usr.usuario      
    ,      Nombre          = usr.nombre      
    ,      Cargo           = CASE WHEN tip.Tipo_Usuario = 'TRADER' THEN 'OPERADOR DE MESA' ELSE tip.Descripcion  END      
    ,      Email           = isnull(usr.email, '')      
    FROM BacParamSuda.dbo.RESPONSABLE_INTERFACES   res      
    INNER JOIN BacParamSuda.dbo.USUARIO            usr ON usr.usuario      = res.Responsable      
    INNER JOIN BacParamSuda.dbo.GEN_TIPOS_USUARIO  tip ON tip.Tipo_Usuario = usr.Tipo_Usuario       
    WHERE  res.sistema     = @Sistema      
    AND    res.Id_interfaz = @Interfaz      
      
    UNION      
       
    SELECT usuario         = inf.Usuario      
    ,      Nombre          = inf.Responsable      
    ,      Cargo           = inf.Cargo      
    ,      Email           = inf.email      
    FROM BacParamSuda.dbo.RESPONSABLE_INTERFACES   res      
    INNER JOIN BacParamSuda.dbo.TBL_RESPONSABLES   inf ON inf.Usuario = res.Responsable      
    WHERE  res.sistema     = @Sistema      
    AND    res.Id_interfaz = @Interfaz      
        
END 
GO
