USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_GRABAR_INVERSION_CARTERA_PERMANENTE]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEA_GRABAR_INVERSION_CARTERA_PERMANENTE](
				@cSistema	CHAR	(03)	,
				@cProducto	CHAR	(05)	,
				@nNumoper	NUMERIC	(10)	)


AS
BEGIN

   SET TRANSACTION ISOLATION LEVEL READ COMMITTED
   SET DATEFORMAT dmy
   SET NOCOUNT ON

	DECLARE	@nTotalDisponible	NUMERIC	(19,4)	,
		@nMonto			NUMERIC	(19,4)	,
		@nRut_emisor		NUMERIC(9)	,
		@cCarteraSuper		NUMERIC(05)	,
		@nMoneda_Emision 	NUMERIC(03)	,
		@nExceso		NUMERIC(19)	,
		@Inversion_Total	NUMERIC(19)	,
		@Inversion_Ocupado	NUMERIC(19)	,
		@cUsuario       	CHAR	(20)	,
		@dFecPro        	DATETIME	,
		@nCorrLimite		INTEGER


	DECLARE Cursor_INVERSION_INSTRUMENTO SCROLL CURSOR FOR
	SELECT	FechaOperacion		,
		Operador		,
		SUM(MontoTransaccion)
	FROM	LINEA_CHEQUEAR WITH (NOLOCK)
	WHERE	NumeroOperacion	= @nNumoper
	AND	Id_Sistema	= @cSistema
	AND	Codigo_Producto = @cProducto
	AND	codigo_carterasuper = 'P'
	GROUP BY
		FechaOperacion		,
		Operador	

	OPEN Cursor_INVERSION_INSTRUMENTO

	WHILE (1=1)
	BEGIN

		FETCH NEXT FROM Cursor_INVERSION_INSTRUMENTO
		INTO	@dFecPro	,
			@cUsuario       ,
			@nMonto	


		IF (@@fetch_status <> 0)
		BEGIN
			BREAK
		END

		IF @cProducto = 'CP' BEGIN

			SELECT	@nExceso		= 0,
				@Inversion_Total	= Limite_Inversion_Cartera_Asignado,
				@Inversion_Ocupado	= Limite_Inversion_Cartera_Ocupado
			FROM 	datos_limites

			IF @Inversion_Ocupado > @Inversion_Total 			SELECT @nExceso = @nMonto
			ELSE 	IF (@Inversion_Ocupado + @nMonto) > @Inversion_Total	SELECT @nExceso = (@Inversion_Ocupado + @nMonto) - @Inversion_Total

			UPDATE	datos_limites
			SET	Limite_Inversion_Cartera_Ocupado	= Limite_Inversion_Cartera_Ocupado +  @nMonto

			

			IF @nExceso > 0
			BEGIN
				IF NOT EXISTS(	SELECT * FROM LIMITE_TRANSACCION  WITH (NOLOCK)
						WHERE	NumeroOperacion = @nNumoper 
						AND	id_sistema        = @cSistema     
						AND	codigo_producto   = @cProducto
						AND	tipo_control      = 'LINVP') 

					EXEC	SP_LIMITES_GRABAR @dFecPro, @nNumoper, @cSistema, @cProducto, '', 0, @nExceso, 0, @dFecPro, @cUsuario, 'N', 'N','LINVP', 0, 0


				SELECT	@nCorrLimite = 0
				SELECT	@nCorrLimite = (COUNT(*)) + 1
				FROM	LIMITE_TRANSACCION_ERROR  WITH (NOLOCK)
				WHERE	NumeroOperacion = @nNumoper 
				AND	id_sistema        = @cSistema     



				INSERT INTO LIMITE_TRANSACCION_ERROR 
				SELECT	@dFecPro	,
	        			@nNumoper	,
					@cSistema	,
					@cProducto	,
					''		,
					@nExceso	,
					'Operacion Sobrepasa Margen de Instrumentos de Cartera Permanente',
		        	        @nCorrLimite	,
		                	'LINVP'		,
					'CP'

			END


		END ELSE BEGIN
			UPDATE	DATOS_GENERALES
			SET	Limite_Inversion_Cartera_Ocupado	= Limite_Inversion_Cartera_Ocupado -  @nMonto
		END
	
	END

	CLOSE Cursor_INVERSION_INSTRUMENTO
	DEALLOCATE Cursor_INVERSION_INSTRUMENTO

END

GO
