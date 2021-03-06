USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_USR_UpdateProfile]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_USR_UpdateProfile] 
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdUser           NVARCHAR(30)
   ,@Nombres          NVARCHAR(100)
   ,@Apellidos        NVARCHAR(100)
   ,@Cargo            NVARCHAR(60)
   ,@Fono             NVARCHAR(30)
   ,@Rut              INT
   ,@Dv               CHAR(1)
   ,@Vigencia         CHAR(1)
   ,@UserBacinver     VARCHAR(15)
)
AS
	/*
Actualizar la informacion adicional del usuario indicado

@Autor : Gabriel Ponce (gbrel)
@Fecha : Novimebre - 2009
@Modifica : Eduardo Díaz (ediaz)
@Example: EXEC fwk_USR_UpdateProfile 'FFMM', 'GBREL', 'GABRIEL', 'PONCE', 'INFORMATICO', '(2) 687 5625'

*/

BEGIN
	IF EXISTS (
	       SELECT id_user
	       FROM   FWK_USERS_PROFILES
	       WHERE  id_aplicacion     = @IdAplicacion
	              AND id_user       = @IdUser
	   )
	BEGIN
	    -- actualizar la informacion
	    UPDATE FWK_USERS_PROFILES
	    SET    nombres               = @Nombres
	          ,apellidos             = @Apellidos
	          ,cargo                 = @Cargo
	          ,fono                  = @Fono
	          ,rut                   = @Rut
	          ,dv_rut_par            = @Dv
	          ,sw_vigente            = @Vigencia
	          ,fecha_eliminacion     = (
	               CASE 
	                    WHEN @Vigencia = 'N' THEN GETDATE()
	                    ELSE CONVERT(DATETIME ,'19000101')
	               END
	           )
	          ,UserBacinver          = @UserBacinver
	    WHERE  id_aplicacion         = @IdAplicacion
	           AND id_user           = @IdUser
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
	       ,rut
	       ,dv_rut_par
	       ,sw_vigente
	       ,fecha_eliminacion
	       ,UserBacinver
	      )
	    VALUES
	      (
	        @IdAplicacion
	       ,@IdUser
	       ,@Nombres
	       ,@Apellidos
	       ,@Cargo
	       ,@Fono
	       ,@Rut
	       ,@Dv
	       ,@Vigencia
	       ,CONVERT(DATETIME ,'19000101')
	       ,@UserBacinver
	      )
	END
END
GO
