USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_PRIVILEGIO_MENU_USUARIO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_PRIVILEGIO_MENU_USUARIO]
	(
		@Habilitado	CHAR(8),
		@Usuario	CHAR(20)
	)
AS
BEGIN
	SET NOCOUNT ON

		SELECT     	GPR.usuario
		,		USU.nombre 	
		, 		SIS.nombre_sistema	
		, 		GME.nombre_opcion
		, 		GPR.opcion
		,		GPR.habilitado

		FROM         	GEN_PRIVILEGIOS GPR	
		,		USUARIO		USU
		,		GEN_MENU	GME
		,		SISTEMA_CNT	SIS

		WHERE        	(GPR.usuario 	= @Usuario OR @Usuario = 'TODOS') 
		AND 		(GPR.habilitado = @Habilitado OR @Habilitado = 'TODOS')
		AND		GPR.usuario 	= USU.usuario 
		AND		GPR.opcion 	= GME.nombre_objeto 
		AND 		GPR.entidad 	= GME.entidad 
		AND		GPR.entidad 	= SIS.id_sistema


	SET NOCOUNT OFF
END

GO
