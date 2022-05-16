USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ENVIOMAILPAE]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_ENVIOMAILPAE]
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
	SELECT	 DISTINCT
             rol.Usuario                     
      ,      rol.EMail 
    FROM BacParamSuda.dbo.CONFIGURACION_MENSAJE           conf
        INNER JOIN BacParamSuda.dbo.TABLA_ROLES_USUARIOS  rol  ON rol.Rol = conf.Rol
    WHERE  Estado    = 1  

END
GO
