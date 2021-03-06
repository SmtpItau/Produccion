USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_CHK_TASAS]    Script Date: 13-05-2022 10:37:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CHK_TASAS] (	@dFecPro	DATETIME	,
					@cSistema	CHAR(03)	,
					@cProducto	CHAR(05)	,
					@FormaPago	NUMERIC(03)	,
					@nMonedaOp	NUMERIC (05)	,
					@nNumVentana	NUMERIC(10)	,
					@dFecvctop	DATETIME	,
					@nTasa		FLOAT		,
					@nInCodigo	NUMERIC (05)	,
					@nTipo		CHAR(01)	,
					@cIntser	CHAR(12)	,
					@cSeriado	CHAR(01)	,
					@nNumOper	NUMERIC(10)
)
AS
BEGIN
	DECLARE @Existe		CHAR(01),
		@nPorcMin	NUMERIC(08,04),
		@nPorcMax	NUMERIC(08,04),
		@nTasaSuper	FLOAT,
		@nTasaMin	FLOAT,
		@nTasaMax	FLOAT,
		@cMensaje	VARCHAR(255),
		@nExceso	NUMERIC(19,04),
		@nDesde		INTEGER,
		@nHasta		INTEGER,
		@nNumDocu	NUMERIC(10),
		@nCorrela	NUMERIC(05),
		@nCorrDet	NUMERIC(05),
		@nRutCLi	NUMERIC(10),
		@nCodCli	NUMERIC(10),
		@dFecOpe	DATETIME,
		@dFecVcto	DATETIME,
		@cOperador	CHAR(15)

	SET ROWCOUNT 1
	SELECT	@nNumDocu	= NumeroDocumento,
		@nCorrela	= NumeroCorrelativo,
		@nCorrDet	= 0,
		@nRutCLi	= Rut_Cliente,
		@nCodCli	= Codigo_Cliente,
		@dFecOpe	= FechaOperacion,
		@dFecVcto	= CASE WHEN @nTipo = 'P' THEN FechaVencimiento ELSE FechaVctoInst END,
		@cOperador	= Operador
	FROM 	LINEA_CHEQUEAR
	WHERE 	NumeroOperacion = @nNumVentana
	SET ROWCOUNT 0

	SELECT @nCorrDet = ISNULL(MAX(NumeroCorre_Detalle),0)
	FROM LINEA_TRANSACCION_DETALLE 
	WHERE NumeroOperacion = @nNumVentana

	IF @nCorrDet = 0 BEGIN
		INSERT INTO LINEA_TRANSACCION
			(	numerodocumento  	,
				numerooperacion  	,
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
				activo			)


		SELECT 		@nNumDocu		,
				@nNumoper		,
				@nCorrela		,
				@nRutCLi		,
				@nCodCli		,
				'BTR'			,
				@cProducto		,
				''			,
				''			,
				@dFecOpe		,
				@dFecVcto		,
				0			,
				0			,
				0			,
				0			,
				@cOperador		,
				'S'



	END

	IF @nTipo = 'P' BEGIN
		SELECT 	@Existe		= 'N'

		/* La forma dfe Pago para este contro, por operacion es Opcional */
		IF NOT EXISTS(SELECT 1 FROM LINEA_TASA WHERE 	Id_Sistema 	= 'BTR'		AND
								Codigo_Producto	= @cProducto	AND
								codigo		= @FormaPago 	AND
								mncodmon	= @nMonedaOp	AND
								Plazo_Desde    <= DATEDIFF(day, @dFecPro, @dFecvctop)	AND
								Plazo_Hasta    >= DATEDIFF(day, @dFecPro, @dFecvctop) ) 
		BEGIN
			SELECT @FormaPago	= 0
		END


		SELECT 	@nPorcMin 	= Porcentaje_Minima	,
			@nPorcMax 	= Porcentaje_Maximo	,
			@nTasaSuper	= TasaSuper		,
			@nDesde		= Plazo_Desde		,
			@nHasta		= Plazo_Hasta		,
			@Existe		= 'S'
		FROM 	LINEA_TASA
		WHERE 	Id_Sistema 	= 'BTR'		AND
			Codigo_Producto	= @cProducto	AND
			codigo		= @FormaPago 	AND
			mncodmon	= @nMonedaOp	AND
			Plazo_Desde    <= DATEDIFF(day, @dFecPro, @dFecvctop)	AND
			Plazo_Hasta    >= DATEDIFF(day, @dFecPro, @dFecvctop)


		IF @Existe = 'S' BEGIN

			SELECT @nTasaMin	= ROUND(@nTasaSuper - ((@nTasaSuper*@nPorcMin)/100.0),4)
			SELECT @nTasaMax	= ROUND(@nTasaSuper + ((@nTasaSuper*@nPorcMax)/100.0),4)
			SELECT @cMensaje	= ''

			IF @nTasa < @nTasaMin BEGIN
				SELECT  @cMensaje = 'La Tasa Ingresada esta por Debajo del Minimo Permitido - Tasa Minima ' + RTRIM(CONVERT(CHAR(15),@nTasaMin)) + ' Operacion ' + @cProducto,
					@nExceso  = 0							
			END

			IF @nTasa > @nTasaMax BEGIN
				SELECT  @cMensaje = 'La Tasa Ingresada esta por Encima del Maximo Permitido - Tasa Maxima ' + RTRIM(CONVERT(CHAR(15),@nTasaMax)) + ' Operacion ' + @cProducto,
					@nExceso  = 0							
			END

			IF @cMensaje <> ''
			BEGIN

				SELECT @nCorrDet = @nCorrDet + 1
				INSERT INTO LINEA_TRANSACCION_DETALLE
					(	NumeroOperacion		,
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
						forma_pago		,
						Mensaje_Error		)

				SELECT 		@nNumoper		,
						@nNumDocu		,
						@nCorrela		,
						@nCorrDet		,
						@nRutCLi		,
						@nCodCli		,
						'BTR'			,
						@cProducto		,
						''			,
						''			,
						'CTRLTA'		,
						0			,
						0			,
						@nDesde			,
						@nHasta			,
						'N'			,
						'S'			,
						@FormaPago		,
						@cMensaje
						
			END

		END ELSE BEGIN
			SELECT  @cMensaje = 'No se Encontraron Tasa Minimas y/o Maximas para esta Operacion ' + @cProducto,
				@nExceso  = 0							

			SELECT @nCorrDet = @nCorrDet + 1
			INSERT INTO LINEA_TRANSACCION_DETALLE
				(	NumeroOperacion		,
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
					Mensaje_Error		)

			SELECT 		@nNumoper		,
					@nNumDocu		,
					@nCorrela		,
					@nCorrDet		,
					@nRutCLi		,
					@nCodCli		,
					'BTR'			,
					@cProducto		,
					''			,
					''			,
					'CTRLTA'		,
					0			,
					0			,
					0			,
					0		,
					'N'			,
					'S'			,
					@cMensaje
		END
		
	END ELSE BEGIN

		SELECT 	@Existe		= 'N'

		IF @cSeriado = 'S' BEGIN -- Instrumentos Seriados
			/* Rescata Tasa Mercado cargada desde la Interfaz de la Super */
			SELECT 	@nTasaSuper	= Tir_Valorizacion		,
				@Existe		= 'S'
			FROM 	LINEA_TASA_SUPER
			WHERE 	Nemotecnico 	= @cIntser

			/* Rescata Porcentajes de Desviacion Minimo y Maximo */
			SELECT	@nPorcMin 	= Porcentaje_Minimo	,
				@nPorcMax 	= Porcentaje_Maximo
			FROM	LINEA_TASA_INSTRUMENTOS
			WHERE	Incodigo	= @nInCodigo

			IF @Existe = 'S' BEGIN
				SELECT @nTasaMin	= ROUND(@nTasaSuper - ((@nTasaSuper*@nPorcMin)/100.0),4)
				SELECT @nTasaMax	= ROUND(@nTasaSuper + ((@nTasaSuper*@nPorcMax)/100.0),4)
				SELECT @cMensaje	= ''
	
				IF @nTasa < @nTasaMin BEGIN
					SELECT  @cMensaje = 'La Tasa Ingresada esta por Debajo del Minimo Permitido - Tasa Minima ' + Rtrim(CONVERT(CHAR(15),@nTasaMin)) + ' Instrumento ' + @cIntser,
						@nExceso  = 0
				END

				IF @nTasa > @nTasaMax BEGIN
					SELECT  @cMensaje = 'La Tasa Ingresada esta por Encima del Maximo Permitido - Tasa Maxima ' + Rtrim(CONVERT(CHAR(15),@nTasaMax)) + ' Instrumento ' + @cIntser,
						@nExceso  = 0
				END

				IF @cMensaje <> ''
				BEGIN

					SELECT @nCorrDet = @nCorrDet + 1
					INSERT INTO LINEA_TRANSACCION_DETALLE
						(	NumeroOperacion		,
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
							Mensaje_Error		)

					SELECT 		@nNumoper		,
							@nNumDocu		,
							@nCorrela		,
							@nCorrDet		,
							@nRutCLi		,
							@nCodCli		,
							'BTR'			,
							@cProducto		,
							''			,
								''			,
							'CTRLTA'		,
							0			,
							0			,
							0			,
							0			,
							'N'			,
							'S'			,
							@cMensaje
				END
	
			END ELSE BEGIN
				SELECT  @cMensaje = 'No se Encontraron Tasa Minimas y/o Maximas para esta Operacion -  Instrumento ' +@cIntser,
					@nExceso  = 0							

				SELECT @nCorrDet = @nCorrDet + 1
				INSERT INTO LINEA_TRANSACCION_DETALLE
					(	NumeroOperacion		,
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
						Mensaje_Error		)

				SELECT 		@nNumoper		,
						@nNumDocu		,
						@nCorrela		,
						@nCorrDet		,
						@nRutCLi		,
						@nCodCli		,
						'BTR'			,
						@cProducto		,
						''			,
						''			,
						'CTRLTA'		,
						0			,
						0			,
						0			,--@nDesde			,
						0			,--@nHasta			,
						'N'			,
						'S'			,
						@cMensaje

			END

		END ELSE BEGIN -- Instrumentos No Seriados
			/* Rescata Tasa y Porcentajes de Desviacion Minimo y Maximo */
			SELECT 	@nPorcMin 	= Porcentaje_Minimo	,
				@nPorcMax 	= Porcentaje_Maximo	,
				@nTasaSuper	= TasaSuper		,
				@nDesde		= Plazo_Desde		,
				@nHasta		= Plazo_Hasta		,
				@Existe		= 'S'
			FROM 	LINEA_TASA_INSTRUMENTOS
			WHERE 	Incodigo	= @nInCodigo 				AND
				Plazo_Desde    <= DATEDIFF(day, @dFecPro, @dFecvctop)	AND
				Plazo_Hasta    >= DATEDIFF(day, @dFecPro, @dFecvctop)

			IF @Existe = 'S' BEGIN
				SELECT @nTasaMin	= ROUND(@nTasaSuper - ((@nTasaSuper*@nPorcMin)/100.0),4)
				SELECT @nTasaMax	= ROUND(@nTasaSuper + ((@nTasaSuper*@nPorcMax)/100.0),4)
				SELECT @cMensaje	= ''
	
				IF @nTasa < @nTasaMin BEGIN
					SELECT  @cMensaje = 'La Tasa Ingresada esta por Debajo del Minimo Permitido - Tasa Minima ' + Rtrim(CONVERT(CHAR(15),@nTasaMin)) + ' Instrumento ' +@cIntser,
						@nExceso  = 0
				END

				IF @nTasa > @nTasaMax BEGIN
					SELECT  @cMensaje = 'La Tasa Ingresada esta por Encima del Maximo Permitido - Tasa Maxima ' + Rtrim(CONVERT(CHAR(15),@nTasaMax)) + ' Instrumento ' +@cIntser,
						@nExceso  = 0
				END

				IF @cMensaje <> ''
				BEGIN
					SELECT @nCorrDet = @nCorrDet + 1
					INSERT INTO LINEA_TRANSACCION_DETALLE
						(	NumeroOperacion		,
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
							Mensaje_Error		)

					SELECT 		@nNumoper		,
							@nNumDocu		,
							@nCorrela		,
							@nCorrDet		,
							@nRutCLi		,
							@nCodCli		,
							'BTR'			,
							@cProducto		,
							''			,
							''			,
							'CTRLTA'		,
							0			,
							0			,
							@nDesde			,
							@nHasta			,
							'N'			,
							'S'			,
							@cMensaje				
				END
	
			END ELSE BEGIN
				SELECT  @cMensaje = 'No se Encontraron Tasa Minimas y/o Maximas para esta Operacion - Instrumento ' +@cIntser,
					@nExceso  = 0							
	
				SELECT @nCorrDet = @nCorrDet + 1
				INSERT INTO LINEA_TRANSACCION_DETALLE
					(	NumeroOperacion		,
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
						Mensaje_Error		)

				SELECT 		@nNumoper		,
						@nNumDocu		,
						@nCorrela		,
						@nCorrDet		,
						@nRutCLi		,
						@nCodCli		,
						'BTR'			,
						@cProducto		,
						''			,
						''			,
						'CTRLTA'		,
						0			,
						0			,
						0			,
						0			,
						'N'			,
						'S'			,
						@cMensaje				
	
			END
		END

	END
END











GO
