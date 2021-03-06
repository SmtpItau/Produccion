USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NGINE_ENVIO_PAGO_XML]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_NGINE_ENVIO_PAGO_XML] (	@Fecha_proceso		datetime
												,@Sistema			varchar(3)
												,@Numero_operacion	numeric(10))
AS
BEGIN
	DECLARE
		-- Variables
		@CodigoCanal					numeric(3)
		,@CodigoAplicacion				numeric(3)
		,@NombreAplicacion				varchar(10)
		,@CodigoSistema					varchar(10)
		,@Numerooperacion				numeric(10)
		,@CodigoProducto				varchar(10)
		,@CodigoProductoEquivalente		varchar(10)
		,@NemotecnicoTipoInstrumento	varchar(12)
		,@Valornominal					numeric(19,4)
		,@Tir							numeric(19,4)
		,@Valorcompra					numeric(19,4)
		,@ClaveOperacion				varchar(10)
		,@CorrelativoRegistro			numeric(3)
		,@XML_pago_documento			varchar(4000)
		,@XML_pago_operacion			varchar(4000)
		,@FormaPagoEquivalente			varchar(10)
		,@CodigoValutaEquivalente		numeric (3)

		-- Parametros tabla_general_detalle EQUIVALENCIAS 
		,@EQUsuarioMDP					numeric(4)= 9929    --Usuario MDP
		,@EQSistema						numeric(4)= 9930    --Equivalencia Sistema
		,@EQXmlParametros				numeric(4)= 9931    --Parametros XML canal,appcod y appnombre
		,@EQProducto					numeric(4)= 9932	--Equivalencia Producto
		,@EQFormaPago					numeric(4)= 9933	--Equivalente forma de pago
		,@EQValuta						numeric(4)= 9934    --Equivalente Valuta
		,@EQProd_System					numeric(4)= 9935    --Equivalente producto + _SYSTEM
		,@EQISOAlpha					numeric(4)= 9936    --Equivalencia Bac a ISO Alpha3
		,@EQBanco						numeric(4)= 9938    --Equivalencias Banco Beneficiario
		
		-- Campos Tabla
		,@Envio							varchar (2)
		--,@Sistema						varchar (3)
		--,@Numero_operacion			numeric (10)
		,@Tipo_operacion				varchar (50)
		,@Glosa_Tipo_operacion			varchar (50)
		,@Indicador						varchar (3)
		,@Fecha_operacion				datetime
		,@Ejecutivo						varchar (15)	--Usuario
		,@Moneda						varchar (8)
		,@Glosa_Moneda					varchar (35)
		,@Rut							numeric (9)		--Rut_cliente
		,@DigitoVerificador				varchar (1)		--Dv_cliente
		,@SucursalRut					numeric (3)		--Sucursal
		,@Monto_operacion				numeric (19,4)
		,@Forma_pago					numeric (5)
		,@Glosa_Forma_pago				varchar (30)
		,@Codigo_valuta					numeric (3)
		,@Nombre_cliente				varchar (70)
		,@Banco							varchar (20)
		,@CtaCteBenVendedor				varchar (15)
		,@Clave_abif					varchar (20)
		,@Cta_comprador					varchar (3)
		,@Codigo_dcv_comprador			varchar (20)
		,@Cta_vendedor					varchar (3)
		,@Codigo_dcv_vendedor			varchar (20)
		,@Monto_original				numeric (19,4)
		,@Fecha_inicio					datetime
		,@Tasa_interes					numeric (19,4)
		,@Interes						numeric (19,4)
		,@Monto_vencimiento				numeric (19,4)
		,@Fecha_vencimiento				datetime
		,@Reajustabilidad				varchar (8)
		,@Tasa_Pacto					numeric (19,4)
		,@Monto_Final					numeric (19,4)
		,@Monto_Nominal					numeric (19,4)
		,@Tasa_descuento				numeric (19,4)
		,@Valor_tasa					numeric (19,4)
		,@Custodia						varchar (10)
		,@Numero_instrumentos			numeric (10)
		,@Monto_total					numeric (19,4)
		,@Codigo_mon_mx					varchar (8)
		,@Monto_mx						numeric (19,4)
		,@Tasa_cambio					numeric (19,4)
		,@Fecha_valor_mx				datetime
		,@Forma_pago_neg				numeric  (5)
		,@Sesion						varchar  (15)
		,@NombreClienteBen_3			varchar  (35)
		,@NombreClienteBen_4			varchar  (35)
		,@UsuarioMDP					varchar  (50)
		,@UsuarioIngreso				varchar  (50)
		,@CargoCtaCte					varchar  (1)
		,@SobregiroCtaCte				varchar  (1)
		,@PvpReferencia					varchar  (20)
		,@PvpMoneda						varchar  (20)
		,@PvpTasaCambio					numeric  (19,4)
		,@PvpMonto						numeric  (19,4)
		,@Cod_cliente					numeric  (9)
		,@Codigo_dcv2					varchar  (20)
		,@Estado						varchar  (3)

		IF OBJECT_ID('tempdb..#Tmp_RESULTADO1_SP')IS NOT NULL 
			DROP TABLE #Tmp_RESULTADO1_SP

			CREATE TABLE #Tmp_RESULTADO1_SP
			(
				nemo	varchar(10)
			)
		
		IF OBJECT_ID('tempdb..#Tmp_RESULTADO2_SP')IS NOT NULL 
			DROP TABLE #Tmp_RESULTADO2_SP

			CREATE TABLE #Tmp_RESULTADO2_SP
			(
				tbglosa	varchar(50)
				,nemo	varchar(10)
			)

		IF OBJECT_ID('tempdb..#Tmp_RESULTADO3_SP')IS NOT NULL 
			DROP TABLE #Tmp_RESULTADO3_SP

			CREATE TABLE #Tmp_RESULTADO3_SP
			(
				codigo numeric(3)
				,diasvalor numeric(3)
				,valuta char(10)
			)

		IF OBJECT_ID('tempdb..#Tmp_RESULTADO8_SP')IS NOT NULL 
			DROP TABLE #Tmp_RESULTADO8_SP

			CREATE TABLE #Tmp_RESULTADO8_SP
			(
				CodigoProducto				varchar(4)
				,NumeroOperacion			numeric(10)
				,NemotecnicoTipoInstrumento	varchar(12)
				,Valornominal				numeric(19,4)
				,Tir						numeric(19,4)
				,Valorcompra				numeric(19,4)
				,ClaveOperacion				varchar(10)
				,CorrelativoRegistro		numeric(3)
			)



	-- ================================================================================================================
	-- Obtengo valores desde NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO
	-- ================================================================================================================
	SELECT
		--@Fecha_proceso		= @Fecha_proceso
		@Envio					= @Envio
		--,@Sistema				= @Sistema
		--,@Numero_operacion	= @Numero_operacion
		,@Tipo_operacion        = rtrim(Tipo_operacion)
		,@Glosa_Tipo_operacion  = Glosa_Tipo_operacion
		,@Indicador             = Indicador
		,@Fecha_operacion       = Fecha_operacion
		,@Ejecutivo             = Usuario
		,@Moneda                = Moneda
		,@Glosa_Moneda          = Glosa_Moneda
		,@Rut					= Rut_cliente
		,@DigitoVerificador     = Dv_cliente
		,@SucursalRut           = Sucursal
		,@Monto_operacion       = ABS(Monto_operacion)
		,@Forma_pago            = Forma_pago
		,@Glosa_Forma_pago      = Glosa_Forma_pago
		,@Codigo_valuta         = Codigo_valuta
		,@Nombre_cliente        = Nombre_cliente
		,@Banco                 = Banco
		,@CtaCteBenVendedor     = CtaCteBenVendedor
		,@Clave_abif            = Clave_abif
		,@Cta_comprador         = Cta_comprador
		,@Codigo_dcv_comprador  = Codigo_dcv_comprador
		,@Cta_vendedor          = Cta_vendedor
		,@Codigo_dcv_vendedor   = Codigo_dcv_vendedor
		,@Monto_original        = Monto_original
		,@Fecha_inicio          = Fecha_inicio
		,@Tasa_interes          = Tasa_interes
		,@Interes               = Interes
		,@Monto_vencimiento     = Monto_vencimiento
		,@Fecha_vencimiento     = Fecha_vencimiento
		,@Reajustabilidad       = Reajustabilidad
		,@Tasa_Pacto            = Tasa_Pacto
		,@Monto_Final           = Monto_Final
		,@Monto_Nominal         = Monto_Nominal
		,@Tasa_descuento        = Tasa_descuento
		,@Valor_tasa            = Valor_tasa
		,@Custodia              = Custodia
		,@Numero_instrumentos   = Numero_instrumentos
		,@Monto_total           = Monto_total
		,@Codigo_mon_mx         = Codigo_mon_mx
		,@Monto_mx              = Monto_mx
		,@Tasa_cambio           = Tasa_cambio
		,@Fecha_valor_mx        = Fecha_valor_mx
		,@Forma_pago_neg        = Forma_pago_neg
		,@Sesion                = Sesion
		,@NombreClienteBen_3    = NombreClienteBen_3
		,@NombreClienteBen_4    = NombreClienteBen_4
		,@UsuarioMDP            = UsuarioMDP
		,@UsuarioIngreso        = UsuarioIngreso
		,@CargoCtaCte           = CargoCtaCte
		,@SobregiroCtaCte       = SobregiroCtaCte
		,@PvpReferencia         = PvpReferencia
		,@PvpMoneda             = PvpMoneda
		,@PvpTasaCambio         = PvpTasaCambio
		,@PvpMonto              = PvpMonto
		,@Cod_cliente           = Cod_cliente
		,@Codigo_dcv2           = Codigo_dcv2
		,@Estado                = Estado
	FROM NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO
	WHERE
		Fecha_proceso		= @Fecha_proceso		
		AND Sistema			= @Sistema			
		AND Numero_operacion= @Numero_operacion

	-- ================================================================================================================
	-- Retorna parametros XML CANAL, APPCOD o APPNAME para broker 9931
	-- ================================================================================================================
	-- Valores para codigocanal,CodigoAplicacion y NombreAplicacion
	
		INSERT INTO #Tmp_RESULTADO2_SP
		EXEC bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA @EQXmlParametros,'CANAL',0
		SELECT @CodigoCanal  = tbglosa from  #Tmp_RESULTADO2_SP
		DELETE #Tmp_RESULTADO2_SP

		INSERT INTO #Tmp_RESULTADO2_SP
		EXEC bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA @EQXmlParametros,'APPCOD',0
		SELECT @CodigoAplicacion  = tbglosa from  #Tmp_RESULTADO2_SP
		DELETE #Tmp_RESULTADO2_SP

		INSERT INTO #Tmp_RESULTADO2_SP
		EXEC bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA @EQXmlParametros,'APPNAME',0
		SELECT @NombreAplicacion  = LTRIM(RTRIM(tbglosa)) from  #Tmp_RESULTADO2_SP
		DELETE #Tmp_RESULTADO2_SP
	
		--SELECT 'CANAL',@CodigoCanal,'APPCOD',@CodigoAplicacion,'APPNAME',@NombreAplicacion

	-- ===================================================================
	-- Equivalencia Sistema BTR, BEX o PCS 9930
	-- ===================================================================
	-- Retorna codigo sistema equivalente en MDP
       
        INSERT INTO #Tmp_RESULTADO1_SP
		EXEC bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA @EQSistema,@Sistema,0
		SELECT @CodigoSistema  = nemo from  #Tmp_RESULTADO1_SP
		DELETE #Tmp_RESULTADO1_SP
      
		SELECT @NumeroOperacion = @Numero_operacion
		
		--SELECT 'CODIGOSISTEMA',@CodigoSistema
		--SELECT 'NUMEROOPERACION',@NumeroOperacion
      
	-- ====================================================================
	-- Equivalencia Producto
	-- ====================================================================
		--SELECT * FROM NGINE_OPERACIONES_CONFIRMADAS_ENVIO_PAGO WHERE numero_operacion = 231268
		INSERT INTO #Tmp_RESULTADO2_SP
		EXEC bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA @EQProducto, @CodigoSistema, @Tipo_operacion
		SELECT @CodigoProductoEquivalente  = LTRIM(RTRIM(nemo)) from  #Tmp_RESULTADO2_SP
		SELECT @CodigoProducto = @CodigoProductoEquivalente
		DELETE #Tmp_RESULTADO2_SP

		--SELECT 'CODIGOPRODUCTOEQUIVALENTE',@CodigoProductoEquivalente
		--SELECT 'TIPO_OPERACION',@Tipo_operacion
			-- ===================================================================
			-- Envío Pago Documento x Instrumento solamente BTR y BEX
			-- Para los siguientes tipos de operacion:
			-- Interbancario de Colocación
			-- Interbancario de Captación
			-- Compra Definitiva
			-- Venta Definitiva
			-- DVP con DCV entre Bancos (No aplica)
			-- Compra con Pacto
			-- Venta con Pacto
			-- ===================================================================
				-- SP que trae instrumentos por operacion Sistema + NumeroOperacion, solamente para BTR y BEX
				IF charindex(@Tipo_operacion,'CP VP CI VI ICAP ICOL')>0
				BEGIN
					INSERT INTO #Tmp_RESULTADO8_SP
					EXEC SP_NGINE_DOCUMENTOS_ENVIO_PAGO @CodigoSistema,@Numerooperacion
					SELECT
						@NemotecnicoTipoInstrumento	= LTRIM(RTRIM(NemotecnicoTipoInstrumento))
						,@ValorNominal				= ValorNominal
						,@Tir						= Tir
						,@ValorCompra				= ValorCompra
						,@ClaveOperacion			= LTRIM(RTRIM(ClaveOperacion))
						,@CorrelativoRegistro		= CorrelativoRegistro
					FROM #Tmp_RESULTADO8_SP
					DELETE #Tmp_RESULTADO8_SP

					-- SELECT @NemotecnicoTipoInstrumento,@ValorNominal
					--	,@Tir			
					--	,@ValorCompra
					--	,@ClaveOperacion
					--	,@CorrelativoRegistro		
   																																					
					SELECT @XML_pago_documento =
					'<soapenv:Envelope xmlns:soapenv='+CHAR(34)+'http://schemas.xmlsoap.org/soap/envelope/'+char(34)+'xmlns:ns='+CHAR(34)+'http://itau.cl/xmlns/Payments/PaymentsExecution/PaymentsExecution/setPaymentDocumentNgine/1'+CHAR(34)+'>' + CHAR(13) + CHAR(10)
					+'<soapenv:Header/>' + CHAR(13) + CHAR(10)
					+'<soapenv:Body>' + CHAR(13) + CHAR(10)
					+'<ns:setPaymentDocumentNgineRq>' + CHAR(13) + CHAR(10)
					+'<MsgRqHdr>' + CHAR(13) + CHAR(10)
						+'<ContextRqHdr>' + CHAR(13) + CHAR(10)
							+'<ChnlId>'+ CONVERT(varchar(3),@CodigoCanal) + '</ChnlId>' + CHAR(13) + CHAR(10)			--CodigoCanal
							+'<AppId>'+ CONVERT(varchar(3),@CodigoAplicacion) +'</AppId>' + CHAR(13) + CHAR(10)			--CodigoAplicacion
							+'<AppName>'+ @NombreAplicacion+'</AppName>'+ CHAR(13) + CHAR(10)		--NombreAplicacion
						+'</ContextRqHdr>'+ CHAR(13) + CHAR(10)
					+'</MsgRqHdr>'+ CHAR(13) + CHAR(10)
					+'<AcctRec>'+ CHAR(13) + CHAR(10)
						+'<AcctId>' + @CodigoProducto +'</AcctId>'+ CHAR(13) + CHAR(10)							--CodigoProducto
						+'<AcctInfo>'+ CHAR(13) + CHAR(10)
							+'<Desc>'+ @NemotecnicoTipoInstrumento +'</Desc>'+ CHAR(13) + CHAR(10)				--NemotecnicoTipoInstrumento
							+'<CurCode>'+ CHAR(13) + CHAR(10)
								+'<CurCodeValue>'+ CONVERT(varchar(20),@ValorNominal) +'</CurCodeValue>'+ CHAR(13) + CHAR(10)		-- ValorNominal
							+'</CurCode>'+ CHAR(13) + CHAR(10)
							+'<AcctPeriodData>'+ CHAR(13) + CHAR(10)
								+'<AcctPeriodType>'+ CONVERT(varchar(20),@ValorCompra) +'</AcctPeriodType>'+ CHAR(13) + CHAR(10)	--ValorCompra
								+'<Count>'+ CONVERT(varchar(20),@Tir) +'</Count>'+ CHAR(13) + CHAR(10)								--Tir
							+'</AcctPeriodData'+ CHAR(13) + CHAR(10)
							+'<AcctType>'+ CHAR(13) + CHAR(10)
								+'<AcctTypeValue>'+ @ClaveOperacion +'</AcctTypeValue>'+ CHAR(13) + CHAR(10)						--ClaveOperacion
							+'</AcctType>'+ CHAR(13) + CHAR(10)
							+'<OrigInitialAmount>'+ CHAR(13) + CHAR(10)
								+'<Amt>'+ CONVERT(varchar(20),@Numerooperacion) +'</Amt>'+ CHAR(13) + CHAR(10)						--NumeroOperacion
								+'<USDAmt>'+ CONVERT(varchar(20),@CorrelativoRegistro) +'</USDAmt>'+ CHAR(13) + CHAR(10)			--CorrelativoRegistro
							+'</OrigInitialAmount>'+ CHAR(13) + CHAR(10)
						+'</AcctInfo>'+ CHAR(13) + CHAR(10)
					+'</AcctRec>'+ CHAR(13) + CHAR(10)
					+'</ns:setPaymentDocumentNgineRq>'+ CHAR(13) + CHAR(10)
					+'</soapenv:Body>'+ CHAR(13) + CHAR(10)
					+'</soapenv:Envelope>'+ CHAR(13) + CHAR(10)
		
					SELECT 'SALIDA_DOCUMENTO_XML',@XML_pago_documento
				END
	
	-- ===================================================================
	-- Envío Pago Operacion
	-- ===================================================================
		SELECT @CodigoProducto = @CodigoSistema
		--SELECT 'CodigoProducto',@CodigoProducto
		INSERT INTO #Tmp_RESULTADO2_SP
		EXEC bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA @EQProducto,@CodigoProducto,@Tipo_operacion
		SELECT @CodigoProductoEquivalente = nemo FROM #Tmp_RESULTADO2_SP
		DELETE #Tmp_RESULTADO2_SP
		--SELECT @CodigoProductoEquivalente

		INSERT INTO #Tmp_RESULTADO2_SP
		EXEC bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA @EQProducto, @CodigoProducto, @CodigoProductoEquivalente
		SELECT @Tipo_operacion = nemo FROM #Tmp_RESULTADO2_SP
		DELETE #Tmp_RESULTADO2_SP
		--SELECT 'Tipo_operacion',@Tipo_operacion
		--SELECT 'indicadorAccion',@Indicador
		--SELECT 'Fecha_operacion',@Fecha_operacion
		--SELECT 'Ejecutivo',@Ejecutivo
		--SELECT 'Moneda',@Moneda
		--SELECT 'Rut',@Rut
		--SELECT 'DigitoVerificador',@DigitoVerificador
		--SELECT 'SucursalRut',@SucursalRut
		--SELECT 'Monto_operacion',@Monto_operacion
    
	-- ===================================================================
	-- FORMA DE PAGO DEBE SER HOMOLOGADAS A LAS DE NGINE: SCP, CCA, CYA, 
	-- VVT, DVH, DVS
    -- exec bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA 9933,'',132
	-- ===================================================================
		INSERT INTO #Tmp_RESULTADO2_SP
		EXEC bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA @EQFormaPago,'',@Forma_pago
		SELECT @FormaPagoEquivalente = nemo from #Tmp_RESULTADO2_SP
		DELETE #Tmp_RESULTADO2_SP
		--SELECT @FormaPagoEquivalente

	-- ===================================================================
	-- CODIGO DE VALUTA TIENE UN FORMATO NGIN: 100,101,102...
	-- (correlativo que comienza desde 101)
	-- ===================================================================
		INSERT INTO #Tmp_RESULTADO3_SP
		EXEC bacparamsuda..SP_NGINE_BUSCA_EQUIVALENCIA @EQValuta,'',@Forma_pago
		SELECT @CodigoValutaEquivalente = CONVERT(numeric(3),valuta) from #Tmp_RESULTADO3_SP
		DELETE #Tmp_RESULTADO3_SP
		--SELECT @CodigoValutaEquivalente

	-- ===================================================================
	-- EQUIVALENCIA BANCO BENEFICIARIO (En desarrollo)
	-- ===================================================================
		IF @CodigoProducto <> 'RFI'
		BEGIN
			select 'equivalencia benef',9938,'',97006000
			INSERT INTO #Tmp_RESULTADO1_SP
			EXECUTE BACPARAMSUDA..SP_NGINE_BUSCA_EQUIVALENCIA @EQBanco,'',@Rut
		    SELECT @Banco = nemo FROM #Tmp_RESULTADO1_SP
			DELETE #Tmp_RESULTADO1_SP
		END

END
GO
