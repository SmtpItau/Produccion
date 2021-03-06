USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_UpdateFailedPassword]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_UpdateFailedPassword]
(
    @IdAplicacion                   NVARCHAR(30)
   ,@IdUser                         NVARCHAR(30)
   ,@FailureType                    INT
   ,@PasswordAttempWindow           INT
   ,@MaxInvalidPasswordAttempts     INT
)
--WITH ENCRYPTION
AS
	/*
Actualiza los intentos de conexion fallidos

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_USR_UpdateFailedPassword ...

*/

BEGIN
	DECLARE @failureCount INT
	       ,@windowStart DATETIME
	       ,@windowEnd DATETIME;
	
	IF (@FailureType = 1)
	BEGIN
	    SELECT @failureCount = FailedPasswordAttemptCount
	          ,@windowStart      = FailedPasswordAttemptWindowStart
	    FROM   FWK_USERS
	    WHERE  id_aplicacion     = @IdAplicacion
	           AND id_user       = @IdUser
	END
	ELSE 
	IF (@FailureType = 2)
	BEGIN
	    SELECT @failureCount = FailedPasswordAnswerAttemptCount
	          ,@windowStart      = FailedPasswordAnswerAttemptWindowStart
	    FROM   FWK_USERS
	    WHERE  id_aplicacion     = @IdAplicacion
	           AND id_user       = @IdUser
	END
	
	SET @windowEnd = DATEADD(minute ,@PasswordAttempWindow ,@windowStart)
	
	IF ((@FailureType = 0) OR (GETDATE() > @windowEnd))
	BEGIN
	    IF (@failureType = 1)
	    BEGIN
	        UPDATE FWK_USERS
	        SET    FailedPasswordAttemptCount = 1
	              ,FailedPasswordAttemptWindowStart = GETDATE()
	        WHERE  id_aplicacion     = @IdAplicacion
	               AND id_user       = @IdUser
	    END
	    ELSE 
	    IF (@FailureType = 2)
	    BEGIN
	        UPDATE FWK_USERS
	        SET    FailedPasswordAnswerAttemptCount = 1
	              ,FailedPasswordAnswerAttemptWindowStart = GETDATE()
	        WHERE  id_aplicacion     = @IdAplicacion
	               AND id_user       = @IdUser
	    END
	END
	ELSE
	BEGIN
	    SET @failureCount = @failureCount + 1;
	    
	    IF (@failureCount >= @MaxInvalidPasswordAttempts)
	    BEGIN
	        UPDATE FWK_USERS
	        SET    IsLockedOut           = 1
	              ,LastLockedOutDate     = GETDATE()
	        WHERE  id_aplicacion         = @IdAplicacion
	               AND id_user           = @IdUser
	    END
	    ELSE
	    BEGIN
	        IF (@FailureType = 1)
	        BEGIN
	            UPDATE FWK_USERS
	            SET    FailedPasswordAttemptCount = @failureCount
	            WHERE  id_aplicacion     = @IdAplicacion
	                   AND id_user       = @IdUser
	        END
	        ELSE 
	        IF (@FailureType = 2)
	        BEGIN
	            UPDATE FWK_USERS
	            SET    FailedPasswordAnswerAttemptCount = @failureCount
	            WHERE  id_aplicacion     = @IdAplicacion
	                   AND id_user       = @IdUser
	        END
	    END
	END
END

GO
