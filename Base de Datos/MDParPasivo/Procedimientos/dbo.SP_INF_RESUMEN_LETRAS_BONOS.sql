USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_RESUMEN_LETRAS_BONOS]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_INF_RESUMEN_LETRAS_BONOS]
					(
						@rut_cliente 	NUMERIC(10)	,
						@codigo_cliente NUMERIC(10)
					)
		
AS
BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	DECLARE @Nombre_Cliente CHAR(70)
	DECLARE @Digito_Verif	CHAR(02)

	SELECT	@Nombre_Cliente = 'TODOS',
		@Digito_Verif	= '-0'

	SELECT	'Serie'		= cpinstser				,
		'Valor Inicial'	= SUM(cpnominal) + SUM(isnull(vinominal,0))  ,
		'Tasa Caratula'	= (CASE WHEN cpseriado = 'S' THEN 
                                       (SELECT setasemi 
                                        FROM SERIE 
                                        WHERE semascara = cpmascara) ELSE
                                        cptircomp END),
		'Vencimiento'	= CONVERT(CHAR(10),cpfecven,103)	,
		'TIR Implicita'	= cptircomp				,
		'Monto'		= SUM(lt.montotransaccion) ,
		'Fecha Emision'	= (CASE WHEN cpseriado ='S' then CONVERT(CHAR(10),cpfecemi,103) 
                                       ELSE CONVERT(CHAR(10),cpfeccomp,103) END)	 	,
		'Fecha Vcto.'	= CONVERT(CHAR(10),cpfecven,103)	,
		'Sistema'       = 'BTR'    				,
		'Rut'		= cprutcli				,
		'Codigo Cliente'= cpcodcli				,
		'Dv'		=  '-' + cldv				,
		'Nombre'	= clnombre				,    
                'Ordenar'       = cpfecven                              ,
                'MATRIZ_RIESGO' = LFRP.Factor_Riesgo  
	INTO #TEMP
	FROM	VIEW_CARTERA_PROPIA,
		CLIENTE,LINEA_TRANSACCION LT,
		LINEA_TRANSACCION_DETALLE LTD,
                VIEW_CARTERA_VENTA_PACTO,
                LINEAS_OPERACION_FRP LFRP
	WHERE	clrut 			= cprutcli
	AND   clcodigo 	  	= cpcodcli
	AND  (cprutcli 		= @rut_cliente OR @rut_cliente = 0)
	AND  (cpcodcli		= @codigo_cliente OR @codigo_cliente = 0)
        AND  LT.codigo_grupo    = LTD.codigo_grupo
        AND  LT.numerooperacion = LTD.numerooperacion
        AND  LT.numerocorrelativo = ltd.numerocorrelativo
        AND  LTD.Tipo_Detalle= 'L'
        AND  LTD.Tipo_Movimiento = 'S'
        AND  LTD.linea_transsaccion = 'LINSIS'
        AND  LT.numerodocumento  = cpnumdocu
        AND  LT.numerocorrelativo = cpcorrela
        AND  cpnumdocu *=vinumdocu 
        AND  cpcorrela *=vicorrela
	AND	LFRP.id_sistema		= lt.id_sistema
	AND	LFRP.Codigo_Grupo	= lt.Codigo_Grupo
	AND	LFRP.NumeroOperacion	= lt.NumeroOperacion
	AND	LFRP.NumeroDocumento	= lt.Numerodocumento 
	AND	LFRP.NumeroCorrelativo	= lt.NumeroCorrelativo

        GROUP BY
        cpinstser,cpmascara,cpseriado,cpfecemi,cpfeccomp,cptircomp,cpfecven,cprutcli,cpcodcli,clnombre,cldv,LFRP.Factor_Riesgo




        INSERT INTO #TEMP
	SELECT	cod_nemo				,
		SUM(cpnominal)				,
		cptasemi,
		CONVERT(CHAR(10),cpfecven,103)	,
		cptircomp				,
		SUM(lt.montotransaccion) ,
		CONVERT(CHAR(10),cpfecemi,103)  ,
		CONVERT(CHAR(10),cpfecven,103)	,
		'INV'    				,
		cprutcli				,
		cpcodcli				,
		'-' + cldv				,
		clnombre				,    
                cpfecven                                ,
                LFRP.Factor_Riesgo
	FROM	VIEW_CARTERA_INVERSION_EXTERIOR,
		CLIENTE,
		LINEA_TRANSACCION LT,
		LINEA_TRANSACCION_DETALLE LTD,
                LINEAS_OPERACION_FRP LFRP
	WHERE	clrut 			= cprutcli
	AND	clcodigo 	  	= cpcodcli
	AND	(cprutcli 		= @rut_cliente OR @rut_cliente = 0)
	AND	(cpcodcli		= @codigo_cliente OR @codigo_cliente = 0)
        AND     LT.codigo_grupo    = LTD.codigo_grupo
        AND     LT.numerooperacion = LTD.numerooperacion
        AND     LT.numerocorrelativo = ltd.numerocorrelativo
        AND     LTD.Tipo_Detalle= 'L'
        AND     LTD.Tipo_Movimiento = 'S'
        AND     LTD.linea_transsaccion = 'LINSIS'
        AND     LT.numerodocumento  = cpnumdocu
        AND     LT.numerocorrelativo = correlativo
	AND	LFRP.id_sistema		= lt.id_sistema
	AND	LFRP.Codigo_Grupo	= lt.Codigo_Grupo
	AND	LFRP.NumeroOperacion	= lt.NumeroOperacion
	AND	LFRP.NumeroDocumento	= lt.Numerodocumento 
	AND	LFRP.NumeroCorrelativo	= lt.NumeroCorrelativo
        GROUP BY
        cod_nemo,cptasemi,cptircomp,cpfecven,cprutcli,cpcodcli,clnombre,cpfecemi,cldv,LFRP.Factor_Riesgo



        INSERT INTO #TEMP
	SELECT	'Serie'		= serie,
		'Valor Inicial'	= nominal,
		'Tasa Caratula'	= 0,
		'Vencimiento'	= CONVERT(CHAR(10),fecha_termino,103)	,
		'TIR Implicita'	= valor_tasa_forward			,
		'Monto'		= lt.montotransaccion	 		,
		'Fecha Emision'	= CONVERT(CHAR(10),fecha_cierre,103) 	,
		'Fecha Vcto.'	= CONVERT(CHAR(10),fecha_termino,103)	,
		'Sistema'       = 'BFW'    				,
		'Rut'		= lt.rut_cliente			,
		'Codigo Cliente'= lt.codigo_cliente			,
		'Dv'		=  '-' + cldv				,
		'Nombre'	= clnombre				,    
                'Ordenar'       = fecha_termino				,
                'MATRIZ_RIESGO' = LFRP.Factor_Riesgo  
	FROM	VIEW_CARTERA_FORWARD_PAPEL,
		CLIENTE,LINEA_TRANSACCION LT,
		LINEA_TRANSACCION_DETALLE LTD,
                LINEAS_OPERACION_FRP LFRP
	WHERE	clrut 			= lt.rut_cliente
	AND	clcodigo 	  	= lt.codigo_cliente
	AND	(lt.rut_cliente 	= @rut_cliente OR @rut_cliente = 0)
	AND	(lt.codigo_cliente	= @codigo_cliente OR @codigo_cliente = 0)
        AND	LT.codigo_grupo    	= LTD.codigo_grupo
        AND	LT.numerooperacion 	= LTD.numerooperacion
        AND	LT.numerocorrelativo 	= ltd.numerocorrelativo
        AND	LTD.Tipo_Detalle	= 'L'
        AND	LTD.Tipo_Movimiento 	= 'S'
        AND	LTD.linea_transsaccion 	= 'LINSIS'
        AND	LT.numerodocumento  	= numero_operacion
        AND	LT.numerooperacion 	= numero_operacion
        AND	LT.numerocorrelativo 	= 1
	AND	LFRP.id_sistema		= lt.id_sistema
	AND	LFRP.Codigo_Grupo	= lt.Codigo_Grupo
	AND	LFRP.NumeroOperacion	= lt.NumeroOperacion
	AND	LFRP.NumeroDocumento	= lt.Numerodocumento 
	AND	LFRP.NumeroCorrelativo	= lt.NumeroCorrelativo



	IF NOT EXISTS(SELECT 1 FROM #TEMP)
	BEGIN

		SELECT	'Serie'		= CONVERT(CHAR(12),' ')	,
			'Valor Inicial'	= 0.0			,
			'Tasa Caratula'	= 0.0			,
			'Vencimiento'	= CONVERT(CHAR(10),' ')	,
			'TIR Implicita'	= 0.0			,
			'Monto'		= 0.0		,
			'Fecha Emision'	= CONVERT(CHAR(10),' ')			,
			'Fecha Vcto.'	= CONVERT(CHAR(10),' ')			,
			'Sistema'       = ' '			,
			'Rut'		= @rut_cliente		,
			'Codigo Cliente'= @codigo_cliente	,
			'Dv'		= @Digito_Verif		,
			'Nombre'	= @Nombre_Cliente	,
			'Ordenar'	= CONVERT(DATETIME,' '),
                        'MATRIZ_RIESGO' = 0.0

	END ELSE BEGIN

		SELECT * FROM #TEMP
                WHERE monto > 0
		ORDER BY  Nombre, Serie, Ordenar

	END

	SET NOCOUNT OFF

END




-- dbo.SP_INF_RESUMEN_LETRAS_BONOS 0,0
--select * from linea_transaccion where id_sistema = 'btr'
--select * from linea_transaccion_detalle where id_sistema = 'btr'
--10362463.0

GO
