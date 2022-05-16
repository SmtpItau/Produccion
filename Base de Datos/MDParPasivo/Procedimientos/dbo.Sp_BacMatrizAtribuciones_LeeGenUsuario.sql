USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMatrizAtribuciones_LeeGenUsuario]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_BacMatrizAtribuciones_LeeGenUsuario]
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   SELECT usuario
      ,   nombre
   FROM USUARIO
   WHERE activo = 'S'

   SET NOCOUNT OFF

END

GO
