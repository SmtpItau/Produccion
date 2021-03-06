USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Ayuda_Usuarios]    Script Date: 16-05-2022 11:18:07 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Ayuda_Usuarios]
        (@sw   NUMERIC(1),
         @usuario   CHAR(50)=' ')

AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   IF @sw = 0
   BEGIN

      SELECT nombre
         ,   usuario
      FROM   USUARIO
      WHERE  activo = 'S'
      ORDER BY nombre

   END ELSE BEGIN

      SELECT nombre
         ,   usuario
      FROM   USUARIO
      WHERE  nombre = @usuario
        AND  activo = 'S'
      ORDER BY nombre
   END

   SET NOCOUNT OFF 

END






GO
