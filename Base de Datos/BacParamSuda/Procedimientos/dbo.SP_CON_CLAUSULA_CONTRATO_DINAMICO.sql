USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_CLAUSULA_CONTRATO_DINAMICO]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CON_CLAUSULA_CONTRATO_DINAMICO]	(	@Sistema		CHAR(10) 	= '' 
							,	@Tipo_Contrato		CHAR(10)	= ''
							,	@Codigo_Clausula	CHAR(10)	= ''
							,	@Marcador		CHAR(15)	= ''
							,	@ClausulaActiva		CHAR(01)	= ''
							)
AS
BEGIN
	SET NOCOUNT ON

	SELECT	Sistema
	,	Tipo_Contrato
	,	Codigo_Clausula
	,	Glosa1		-- Glosa Corta
	,	Glosa2		-- Glosa Completa
	,	Marcador
	,	Indice_Orden
	,	Por_Defecto
	,	Utiliza_Aval
	,	Activa
	FROM	TBL_CLAUSULAS
	WHERE	(Sistema	 	= @Sistema		OR @Sistema		= '')
	AND	(Tipo_Contrato		= @Tipo_Contrato	OR @Tipo_Contrato	= '')
	AND 	(Codigo_Clausula	= @Codigo_Clausula	OR @Codigo_Clausula	= '')
	AND	(Marcador		= @Marcador		OR @Marcador		= '')
	AND	(Activa			= @ClausulaActiva	OR @ClausulaActiva	= '')
	ORDER
	BY	Marcador
	,	Indice_Orden

	SET NOCOUNT OFF
END
GO
