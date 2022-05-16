USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_TraeBloqueo_Usuario]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_TraeBloqueo_Usuario]
                  (@xusuario CHAR(15))
                                        
AS 
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   SELECT bloqueado FROM USUARIO WHERE usuario = @xusuario

END


GO
