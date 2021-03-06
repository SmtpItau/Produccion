USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[usp_RPT_FWK_ROLES_USUARIOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_RPT_FWK_ROLES_USUARIOS]
	@fchProceso DATETIME = '20081124'
	 ,
	@IdAplicacion NVARCHAR(30) = 'FFMM'
	 --WITH ENCRYPTION
AS
BEGIN
	/*
	Procedimiento destinado al reporte que lleva su nombre
	
	@Autor       : Gabriel Ponce (gbrel)
	@Fecha     : Abril 2010
	@Example  :
	EXEC usp_RPT_FWK_ROLES_USUARIOS  '20081124', 'FFMM'
	*/
	
	--================================================================
	-- USUARIO  - INFORMACION «USUARIOS AGRUPADOS X ROLE»
	--================================================================
	SELECT FWK_APLICACIONES.descripcion  AS aplicacion
	      ,FWK_ROLES.id_role
	      ,FWK_USERS.id_user 
	      ,FWK_USERS_PROFILES.nombres + ' ' + FWK_USERS_PROFILES.apellidos AS descripcion
	      ,FWK_USERS_PROFILES.FONO AS fono
	      ,FWK_USERS.email AS email
	      ,FWK_USERS.LastLoginDate
	      ,FWK_USERS.LastPasswordChangedDate
	      ,FWK_USERS.IsLockedOut
	      ,FWK_USERS.IsApproved
	      ,0  AS id_ejecutivo
	      ,CONVERT(VARCHAR(10) ,FWK_USERS_PROFILES.rut) 
	                 + '-' + FWK_USERS_PROFILES.dv_rut_par AS rut
	      ,0  AS id_sucursal
	      ,case FWK_USERS_PROFILES.sw_vigente WHEN 'N' THEN 0 ELSE 1 END AS IsVigente
	FROM   FWK_APLICACIONES
	       INNER JOIN FWK_ROLES
	            ON  FWK_APLICACIONES.id_aplicacion = FWK_ROLES.id_aplicacion
	       INNER JOIN FWK_USERS_ROLES
	            ON  FWK_ROLES.id_aplicacion = FWK_USERS_ROLES.id_aplicacion
	                AND FWK_ROLES.id_role = FWK_USERS_ROLES.id_role
	       INNER JOIN FWK_USERS
	            ON  FWK_USERS_ROLES.id_aplicacion = FWK_USERS.id_aplicacion
	                AND FWK_USERS_ROLES.id_user = FWK_USERS.id_user
	       INNER JOIN FWK_USERS_PROFILES
	            ON  FWK_USERS.id_aplicacion = FWK_USERS_PROFILES.id_aplicacion
	                AND FWK_USERS.id_user = FWK_USERS_PROFILES.id_user
	WHERE  FWK_ROLES.id_role <> FWK_APLICACIONES.fixed_role
	       AND FWK_USERS.id_user <> FWK_APLICACIONES.fixed_user
	       AND FWK_APLICACIONES.id_aplicacion = @IdAplicacion
	ORDER BY
	       FWK_ROLES.id_role
	      ,FWK_USERS.id_user
END

GO
