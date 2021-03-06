USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_ROL_Update]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_ROL_Update] 
(
    @IdAplicacion     NVARCHAR(30)
   ,@IdRole           NVARCHAR(30)
   ,@Descripcion      VARCHAR(100)
)
--WITH ENCRYPTION
AS
	/*
Actualizar al role indicado

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_ROL_Update 'FFMM', 'DEVELOPER', 'DEVELOPER'

*/

BEGIN
	IF EXISTS (
	       SELECT id_aplicacion
	       FROM   FWK_ROLES
	       WHERE  id_aplicacion     = @IdAplicacion
	              AND id_role       = @IdRole
	   )
	BEGIN
	    -- actualizar la informacion
	    UPDATE FWK_ROLES
	    SET    descripcion       = @Descripcion
	    WHERE  id_aplicacion     = @IdAplicacion
	           AND id_role       = @IdRole
	END
	ELSE
	BEGIN
	    -- crear la informacion
	    INSERT INTO FWK_ROLES
	      (
	        id_aplicacion
	       ,id_role
	       ,descripcion
	      )
	    VALUES
	      (
	        @IdAplicacion
	       ,@IdRole
	       ,@Descripcion
	      )
	END
END
GO
