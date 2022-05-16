USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LIMITES_CONSULTAOPERACION]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LIMITES_CONSULTAOPERACION]
AS
BEGIN

	DECLARE @dFecPro 	DATETIME	,
		@cProducto	CHAR	(05)	,
		@nCodInst	NUMERIC	(05,0)	,
		@nMonto		NUMERIC	(19,4)	,
		@dFecvctop	DATETIME	,
		@cUsuario	CHAR	(15)	,
		@cCheckLimOp	CHAR	(1)	,
		@cCheckLimInst	CHAR	(1)



	DECLARE @nCorrDet	Integer,
		@cMensaje	VARCHAR(255),
		@cError 	VARCHAR(1),
		@cTipInst	CHAR(12)

	DECLARE	@nMontLimIni	NUMERIC(19,04),
		@nMontLimVen	NUMERIC(19,04),
		@nExceso	NUMERIC(19,04)


	SELECT @nCorrDet = 0


	DECLARE Cursor_Lim SCROLL CURSOR FOR
	SELECT	FechaOperacion,
		Codigo_Producto,
		InCodigo,
		SUM(MontoTransaccion),
		MAX(FechaVencimiento),
		Operador,
		Check_Operacion,
		Check_Instrumento 
	FROM	#Temp_LIMITE_TRANSACCION
	GROUP BY
		FechaOperacion,
		Codigo_Producto,
		InCodigo,
		Operador,
		Check_Operacion,
		Check_Instrumento
--select *  FROM	#Temp_LIMITE_TRANSACCION

	OPEN Cursor_Lim

	WHILE (1=1)
	BEGIN

		FETCH NEXT FROM cursor_Lim
		INTO	@dFecPro	,
			@cProducto	,
			@nCodInst	,
			@nMonto		,
			@dFecvctop	,
			@cUsuario	,
			@cCheckLimOp	,
			@cCheckLimInst

		IF (@@fetch_status <> 0)
		BEGIN
			BREAK
		END


		--*************************************
		--*************** INICIO LIMITES OP.***
-- select * from VIEW_MATRIZ_ATRIBUCION
		IF @cCheckLimOp = 'S'
		BEGIN

			SELECT @cMensaje = ''

			IF EXISTS(SELECT * FROM VIEW_MATRIZ_ATRIBUCION WHERE Usuario = @cUsuario AND Codigo_Producto  = @cProducto)
			BEGIN

				SELECT	@nMontLimIni	= 0,
					@nMontLimVen	= 0

				SELECT	@nMontLimIni	= MontoInicio,
					@nMontLimVen	= MontoFinal
				FROM	VIEW_MATRIZ_ATRIBUCION
				WHERE	Usuario		= @cUsuario
				AND	Codigo_Producto	= @cProducto
				AND	Plazo_Desde    <= DATEDIFF(day, @dFecPro, @dFecvctop)
				AND	Plazo_Hasta    >= DATEDIFF(day, @dFecPro, @dFecvctop)

				IF @nMontLimIni > @nMonto
					SELECT  @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Monto No Alcanza a cubrir Minimo de Operación en',
						@nExceso  = @nMontLimIni - @nMonto

				IF @nMontLimVen < @nMonto
					SELECT  @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Monto Sobrepasa Maximo de Operación en ',
						@nExceso  = @nMonto - @nMontLimVen

			END ELSE
			BEGIN

				SELECT  @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Usuario no tiene Privilegios para esta Operación '	,
					@nExceso  = 0							

			END


			IF @cMensaje <> ''
			BEGIN

				SELECT @nCorrDet = @nCorrDet + 1

				INSERT INTO #Tmp_Error
				SELECT	'LIM'		,
					@nCorrDet	,
					@cMensaje	,
					@nExceso

			END

		END

		--*************************************
		--*************** FIN LIMITES OP.******




		--*************************************
		--********** INICIO LIMITES OP.INST ***

		IF @cCheckLimInst = 'S'
		BEGIN

			SELECT 	@cMensaje = ''

			SELECT	@cTipInst = inserie
			FROM	VIEW_INSTRUMENTO
			WHERE	incodigo = @nCodInst
		

			IF EXISTS(SELECT * FROM VIEW_MATRIZ_ATRIBUCION_INSTRUMENTO WHERE Usuario = @cUsuario AND Codigo_Producto  = @cProducto AND Incodigo = @nCodInst)
			BEGIN

				SELECT	@nMontLimIni = 0,
					@nMontLimVen = 0,


					@nMontLimVen = MontoFinal
				FROM	VIEW_MATRIZ_ATRIBUCION_INSTRUMENTO
				WHERE	Usuario 	= @cUsuario
				AND	Codigo_Producto = @cProducto
				AND	Incodigo	= @nCodInst
				AND	Plazo_Desde    <= DATEDIFF(day, @dFecPro, @dFecvctop)
				AND	Plazo_Hasta    >= DATEDIFF(day, @dFecPro, @dFecvctop)


				IF @nMontLimIni > @nMonto
					SELECT  @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Monto No Alcanza a cubrir Minimo de Instrumento ' + RTRIM(LTRIM(@cTipInst)) +' en',
						@nExceso  = @nMontLimIni - @nMonto

				IF @nMontLimVen < @nMonto
					SELECT  @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Monto Sobrepasa Maximo de Instrumento ' + RTRIM(LTRIM(@cTipInst)) +' en',
						@nExceso  = @nMonto - @nMontLimVen

			END ELSE
			BEGIN

				SELECT  @cMensaje = RTRIM(LTRIM(@cUsuario)) + ': Usuario no tiene Privilegios para Instrumento ' + @cTipInst	,
					@nExceso  = 0

			END


			IF @cMensaje <> ''
			BEGIN

				SELECT @nCorrDet = @nCorrDet + 1

				INSERT INTO #Tmp_Error
				SELECT	'LIM'		,
					@nCorrDet	,
					@cMensaje	,
					@nExceso

			END

		END

		--*************************************
		--********** FIN LIMITES OP.INST ******


	END


	CLOSE Cursor_Lim
	DEALLOCATE Cursor_Lim


END

GO
