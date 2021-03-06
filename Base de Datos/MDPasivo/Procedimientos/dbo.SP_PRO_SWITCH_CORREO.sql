USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_PRO_SWITCH_CORREO]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_PRO_SWITCH_CORREO]
					(
					@iswitch_operativo	CHAR(30),
					@isistema		CHAR(03)
					)
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

	DECLARE @nTotalRegistros	INTEGER		,
		@nContador		INTEGER	   	,
		@nContadorP		INTEGER	   	,
		@nContadorC		INTEGER	   	,
		@NumeroOperacion	NUMERIC(10)	,
		@cEmailP		CHAR(255)	,
		@cEmailC		CHAR(255)	,
		@cPara			CHAR(255)	,
		@cCC			CHAR(255)	,
		@nLargoP		INTEGER	   	,
		@nLargoC		INTEGER	   	,
		@nPosicionP		INTEGER	   	,
		@nPosicionC		INTEGER	   	,
		@nPosicion_P		INTEGER	   	,
		@nPosicion_C		INTEGER	   	,
		@cUsuarioP		CHAR(255)	,
		@cUsuarioC		CHAR(255)	,
		@cEmail_P		CHAR(255)	,
		@cEmail_C		CHAR(255)	,
		@cPorcion		CHAR(255)

	CREATE TABLE #SWITCH_CORREO
					(
					numero_regla		NUMERIC(10)	,
					nombre_regla		CHAR(100)	,
					para			CHAR(255)	,
					cc			CHAR(255)	,
					otros			CHAR(255)	,
					asunto			CHAR(255)	,
					estado			CHAR(1)		,
					id_sistema		CHAR(3)		,
					opcion_menu		CHAR(30)	,
					estado_control		NUMERIC(10)	,
					emailp			CHAR(255)	,
					emailc			CHAR(255)	,
					descripcion		CHAR(100)	,
					Contador INT IDENTITY(1,1)
					)


		SELECT 	A.numero_regla		,
			B.id_sistema		,
			IDENTITY(INT, 1,1) AS Contador 
		INTO #SWITCH_NUMERO_CORREO
		FROM REGLA_MENSAJE A, REGLA_MENSAJE_DETALLE B
		WHERE 	A.numero_regla = B.numero_regla
		AND	LTRIM(RTRIM(A.estado)) = '0'
		AND	LTRIM(RTRIM(B.opcion_menu))= LTRIM(RTRIM(@iswitch_operativo))
		AND	LTRIM(RTRIM(B.id_sistema))= LTRIM(RTRIM(@isistema))

		SELECT @nTotalRegistros =(SELECT COUNT(*) FROM #SWITCH_NUMERO_CORREO)
		SELECT @nContador = 1

		WHILE @nContador <= @nTotalRegistros
		BEGIN

			
			SET ROWCOUNT @nContador
				SELECT @NumeroOperacion = numero_regla FROM #SWITCH_NUMERO_CORREO WHERE Contador = @nContador
			
			SET ROWCOUNT 0

				INSERT INTO  #SWITCH_CORREO
				SELECT
					A.numero_regla		,
					A.nombre_regla		,
					A.para			,
					A.cc			,
					A.otros			,
					A.asunto		,
					A.estado		,
					B.id_sistema		,
					B.opcion_menu		,
					C.estado_control	,
					' '			,
					' '			,
					C.Descripcion				
				FROM REGLA_MENSAJE A, REGLA_MENSAJE_DETALLE B,SWITCH_OPERATIVO C
				WHERE 	A.numero_regla 	= 	B.numero_regla 
				AND 	A.numero_regla 	= 	@NumeroOperacion
				AND	B.opcion_menu 	= 	C.codigo_control
				AND	C.sistema 	= 	B.id_sistema
			
			SELECT @nContador = @nContador + 1
		END 


		SELECT @nContador = 1

		WHILE @nContador <= @nTotalRegistros
		BEGIN

			SET ROWCOUNT @nContador

				SELECT @NumeroOperacion = numero_regla FROM #SWITCH_NUMERO_CORREO WHERE Contador = @nContador

			SET ROWCOUNT 0

			IF EXISTS(SELECT 1 FROM #SWITCH_CORREO WHERE estado_control = 0 AND numero_regla = @NumeroOperacion)
			BEGIN
				DELETE #SWITCH_CORREO WHERE numero_regla = @NumeroOperacion
			END				


			SELECT @nContador = @nContador + 1
		END 


		SELECT @nContador = 1
		SELECT @nTotalRegistros =(SELECT COUNT(*) FROM #SWITCH_CORREO)
		SELECT @cEmailP = ' '
		SELECT @cEmailC = ' '
		SELECT @cEmail_P = ' '
		SELECT @cEmail_C = ' '

		WHILE @nContador <= @nTotalRegistros
		BEGIN
			
			SET ROWCOUNT @nContador

				SELECT 
					@cPara 	= para ,
					@cCC	= cc
				FROM #SWITCH_CORREO WHERE Contador = @nContador
			
				SELECT @nLargoP = LEN(@cPara)				
				SELECT @nLargoC	= LEN(@cCC)
				SELECT @nContadorP = 1
				SELECT @nContadorC = 1

				WHILE @nContadorP <= @nLargoP
				BEGIN
					SELECT @nPosicionP = CHARINDEX(';', @cPara , @nContadorP)

					IF @nPosicionP = 0
						SELECT @nPosicionP = @nLargoP
					
					IF @nContadorP > 1
						SELECT @nPosicion_P = @nPosicionP - @nContadorP  + 1
					ELSE
						SELECT @nPosicion_P = @nPosicionP



					IF  @nPosicionP = @nLargoP
						SELECT @cUsuarioP = SUBSTRING(@cPara, @nContadorP,@nPosicion_P)
					ELSE
						SELECT @cUsuarioP = SUBSTRING(@cPara, @nContadorP,@nPosicion_P - 1)


					IF @nContadorP = 1
					BEGIN
						SELECT @cEmailP =' '
						EXECUTE SP_COM_EMAIL @cUsuarioP, @cEmailP OUTPUT
							IF LTRIM(RTRIM(@cEmailP)) <> ' '
								SELECT @cEmail_P = LTRIM(RTRIM(@cEmailP))
					END
					ELSE
					BEGIN
						SELECT @cEmailP =' '
						EXECUTE SP_COM_EMAIL @cUsuarioP, @cEmailP OUTPUT
						IF LTRIM(RTRIM(@cEmailP)) <> ' '
							SELECT @cEmail_P = LTRIM(RTRIM(@cEmail_P)) + ';' + LTRIM(RTRIM(@cEmailP))
					END

					SELECT @nContadorP = @nPosicionP + 1
					
				END


				WHILE @nContadorC <= @nLargoC
				BEGIN
					SELECT @nPosicionC = CHARINDEX(';', @cCC , @nContadorC)

					IF @nPosicionC = 0
						SELECT @nPosicionC = @nLargoC
					
					IF @nContadorC > 1
						SELECT @nPosicion_C = @nPosicionC - @nContadorC  + 1
					ELSE
						SELECT @nPosicion_C = @nPosicionC


					IF  @nPosicionC = @nLargoC
						SELECT @cUsuarioC = SUBSTRING(@cCC, @nContadorC,@nPosicion_C)
					ELSE
						SELECT @cUsuarioC = SUBSTRING(@cCC, @nContadorC,@nPosicion_C - 1)

					IF @nContadorC = 1
					BEGIN
						SELECT @cEmailC = ' '
						EXECUTE SP_COM_EMAIL @cUsuarioC, @cEmailC OUTPUT
						IF LTRIM(RTRIM(@cEmailC)) <> ' '
							SELECT @cEmail_C = LTRIM(RTRIM(@cEmailC))
					END
					ELSE
					BEGIN
						SELECT @cEmailC = ' '
						EXECUTE SP_COM_EMAIL @cUsuarioC, @cEmailC OUTPUT
						IF LTRIM(RTRIM(@cEmailC)) <> ' '
							SELECT @cEmail_C = LTRIM(RTRIM(@cEmail_C)) + ';' + LTRIM(RTRIM(@cEmailC))
					END

					SELECT @nContadorC = @nPosicionC + 1
					
				END

				UPDATE #SWITCH_CORREO
				SET
					emailp	= @cEmail_P	,
					emailc	= @cEmail_C
				WHERE Contador = @nContador

			SET ROWCOUNT 0

			SELECT @nContador = @nContador + 1

		END 

	SELECT * FROM #SWITCH_CORREO
END


GO
