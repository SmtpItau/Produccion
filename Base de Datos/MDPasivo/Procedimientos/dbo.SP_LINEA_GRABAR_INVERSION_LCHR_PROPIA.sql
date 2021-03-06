USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEA_GRABAR_INVERSION_LCHR_PROPIA]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEA_GRABAR_INVERSION_LCHR_PROPIA](
				@cSistema	CHAR	(03)	,
				@cProducto	CHAR	(05)	,
				@nNumoper	NUMERIC	(10)	)

AS
BEGIN
	SET TRANSACTION ISOLATION LEVEL READ COMMITTED 
	SET NOCOUNT ON
	SET DATEFORMAT dmy

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
	FROM	LINEA_CHEQUEAR WITH (NOLOCK INDEX=IX_LINEA_CHEQUEAR)
	WHERE	NumeroOperacion	= @nNumoper
	AND	Id_Sistema	= @cSistema
	AND	Codigo_Producto = @cProducto
	AND	incodigo        = 20
	AND	Rut_Emisor	= 97032000
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
				@Inversion_Total	= Total_Cartera_Lchr,
				@Inversion_Ocupado	= Total_Cartera_Lchr_Ocupado
			FROM 	datos_limites  WITH (NOLOCK)


			IF @Inversion_Ocupado > @Inversion_Total 			SET @nExceso = @nMonto
			ELSE 	IF (@Inversion_Ocupado + @nMonto) > @Inversion_Total	SET @nExceso = (@Inversion_Ocupado + @nMonto) - @Inversion_Total



			UPDATE	datos_limites
			SET	Total_Cartera_Lchr_Ocupado	= Total_Cartera_Lchr_Ocupado +  @nMonto

			

			IF @nExceso > 0
			BEGIN
				IF NOT EXISTS(	SELECT COUNT(1) FROM LIMITE_TRANSACCION WITH(NOLOCK) 
						WHERE	NumeroOperacion = @nNumoper 
						AND	id_sistema        = @cSistema     
						AND	codigo_producto   = @cProducto
						AND	tipo_control      = 'CLCHR') 

					EXEC	SP_LIMITES_GRABAR @dFecPro, @nNumoper, @cSistema, @cProducto, '', 0, @nExceso, 0, @dFecPro, @cUsuario, 'N', 'N','CLCHR', 0, 0



				SET	@nCorrLimite = 0
				SELECT	@nCorrLimite = (COUNT(*)) + 1
				FROM	LIMITE_TRANSACCION_ERROR WITH(NOLOCK)
				WHERE	NumeroOperacion = @nNumoper 
				AND	id_sistema        = @cSistema     



	
				INSERT INTO LIMITE_TRANSACCION_ERROR 
				VALUES(	@dFecPro	,
	        			@nNumoper	,
					@cSistema	,
					@cProducto	,
					''		,
					@nExceso	,
					'Operacion Sobrepasa Margen de Letras Hipotecarias Propia Emision',
		        	        @nCorrLimite	,
		                	'CLCHR'		,
					'LP' )		

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
