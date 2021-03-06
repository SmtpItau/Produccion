USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_UpdateActivityDate_ByUserName]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_UpdateActivityDate_ByUserName]
(@IdAplicacion NVARCHAR(30) ,@IdUser NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Actualiza la ultima vez que el usuario ha iniciado sesion

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_UpdateActivityDate_ByUserName 'FFMM', 'GBREL'

*/

BEGIN
	UPDATE FWK_USERS
	SET    LastActivityDate     = GETDATE()
	WHERE  id_aplicacion        = @IdAplicacion
	       AND id_user          = @IdUser
END

GO
