USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_BACMATRIZATRIBUCIONES_LEEGENUSUARIO]    Script Date: 13-05-2022 10:37:55 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_BACMATRIZATRIBUCIONES_LEEGENUSUARIO]
AS BEGIN
   SET NOCOUNT ON
      SELECT usuario
      ,      nombre 
      ,	     tipo_usuario	
        FROM VIEW_USUARIO
   SET NOCOUNT OFF
END
GO
