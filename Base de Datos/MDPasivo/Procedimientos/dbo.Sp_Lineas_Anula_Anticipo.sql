USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Lineas_Anula_Anticipo]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[Sp_Lineas_Anula_Anticipo]
			(	@csistema	CHAR	(03)	,
				@nnumoper	NUMERIC	(10,0)	)
AS BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
	SET DATEFORMAT dmy
	SET NOCOUNT ON

	DECLARE @nnumdocu		NUMERIC	(10)
	DECLARE @ncorrela		NUMERIC	(3)
	DECLARE @ccodigo_grupo		CHAR	(10)	,
		@cTranssaccion		CHAR	(15)	,
		@nRutcli		NUMERIC	(09,0)	,
		@nCodigo		NUMERIC	(09,0)	,
		@nmontotransaccion	NUMERIC	(19,4)	,
		@nPlazoDesde		NUMERIC	(09,0)	,
		@nPlazoHasta		NUMERIC	(09,0)



	DECLARE cursor_Anu SCROLL CURSOR FOR
	SELECT 	NumeroDocumento		,
		NumeroCorrelativo	,
		codigo_grupo		,
		Linea_Transsaccion	,
		MontoTransaccion	,
		PlazoDesde		,
		PlazoHasta		
	FROM	LINEA_TRANSACCION_DETALLE  WITH (NOLOCK)
	WHERE	NumeroOperacion 	= @nNumoper
	AND	Id_Sistema		= @csistema
	AND	Tipo_Detalle		= 'L'
	AND	Tipo_Movimiento		= 'R'




	OPEN cursor_Anu

	WHILE (1=1) BEGIN

		FETCH NEXT FROM cursor_Anu 
		INTO	@nnumdocu		,
			@ncorrela		,
			@ccodigo_grupo		,
			@cTranssaccion		,
			@nmontotransaccion	,
			@nPlazoDesde		,
			@nPlazoHasta		




		IF (@@fetch_status <> 0) BEGIN
			BREAK
		END


		SELECT	@nRutcli = Rut_cliente	,
			@nCodigo = Codigo_cliente
		FROM	LINEA_TRANSACCION  WITH (NOLOCK)
		WHERE	NumeroOperacion		= @nNumoper
		AND	NumeroDocumento		= @nnumdocu
		AND	NumeroCorrelativo	= @ncorrela
		AND	Id_Sistema 		= @csistema


		SELECT	@nmontotransaccion=ABS(@nmontotransaccion)




		EXECUTE sp_lineas_aumenta	@cSistema		,
						@nNumoper		,
						@nNumdocu		,
						@nCorrela		,
						@ccodigo_grupo		,
						@cTranssaccion		,
						@nRutcli		,
						@nCodigo		,
						@nmontotransaccion	,
						@nPlazoDesde		,
						@nPlazoHasta		


	END

	CLOSE cursor_Anu
	DEALLOCATE cursor_Anu


	DELETE 	LINEA_TRANSACCION_DETALLE WITH (ROWLOCK)
	WHERE	NumeroOperacion 	= @nNumoper
	AND	Id_Sistema		= @csistema
	AND	Tipo_Detalle		= 'L'
	AND	Tipo_Movimiento		= 'R'


	EXECUTE SP_LINEAS_ACTUALIZA  


	SET NOCOUNT OFF

END




GO
