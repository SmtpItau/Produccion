USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USER_UpdateProfile]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USER_UpdateProfile] 
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdUser           NVARCHAR(30)
   ,@Nombres          NVARCHAR(100)
   ,@Apellidos        NVARCHAR(100)
   ,@Cargo            NVARCHAR(60)
   ,@Fono             NVARCHAR(30)
)
--WITH ENCRYPTION
AS
	/*
Actualizar la informacion adicional del usuario indicado

@Autor : Gabriel Ponce (gbrel)
@Fecha : Novimebre - 2009
@Example: EXEC fwk_USER_UpdateProfile 'FFMM', 'GBREL', 'GABRIEL', 'PONCE', 'INFORMATICO', '(2) 687 5625'

*/

BEGIN
	IF (
	       EXISTS (
	           SELECT id_user
	           FROM   FWK_USERS_PROFILES
	           WHERE  id_aplicacion     = @IdAplicacion
	                  AND id_user       = @IdUser
	       )
	   )
	BEGIN
	    -- actualizar la informacion
	    UPDATE FWK_USERS_PROFILES
	    SET    nombres           = @Nombres
	          ,apellidos         = @Apellidos
	          ,cargo             = @Cargo
	          ,fono              = @Fono
	    WHERE  id_aplicacion     = @IdAplicacion
	           AND id_user       = @IdUser
	END
	ELSE
	BEGIN
	    -- crear la informacion
	    INSERT INTO FWK_USERS_PROFILES
	      (
	        id_aplicacion
	       ,id_user
	       ,nombres
	       ,apellidos
	       ,cargo
	       ,fono
	      )
	    VALUES
	      (
	        @IdAplicacion
	       ,@IdUser
	       ,@Nombres
	       ,@Apellidos
	       ,@Cargo
	       ,@Fono
	      )
	END
END
GO
