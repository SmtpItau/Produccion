USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_OPER_MODIFICADAS]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_GRABA_OPER_MODIFICADAS]
		(
			 @Modulo	CHAR(3),
			 @tipoProd	NUMERIC(2, 0)
			,@NumOper	NUMERIC(10, 0)
		)
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE  @caFecha		DATETIME
			,@fechaOper		DATETIME
			,@fechaMod		DATETIME
			,@horaMod		VARCHAR(8)
			,@FolioMod		NUMERIC( 9,0)
			,@Prorroga		INTEGER
			,@Variacion		NUMERIC(21,9)
			,@tipoProducto	VARCHAR(255)
			---> DATOS NUEVOS
			,@nNumMod_01		VARCHAR(255)
			,@nFechaMod_02		VARCHAR(255)
			,@nFechaOpe_03		VARCHAR(255)
			,@nNumOper_04		VARCHAR(255)
			,@nTipoProd_05		VARCHAR(255)
			,@nnomCliente_06	VARCHAR(255)
			,@ntipoOper_07		VARCHAR(255)
			,@nplazo_08			VARCHAR(255)
			,@nprorroga_09		VARCHAR(255)
			,@nfechaVcto_10		VARCHAR(255)
			,@nfechaEfect_11	VARCHAR(255)
			,@nMoneda_12		VARCHAR(255)
			,@nMontoMX_13		VARCHAR(255)
			,@nPrecio_14		VARCHAR(255)
			,@nTCFinal_15		VARCHAR(255)
			,@nVariacion_16		VARCHAR(255)
			,@nMontofinal_17	VARCHAR(255)
			,@nModalidad_18		VARCHAR(255)
			,@nCartera_19		VARCHAR(255)
			,@nPagoMN_20		VARCHAR(255)
			,@nPagoMX_21		VARCHAR(255)
			,@nMTM_22			VARCHAR(255)
			,@nOperador_23		VARCHAR(255)
			,@nHora_24			VARCHAR(255)
			---> DATOS ANTIGUOS
			,@aNumMod_01		VARCHAR(255)
			,@aFechaMod_02		VARCHAR(255)
			,@aFechaOpe_03		VARCHAR(255)
			,@aNumOper_04		VARCHAR(255)
			,@aTipoProd_05		VARCHAR(255)
			,@anomCliente_06	VARCHAR(255)
			,@atipoOper_07		VARCHAR(255)
			,@aplazo_08			VARCHAR(255)
			,@aprorroga_09		VARCHAR(255)
			,@afechaVcto_10		VARCHAR(255)
			,@afechaEfect_11	VARCHAR(255)
			,@aMoneda_12		VARCHAR(255)
			,@aMontoMX_13		VARCHAR(255)
			,@aPrecio_14		VARCHAR(255)
			,@aTCFinal_15		VARCHAR(255)
			,@aVariacion_16		VARCHAR(255)
			,@aMontofinal_17	VARCHAR(255)
			,@aModalidad_18		VARCHAR(255)
			,@aCartera_19		VARCHAR(255)
			,@aPagoMN_20		VARCHAR(255)
			,@aPagoMX_21		VARCHAR(255)
			,@aMTM_22			VARCHAR(255)
			,@aOperador_23		VARCHAR(255)
			,@aHora_24			VARCHAR(255)
			
		
	IF @Modulo = 'BFW'
	BEGIN
		SELECT @caFecha = cafecha FROM Bacfwdsuda.dbo.MFCA WHERE canumoper = @NumOper
		
		SELECT @fechaOper = cafecha FROM Bacfwdsuda.dbo.MFCARES WHERE canumoper = @NumOper AND caFechaProceso = @cafecha
		
		SELECT @tipoProducto = descripcion FROM PRODUCTO WHERE id_sistema = 'BFW' AND codigo_producto = CONVERT(CHAR(5), @tipoProd)
		---> Suponemos que es la primera modificación
		SELECT @FolioMod = 0
		IF EXISTS(SELECT 1 FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES WHERE Modulo = @Modulo AND FolioContrato = @NumOper)
		BEGIN
			---> La operación ya existe en la tabla de modificaciones
			SELECT @FolioMod = ISNULL(MAX(FolioModificacion), 0)
			FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES
			WHERE Modulo = 'BFW' AND FolioContrato = @NumOper
		END
		SELECT @FolioMod = @FolioMod + 1

		SELECT @fechaMod			= acfecproc FROM BacFwdSuda.dbo.MFAC
		
		SELECT   @horaMod			= CONVERT(VARCHAR(255), getdate(), 108)

		---> Traer estos datos de la tabla TBL_RG_MODIFICACIONES con Folio = 0, si existe
		SELECT 	 @aFechaMod_02 		= ' '
				,@aVariacion_16		= ' '
				,@aHora_24			= ' '
		
		
		SELECT	 @aFechaMod_02		= DatosOriginales FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES
				WHERE Modulo = @Modulo AND FolioContrato = @NumOper AND FolioModificacion = 0 AND Correlativo = 2
		
		
		SELECT  @aVariacion_16		= DatosOriginales FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES
				WHERE Modulo = @Modulo AND FolioContrato = @NumOper AND FolioModificacion = 0 AND Correlativo = 16
				
		SELECT  @aHora_24			= DatosOriginales FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES
				WHERE Modulo = @Modulo AND FolioContrato = @NumOper AND FolioModificacion = 0 AND Correlativo = 24
		
		IF EXISTS(SELECT 1 FROM BacFwdSuda.dbo.MFCARES WHERE canumoper = @NumOper AND caFechaProceso = @caFecha)
		BEGIN
		
			SELECT	 @aNumMod_01		= CONVERT(VARCHAR(255), @FolioMod)

			
			SELECT   @aFechaOpe_03		= CONVERT(VARCHAR(255), cares.cafecha, 105)
					,@aNumOper_04		= CONVERT(VARCHAR(255), @NumOper)
					,@aTipoProd_05		= @tipoProducto
					,@anomCliente_06	= cl.Clnombre
					,@atipoOper_07		= CASE cares.catipoper WHEN 'C' THEN 'COMPRA' WHEN 'V' THEN 'VENTA' END
					,@aplazo_08			= CONVERT(VARCHAR(255), cares.caplazo)
					,@afechaVcto_10		= CONVERT(VARCHAR(255), cares.cafecvcto, 105)
					,@afechaEfect_11	= CONVERT(VARCHAR(255), cares.cafecEfectiva, 105)
					,@aMoneda_12		= mo.mnglosa
					,@aMontoMX_13		= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), cares.camtomon1))
					,@aPrecio_14		= CASE cares.cacodpos1 WHEN 2 THEN CONVERT(VARCHAR(255), cares.caparmon1) ELSE CONVERT(VARCHAR(255), cares.caprecal) END
					,@aTCFinal_15		= CONVERT(VARCHAR(255), CONVERT(NUMERIC(19,2), cares.capremon1))
					,@aMontofinal_17	= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), cares.camtomon2))
					,@aModalidad_18		= CASE cares.catipmoda WHEN 'C' THEN 'COMPENSACION' WHEN 'E' THEN 'ENTREGA FISICA' END
					,@aCartera_19		= tg.tbglosa
					,@aPagoMN_20		= fp1.glosa
					,@aPagoMX_21		= CASE WHEN cares.cafpagomx = 0 THEN 'NO APLICABLE'
										   WHEN cares.cafpagomx > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
												WHERE fp.codigo = cares.cafpagomx)
										  END
					,@aMTM_22			= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), cares.fRes_Obtenido))
					,@aOperador_23		= us.nombre
					FROM BacFwdSuda.dbo.MFCARES cares
					INNER JOIN BacParamsuda.dbo.CLIENTE cl
						ON cl.Clrut = cares.cacodigo AND cl.Clcodigo = cares.cacodcli
					INNER JOIN BacParamsuda.dbo.MONEDA mo
						ON cares.cacodmon1 = mo.mncodmon
					INNER JOIN BacParamsuda.dbo.TABLA_GENERAL_DETALLE tg
						ON tg.tbcodigo1 = cares.cacartera_normativa AND tg.tbcateg = 1111
					INNER JOIN BacParamsuda.dbo.USUARIO us
						ON us.usuario = cares.caoperador
					INNER JOIN BacParamsuda.dbo.FORMA_DE_PAGO fp1
						ON fp1.codigo = cares.cafpagomn
					WHERE cares.canumoper = @NumOper AND cares.caFechaProceso = @caFecha
		END

		IF @FolioMod = 1
		BEGIN
						
			--> a) Grabar la operación original en tabla de modificaciones con datos antiguos (no nuevos) con folio = 0
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item, DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 1, 'NRO. MODIFICACION', CONVERT(VARCHAR(255), 0), ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item, DatosOriginales, DatosNuevos)
			---VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 2, 'FECHA MODIFICACION', CONVERT(VARCHAR(255), @fechaMod, 105), ' ')
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 2, 'FECHA MODIFICACION', ' ', ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 3, 'FECHA OPERACION', @aFechaOpe_03, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 4, 'NUMERO CONTRATO', CONVERT(VARCHAR(255), @NumOper), ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 5, 'TIPO PRODUCTO', @aTipoProd_05, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 6, 'NOMBRE CLIENTE', @anomCliente_06, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 7, 'TIPO OPERACION', @atipoOper_07, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 8, 'PLAZO OPERACION', @aplazo_08 ,' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 9, 'DIAS PRORROGADOS','0',' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 10, 'FECHA VENCIMIENTO', @afechaVcto_10, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 11, 'FECHA EFECTIVA', @afechaEfect_11, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 12, 'MONEDA', @aMoneda_12, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 13, 'MONTO M/X', @aMontoMX_13, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 14, 'PRECIO', @aPrecio_14, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 15, 'T/C FINAL', @aTCFinal_15, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 16, 'VARIACION %', '0.000000000',' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 17, 'MONTO FINAL', @aMontofinal_17, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 18, 'MODALIDAD', @aModalidad_18, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 19, 'CARTERA', @aCartera_19, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 20, 'PAGO M/N', @aPagoMN_20, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 21, 'PAGO M/X', @aPagoMX_21, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 22, 'MTM', @aMTM_22, ' ')
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 23, 'OPERADOR', @aOperador_23, ' ')

			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, 0, 24, 'HORA', @aHora_24, ' ')
		
		END
		
		---> Buscar la operación recién grabada en MFCA para completar el item DatosNuevos
		
		SELECT 	 @nFechaMod_02		= acfecproc FROM BacFwdSuda.dbo.MFAC
		
		SELECT	 @nNumMod_01		= CONVERT(VARCHAR(255), @FolioMod)
				,@nFechaOpe_03		= CONVERT(VARCHAR(255), ca.cafecha, 105)
				,@nNumOper_04		= CONVERT(VARCHAR(255), @NumOper)
				,@nTipoProd_05		= @tipoProducto
				,@nnomCliente_06	= cl.Clnombre
				,@ntipoOper_07		= CASE ca.catipoper WHEN 'C' THEN 'COMPRA' WHEN 'V' THEN 'VENTA' END
				,@nplazo_08			= CONVERT(VARCHAR(255), ca.caplazo)
				,@nfechaVcto_10		= CONVERT(VARCHAR(255), ca.cafecvcto, 105)
				,@nfechaEfect_11	= CONVERT(VARCHAR(255), ca.cafecEfectiva, 105)
				,@nMoneda_12		= mo.mnglosa
				,@nMontoMX_13		= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), ca.camtomon1))
				,@nPrecio_14		= CASE ca.cacodpos1 WHEN 2 THEN CONVERT(VARCHAR(255), ca.caparmon1) ELSE CONVERT(VARCHAR(255), ca.caprecal) END
				,@nTCFinal_15		= CONVERT(VARCHAR(255), CONVERT(NUMERIC(19,2), ca.capremon1))
				,@nVariacion_16 	= ' '
				,@nMontofinal_17	= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), ca.camtomon2))
				,@nModalidad_18		= CASE ca.catipmoda WHEN 'C' THEN 'COMPENSACION' WHEN 'E' THEN 'ENTREGA FISICA' END
				,@nCartera_19		= tg.tbglosa
				,@nPagoMN_20		= fp1.glosa
				,@nPagoMX_21		= CASE WHEN ca.cafpagomx = 0 THEN 'NO APLICABLE'
									   WHEN ca.cafpagomx > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
											WHERE fp.codigo = ca.cafpagomx)
									  END
				,@nMTM_22			= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), ca.fRes_Obtenido))
				,@nOperador_23		= us.nombre
				,@nHora_24			= @horaMod
				FROM BacFwdSuda.dbo.MFCA ca
				INNER JOIN BacParamsuda.dbo.CLIENTE cl
					ON cl.Clrut = ca.cacodigo AND cl.Clcodigo = ca.cacodcli
				INNER JOIN BacParamsuda.dbo.MONEDA mo
					ON ca.cacodmon1 = mo.mncodmon
				INNER JOIN BacParamsuda.dbo.TABLA_GENERAL_DETALLE tg
					ON tg.tbcodigo1 = ca.cacartera_normativa AND tg.tbcateg = 1111
				INNER JOIN BacParamsuda.dbo.USUARIO us
					ON us.usuario = ca.caoperador
				INNER JOIN BacParamsuda.dbo.FORMA_DE_PAGO fp1
					ON fp1.codigo = ca.cafpagomn
				WHERE ca.canumoper = @NumOper
			
			---> Calcular los días prorrogados y el % de variación del Precio
			SELECT @Prorroga = CONVERT(INTEGER, @nPlazo_08) - CONVERT(INTEGER, @aPlazo_08)
			IF CONVERT(NUMERIC(21,9), @aPrecio_14) > 0.000
				SELECT @Variacion = ( CONVERT(NUMERIC(21,9), @nPrecio_14) / CONVERT(NUMERIC(21,9), @aPrecio_14) )*100.0 - 100.0
			ELSE
				SELECT @Variacion = 0.0
			
			---> b) Grabar la operación nueva en tabla TBL_REG_MODIFICACIONES
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item, DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 1, 'NRO. MODIFICACION', CONVERT(VARCHAR(255), 0), CONVERT(VARCHAR(255), @FolioMod))
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item, DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 2, 'FECHA MODIFICACION', ' ', CONVERT(VARCHAR(255), @fechaMod, 105))
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 3, 'FECHA OPERACION', @aFechaOpe_03, CONVERT(VARCHAR(255), @fechaOper, 105))
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 4, 'NUMERO CONTRATO', CONVERT(VARCHAR(255), @NumOper), CONVERT(VARCHAR(255), @NumOper))
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 5, 'TIPO PRODUCTO', @aTipoProd_05, @nTipoProd_05 )
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 6, 'NOMBRE CLIENTE', @anomCliente_06, @nnomCliente_06)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 7, 'TIPO OPERACION', @atipoOper_07, @ntipoOper_07)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 8, 'PLAZO OPERACION', @aplazo_08, @nplazo_08)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 9, 'DIAS PRORROGADOS','0', CONVERT(VARCHAR(255),@Prorroga))
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 10, 'FECHA VENCIMIENTO', @afechaVcto_10, @nfechaVcto_10)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 11, 'FECHA EFECTIVA', @afechaEfect_11, @nfechaEfect_11)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 12, 'MONEDA', @aMoneda_12, @nMoneda_12)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 13, 'MONTO M/X', @aMontoMX_13, @nMontoMX_13)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 14, 'PRECIO', @aPrecio_14, @nPrecio_14)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 15, 'T/C FINAL', @aTCFinal_15, @nTCFinal_15)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 16, 'VARIACION %', '0.000000000',CONVERT(VARCHAR(255), @Variacion))
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 17, 'MONTO FINAL', @aMontofinal_17, @nMontofinal_17)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 18, 'MODALIDAD', @aModalidad_18, @nModalidad_18)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 19, 'CARTERA', @aCartera_19, @nCartera_19)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 20, 'PAGO M/N', @aPagoMN_20, @nPagoMN_20)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 21, 'PAGO M/X', @aPagoMX_21, @nPagoMX_21)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 22, 'MTM', @aMTM_22, @nMTM_22)
			
			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 23, 'OPERADOR', @aOperador_23, @nOperador_23)

			INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
			FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
			VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 24, 'HORA', @aHora_24, @nHora_24)

	END

END
GO
