USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[sp_margenbanco_consultar]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[sp_margenbanco_consultar](	@cCodSis	CHAR(03)	,
						@nNumoper	NUMERIC(09)	)
AS
BEGIN


	SET NOCOUNT ON



	DECLARE	@cod_servicio		CHAR(05),
		@cod_err_serv		CHAR(04),
		@cod_err_mq		CHAR(04),
		@tipo_err_mq		CHAR(01),
		@data			VARCHAR(1986),
		@buffer			VARCHAR(2000)

	DECLARE	@comm_codigo		CHAR(20),
		@comm_numitm		CHAR(02),
		@comm_rutcli		CHAR(10),
		@comm_numido		CHAR(20),
		@comm_fecvto		CHAR(08),
		@comm_monto		CHAR(13),
		@comm_monori		CHAR(02),
		@filler			VARCHAR(1911)

	DECLARE	@nRutCli		NUMERIC(09),
		@cDv			CHAR(1),
		@nMonto			NUMERIC(19),
		@dFecvcto		DATETIME,
		@nContador		INTEGER,
		@cEncontro		CHAR(1),
		@retorno		INT,
		@cNumeroMargenPU	CHAR(20),
		@cNumeroItemPU		CHAR(2)
		

	SELECT	DISTINCT
		rut		= rut_cliente,
		contador	= IDENTITY(int, 1,1),
		retorno		= 'xxxx'
	INTO	#temp1
	FROM	linea_transaccion 	  t,
		linea_transaccion_detalle d
	WHERE	t.Id_Sistema		= @cCodSis
	AND	t.NumeroOperacion 	= @nNumoper
	AND	t.Id_Sistema		= d.Id_Sistema
	AND	t.NumeroOperacion	= d.NumeroOperacion
	AND	t.NumeroDocumento	= d.NumeroDocumento
	AND	t.NumeroCorrelativo	= d.NumeroCorrelativo
	AND 	d.Linea_Transsaccion	= 'LINGEN'
	AND	d.Tipo_Detalle		= 'L'
	AND	d.Tipo_Movimiento	= 'S'



	IF (SELECT COUNT(*) FROM #temp1) = 0
	BEGIN
		SELECT 'SI', 'OPERACION NO OCUPA LINEAS'
		RETURN
	END



	SELECT	@nContador=0

	WHILE 1=1
	BEGIN	

		SELECT	@cEncontro = 'N'

		SET ROWCOUNT 1

		SELECT	@cEncontro 	= 'S',
			@nRutCli	= rut_cliente,
			@nMonto		= TotalOcupado,
			@nContador	= contador
		FROM	linea_general,
			#temp1
		WHERE	rut_cliente = rut
		AND	contador > @nContador

		SET ROWCOUNT 0


		IF @cEncontro = 'N'
			BREAK


		SELECT 	top 1
			@cDv = cldv
		FROM	CLIENTE
		WHERE	clrut = @nRutCli 





		SELECT 	top 1
			@cNumeroMargenPU = NumeroMargenPU,
			@cNumeroItemPU = NumeroItemPU
		FROM	CLIENTE
		WHERE	clrut = @nRutCli 



		IF LTRIM(RTRIM(@cNumeroMargenPU)) = '' OR LTRIM(RTRIM(@cNumeroItemPU))=''
		BEGIN
			SELECT 'NO', 'CLIENTE SIN NUMERO MARGEN DEFINIDO'
			RETURN
		END



		SELECT	@dFecvcto 	= MAX( FechaVencimiento )
		FROM	linea_transaccion
		WHERE	Rut_Cliente	= @nRutCli


	
		SELECT 	@cod_servicio	= 'MAASO',
			@cod_err_serv	= '0000',
			@cod_err_mq	= '0000',
			@tipo_err_mq	= '0'

		SELECT	@comm_codigo	= @cNumeroMargenPU,
			@comm_numitm	= @cNumeroItemPU,
			@comm_rutcli	= REPLICATE('0',9-len(ltrim(CONVERT(CHAR(9),@nRutCli)))) + lTRIM(CONVERT(CHAR(9),@nRutCli)) + @cDv,
			@comm_numido	= @cNumeroMargenPU,
			@comm_fecvto	= CONVERT(CHAR(8), @dFecvcto, 112),
			@comm_monto	= REPLICATE('0',13-len(ltrim(CONVERT(CHAR(13),@nMonto)))) + lTRIM(CONVERT(CHAR(13),@nMonto)),
			@comm_monori	= '00',
			@filler		= REPLICATE(' ',1911)


		SELECT 	@data =	@comm_codigo	+
				@comm_numitm	+
				@comm_rutcli	+
				@comm_numido	+
				@comm_fecvto	+
				@comm_monto	+
				@comm_monori	+
				@filler		


		SELECT	@buffer =	@cod_servicio	+
					@cod_err_serv	+
					@cod_err_mq	+
					@tipo_err_mq	+
					@data



--	        EXECUTE	@Retorno = master..xp_MQServ @buffer OUT


		UPDATE	#temp1
		SET	retorno  = SUBSTRING(@buffer, 6, 4)
		WHERE	contador = @nContador

	END


	IF ( SELECT COUNT(*) FROM #temp1 WHERE RETORNO = '00' ) = ( SELECT COUNT(*) FROM #temp1 )
		SELECT 'SI', 'MONTO APROBADO'
	ELSE
		SELECT 'NO', 'MONTO RECHAZADO'


	SET NOCOUNT OFF

END
-- sp_margenbanco_consultar 'BTR', 51153
-- select * from cliente
-- select CONVERT(CHAR(8), GETDATE(), 112)
-- select * from linea_transaccion

GO
