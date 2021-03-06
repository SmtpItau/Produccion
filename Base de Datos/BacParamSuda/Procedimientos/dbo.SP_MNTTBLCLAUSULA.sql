USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_MNTTBLCLAUSULA]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_MNTTBLCLAUSULA](
	@TipoAccion		CHAR(1),
	@Sistema		CHAR(5), 
	@Tipo_Contrato		CHAR(5),
	@Marcador		CHAR(15),
	@Codigo_Clausula	CHAR(5),
	@Glosa1			CHAR(50),
	@Glosa2			TEXT,
	@Indice_Orden		NUMERIC(3,0),
	@Por_Defecto		CHAR(1),
	@Utiliza_Aval		CHAR(1),
	@Clausula_Activa	CHAR(1))

AS
BEGIN
	SET NOCOUNT ON

	IF @TipoAccion = 'I' BEGIN
		UPDATE	TBL_CLAUSULAS
		SET	MARCADOR	= @Marcador
		,	GLOSA1		= @Glosa1
		,	GLOSA2		= @Glosa2
		,	INDICE_ORDEN	= @Indice_Orden
		,	POR_DEFECTO	= @Por_Defecto
		,	UTILIZA_AVAL	= @Utiliza_Aval
		,	Activa		= @Clausula_Activa
		WHERE	SISTEMA		= @Sistema
		AND	TIPO_CONTRATO	= @Tipo_Contrato
		AND	CODIGO_CLAUSULA	= @Codigo_Clausula
		
		IF @@ROWCOUNT = 0 BEGIN
			INSERT INTO TBL_CLAUSULAS
			(	SISTEMA
			,	TIPO_CONTRATO
			,	MARCADOR
			,	CODIGO_CLAUSULA
			,	GLOSA1
			,	GLOSA2
			,	INDICE_ORDEN
			,	POR_DEFECTO
			,	UTILIZA_AVAL
			,	Activa
			)
			VALUES	
			(	@Sistema
			,	@Tipo_Contrato
			,	@Marcador
			,	@Codigo_Clausula
			,	@Glosa1
			,	@Glosa2
			,	@Indice_Orden
			,	@Por_Defecto
			,	@Utiliza_Aval
			,	@Clausula_Activa
			)

			IF @@ERROR <> 0	BEGIN
				SELECT -1, 'Error: al Ingresar Clausula'
				RETURN 
			END
		END

		SELECT 'OK'
	END

	IF @TipoAccion = 'D'
	BEGIN
		DELETE	TBL_CLAUSULAS
		WHERE	LTRIM(SISTEMA)	 	= LTRIM(@Sistema)
		AND	TIPO_CONTRATO		= @Tipo_Contrato
		AND 	LTRIM(CODIGO_CLAUSULA)	= LTRIM(@Codigo_Clausula)

		SELECT 'OK'
		IF @@ERROR <> 0
		BEGIN
			SELECT -2, 'Error: al Eliminar Clausula'
			RETURN 
		END
	END

	IF @TipoAccion = 'U'
	BEGIN
		IF (SELECT count(1) FROM TBL_CLAUSULAS
				WHERE	LTRIM(SISTEMA)	 	= LTRIM(@Sistema)
				AND	TIPO_CONTRATO		= @Tipo_Contrato
				AND 	LTRIM(CODIGO_CLAUSULA)	= LTRIM(@Codigo_Clausula )) >= 1
			SELECT 1
		ELSE
			SELECT 0
		IF @@ERROR <> 0
		BEGIN
			SELECT -4, 'Error: al Listar Clausulas'
			RETURN 
		END
	END

	IF @TipoAccion = 'G'
	BEGIN
		IF (SELECT count(1) FROM TBL_CLAUSULAS
		WHERE	LTRIM(SISTEMA)	 	= LTRIM(@Sistema)
		AND	TIPO_CONTRATO		= @Tipo_Contrato
		AND 	LTRIM(Glosa1)	= LTRIM(@GLOSA1)) >= 1
			SELECT 1
		ELSE
			SELECT 0
		IF @@ERROR <> 0
		BEGIN
			SELECT -4, 'Error: al Listar Clausulas'
			RETURN 
		END
	END

	SET NOCOUNT OFF
END

GO
