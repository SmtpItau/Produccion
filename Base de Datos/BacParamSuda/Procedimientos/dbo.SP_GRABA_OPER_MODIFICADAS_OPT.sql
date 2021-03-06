USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_GRABA_OPER_MODIFICADAS_OPT]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_GRABA_OPER_MODIFICADAS_OPT]
		(
			@NumOper		NUMERIC(10, 0)
		,	@Origen			CHAR(1) 
		,	@antFolio		NUMERIC(10, 0)
		,	@actFolio		NUMERIC(10, 0)
		,	@antPosicion	NUMERIC(10, 0)
		,	@actPosicion	NUMERIC(10, 0)
		)
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE  @Modulo 		CHAR(3)
			,@NumFolio		NUMERIC( 8, 0)
			,@moFecha		DATETIME
			,@fechaOper		DATETIME
			,@fechaMod		DATETIME
			,@horaMod		VARCHAR(8)
			,@FolioMod		NUMERIC( 9,0)
			,@Prorroga		INTEGER
			,@Variacion		NUMERIC(21,9)
			,@tipoProd		VARCHAR(10)
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
			
		SELECT @Modulo = 'OPT'	
	
		IF @Origen = 'M'
			SELECT 	 @moFecha	= MoFechaContrato
					,@tipoProd  = MoCodEstructura
			FROM lnkOpc.CbMdbOpc.dbo.MoEncContrato WHERE MoNumContrato = @NumOper
			AND MoNumFolio = @actFolio
			AND MoTipoTransaccion = 'MODIFICA'		
		ELSE
			SELECT 	 @moFecha	= MoFechaContrato
					,@tipoProd  = MoCodEstructura
			FROM lnkOpc.CbMdbOpc.dbo.MoHisEncContrato WHERE MoNumContrato = @NumOper
			AND MoNumFolio = @actFolio
			AND MoTipoTransaccion = 'MODIFICA'		
				
		SELECT @tipoProducto = OpcEstDsc FROM lnkOpc.CbMdbOpc.dbo.OpcionEstructura WHERE OpcEstCod = @tipoProd
		SELECT @fechaOper = @moFecha

		/*
		Proceso: Tomar los datos de la operación con el folio @antFolio y grabarlo en TBL_REG_MODIFICACIONES_OPT 
		con @FolioMod = @antPosicion
		Luego, hacer lo mismo con el folio @actFolio y dejar @FolioMod = @actPosicion
		*/
		--> Primer paso, grabar el folio @antFolio en TBL_REG_MODIFICACIONES_OPT
		SELECT @FolioMod = @antPosicion

		---SELECT @fechaMod	= fechaproc FROM lnkOpc.CbMdbOpc.dbo.OPCIONESGENERAL
		---> @fechaMod es la fecha real de la operación seleccionada
		
		SELECT @horaMod		= CONVERT(VARCHAR(255), getdate(), 108)

		SELECT 	 @aFechaMod_02 		= ' '
				,@aVariacion_16		= ' '
				,@aHora_24			= ' '
		
		SELECT	 @aFechaMod_02		= DatosOriginales FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT
				WHERE Modulo = @Modulo AND FolioContrato = @NumOper AND FolioModificacion = 0 AND Correlativo = 2
				
		SELECT  @aVariacion_16		= DatosOriginales FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT
				WHERE Modulo = @Modulo AND FolioContrato = @NumOper AND FolioModificacion = 0 AND Correlativo = 16
				
		SELECT  @aHora_24			= DatosOriginales FROM BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT
				WHERE Modulo = @Modulo AND FolioContrato = @NumOper AND FolioModificacion = 0 AND Correlativo = 24
		
		---> Tomar los datos antiguos de la tabla.
		IF @Origen = 'M'
		BEGIN
			
			/*
			Si @antFolio = 0 ==> Traer los datos de la operación original que está en MoHisEncContrato/MoHisDetContrato
			con enca->MoTipoTransaccion = 'CREACION'
			*/
			IF @antFolio = 0
			BEGIN
				SELECT @NumFolio = MoNumFolio FROM lnkOpc.CbMdbOpc.dbo.MoHisEncContrato
				WHERE MoNumContrato = @NumOper AND MoTipoTransaccion = 'CREACION'
			
				SELECT TOP 1 * INTO #tmpMoHisDetContratoh
				FROM lnkOpc.CbMdbOpc.dbo.MoHisDetContrato WHERE MoNumFolio = @NumFolio
				
				SELECT	 @aNumMod_01		= CONVERT(VARCHAR(255), @FolioMod)
				
				SELECT   @aFechaMod_02 		= CONVERT(VARCHAR(255), '') --->CONVERT(VARCHAR(255), moenc.MoFechaCreacionRegistro, 105)
						,@aFechaOpe_03		= CONVERT(VARCHAR(255), moenc.MoFechaContrato, 105)
						,@aNumOper_04		= CONVERT(VARCHAR(255), @NumOper)
						,@aTipoProd_05		= @tipoProducto
						,@anomCliente_06	= cl.Clnombre
						,@atipoOper_07		= CASE modet.MoCVOpc WHEN 'C' THEN 'COMPRA' WHEN 'V' THEN 'VENTA' END
						,@aplazo_08			= CONVERT(VARCHAR(255), DATEDIFF(dd, modet.MoFechaInicioOpc, modet.MoFechaVcto) )
						,@afechaVcto_10		= CONVERT(VARCHAR(255), modet.MoFechaVcto, 105)
						,@afechaEfect_11	= CONVERT(VARCHAR(255), modet.MoFechaFijacion, 105)
						,@aMoneda_12		= mo.mnglosa
						,@aMontoMX_13		= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon1))
						,@aPrecio_14		= CONVERT(VARCHAR(255), modet.MoStrike)
						,@aTCFinal_15		= CONVERT(VARCHAR(255), 0)
						,@aMontofinal_17	= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon2))
						,@aModalidad_18		= CASE modet.MoModalidad WHEN 'C' THEN 'COMPENSACION' WHEN 'E' THEN 'ENTREGA FISICA' END
						,@aCartera_19		= tg.tbglosa
						,@aPagoMN_20		= CASE WHEN moenc.MofPagoPrima = 0 THEN 'NO APLICABLE'
											   WHEN moenc.MofPagoPrima > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
													WHERE fp.codigo = moenc.MofPagoPrima)
											  END
						,@aPagoMX_21		= CASE WHEN modet.MoFormaPagoComp = 0 THEN 'NO APLICABLE'
											   WHEN modet.MoFormaPagoComp > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
													WHERE fp.codigo = modet.MoFormaPagoComp)
											  END
						,@aMTM_22			= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), moenc.MoVr))
						,@aOperador_23		= us.nombre
						FROM lnkOpc.CbMdbOpc.dbo.MoHisEncContrato moenc
						INNER JOIN #tmpMoHisDetContratoh modet
							ON moenc.MoNumFolio = modet.MoNumFolio
						INNER JOIN BacParamsuda.dbo.CLIENTE cl
							ON cl.Clrut = moenc.MoRutCliente AND cl.Clcodigo = moenc.MoCodigo
						INNER JOIN BacParamsuda.dbo.MONEDA mo
							ON modet.MoCodMon1 = mo.mncodmon
						INNER JOIN BacParamsuda.dbo.TABLA_GENERAL_DETALLE tg
							ON tg.tbcodigo1 = moenc.MoCarNormativa AND tg.tbcateg = 1111
						INNER JOIN BacParamsuda.dbo.USUARIO us
							ON us.usuario = moenc.MoOperador
						WHERE moenc.MoNumContrato = @NumOper
						AND moenc.MoTipoTransaccion = 'CREACION'
			END
			ELSE	---> @antFolio > 0
			BEGIN
				SELECT @NumFolio = @antFolio
				
				---> Pasar a temporal el primer registro de MoDetContrato con NumFolio = @NumFolio
				SELECT TOP 1 * INTO #tmpMoDetContrato
				FROM lnkOpc.CbMdbOpc.dbo.MoDetContrato WHERE MoNumFolio = @NumFolio
			
				SELECT	 @aNumMod_01		= CONVERT(VARCHAR(255), @FolioMod)
				
				SELECT   @aFechaMod_02 		= CONVERT(VARCHAR(255), moenc.MoFechaCreacionRegistro, 105)
						,@aFechaOpe_03		= CONVERT(VARCHAR(255), moenc.MoFechaContrato, 105)
						,@aNumOper_04		= CONVERT(VARCHAR(255), @NumOper)
						,@aTipoProd_05		= @tipoProducto
						,@anomCliente_06	= cl.Clnombre
						,@atipoOper_07		= CASE modet.MoCVOpc WHEN 'C' THEN 'COMPRA' WHEN 'V' THEN 'VENTA' END
						,@aplazo_08			= CONVERT(VARCHAR(255), DATEDIFF(dd,modet.MoFechaInicioOpc, modet.MoFechaVcto) )
						,@afechaVcto_10		= CONVERT(VARCHAR(255), modet.MoFechaVcto, 105)
						,@afechaEfect_11	= CONVERT(VARCHAR(255), modet.MoFechaFijacion, 105)
						,@aMoneda_12		= mo.mnglosa
						,@aMontoMX_13		= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon1))
						,@aPrecio_14		= CONVERT(VARCHAR(255), modet.MoStrike)
						,@aTCFinal_15		= CONVERT(VARCHAR(255), 0)
						,@aMontofinal_17	= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon2))
						,@aModalidad_18		= CASE modet.MoModalidad WHEN 'C' THEN 'COMPENSACION' WHEN 'E' THEN 'ENTREGA FISICA' END
						,@aCartera_19		= tg.tbglosa
						,@aPagoMN_20		= CASE WHEN moenc.MofPagoPrima = 0 THEN 'NO APLICABLE'
											   WHEN moenc.MofPagoPrima > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
													WHERE fp.codigo = moenc.MofPagoPrima)
											  END
						,@aPagoMX_21		= CASE WHEN modet.MoFormaPagoComp = 0 THEN 'NO APLICABLE'
											   WHEN modet.MoFormaPagoComp > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
													WHERE fp.codigo = modet.MoFormaPagoComp)
											  END
						,@aMTM_22			= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), moenc.MoVr))
						,@aOperador_23		= us.nombre
						,@aHora_24			= CONVERT(VARCHAR(255), moenc.MoFechaCreacionRegistro, 108)
						FROM lnkOpc.CbMdbOpc.dbo.MoEncContrato moenc
						INNER JOIN #tmpMoDetContrato modet
							ON moenc.MoNumFolio = modet.MoNumFolio
						INNER JOIN BacParamsuda.dbo.CLIENTE cl
							ON cl.Clrut = moenc.MoRutCliente AND cl.Clcodigo = moenc.MoCodigo
						INNER JOIN BacParamsuda.dbo.MONEDA mo
							ON modet.MoCodMon1 = mo.mncodmon
						INNER JOIN BacParamsuda.dbo.TABLA_GENERAL_DETALLE tg
							ON tg.tbcodigo1 = moenc.MoCarNormativa AND tg.tbcateg = 1111
						INNER JOIN BacParamsuda.dbo.USUARIO us
							ON us.usuario = moenc.MoOperador
						WHERE moenc.MoNumContrato = @NumOper
						AND moenc.MoTipoTransaccion = 'MODIFICA'
						AND moenc.MoNumFolio = @NumFolio
			END		
		END
		ELSE	---> Origen = 'H', Datos historicos
		BEGIN
		/*
		Si @antFolio = 0 ==> Traer los datos de la operación original que está en MoHisEncContrato/MoHisDetContrato
		con enca->MoTipoTransaccion = 'CREACION'
		*/
			IF @antFolio = 0
			BEGIN
				SELECT @NumFolio = MoNumFolio FROM lnkOpc.CbMdbOpc.dbo.MoHisEncContrato
				WHERE MoNumContrato = @NumOper AND MoTipoTransaccion = 'CREACION'
			
				SELECT TOP 1 * INTO #tmpMoHisDetContratohh
				FROM lnkOpc.CbMdbOpc.dbo.MoHisDetContrato WHERE MoNumFolio = @NumFolio
				
				SELECT	 @aNumMod_01		= CONVERT(VARCHAR(255), @FolioMod)
				
				SELECT   @aFechaMod_02 		= CONVERT(VARCHAR(255), '') --->CONVERT(VARCHAR(255), moenc.MoFechaCreacionRegistro, 105)
						,@aFechaOpe_03		= CONVERT(VARCHAR(255), moenc.MoFechaContrato, 105)
						,@aNumOper_04		= CONVERT(VARCHAR(255), @NumOper)
						,@aTipoProd_05		= @tipoProducto
						,@anomCliente_06	= cl.Clnombre
						,@atipoOper_07		= CASE modet.MoCVOpc WHEN 'C' THEN 'COMPRA' WHEN 'V' THEN 'VENTA' END
						,@aplazo_08			= CONVERT(VARCHAR(255), DATEDIFF(dd, modet.MoFechaInicioOpc, modet.MoFechaVcto) )
						,@afechaVcto_10		= CONVERT(VARCHAR(255), modet.MoFechaVcto, 105)
						,@afechaEfect_11	= CONVERT(VARCHAR(255), modet.MoFechaFijacion, 105)
						,@aMoneda_12		= mo.mnglosa
						,@aMontoMX_13		= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon1))
						,@aPrecio_14		= CONVERT(VARCHAR(255), modet.MoStrike)
						,@aTCFinal_15		= CONVERT(VARCHAR(255), 0)
						,@aMontofinal_17	= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon2))
						,@aModalidad_18		= CASE modet.MoModalidad WHEN 'C' THEN 'COMPENSACION' WHEN 'E' THEN 'ENTREGA FISICA' END
						,@aCartera_19		= tg.tbglosa
						,@aPagoMN_20		= CASE WHEN moenc.MofPagoPrima = 0 THEN 'NO APLICABLE'
											   WHEN moenc.MofPagoPrima > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
													WHERE fp.codigo = moenc.MofPagoPrima)
											  END
						,@aPagoMX_21		= CASE WHEN modet.MoFormaPagoComp = 0 THEN 'NO APLICABLE'
											   WHEN modet.MoFormaPagoComp > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
													WHERE fp.codigo = modet.MoFormaPagoComp)
											  END
						,@aMTM_22			= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), moenc.MoVr))
						,@aOperador_23		= us.nombre
						FROM lnkOpc.CbMdbOpc.dbo.MoHisEncContrato moenc
						INNER JOIN #tmpMoHisDetContratohh modet
							ON moenc.MoNumFolio = modet.MoNumFolio
						INNER JOIN BacParamsuda.dbo.CLIENTE cl
							ON cl.Clrut = moenc.MoRutCliente AND cl.Clcodigo = moenc.MoCodigo
						INNER JOIN BacParamsuda.dbo.MONEDA mo
							ON modet.MoCodMon1 = mo.mncodmon
						INNER JOIN BacParamsuda.dbo.TABLA_GENERAL_DETALLE tg
							ON tg.tbcodigo1 = moenc.MoCarNormativa AND tg.tbcateg = 1111
						INNER JOIN BacParamsuda.dbo.USUARIO us
							ON us.usuario = moenc.MoOperador
						WHERE moenc.MoNumContrato = @NumOper
						AND moenc.MoTipoTransaccion = 'CREACION'
			END		
			ELSE
			BEGIN
				SELECT @NumFolio = @antFolio
				
				---> Pasar a temporal el primer registro de MoHisDetContrato con NumFolio = @NumFolio
				SELECT TOP 1 * INTO #tmpMoHisDetContrato
				FROM lnkOpc.CbMdbOpc.dbo.MoHisDetContrato WHERE MoNumFolio = @NumFolio
				
				SELECT	 @aNumMod_01		= CONVERT(VARCHAR(255), @FolioMod)

				SELECT   @aFechaMod_02 		= CONVERT(VARCHAR(255), moenc.MoFechaCreacionRegistro, 105)
						,@aFechaOpe_03		= CONVERT(VARCHAR(255), moenc.MoFechaContrato, 105)				
						,@aNumOper_04		= CONVERT(VARCHAR(255), @NumOper)
						,@aTipoProd_05		= @tipoProducto
						,@anomCliente_06	= cl.Clnombre
						,@atipoOper_07		= CASE modet.MoCVOpc WHEN 'C' THEN 'COMPRA' WHEN 'V' THEN 'VENTA' END
						,@aplazo_08			= CONVERT(VARCHAR(255), DATEDIFF(dd,modet.MoFechaInicioOpc, modet.MoFechaVcto) )
						,@afechaVcto_10		= CONVERT(VARCHAR(255), modet.MoFechaVcto, 105)
						,@afechaEfect_11	= CONVERT(VARCHAR(255), modet.MoFechaFijacion, 105)
						,@aMoneda_12		= mo.mnglosa
						,@aMontoMX_13		= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon1))
						,@aPrecio_14		= CONVERT(VARCHAR(255), modet.MoStrike)
						,@aTCFinal_15		= CONVERT(VARCHAR(255), modet.MoStrike)
						,@aMontofinal_17	= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon2))
						,@aModalidad_18		= CASE modet.MoModalidad WHEN 'C' THEN 'COMPENSACION' WHEN 'E' THEN 'ENTREGA FISICA' END
						,@aCartera_19		= tg.tbglosa
						,@aPagoMN_20		= CASE WHEN moenc.MofPagoPrima = 0 THEN 'NO APLICABLE'
											   WHEN moenc.MofPagoPrima > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
													WHERE fp.codigo = moenc.MofPagoPrima)
											  END
						,@aPagoMX_21		= CASE WHEN modet.MoFormaPagoComp = 0 THEN 'NO APLICABLE'
											   WHEN modet.MoFormaPagoComp > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
													WHERE fp.codigo = modet.MoFormaPagoComp)
											  END
						,@aMTM_22			= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), moenc.MoVr))
						,@aOperador_23		= us.nombre
						FROM lnkOpc.CbMdbOpc.dbo.MoHisEncContrato moenc
						INNER JOIN #tmpMoHisDetContrato modet
							ON moenc.moNumFolio = modet.MoNumFolio
						INNER JOIN BacParamsuda.dbo.CLIENTE cl
							ON cl.Clrut = moenc.MoRutCliente AND cl.Clcodigo = moenc.MoCodigo
						INNER JOIN BacParamsuda.dbo.MONEDA mo
							ON modet.MoCodMon1 = mo.mncodmon
						INNER JOIN BacParamsuda.dbo.TABLA_GENERAL_DETALLE tg
							ON tg.tbcodigo1 = moenc.MoCarNormativa AND tg.tbcateg = 1111
						INNER JOIN BacParamsuda.dbo.USUARIO us
							ON us.usuario = moenc.MoOperador
						WHERE moenc.MoNumContrato = @NumOper
						AND moenc.MoTipoTransaccion = 'MODIFICA'
						AND moenc.MoNumFolio = @NumFolio
			END
		END
		
		---> Buscar la operación recién grabada en archivo de Movimientos de Opciones para completar el item DatosNuevos
		---> o en el historico, según el @Origen
		
		---> 2° PASO
		
		---SELECT 	 @nFechaMod_02		= fechaproc FROM lnkOpc.CbMdbOpc.dbo.OPCIONESGENERAL

		SELECT 	@NumFolio = @actFolio,
				@FolioMod = @actPosicion

		IF @Origen = 'M'
		BEGIN	
			SELECT TOP 1 * INTO #tmpMoDetContrato1
			FROM lnkOpc.CbMdbOpc.dbo.MoDetContrato WHERE MoNumFolio = @NumFolio
		
			SELECT	 @nNumMod_01		= CONVERT(VARCHAR(255), @FolioMod)
					,@nFechaMod_02		= CONVERT(VARCHAR(255), moenc.MoFechaCreacionRegistro, 105)
					,@fechaMod 			= CONVERT(DATETIME, CONVERT(VARCHAR(10), moenc.MoFechaCreacionRegistro, 112))
					,@nFechaOpe_03		= CONVERT(VARCHAR(255), moenc.MoFechaContrato, 105)
					,@nNumOper_04		= CONVERT(VARCHAR(255), @NumOper)
					,@nTipoProd_05		= @tipoProducto
					,@nnomCliente_06	= cl.Clnombre
					,@ntipoOper_07		= CASE modet.MoCVOpc WHEN 'C' THEN 'COMPRA' WHEN 'V' THEN 'VENTA' END
					,@nplazo_08			= CONVERT(VARCHAR(255), DATEDIFF(dd, modet.MoFechaInicioOpc, modet.MoFechaVcto)) 
					,@nfechaVcto_10		= CONVERT(VARCHAR(255), modet.MoFechaVcto, 105)
					,@nfechaEfect_11	= CONVERT(VARCHAR(255), modet.MoFechaFijacion, 105)
					,@nMoneda_12		= mo.mnglosa
					,@nMontoMX_13		= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon1))
					,@nPrecio_14		= CONVERT(VARCHAR(255), modet.MoStrike)
					,@nTCFinal_15		= CONVERT(VARCHAR(255), modet.MoStrike)
					,@nMontofinal_17	= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon2))
					,@nModalidad_18		= CASE modet.MoModalidad WHEN 'C' THEN 'COMPENSACION' WHEN 'E' THEN 'ENTREGA FISICA' END
					,@nCartera_19		= tg.tbglosa
					,@nPagoMN_20		= CASE WHEN moenc.MofPagoPrima = 0 THEN 'NO APLICABLE'
										   WHEN moenc.MofPagoPrima > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
												WHERE fp.codigo = moenc.MofPagoPrima)
										  END
					,@nPagoMX_21		= CASE WHEN modet.MoFormaPagoComp = 0 THEN 'NO APLICABLE'
										   WHEN modet.MoFormaPagoComp > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
												WHERE fp.codigo = modet.MoformaPagoComp)
										  END
					,@nMTM_22			= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), moenc.MoVr))
					,@nOperador_23		= us.nombre
					,@nHora_24			= CONVERT(VARCHAR(255), moenc.MoFechaCreacionRegistro, 108)	---@horaMod
					FROM lnkOpc.CbMdbOpc.dbo.MoEncContrato moenc
					INNER JOIN #tmpMoDetContrato1 modet
						ON moenc.MoNumFolio = modet.MoNumFolio
					INNER JOIN BacParamsuda.dbo.CLIENTE cl
						ON cl.Clrut = moenc.MoRutCliente AND cl.Clcodigo = moenc.MoCodigo
					INNER JOIN BacParamsuda.dbo.MONEDA mo
						ON modet.MoCodMon1 = mo.mncodmon
					INNER JOIN BacParamsuda.dbo.TABLA_GENERAL_DETALLE tg
						ON tg.tbcodigo1 = moenc.MoCarNormativa AND tg.tbcateg = 1111
					INNER JOIN BacParamsuda.dbo.USUARIO us
						ON us.usuario = moenc.MoOperador
					WHERE moenc.MoNumContrato = @NumOper
					AND moenc.MoTipoTransaccion = 'MODIFICA'
					AND moenc.MoNumFolio = @NumFolio
		END
		ELSE
		BEGIN
			SELECT TOP 1 * INTO #tmpMoHisDetContrato1
			FROM lnkOpc.CbMdbOpc.dbo.MoHisDetContrato WHERE MoNumFolio = @NumFolio
		
			SELECT	 @nNumMod_01		= CONVERT(VARCHAR(255), @FolioMod)
					,@nFechaMod_02		= CONVERT(VARCHAR(255), moenc.MoFechaCreacionRegistro, 105)
					,@fechaMod 			= CONVERT(DATETIME, CONVERT(VARCHAR(10), moenc.MoFechaCreacionRegistro, 112))
					,@nFechaOpe_03		= CONVERT(VARCHAR(255), moenc.MoFechaContrato, 105)
					,@nNumOper_04		= CONVERT(VARCHAR(255), @NumOper)
					,@nTipoProd_05		= @tipoProducto
					,@nnomCliente_06	= cl.Clnombre
					,@ntipoOper_07		= CASE modet.MoCVOpc WHEN 'C' THEN 'COMPRA' WHEN 'V' THEN 'VENTA' END
					,@nplazo_08			= CONVERT(VARCHAR(255), DATEDIFF(dd, modet.MoFechaInicioOpc, modet.MoFechaVcto)) 
					,@nfechaVcto_10		= CONVERT(VARCHAR(255), modet.MoFechaVcto, 105)
					,@nfechaEfect_11	= CONVERT(VARCHAR(255), modet.MoFechaFijacion, 105)
					,@nMoneda_12		= mo.mnglosa
					,@nMontoMX_13		= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon1))
					,@nPrecio_14		= CONVERT(VARCHAR(255), modet.MoStrike)
					,@nTCFinal_15		= CONVERT(VARCHAR(255), modet.MoStrike)
					,@nMontofinal_17	= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), modet.MoMontoMon2))
					,@nModalidad_18		= CASE modet.MoModalidad WHEN 'C' THEN 'COMPENSACION' WHEN 'E' THEN 'ENTREGA FISICA' END
					,@nCartera_19		= tg.tbglosa
					,@nPagoMN_20		= CASE WHEN moenc.MofPagoPrima = 0 THEN 'NO APLICABLE'
										   WHEN moenc.MofPagoPrima > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
												WHERE fp.codigo = moenc.MofPagoPrima)
										  END
					,@nPagoMX_21		= CASE WHEN modet.MoFormaPagoComp = 0 THEN 'NO APLICABLE'
										   WHEN modet.MoFormaPagoComp > 0 THEN (SELECT fp.glosa FROM BacParamsuda.dbo.FORMA_DE_PAGO fp
												WHERE fp.codigo = modet.MoformaPagoComp)
										  END
					,@nMTM_22			= CONVERT(VARCHAR(255), CONVERT(NUMERIC(21,4), moenc.MoVr))
					,@nOperador_23		= us.nombre
					,@nHora_24			= CONVERT(VARCHAR(255), moenc.MoFechaCreacionRegistro, 108)	---@horaMod
					FROM lnkOpc.CbMdbOpc.dbo.MoHisEncContrato moenc
					INNER JOIN #tmpMoHisDetContrato1 modet
						ON moenc.MoNumFolio = modet.MoNumFolio
					INNER JOIN BacParamsuda.dbo.CLIENTE cl
						ON cl.Clrut = moenc.MoRutCliente AND cl.Clcodigo = moenc.MoCodigo
					INNER JOIN BacParamsuda.dbo.MONEDA mo
						ON modet.MoCodMon1 = mo.mncodmon
					INNER JOIN BacParamsuda.dbo.TABLA_GENERAL_DETALLE tg
						ON tg.tbcodigo1 = moenc.MoCarNormativa AND tg.tbcateg = 1111
					INNER JOIN BacParamsuda.dbo.USUARIO us
						ON us.usuario = moenc.MoOperador
					WHERE moenc.MoNumContrato = @NumOper
					AND moenc.MoTipoTransaccion = 'MODIFICA'
					AND moenc.MoNumFolio = @NumFolio
		END
		---> Calcular los días prorrogados y el % de variación del Precio
		SELECT @Prorroga = CONVERT(INTEGER, @nPlazo_08) - CONVERT(INTEGER, @aPlazo_08)
		IF CONVERT(NUMERIC(21,9), @aPrecio_14) > 0.000
			SELECT @Variacion = ( CONVERT(NUMERIC(21,9), @nPrecio_14) / CONVERT(NUMERIC(21,9), @aPrecio_14) )*100.0 - 100.0
		ELSE
			SELECT @Variacion = 0.0
		
		---> b) Grabar la operación nueva en tabla TBL_REG_MODIFICACIONES_OPT
						
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item, DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 1, 'NRO. MODIFICACION', CONVERT(VARCHAR(255), @antPosicion), CONVERT(VARCHAR(255), @FolioMod))
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item, DatosOriginales, DatosNuevos)
		---VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 2, 'FECHA MODIFICACION', @aFechaMod_02, CONVERT(VARCHAR(255), @fechaMod, 105))
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 2, 'FECHA MODIFICACION', @aFechaMod_02, @nFechaMod_02)		
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 3, 'FECHA OPERACION', @aFechaOpe_03, CONVERT(VARCHAR(255), @fechaOper, 105))
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 4, 'NUMERO CONTRATO', CONVERT(VARCHAR(255), @NumOper), CONVERT(VARCHAR(255), @NumOper))
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 5, 'TIPO PRODUCTO', @aTipoProd_05, @nTipoProd_05 )
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 6, 'NOMBRE CLIENTE', @anomCliente_06, @nnomCliente_06)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 7, 'TIPO OPERACION', @atipoOper_07, @ntipoOper_07)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 8, 'PLAZO OPERACION', @aplazo_08, @nplazo_08)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 9, 'DIAS PRORROGADOS','0', CONVERT(VARCHAR(255),@Prorroga))
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 10, 'FECHA VENCIMIENTO', @afechaVcto_10, @nfechaVcto_10)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 11, 'FECHA EFECTIVA', @afechaEfect_11, @nfechaEfect_11)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 12, 'MONEDA', @aMoneda_12, @nMoneda_12)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 13, 'MONTO M/X', @aMontoMX_13, @nMontoMX_13)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 14, 'PRECIO', @aPrecio_14, @nPrecio_14)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 15, 'T/C FINAL', @aTCFinal_15, @nTCFinal_15)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 16, 'VARIACION %', '0.000000000',CONVERT(VARCHAR(255), @Variacion))
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 17, 'MONTO FINAL', @aMontofinal_17, @nMontofinal_17)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 18, 'MODALIDAD', @aModalidad_18, @nModalidad_18)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 19, 'CARTERA', @aCartera_19, @nCartera_19)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 20, 'PAGO M/N', @aPagoMN_20, @nPagoMN_20)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 21, 'PAGO M/X', @aPagoMX_21, @nPagoMX_21)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 22, 'MTM', @aMTM_22, @nMTM_22)
		
		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 23, 'OPERADOR', @aOperador_23, @nOperador_23)

		INSERT INTO BacParamsuda.dbo.TBL_REG_MODIFICACIONES_OPT(FechaModificacion, HoraModificacion, Modulo, FolioContrato,
		FolioModificacion, Correlativo, Item,  DatosOriginales, DatosNuevos)
		VALUES(@fechaMod, @horaMod, @Modulo, @NumOper, @FolioMod, 24, 'HORA', @aHora_24, @nHora_24)

END
GO
