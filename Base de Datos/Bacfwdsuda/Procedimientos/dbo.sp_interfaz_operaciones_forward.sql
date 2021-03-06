USE [Bacfwdsuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_interfaz_operaciones_forward]    Script Date: 13-05-2022 10:30:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_interfaz_operaciones_forward]
   (   @fechafinmeshabil   CHAR(8)
   ,   @fechafinmes        CHAR(8)
   )
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @FECHA				DATETIME    
		SET @FECHA				= (select acfecproc from mfac with(nolock))

	DECLARE @vDolar_obsFinMes	FLOAT
	DECLARE @vUF_FinMes			FLOAT

	DECLARE @max				INTEGER    
		SET @max				= (select count(1) from mfca with(nolock) where cafecha = @fecha)

		SET @vDolar_obsFinMes   = 0.0
	SELECT	@vDolar_obsFinMes   = ISNULL(vmvalor,0.0)     FROM BacParamSuda..VALOR_MONEDA          with (nolock) WHERE vmcodigo      = 994 AND vmfecha = @FECHA    

		SET @vDolar_obsFinMes   = 0.0
	SELECT	@vDolar_obsFinMes   = ISNULL(Tipo_Cambio,0.0) FROM BacParamSuda..VALOR_MONEDA_CONTABLE with (nolock) WHERE Codigo_Moneda = 994 AND Fecha   = @FECHA    

		SET @vUF_FinMes         = 0.0
	SELECT	@vUF_FinMes         = ISNULL(vmvalor,0.0)     FROM BacParamSuda..VALOR_MONEDA          with (nolock) WHERE vmcodigo      = 998 AND vmfecha = @FECHAFINMES    

	SELECT	vmptacmp
		,	mnrefusd
		,	mncodmon
		,	vmvalor
	INTO	#TIPOCAMBIO
	FROM	BacParamSuda..VALOR_MONEDA      with(nolock)
			INNER JOIN BacParamSuda..MONEDA with(nolock) ON vmcodigo = mncodmon
	WHERE	vmfecha     = @FECHA    
	AND		vmcodigo    NOT IN(998,997)    
    
	SELECT	vmptacmp
		,	mnrefusd
		,	mncodmon 
		,	vmvalor			= Tipo_Cambio    
	INTO	#VALOR_TC_CONTABLE    
	FROM	BacParamSuda..VALOR_MONEDA_CONTABLE   with (nolock)    
			INNER JOIN BacParamSuda..MONEDA       with (nolock) ON Codigo_Moneda = mncodmon     
			INNER JOIN BacParamSuda..VALOR_MONEDA with (nolock) ON Codigo_Moneda = vmcodigo and Fecha = vmfecha    
	WHERE	Fecha			= @FECHA      
	AND		Codigo_Moneda	NOT IN(998,997)       
    
	CREATE TABLE #TEMPORAL
	(	fecha_contable		DATETIME
	,	status				CHAR(1)
	,	cod_producto		CHAR(4)
	,	T_producto			CHAR(4)
	,	rut					CHAR(9)
	,	dig					CHAR(1)
	,	costo				NUMERIC(1)
	,	n_operacion			CHAR(9)
	,	fecha_inic			CHAR(8)
	,	fecha_vcto			DATETIME
	,	cod_inter_mda		NUMERIC(3)
	,	s_mto_cap_ori		CHAR(1)
	,	mto_cap_origen		FLOAT
	,	s_mto_cap_loc		CHAR(1)
	,	mto_cap_local		FLOAT
	,	s_reaj_mda_loc		CHAR(1)
	,	mto_reaj_loc		FLOAT
	,	s_int_mda_loc		CHAR(1)
	,	mto_int_mda_loc		FLOAT
	,	tasa_f_v			CHAR(1)
	,	spread				FLOAT
	,	valor_en_pesos		FLOAT
	,	nomin_en_pesos		FLOAT
	,	t_cartera			CHAR(10)
	,	mto_op_compra		FLOAT
	,	registros			NUMERIC(5)
	,	indicador			CHAR(1)
	,	colocacion			FLOAT
	,	destino				NUMERIC(5)
	,	TasaInteres			FLOAT
	,	MontoIniBFT			FLOAT
	,	Tipo_Contrato		CHAR(1)
	,	RiesgoPais			CHAR(3)
	)    

	declare @iCount			numeric(9)
		set	@iCount			=	(	SELECT	Reg		= count(1)
									FROM	MFCA with(nolock)
											LEFT JOIN BacParamSuda.dbo.CLIENTE with(nolock) ON clrut = cacodigo AND clcodigo = cacodcli
									WHERE	cafecvcto > @FECHA
								)

	SELECT	Forward.fecha_contable				-->	01
		,	Forward.status
		,	Forward.cod_producto
		,	Forward.T_producto
		,	Forward.rut
		,	Forward.dig
		,	Forward.costo
		,	Forward.n_operacion
		,	Forward.fecha_inic
		,	Forward.fecha_vcto					-->	10
		,	Forward.cod_inter_mda
		,	Forward.s_mto_cap_ori
		,	Forward.mto_cap_origen
		,	Forward.s_mto_cap_loc
		,	Forward.mto_cap_local
		,	Forward.s_reaj_mda_loc
		,	Forward.mto_reaj_loc
		,	Forward.s_int_mda_loc
		,	Forward.mto_int_mda_loc
		,	Forward.tasa_f_v					-->	20
		,	Forward.spread
		,	Forward.valor_en_pesos
		,	Forward.nomin_en_pesos
		,	Forward.t_cartera
		,	Forward.mto_op_compra
		,	Forward.registros
		,	Forward.indicador
		,	Forward.colocacion
		,	Forward.destino
		,	Forward.TasaInteres					-->	30
		,	Forward.MontoIniBFT
		,	Forward.Tipo_Contrato
		,	Forward.RiesgoPais
		,	Registros	= @iCount				-->	34
    FROM	(
			--	INSERT INTO #TEMPORAL
				SELECT	'fecha_contable'   = @fecha
				,		'status'           = 'A'
				,		'cod_producto'     = 'MD01'
				,		'T_producto'       = 'MDIR'
				,		'rut'              = CONVERT(CHAR(9),cacodigo)
				,		'dig'              = ISNULL(cldv,'0')
				,		'costo'            = 0
				,		'n_operacion'      = CONVERT(VARCHAR(9),canumoper)
				,		'fecha_inic'       = CONVERT(CHAR(8),cafecha,112)
				,		'fecha_vcto'       = cafecvcto
				,		'cod_inter_mda'    = cacodmon1
				,		's_mto_cap_ori'    = CASE	WHEN camtomon1 > 0		THEN '+' ELSE '-' END
				,		'mto_cap_origen'   = camtomon1    
				,		's_mto_cap_loc'    = CASE	WHEN camtomon1 > 0		THEN '+' ELSE '-' END    
				,		'mto_cap_local'    = CASE	WHEN cacodmon1 = 999	THEN	camtomon1
													WHEN cacodmon1 = 998	THEN	ROUND(camtomon1 * @vUF_FinMes,0)
													WHEN cacodmon1 = 13		THEN	ROUND(camtomon1 * @vDolar_obsFinMes,0)
													ELSE							ROUND(camtomon1 * (SELECT ISNULL(vmvalor,0) FROM #VALOR_TC_CONTABLE WHERE mncodmon = cacodmon1),0)
												END
				,		's_reaj_mda_loc'	= CASE	WHEN cadiftipcam < 0	THEN '-' ELSE '+' END
				,		'mto_reaj_loc'		= cadiftipcam
				,		's_int_mda_loc'		= SPACE(1)
				,		'mto_int_mda_loc'	= 0
				,		'tasa_f_v'			= 'F'
				,		'spread'			= 0
				,		'valor_en_pesos'	= 0
				,		'nomin_en_pesos'	= 0
				,		't_cartera'			= ISNULL(	(	SELECT	ccn_codigo_nuevo
															FROM	BacParamSuda.dbo.TBL_CODIFICACION_CARTERA_NORMATIVA with(nolock) 
															WHERE	ccn_codigo_cartera	= cacartera_normativa),4
														)
				,		'mto_op_compra'		= CASE	WHEN cadiferen > 0		THEN cadiferen ELSE 0 END
				,		'registros'			= @max
				,		'indicador'			= CASE	WHEN catipmoda = 'C'      THEN 'A'       ELSE 'P' END
				,		'colocacion'		= CASE	WHEN cafecha   = @FECHA   THEN caequmon1 ELSE 0   END
				,		'destino'			= CASE	WHEN cacodigo  = 97029000 THEN 211
													WHEN cacodigo  = 97030000 THEN 212
													ELSE                           221
												END
				,		'TasaInteres'		= 0.0
				,		'MontoIniBFT'		= 0.0
				,		'Tipo_Contrato'		= '4'
				,		'RiesgoPais'		= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( cacodigo, cacodcli, 'BFW' )
				FROM	MFCA with(nolock)
						LEFT JOIN BacParamSuda.dbo.CLIENTE with(nolock) ON clrut = cacodigo AND clcodigo = cacodcli
				WHERE	cafecvcto			> @FECHA
				AND		cacodpos1			<> 10

			/*
				ORDER
				BY		canumoper
			*/

				union all
			    
			--	INSERT INTO #TEMPORAL
				SELECT	'fecha_contable'	= @fecha    
				,		'status'			= 'A'    
				,		'cod_producto'		= 'MD01'    
				,		'T_producto'		= 'MDIR'    
				,		'rut'				= CONVERT(CHAR(9),cacodigo)    
				,		'dig'				= ISNULL(cldv,0)    
				,		'costo'				= 0    
				,		'n_operacion'		= CONVERT(VARCHAR(9),canumoper)    
				,		'fecha_inic'		= CONVERT(CHAR(8),cafecha,112)    
				,		'fecha_vcto'		= cafecvcto    
				,		'cod_inter_mda'		= CASE WHEN cacodmon1  = 13 THEN 13  ELSE 999 END    
				,		's_mto_cap_ori'		= CASE WHEN caequusd1  > 0  THEN '+' ELSE '-' END    
				,		'mto_cap_origen'	= caequusd1    
				,		's_mto_cap_loc'		= CASE WHEN caequusd1  > 0  THEN '+' ELSE '-' END    
				,		'mto_cap_local'		= caequusd1    
				,		's_reaj_mda_loc'	= CASE WHEN cavalordia < 0  THEN '-' ELSE '+' END    
				,		'mto_reaj_loc'		= cavalordia    
				,		's_int_mda_loc'		= SPACE(1)    
				,		'mto_int_mda_loc'	= 0    
				,		'tasa_f_v'			= 'F'    
				,		'spread'			= 0    
				,		'valor_en_pesos'	= 0    
				,		'nomin_en_pesos'	= 0    
				,		't_cartera'			= ISNULL(	(	SELECT	ccn_codigo_nuevo 
															FROM	BacParamSuda.dbo.TBL_CODIFICACION_CARTERA_NORMATIVA with(nolock) 
															WHERE	ccn_codigo_cartera = cacartera_normativa) ,	4
														)
				,		'mto_op_compra'		= CASE	WHEN cadiferen > 0 THEN cadiferen ELSE 0 END
				,		'registros'			= @max
				,		'indicador'			= CASE	WHEN catipoper = 'C' THEN 'P' ELSE 'A' END
				,		'colocacion'		= 0
				,		'destino'			= CASE	WHEN cacodigo  = 97029000 THEN 211
													WHEN cacodigo  = 97030000 THEN 212
													ELSE                           221
												END
				,		'TasaInteres'		= 0.0
				,		'MontoIniBFT'		= caequusd1
				,		'Tipo_Contrato'		= '4'
				,		'RiesgoPais'		= BacParamSuda.dbo.fx_Clasificacion_Riesgo_Pais( cacodigo, cacodcli, 'BFW' )
				FROM    MFCA                            with (nolock)    
						LEFT JOIN BacParamSuda.dbo.CLIENTE with (nolock) ON clrut = cacodigo AND clcodigo = cacodcli    
				WHERE   cafecvcto         > @FECHA
				AND		cacodpos1         = 10

			/*
				ORDER
				BY		canumoper    
			*/
    )	Forward
	ORDER
	BY		Forward.n_operacion

--	SELECT * FROM #TEMPORAL
    
END
GO
