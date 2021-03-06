USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_BLOQUEOCLIENTE_OPT]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_GRABA_BLOQUEOCLIENTE_OPT]
(
	@codSistema 	CHAR(3),
	@codProducto 	CHAR(5),
	@NumOp			NUMERIC(10),
	@tipoOp 		CHAR(1),
	@Motivo			VARCHAR(70),
	@RutCliente		NUMERIC(9, 0),
	@CodCliente		NUMERIC(9, 0),
	@fechaInicio	DATETIME,
	@fechaVcto		DATETIME,
	@Operador		VARCHAR(15) = '',
	@MontoOp		NUMERIC(21, 4) = 0.0000,
	@Proceso		VARCHAR(100) OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE	@codProdSwap	NUMERIC(1, 0)
		,	@correlInterno	INTEGER
		,	@TipoCambio		NUMERIC(9, 4)
		,	@NumDocu		NUMERIC(10, 0)
		,	@correlBase		INTEGER

	SELECT @correlBase = 0
	
	SELECT 	@correlInterno = 0

	SELECT @NumDocu = @NumOp

	SELECT @correlInterno = ISNULL(MAX(NumeroCorre_Detalle),0)
	FROM BacLineas..LINEA_TRANSACCION_DETALLE
	WHERE NumeroOperacion = @NumOp
	AND Id_Sistema = @codSistema
	AND NumeroCorrelativo = 0

	SELECT @correlInterno = @correlInterno + 1

	/* Primero, insertar en tabla LINEA_TRANSACCION	*/
	SELECT 	@codProducto = @codSistema,
			@TipoCambio  = 0.0000
	
	IF NOT EXISTS(SELECT NumeroOperacion FROM BacLineas..LINEA_TRANSACCION
				WHERE Id_Sistema = @codSistema
				AND NumeroOperacion = @NumOp
				AND Rut_Cliente = @RutCliente
				AND Codigo_Cliente = @CodCliente)
	BEGIN
		INSERT INTO BacLineas..LINEA_TRANSACCION (
				 NumeroOperacion
				,NumeroDocumento
				,NumeroCorrelativo
				,Rut_Cliente
				,Codigo_Cliente
				,Id_Sistema
				,Codigo_Producto
				,Tipo_Operacion
				,Tipo_Riesgo
				,FechaInicio
				,FechaVencimiento
				,MontoOriginal
				,TipoCambio
				,MatrizRiesgo
				,MontoTransaccion
				,Operador
				,Activo
				)
		VALUES(	@NumOp,
				@NumDocu,
				0,
				@RutCliente,
				@CodCliente,
				@codSistema,
				@codProducto,
				'',
				'C',
				@fechaInicio,
				@fechaVcto,
				@MontoOp,
				@TipoCambio,
				0,
				0,
				@Operador,
				'S'
				)

		IF @@ROWCOUNT = 0
		BEGIN
			SELECT @Proceso = 'No se pudo insertar en tabla LINEA_TRANSACCION'
			RETURN 0
		END			
	END
		
	/* Segundo, insertar en tabla LINEA_TRANSACCION_DETALLE	*/		
	INSERT INTO BacLineas..LINEA_TRANSACCION_DETALLE (
			 NumeroOperacion
			,NumeroDocumento
			,NumeroCorrelativo
			,NumeroCorre_Detalle
			,Rut_Cliente
			,Codigo_Cliente
			,Id_Sistema
			,Codigo_Producto
			,Tipo_Detalle
			,Tipo_Movimiento
			,Linea_Transsaccion
			,MontoTransaccion
			,MontoExceso
			,PlazoDesde
			,PlazoHasta
			,Actualizo_Linea
			,Error
			,Mensaje_Error
			,moneda
			,forma_pago
			,Grupo_Emisor
			,instrumento
			)
	VALUES(	@NumOp,
			@NumDocu,
			0,
			@correlInterno,
			@RutCliente,
			@CodCliente,
			@codSistema,
			@codProducto,
			'L',
			'S',
			'BLQCLI',
			@MontoOp,
			0,
			0,
			0,
			'N',
			'S',
			@Motivo,
			0,
			0,
			'',
			0 )
	IF @@ROWCOUNT = 0
		SELECT @Proceso = 'No se pudo insertar en tabla LINEA_TRANSACCION_DETALLE'
	ELSE
		SELECT @Proceso = 'OK'
	
END
GO
