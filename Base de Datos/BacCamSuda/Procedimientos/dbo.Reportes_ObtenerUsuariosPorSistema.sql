USE [BacCamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerUsuariosPorSistema]    Script Date: 11-05-2022 16:43:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Reportes_ObtenerUsuariosPorSistema] 

@id_sistema as int
AS      
BEGIN      
 SET NOCOUNT ON;      

	SELECT U.ID_Usuario  AS ID,
   			U.UserName AS NOMBRE
	FROM   bacparamsuda.perfil.Perfileria_Sistema S

           INNER JOIN bacparamsuda.perfil.PERFILERIA_ROL R ON S.ID_SISTEMA = R.ID_SISTEMA
           INNER JOIN bacparamsuda.perfil.PERFILERIA_PRIVILEGIO P ON P.ID_ROL = R.ID_ROL
           INNER JOIN bacparamsuda.perfil.PERFILERIA_USUARIO U ON P.UserName = U.UserName

	WHERE  S.ID_SISTEMA = @ID_SISTEMA
	ORDER BY U.UserName
END

GO
