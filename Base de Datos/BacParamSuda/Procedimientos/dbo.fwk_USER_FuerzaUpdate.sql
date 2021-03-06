USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USER_FuerzaUpdate]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USER_FuerzaUpdate] 
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdUser           NVARCHAR(30)
   ,@Locked           BIT
)
AS
	/*
Actualizar la informacion adicional del usuario indicado

@Autor : Eduardo Díaz (ediaz)
@Fecha : Septiembre - 2010
@Example: fwk_USER_FuerzaUpdate 'FFMM', 'YCORTES', '1'

*/

BEGIN
	IF EXISTS (
	       SELECT id_user
	       FROM   FWK_USERS
	       WHERE  id_aplicacion     = @IdAplicacion
	              AND id_user       = @IdUser
	   )
	BEGIN
	    -- actualizar la informacion
	    UPDATE FWK_USERS
	    SET    IsLockedOut       = @Locked
	    WHERE  id_aplicacion     = @IdAplicacion
	           AND id_user       = @IdUser
	END
END

GO
