USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_ROL_CreateRole]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_ROL_CreateRole]
(@id_aplicacion NVARCHAR(30) ,@id_role NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Crea el role

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_ROL_CreateRole 'FFMM', 'DEVELOPER'

*/

BEGIN
	INSERT INTO FWK_ROLES
	  (
	    id_aplicacion
	   ,id_role
	  )
	VALUES
	  (
	    @id_aplicacion
	   ,@id_role
	  )
END
GO
