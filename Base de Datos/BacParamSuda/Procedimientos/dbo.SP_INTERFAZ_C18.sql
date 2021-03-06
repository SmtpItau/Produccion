USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_C18]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_C18]	(	@FechaInter	DATETIME
				)
AS
BEGIN
	DECLARE @FechaBusqueda	DATETIME
	DECLARE @RutBCCH NUMERIC(8)

	SET @RutBCCH = 97029000

	SET NOCOUNT ON 

	CREATE TABLE #INTERFAZ_C18
	(	c18_CAMPO_01	CHAR(122)	--01 DIA				( CODIGO DE LA IF )		-- PRIMER REGISTRO
	,	c18_CAMPO_02	CHAR(122)	--02 ACTIVO CIRCULANTE			( IDENTIFICACION DEL ARCHIVO )	-- PRIMER REGISTRO
	,	c18_CAMPO_03	CHAR(122)	--03 CODIGO DEL BANCO ACREEDOR		( PERIODO AAAAMM )		-- PRIMER REGISTRO
	,	c18_CAMPO_04	CHAR(122)	--04 PLAZO RESIDUAL DE VENCIMIENTO	( FILLER)			-- PRIMER REGISTRO
	,	c18_CAMPO_05	CHAR(122)	--05 MONEDA DE PAGO
	,	c18_CAMPO_06	CHAR(122)	--06 CUENTAS CORRIENTES
	,	c18_CAMPO_07	CHAR(122)	--07 OTRAS OBLIGACIONES A LA VISTA
	,	c18_CAMPO_08	NUMERIC(14,0)	--08 OPERACIONES CON LIQUIDACION EN CURSO
	,	c18_CAMPO_09	CHAR(122)	--09 CONTRATOS DE RETROCOMPRA Y PRESTAMOS DE VALORES
	,	c18_CAMPO_10	CHAR(122)	--10 DEPOSITOS Y OTRAS CAPTACIONES A PLAZO
	,	c18_CAMPO_11	CHAR(122)	--11 CONTRATOS DE DERIVADOS FINANCIEROS
	,	c18_CAMPO_12	CHAR(122)	--12 OBLIGACIONES CON BANCOS
	,	c18_CAMPO_13	CHAR(122)	--13 MONTO CUBIERTO CON GARANTIAS VALIDAS PARA LIMITES
	,	c18_CAMPO_14	CHAR(122)	--14 FILLER
	,	c18_Sistema	CHAR(003)	-- SISTEMA... NO SE RETORNA SOLO DATO DE CONTROL
	)

	DECLARE	@cDiasFeriados	VARCHAR(255)
	,	@cCaracter      CHAR(2)
	,	@HABIL		CHAR(2)
	
	SELECT	@FechaBusqueda	= @FechaInter
	,	@HABIL		= 'NO'

	WHILE @HABIL = 'NO' BEGIN
		
		SELECT @HABIL = 'SI'
	
		SELECT @cDiasFeriados = CASE	WHEN DATEPART(MONTH,@FechaBusqueda) = 1  THEN feene
						WHEN DATEPART(MONTH,@FechaBusqueda) = 2  THEN fefeb
						WHEN DATEPART(MONTH,@FechaBusqueda) = 3  THEN femar
						WHEN DATEPART(MONTH,@FechaBusqueda) = 4  THEN feabr
						WHEN DATEPART(MONTH,@FechaBusqueda) = 5  THEN femay
						WHEN DATEPART(MONTH,@FechaBusqueda) = 6  THEN fejun
						WHEN DATEPART(MONTH,@FechaBusqueda) = 7  THEN fejul
						WHEN DATEPART(MONTH,@FechaBusqueda) = 8  THEN feago
						WHEN DATEPART(MONTH,@FechaBusqueda) = 9  THEN fesep
						WHEN DATEPART(MONTH,@FechaBusqueda) = 10 THEN feoct
						WHEN DATEPART(MONTH,@FechaBusqueda) = 11 THEN fenov
						WHEN DATEPART(MONTH,@FechaBusqueda) = 12 THEN fedic
					END
		FROM	BACPARAMSUDA..FERIADO
		WHERE	feano	= DATEPART(YEAR,@FechaBusqueda)
		AND	feplaza	= 6

		SELECT @cCaracter = CASE	WHEN DATEPART(DAY,@FechaBusqueda) <= 9 THEN '0' + CONVERT(CHAR(1),DATEPART(DAY,@FechaBusqueda))
						ELSE CONVERT(CHAR(2),DATEPART(DAY,@FechaBusqueda))
				    END
		
		IF CHARINDEX(RTRIM(CONVERT(CHAR(02),@cCaracter)),@cDiasFeriados) > 0
			 OR (DATEPART(WEEKDAY,@FechaBusqueda) = 7 OR DATEPART(WEEKDAY,@FechaBusqueda) = 1)  BEGIN
			
		        SELECT	@FechaBusqueda	= DATEADD(DAY,-1,@FechaBusqueda)
			,	@HABIL		= 'NO'		
		END
	END

	IF (SELECT acfecproc FROM BACTRADERSUDA..MDAC) = CONVERT(CHAR(8),@FechaInter,112) BEGIN

		/*********************************** BACTRADER **************************************/

		--	LETRAS DE PROPIA EMISION
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,cpfecven) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,cpfecven) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,cpfecven) >= 364			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE inmonemi	WHEN 999	THEN 1
								WHEN 998	THEN 2
								WHEN 994	THEN 2
										ELSE 3
						 END)))

		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(cpvptirc)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BTR'
		FROM	BACPARAMSUDA..SERIE
		,	BACTRADERSUDA..MDCP		
		,	BACPARAMSUDA..CLIENTE
		,	BACPARAMSUDA..INSTRUMENTO
		WHERE	cpmascara	= semascara
		AND	serutemi	= '97023000'
		AND	incodigo	= cpcodigo
		AND	cpfecven	> @FechaBusqueda
		AND	cpnominal	> 0
		AND	cprutcli	<> @RutBCCH
		AND	cprutcli	= Clrut
		AND	Clpais		= 6
		AND	Cltipcli	= 1
		AND	cpcodcli	= Clcodigo

		--	COMPRAS PROPIAS PM
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) >= 364			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE moneda_emision	WHEN 999	THEN 1
									WHEN 998	THEN 2
									WHEN 994	THEN 2
											ELSE 3
						 END)))

		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(diferencia_mercado)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BTR'
		FROM	BACTRADERSUDA..VALORIZACION_MERCADO	INNER JOIN	BACTRADERSUDA..MDMO
							ON	mofecpro		= fecha_valorizacion
							AND	monumdocu		= rmnumdocu
							AND	monumoper		= rmnumoper
							AND	mocorrela		= rmcorrela
							AND	motipoper		= tipo_operacion
							AND	Fecha_PagoMañana	> mofecpro
		,	BACPARAMSUDA..CLIENTE
		WHERE	fecha_valorizacion	= @FechaBusqueda
		AND	tipo_operacion		= 'CP'
		AND	diferencia_mercado	< 0
		AND	morutcli		<> @RutBCCH
		AND	morutcli		= Clrut
		AND	Clcodigo		= mocodcli
		AND	Clpais			= 6
		AND	Cltipcli		= 1


		--	VENTAS CON PACTOS 
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) >= 364			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE moneda_emision 	WHEN 999	THEN 1
									WHEN 998	THEN 2
									WHEN 994	THEN 2
											ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(diferencia_mercado)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BTR'
		FROM	BACTRADERSUDA..VALORIZACION_MERCADO	INNER JOIN	BACTRADERSUDA..MDMO
							ON	mofecpro		= fecha_valorizacion
							AND	monumdocu		= rmnumdocu
							AND	monumoper		= rmnumoper
							AND	mocorrela		= rmcorrela
							AND	motipoper		= tipo_operacion
		,	BACPARAMSUDA..CLIENTE
		WHERE	fecha_valorizacion	= @FechaBusqueda
		AND	tipo_operacion		= 'VI'
		AND	fecha_valorizacion	< tmfecven
		AND	diferencia_mercado	< 0
		AND	morutcli		<> @RutBCCH
		AND	morutcli		= Clrut
		AND	Clcodigo		= mocodcli
		AND	Clpais			= 6
		AND	Cltipcli		= 1

		--	INTERBANCARIO DE CAPTACIONES
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,cifecven) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,cifecven) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,cifecven) >= 364			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE cimonemi 	WHEN 999	THEN 1
									WHEN 998	THEN 2
									WHEN 994	THEN 2
											ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(civptirci)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BTR'
		FROM	BACTRADERSUDA..MDCI	
		,	BACPARAMSUDA..CLIENTE
		WHERE	ciinstser	= 'ICAP'
		AND	cifecven	> @FechaBusqueda
		AND	cirutcli	<> @RutBCCH
		AND	cirutcli	= Clrut
		AND	cicodcli	= Clcodigo
		AND	Clpais		= 6
		AND	Cltipcli	= 1

		/*********************************** BACCAMBIO **************************************/
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,MOVALUTA2) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,MOVALUTA2) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,MOVALUTA2)	>= 364			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE (	CASE	WHEN MOTIPOPE = 'C' THEN MOCODCNV
								WHEN MOTIPOPE = 'V' THEN MOCODMON
							END)
								WHEN 'CLP'	THEN 1
										ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(CASE	WHEN MOTIPOPE = 'C' AND MOCODCNV = 'CLP'	THEN MOMONPE
					WHEN MOTIPOPE = 'C' AND MOCODCNV <> 'CLP'	THEN MOUSSME
											ELSE MOMONMO
			    END)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BCC'
		FROM 	BACCAMSUDA..MEMO
		,	BACPARAMSUDA..CLIENTE
		WHERE	DATEDIFF(DD,@FechaBusqueda,MOVALUTA2)	> 0
		AND	MORUTCLI				<> @RutBCCH
		AND	MORUTCLI				= Clrut
		AND	Clpais					= 6
		AND	Cltipcli				= 1
		AND	MOCODCLI				= Clcodigo

		/*********************************** BACSWAP **************************************/
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,fecha_termino) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,fecha_termino) >= 364		THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE (	CASE	WHEN tipo_operacion = 'C' THEN compra_moneda
								WHEN tipo_operacion = 'V' THEN venta_moneda
							END)
								WHEN 999	THEN 1
								WHEN 998	THEN 2
								WHEN 994	THEN 2
										ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(Valor_RazonableCLP)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'PCS'
		FROM 	BACSWAPSUDA..CARTERA	A
		,	BACPARAMSUDA..CLIENTE
		WHERE	Valor_RazonableCLP			< 0
		AND	DATEDIFF(DD,@FechaBusqueda,fecha_termino)	> 0
		AND	tipo_flujo				= (SELECT MIN(tipo_flujo) FROM BACSWAPSUDA..CARTERA B 
									WHERE	B.numero_operacion	= A.numero_operacion 
									AND	B.numero_flujo		= A.numero_flujo)
		AND	rut_cliente				<> @RutBCCH
		AND	rut_cliente				= Clrut
		AND	estado_flujo				= 1
		AND	Clpais					= 6
		AND	Cltipcli				= 1
		AND	Clcodigo				= codigo_cliente

		/*********************************** BACFORWARD **************************************/
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,cafecvcto) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,cafecvcto) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,cafecvcto) > 365			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE cacodmon1	WHEN 999	THEN 1
								WHEN 998	THEN 2
								WHEN 994	THEN 2
										ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(fRes_Obtenido)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BFW'
		FROM 	BACFWDSUDA..MFCA
		,	BACPARAMSUDA..CLIENTE
		WHERE	fRes_Obtenido				< 0
		AND	DATEDIFF(DD,@FechaBusqueda,cafecvcto)	> 0
		AND     cacodigo             			<> @RutBCCH
		AND	cacodigo				= Clrut
		AND	Clpais					= 6
		AND	Cltipcli				= 1
		AND	Clcodigo				= cacodcli

/*		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	'1'
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE cacodmon1	WHEN 999	THEN 1
								WHEN 998	THEN 2
								WHEN 994	THEN 2
										ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE(' ', 14 - LEN(LTRIM(RTRIM(CONVERT(CHAR,CONVERT(NUMERIC(14,0),ABS(camtocomp))))))) + LTRIM(RTRIM(CONVERT(CHAR,CONVERT(NUMERIC(14,0),ABS(camtocomp)))))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		FROM 	BACFWDSUDA..MFCA
		,	BACPARAMSUDA..CLIENTE
		WHERE	camtocomp				< 0
		AND	DATEDIFF(DD,@FechaInter,cafecvcto)	= 0
		AND	catipmoda				= 'C'
		AND	cacodigo				= Clrut
		AND	Clpais					= 6
		AND	Cltipcli				= 1
*/



	END
	ELSE BEGIN -- CONSULTA HISTORIA

		/*********************************** BACTRADER **************************************/

		--	LETRAS DE PROPIA EMISION
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,rsfecvcto) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,rsfecvcto) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,rsfecvcto) >= 364			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE rsmonemi 	WHEN 999	THEN 1
								WHEN 998	THEN 2
								WHEN 994	THEN 2
										ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(rsvppresen)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BTR'
		FROM	BACTRADERSUDA..MDRS
		,	BACPARAMSUDA..SERIE
		,	BACPARAMSUDA..CLIENTE
		WHERE	rsfecha		= @FechaBusqueda
		AND	rsrutemis	= '97023000'
		AND	rsmascara	= semascara
		AND	rstipoper	= 'DEV'
		AND	rsfecvcto	> rsfecha
		AND	rsnominal	> 0
		AND	rsrutcli	= Clrut
		AND	Clpais		= 6
		AND	Cltipcli	= 1
		AND	Clcodigo	= rscodcli

	
		--	COMPRAS PROPIAS PM
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) >= 364			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE moneda_emision 	WHEN 999	THEN 1
									WHEN 998	THEN 2
									WHEN 994	THEN 2
											ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(diferencia_mercado)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BTR'
		FROM	BACTRADERSUDA..VALORIZACION_MERCADO	INNER JOIN	BACTRADERSUDA..MDMH
							ON	monumdocu		= rmnumdocu
							AND	monumoper		= rmnumoper
							AND	mocorrela		= rmcorrela
							AND	motipoper		= tipo_operacion
							AND	Fecha_PagoMañana	> mofecpro
		,	BACPARAMSUDA..CLIENTE
		WHERE	fecha_valorizacion	= @FechaBusqueda
		AND	tipo_operacion		= 'CP'
		AND	diferencia_mercado	< 0
		AND	morutcli		<> @RutBCCH
		AND	morutcli		= Clrut
		AND	Clpais			= 6
		AND	Cltipcli		= 1
		AND	Clcodigo		= mocodcli

		--	VENTAS CON PACTOS 
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,tmfecven) >= 364			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE moneda_emision 	WHEN 999	THEN 1
									WHEN 998	THEN 2
									WHEN 994	THEN 2
											ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(diferencia_mercado)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BTR'
		FROM	BACTRADERSUDA..VALORIZACION_MERCADO	INNER JOIN	BACTRADERSUDA..MDMH
							ON	monumdocu		= rmnumdocu
							AND	monumoper		= rmnumoper
							AND	mocorrela		= rmcorrela
							AND	motipoper		= tipo_operacion
		,	BACPARAMSUDA..CLIENTE
		WHERE	fecha_valorizacion	= @FechaBusqueda
		AND	tipo_operacion		= 'VI'
		AND	fecha_valorizacion	< tmfecven
		AND	diferencia_mercado	< 0
		AND	morutcli				= Clrut
		AND	Clpais					= 6
		AND	Cltipcli				= 1
		AND	Clcodigo		= mocodcli

		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,rsfecvcto) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,rsfecvcto) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,rsfecvcto) >= 364			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE rsmonemi 	WHEN 999	THEN 1
									WHEN 998	THEN 2
									WHEN 994	THEN 2
											ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(rsvppresen)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BTR'
 		FROM	BACTRADERSUDA..MDRS	
		,	BACPARAMSUDA..CLIENTE
		WHERE	rsfecha		= @FechaBusqueda
		AND	rstipoper	= 'DEV'
		AND	rsinstser	= 'ICAP'
		AND	rsfecvcto	> rsfecha
		AND	rsrutcli	<> @RutBCCH 
		AND	rsrutcli	= Clrut
		AND	Clpais		= 6
		AND	Cltipcli	= 1
		AND	Clcodigo	= rscodcli
			
		/*********************************** BACCAMBIO **************************************/
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,MOVALUTA2) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,MOVALUTA2) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,MOVALUTA2)	>= 364			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE (	CASE	WHEN MOTIPOPE = 'C' THEN MOCODCNV
								WHEN MOTIPOPE = 'V' THEN MOCODMON
							END)
								WHEN 'CLP'	THEN 1
										ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(CASE	WHEN MOTIPOPE = 'C' AND MOCODCNV = 'CLP'	THEN MOMONPE
					WHEN MOTIPOPE = 'C' AND MOCODCNV <> 'CLP'	THEN MOUSSME
											ELSE MOMONMO
			    END)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BCC'
 		FROM 	BACCAMSUDA..MEMOH
		,	BACPARAMSUDA..CLIENTE
		WHERE	MOFECH					= @FechaBusqueda 
		AND	DATEDIFF(DD,@FechaBusqueda,MOVALUTA2)	> 0
		AND	MORUTCLI				<> @RutBCCH 
		AND	MORUTCLI				= Clrut
		AND	Clpais					= 6
		AND	Cltipcli				= 1
		AND 	Clcodigo				= MOCODCLI
			
		/*********************************** BACSWAP **************************************/
		INSERT	#INTERFAZ_C18
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,fecha_termino) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,fecha_termino) >= 364		THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE (	CASE	WHEN tipo_operacion = 'C' THEN compra_moneda
								WHEN tipo_operacion = 'V' THEN venta_moneda
							END)
								WHEN 999	THEN 1
								WHEN 998	THEN 2
								WHEN 994	THEN 2
										ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(Valor_RazonableCLP)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'PCS'
 		FROM 	BACSWAPSUDA..CARTERARES	A
		,	BACPARAMSUDA..CLIENTE
		WHERE	Fecha_Proceso				= @FechaBusqueda
		AND	Valor_RazonableCLP			< 0
		AND	DATEDIFF(DD,@FechaBusqueda,fecha_termino)	> 0
		AND	tipo_flujo				= (SELECT MIN(tipo_flujo) FROM BACSWAPSUDA..CARTERARES B 
									WHERE	B.Fecha_Proceso		= A.Fecha_Proceso
									AND	B.numero_operacion	= A.numero_operacion 
									AND	B.numero_flujo		= A.numero_flujo)
		AND	rut_cliente				<> @RutBCCH 
		AND	rut_cliente				= Clrut
		AND	estado_flujo				= 1
		AND	Clpais					= 6
		AND	Cltipcli				= 1
		AND	Clcodigo				= codigo_cliente
						
		/*********************************** BACFORWARD **************************************/
		INSERT	#INTERFAZ_C18			
		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,cafecvcto) = 1			THEN 1
							WHEN DATEDIFF(DD,@FechaBusqueda,cafecvcto) BETWEEN 2 AND 365	THEN 2
							WHEN DATEDIFF(DD,@FechaBusqueda,cafecvcto) > 365			THEN 3
						 END)))
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE cacodmon1	WHEN 999	THEN 1
								WHEN 998	THEN 2
								WHEN 994	THEN 2
										ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	ABS(fRes_Obtenido)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		,	'BFW'
		FROM 	BACFWDSUDA..MFCARES
		,	BACPARAMSUDA..CLIENTE
		WHERE	CaFechaProceso				= @FechaBusqueda
		AND	fRes_Obtenido				< 0
		AND	DATEDIFF(DD,@FechaBusqueda,cafecvcto)	> 0
		AND	cacodigo				= Clrut
		AND     cacodigo             			<> @RutBCCH
		AND	Clpais					= 6
		AND	Cltipcli				= 1
		AND	Clcodigo				= cacodcli

/*		SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
		,	REPLICATE('0',14)
		,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
		,	'1'
		,	LTRIM(RTRIM(CONVERT(CHAR,CASE cacodmon1	WHEN 999	THEN 1
								WHEN 998	THEN 2
								WHEN 994	THEN 2
										ELSE 3
						 END)))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE(' ', 14 - LEN(LTRIM(RTRIM(CONVERT(CHAR,CONVERT(NUMERIC(14,0),ABS(camtocomp))))))) + LTRIM(RTRIM(CONVERT(CHAR,CONVERT(NUMERIC(14,0),ABS(camtocomp)))))
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	REPLICATE('0',14)
		,	'0'
		FROM 	BACFWDSUDA..MFCARES
		,	BACPARAMSUDA..CLIENTE
		WHERE	CaFechaProceso				= @FechaBusqueda
		AND	camtocomp				< 0
		AND	DATEDIFF(DD,@FechaInter,cafecvcto)	= 0
		AND	catipmoda				= 'C'
		AND	cacodigo				= Clrut
		AND	Clpais					= 6
		AND	Cltipcli				= 1						
*/
	END
	
	/*********************************** BONOS EN EL EXTERIOR **************************************/
	INSERT	#INTERFAZ_C18
	SELECT	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),7,2)
	,	REPLICATE('0',14)
	,	REPLICATE('0',(3 - LEN(LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))))) +  LTRIM(RTRIM(CONVERT(CHAR,Cod_Inst)))
	,	LTRIM(RTRIM(CONVERT(CHAR,CASE	WHEN DATEDIFF(DD,@FechaBusqueda,mofecven) BETWEEN 2 AND 365	THEN 2
						WHEN DATEDIFF(DD,@FechaBusqueda,mofecven)	>= 364			THEN 3
					 END)))
	,	LTRIM(RTRIM(CONVERT(CHAR,CASE	momonpag	WHEN 999	THEN 1
								WHEN 998	THEN 2
								WHEN 994	THEN 2
										ELSE 3
					 END)))
	,	REPLICATE('0',14)
	,	REPLICATE('0',14)
	,	ABS( movpresen)
	,	REPLICATE('0',14)
	,	REPLICATE('0',14)
	,	REPLICATE('0',14)
	,	REPLICATE('0',14)
	,	REPLICATE('0',14)
	,	'0'
	,	'BEX'
	FROM 	BACBONOSEXTSUDA..text_mvt_dri 	
	,	BACPARAMSUDA..CLIENTE
	WHERE	mofecpro	=  @FechaBusqueda
	AND	motipoper	=  'CP'
	AND 	mofecpro	<> mofecven
	AND	MORUTCLI	= Clrut
	AND	Clpais		= 6
	AND	Cltipcli	= 1
	AND	Clcodigo	= mocodcli

	SELECT	'027'						AS c18_CAMPO_01	-- ( CODIGO DE LA IF )
	,	'C18'						AS c18_CAMPO_02	-- ( IDENTIFICACION DEL ARCHIVO )	
	,	SUBSTRING(CONVERT(CHAR(8),@FechaInter,112),1,6)	AS c18_CAMPO_03	-- ( PERIODO AAAAMM )
	,	SPACE(122)					AS c18_CAMPO_04	-- ( FILLER )
	,	''						AS c18_CAMPO_05
	,	''						AS c18_CAMPO_06
	,	''						AS c18_CAMPO_07
	,	''						AS c18_CAMPO_08 
	,	''						AS c18_CAMPO_09   
	,	''						AS c18_CAMPO_10
	,	''						AS c18_CAMPO_11
	,	''						AS c18_CAMPO_12
	,	''						AS c18_CAMPO_13
	,	''						AS c18_CAMPO_14

	UNION ALL


	SELECT	c18_CAMPO_01					--01 DIA				( CODIGO DE LA IF )		-- PRIMER REGISTRO
	,	c18_CAMPO_02					--02 ACTIVO CIRCULANTE			( IDENTIFICACION DEL ARCHIVO )	-- PRIMER REGISTRO
	,	c18_CAMPO_03					--03 CODIGO DEL BANCO ACREEDOR		( PERIODO AAAAMM )		-- PRIMER REGISTRO
	,	c18_CAMPO_04					--04 PLAZO RESIDUAL DE VENCIMIENTO	( FILLER)			-- PRIMER REGISTRO 
	,	c18_CAMPO_05					--05 MONEDA DE PAGO
	,	c18_CAMPO_06					--06 CUENTAS CORRIENTES
	,	c18_CAMPO_07					--07 OTRAS OBLIGACIONES A LA VISTA
--	,	LTRIM(RTRIM(CONVERT(CHAR,c18_CAMPO_08)))	--08 OPERACIONES CON LIQUIDACION EN CURSO	-- ESTE ES EL UNICO CAMPO QUE SE FORMATEA POR VISUAL BASIC 
	,	LTRIM(RTRIM(CONVERT(CHAR,SUM(c18_CAMPO_08))))	--08 OPERACIONES CON LIQUIDACION EN CURSO	-- ESTE ES EL UNICO CAMPO QUE SE FORMATEA POR VISUAL BASIC 
														-- DEBIDO A  QUE LA FUNCION QUE RETORNA LOS DATOS A LOS TIPO 
														-- CHAR LES HACE UN TRIM Y ELIMINA EL FORMATO QUE SE ENVIO 
														-- DE SQL
	,	c18_CAMPO_09					--09 CONTRATOS DE RETROCOMPRA Y PRESTAMOS DE VALORES
	,	c18_CAMPO_10					--10 DEPOSITOS Y OTRAS CAPTACIONES A PLAZO
	,	c18_CAMPO_11					--11 CONTRATOS DE DERIVADOS FINANCIEROS
	,	c18_CAMPO_12					--12 OBLIGACIONES CON BANCOS
	,	c18_CAMPO_13					--13 MONTO CUBIERTO CON GARANTIAS VALIDAS PARA LIMITES
	,	c18_CAMPO_14					--14 FILLER
	FROM	#INTERFAZ_C18
	GROUP
	BY	c18_CAMPO_03	-- CODIGO BANCO ACREEDOR
	,	c18_CAMPO_04	-- PLAZO RESIDUAL DE VENCIMIENTO
	,	c18_CAMPO_05	-- MONEDA DE PAGO
	,	c18_CAMPO_01
	,	c18_CAMPO_02
	,	c18_CAMPO_06
	,	c18_CAMPO_07
	,	c18_CAMPO_09
	,	c18_CAMPO_10
	,	c18_CAMPO_11
	,	c18_CAMPO_12
	,	c18_CAMPO_13
	,	c18_CAMPO_14
/*
	SELECT	c18_SISTEMA
	,	c18_CAMPO_01					--01 DIA				( CODIGO DE LA IF )		-- PRIMER REGISTRO
	,	c18_CAMPO_02					--02 ACTIVO CIRCULANTE			( IDENTIFICACION DEL ARCHIVO )	-- PRIMER REGISTRO
	,	c18_CAMPO_03					--03 CODIGO DEL BANCO ACREEDOR		( PERIODO AAAAMM )		-- PRIMER REGISTRO
	,	c18_CAMPO_04					--04 PLAZO RESIDUAL DE VENCIMIENTO	( FILLER)			-- PRIMER REGISTRO 
	,	c18_CAMPO_05					--05 MONEDA DE PAGO
	,	c18_CAMPO_06					--06 CUENTAS CORRIENTES
	,	c18_CAMPO_07					--07 OTRAS OBLIGACIONES A LA VISTA
	,	LTRIM(RTRIM(CONVERT(CHAR,c18_CAMPO_08)))	--08 OPERACIONES CON LIQUIDACION EN CURSO	-- ESTE ES EL UNICO CAMPO QUE SE FORMATEA POR VISUAL BASIC 
	,	c18_CAMPO_09					--09 CONTRATOS DE RETROCOMPRA Y PRESTAMOS DE VALORES
	,	c18_CAMPO_10					--10 DEPOSITOS Y OTRAS CAPTACIONES A PLAZO
	,	c18_CAMPO_11					--11 CONTRATOS DE DERIVADOS FINANCIEROS
	,	c18_CAMPO_12					--12 OBLIGACIONES CON BANCOS
	,	c18_CAMPO_13					--13 MONTO CUBIERTO CON GARANTIAS VALIDAS PARA LIMITES
	,	c18_CAMPO_14					--14 FILLER
	FROM	#INTERFAZ_C18
*/

	SET NOCOUNT OFF
END
GO
