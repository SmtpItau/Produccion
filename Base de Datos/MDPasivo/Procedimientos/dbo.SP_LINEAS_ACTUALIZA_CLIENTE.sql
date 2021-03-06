USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_ACTUALIZA_CLIENTE]    Script Date: 16-05-2022 11:18:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_ACTUALIZA_CLIENTE]( 	@nRutCli	NUMERIC(09),
							@nCodigo	NUMERIC(03))
AS
BEGIN

	SET TRANSACTION ISOLATION LEVEL READ COMMITTED
SET DATEFORMAT dmy
SET NOCOUNT ON

	DECLARE	@nContador	NUMERIC(09)
	DECLARE @nTotal		INTEGER
	DECLARE	@encontro	CHAR(01)
	DECLARE	@Transaccion	CHAR(10)
	DECLARE	@Grupo		CHAR(10)
	DECLARE	@MONTO 		NUMERIC(19,04)
	DECLARE	@Plazo		NUMERIC(09)


	UPDATE	LINEA_GENERAL WITH (ROWLOCK)
	SET	TotalOcupado		= 0,
		TotalTraspaso		= 0,
		TotalRecibido		= 0
	WHERE	rut_cliente		= @nRutCli
	AND     Codigo_cliente 	 	= @nCodigo

	UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
	SET	TotalOcupado		= 0,
		TotalTraspaso		= 0,
		TotalRecibido		= 0,
		SinRiesgoOcupado	= 0,
		ConRiesgoOcupado	= 0
	WHERE	rut_cliente		= @nRutCli
	AND     Codigo_cliente 	 	= @nCodigo

	UPDATE	LINEA_POR_PLAZO WITH (ROWLOCK)
	SET	TotalOcupado		= 0,
		TotalTraspaso		= 0,
		TotalRecibido		= 0,
		ConRiesgoOcupadO	= 0,
		SinRiesgoOcupado	= 0
	WHERE	rut_cliente		= @nRutCli
	AND     Codigo_cliente 	 	= @nCodigo


	SELECT	Transaccion	= Linea_Transsaccion,
		Grupo		= A.Codigo_Grupo,
		MONTO 		= SUM(b.MontoTransaccion),
		Plazo		= CASE WHEN Linea_Transsaccion IN ('LINGEN', 'LINSIS', 'LINSCR','LINSSR' ) THEN 0 ELSE datediff(day, FechaInicio,FechaVencimiento) END,
		contador	= IDENTITY(numeric(9), 1,1)
	into #temp1
	FROM	LINEA_TRANSACCION		A WITH (NOLOCK),
		LINEA_TRANSACCION_DETALLE	B WITH (NOLOCK),
		DATOS_GENERALES 		  WITH (NOLOCK)
	WHERE	A.rut_cliente		= @nRutCli
	AND     A.Codigo_cliente 	= @nCodigo
	AND	A.Id_Sistema		= B.Id_Sistema	
	AND	A.NumeroOperacion	= B.NumeroOperacion
	AND	A.NumeroDocumento	= B.NumeroDocumento
	AND	A.NumeroCorrelativo	= B.NumeroCorrelativo
	AND	B.Tipo_Detalle		= 'L'
	AND	B.Tipo_Movimiento	= 'S'
	AND     a.FechaVencimiento	> fecha_proceso
	AND     a.activo		= 'S'
	GROUP BY Linea_Transsaccion,
		 A.Codigo_Grupo,
		 CASE WHEN Linea_Transsaccion IN ('LINGEN', 'LINSIS', 'LINSCR','LINSSR' ) THEN 0 ELSE datediff(day, FechaInicio,FechaVencimiento) END


	SELECT @nContador = 1
	SELECT @nTotal = COUNT(1) FROM #temp1

	WHILE @nContador <= @nTotal
	BEGIn

		SELECT @encontro = '*'

		SELECT	@encontro 	= '1',
			@Transaccion	= Transaccion,
			@Grupo		= Grupo,
			@MONTO		= MONTO,
			@Plazo		= Plazo
		FROM	#temp1
		WHERE	contador = @ncontador

		IF @encontro = '*'
			BREAK



		IF @transaccion='LINGEN'
		        UPDATE	LINEA_GENERAL WITH (ROWLOCK)
			SET	totalocupado	= totalocupado  + @MONTO
			WHERE	rut_cliente	= @nRutcli 
			AND	codigo_cliente	= @nCodigo



		IF @transaccion='LINSIS'
			UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
			SET	totalocupado	= totalocupado    	+ @MONTO	,
				SinRiesgoOcupado= SinRiesgoOcupado	+ @MONTO
			WHERE	rut_cliente	= @nRutcli
			AND 	codigo_cliente	= @nCodigo
			AND	codigo_grupo	= @Grupo

		IF @transaccion='LINSSR'
			UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
			SET	totalocupado	= totalocupado    	+ @MONTO	,
				SinRiesgoOcupado= SinRiesgoOcupado	+ @MONTO
			WHERE	rut_cliente	= @nRutcli
			AND 	codigo_cliente	= @nCodigo
			AND	codigo_grupo	= @Grupo


		IF @transaccion='LINSCR'
			UPDATE	LINEA_SISTEMA WITH (ROWLOCK)
			SET	totalocupado	= totalocupado    	+ @MONTO	,
				ConRiesgoOcupado= ConRiesgoOcupado	+ @MONTO
			WHERE	rut_cliente	= @nRutcli
			AND 	codigo_cliente	= @nCodigo
			AND	codigo_grupo	= @Grupo


		IF @transaccion='LINPZO'
			UPDATE 	LINEA_POR_PLAZO	 WITH (ROWLOCK)
			SET 	totalocupado	=  totalocupado    	+ @MONTO, 
				SinRiesgoocupado=  SinRiesgoocupado	+ @MONTO
			WHERE	rut_cliente	=  @nRutcli
			AND	codigo_cliente	=  @nCodigo
			AND	codigo_grupo 	=  @Grupo
			AND	@Plazo 		>= plazodesde
			AND	@Plazo 		<= plazohasta


		IF @transaccion='LINPSR'
			UPDATE 	LINEA_POR_PLAZO	WITH (ROWLOCK)
			SET 	totalocupado	=  totalocupado    	+ @MONTO,
				SinRiesgoocupado=  SinRiesgoocupado	+ @MONTO
			WHERE	rut_cliente	=  @nRutcli
			AND	codigo_cliente	=  @nCodigo
			AND	codigo_grupo 	=  @Grupo
			AND	@Plazo 		>= plazodesde
			AND	@Plazo 		<= plazohasta


		IF @transaccion='LINPCR'
			UPDATE 	LINEA_POR_PLAZO	WITH (ROWLOCK)
			SET 	totalocupado	=  totalocupado    	+ @MONTO,
				ConRiesgoocupado=  ConRiesgoocupado	+ @MONTO
			WHERE	rut_cliente	=  @nRutcli
			AND	codigo_cliente	=  @nCodigo
			AND	codigo_grupo 	=  @Grupo
			AND	@Plazo 		>= plazodesde
			AND	@Plazo 		<= plazohasta


		SET @nContador = @nContador + 1

	END

	EXECUTE SP_LINEAS_ACTUALIZA @nRutCli

END
GO
