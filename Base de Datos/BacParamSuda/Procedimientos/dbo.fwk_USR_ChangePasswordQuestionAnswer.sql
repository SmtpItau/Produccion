USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_ChangePasswordQuestionAnswer]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_ChangePasswordQuestionAnswer]
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdUser           NVARCHAR(30)
   ,@Question         NVARCHAR(255)
   ,@Answer           NVARCHAR(255)
)
--WITH ENCRYPTION
AS
	/*
Modifica pregunta y respuesta utilizada para recupera la contraseña

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_ChangePasswordQuestionAnswer ...

*/


BEGIN
	UPDATE FWK_USERS
	SET    PasswordQuestion     = @Question
	      ,PasswordAnswer       = @Answer
	WHERE  id_aplicacion        = @IdAplicacion
	       AND id_user          = @IdUser
END

GO
