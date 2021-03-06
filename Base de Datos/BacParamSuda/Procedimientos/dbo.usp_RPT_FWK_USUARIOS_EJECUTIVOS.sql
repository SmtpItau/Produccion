USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[usp_RPT_FWK_USUARIOS_EJECUTIVOS]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[usp_RPT_FWK_USUARIOS_EJECUTIVOS]
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
	EXEC usp_RPT_FWK_USUARIOS_EJECUTIVOS   '20081124', 'FFMM'
	*/
	
	--================================================================
	-- USUARIO  - INFORMACION «USUARIOS - EJECUTIVOS»
	--================================================================
	SELECT FWK_APLICACIONES.descripcion  AS aplicacion
	      ,FWK_USERS.id_user 
	       -- SI ES EJECUTIVO USAR ESOS NOMBRES
	      ,FWK_USERS_PROFILES.nombres + ' ' + FWK_USERS_PROFILES.apellidos AS 
	       descripcion
	      ,FWK_USERS.LastLoginDate
	      ,FWK_USERS.LastPasswordChangedDate
	      ,FWK_USERS.IsLockedOut
	      ,FWK_USERS.IsApproved
	      ,0                             AS id_ejecutivo
	      ,CONVERT(VARCHAR(10) ,FWK_USERS_PROFILES.rut) 
	       + '-' + FWK_USERS_PROFILES.dv_rut_par AS rut
	       --   , CONVERT(VARCHAR(10),FMP_EJECUTIVOS.rut_ejecutivo) + '-' + FMP_EJECUTIVOS.dv_rut_ejec as rut
	      ,0                             AS id_sucursal
	      ,'S' AS                           IsVigente
	      ,STUFF(
	           (
	               SELECT ',' + A.id_role
	               FROM   FWK_USERS_ROLES A
	                      INNER JOIN FWK_SITEMAP_ROLES B
	                           ON  A.id_aplicacion = B.id_aplicacion
	                               AND A.id_role = B.id_role
	               WHERE  A.id_aplicacion = FWK_APLICACIONES.id_aplicacion
	                      AND A.id_user = FWK_USERS.id_user
	               GROUP BY
	                      A.id_role FOR XML PATH('')
	           )
	          ,1
	          ,1
	          ,''
	       )                             AS roles
	      ,0                             AS IsEjecutivo
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
	GROUP BY
	       FWK_APLICACIONES.id_aplicacion
	      ,FWK_APLICACIONES.descripcion
	      ,FWK_USERS.id_user
	      ,(
	           FWK_USERS_PROFILES.nombres + ' ' + FWK_USERS_PROFILES.apellidos
	       )
	      ,FWK_USERS.LastLoginDate
	      ,FWK_USERS.LastPasswordChangedDate
	      ,FWK_USERS.IsLockedOut
	      ,FWK_USERS.IsApproved
	      ,FWK_USERS_PROFILES.rut
	      ,FWK_USERS_PROFILES.dv_rut_par
	ORDER BY
	       FWK_USERS.id_user
END
GO
