USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CONTRATOS_FISICOS_DERIVADOS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_CONTRATOS_FISICOS_DERIVADOS]	(	@Sistema		CHAR(05) = ''
							,	@Codigo			CHAR(10) = ''
							,	@Categoria_Dcto	CHAR(10) = ''
							,	@DocumentoActivo	CHAR(1)  = ''
							)
AS 
BEGIN

	SET NOCOUNT ON

	SELECT	Codigo
	,	Descripcion
	,	Ubicacion
	,	Nombre_Archivo
	,	Indice_Orden
	,	Default_Swap
	,	Default_Forward
	,	Categoria_Dcto
	FROM	TBL_DCTOS_CONTRATOS_DERIVADOS 
	WHERE	(Sistema	= @Sistema		OR @Sistema		= '')
	AND	(Codigo		= @Codigo		OR @Codigo		= '')
	AND 	(Categoria_Dcto	= @Categoria_Dcto	OR @Categoria_Dcto	= '')
	AND	(Activo		= @DocumentoActivo	OR @DocumentoActivo	= '')
	
	ORDER	
	BY	Indice_Orden

	SET NOCOUNT OFF
END
GO
