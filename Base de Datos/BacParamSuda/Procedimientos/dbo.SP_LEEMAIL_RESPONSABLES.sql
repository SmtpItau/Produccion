USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEEMAIL_RESPONSABLES]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    
CREATE PROCEDURE [dbo].[SP_LEEMAIL_RESPONSABLES]    
(   @Id_Sistema  CHAR(3)  )    
AS    
BEGIN    
    
    SET NOCOUNT ON    
    
    SELECT Nombre    = R.nombre    
    ,      Email     = isnull( R.email, '')    
    FROM   RESPONSABLE_INTERFACES    I     
    INNER JOIN BacParamSuda.dbo.USUARIO R ON R.usuario = I.Responsable    
    WHERE  I.sistema = @Id_Sistema    
    
    UNION    
    
    SELECT Nombre    = R.Responsable    
    ,      Email     = R.Email    
    FROM   RESPONSABLE_INTERFACES  I    
    INNER JOIN TBL_RESPONSABLES R ON R.Usuario = I.Responsable    
    WHERE  I.sistema = @Id_Sistema    
    
END 
GO
