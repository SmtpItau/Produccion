USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_OPPENDIENTEPRECIOS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_GRABA_OPPENDIENTEPRECIOS]
(
	@codSistema 	CHAR(3),
	@codProducto 	CHAR(5),
	@NumOp	NUMERIC(9),
	@NumDocu	NUMERIC(9)=0,
	@tipoOp 	CHAR(1),
	@Diferencia	FLOAT,
	@Leyenda	VARCHAR(255)
)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE	@encontrado 	CHAR(1),
		@RutCliente	NUMERIC(9),
		@CodCliente	NUMERIC(9),
		@MontoOp	NUMERIC(19, 4),
		@codProdSwap	NUMERIC(5),
		@correlInterno	INTEGER

	SELECT 	@encontrado = 'N',
			@correlInterno = 0

	IF @NumDocu = 0 OR @NumDocu IS NULL
		SELECT @NumDocu = @NumOp

	SELECT @correlInterno = ISNULL(MAX(NumeroCorre_Detalle),1)
	FROM BacLineas..LINEA_TRANSACCION_DETALLE
	WHERE NumeroOperacion = @NumOp
	AND Id_Sistema = @codSistema
	AND NumeroCorrelativo = 1

	SELECT @correlInterno = @correlInterno + 1

	IF @codSistema = 'BCC'
	BEGIN
		IF NOT EXISTS(SELECT MONUMOPE
				FROM BacCamSuda..MEMO
				WHERE MOTIPMER = @codProducto
				AND MONUMOPE = @NumOp
				AND MOTIPOPE = @tipoOp)
			SELECT 'Error','No se encontró el movimiento en tabla MEMO'
		ELSE	
		BEGIN
			UPDATE BacCamSuda..MEMO
			SET MOESTATUS = 'P'
			WHERE MOTIPMER = @codProducto
			AND MONUMOPE = @NumOp
			AND MOTIPOPE = @tipoOp
			AND MOESTATUS <> 'P'
			
			SELECT 	@RutCliente = MORUTCLI,
				@CodCliente = MOCODCLI,
				@MontoOp    = MOMONMO
				FROM BacCamSuda..MEMO
				WHERE MOTIPMER = @codProducto
				AND MONUMOPE = @NumOp
				AND MOTIPOPE = @tipoOp

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
					1,
					@correlInterno,
					@RutCliente,
					@CodCliente,
					@codSistema,
					@codProducto,
					'L',
					'S',
					'CTRLPR',
					@MontoOp,
					0,	---@Diferencia,
					0,
					0,
					'N',
					'S',
					@Leyenda,
					0,
					0,
					'',
					0 )
			SELECT 'OK','OK'
		END
	END	--- @codSistema = 'BCC'
	IF @codSistema = 'BTR'
	BEGIN
		IF NOT EXISTS(SELECT monumoper
				FROM BacTraderSuda..mdmo
				WHERE monumoper = @NumOp
				AND motipoper = @codProducto)
			SELECT 'Error','No se encontró el movimiento en tabla mdmo'
		ELSE	
		BEGIN
			UPDATE BacTraderSuda..mdmo
			SET mostatreg = 'P'
			WHERE monumoper = @NumOp
			AND motipoper = @codProducto
			AND mostatreg <> 'P'
			
			IF @codProducto = 'CP'		--- Solo para Compras Propias usar el correlativo
			SELECT 	@RutCliente = morutcli,
				@CodCliente = mocodcli,
				@MontoOp    = monominal
				FROM BacTraderSuda..mdmo
				WHERE monumoper = @NumOp
				AND motipoper = @codProducto
				AND mocorrela = @correlInterno - 1
			ELSE IF @codProducto IN ( 'CI','VI','RC','RV','IB' )
				SELECT 	@RutCliente = morutcli,
				@CodCliente = mocodcli,
				@MontoOp    = movpresen
				FROM BacTraderSuda..mdmo
				WHERE monumoper = @NumOp
				AND motipoper = @codProducto
			ELSE		--- VP
				SELECT 	@RutCliente = morutcli,
				@CodCliente = mocodcli,
				@MontoOp    = monominal
				FROM BacTraderSuda..mdmo
				WHERE monumoper = @NumOp
				AND motipoper = @codProducto

						
			INSERT INTO BacLineas..LINEA_TRANSACCION_DETALLE(
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
					1,
					@correlInterno,
					@RutCliente,
					@CodCliente,
					@codSistema,
					@codProducto,
					'L',
					'S',
					'CTRLPR',
					@MontoOp,
					0,	---@Diferencia,
					0,
					0,
					'N',
					'S',
					@Leyenda,
					0,
					0,
					'',
					0 )
			SELECT 'OK','OK'
		END
	END	--- @codSistema = 'BTR'
	IF @codSistema = 'BFW'
	BEGIN
		IF NOT EXISTS(SELECT monumoper
				FROM BacFwdSuda..mfmo
				WHERE monumoper = @NumOp
				AND mocodpos1 = @codProducto
				AND motipoper = @tipoOp)
			SELECT 'Error','No se encontró el movimiento en tabla mfmo'
		ELSE	
		BEGIN
			UPDATE BacFwdSuda..mfmo
			SET moestado = 'P'
			WHERE monumoper = @NumOp
			AND mocodpos1 = @codProducto
			AND motipoper = @tipoOp
			AND moestado <> 'P'
			
			SELECT 	@RutCliente = mocodigo,
				@CodCliente = mocodcli,
				@MontoOp    = momtomon1
				FROM BacFwdSuda..mfmo
				WHERE monumoper = @NumOp
				AND mocodpos1 = @codProducto
				AND motipoper = @tipoOp
						
			INSERT INTO BacLineas..LINEA_TRANSACCION_DETALLE(
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
					1,
					@correlInterno,
					@RutCliente,
					@CodCliente,
					@codSistema,
					@codProducto,
					'L',
					'S',
					'CTRLPR',
					@MontoOp,
					0,	---@Diferencia,
					0,
					0,
					'N',
					'S',
					@Leyenda,
					0,
					0,
					'',
					0 )
			SELECT 'OK','OK'
		END
	END	--- @codSistema = 'BFW'
	IF @codSistema = 'PCS'
	BEGIN
		/* Primero traducir el tipo de Swap */
		IF @codProducto = 'ST'
			SELECT @codProdSwap = 1
		IF @codProducto = 'SM'
			SELECT @codProdSwap = 2
		IF @codProducto = 'SP'
			SELECT @codProdSwap = 3

		IF NOT EXISTS(SELECT numero_operacion
				FROM BacSwapSuda..MovDiario
				WHERE numero_operacion = @NumOp
				AND tipo_swap = @codProdSwap
				AND tipo_operacion = @tipoOp
				AND numero_flujo = 1
				AND tipo_flujo = 1)
			SELECT 'Error','No se encontró el movimiento en tabla MovDiario'
		ELSE	
		BEGIN
			/*
			UPDATE BacFwdSuda..mfmo
			SET moestado = 'P'
			WHERE monumoper = @NumOp
			AND mocodpos1 = @codProducto
			AND motipoper = @tipoOp
			AND moestado <> 'P'
			*/

			SELECT 	@RutCliente = rut_cliente,
				@CodCliente = codigo_cliente
				FROM BacSwapSuda..MovDiario
				WHERE numero_operacion = @NumOp
				AND tipo_swap = @codProdSwap
				AND tipo_operacion = @tipoOp
				AND numero_flujo = 1
				AND tipo_flujo = 1

			IF @tipoOp = 'C'
				SELECT 	@MontoOp = compra_capital
					FROM BacSwapSuda..MovDiario
					WHERE numero_operacion = @NumOp
					AND tipo_swap = @codProdSwap
					AND tipo_operacion = @tipoOp
					AND @tipoOp = 'C'
					AND numero_flujo = 1
					AND tipo_flujo = 1
			ELSE
				SELECT 	@MontoOp = venta_capital
					FROM BacSwapSuda..MovDiario
					WHERE numero_operacion = @NumOp
					AND tipo_swap = @codProdSwap
					AND tipo_operacion = @tipoOp
					AND @tipoOp = 'V'
					AND numero_flujo = 1
					AND tipo_flujo = 1

						
			INSERT INTO BacLineas..LINEA_TRANSACCION_DETALLE(
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
					1,
					@correlInterno,
					@RutCliente,
					@CodCliente,
					@codSistema,
					@codProdSwap,
					'L',
					'S',
					'CTRLPR',
					@MontoOp,
					0,	---@Diferencia,
					0,
					0,
					'N',
					'S',
					@Leyenda,
					0,
					0,
					'',
					0 )
			SELECT 'OK','OK'
		END
	END	--- @codSistema = 'PCS'
	IF @codSistema = 'BEX'
	BEGIN
		IF NOT EXISTS(SELECT monumoper
				FROM BacBonosExtSuda..text_mvt_dri
				WHERE monumoper = @NumOp
				AND motipoper = SUBSTRING(@codProducto,1,2)
				AND mocorrelativo = 1)
			SELECT 'Error','No se encontró el movimiento en tabla text_mvt_dri'
		ELSE	
		BEGIN
			UPDATE BacBonosExtSuda..text_mvt_dri
			SET mostatreg = 'P'
			WHERE monumoper = @NumOp
			AND motipoper = SUBSTRING(@codProducto,1,2)
			AND mocorrelativo = 1
			AND mostatreg <> 'P'
			
			SELECT 	@RutCliente = morutcli,
				@CodCliente = mocodcli,
				@MontoOp    = monominal
				FROM BacBonosExtSuda..text_mvt_dri
				WHERE monumoper = @NumOp
				AND motipoper = SUBSTRING(@codProducto,1,2)
				AND mocorrelativo = 1
						
			INSERT INTO BacLineas..LINEA_TRANSACCION_DETALLE(
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
					1,
					@correlInterno,
					@RutCliente,
					@CodCliente,
					@codSistema,
					@codProducto,
					'L',
					'S',
					'CTRLPR',
					@MontoOp,
					0,	---@Diferencia,
					0,
					0,
					'N',
					'S',
					@Leyenda,
					0,
					0,
					'',
					0 )
			SELECT 'OK','OK'
		END
	END	--- @codSistema = 'BEX'
END
GO
