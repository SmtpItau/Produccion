USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_Validate]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_Validate]
(@IdAplicacion NVARCHAR(30) ,@IdUser NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Recupera la informacion necesaria para verificar las credenciales proporcionales

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_Validate 'FFMM', 'GBREL'

*/

BEGIN
	SELECT [Password]
	      ,IsApproved
	      ,IsLockedOut
	      ,IsReset
	      ,DATEDIFF(DAY ,LastPasswordChangedDate ,GETDATE()) AS ChangeDays
	FROM   FWK_USERS
	WHERE  id_aplicacion = @IdAplicacion
	       AND id_user = @IdUser
	       AND IsLockedOut = 0
END

GO
