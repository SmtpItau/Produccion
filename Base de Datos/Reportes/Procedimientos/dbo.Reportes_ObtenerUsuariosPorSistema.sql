USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[Reportes_ObtenerUsuariosPorSistema]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================      
-- Author:  <EDUARDO CASTILLO>      
-- Create date: <24-05-2013>      
-- Description: <OBTIENE LOS USUARIOS PERTENECIENTES AL SISTEMA>
-- =============================================      

CREATE PROCEDURE [dbo].[Reportes_ObtenerUsuariosPorSistema] 

@id_sistema as INT

AS      

BEGIN      
 SET NOCOUNT ON;      

       SELECT U.ID_Usuario  AS ID,
                    U.UserName AS NOMBRE
       FROM   bacparamsuda.perfil.Perfileria_Sistema S
           INNER JOIN bacparamsuda.perfil.PERFILERIA_ROL R ON S.ID_SISTEMA = R.ID_SISTEMA
           INNER JOIN bacparamsuda.perfil.PERFILERIA_PRIVILEGIO P ON P.ID_ROL = R.ID_ROL
           INNER JOIN bacparamsuda.perfil.PERFILERIA_USUARIO U ON P.UserName = U.UserName
       WHERE  S.ID_SISTEMA = 5
       ORDER BY U.UserName
END
GO
