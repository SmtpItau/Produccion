USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LINEAS_FLI]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LINEAS_FLI] (	@nNumoper 	NUMERIC(10),
				@nNumdocu       NUMERIC(10),
                                @nCorrela       NUMERIC(3),
				@nCorrelaFli    NUMERIC(3),	
				@nRutcli  	NUMERIC(09,0),
				@nCodigo  	NUMERIC(09,0),
				@cUsuario	CHAR(10),
				@dFeciniop  	DATETIME,
				@dFecvctop  	DATETIME,
				@nMontolin  	NUMERIC (19,4))
AS
BEGIN
       SET NOCOUNT ON

       IF EXISTS(SELECT * FROM BacLineas..LINEA_TRANSACCION WHERE numerooperacion = @nNumoper)
          UPDATE BacLineas..LINEA_TRANSACCION SET MontoTransaccion= MontoTransaccion + @nMontoLin WHERE numerooperacion = @nNumoper
       ELSE  
          INSERT INTO BacLineas..LINEA_TRANSACCION
		(	numerooperacion  	,
			numerodocumento  	,
			numerocorrelativo 	,
			rut_cliente  		,
			codigo_cliente  	,
			id_sistema  		,
			codigo_producto  	,
			tipo_operacion 		,
			tipo_riesgo  		,
			fechainicio  		,
			fechavencimiento 	,
			montooriginal  		,
			tipocambio  		,
			matrizriesgo		,
			montotransaccion 	,
			operador		,
			activo
				)
	SELECT	@nNumoper  	,
		@nNumdocu       ,
		@nCorrela	,
		@nRutcli  	,
		@nCodigo  	,
		'BTR'  		,
		'FLI'    	,
		''   		,
		''  		,
		@dFeciniop  	,
		@dFecvctop  	,
		0		,
		0           	,
		0               ,
		@nMontolin  	,
		@cUsuario	,
		'S'
	IF @@ERROR <> 0
        BEGIN
	     SELECT '1'
             RETURN
        END


	INSERT INTO BacLineas..LINEA_TRANSACCION_DETALLE	(NumeroOperacion	,
								NumeroDocumento		,
								NumeroCorrelativo	,
								NumeroCorre_Detalle	,
								Rut_Cliente		,
								Codigo_Cliente		,
								Id_Sistema		,
								Codigo_Producto		,
								Tipo_Detalle		,
								Tipo_Movimiento		,
								Linea_Transsaccion	,
								MontoTransaccion	,
								MontoExceso		,
								PlazoDesde		,
								PlazoHasta		,
								Actualizo_Linea		,
								Error			,
								Mensaje_Error		,
								instrumento		,
								moneda			,
								forma_pago		, 
								grupo_emisor            )


	SELECT	@nNumoper	,
		@nNumdocu       ,
		@nCorrela       ,
		@nCorrelaFli	,
		@nRutcli   	,
		@nCodigo   	,
		'BTR' 		,
		'FLI'     	,
		' '  		,
		' '      	,
		' '      	,
		0        	,
		0   		,
		0         	,
		0         	,
		'N'            	,
		'S'		,
		'Facilidad de Liquidez Intradia'	,
		0, --@incodigo	,
		0		,
		0		,
                ''
	IF @@ERROR <> 0
        BEGIN
             SELECT '1'
             RETURN
        END

	UPDATE MDMO
	SET mostatreg = 'P'
	WHERE monumoper = @nNumoper
	IF @@ERROR <> 0
        BEGIN
	     SELECT '1'
             RETURN
        END
	SET NOCOUNT OFF

        SELECT '0'
END

GO
