USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_BUSCA_EVENTO_MENU]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_BUSCA_EVENTO_MENU]
	(
		@ID_SISTEMA	CHAR(05)
	,	@COD_EVENTO	CHAR(30)
	,	@Cod_Usu	CHAR(20) = ''
	)
AS
BEGIN
	SET NOCOUNT ON

	SELECT	DISTINCT 
		LA.Codigo_Evento 
	,	LE.descripcion
 	FROM	log_auditoria	LA WITH(NOLOCK)	LEFT JOIN LOG_EVENTO LE WITH(NOLOCK)
					ON 	LE.codigo_evento = LA.Codigo_Evento

	WHERE	(Id_Sistema	= @ID_SISTEMA	OR @ID_SISTEMA = 'TODOS')
	AND	CodigoMenu	= SUBSTRING(@COD_EVENTO,1,12)
	AND	(Usuario	= @Cod_Usu	OR @Cod_Usu = 'TODOS')
	ORDER
	BY	LE.descripcion

	SET NOCOUNT OFF
END
GO
