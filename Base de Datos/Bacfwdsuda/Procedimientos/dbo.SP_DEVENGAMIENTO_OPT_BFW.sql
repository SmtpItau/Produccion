USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_DEVENGAMIENTO_OPT_BFW]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_DEVENGAMIENTO_OPT_BFW]
		(
		@dFecPro      		DATETIME       	, -- 1 Fecha de Proceso
		@dFecProAnt      	DATETIME       	, -- 2 Fecha Proceso Anterior
		@dFecProxPro		DATETIME       	, -- 3 Proxima Fecha Habil
		@dFecUDMPro  	    DATETIME       	, -- 4 Ultimo D¡a Mes de Proceso
		@dFecUDMAnt   	    DATETIME       	, -- 5 Ultimo D¡a Mes de Proceso Anterior
		@cLastHabil			CHAR(2)  		, -- 6 Indica si es el Ultimo D¡a H bil
		@cFirstHabil		CHAR(2)			, -- 7 Indica si es el Primer D¡a H bil
		@nValorUF_Ant   	NUMERIC(12,04) 	, -- 8 Uf Dia Anterior
		@nValorUF_Pro		NUMERIC(12,04) 	, -- 9 Uf de Proceso
		@nValorUF_UDM	    NUMERIC(12,04) 	, -- 10 Uf Fin de Mes
		@nValUsd_Pro		NUMERIC(12,4)	, -- 11 Valor D¢lar Observado Proceso
		@nValUsd_Ant		NUMERIC(12,4)	, -- 12 Valor D¢lar Observado Anterior
		@nvalusd_udma	    NUMERIC(12,4)	, -- 13 Valor D¢lar Observado Ultimo Día Mes Anterior
		@iEjecucionIniDia	INT      		  -- = 0
		)
AS 
BEGIN

	SET NOCOUNT ON 
/*
--	DROP TABLE #TEMPORAL_MFCA
--	go

	DECLARE	@dFecPro		DATETIME       	 -- 1 Fecha de Proceso
	,	@dFecProAnt		DATETIME       	 -- 2 Fecha Proceso Anterior
	,	@dFecProxPro		DATETIME       	 -- 3 Proxima Fecha Habil
	,	@dFecUDMPro		DATETIME       	 -- 4 Ultimo D¡a Mes de Proceso
	,	@dFecUDMAnt		DATETIME       	 -- 5 Ultimo D¡a Mes de Proceso Anterior
	,	@cLastHabil		CHAR(2)  	 -- 6 Indica si es el Ultimo D¡a H bil
	,	@cFirstHabil		CHAR(2)		 -- 7 Indica si es el Primer D¡a H bil
	,	@nValorUF_Ant		NUMERIC(12,04) 	 -- 8 Uf Dia Anterior
	,	@nValorUF_Pro		NUMERIC(12,04) 	 -- 9 Uf de Proceso
	,	@nValorUF_UDM		NUMERIC(12,04) 	 -- 10 Uf Fin de Mes
	,	@nValUsd_Pro		NUMERIC(12,4)	 -- 11 Valor D¢lar Observado Proceso
	,	@nValUsd_Ant		NUMERIC(12,4)	 -- 12 Valor D¢lar Observado Anterior
	,	@nvalusd_udma		NUMERIC(12,4)	 -- 13 Valor D¢lar Observado Ultimo Día Mes Anterior
	,	@iEjecucionIniDia	INT      	  -- = 0

	SET	@dFecPro      		= '20100301'	--DATETIME       	 -- 1 Fecha de Proceso
	SET	@dFecProAnt      	= '20100226'	--DATETIME       	 -- 2 Fecha Proceso Anterior
	SET	@dFecProxPro		= '20100302'	--DATETIME       	 -- 3 Proxima Fecha Habil
	SET	@dFecUDMPro  	        = '20100331'	--DATETIME       	 -- 4 Ultimo D¡a Mes de Proceso
	SET	@dFecUDMAnt   	        = '20100228'	--DATETIME       	 -- 5 Ultimo D¡a Mes de Proceso Anterior
	SET	@cLastHabil		= 'N0'		--CHAR(2)  	 	 -- 6 Indica si es el Ultimo D¡a H bil
	SET	@cFirstHabil		= 'SI'		--CHAR(2)		 -- 7 Indica si es el Primer D¡a H bil
	SET	@nValorUF_Ant   	= 20920.36	--NUMERIC(12,04) 	 -- 8 Uf Dia Anterior
	SET	@nValorUF_Pro		= 20924.09	--NUMERIC(12,04) 	 -- 9 Uf de Proceso
	SET	@nValorUF_UDM	        = 20998.52	--NUMERIC(12,04) 	 -- 10 Uf Fin de Mes
	SET	@nValUsd_Pro		= 527.84	--NUMERIC(12,4)	 	 -- 11 Valor D¢lar Observado Proceso
	SET	@nValUsd_Ant		= 529.69	--NUMERIC(12,4)	 	 -- 12 Valor D¢lar Observado Anterior
	SET	@nvalusd_udma	        = 529.69	--NUMERIC(12,4)	 	 -- 13 Valor D¢lar Observado Ultimo Día Mes Anterior
	SET	@iEjecucionIniDia       = 0 		--INT		 -- = 0
*/

	DECLARE	@FechaCalculos		DATETIME
		,	@nValorDolar		FLOAT
		,	@ndolar_estimado	NUMERIC(12,04)
		,	@Actualiza			CHAR(01)	-- SE OCUPA PARA REALIZAR DEVENGAMIENTO Y GRABAR EN LA MFCA 

	SET	@Actualiza			= 'S'
	SET	@FechaCalculos		= CASE WHEN DATEPART(MONTH, @dFecPro) = DATEPART(MONTH, @dFecProxPro)	THEN @dFecPro
										                                ELSE @dFecUDMPro END
	SET	@nValorDolar		= (SELECT vmvalor FROM BacParamSuda..VALOR_MONEDA with(nolock) WHERE vmfecha = @dFecPro AND vmcodigo = 994)
	SET 	@ndolar_estimado	= (SELECT tasa_compra FROM VIEW_TASA_FWD WHERE codigo = 2 AND fecha = @dfecpro)

	CREATE TABLE #TEMPORAL_MFCA
	(	nNumOpe					NUMERIC(10,00) 	-- Numero de Operacion
	,	nCorrelativo			INT		-- Correlativo para producto 13 SIH
	,	nCarter   				NUMERIC(02,00) 	-- Tipo de Cartera
	,	cTipOpe      			CHAR(01)       	-- Tipo de Operaci¢n
	,	nCodMon      			NUMERIC(03,00) 	-- Moneda Origen
	,	nMtoMex      			NUMERIC(21,04) 	-- Monto Origen
	,	nMtoClp_i 				NUMERIC(21,00)	-- Pesos al Inicio Por los D¢lares
	,	nValMex_i				FLOAT		-- Valor de la Moneda1 al Inicio
	,	nCodCnv      			NUMERIC(03,00) 	-- Moneda Conversi¢n
	,	nMtoCnv      			NUMERIC(21,04) 	-- Monto Conversi¢n
	,	nMtoCnv_i 				NUMERIC(21,00)	-- Pesos al Inicio Por moneda Cnv ($$-UF)
	,	nValCnv_i				FLOAT		-- Valor de la Moneda2 al Inicio
	,	dFecIni      			DATETIME       	-- Fecha Inicio
	,	dFecVto      			DATETIME       	-- Fecha Vencimiento
	,	nPreFut					FLOAT		-- Precio Futuro
	,	nMonRef      			NUMERIC(03,00)  -- Moneda Referencial	
	,	ntccierre				FLOAT           -- Tipo de Cambio Cierre Arbitrajes
	,	cModal					CHAR ( 1 )	-- Modalidad de la Operación (C-Compensación, E-Entrega Física)
	,	nmtofin1  				NUMERIC(21,4)	-- Monto USD Final Oper. Posición-1446
	,	nmtoini1  				NUMERIC(21,4)	-- Monto USD Inicial Oper. Posición-1446
	,	nmtofin2  				NUMERIC(21,4)	-- Monto CNV Final Oper. Posición-1446
	,	nmtoini2  				NUMERIC(21,4)	-- Monto CNV Inicial Oper. Posición-1446	 
	,	ntasausd  				FLOAT		-- Tasa USD Posición-1446
	,	ntasacnv				FLOAT		-- Tasa CNV Posición-1446
	,	tc_calculo_mes_actual	NUMERIC(12,4)	--
	,	tc_calculo_mes_anterior NUMERIC(21,4)	-- 
	,	npremio		 			NUMERIC(24,4)	--
	,	canticipo				CHAR(1)		--
	,	vencimiento_original	DATETIME	--
	,	Valor_Ayer 	 			NUMERIC(21,00)	--
	,	dFecEfectiva  			DATETIME       	-- Fecha Efectiva
	,	nPlazoOpe     			NUMERIC(04,00) 	-- Plazo Operaci¢n
	,	ctipcli               	CHAR (01)	-- Tipo Cliente L=local  E=externo
	,	iRefMercado				INT		--	
	,	nDiasValor				NUMERIC(5)	-- Para Calcular Fecha Efectiva
	,	cDiasFeriados			VARCHAR(255)	-- Cadena que contiene los feriados del mes de la fecha consultada en este caso fecha efectiva
	,	cDiaCaracter			CHAR(2)		-- Numero de dia convertido a caracter para buscar dentro de la cadena de feriados
	,	cEstadoDia				CHAR(1)		-- H = Habil - I = Inhabil
	,	dFecAux					DATETIME	-- 
	,	nPlazoVto				NUMERIC(04,00)	-- Plazo al Vencimiento
	,	nPlazoVtoEfec			FLOAT		-- 
	,	nPlazoVtoanterior 		NUMERIC(4,0)	-- 
	,	nPlazoCal				NUMERIC(04,00)	-- 
	,	nPlazoCal_a				NUMERIC(04,00)  --
	,	nDiaDev      			NUMERIC(04,00)	-- 
	,	nPerSal 				NUMERIC(21,00)	-- Saldo por devengar de la Perdida Diferida
	,	nUtiSal 				NUMERIC(21,00)	-- Saldo por devengar de la utilidad Diferida
	,	nValUsd_c				NUMERIC(12,04)	-- TOMA EL VALOR DEL PARAMETRO @nValUsd_Pro
	,	nMtoDif					NUMERIC(21,00)	-- 
	,	nDelUsd					NUMERIC(12,04)	-- 
	,	nDelUf					NUMERIC(12,04)	-- 
	,	nValorUF				NUMERIC(12,04)	--
	,	nUtiDif 				NUMERIC(21,00)	-- Utilidad Diferida
	,	nPerDif 				NUMERIC(21,00)	-- Perdida Diferida
	,	nUtiDev 				NUMERIC(21,00)	-- Utilidad Devengada
	,	nPerDev 				NUMERIC(21,00)	-- Perdida Devengada
	,	nPerAcu 				NUMERIC(21,00)	-- Perdida Acumulada
	,	nUtiAcu 				NUMERIC(21,00)	-- Utilidad Acumulada
	,	nClp_Mex				NUMERIC(21,00)	-- Pesos de la Moneda1 Hoy
	,	nClp_Cnv				NUMERIC(21,00)	-- Pesos de la Moneda2 Hoy
	,	nRevUsd					NUMERIC(21,00)  -- Valorizaci½n Acumulada de los D½lares
	,	nRevUF					NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF
	,	nRevTot					NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF + los D½lares
	,	nCtaCamb_a 				NUMERIC(21,00)	-- Valor de la Cuenta Cambio Ayer
	,	nCtaCamb_c 				NUMERIC(21,00)	-- Valor de la Cuenta Cambio Hoy
	,	nReaUFDia 				NUMERIC(21,00)	-- Reajustes de la UF Hoy
	,	nReaTCDia 				NUMERIC(21,00)	-- Reajustes de la T/C Hoy
	,	nValorDia				NUMERIC(21,00)  -- Valorizaci½n del D­a
	,	nRevTot_a				NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF + los D½lares ayer
	,	nMtoComp				NUMERIC(21,04)  -- Monto a Compensar
	,	nCompensacion_estimada	NUMERIC(21,00)	-- Monto compensacion estimada
	,	cfuerte                	CHAR ( 1 )      -- Moneda fuerte o debil
	,	Plazo					INT
	,	PuntaSpot				FLOAT
	,	TasaUSD					FLOAT
	,	TasaBidMe				FLOAT
	,	TasaBidMa				FLOAT
	,	TasaAskMe				FLOAT
	,	TasaAskMa				FLOAT
	,	PlazoCalMe				INT
	,	PlazoCalMa				INT
	,	DifTasaBid				FLOAT
	,	DifTasaAsk				FLOAT
	,	DifPlazo				INT
	,	InterpBid				FLOAT
	,	InterpAsk				FLOAT
	,	TasaFwd					FLOAT
	,	Valor_Obtenido			FLOAT
	,	PrecioFwd				FLOAT		-- Paridad
	,	ValorMTM_USD			FLOAT	       	
	,	ValorPte_USD			FLOAT		-- Valor Presente USD
	,	nTipCamVal				FLOAT		-- Paridad de valorizaci¢n
	,	nDelUf_a				NUMERIC(12,04)
	,	nRevUF_a				NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF Ayer
    ,   PuntosCierre            FLOAT           -- 5522 Forward a Observado
    ,   FechaStarting           DATETIME        -- 5522 Forward a Observado 
	,   NroMxClp				NUMERIC(10,00)
	)

	CREATE NONCLUSTERED INDEX #TEMPORAL_MFCA_001 ON #TEMPORAL_MFCA
	(	nCarter
	,	dFecVto
	,	nCodCnv
	)

	CREATE NONCLUSTERED INDEX #TEMPORAL_MFCA_002 ON #TEMPORAL_MFCA
	(	nCarter 
	,	nCodCnv 
	)

	INSERT	#TEMPORAL_MFCA
	SELECT	'nNumOpe'			= canumoper   		 --1
	,	'nCorrelativo'			= 0			 --2
	,	'nCarter'			= cacodpos1   		 --3
	,	'cTipOpe'			= catipoper   		 --4
	,	'nCodMon'			= cacodmon1   		 --5
	,	'nMtoMex'			= camtomon1 		 --6
	,	'nMtoClp_i'			= FLOOR( caequmon1 )	 --7
	,	'nValMex_i'			= capremon1   		 --8
	,	'nCodCnv'			= cacodmon2   		 --9
	,	'nMtoCnv'			= camtomon2   		 --10
	,	'nMtoCnv_i'			= FLOOR( caequmon2 )	 --11    caequmon2 - nMtoCnv_i
	,	'nValCnv_i'			= capremon2   		 --12
	,	'dFecIni'			= cafecha     		 --13
	,	'dFecVto'			= cafecvcto   		 --14
	,	'nPreFut'			= catipcam    		 --15
	,	'nMonRef'			= camdausd    		 --16
	,	'ntccierre'			= caprecal    		 --17
	,	'cModal'			= catipmoda   		 --18
	,	'nmtofin1'			= camtomon1fin		 --19
	,	'nmtoini1'			= camtomon1ini		 --20
	,	'nmtofin2'			= camtomon2fin		 --21
	,	'nmtoini2'			= camtomon2ini		 --22
	,	'ntasausd'			= catasausd		 --23
	,	'ntasacnv'			= catasacon		 --24
	,	'tc_calculo_mes_actual'		= tc_calculo_mes_actual	 --25
	,	'tc_calculo_mes_anterior'	= tc_calculo_mes_anterior  --26
	,	'npremio'			= capremio		 --27
	,	'canticipo'			= caantici		 --28
	,	'vencimiento_original'		= cafecvenor		 --29
	,	'valor_ayer'			= cavalorayer		 --30
	,	'dFecEfectiva'			= cafecEfectiva		 --31

	,	'nPlazoOpe'			= CASE WHEN DATEDIFF( dd, cafecha, cafecvcto ) = 0 
							THEN 1 ELSE DATEDIFF( dd, cafecha , cafecvcto ) END -- 	NUMERIC(04,00) 	-- Plazo Operaci¢n	
	,	'cTipCli'			= (SELECT (CASE clpais WHEN 6 THEN 'L' ELSE 'E' END)
							FROM	VIEW_CLIENTE
							WHERE	clrut		= cacodigo 
							AND	clcodigo	= cacodcli)-- 	CHAR (01)	
	,	'iRefMercado'			= CASE WHEN cacodpos1	= 1	THEN CONVERT(NUMERIC(5), cacodpos2)
						       WHEN cacodpos1	= 2	THEN CONVERT(NUMERIC(5), cacolmon1)
										ELSE CONVERT(NUMERIC(5), 0) END -- 	INT		
	,	'nDiasValor'			= 0			-- 	NUMERIC(5)	
	,	'cDiasFeriados'			= ''			-- 	VARCHAR(255)	
	,	'cDiaCaracter'			= ''			-- 	CHAR(2)		
	,	'cEstadoDia'			= 'I'			-- 	CHAR(1)		-- H = Habil - I = Inhabil
	,	'dFecAux'			= ''			-- 	DATETIME	- 	 
	,	'nPlazoVto'			= 0			-- 	NUMERIC(04,00)	
	,	'nPlazoVtoEfec'			= 0			-- 	FLOAT		
	,	'nPlazoVtoanterior'		= 0			-- 	NUMERIC(4,0)	-- 	
	,	'nPlazoCal'			= 0			-- 	NUMERIC(04,00)	-- 	
	,	'nPlazoCal_a'			= 0			--	NUMERIC(04,00)  --
	,	'nDiaDev'			= 0			--	NUMERIC(04,00)
	,	'nPerSal'			= 0			-- 	NUMERIC(21,00)	
	,	'nUtiSal'			= 0			-- 	NUMERIC(21,00)	
									
	,	'nValUsd_c'			= @nValUsd_Pro		-- 	NUMERIC(12,04)	-- TOMA EL VALOR DEL PARAMETRO @nValUsd_Pro	
	,	'nMtoDif'			= 0			-- 	NUMERIC(21,00)	-- 	
	,	'nDelUsd'			= 0			-- 	NUMERIC(12,04)	-- 	
	,	'nDelUf'			= 0			-- 	NUMERIC(12,04)	-- 	
	,	'nValorUF'			= @nValorUF_Pro		-- 	NUMERIC(12,04)	--	
	,	'nUtiDif'			= 0			--	NUMERIC(21,00)	-- Utilidad Diferida
	,	'nPerDif'			= 0			-- 	NUMERIC(21,00)	
	,	'nUtiDev' 			= 0			--	NUMERIC(21,00)	-- Utilidad Devengada
	,	'nPerDev'			= 0			-- 	NUMERIC(21,00)	
	,	'nPerAcu'			= 0			-- 	NUMERIC(21,00)	
	,	'nUtiAcu'			= 0			-- 	NUMERIC(21,00)	
	,	'nClp_Mex'			= 0			-- 	NUMERIC(21,00)	
	,	'nClp_Cnv'			= 0			-- 	NUMERIC(21,00)	
	,	'nRevUsd'			= 0			-- 	NUMERIC(21,00)  -- Valorizaci½n Acumulada de los D½lares		
	,	'nRevUF'			= 0			-- 	NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF		
	,	'nRevTot'			= 0			-- 	NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF + los D½lares		
	,	'nCtaCamb_a'			= 0			-- 	NUMERIC(21,00)	
	,	'nCtaCamb_c'			= 0			-- 	NUMERIC(21,00)	
	,	'nReaUFDia'			= 0			-- 	NUMERIC(21,00)	
	,	'nReaTCDia'			= 0			-- 	NUMERIC(21,00)	-- Reajustes de la T/C Hoy	
	,	'nValorDia'			= 0			-- 	NUMERIC(21,00)  -- Valorizaci½n del D­a		
	,	'nRevTot_a'			= 0			-- 	NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF + los D½lares ayer		
	,	'nMtoComp'			= 0			-- 	NUMERIC(21,04)  -- Monto a Compensar		
	,	'nCompensacion_estimada'	= 0			-- 	NUMERIC(21,00)	

	,	'cfuerte'			= ''			--	CHAR ( 1 )      -- Moneda fuerte o debil
	,	'Plazo'				= DATEDIFF( DAY, @dFecPro, cafecEfectiva )	-- Se vuelve a actualizar en el proceso de calculo de fecha efectiva mas abajo
	,	'PuntaSpot'			= 0			--	FLOAT
	,	'TasaUSD'			= 0			--	FLOAT
	,	'TasaBidMe'			= 0			--	FLOAT
	,	'TasaBidMa'			= 0			--	FLOAT
	,	'TasaAskMe'			= 0			--	FLOAT
	,	'TasaAskMa'			= 0			--	FLOAT
	,	'PlazoCalMe'			= 0			--	INT
	,	'PlazoCalMa'			= 0			--	INT
	,	'DifTasaBid'			= 0			--	FLOAT
	,	'DifTasaAsk'			= 0			--	FLOAT
	,	'DifPlazo'			= 0			--	INT
	,	'InterpBid'			= 0			--	FLOAT
	,	'InterpAsk'			= 0			--	FLOAT
	,	'TasaFwd'			= 0			--	FLOAT
	,	'Valor_Obtenido'		= 0			--	FLOAT
	,	'PrecioFwd'			= 0			--	FLOAT		-- Paridad
	,	'ValorMTM_USD'			= 0			--	FLOAT	       	
	,	'ValorPte_USD'			= 0			--	FLOAT		-- Valor Presente USD
	,	'nTipCamVal'			= 0			--	FLOAT		-- Paridad de valorizaci¢n
	,	'nDelUf_a'			= 0			--	NUMERIC(12,04)
	,	'nRevUF_a'			= 0 			--	NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF Ayer
        ,       'PuntosCierre'                  = CaPuntosFwdCierre     -- 5522 Forward a Observado
        ,       'FechaStarting'                 = CaFechaStarting       -- 5522 Forward a Observado
	,       'NroMxClp'			= var_moneda2

	FROM	BACFWDSUDA..MFCA	WITH (NOLOCK)
--	WHERE	cacodpos1	in (1,2,3)
        WHERE	cacodpos1	in (1,2,3,14)                                      -- 5522 Forward a Observado
	AND	( cafecvcto	= CASE WHEN @iEjecucionIniDia = 1 THEN @dFecPro    -- Inicio Dia calcula los vencimientos
                                  ELSE cafecvcto END                               -- Dev. cierre elimina la restricción
                   or
                  CaFechaStarting = CASE WHEN  @iEjecucionIniDia = 1 THEN @dFecPro -- Inicio Dia Fija CaTipCam
                                  ELSE CaFechaStarting END                         -- Dev. cierre elimina la restrición 
                 ) 

	UNION
		
	SELECT	'nNumOpe'			= canumoper   			--1
	,	'nCorrelativo'			= Ctf_Correlativo		--2
	,	'nCarter'			= cacodpos1			--3
	,	'cTipOpe'			= catipoper			--4
	,	'nCodMon'			= cacodmon1			--5
	,	'nMtoMex'			= Ctf_Monto_Principal		--6
	,	'nMtoClp_i'			= FLOOR( Ctf_Monto_Principal * capremon1 )		--7
	,	'nValMex_i'			= capremon1			--8
	,	'nCodCnv'			= cacodmon2 			--9
	,	'nMtoCnv'			= (Ctf_Monto_Principal * Ctf_Precio_Contrato)		--10
	,	'nMtoCnv_i'			= FLOOR( Ctf_Monto_Principal * Ctf_Precio_Contrato)	--11
	,	'nValCnv_i'			= Ctf_Precio_Costo		--12
	,	'dFecIni'			= cafecha     			--13
	,	'dFecVto'			= Ctf_Fecha_Vencimiento		--14
	,	'nPreFut'			= Ctf_Precio_Contrato		--15
	,	'nMonRef'			= camdausd			--16
	,	'ntccierre'			= Ctf_Precio_Costo		--17
	,	'cModal'			= catipmoda   			--18
	,	'nmtofin1'			= camtomon1fin			--19
	,	'nmtoini1'			= camtomon1ini			--20
	,	'nmtofin2'			= (Ctf_Monto_Principal * Ctf_Precio_Contrato)		--21
	,	'nmtoini2'			= (Ctf_Monto_Principal * capremon1)			--22
	,	'ntasausd'			= catasausd			--23
	,	'ntasacnv'			= catasacon			--24
	,	'tc_calculo_mes_actual'		= tc_calculo_mes_actual		--25
	,	'tc_calculo_mes_anterior'	= tc_calculo_mes_anterior	--26
	,	'npremio'			= capremio			--27
	,	'canticipo'			= caantici			--28
	,	'vencimiento_original'		= cafecvenor			--29
	,	'valor_ayer'			= cavalorayer			--30
	,	'dFecEfectiva'			= Ctf_Fecha_Fijacion		--31

	,	'nPlazoOpe'			= CASE WHEN DATEDIFF( dd, cafecha, cafecvcto ) = 0 
							THEN 1 ELSE DATEDIFF( dd, cafecha , cafecvcto ) END -- 	NUMERIC(04,00) 	-- Plazo Operaci¢n	
	,	'cTipCli'			= (SELECT (CASE clpais WHEN 6 THEN 'L' ELSE 'E' END)
							FROM	VIEW_CLIENTE
							WHERE	clrut		= cacodigo 
							AND	clcodigo	= cacodcli)-- 	CHAR (01)	
	,	'iRefMercado'			= CASE WHEN cacodpos1	= 1	THEN CONVERT(NUMERIC(5), cacodpos2)
						       WHEN cacodpos1	= 2	THEN CONVERT(NUMERIC(5), cacolmon1)
										ELSE CONVERT(NUMERIC(5), 0) END -- 	INT	#¿NOMBRE?	
	,	'nDiasValor'			= 0			-- 	NUMERIC(5)	
	,	'cDiasFeriados'			= ''			-- 	VARCHAR(255)	
	,	'cDiaCaracter'			= ''			-- 	CHAR(2)		
	,	'cEstadoDia'			= 'I'			-- 	CHAR(1)		-- H = Habil - I = Inhabil
	,	'dFecAux'			= ''			-- 	DATETIME	- 	 
	,	'nPlazoVto'			= 0			-- 	NUMERIC(04,00)	
	,	'nPlazoVtoEfec'			= 0			-- 	FLOAT		
	,	'nPlazoVtoanterior'		= 0			-- 	NUMERIC(4,0)	-- 	
	,	'nPlazoCal'			= 0			-- 	NUMERIC(04,00)	-- 	
	,	'nPlazoCal_a'			= 0			--	NUMERIC(04,00)  --
	,	'nDiaDev'			= 0			--	NUMERIC(04,00)
	,	'nPerSal'			= 0			-- 	NUMERIC(21,00)	
	,	'nUtiSal'			= 0			-- 	NUMERIC(21,00)	
									
	,	'nValUsd_c'			= @nValUsd_Pro		-- 	NUMERIC(12,04)	-- TOMA EL VALOR DEL PARAMETRO @nValUsd_Pro	
	,	'nMtoDif'			= 0			-- 	NUMERIC(21,00)	-- 	
	,	'nDelUsd'			= 0			-- 	NUMERIC(12,04)	-- 	
	,	'nDelUf'			= 0			-- 	NUMERIC(12,04)	-- 	
	,	'nValorUF'			= @nValorUF_Pro		-- 	NUMERIC(12,04)	--	
	,	'nUtiDif'			= 0			--	NUMERIC(21,00)	-- Utilidad Diferida
	,	'nPerDif'			= 0			-- 	NUMERIC(21,00)	
	,	'nUtiDev' 			= 0			--	NUMERIC(21,00)	-- Utilidad Devengada
	,	'nPerDev'			= 0			-- 	NUMERIC(21,00)	
	,	'nPerAcu'			= 0			-- 	NUMERIC(21,00)	
	,	'nUtiAcu'			= 0			-- 	NUMERIC(21,00)	
	,	'nClp_Mex'			= 0			-- 	NUMERIC(21,00)	
	,	'nClp_Cnv'			= 0			-- 	NUMERIC(21,00)	
	,	'nRevUsd'			= 0			-- 	NUMERIC(21,00)  -- Valorizaci½n Acumulada de los D½lares		
	,	'nRevUF'			= 0			-- 	NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF		
	,	'nRevTot'			= 0			-- 	NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF + los D½lares		
	,	'nCtaCamb_a'			= 0			-- 	NUMERIC(21,00)	
	,	'nCtaCamb_c'			= 0			-- 	NUMERIC(21,00)	
	,	'nReaUFDia'			= 0			-- 	NUMERIC(21,00)	
	,	'nReaTCDia'			= 0			-- 	NUMERIC(21,00)	-- Reajustes de la T/C Hoy	
	,	'nValorDia'			= 0			-- 	NUMERIC(21,00)  -- Valorizaci½n del D­a		
	,	'nRevTot_a'			= 0			-- 	NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF + los D½lares ayer		
	,	'nMtoComp'			= 0			-- 	NUMERIC(21,04)  -- Monto a Compensar		
	,	'nCompensacion_estimada'	= 0			-- 	NUMERIC(21,00)	

	,	'cfuerte'			= ''			--	CHAR ( 1 )       -- Moneda fuerte o debil
	,	'Plazo'				= DATEDIFF( DAY, @dFecPro, cafecEfectiva )
	,	'PuntaSpot'			= 0			--	FLOAT
	,	'TasaUSD'			= 0			--	FLOAT
	,	'TasaBidMe'			= 0			--	FLOAT
	,	'TasaBidMa'			= 0			--	FLOAT
	,	'TasaAskMe'			= 0			--	FLOAT
	,	'TasaAskMa'			= 0			--	FLOAT
	,	'PlazoCalMe'			= 0			--	INT
	,	'PlazoCalMa'			= 0			--	INT
	,	'DifTasaBid'			= 0			--	FLOAT
	,	'DifTasaAsk'			= 0			--	FLOAT
	,	'DifPlazo'			= 0			--	INT
	,	'InterpBid'			= 0			--	FLOAT
	,	'InterpAsk'			= 0			--	FLOAT
	,	'TasaFwd'			= 0			--	FLOAT
	,	'Valor_Obtenido'		= 0			--	FLOAT
	,	'PrecioFwd'			= 0			--	FLOAT		-- Paridad
	,	'ValorMTM_USD'			= 0			--	FLOAT	       	
	,	'ValorPte_USD'			= 0			--	FLOAT		-- Valor Presente USD
	,	'nTipCamVal'			= 0			--	FLOAT		-- Paridad de valorizaci¢n
	,	'nDelUf_a'			= 0			--	NUMERIC(12,04)
	,	'nRevUF_a'			= 0 			--	NUMERIC(21,00)  -- Valorizaci½n Acumulada de la UF Ayer
        ,       'PuntosCierre'                  = 0                     -- 5522 Forward a Observado
        ,       'FechaStarting'                 = CaFecVcto             -- 5522 Forward a Observado
	,      'NroMxClp'			= var_moneda2
	FROM	BACFWDSUDA..MFCA
	,	BACFWDSUDA..TBL_CARTERA_FLUJOS
	WHERE	cacodpos1		= 13
	AND	Ctf_Fecha_Vencimiento	= CASE WHEN @iEjecucionIniDia = 1 THEN @dFecPro ELSE Ctf_Fecha_Vencimiento END
	AND	Ctf_Numero_OPeracion	= canumoper
	ORDER 
	BY	canumoper
	,	ncorrelativo	ASC--este campo no existe en la mfca solo sirve para los flujos

	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------- CALCULO DE FECHA EFECTIVA --------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------

	UPDATE	#TEMPORAL_MFCA
	SET	iRefMercado	= CASE	WHEN nCarter = 1 THEN 1
				  	WHEN nCarter = 2 THEN 6 END
	WHERE	nCarter		IN (1,2)
	AND	iRefMercado	= 0

	UPDATE #TEMPORAL_MFCA
	SET	nDiasValor		= ISNULL((SELECT DiasValor FROM BacParamSuda..REFERENCIA_MERCADO_PRODUCTO WITH (NOLOCK)
                                                    WHERE Producto    = nCarter
                                                      AND Modalidad   = cModal
                                                      AND Referencia  = iRefMercado), 0)
	,	dFecEfectiva		= dFecVto
	WHERE	nCarter		IN (1,2)

	DECLARE	@Existe		CHAR(01)
	,	@nContador	INT

	SET	@Existe		= 'S'
	SET	@nContador	= 1

	WHILE @Existe = 'S' BEGIN 
			
		UPDATE	#TEMPORAL_MFCA 
		SET	cDiasFeriados = CASE DATEPART(MONTH,DATEADD(DAY, -1, dFecEfectiva))	
										WHEN 1  THEN feene
										WHEN 2  THEN fefeb
										WHEN 3  THEN femar
										WHEN 4  THEN feabr
										WHEN 5  THEN femay
										WHEN 6  THEN fejun
										WHEN 7  THEN fejul
										WHEN 8  THEN feago
										WHEN 9  THEN fesep
										WHEN 10 THEN feoct
										WHEN 11 THEN fenov
										WHEN  12 THEN fedic
										END
		,	cDiaCaracter	=  CASE WHEN DATEPART(DAY, dFecEfectiva) <= 9	THEN '0' + CONVERT(CHAR(1),DATEPART(DAY, DATEADD(DAY, -1, dFecEfectiva)))
											ELSE CONVERT(CHAR(2),DATEPART(DAY, DATEADD(DAY, -1, dFecEfectiva)))
											END						
		FROM	BACPARAMSUDA..FERIADO WITH (NOLOCK)
		WHERE	feano		= DATEPART(YEAR,DATEADD(DAY, -1, dFecEfectiva))
		AND	feplaza		= 6 -- CHILE
		AND	nCarter		IN (1,2)
		AND	cEstadoDia	= 'I'
		
		UPDATE	#TEMPORAL_MFCA
		SET	dFecEfectiva	= DATEADD(DAY, -1, dFecEfectiva)
		WHERE	nCarter		IN (1,2)
		AND	cEstadoDia	= 'I'

		SET @nContador	= @nContador + 1

		UPDATE	#TEMPORAL_MFCA
		SET	cEstadoDia	= CASE	WHEN CHARINDEX(RTRIM(CONVERT(CHAR(02), cDiaCaracter)),cDiasFeriados) > 0		THEN 'I'	-- SI EL DIA ESTA EN LA CADENA DE FERIADOS
						WHEN DATEPART(WEEKDAY, dFecEfectiva) = 7 OR DATEPART(WEEKDAY, dFecEfectiva) = 1		THEN 'I'	-- SABADO O DOMINGO
						WHEN ABS(nDiasValor) >= @nContador							THEN 'I'
																	ELSE 'H' END	-- DIA HABIL
		WHERE	nCarter		IN (1,2)

		IF (SELECT COUNT(1) FROM #TEMPORAL_MFCA WHERE nCarter IN (1,2) AND cEstadoDia = 'I') = 0 BEGIN
			SET @Existe = 'N'
		END
	END

	/* SE ACTUALIZA PLAZO CON LA NUEVA FECHA EFECTIVA */
	UPDATE	#TEMPORAL_MFCA
	SET	Plazo		= DATEDIFF( DAY, @dFecPro, dFecEfectiva )
	WHERE	nCarter		IN (1,2)

	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	------------------------------------------------------------ FIN CALCULO DE FECHA EFECTIVA ------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------------------------------------------------------------------

	UPDATE	#TEMPORAL_MFCA
	SET	nPlazoVto	= 0
	,	nPlazoVtoEfec	= 0
	WHERE	dFecVto 	< @dFecPro
		
	UPDATE	#TEMPORAL_MFCA
	SET	nPlazoVto      = DATEDIFF(DAY, @FechaCalculos, dFecVto)      
	,	nPlazoVtoEfec  = DATEDIFF(DAY, @FechaCalculos, dFecEfectiva) 
	WHERE	dFecVto >= @dFecPro
			
	UPDATE	#TEMPORAL_MFCA
	SET	nPlazoVtoanterior = DATEDIFF( dd , @dFecProAnt , dFecVto )
	WHERE	dFecini < @dFecPro
				      
	---------------------------------------------------------------------
	--		Plazo de Cálculo hasta Hoy 			   --
	---------------------------------------------------------------------
		
	UPDATE	#TEMPORAL_MFCA
	SET	nPlazoCal	= DATEDIFF(DAY, dFecIni, @FechaCalculos)
	WHERE	dFecVto	= @dFecPro 

	UPDATE	#TEMPORAL_MFCA
	SET	nPlazoCal = DATEDIFF( dd, dFecIni, dFecVto )
	WHERE	dFecVto	< @dFecPro

	UPDATE	#TEMPORAL_MFCA
	SET	nPlazoCal = DATEDIFF( dd, dFecIni, @dFecProxPro )
	WHERE	dFecVto	> @dFecPro

	IF @cLastHabil = 'SI' BEGIN
		UPDATE	#TEMPORAL_MFCA
		SET	nPlazoCal = DATEDIFF( dd , dFecIni , (@dFecUDMPro + 1))
		WHERE	dFecVto <> @dFecPro
	END

	UPDATE	#TEMPORAL_MFCA
	SET	nPlazoCal	= DATEDIFF( dd, dFecIni, vencimiento_original )
	WHERE	canticipo	= 'A' 

	UPDATE	#TEMPORAL_MFCA
	SET	nPlazoCal_a	= DATEDIFF(DAY, dFecIni, @FechaCalculos) 
	WHERE	dFecIni	< @dFecPro

	IF @cFirstHabil = 'SI'	BEGIN 
		UPDATE	#TEMPORAL_MFCA
		SET	nPlazoCal_a	= DATEDIFF( dd , dFecIni , (@dFecUDMAnt + 1))	
		WHERE	dFecIni	< @dFecPro
	END

--	|---------------------------------------------------------------------|
--	| Dias de Devengamiento						      |
--	|---------------------------------------------------------------------|

	UPDATE	#TEMPORAL_MFCA
	SET	dFecAux	= CASE	WHEN dFecVto <  @dFecPro			THEN dFecVto
				WHEN dFecVto >= @dFecPro AND canticipo =  'A'	THEN vencimiento_original
				WHEN dFecVto >= @dFecPro AND canticipo <> 'A'	THEN @dFecProxPro END

	UPDATE	#TEMPORAL_MFCA
	SET	nDiaDev	= CASE	WHEN @cFirstHabil = 'SI' AND dFecIni < @dFecPro AND dFecVto =  @dFecPro	THEN DATEDIFF( dd , ( @dFecUDMAnt + 1 ) , @dFecPro )
				WHEN @cFirstHabil = 'SI' AND dFecIni < @dFecPro AND dFecVto <> @dFecPro	THEN DATEDIFF( dd , ( @dFecUDMAnt + 1 ) , @dFecProxPro )
				WHEN @cLastHabil  = 'SI' 						THEN DATEDIFF( dd , @dFecPro , ( @dFecUDMPro + 1 ) )
				WHEN dFecVto <= @dFecPro AND canticipo <> 'A' AND @cFirstHabil = 'NO'	THEN 0
													ELSE DATEDIFF(DAY, @FechaCalculos, dFecAux )
													END

--	|---------------------------------------------------------------------|
--	| Fin Dias de Devengamiento					      |
--	|---------------------------------------------------------------------|
			
	IF @dFecPro <> @FechaCalculos BEGIN
		UPDATE	#TEMPORAL_MFCA
		SET	nValorUF	= @nValorUF_Pro
	END

	-- @cLastHabil VIENE DE LOS PARAMETROS
	IF @cLastHabil	= 'SI' BEGIN		
		UPDATE	#TEMPORAL_MFCA
		SET	nValorUF	= @nValorUF_UDM
		WHERE	dFecVto		<> @dFecPro
	END

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------
	---------------------------- SEGURO DE CAMBIO CONTRAMONEDA UF -----------------------------
	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------

	UPDATE	#TEMPORAL_MFCA
	SET	nMtoDif = CASE	WHEN cTipOpe = 'C'	THEN nMtoClp_i - nMtoCnv_i
							ELSE nMtoCnv_i - nMtoClp_i END
	,	nDelUsd = CASE	WHEN cTipOpe = 'C'	THEN nValUsd_c - nValMex_i
							ELSE nValMex_i - nValUsd_c END
	,	nDelUf  = CASE	WHEN cTipOpe = 'C'	THEN nValCnv_i - nValorUF
							ELSE nValorUF  - nValCnv_i END
	WHERE	nCarter	= 1
	AND	nCodCnv = 998
		
	UPDATE	#TEMPORAL_MFCA
	SET	nPerDif	= CASE	WHEN nMtoDif < 0	THEN nMtoDif
							ELSE 0 END
	,	nUtiDif	= CASE	WHEN nMtoDif > 0	THEN nMtoDif 
							ELSE 0 END
	WHERE	nCarter	= 1
	AND	nCodCnv = 998
		
	UPDATE	#TEMPORAL_MFCA
	SET	nPerDev = ROUND( ( nPerDif / nPlazoOpe ) * nDiaDev   , 0 )
	,	nUtiDev = ROUND( ( nUtiDif / nPlazoOpe ) * nDiaDev   , 0 )
	,	nPerAcu = ROUND( ( nPerDif / nPlazoOpe ) * nPlazoCal , 0 )
	,	nUtiAcu = ROUND( ( nUtiDif / nPlazoOpe ) * nPlazoCal , 0 )
	WHERE	nCarter = 1
	AND	nCodCnv = 998
		
	UPDATE	#TEMPORAL_MFCA
	SET	nPerSal		= nPerDif - nPerAcu
	,	nUtiSal		= nUtiDif - nUtiAcu
	,	nClp_Mex	= ROUND( nMtoMex * nValUsd_c , 0 )
	,	nClp_Cnv	= ROUND( nMtoCnv * nValorUF   , 0 )
	,	nRevUsd		= ROUND( nMtoMex * nDelUsd    , 0 )
	,	nRevUF		= ROUND( nMtoCnv * nDelUf     , 0 )
	WHERE	nCarter = 1
	AND	nCodCnv = 998

	UPDATE	#TEMPORAL_MFCA
	SET	nRevTot		= nRevUsd + nRevUF + nUtiAcu + nPerAcu
	WHERE	nCarter = 1
	AND	nCodCnv = 998

	UPDATE	#TEMPORAL_MFCA
	SET	nCtaCamb_a	= CASE	WHEN dFecIni < @dFecPro	THEN ROUND( nMtoMex * @nValUsd_Ant , 0 )			
								ELSE ROUND( nMtoMex * nValMex_i , 0 )	END
	,	nCtaCamb_c	= CASE	WHEN dFecIni < @dFecPro	THEN ROUND( nMtoMex * nValUsd_c    , 0 )			
								ELSE ROUND( nMtoMex * nValUsd_c , 0 )	END
	,	nReaUFDia	= CASE	WHEN dFecIni < @dFecPro	THEN ROUND( nMtoCnv * ( nValorUF - @nValorUF_Ant ) , 0 )	
								ELSE ROUND( nMtoCnv * ( nValorUF - @nValorUF_Pro ), 0 )	END
	WHERE	nCarter = 1
	AND	nCodCnv = 998

	UPDATE	#TEMPORAL_MFCA
	SET	nReaTCDia	= nCtaCamb_c - nCtaCamb_a
	WHERE	nCarter = 1
	AND	nCodCnv = 998
			
	UPDATE	#TEMPORAL_MFCA
	SET	nCtaCamb_a	= CASE	WHEN cTipOpe = 'C'	THEN nCtaCamb_a - nUtiDev + ABS( nPerDev )
								ELSE nCtaCamb_a + nUtiDev - ABS( nPerDev ) END
	WHERE	nCarter = 1
	AND	nCodCnv = 998

	UPDATE	#TEMPORAL_MFCA
	SET	nCtaCamb_a	= nCtaCamb_a + nReaUFDia
	WHERE	nCarter = 1
	AND	nCodCnv = 998

	UPDATE	#TEMPORAL_MFCA
	SET	nValorDia	= CASE	WHEN cTipOpe = 'C'	THEN nCtaCamb_c - nCtaCamb_a
								ELSE nCtaCamb_a - nCtaCamb_c END
	WHERE	nCarter = 1
	AND	nCodCnv = 998
		
	UPDATE	#TEMPORAL_MFCA
	SET	nRevTot_a	= nValorDia + Valor_Ayer
	WHERE	nCarter	= 1
	AND	nCodCnv = 998
	
	UPDATE	#TEMPORAL_MFCA
	SET	nMtoComp	= CASE	WHEN cTipOpe = 'C'	THEN ROUND( nMtoMex * nValUsd_c , 0 ) - ROUND( nMtoCnv * nValorUF  , 0 )
								ELSE ROUND( nMtoCnv * nValorUF  , 0 ) - ROUND( nMtoMex * nValUsd_c , 0 ) END
	WHERE	nCarter	= 1
	AND	nCodCnv = 998
	AND	dFecVto	<= @dFecpro 

	UPDATE	#TEMPORAL_MFCA
	SET	nMtoComp	= ROUND(nMtoComp / @nValorDolar, 4)
	WHERE	nCarter  = 1
	AND	nCodCnv = 998
	AND	dFecVto	<= @dFecpro 
	AND	cTipCli	 = 'E'

	UPDATE	#TEMPORAL_MFCA
	SET	nCompensacion_estimada	= CASE	WHEN cTipOpe = 'C'	THEN ROUND( nMtoMex * @ndolar_estimado , 0 ) - ROUND( nMtoCnv * nValorUF , 0 )
									ELSE ROUND( nMtoCnv * nValorUF , 0 )         - ROUND( nMtoMex * @ndolar_estimado , 0 ) END
	WHERE	nCarter	= 1
	AND	nCodCnv = 998
	AND	dFecVto = @dFecProxPro 
	AND	cModal	= 'C'

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------
	---------------------------- SEGURO DE CAMBIO CONTRAMONEDA $ ------------------------------
	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------

	UPDATE	#TEMPORAL_MFCA
	SET	nMtoDif = CASE WHEN cTipOpe = 'C'	THEN nMtoClp_i - nMtoCnv_i		
							ELSE nMtoCnv_i - nMtoClp_i END
	,	nDelUsd = CASE WHEN cTipOpe = 'C'	THEN nValUsd_c - nValMex_i
							ELSE nValMex_i - nValUsd_c END
	WHERE	nCarter	= 1 
	AND	ncodCnv	= 999

	UPDATE	#TEMPORAL_MFCA
	SET	nPerDif	= CASE WHEN nMtoDif < 0	THEN nMtoDif
						ELSE 0 END
	,	nUtiDif = CASE WHEN nMtoDif > 0	THEN nMtoDif		
						ELSE 0 END
	WHERE	nCarter = 1
	AND	nCodCnv = 999

	UPDATE	#TEMPORAL_MFCA
	SET	nPerDev		= ROUND( ( nPerDif / nPlazoOpe ) * nDiaDev   , 0 )
	,	nUtiDev		= ROUND( ( nUtiDif / nPlazoOpe ) * nDiaDev   , 0 )
	,	nPerAcu		= ROUND( ( nPerDif / nPlazoOpe ) * nPlazoCal , 0 )
	,	nUtiAcu		= ROUND( ( nUtiDif / nPlazoOpe ) * nPlazoCal , 0 )
	WHERE	nCarter = 1
	AND	nCodCnv = 999

	UPDATE	#TEMPORAL_MFCA
	SET	nPerSal		= nPerDif - nPerAcu
	,	nUtiSal		= nUtiDif - nUtiAcu
	,	nClp_Mex	= ROUND( nMtoMex * nValUsd_c , 0 )
	,	nClp_Cnv	= nMtoCnv_i
	,	nRevUsd		= ROUND( nMtoMex * nDelUsd   , 0 )
	WHERE	nCarter = 1
	AND	nCodCnv = 999

	UPDATE	#TEMPORAL_MFCA
	SET	nRevTot		= nRevUsd + nUtiAcu + nPerAcu
	WHERE	nCarter = 1
	AND	nCodCnv = 999

	UPDATE	#TEMPORAL_MFCA
	SET	nCtaCamb_a	= CASE WHEN dFecIni < @dFecPro	THEN ROUND( nMtoMex * @nValUsd_Ant , 0 )
								ELSE ROUND( nMtoMex * nValMex_i , 0 ) END
	,	nCtaCamb_c	= ROUND( nMtoMex * nValUsd_c , 0 )
	WHERE	nCarter = 1
	AND	nCodCnv = 999

	UPDATE	#TEMPORAL_MFCA
	SET	nReaTCDia	= nCtaCamb_c - nCtaCamb_a
	WHERE	nCarter = 1
	AND	nCodCnv = 999

	UPDATE	#TEMPORAL_MFCA
	SET	nCtaCamb_a	= CASE WHEN cTipOpe = 'C'	THEN nCtaCamb_a - nUtiDev + ABS( nPerDev )
								ELSE nCtaCamb_a + nUtiDev - ABS( nPerDev ) END
	,	nValorDia	= CASE WHEN cTipOpe = 'C'	THEN nCtaCamb_c - nCtaCamb_a 
								ELSE nCtaCamb_a - nCtaCamb_c END 
	WHERE	nCarter = 1
	AND	nCodCnv = 999

	UPDATE	#TEMPORAL_MFCA
	SET	nRevTot_a	= nValorDia + valor_ayer
	WHERE	nCarter = 1
	AND	nCodCnv = 999


        -- 5522 Inicio Bloque Forward a Observado
	UPDATE	#TEMPORAL_MFCA
	SET	nPreFut	= round( nValUsd_c + PuntosCierre , 4 )
        ,       nMtoCnv = round( nMtoMex  * round( nValUsd_c + PuntosCierre , 4 ) , 0 )
        ,       nMtoCnv_i = round( nMtoMex  * round( nValUsd_c + PuntosCierre , 4 ) , 0 )
	WHERE	nCarter = 14
	AND	nCodCnv = 999
        AND     FechaStarting = @dFecPro
        -- 5522 Fin Bloque Forward a Observado    select caMtoMon2 * from mfca


	UPDATE	#TEMPORAL_MFCA
	SET	nMtoComp	= CASE WHEN cTipOpe = 'C'	THEN ROUND( nMtoMex * nValUsd_c , 0 ) - nMtoCnv_i
								ELSE nMtoCnv_i - ROUND( nMtoMex * nValUsd_c , 0 ) END
--	WHERE	nCarter =  1
	WHERE	nCarter in (  1, 14 )                           -- 5522 Forward a Observado  
	AND	nCodCnv =  999
	AND	dFecVto	<= @dFecpro

	UPDATE	#TEMPORAL_MFCA
	SET	nMtoComp	= ROUND(nMtoComp / @nValorDolar, 4)
--	WHERE	nCarter =  1
	WHERE	nCarter in (  1, 14 )                           -- 5522 Forward a Observado
	AND	nCodCnv  = 999
	AND	dFecVto	<= @dFecpro
	AND	cTipCli	 = 'E'	

	UPDATE	#TEMPORAL_MFCA
	SET	nCompensacion_estimada	= CASE WHEN cTipOpe = 'C'	THEN ROUND( nMtoMex * @ndolar_estimado , 0 ) - nMtoCnv_i
									ELSE nMtoCnv_i - ROUND( nMtoMex * @ndolar_estimado , 0 ) END
--	WHERE	nCarter =  1
	WHERE	nCarter in (  1, 14 )                           -- 5522 Forward a Observado
	AND	nCodCnv  = 999
	AND	dFecVto	 = @dFecproxpro 
	AND	cModal	 = 'C'

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------
	----------------------------------- ARBITRAJE A FUTURO ------------------------------------
	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------

	UPDATE	#TEMPORAL_MFCA
	SET	nmtodif	= CASE WHEN cTipOpe = 'C'	THEN nMtoClp_i - nMtoCnv_i
							ELSE nMtoCnv_i - nMtoClp_i END

	UPDATE	#TEMPORAL_MFCA
	SET	cfuerte	= mnrefusd 
	FROM	VIEW_MONEDA WITH (NOLOCK)
	WHERE	mncodmon	= nCodMon


	--******************************************************************************************************************************--
	--******************************************************************************************************************************--
	--******************************************************************************************************************************--

	UPDATE	#TEMPORAL_MFCA
	SET	TasaBidMe	= (SELECT TOP 1 ISNULL(bidcal,0)   FROM VIEW_MFBIDASK WITH (NOLOCK) WHERE fecha = @dFecpro AND moneda = ncodmon AND plazocal <= Plazo ORDER BY plazocal DESC) 
	,	TasaAskMe	= (SELECT TOP 1 ISNULL(askcal,0)   FROM VIEW_MFBIDASK WITH (NOLOCK) WHERE fecha = @dFecpro AND moneda = ncodmon AND plazocal <= Plazo ORDER BY plazocal DESC) 
	,	PlazoCalMe	= (SELECT TOP 1 ISNULL(plazocal,0) FROM VIEW_MFBIDASK WITH (NOLOCK) WHERE fecha = @dFecpro AND moneda = ncodmon AND plazocal <= Plazo ORDER BY plazocal DESC) 
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR

	UPDATE	#TEMPORAL_MFCA
	SET	TasaBidMa	= (SELECT TOP 1 ISNULL(bidcal,0)   FROM VIEW_MFBIDASK WITH (NOLOCK) WHERE fecha = @dFecpro AND moneda = ncodmon AND plazocal > Plazo ORDER BY plazocal ASC) 
	,	TasaAskMa	= (SELECT TOP 1 ISNULL(askcal,0)   FROM VIEW_MFBIDASK WITH (NOLOCK) WHERE fecha = @dFecpro AND moneda = ncodmon AND plazocal > Plazo ORDER BY plazocal ASC) 
	,	PlazoCalMa	= (SELECT TOP 1 ISNULL(plazocal,0) FROM VIEW_MFBIDASK WITH (NOLOCK) WHERE fecha = @dFecpro AND moneda = ncodmon AND plazocal > Plazo ORDER BY plazocal ASC) 
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR

	---------------------------------------

	UPDATE	#TEMPORAL_MFCA
	SET	TasaBidMe	= 0
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	TasaBidMe IS NULL

	UPDATE	#TEMPORAL_MFCA
	SET	TasaAskMe	= 0
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	TasaAskMe IS NULL

	UPDATE	#TEMPORAL_MFCA
	SET	PlazoCalMe	= 0
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	PlazoCalMe IS NULL

	---------------------------------------	
	
	UPDATE	#TEMPORAL_MFCA
	SET	TasaBidMa	= TasaBidMe
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	TasaBidMa IS NULL

	UPDATE	#TEMPORAL_MFCA
	SET	TasaAskMa	= TasaAskMe
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	TasaAskMa IS NULL

	UPDATE	#TEMPORAL_MFCA
	SET	PlazoCalMa	= PlazoCalMe
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	PlazoCalMa	IS NULL
	
	---------------------------------------

	UPDATE	#TEMPORAL_MFCA
	SET	DifTasaBid	= TasaBidMa  - TasaBidMe
        ,	DifTasaAsk	= TasaAskMa  - TasaAskMe
        ,	DifPlazo	= PlazoCalMa - PlazoCalMe
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	Plazo > PlazoCalMe

	UPDATE	#TEMPORAL_MFCA
	SET	InterpBid	= DifTasaBid / DifPlazo
	,	InterpAsk	= DifTasaAsk / DifPlazo
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	Plazo		> PlazoCalMe
	AND	DifPlazo	<> 0

	UPDATE	#TEMPORAL_MFCA
	SET	TasaUSD		= ROUND(((TasaAskMe + InterpAsk * ( Plazo - PlazoCalMe ) ) + ( TasaBidMe + InterpBid * ( Plazo - PlazoCalMe))) / 2 ,6)
	,	Valor_Obtenido	= ((TasaAskMe + InterpAsk * ( Plazo - PlazoCalMe ) ) + ( TasaBidMe + InterpBid * ( Plazo - PlazoCalMe))) / 2 
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	Plazo		> PlazoCalMe

	UPDATE	#TEMPORAL_MFCA
	SET	TasaUSD		= ROUND(( TasaBidMe + TasaAskMe ) / 2 ,6)
	,	Valor_Obtenido	= ( TasaBidMe + TasaAskMe ) / 2
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	Plazo		<= PlazoCalMe
	

	UPDATE	#TEMPORAL_MFCA
	SET	PuntaSpot	= vmptacmp
	,	TasaFwd		= vmptacmp
	FROM	VIEW_VALOR_MONEDA 
	WHERE	vmcodigo	= ncodmon
	AND	vmfecha		= @dFecpro
	AND	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR

	UPDATE	#TEMPORAL_MFCA
	SET	PrecioFwd     = TasaUSD + TasaFWD	
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR

	--******************************************************************************************************************************--
	--******************************************************************************************************************************--
	--******************************************************************************************************************************--


	UPDATE	#TEMPORAL_MFCA
	SET	PrecioFwd	= CASE WHEN PrecioFwd = 0	THEN 0 
								ELSE ROUND((1.0 / PrecioFwd) ,10) END
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	cFuerte		= 0

	UPDATE	#TEMPORAL_MFCA
	SET	ValorMTM_USD	= ROUND( nMtoMex * PrecioFwd    , 2 ) 
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR

	UPDATE	#TEMPORAL_MFCA
	SET	ValorPte_USD = ROUND( nMtoCnv - ValorMTM_USD , 2 )
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR


	UPDATE	#TEMPORAL_MFCA
	SET	ValorPte_USD =  ValorPte_USD * -1
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	cTipOpe		= 'C'

	UPDATE	#TEMPORAL_MFCA
	SET	PrecioFwd	= CASE WHEN PrecioFwd = 0	THEN 0 
								ELSE ROUND((1 / PrecioFwd) ,10) END
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR
	AND	cFuerte		= 0

	UPDATE	#TEMPORAL_MFCA
	SET	nValorDia	= ROUND(ISNULL(ValorPte_USD * nValUsd_c, 0.0),0)
	,	nTipCamVal	= ISNULL(PrecioFwd,0.0)
	WHERE	nCarter		= 2
	AND	dFecVto		> @dFecPro 
	AND	nCodCnv		= 13	-- DOLAR		

	---------------------------------------------------------------------------

	UPDATE	#TEMPORAL_MFCA
	SET	PrecioFwd = nTcCierre
	WHERE	nCarter		= 2
	AND	dFecVto	<= @dFecpro 
	AND	cModal	 = 'C'


	UPDATE	#TEMPORAL_MFCA
	SET	PrecioFwd = CASE WHEN PrecioFwd = 0	THEN 0 
								ELSE ROUND((1 / PrecioFwd) ,10) END
	WHERE	nCarter	 = 2
	AND	dFecVto	<= @dFecpro 
	AND	cModal	 = 'C'
	AND	cFuerte	 = 0

/*
--> Se comenta este codigo, para que calcule la compensacion para los arbitrajes, dado que se calcula en ingreso de paridades al vcto.
	UPDATE  #TEMPORAL_MFCA
	   SET  nMtoComp = CASE WHEN cTipOpe = 'C'	THEN ROUND(nMtoMex * CASE WHEN NroMxClp > 0 THEN nPreFut ELSE PrecioFWD END, 2) - nMtoCnv
							ELSE		   nMtoCnv - ROUND(nMtoMex * CASE WHEN NroMxClp > 0 THEN nPreFut ELSE PrecioFWD END, 2) 
					   END
	WHERE	nCarter	 = 2
	AND		dFecVto	<= @dFecpro 
	AND		cModal	 = 'C'

	UPDATE	#TEMPORAL_MFCA
	   SET	nMtoComp = CASE WHEN cTipOpe = 'C'	THEN ROUND(nMtoMex * PrecioFWD, 2) - nMtoCnv
							ELSE		   nMtoCnv - ROUND(nMtoMex * PrecioFWD, 2 ) 
	      			   END
	WHERE	nCarter	 = 2
	AND		dFecVto	<= @dFecpro 
	AND		cModal	 = 'C'

	UPDATE	#TEMPORAL_MFCA
	SET	nMtoComp	= CASE WHEN cTipOpe = 'C'	THEN ROUND(nMtoMex * nTipCamVal , 2) - nMtoCnv
								ELSE nMtoCnv - ROUND( nMtoMex * nTipCamVal , 2 ) END
	WHERE	nCarter	 = 2
	AND	dFecVto	<= @dFecpro 
	AND	cModal	 = 'C'

	UPDATE #TEMPORAL_MFCA
	   SET nMtoComp  = ROUND( nMtoComp * nValUsd_c, 0)
	 WHERE nCarter	 = 2
	   AND dFecVto	<= @dFecpro 
	   AND cModal	 = 'C'
	   AND cTipCli	 = 'L' 
	   AND nCodCnv	 NOT IN (999 ,998)
*/
	   

	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------
	---------------------------------- SEGURO DE INFLACION ------------------------------------
	----------------------------------         Y           ------------------------------------
	---------------------------------- SEG INF HIPOTECARIO ------------------------------------
	-------------------------------------------------------------------------------------------
	-------------------------------------------------------------------------------------------

	UPDATE	#TEMPORAL_MFCA	
	SET	nMtoDif		= CASE WHEN cTipOpe = 'C'	THEN nMtoClp_i - nMtoCnv_i
								ELSE nMtoCnv_i - nMtoClp_i	END
	,	nDelUf		= CASE WHEN cTipOpe = 'C'	THEN nValorUF  - nValMex_i
								ELSE nValMex_i - nValorUF	END
	WHERE	nCarter	 IN (3,13)	


	UPDATE	#TEMPORAL_MFCA	
	SET	nDelUf_a	= CASE WHEN cTipOpe = 'C' 	THEN @nValorUF_Ant - nValMex_i
								ELSE nValMex_i   - @nValorUF_Ant END
	WHERE	nCarter	 IN (3,13)	
	AND	dFecIni < @dFecPro

	UPDATE	#TEMPORAL_MFCA	
	SET	nPerDif	= CASE WHEN nMtoDif < 0	THEN nMtoDif
						ELSE 0	END
	,	nUtiDif	= CASE WHEN nMtoDif < 0	THEN nMtoDif
						ELSE 0	END
	WHERE	nCarter	 IN (3,13)

	UPDATE	#TEMPORAL_MFCA	
	SET	nPerDev	= ROUND( ( nPerDif / nPlazoOpe ) * nDiaDev  , 0 )
	,	nUtiDev = ROUND( ( nUtiDif / nPlazoOpe ) * nDiaDev  , 0 )
	,	nPerAcu	= ROUND( ( nPerDif / nPlazoOpe ) * nPlazoCal , 0 )
	,	nUtiAcu = ROUND( ( nUtiDif / nPlazoOpe ) * nPlazoCal , 0 )
	WHERE	nCarter	 IN (3,13)	

	UPDATE	#TEMPORAL_MFCA	
	SET	nPerSal		= nPerDif - nPerAcu
	,	nUtiSal		= nUtiDif - nUtiAcu
	,	nClp_Mex	= ROUND( nMtoMex * nValorUf , 0 )
	,	nClp_Cnv	= nMtoCnv_i
	,	nRevUF		= ROUND( nMtoMex * nDelUf  , 0 )
	WHERE	nCarter	 IN (3,13)

	UPDATE	#TEMPORAL_MFCA	
	SET	nRevTot		= nRevUF + nUtiAcu + nPerAcu
	,	nRevUF_a	= ROUND( nMtoMex * nDelUf_a , 0)
	WHERE	nCarter	 IN (3,13)	

	UPDATE	#TEMPORAL_MFCA	
	SET	nCtaCamb_a	= CASE WHEN dFecIni < @dFecPro	THEN ROUND( nMtoMex * @nValorUF_Ant , 0 )
								ELSE @nValorUF_Pro	END
	,	nCtaCamb_c	= CASE WHEN dFecIni < @dFecPro	THEN ROUND( nMtoMex * nValorUF , 0 )
								ELSE nValorUF		END
	,	nReaUFDia	= CASE WHEN dFecIni < @dFecPro	THEN ROUND( nMtoCnv * ( nValorUF - @nValorUF_Ant ) , 0 )
								ELSE ROUND( nMtoCnv * ( nValorUF - @nValorUF_Pro ) , 0 )	END
	WHERE	nCarter	 IN (3,13)	

	UPDATE	#TEMPORAL_MFCA	
	SET	nCtaCamb_a	= CASE WHEN cTipOpe = 'C'	THEN nCtaCamb_a - nUtiDev + ABS( nPerDev )
								ELSE nCtaCamb_a + nUtiDev - ABS( nPerDev ) END
	,	nValorDia	= CASE WHEN cTipOpe = 'C'	THEN nCtaCamb_c - nCtaCamb_a
								ELSE nCtaCamb_a - nCtaCamb_c END
	WHERE	nCarter	 IN (3,13)	

	UPDATE	#TEMPORAL_MFCA	
	SET	nRevTot_a	= nValorDia + Valor_ayer
	WHERE	nCarter	 IN (3,13)	

	UPDATE	#TEMPORAL_MFCA	
	SET	nMtoComp	= CASE WHEN cTipOpe = 'C'	THEN ROUND( nMtoMex * nValorUF , 0 ) - nMtoCnv
								ELSE nMtoCnv - ROUND( nMtoMex * nValorUF , 0 ) END
	WHERE	nCarter	 IN (3,13)	
	AND	dFecVto	<= @dFecpro


	/**************************************************************************************************************************************************************/
	/**************************************************************************************************************************************************************/
	/**************************************************************************************************************************************************************/
	DECLARE	@cNuevoBegin	CHAR(1)
/*
		SELECT	nNumOpe, nMtoMex, PrecioFWD, nMtoCnv, 
		        TMP.nPlazoOpe		
		,	TMP.nPlazoVto		
		,	TMP.nPlazoCal		
		,	TMP.nDiaDev		
		,	TMP.nReaTCDia		-- Diferencia
		,	TMP.nReaUFDia		-- Reajustes
		,	TMP.nRevUsd		-- Inicio - Hoy
		,	TMP.nRevUF		-- Inicio - Hoy
		,	TMP.nrevTot		
		,	TMP.nRevUF_a		-- Inicio - Ayer
		,	TMP.nrevTot_a		
		,	TMP.nValorDia		
		,	TMP.nctaCamb_a		
		,	TMP.nctaCamb_c		
		,	TMP.nUtiDif 		
		,	TMP.nPerDif		
		,	TMP.nUtiDev		-- Utilida Diario
		,	TMP.nPerDev		-- perdida Diario
		,	TMP.nUtiAcu		-- Acumulado 		 			
		,	TMP.nPerAcu		-- Acumulado
		,	TMP.nUtiSal		-- Saldo					
		,	TMP.nPerSal		
		,	TMP.nClp_Mex		-- Monto CLP Hoy 
		,	TMP.nClp_Cnv		-- 
		,	TMP.nDelUsd
		,	TMP.ndelUf
		,	TMP.nMtoComp
		,	TMP.ntipcamval
		,	TMP.nmtodif, * 

	FROM #TEMPORAL_MFCA	TMP


*/

		UPDATE  MFCA  
		SET	caplazoope                      = TMP.nPlazoOpe		
		,	caplazovto                      = TMP.nPlazoVto		
		,	caplazocal                      = TMP.nPlazoCal		
		,	cadiasdev                       = TMP.nDiaDev		
		,	cadiftipcam 			= TMP.nReaTCDia		-- Diferencia
		,	cadifuf 			= TMP.nReaUFDia		-- Reajustes
		,	carevusd			= TMP.nRevUsd		-- Inicio - Hoy
		,	carevuf				= TMP.nRevUF		-- Inicio - Hoy
		,	carevTot			= TMP.nrevTot		
		,	carevuf_ayer			= TMP.nRevUF_a		-- Inicio - Ayer
		,	carevTot_ayer			= TMP.nrevTot_a		
		,	cavalordia			= TMP.nValorDia		
		,	cactacambio_a			= TMP.nctaCamb_a		
		,	cactacambio_c			= TMP.nctaCamb_c		
		,	cautildiferir			= TMP.nUtiDif 		
		,	caperddiferir 			= TMP.nPerDif		
		,	cautildevenga 			= TMP.nUtiDev		-- Utilida Diario
		,	caperddevenga 			= TMP.nPerDev		-- perdida Diario
		,	cautilacum 			= TMP.nUtiAcu		-- Acumulado 		 			
		,	caperdacum 			= TMP.nPerAcu		-- Acumulado
		,	cautilsaldo 			= TMP.nUtiSal		-- Saldo					
		,	caperdsaldo 			= TMP.nPerSal		
		,	caclpmoneda1 			= TMP.nClp_Mex		-- Monto CLP Hoy 
		,	caclpmoneda2 			= TMP.nClp_Cnv		-- 
		,	cadelusd			= TMP.nDelUsd
		,	cadeluf				= TMP.ndelUf
		,	camtocomp      			= CASE WHEN cacodpos1 = 2 then camtocomp else TMP.nMtoComp end
		,	catipcamval     		= TMP.ntipcamval
		,	camtodiferir			= TMP.nmtodif 
                -- 5522 Inicio Bloque Forward a Observado
                ,       CaTipCam                        = Case when CaCodPos1 = 14 and CaFechaStarting = @dFecPro 
                                                          then TMP.nPreFut else CaTipCam  end
                ,       CaMtoMon2                       = Case when CaCodPos1 = 14 and CaFechaStarting = @dFecPro 
                                                          then TMP.nMtoCnv else CaMtoMon2 end
                ,       caequmon2                       = case when CaCodPos1 = 14 then  nMtoCnv_i else caequmon2 end
                -- 5522 Inicio Bloque Forward a Observado
		FROM	#TEMPORAL_MFCA	TMP
		WHERE   canumoper                       = TMP.nNumOpe
		AND	nCorrelativo			= 0


		UPDATE	TBL_CARTERA_FLUJOS
		SET	Ctf_Articulo84			= nMtoDif
		FROM	#TEMPORAL_MFCA	TMP
		WHERE	Ctf_Numero_OPeracion		= TMP.nNumOpe
		AND	Ctf_Correlativo			= TMP.nCorrelativo


	SET NOCOUNT OFF
END
GO
