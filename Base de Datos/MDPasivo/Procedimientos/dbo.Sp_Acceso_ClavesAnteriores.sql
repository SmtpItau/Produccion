USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Acceso_ClavesAnteriores]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Acceso_ClavesAnteriores]
                                    ( @usuario CHAR(15))

AS
BEGIN

      SET NOCOUNT ON
      SET DATEFORMAT dmy

      SELECT clave_anterior1,
             clave_anterior2,
             clave_anterior3,
             clave
      FROM USUARIO
      WHERE usuario = @usuario
        AND activo = 'S'

      SET NOCOUNT OFF

END






GO
