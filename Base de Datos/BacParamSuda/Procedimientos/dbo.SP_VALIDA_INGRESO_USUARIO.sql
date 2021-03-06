USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_VALIDA_INGRESO_USUARIO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--BacParamSuda.dbo.SP_VALIDA_INGRESO_USUARIO 'CABRIL', 'LHTvBR><'


CREATE PROCEDURE [dbo].[SP_VALIDA_INGRESO_USUARIO]
   (	@Usuario		CHAR(15)	
   ,	@Clave			CHAR(15)	= ''
   )
AS
BEGIN
/*
NOMBRE              : dbo.SP_VALIDA_INGRESO_USUARIO.sql
AUTOR               : Cristian Vega Sanhueza.
DESCRIPCION			: Valida la existencia de un usuario creado en el sistema.
FECHA CREACIÓN		: 2017.06.05

HISTÓRICO DE CAMBIOS
FECHA		AUTOR		TAG
----------------------------------------------------------------------------------------------------------------------------------------
2017.06.05	CVS			cvegasan 2017.06.05

*/
	SET NOCOUNT ON

	DECLARE @lc_bloqueado	CHAR(1)
	DECLARE @lc_clave		CHAR(15)
	DECLARE @lc_fec_expira	CHAR(10)

	if exists( select 1 from BacParamSuda.dbo.USUARIO with(nolock) where usuario = @Usuario )
	begin
		SELECT	@lc_bloqueado		= bloqueado
			,	@lc_clave			= clave
			,	@lc_fec_expira		= convert(char(10),Fecha_Expira,103)
		FROM	BacParamSuda.dbo.USUARIO with(nolock)
		WHERE	Usuario				= @Usuario

		IF @lc_bloqueado = '1'
		BEGIN
			SELECT -1, 'No pudo entrar al sistema: usuario bloqueado'
			RETURN -1
		END
		-- '+++cvegasan 2017.06.05 HOM Ex-Itau, se comenta por	Windows Authentication
		/*
		IF @lc_clave <> @Clave
		BEGIN
			SELECT -1, 'Clave Invalida.'
			RETURN -1
		END
		*/
		-- '---cvegasan 2017.06.05 HOM Ex-Itau, se comenta por	Windows Authentication
	end else
	begin
		SELECT -1, '¡ Usuario no se encuentra definido. !'
		RETURN -1
	end

   SELECT	clave				= clave
      ,		 tipo_usuario		= tipo_usuario
      ,		fecha_expira		= convert(char(10),Fecha_Expira,103)
      ,		cambio_clave		= cambio_clave
      ,		dias_expiracion		= dias_expiracion
      ,		largo_clave			= largo_clave
      ,		tipo_clave			= tipo_clave
      ,		FechaExpiraNY			= Fecha_Expira
   FROM		BacParamSuda.dbo.USUARIO with(nolock)
   WHERE	Usuario				= @Usuario

END

GO
