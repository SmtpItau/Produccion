USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_Create]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_Create]
(
    @IdAplicacion         NVARCHAR(30)
   ,@IdUser               NVARCHAR(30)
   ,@Password             NVARCHAR(128)
   ,@Email                NVARCHAR(255)
   ,@PasswordQuestion     NVARCHAR(255)
   ,@PasswordAnswer       NVARCHAR(255)
   ,@IsApproved           BIT
   ,@Comment              NVARCHAR(255)
)
--WITH ENCRYPTION
AS
	/*
Crea al usuario

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_Create ...

*/

BEGIN
	DECLARE @dateStamp DATETIME
	SET @dateStamp = GETDATE()
	
	INSERT INTO FWK_USERS
	  (
	    id_aplicacion
	   ,id_user
	   ,[Password]
	   ,Email
	   ,PasswordQuestion
	   ,PasswordAnswer
	   ,IsApproved
	   ,Comment
	   ,CreationDate
	   ,LastPasswordChangedDate
	   ,LastActivityDate
	   ,IsLockedOut
	   ,LastLockedOutDate
	   ,FailedPasswordAttemptCount
	   ,FailedPasswordAttemptWindowStart
	   ,FailedPasswordAnswerAttemptCount
	   ,FailedPasswordAnswerAttemptWindowStart
	  )
	VALUES
	  (
	    @IdAplicacion
	   ,@IdUser
	   ,@Password
	   ,@Email
	   ,@PasswordQuestion
	   ,@PasswordAnswer
	   ,@IsApproved
	   ,@Comment
	   ,@dateStamp
	   ,@dateStamp
	   ,@dateStamp
	   ,0	/*False*/
	   ,NULL
	   ,0
	   ,NULL
	   ,0
	   ,NULL
	  )
END
GO
