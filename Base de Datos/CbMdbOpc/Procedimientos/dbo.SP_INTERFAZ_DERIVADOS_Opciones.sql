USE [CbMdbOpc]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_DERIVADOS_Opciones]    Script Date: 16-05-2022 10:15:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[SP_INTERFAZ_DERIVADOS_Opciones]
AS
BEGIN

	SET NOCOUNT ON

	-- ASVG 02 Marzo 2011: Se filtran las operaciones de Forward Americano (código estructura 8), salen por las interfaces de Bac Forward.
	--      Para el filtrado se agregó un join... se podría evitar con el where solamente en el último select ?
	--      OBS: muchas líneas en blanco al rededor de la #200
	-- ASVG 10 Marzo 2011: Se dejan las operaciones de Forward Americano por opciones, se elimina ASVG_20110302.
	-- ASVG 22 Marzo 2011: MAP 20110321 Se asume que cliente ejerce antes de vencimiento si le conviene.
	-- ASVG 23 Marzo 2011: Se da vuelta el signo.
	--       OBS: muchas líneas en blanco al rededor de la #200, borradas.
	-- ASVG 27 Abril 2011: MAP 20110426 Se implementa nueva lógica para informe C08
	
	-- RCHS 13 Noviembre 2019: Se restringe la salida sólo para operaciones que tengan activo_mtm>=0 e igual para los pasivos_mtm, se excluyen montos negativos
	
	
	DECLARE @Fecha				DATETIME
	DECLARE	@Fecha_Prox			DATETIME -- MAP 20110321

	SELECT	@Fecha				= fechaproc
		,	@Fecha_Prox			= fechaprox -- MAP 20110321
	FROM	CbMdbOpc.dbo.OpcionesGeneral

	SELECT	CaNumContrato		= Detalle.CaNumContrato
		,	CaNumEstructura		= Detalle.CaNumEstructura
		,	CaFechaPagoEjer		= Detalle.CaFechaPagoEjer
		,	CaCVOpc				= Detalle.CaCVOpc
		,	CaCallPut			= Detalle.CaCallPut
		,	CaModalidad			= Detalle.CaModalidad
		,	CaCodMon1			= Detalle.CaCodMon1
		,	CaCodMon2			= Detalle.CaCodMon2
		,	CaMontoMon1			= Detalle.CaMontoMon1
		,	CaMontoMon2			= Detalle.CaMontoMon2
									-- Maria Paz: Aqui pone el spot cuando el mtm < 0
		,	[CaFlujo1]			= DETALLE.CaMontoMon1 * CASE	WHEN		ENCABEZADO.CaCodEstructura	= 8
																AND (	(	DETALLE.CaVrDetML			< 0 AND DETALLE.CaCVOpc = 'V')
																	OR	(	DETALLE.CaVrDetML			> 0 AND DETALLE.CaCVOpc = 'C')
																	) THEN	DETALLE.CaSpotDet
																ELSE		DETALLE.CaFwd_teo
															END
		,	[CaFlujo2]			= DETALLE.CaMontoMon2
		,	[Compensacion]		= CONVERT(NUMERIC(18),0)
		,	CaVrDetML			= Detalle.CaVrDetML
		,	CaWf_Mon2			= Detalle.CaWf_Mon2
		,	MdaEntra			= case	when Detalle.CaModalidad = 'E' and Detalle.CaCVOpc = 'C' then Detalle.CaCodMon1
										when Detalle.CaModalidad = 'E' and Detalle.CaCVOpc = 'V' then Detalle.CaCodMon2
										else CaMdaCompensacion             -- MAP 5203 Inclusion de la moneda compensacion se cambia	si es EF
									end
		,	MdaSale				= case	when Detalle.CaModalidad = 'E' and Detalle.CaCVOpc = 'C' then Detalle.CaCodMon2
										when Detalle.CaModalidad = 'E' and Detalle.CaCVOpc = 'V' then Detalle.CaCodMon1
										else CaMdaCompensacion             -- MAP 5203 Inclusion de la moneda compensacion se cambiara si es EF
									end
		,	CaCodEstructura		= ENCABEZADO.CaCodEstructura
		,   VrActivo			= case	when Detalle.CaVrDetML > 0 then Detalle.CaVrDetML else 0					end
		,   VrPasivo			= case	when Detalle.CaVrDetML > 0 then					0 else -Detalle.CaVrDetML	end
		,   OpcContabExternaTip	= Estructura.OpcContabExternaTip
	INTO	#CaDetContrato
	FROM	CbMdbOpc.dbo.CaDetContrato			AS Detalle
			join CbMdbOpc.dbo.CaEncContrato		AS Encabezado ON Detalle.CaNumContrato		= Encabezado.CaNumContrato	-->	ASVG_20110302 para obtener la estructura
			join CbMdbOpc.dbo.OpcionEstructura	As Estructura ON Encabezado.CaCodEstructura	= Estructura.OpcEstCod		-->	PROD-14245
	WHERE   caFechaPagoEjer					 > @Fecha
	AND		Estructura.OpcContabExternaTip	<> 'OTROS_FWD'	--	PROD-14245
	AND		Encabezado.CaEstado				<> 'C'			--	PROD-14245
--	AND		Encabezado.CaCodEstructura != '8' --ASVG_20110302 Forward americano va en interfaces de Bac Forward  

	-- PROD-14245 
	INSERT	INTO #CaDetContrato
/*	SELECT	CaNumContrato			= Detalle.CaNumContrato
		,	CaNumEstructura			= 1
		,	CaFechaPagoEjer			= Detalle.CaFechaPagoEjer 
		,	CaCVOpc					= Encabezado.CaCVEstructura
		,	CaCallPut				= Case when Encabezado.CaCVEstructura = 'C' then 'Call' else 'Put' end
		,	CaModalidad				= Detalle.CaModalidad
		,	CaCodMon1				= Detalle.CaCodMon1
		,	CaCodMon2				= Detalle.CaCodMon2
		,	CaMontoMon1				= Detalle.CaMontoMon1
		,	CaMontoMon2				= Detalle.CaMontoMon2
		,	[CaFlujo1]				= DETALLE.CaMontoMon1 * DETALLE.CaFwd_teo
		,	[CaFlujo2]				= DETALLE.CaMontoMon2
		,   [Compensacion]			= CONVERT(NUMERIC(18),0)  
		,	CaVrDetML				= sum(Detalle.CaVrDetML )
		,	CaWf_Mon2				= Detalle.CaWf_Mon2
		,   MdaEntra				= Detalle.CaMdaCompensacion             -- MAP 5203 Inclusion de la moneda compensacion se cambia si es EF  
		,   MdaSale					= Detalle.CaMdaCompensacion             -- MAP 5203 Inclusion de la moneda compensacion se cambiara si es EF   
		,	CaCodEstructura			= Encabezado.CaCodEstructura
		,   VrActivo				= sum( case when Detalle.CaVrDetML > 0 then Detalle.CaVrDetML else 0 end )
		,   VrPasivo				= sum( case when Detalle.CaVrDetML > 0 then 0 else -Detalle.CaVrDetML end )
		,   OpcContabExternaTip		= Estructura.OpcContabExternaTip
	FROM	CbMdbOpc.dbo.CaDetContrato			AS Detalle		with(nolock)
			join CbMdbOpc.dbo.CaEncContrato		AS Encabezado	with(nolock)	ON Detalle.CaNumContrato		= Encabezado.CaNumContrato --ASVG_20110302 para obtener la estructura
			join CbMdbOpc.dbo.OpcionEstructura	As Estructura	with(nolock)	ON Encabezado.CaCodEstructura	= Estructura.OpcEstCod --PROD-14245
	WHERE	caFechaPagoEjer						> @Fecha
	AND		Estructura.OpcContabExternaTip		= 'OTROS_FWD'
	AND		Encabezado.CaEstado				   <> 'C'                      
	group 
	by		Detalle.CaNumContrato
		,	Detalle.CaFechaPagoEjer
		,	Encabezado.CaCVEstructura
		,	Detalle.CaModalidad
		,	Detalle.CaCodMon1
		,	Detalle.CaCodMon2
		,	Detalle.CaMontoMon1
		,	Detalle.CaMontoMon2
		,	DETALLE.CaMontoMon1 * DETALLE.CaFwd_teo 
		,	Detalle.CaMdaCompensacion
		,	Encabezado.CaCodEstructura
		,	Estructura.OpcContabExternaTip
		,	Detalle.CaWf_Mon2*/

	SELECT	CaNumContrato			= Detalle.CaNumContrato
		,	CaNumEstructura			= 1
		,	CaFechaPagoEjer			= Detalle.CaFechaPagoEjer 
		,	CaCVOpc					= Encabezado.CaCVEstructura
		,	CaCallPut				= Case when Encabezado.CaCVEstructura = 'C' then 'Call' else 'Put' end
		,	CaModalidad				= Detalle.CaModalidad
		,	CaCodMon1				= Detalle.CaCodMon1
		,	CaCodMon2				= Detalle.CaCodMon2
		,	CaMontoMon1				= Detalle.CaMontoMon1
		,	CaMontoMon2				= Detalle.CaMontoMon2
		,	[CaFlujo1]				= Det.Monto * Det.FwdTeorico
		,	[CaFlujo2]				= DETALLE.CaMontoMon2
		,   [Compensacion]			= CONVERT(NUMERIC(18),0)  
		,	CaVrDetML				= sum(Detalle.CaVrDetML )
		,	CaWf_Mon2				= Detalle.CaWf_Mon2
		,   MdaEntra				= Detalle.CaMdaCompensacion             -- MAP 5203 Inclusion de la moneda compensacion se cambia si es EF  
		,   MdaSale					= Detalle.CaMdaCompensacion             -- MAP 5203 Inclusion de la moneda compensacion se cambiara si es EF   
		,	CaCodEstructura			= Encabezado.CaCodEstructura
		,   VrActivo				= sum( case when Detalle.CaVrDetML > 0 then Detalle.CaVrDetML else 0 end )
		,   VrPasivo				= sum( case when Detalle.CaVrDetML > 0 then 0 else -Detalle.CaVrDetML end )
		,   OpcContabExternaTip		= Estructura.OpcContabExternaTip
	FROM	CbMdbOpc.dbo.CaDetContrato			AS Detalle		with(nolock)
			-->    Solamente para evitar la Duplicidad de Registros
			inner join (select  canumcontrato	= canumcontrato
							,	Monto			= camontomon1
							,	FwdTeorico		= MIN( cafwd_teo )
						from	CbMdbOpc.dbo.CaDetContrato
						group 
						by		canumcontrato
							,	camontomon1
						)	Det	On	Det.canumcontrato	= Detalle.canumcontrato
								and Det.Monto			= Detalle.camontomon1
			-->    Solamente para evitar la Duplicidad de Registros
			join CbMdbOpc.dbo.CaEncContrato		AS Encabezado	with(nolock)	ON Detalle.CaNumContrato		= Encabezado.CaNumContrato --ASVG_20110302 para obtener la estructura
			join CbMdbOpc.dbo.OpcionEstructura	As Estructura	with(nolock)	ON Encabezado.CaCodEstructura	= Estructura.OpcEstCod --PROD-14245
	WHERE	caFechaPagoEjer						> (	SELECT  fechaproc	FROM	CbMdbOpc.dbo.OpcionesGeneral with(nolock)	)
	AND		Estructura.OpcContabExternaTip		= 'OTROS_FWD'
	AND		Encabezado.CaEstado				   <> 'C'                 
	group 
	by		Detalle.CaNumContrato
		,	Detalle.CaFechaPagoEjer
		,	Encabezado.CaCVEstructura
		,	Detalle.CaModalidad
		,	Detalle.CaCodMon1
		,	Detalle.CaCodMon2
		,	Detalle.CaMontoMon1
		,	Detalle.CaMontoMon2
		,(	Det.Monto * Det.FwdTeorico )
		,	Detalle.CaMdaCompensacion
		,	Encabezado.CaCodEstructura
		,	Estructura.OpcContabExternaTip
		,	Detalle.CaWf_Mon2
	-- PROD-14245
	--> Calcula la compensacion
	UPDATE	#CaDetContrato
	SET		Compensacion	= CaFlujo1 - CaFlujo2
	--> Calcula la compensacion

	--> Actualiza los flujos de las opciones compensadas (inicio bloque)
	UPDATE	#CaDetContrato
	SET		CaFlujo1	= CASE	WHEN Compensacion > 0 AND (		CaCodEstructura		in ( 8, 6 )
														OR  (	CaCodEstructura not in ( 8, 6 )
															AND CaCallPut		= 'Call'
															)
														) THEN	Compensacion
								ELSE							0
							END
	,		CaFlujo2	= CASE	WHEN Compensacion < 0 AND (		CaCodEstructura		in ( 8, 6)
														OR  (	CaCodEstructura not in ( 8, 6)
															AND CaCallPut		= 'Put')
														) THEN -Compensacion
								ELSE						    0
							END
	WHERE	CaModalidad	= 'C'
	--> Actualiza los flujos de las opciones compensadas (fin bloque)


	SELECT	'fecha_contable'	= @Fecha
		,	'cod_producto'		= 'MD49'
		,   'T_producto'		= 'MDIR'
		,   'rut'				= rtrim( CONVERT(CHAR(9), Enc.caRutCliente) )
		,   'dig'				= ISNULL( C.Cldv,'')
		,   'n_operacion'		= CONVERT(VARCHAR(10), rtrim( Det.CaNumContrato ) + rtrim( Det.CaNumEstructura ) )
		,   'fecha_inic'		= convert(char(8), Enc.CaFechaContrato,112)
		,	'fecha_vcto'		= CASE  WHEN Det.CaCodEstructura = 8 AND Det.CaVrDetML < 0 AND Det.CaCVOpc = 'V' THEN @Fecha_Prox
										ELSE Det.CaFechaPagoEjer
									END
		,	'mda_compra'		= CASE  WHEN Det.CaCVOpc = 'C' and Det.CaCallPut = 'Call' THEN Det.CaCodMon1
										WHEN Det.CaCVOpc = 'V' and Det.CaCallPut = 'Put'  THEN Det.CaCodMon1
										WHEN Det.CaCVOpc = 'C' and Det.CaCallPut = 'Put'  THEN Det.CaCodMon2
										WHEN Det.CaCVOpc = 'V' and Det.CaCallPut = 'Call' THEN Det.CaCodMon2
									END
		,	'mto_compra'		= convert( numeric(18)
								, CASE	WHEN Det.CaCVOpc = 'C' AND Det.CaCallPut = 'Call' THEN Det.CaMontoMon1
										WHEN Det.CaCVOpc = 'V' AND Det.CaCallPut = 'Put'  THEN Det.CaMontoMon1
										WHEN Det.CaCVOpc = 'C' AND Det.CaCallPut = 'Put'  THEN Det.CaMontoMon2
										WHEN Det.CaCVOpc = 'V' AND Det.CaCallPut = 'Call' THEN Det.CaMontoMon2
									END	)
		,	'mda_venta'			= CASE  WHEN Det.CaCVOpc = 'C' and Det.CaCallPut = 'Call' THEN Det.CaCodMon2
										WHEN Det.CaCVOpc = 'V' and Det.CaCallPut = 'Put'  THEN Det.CaCodMon2
										WHEN Det.CaCVOpc = 'C' and Det.CaCallPut = 'Put'  THEN Det.CaCodMon1
										WHEN Det.CaCVOpc = 'V' and Det.CaCallPut = 'Call' THEN Det.CaCodMon1
									END
		,	'mto_venta'			= convert( numeric(18)
								, CASE	WHEN Det.CaCVOpc = 'C' and Det.CaCallPut = 'Call' THEN Det.CaMontoMon2
										WHEN Det.CaCVOpc = 'V' and Det.CaCallPut = 'Put'  THEN Det.CaMontoMon2
										WHEN Det.CaCVOpc = 'C' and Det.CaCallPut = 'Put'  THEN Det.CaMontoMon1
										WHEN Det.CaCVOpc = 'V' and Det.CaCallPut = 'Call' THEN Det.CaMontoMon1
									END )
		,	'tip_vcto'			= CASE  WHEN Det.CaModalidad = 'E' THEN 'D'
										ELSE Det.CaModalidad
									END
		,	'activo_mtm'		= convert( numeric(18)
								, CASE	WHEN Det.CaCVOpc = 'C' AND Det.CaCallPut = 'Call' THEN Det.CaFlujo1
										WHEN Det.CaCVOpc = 'V' AND Det.CaCallPut = 'Put'  THEN Det.CaFlujo1
										WHEN Det.CaCVOpc = 'C' AND Det.CaCallPut = 'Put'  THEN Det.CaFlujo2
										WHEN Det.CaCVOpc = 'V' AND Det.CaCallPut = 'Call' THEN Det.CaFlujo2
									END )
		,	'pasivo_mtm'		= convert( numeric(18)
								, CASE  WHEN Det.CaCVOpc = 'C' and Det.CaCallPut = 'Call' THEN Det.CaFlujo2
										WHEN Det.CaCVOpc = 'V' and Det.CaCallPut = 'Put'  THEN Det.CaFlujo2
										WHEN Det.CaCVOpc = 'C' and Det.CaCallPut = 'Put' THEN Det.CaFlujo1
										WHEN Det.CaCVOpc = 'V' and Det.CaCallPut = 'Call' THEN Det.CaFlujo1
									END )
		,	'Vpresen_activo'	=  convert( numeric(18)
								, Case	when OpcContabExternaTip = 'OTROS_FWD' then VrActivo
										else	Case	when Det.CaVrDetML > 0 then Det.CaVrDetML
														Else 0
													End
									end )
		,	'Vpresen_pasivo'	= convert( numeric(18)
								, Case	when OpcContabExternaTip = 'OTROS_FWD' then VrPasivo
										else	Case	when Det.CaVrDetML < 0 then -Det.CaVrDetML
														Else 0
													end
									end )
		,	'Flujos'			= ' '
		,	'Wf_mon2'			= Det.CaWf_mon2
		,	'MdaEntra'			= Det.MdaEntra -- MAP 5203
        ,   'MdaSale'			= Det.MdaSale  -- MAP 5203
	INTO	#Temporal
	FROM	#CaDetContrato				As Det
		,	CbMdbOpc.dbo.CaEncContrato	As Enc
			LEFT JOIN	BACPARAMSUDA.DBO.CLIENTE C ON caRutCliente = clrut AND caCodigo = clcodigo
	WHERE   Det.caFechaPagoEjer > @Fecha
    AND		Enc.CaNumContrato	= Det.CaNumContrato
--	AND		Enc.CaEstado		<> 'C'   PROD-14245    

	UPDATE	#Temporal    
	SET		MdaEntra =  Mda_Compra     
	,		MdaSale  =  Mda_Venta 
	WHERE	Tip_Vcto <> 'C'      
	-- Para entrega fisica se asume la moneda1 y moneda2     
    -- con el criterio Call-Put Compra - Venta     
     
	SELECT	fecha_contable
	,		cod_producto
	,		T_producto
	,		rut
	,		dig
	,		n_operacion
	,		fecha_inic
	,		fecha_vcto
	,		mda_compra
	,		mto_compra
	,		mda_venta
	,		mto_venta
	,		tip_vcto
	,		activo_mtm
	,		pasivo_mtm
	,		Vpresen_activo
	,		Vpresen_pasivo
	,		Flujos
	,		Wf_mon2
	,		MdaEntra
	,		MdaSale
	FROM	#Temporal 
	WHERE (activo_mtm>=0) OR (pasivo_mtm>=0)
	ORDER 
	BY		convert(int, N_Operacion  )

END  


GO
