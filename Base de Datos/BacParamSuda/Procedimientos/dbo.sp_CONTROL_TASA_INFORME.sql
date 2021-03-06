USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[sp_CONTROL_TASA_INFORME]    Script Date: 13-05-2022 10:53:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[sp_CONTROL_TASA_INFORME]
AS BEGIN
SET NOCOUNT ON

	DECLARE @ACFECPROC		CHAR(10)
	,		@ACFECPROX		CHAR(10)
	,		@UF_HOY			FLOAT   
	,		@UF_MAN			FLOAT   
	,		@IVP_HOY		FLOAT
	,		@IVP_MAN		FLOAT   
	,		@DO_HOY			FLOAT   
	,		@DO_MAN			FLOAT   
	,		@DA_HOY			FLOAT   
	,		@DA_MAN			FLOAT
	,		@ACNOMPROP		CHAR(40)
	,		@RUT_EMPRESA	CHAR(12)
	,		@HORA			CHAR(08)
	,		@FECHA_HOY		CHAR(10)
	,       @NomProp		CHAR(50)
	,		@RutProp		CHAR(12)

	EXECUTE dbo.sp_Base_Del_Informe 
		@acfecproc		OUTPUT
	,	@acfecprox		OUTPUT
	,	@uf_hoy			OUTPUT
	,	@uf_man			OUTPUT
	,	@ivp_hoy		OUTPUT 
	,	@ivp_man		OUTPUT
	,	@do_hoy			OUTPUT
	,	@do_man			OUTPUT
	,	@da_hoy			OUTPUT
	,	@da_man			OUTPUT 
	,   @acnomprop		OUTPUT
	,	@rut_empresa	OUTPUT
	,	@hora			OUTPUT

	SELECT  
		'Codigo_Tipo_Limite'	= Codigo_Tipo_Limite	,
		'Codigo_Limite'		= Codigo_Limite			,
		'Descripcion_Limite'	= 'CONTROL DE TASAS Y PRECIOS'	, --Descripcion_Limite		,
		'Numero_operacion'	= Numero_operacion		,
		'Tipo_Operacion'	= Tipo_Operacion		,
		'Serie'			= Serie				,
		'Monto_Operacion'	= Monto_Operacion		,
		'Tasa_Limite'		= Monto_Linea			,
		'Tasa_Operacion'	= Exceso			,
		'Exceso'		= ROUND(Exceso - Monto_Linea, 4),
		'Fecha_Exceso'		= Fecha_Exceso			,
		'Plazo'			= Plazo				,
		'Trader'		= Trader			,
		'Trader_Autorizador'	= Trader_Autorizador		,
		'Rut_Cliente'		= Rut_Cliente			,
		'Codigo_Cliente'	= Codigo_Cliente		,
		'cliente'		= ISNULL(CLNOMBRE,' ')		,
		'hora'			= CONVERT(CHAR(10), GETDATE(),108),
		'fe_pro'		= acfecproc			,
		'acnomprop'		= acnomprop			,
                'rut_empresa'		= REPLACE(SUBSTRING(CONVERT(CHAR(13), CONVERT(MONEY, acrutprop), 1), 1, 10), ',', '.')+ '-'+ acdigprop,
		'uf_hoy'		= @uf_hoy			,
          	'ivp_hoy'		= @ivp_hoy			,
                'do_hoy'		= @do_hoy			,
                'da_hoy'		= @da_hoy			,
		'hora_operacion'	= CONVERT(CHAR(10), ' ')	,
		'UM_operacion'		= CONVERT(CHAR(03), '0')	,
		'sistema'		= CONVERT(CHAR(30), id_sistema),
		'Detalle_Descripcion_Limite' = Descripcion_Limite		--jcamposd 20121217 se suma dato.
	INTO #Temporal
	FROM	CONTROL_LIMITES_GENERALES	,
		view_mdac			,
		CLIENTE
	WHERE	--Codigo_Limite		in(1,2)		AND	(VGS) 26/02/2008 PACTOS EN USD
		Codigo_Tipo_Limite	= 4					--> CODIGO LIMITES CONTROL DE TASA
	AND	Fecha_Exceso		= acfecproc			-->
	AND	clrut				= rut_cliente	
	AND	Codigo_Cliente		= clcodigo      
	AND	Trader_Autorizador  <> ' '

	ORDER BY id_sistema


	/****************************************************************/
	/****************************************************************/

	/****************************************************************/
	/********* Renta fija *******************************************/
	/****************************************************************/
		UPDATE #Temporal SET
			hora_operacion	= CONVERT(CHAR(08), mohora),
			UM_operacion	= CASE WHEN motipoper IN ('VP', 'CP') THEN  momonemi
					       ELSE momonpact
					  END
		FROM #Temporal
		INNER JOIN VIEW_MDMO	ON
			monumoper	= Numero_operacion AND
			sistema		= 'BTR'

	/****************************************************************/
	/****************************************************************/

	/****************************************************************/
	/********* Forward **********************************************/
	/****************************************************************/
		UPDATE #Temporal SET
			hora_operacion	= mohora,
			UM_operacion	= mocodmon1
		FROM #Temporal
		INNER JOIN VIEW_MFMO	ON
			monumoper	= Numero_operacion AND
			sistema		= 'BFW'
	/****************************************************************/
	/****************************************************************/
	/****************************************************************/
	/********* Cambio  **********************************************/
	/****************************************************************/
		UPDATE #Temporal SET
			hora_operacion	= mohora,
			UM_operacion	= mocodmon
		FROM #Temporal
		INNER JOIN VIEW_MEMO	ON
			monumope	= Numero_operacion AND
			sistema		= 'BCC'

		UPDATE #Temporal SET
			UM_operacion	= mnnemo
		FROM #Temporal
		INNER JOIN MONEDA	ON
			UM_operacion	= mncodmon	AND
			sistema		<> 'BCC'

	/****************************************************************/
	/****************************************************************/
		UPDATE #Temporal SET
			sistema	= nombre_sistema
		FROM #Temporal
		INNER JOIN SISTEMA_CNT	ON
			sistema		= id_sistema
	/****************************************************************/
	/****************************************************************/
	SELECT * FROM #Temporal ORDER BY sistema	,
					 hora_operacion
SET NOCOUNT OFF
END



/*
select * from delete CONTROL_LIMITES_GENERALES where Fecha_Exceso = '20080225' and Codigo_Limite in(1,2) and Codigo_Tipo_Limite = 4
and Numero_operacion in(76537,76538,76539)
*/

GO
