USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_IsAuthorized]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_IsAuthorized]
(@IdAplicacion NVARCHAR(30) ,@IdUser NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Evalua si el usuario puede utilizar el Sistema indicado

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_IsAuthorized 'FFMM', 'ADMIN'

*/

BEGIN
	SELECT 1
	FROM   FWK_USERS_APLICACIONES
	WHERE  id_aplicacion     = @IdAplicacion
	       AND id_user       = @IdUser
END
GO
