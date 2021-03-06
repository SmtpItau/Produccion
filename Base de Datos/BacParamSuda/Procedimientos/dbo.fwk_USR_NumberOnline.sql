USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_NumberOnline]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_NumberOnline]
(@IdAplicacion NVARCHAR(30) ,@CompareDate DATETIME)
--WITH ENCRYPTION
AS
	/*
Recupera el numero de usuarios conectados

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_NumberOnline ...

*/

BEGIN
	SELECT COUNT(*)
	FROM   FWK_USERS
	WHERE  id_aplicacion = @IdAplicacion
	       AND LastActivityDate > @CompareDate
END

GO
