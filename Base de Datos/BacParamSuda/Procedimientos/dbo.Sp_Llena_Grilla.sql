USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Llena_Grilla]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Llena_Grilla]
AS

/*LD1-COR-035 -----> CONSULTA LIMITE DE ENDEUDAMIENTO */

BEGIN

	SET NOCOUNT ON
DECLARE	@dFecproc 			DATETIME
		,@dfecsup				DATETIME    
		,@nDO_Obs				NUMERIC	(19,4)
		,@nDO_ObsRC				NUMERIC	(19,4)
		,@nUF_Hoy				NUMERIC	(19,4)
		,@nPFwp_Perd_Dif		NUMERIC	(07,4)
		,@nActivo_Circulante	NUMERIC	(19,2)
		,@nPend_Inst_Finan		NUMERIC	(05,2)
		,@nPmax_End_Inst_Finan	NUMERIC	(05,2)
		,@dfechaAnterior		DATETIME

	SELECT	@nDO_Obs		= 1	,
		@nUF_Hoy		= 0	,
		@nPFwp_Perd_Dif		= 0	,
		@nActivo_Circulante	= 0	,
		@nPend_Inst_Finan	= 0	,
		@nPmax_End_Inst_Finan   = 0
  

	SELECT	@dFecproc		= acfecproc 
			,@dfechaAnterior = acfecante
	FROM VIEW_MDAC (NOLOCK)

	--SE CAMBIA POR DOLAR SUPER EN VEZ DEL OBSERVADO SEGUN BENJAMIN LEVY EL 23/12/2003 CRISTIAN BRAVO
	--SELECT	@nDO_Obs		= ISNULL(vmvalor,0) FROM VALOR_MONEDA WHERE vmcodigo=994 AND vmfecha=@dFecproc
	
	SELECT  @dFecsup		= (@dFecproc - Datepart(dd,@dFecproc)) + 1
	SELECT	@nDO_Obs		= ISNULL(vmvalor,1) FROM VALOR_MONEDA WHERE vmcodigo=14 AND vmfecha=@dFecsup
	SELECT	@nDO_ObsRC		= ISNULL(Tipo_Cambio,0) FROM VALOR_MONEDA_CONTABLE WHERE Codigo_Moneda=994 AND Fecha=@dFecproc
	SELECT	@nUF_Hoy		= ISNULL(vmvalor,0) FROM VALOR_MONEDA WHERE vmcodigo=998 AND vmfecha=@dFecproc

	SELECT	@nPFwp_Perd_Dif		= ROUND(PFwp_Perd_Dif/100,4),
		@nActivo_Circulante		= Activo_Circulante,
		@nPend_Inst_Finan		= Pend_Inst_Finan,
		@nPmax_End_Inst_Finan	= Pmax_End_Inst_Finan
	FROM	ENDEUDAMIENTO (NOLOCK)

	CREATE	TABLE
	#TEMP
		(
		tmp_rut_cliente		NUMERIC	(09,0)	NOT NULL DEFAULT 0	,
		tmp_codigo_cliente	NUMERIC	(09,0)	NOT NULL DEFAULT 0	,
		tmp_nombre_cliente	VARCHAR (70)	NOT NULL DEFAULT ''	,
		tmp_num_oper		NUMERIC	(10,0)	NOT NULL DEFAULT 0	,
		tmp_num_docu		NUMERIC	(10,0)	NOT NULL DEFAULT 0	,
		tmp_correla		    NUMERIC	(10,0)	NOT NULL DEFAULT 0	,
		tmp_captaciones		NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_forward_per		NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_forward_per_dife	NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_Garantias_Otorgadas NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_tipo_cliente	NUMERIC	(5,0)	NOT NULL DEFAULT 0	,
		tmp_sistema		CHAR	(03)	NOT NULL DEFAULT ''
		)

	CREATE	TABLE
	#TEMP2
		(
		tmp_rut_cliente		NUMERIC	(09,0)	NOT NULL DEFAULT 0	,
		tmp_codigo_cliente	NUMERIC	(09,0)	NOT NULL DEFAULT 0	,
		tmp_nombre_cliente	VARCHAR (70)	NOT NULL DEFAULT ''	,
		tmp_num_oper		NUMERIC	(10,0)	NOT NULL DEFAULT 0	,
		tmp_num_docu		NUMERIC	(10,0)	NOT NULL DEFAULT 0	,
		tmp_correla		NUMERIC	(10,0)	NOT NULL DEFAULT 0	,
		tmp_captaciones		NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_forward_per		NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_forward_per_dife	NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_Garantias_Otorgadas NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_tipo_cliente	NUMERIC	(5,0)	NOT NULL DEFAULT 0	,
		tmp_sistema		CHAR	(03)	NOT NULL DEFAULT ''
		)

	CREATE	TABLE
	#TEMP3
		(
		tmp_rut_cliente		NUMERIC	(09,0)	NOT NULL DEFAULT 0	,
		tmp_codigo_cliente	NUMERIC	(09,0)	NOT NULL DEFAULT 0	,
		tmp_nombre_cliente	VARCHAR (70)	NOT NULL DEFAULT ''	,
		tmp_num_oper		NUMERIC	(10,0)	NOT NULL DEFAULT 0	,
		tmp_num_docu		NUMERIC	(10,0)	NOT NULL DEFAULT 0	,
		tmp_correla			NUMERIC	(10,0)	NOT NULL DEFAULT 0	,
		tmp_captaciones		NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_forward_per		NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_forward_per_dife	NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_Garantias_Otorgadas NUMERIC	(19,4)	NOT NULL DEFAULT 0	,
		tmp_tipo_cliente	NUMERIC	(5,0)	NOT NULL DEFAULT 0	,
		tmp_sistema		CHAR	(03)	NOT NULL DEFAULT ''
		)


	-- Captaciones Interbancarios
	INSERT	INTO
	#TEMP
		(
		tmp_rut_cliente		, -- 1
		tmp_codigo_cliente	, -- 2
		tmp_nombre_cliente	, -- 3
		tmp_num_oper		, -- 4
		tmp_num_docu		, -- 5
		tmp_correla			, -- 6
		tmp_captaciones		, -- 7
		tmp_forward_per		, -- 8
		tmp_forward_per_dife	, -- 9
		tmp_Garantias_Otorgadas , -- 10
		tmp_tipo_cliente		, -- 11
		tmp_sistema				  -- 12
		)
	SELECT
		rut_cliente		, -- 1
		codigo_cliente	, -- 2
		clnombre		, -- 3
		cinumdocu		, -- 4
		cinumdocu		, -- 5
		cicorrela		, -- 6
		ISNULL(civalinip,0)	, -- 7
		0				, -- 8
		0				, -- 9
		0				, -- 10
		cltipcli		, -- 11
		'BTR'			  -- 12
	FROM	VIEW_MDCI
			INNER JOIN CLIENTE ON
				clrut		=cirutcli 
				AND clcodigo=cicodcli 
				AND cicodigo=993 --ICAP
				AND cltipcli in(1,2)
			INNER JOIN LIMITE_TOTAL_ENDEUDAMIENTO ON
				rut_cliente			=cirutcli 
				AND codigo_cliente	=cicodcli 						
	WHERE DATEDIFF(DAY,@dFecproc,cifecvenp)<=365
			AND cifecvenp>@dFecproc 
			AND estado=1


	-- Captaciones a Plazo --------------------------------------------
	INSERT	INTO
	#TEMP2
		(
		tmp_rut_cliente		, -- 1
		tmp_codigo_cliente	, -- 2
		tmp_nombre_cliente	, -- 3
		tmp_num_oper		, -- 4
		tmp_num_docu		, -- 5
		tmp_correla		, -- 6
		tmp_captaciones		, -- 7
		tmp_forward_per		, -- 8
		tmp_forward_per_dife	, -- 9
		tmp_Garantias_Otorgadas , -- 10
		tmp_tipo_cliente	, -- 11
		tmp_sistema		  -- 12
		)
	SELECT DISTINCT 
		rut_cliente		, -- 1
		codigo_rut		, -- 2
		clnombre		, -- 3
		numero_operacion, -- 4
		numero_operacion, -- 5
		0				, -- 6
		0				, -- 7
		0				, -- 8
		0				, -- 9
		0				, -- 10
		cltipcli		, -- 11
		'BTR'			  -- 12

	FROM VIEW_GEN_CAPTACION a 
		INNER JOIN CLIENTE c ON 
			c.clrut			=a.rut_cliente 
			AND c.clcodigo	= a.codigo_rut
			AND c.Cltipcli IN(1,2)
	WHERE	DATEDIFF(DAY,@dFecproc,a.fecha_vencimiento) <= 365 
			AND	a.fecha_vencimiento > @dFecproc 
			AND a.tipo_operacion='CAP' 
			AND a.estado <> 'A' 		
/*	FROM	CLIENTE c,
		VIEW_GEN_CAPTACION a
	WHERE	(c.clrut=a.rut_cliente AND c.clcodigo= a.codigo_rut) 
			AND	a.fecha_vencimiento > @dFecproc 
			AND a.tipo_operacion='CAP' 
			AND a.estado <> 'A' 
			AND DATEDIFF(DAY,@dFecproc,a.fecha_vencimiento) <= 365
*/
	UPDATE #TEMP2  SET  tmp_captaciones = ROUND(isnull((SELECT SUM(monto_inicio_pesos) * (Case WHEN min(Moneda) = 13 THEN @nDO_Obs ELSE 1 END) FROM VIEW_GEN_CAPTACION WHERE numero_operacion=tmp_num_oper),0),0)


	INSERT	INTO
	#TEMP
		(
		tmp_rut_cliente		, -- 1
		tmp_codigo_cliente	, -- 2
		tmp_nombre_cliente	, -- 3
		tmp_num_oper		, -- 4
		tmp_num_docu		, -- 5
		tmp_correla			, -- 6
		tmp_captaciones		, -- 7
		tmp_forward_per		, -- 8
		tmp_forward_per_dife	, -- 9
		tmp_Garantias_Otorgadas , -- 10
		tmp_tipo_cliente	, -- 11
		tmp_sistema			  -- 12
		)
	SELECT
		rut_cliente		, -- 1
		codigo_cliente	, -- 2
		clnombre		, -- 3
		tmp_num_oper	, -- 4
		tmp_num_docu	, -- 5
		tmp_correla		, -- 6
		tmp_captaciones	, -- 7
		0				, -- 8
		0				, -- 9
		0				, -- 10
		cltipcli		, -- 11
		'BTR'			  -- 12
	FROM	LIMITE_TOTAL_ENDEUDAMIENTO,
			CLIENTE,
			#TEMP2 A
	WHERE	(rut_cliente=clrut AND codigo_cliente=clcodigo)	AND
		(rut_cliente=A.tmp_rut_cliente AND codigo_cliente=A.tmp_codigo_cliente) 
		 AND estado=1

	-- Fin de Captaciones a Plazo --------------------------------------------


	-- Ventas Con Pactos-------------------------------------------------------
	INSERT	INTO
	#TEMP3		(
		tmp_rut_cliente		, -- 1
		tmp_codigo_cliente	, -- 2
		tmp_nombre_cliente	, -- 3
		tmp_num_oper		, -- 4
		tmp_num_docu		, -- 5
		tmp_correla		, -- 6
		tmp_captaciones		, -- 7
		tmp_forward_per		, -- 8
		tmp_forward_per_dife	, -- 9
		tmp_Garantias_Otorgadas , -- 10
		tmp_tipo_cliente	, -- 11
		tmp_sistema		  -- 12
		)
	SELECT DISTINCT 
		clrut     	, -- 1
		clcodigo	, -- 2
		clnombre	, -- 3
		vinumoper	, -- 4
		vinumoper	, -- 5
		0			, -- 6
		0			, -- 7
		0			, -- 8
		0			, -- 9
		0			, -- 10
		cltipcli	, -- 11
		'BTR'		  -- 12
	FROM BacTraderSuda..MDVI with(nolock)
		INNER JOIN CLIENTE ON
			clrut		=virutcli 
			AND clcodigo=vicodcli 
			AND cltipcli in(1,2)
		INNER JOIN BacParamSuda..LIMITE_TOTAL_ENDEUDAMIENTO ON
			rut_cliente			= virutcli 
			AND codigo_cliente	= vicodcli 
	WHERE	vifecvenp>@dFecproc 
		AND  DATEDIFF(DAY,@dFecproc,vifecvenp) <= 365 		

	
	UPDATE #TEMP3  SET  tmp_captaciones = isnull((SELECT SUM(vivalinip) FROM VIEW_mdvi WHERE vinumoper=tmp_num_oper),0)



	INSERT	INTO
	#TEMP
		(
		tmp_rut_cliente		, -- 1
		tmp_codigo_cliente	, -- 2
		tmp_nombre_cliente	, -- 3
		tmp_num_oper		, -- 4
		tmp_num_docu		, -- 5
		tmp_correla			, -- 6
		tmp_captaciones		, -- 7
		tmp_forward_per		, -- 8
		tmp_forward_per_dife	, -- 9
		tmp_Garantias_Otorgadas , -- 10
		tmp_tipo_cliente	, -- 11
		tmp_sistema			  -- 12
		)
	SELECT
		rut_cliente		, -- 1
		codigo_cliente	, -- 2
		clnombre		, -- 3
		tmp_num_oper	, -- 4
		tmp_num_docu	, -- 5
		tmp_correla		, -- 6
		tmp_captaciones	, -- 7
		0				, -- 8
		0				, -- 9
		0				, -- 10
		cltipcli		, -- 11
		'BTR'			  -- 12
	FROM	LIMITE_TOTAL_ENDEUDAMIENTO, CLIENTE,  #TEMP3 A
	WHERE	(rut_cliente=clrut AND codigo_cliente=clcodigo)	AND
		(rut_cliente=A.tmp_rut_cliente AND codigo_cliente=A.tmp_codigo_cliente) 
		 AND estado=1

	-- Fin de Ventas Con Pacto --------------------------------------------

	-- Seguros de cambio (Forward)-- cartera fin de dia	anterior	(txt - Inico Dia)
	INSERT INTO #TEMP
		(
		tmp_rut_cliente			, -- 1
		tmp_codigo_cliente		, -- 2
		tmp_nombre_cliente		, -- 3
		tmp_num_oper			, -- 4
		tmp_num_docu			, -- 5
		tmp_correla				, -- 6
		tmp_captaciones			, -- 7
		tmp_forward_per			, -- 8
		tmp_forward_per_dife	, -- 9
		tmp_Garantias_Otorgadas , -- 10
		tmp_tipo_cliente		, -- 11
		tmp_sistema			      -- 12
		)
	SELECT
		clrut		, -- 1
		clcodigo 	, -- 2
		clnombre	, -- 3
		[Numero_operación], -- 4
		[Numero_operación], -- 5
		1			, -- 6
		0			, -- 7
--		ROUND(ISNULL(camtomon1,0)*@nDO_Obs,0)	, -- 8
--		ROUND(ISNULL(camtomon1,0)*@nDO_Obs,0)	, -- 9
--+++ SRE.20140313
		ROUND(ISNULL([Monto],0),2)	, -- 8
		0--ROUND(ISNULL([Monto],0),2)	, -- 9
----- SRE.20140313
		,0			, -- 10
		cltipcli	, -- 11
		'BFW'		  -- 12 -------------------------------------------------------------******
		FROM mfca_Findur with(nolock)
			INNER JOIN CLIENTE ON
				clrut=[Rut_Contraparte] 
				AND clcodigo=[Codigo_cliente] 
				AND cltipcli in(1,2)
		WHERE	fecha_proceso = @dfechaAnterior
			AND Fecha_vencimiento > @dFecproc 
			AND DATEDIFF(DAY,[Fecha_proceso] ,[Fecha_vencimiento])<=365 
			AND [Tipo_negocio] IN (1,3)
			AND [MTM_proyectado] < 0
 
 
 
	-- Seguros de  Inflacion (Forward) Cartera OnLine (Servicio)
	INSERT INTO #TEMP
		(
		tmp_rut_cliente		, -- 1
		tmp_codigo_cliente	, -- 2
		tmp_nombre_cliente	, -- 3
		tmp_num_oper		, -- 4
		tmp_num_docu		, -- 5
		tmp_correla			, -- 6
		tmp_captaciones		, -- 7
		tmp_forward_per		, -- 8
		tmp_forward_per_dife, -- 9
		tmp_Garantias_Otorgadas 	, -- 10
		tmp_tipo_cliente	, -- 11
		tmp_sistema			  -- 12
		)
	SELECT
		clrut		, -- 1
		clcodigo 	, -- 2
		clnombre	, -- 3
		ope.[Numero_operación]	, -- 4
		ope.[Numero_operación]	, -- 5
		1			, -- 6
		0			, -- 7
		0--ROUND(ISNULL([Monto_afecto],0),2)	, -- 8
		,ROUND(ISNULL([Monto],0),2)	, -- 9
		0			, -- 10
		cltipcli	, -- 11
		'BFW'		  -- 12 ----------------------------------------------*********
	FROM	LIMITE_TOTAL_ENDEUDAMIENTO a with(nolock)
			INNER JOIN CLIENTE b with(nolock) ON
				rut_cliente = clrut
				AND codigo_cliente = clcodigo
				AND cltipcli IN (1,2)
			LEFT JOIN mfca_findur ope with(nolock) ON
				ope.Rut_contraparte = rut_cliente				
				AND ope.Codigo_cliente = a.Codigo_cliente
	WHERE ope.Fecha_proceso	= @dFecproc
		AND ope.Fecha_vencimiento > @dFecproc 
		AND ope.[Tipo_negocio] IN(1,3)  
		AND DATEDIFF(DAY,@dFecproc,ope.Fecha_vencimiento)<=365
		--AND ope.Estado = 'I'
		
	
	UPDATE	#TEMP

	SET	tmp_Garantias_Otorgadas = tmp_Garantias_Otorgadas + ISNULL((SELECT SUM(ValorPresente) FROM  BacTraderSuda..View_Garantias WHERE NumeroOperacionInstrumento=NumeroOperacionInstrumento ),0) + ISNULL((SELECT SUM(vivalinip) FROM VIEW_MDVI WHERE tmp_num_oper=vinumoper),0)


	INSERT	INTO
	#TEMP
		(
		tmp_rut_cliente			, -- 1
		tmp_codigo_cliente		, -- 2
		tmp_nombre_cliente		, -- 3
		tmp_num_oper			, -- 4
		tmp_num_docu			, -- 5
		tmp_correla			, -- 6
		tmp_captaciones			, -- 7
		tmp_forward_per			, -- 8
		tmp_forward_per_dife		, -- 9
		tmp_Garantias_Otorgadas 	, -- 10
		tmp_tipo_cliente	
		)
	SELECT
		clrut				, -- 1
		clcodigo 			, -- 2
		clnombre			, -- 3
		0				, -- 4
		0				, -- 5
		1				, -- 6
		0				, -- 7
		0				, -- 8
		0				, -- 9
		0				, -- 10
		cltipcli		 
	FROM	LIMITE_TOTAL_ENDEUDAMIENTO with(nolock), CLIENTE with(nolock)
	WHERE	(rut_cliente=clrut AND codigo_cliente=clcodigo) AND
		estado=1

	SELECT	'rut_cliente'			= tmp_rut_cliente		,
		'codigo_cliente'		= tmp_codigo_cliente		,
		'nombre_cliente'		= tmp_nombre_cliente		,
		'captaciones_inter'		= SUM(tmp_captaciones)	 + ROUND((ISNULL((SELECT CAPTACIONES_DOLARES FROM LIMITE_TOTAL_ENDEUDAMIENTO WHERE rut_cliente=tmp_rut_cliente AND codigo_cliente= tmp_codigo_cliente),0)* @nDO_Obs ),0),
		'forward_per'			= ROUND(SUM(tmp_forward_per),0) / ISNULL(@nDO_Obs, 1),
		'tmp_porcen_forward_per'	=ROUND(SUM(tmp_forward_per)  * @nPFwp_Perd_Dif,0) + SUM(tmp_forward_per_dife),
		'Obligaciones'			= ROUND(SUM(tmp_forward_per) * @nPFwp_Perd_Dif,0) + SUM(tmp_forward_per_dife) + SUM(tmp_captaciones)+ROUND((ISNULL((SELECT CAPTACIONES_DOLARES FROM LIMITE_TOTAL_ENDEUDAMIENTO WHERE rut_cliente=tmp_rut_cliente AND codigo_cliente= tmp_codigo_cliente),0)* @nDO_Obs ),0),		
		--'tmp_porcen_forward_per'	= ROUND(SUM(tmp_forward_per) * @nPFwp_Perd_Dif * @nDO_Obs,0)			,
		--'Obligaciones'			= ROUND(SUM(tmp_forward_per) * @nPFwp_Perd_Dif * @nDO_Obs,0) + SUM(tmp_captaciones)+ROUND((ISNULL((SELECT CAPTACIONES_DOLARES FROM LIMITE_TOTAL_ENDEUDAMIENTO WHERE rut_cliente=tmp_rut_cliente AND codigo_cliente= tmp_codigo_cliente),0)* @nDO_Obs ),0),
		'Garantias'			= SUM(tmp_Garantias_Otorgadas)							,
----------------------------
		'Afecto'			= ((ROUND(SUM(tmp_forward_per)  * @nPFwp_Perd_Dif,0) + SUM(tmp_forward_per_dife) + SUM(tmp_captaciones)+ ROUND((ISNULL((SELECT CAPTACIONES_DOLARES FROM LIMITE_TOTAL_ENDEUDAMIENTO WHERE rut_cliente=tmp_rut_cliente AND codigo_cliente= tmp_codigo_cliente),0)* @nDO_Obs ),0) ) - SUM(tmp_Garantias_Otorgadas)),
		
      	--'Afecto'			= ((ROUND(SUM(tmp_forward_per) * @nPFwp_Perd_Dif * @nDO_Obs,0) + SUM(tmp_captaciones)+ ROUND((ISNULL((SELECT CAPTACIONES_DOLARES FROM LIMITE_TOTAL_ENDEUDAMIENTO WHERE rut_cliente=tmp_rut_cliente AND codigo_cliente= tmp_codigo_cliente),0)* @nDO_Obs ),0) ) - SUM(tmp_Garantias_Otorgadas)),

----------------------------
		'tipo_cliente'			= tmp_tipo_cliente								,
		'total_garantias'		= ISNULL((SELECT SUM(divptirc) FROM VIEW_MDDI WHERE (dinominal - 0)>0 AND
											      digenemi='BCCH' AND ditipoper='CP' AND ditipcart='2' ),0)		,
		'Dolar_Observado'		= @nDO_Obs	   								,
		'UF_Hoy'			= @nUF_Hoy									,
		'Fecha_proceso'			= CONVERT(CHAR(10),@dFecproc,103)						,
		'Activo_Circulante'		= @nActivo_Circulante								,
		'tres_por_Activo'		= (@nActivo_Circulante*@nPend_Inst_Finan)/100,
		'@nPFwp_Perd_Dif'               = @nPFwp_Perd_Dif ,
		'Activo_Circ_Contraparte'	=(Select ((activo_circulante*@nPend_Inst_Finan)/100) from limite_total_endeudamiento where rut_cliente=tmp_rut_cliente and codigo_cliente=tmp_codigo_cliente), -- 3 %
		'Afecto_Positivo        '  = (case when ((ROUND(SUM(tmp_forward_per)  * @nPFwp_Perd_Dif,0) + SUM(tmp_forward_per_dife) + SUM(tmp_captaciones)+ ROUND((ISNULL((SELECT CAPTACIONES_DOLARES FROM LIMITE_TOTAL_ENDEUDAMIENTO WHERE rut_cliente=tmp_rut_cliente AND codigo_cliente= tmp_codigo_cliente),0)* @nDO_Obs ),0) ) - SUM(tmp_Garantias_Otorgadas)) > 0 then
							((ROUND(SUM(tmp_forward_per)  * @nPFwp_Perd_Dif,0) + SUM(tmp_forward_per_dife) + SUM(tmp_captaciones)+ ROUND((ISNULL((SELECT CAPTACIONES_DOLARES FROM LIMITE_TOTAL_ENDEUDAMIENTO WHERE rut_cliente=tmp_rut_cliente AND codigo_cliente= tmp_codigo_cliente),0)* @nDO_Obs ),0) ) - SUM(tmp_Garantias_Otorgadas))
						  else
							0
						  end),		
		--'Afecto_Positivo        '       = (case when ((ROUND(SUM(tmp_forward_per) * @nPFwp_Perd_Dif * @nDO_Obs,0) + SUM(tmp_captaciones)+ ROUND((ISNULL((SELECT CAPTACIONES_DOLARES FROM LIMITE_TOTAL_ENDEUDAMIENTO WHERE rut_cliente=tmp_rut_cliente AND codigo_cliente= tmp_codigo_cliente),0)* @nDO_Obs ),0) ) - SUM(tmp_Garantias_Otorgadas)) > 0 then
		--					((ROUND(SUM(tmp_forward_per) * @nPFwp_Perd_Dif * @nDO_Obs,0) + SUM(tmp_captaciones)+ ROUND((ISNULL((SELECT CAPTACIONES_DOLARES FROM LIMITE_TOTAL_ENDEUDAMIENTO WHERE rut_cliente=tmp_rut_cliente AND codigo_cliente= tmp_codigo_cliente),0)* @nDO_Obs ),0) ) - SUM(tmp_Garantias_Otorgadas))
		--				  else
		--					0
		--				  end),
		'Total_Circ_Contraparte'	=(Select activo_circulante from limite_total_endeudamiento where rut_cliente=tmp_rut_cliente and codigo_cliente=tmp_codigo_cliente), -- Total %
		'Pmax_End_Inst_Finan'		= round(@nPmax_End_Inst_Finan,2),
		'Pend_Inst_Finan'		= round(@nPend_Inst_Finan,2), 
		'Afecto_RC'			= ISNULL(((ROUND((((SUM(tmp_forward_per) / ISNULL(@nDO_Obs, 1)) * @nDO_ObsRC) * @nPFwp_Perd_Dif),0) + SUM(tmp_captaciones) + ROUND((ISNULL((SELECT CAPTACIONES_DOLARES FROM LIMITE_TOTAL_ENDEUDAMIENTO WHERE rut_cliente=tmp_rut_cliente AND codigo_cliente= tmp_codigo_cliente),0)* @nDO_ObsRC ),0) )- SUM(tmp_Garantias_Otorgadas)), 0)
        --'Afecto_RC'			= ((ROUND(SUM(tmp_forward_per) * @nPFwp_Perd_Dif * @nDO_ObsRC,0) + SUM(tmp_captaciones)+ ROUND((ISNULL((SELECT CAPTACIONES_DOLARES FROM LIMITE_TOTAL_ENDEUDAMIENTO WHERE rut_cliente=tmp_rut_cliente AND codigo_cliente= tmp_codigo_cliente),0)* @nDO_ObsRC ),0) ) - SUM(tmp_Garantias_Otorgadas))

	FROM	#Temp
	GROUP BY tmp_rut_cliente, tmp_codigo_cliente, tmp_tipo_cliente, tmp_nombre_cliente
	ORDER BY tmp_rut_cliente


	SET NOCOUNT OFF
END

GO
