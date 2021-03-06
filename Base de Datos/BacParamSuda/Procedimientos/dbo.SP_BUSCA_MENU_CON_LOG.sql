USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_MENU_CON_LOG]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_BUSCA_MENU_CON_LOG]	
					(	@Usuario	CHAR(20)
					,	@Sistema	CHAR(30) 
					)
AS

BEGIN
	SET NOCOUNT ON


	SELECT  DISTINCT   
		MEN.entidad
	, 	MEN.nombre_objeto
	,	MEN.nombre_opcion
	FROM	GEN_MENU	MEN	WITH(NOLOCK)	
	WHERE	(MEN.entidad		= @Sistema	OR @Sistema = 'TODOS')
	AND	EXISTS((SELECT 1 FROM Log_Auditoria LA WITH(NOLOCK)
			WHERE	LA.Id_Sistema	= MEN.entidad
			AND	LA.CodigoMenu	= SUBSTRING(MEN.nombre_objeto,1,12)
			AND	(LA.usuario	= @Usuario	OR @Usuario = 'TODOS')))
	ORDER 
	BY MEN.entidad

	SET NOCOUNT OFF
END
GO
