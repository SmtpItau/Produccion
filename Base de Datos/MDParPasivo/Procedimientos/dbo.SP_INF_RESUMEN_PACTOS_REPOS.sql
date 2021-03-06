USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_INF_RESUMEN_PACTOS_REPOS]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_INF_RESUMEN_PACTOS_REPOS]
						(
							@rut_cliente	NUMERIC(10)	,
							@codigo_cliente NUMERIC(10)
						)
AS
BEGIN
	SET NOCOUNT ON
        SET DATEFORMAT dmy

	DECLARE @Nombre_Cliente CHAR(70)
	DECLARE @Digito_Verif	CHAR(02)

	SELECT	@Nombre_Cliente = 'TODOS',
		@Digito_Verif	= '-'

	SELECT
		'Serie'		= ciinstser				,
		'Emisor'	= emrut,
		'Emisor_Nombre'	= emgeneric 				,
		'Fecha Emision'	= (CASE WHEN ciseriado = 'S' THEN 
                                       (SELECT convert(char(10),sefecemi,103)
                                        FROM SERIE 
                                        WHERE semascara = cimascara) ELSE
                                        CONVERT(CHAR(10),cifeccomp,103) END),
		'Monto'		= cinominal        			,
		'Tasa Caratula'	= (CASE WHEN ciseriado = 'S' THEN 
                                       (SELECT setasemi
                                        FROM SERIE 
                                        WHERE semascara = cimascara) ELSE
                                        citircomp END),
		'Vencimiento'	= CONVERT(CHAR(10),cifecven,103)	,
		'TIR Implicita'	= citircomp				,
		'Consumo'	= lt.montotransaccion			,
		'Fecha Inicio'	= CONVERT(CHAR(10),cifeccomp,103)	,
		'Fecha Vcto.'	= CONVERT(CHAR(10),cifecven,103)	,
		'Tipo Operacion'= descripcion				,
		'Rut'		= cirutcli				,
		'Codigo Cliente'= cicodcli				,
		'Dv'		= '-' + cldv				,
		'Nombre'	= clnombre				,
		'Tipo'		= 'PACTO'				,
		'Divisa'	= LTRIM(RTRIM((SELECT mnnemo FROM MONEDA WHERE cimonpact = mncodmon)))	,
		'Fecha'		= CONVERT(CHAR(10),cifecinip,101)	,
		'Plazo'		= ABS(DATEDIFF(DAY,cifecvenp,cifecinip)),
		'Nocional'	= lt.montooriginal			,
		'Operacion'	= cinumdocu				,
		'Correlativo'	= cicorrela,
                'factor'        = lt.matrizriesgo
	INTO #TEMP
	FROM	VIEW_CARTERA_COMPRA_PACTO	,
		CLIENTE			, 
		PRODUCTO		c	,
		DATOS_GENERALES			,
		EMISOR                          ,
                LINEA_TRANSACCION    LT,
                LINEA_TRANSACCION_DETALLE    LTD,
                VIEW_CARTERA_DISPONIBLE
	WHERE	emgeneric=digenemi
        AND     dinumdocu = cinumdocu
        AND     dicorrela = cicorrela
	AND	clrut = cirutcli
	AND	clcodigo = cicodcli
	AND	(cirutcli = @rut_cliente OR @rut_cliente = 0)
	AND	(cicodcli = @codigo_cliente OR @codigo_cliente = 0)
	AND	c.codigo_producto = 'CI'
        AND     lt.numerooperacion     = cinumdocu
        AND     LT.codigo_grupo    = LTD.codigo_grupo
        AND     LT.numerooperacion = LTD.numerooperacion
        AND     LT.numerocorrelativo = ltd.numerocorrelativo
        AND     LTD.Tipo_Detalle= 'L'
        AND     LTD.Tipo_Movimiento = 'S'
        AND     LTD.linea_transsaccion = 'LINSIS'
        AND     LT.numerooperacion  = cinumdocu



	IF NOT EXISTS(SELECT 1 FROM #TEMP)
	BEGIN

		SELECT
			'Serie'		= CONVERT(CHAR(12),' ')	,
			'Emisor'	= 0			,
			'Emisor_Nombre'	= CONVERT(CHAR(10),' ')	,
			'Fecha Emision'	= CONVERT(CHAR(10),' ')	,
			'Monto'		= 0.0			,
			'Tasa Caratula'	= 0.0			,
			'Vencimiento'	= CONVERT(CHAR(10),' ')	,
			'TIR Implicita'	= 0.0			,
			'Consumo'	= 0.0			,
			'Fecha Inicio'	= CONVERT(CHAR(10),' ')	,
			'Fecha Vcto.'	= CONVERT(CHAR(10),' ')	,
			'Tipo Operacion'= CONVERT(CHAR(10),' ')	,
			'Rut'		= @rut_cliente		,
			'Codigo Cliente'= @codigo_cliente	,
			'Dv'		= @Digito_Verif		,
			'Nombre'	= @Nombre_Cliente	,
			'Tipo'		= ' '			,
			'Divisa'	= CONVERT(CHAR(8),'')  ,
			'Fecha'		= CONVERT(CHAR(10),' ')	,
			'PLazo'		= 0			,
			'Nocional'	= 0.0			,
			'Operacion'	= 0.0			,
			'Correlativo'	= 0.0                   ,
                        'factor'        = 0.0

	END ELSE BEGIN

		SELECT * FROM #TEMP ORDER BY Nombre, [Tipo Operacion], Operacion, Correlativo	

	END

	SET NOCOUNT OFF


END


--SP_INF_RESUMEN_PACTOS_REPOS 0,0
--select * from view_noserie where nsnumdocu = 51146
--select * from linea_transaccion
--select * from VIEW_CARTERA_DISPONIBLE
--select * from  view_cartera_compra_pacto order by cinumdocu desc


GO
