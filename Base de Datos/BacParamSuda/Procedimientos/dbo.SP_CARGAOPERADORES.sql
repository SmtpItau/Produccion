USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAOPERADORES]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
CREATE PROCEDURE [dbo].[SP_CARGAOPERADORES]  
AS  
BEGIN  
  
   SET NOCOUNT ON  
  
   /*  
   SELECT  'usuario'    = usr.usuario  
   ,       'nomUsuario' = CASE WHEN PATINDEX('%-%', usr.nombre) > 0 THEN RTRIM(SUBSTRING(usr.nombre, 1, PATINDEX('%-%', usr.nombre) -1))  
                        ELSE usr.nombre   
                         END   
   FROM     BacParamSuda.dbo.USUARIO usr  
   WHERE    UPPER(usr.tipo_usuario) = 'TRADER'  
   ORDER BY usr.usuario  
   */  
  
   SELECT 'usuario'    = usr.usuario  
   ,      'nomUsuario' = CASE WHEN PATINDEX('%-%',usr.nombre) > 0 THEN RTRIM(SUBSTRING(usr.nombre,1,PATINDEX('%-%',usr.nombre)-1))   
                       ELSE usr.nombre   
                         END   
		  ,'clase'     =	usr.clase
   FROM   BacParamSuda.dbo.USUARIO usr  
          LEFT JOIN BacParamSuda.dbo.GEN_TIPOS_USUARIO tip ON tip.Tipo_Usuario = usr.tipo_usuario  
   WHERE  tip.Rol          = 'INGRESADOR'  
   ORDER BY usr.usuario  
  
END
GO
