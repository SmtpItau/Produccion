USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_OPERACIONES_PSV]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_DETALLE_OPERACIONES_PSV
CREATE PROCEDURE [dbo].[SP_DETALLE_OPERACIONES_PSV]
(
		@FECHA		 DATE = NULL	
)
AS  
BEGIN   
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ DETALLE OPERACIONES
--MODIFICACION	: 26-09-2018	cuentas faltantes

	SET NOCOUNT ON  

	DECLARE @FECHA_PROC_FILTRO	DATE
	DECLARE @FECHA_INI_FILTRO	DATE
	DECLARE @ENTIDAD			VARCHAR(30)

	declare @fecpro				DATETIME
	declare @cliente			NUMERIC(9)
	declare @acfecprox			DATETIME

	SELECT  @fecpro				= Fecha_Proceso
	,		@cliente			= Rut_Entidad
	,		@acfecprox			= Fecha_Proxima
	FROM	MDParPasivo..DATOS_GENERALES with(nolock)

	IF @FECHA IS NULL 
		BEGIN
			SET @FECHA_PROC_FILTRO = (select top 1 Fecha_Proceso from MDParPasivo..DATOS_GENERALES WITH(NOLOCK)) 
		END 
	ELSE
		BEGIN
			SET @FECHA_PROC_FILTRO = @FECHA
		END

	SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')


	CREATE TABLE #TMP_DETALLE_PSV
	(
/*01*/	 NRO_DOCUMENTO			NUMERIC(20)
/*02*/	,NRO_OPERACION			NUMERIC(20)
/*03*/	,NRO_CORRELATIVO		NUMERIC(20)
/*04*/	,FEC_DATA				DATE
/*05*/	,COD_ENTIDAD			VARCHAR(4)
/*06*/	,COD_PRODUCTO			VARCHAR(4) DEFAULT('PSV')
/*07*/	,COD_SUBPRODU			VARCHAR(4)
/*08*/	,NUM_CUENTA				VARCHAR(12)
/*09*/	,NUM_SECUENCIA_CTO		NUMERIC(4)
/*10*/	,COD_DIVISA				VARCHAR(4)
/*11*/	,COD_REAJUSTE			VARCHAR(3)
/*12*/	,IDF_PERS_ODS			VARCHAR(25)
/*13*/	,COD_CENTRO_CONT		VARCHAR(4)
/*14*/	,COD_OFI_COMERCIAL		VARCHAR(5)
/*15*/	,COD_GESTOR_PROD		VARCHAR(15)
/*16*/	,COD_BASE_TAS_INT		VARCHAR(3)
/*17*/	,COD_BCA_INT			VARCHAR(3)
/*18*/	,COD_COMPOS_INT			CHAR(1)
/*19*/	,COD_MOD_PAGO			CHAR(1)
/*20*/	,COD_MET_AMRT			VARCHAR(4)
/*21*/	,COD_CUR_REF			VARCHAR(5)
/*22*/	,COD_TIP_TAS			VARCHAR(2)
/*23*/	,TAS_INT				NUMERIC(8,5)
/*24*/	,TAS_DIF_INC_REF		NUMERIC(8,5)
/*25*/	,FEC_ALTA_CTO			DATE 
/*26*/	,FEC_INI_GEST			DATE 
/*27*/	,FEC_CAN_ANT			DATE 
/*28*/	,FEC_ULT_LIQ			DATE 
/*29*/	,FEC_PRX_LIQ			DATE 
/*30*/	,FEC_ULT_REV			DATE 
/*31*/	,FEC_PRX_REV			DATE 
/*32*/	,FEC_VEN				DATE 
/*33*/	,FRE_PAGO_INT			NUMERIC(5)
/*34*/	,COD_UNI_FRE_PAGO_INT	CHAR(1)
/*35*/	,FRE_REV_INT			NUMERIC(5)
/*36*/	,COD_UNI_FRE_REV_INT	CHAR(1)
/*37*/	,PLZ_CONTRACTUAL		NUMERIC(5)
/*38*/	,PLZ_AMRT				NUMERIC(5)
/*39*/	,COD_UNI_PLZ_AMRT		CHAR(1)
/*40*/	,IMP_INI_MO				NUMERIC(20,4)
/*41*/	,IMP_CUO_MO				NUMERIC(20,2)
/*42*/	,IMP_CUO_INI_MO			NUMERIC(20,2)
/*43*/	,NUM_CUO_PAC			NUMERIC(5)
/*44*/	,NUM_CUO_PEND			NUMERIC(5)
/*45*/	,IMP_PAGO_ML			NUMERIC(20,4)
/*46*/	,IMP_PAGO_MO			NUMERIC(20,4)
/*47*/	,IND_CAN_ANT			CHAR(1)
/*48*/	,IND_TAS_PREDEF			CHAR(1)
/*49*/	,TAS_PREDEF				NUMERIC(8,5)
/*50*/	,IMP_INI_ML				NUMERIC(20,4)
/*51*/	,TAS_INT_ORIGEN			NUMERIC(8,5)
/*52*/	,COD_PORTAFOLIO			VARCHAR(10)
/*53*/	,DES_PORTAFOLIO			VARCHAR(20)
/*54*/	,COD_NEMOTECNICO		VARCHAR(20)
/*55*/	,COD_CARTERA_FINANCI	CHAR(8)
/*56*/	,COD_TIP_LIBRO			VARCHAR(1)
/*57*/	,NUM_DOC				VARCHAR(12)
/*58*/	,NUM_OPE_ANT			VARCHAR(12)
/*59*/	,T_FLUJO				INT DEFAULT 0
	)

	INSERT INTO #TMP_DETALLE_PSV
	select	0					as NRO_DOCUMENTO
	,		numero_operacion	as NRO_OPERACION
	,		numero_correlativo	as NRO_CORRELATIVO
	,		@FECHA				as FEC_DATA
	,		entidad_cartera		as COD_ENTIDAD
	,		'PSV'				as COD_PRODUCTO
	,		codigo_instrumento	as COD_SUBPRODU
	,		numero_operacion	as NUM_CUENTA
	,		numero_correlativo	as NUM_SECUENCIA_CTO
	,		case ltrim(rtrim(mnnemo)) 
										when 'UF' then 'CLP'
										when 'DO' then 'USD'
										else substring(mnnemo,1,4)
										end
			as moneda1
	,		case when moneda_emision in (998,997) then 'UF' else null end		as moneda2
	,		rtrim(ltrim(CONVERT(varchar,rut_cliente))) + '-' + ISNULL(cldv,'0')	as rutcli
	,		'2230'																as COD_CENTRO_CONT
	,		''																	as COD_OFI_COMERCIAL
	,		case when operador='' then 'ADMINISTRA' else operador end			as COD_GESTOR_PROD
	,		case	when datediff(day,fecha_movimiento,fecha_vencimiento)<=90 then 'M'
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=91 and datediff(day,fecha_movimiento,fecha_vencimiento)<=179 then 'M' 					
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=180 and datediff(day,fecha_movimiento,fecha_vencimiento)<=364 then 'S' 					
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=365 then 'A' end as COD_BASE_TAS_INT
	,		'1'		as COD_BCA_INT
	,		'C'		as COD_COMPOS_INT
	,		'V'		as COD_MOD_PAGO
	,		'1'		as COD_MET_AMRT
	,		0		as COD_CUR_REF
	,		'F'		as COD_TIP_TAS
	,		0		as TAS_INT
	,		0		as TAS_DIF_INC_REF
	,		fecha_movimiento	as FEC_ALTA_CTO
	,		fecha_movimiento	as FEC_INI_GEST
	,		'1900-01-01'		as FEC_CAN_ANT
	,		fecha_movimiento	as FEC_ULT_LIQ
	,		fecha_movimiento	as FEC_PRX_LIQ
	,		fecha_movimiento	as FEC_ULT_REV
	,		fecha_movimiento	as FEC_PRX_REV
	,		fecha_vencimiento	as FEC_VEN
	,		case	when datediff(day,fecha_movimiento,fecha_vencimiento)<31 then 1
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=31 and datediff(day,fecha_movimiento,fecha_vencimiento)<365 then
							case when ROUND(datediff(day,fecha_movimiento,fecha_vencimiento)/30,0,0)>=12 then 3 else 2 end 
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=365 then 3 end as FRE_PAGO_INT

	,		case	when datediff(day,fecha_movimiento,fecha_vencimiento)<31 then 'D'
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=31 and datediff(day,fecha_movimiento,fecha_vencimiento)<365 then
							case when ROUND(datediff(day,fecha_movimiento,fecha_vencimiento)/30,0,0)>=12 then 'A' else 'M' end 
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=365 then 'A' end as COD_UNI_FRE_PAGO_INT

	,		case	when datediff(day,fecha_movimiento,fecha_vencimiento)<31 then 1
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=31 and datediff(day,fecha_movimiento,fecha_vencimiento)<365 then
							case when ROUND(datediff(day,fecha_movimiento,fecha_vencimiento)/30,0,0)>=12 then 3 else 2 end 
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=365 then 3 end as FRE_REV_INT

	,		case	when datediff(day,fecha_movimiento,fecha_vencimiento)<31 then 'D'
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=31 and datediff(day,fecha_movimiento,fecha_vencimiento)<365 then
							case when ROUND(datediff(day,fecha_movimiento,fecha_vencimiento)/30,0,0)>=12 then 'A' else 'M' end 
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=365 then 'A' end as COD_UNI_FRE_REV_INT

	,		datediff(day,fecha_movimiento,fecha_vencimiento) as PLZ_CONTRACTUAL		

	,		case	when datediff(day,fecha_movimiento,fecha_vencimiento)<31 then datediff(day,fecha_movimiento,fecha_vencimiento)
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=31 and datediff(day,fecha_movimiento,fecha_vencimiento)<365 then
							case when ROUND(datediff(day,fecha_movimiento,fecha_vencimiento)/30,0,0)>=12 then 1 else round(datediff(day,fecha_movimiento,fecha_vencimiento)/30,0,0) end 
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=365 then round(datediff(day,fecha_movimiento,fecha_vencimiento)/365,0,0) end as PLZ_AMRT

	,		case	when datediff(day,fecha_movimiento,fecha_vencimiento)<31 then 'D'
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=31 and datediff(day,fecha_movimiento,fecha_vencimiento)<365 then
							case when ROUND(datediff(day,fecha_movimiento,fecha_vencimiento)/30,0,0)>=12 then 'A' else 'M' end 
					when datediff(day,fecha_movimiento,fecha_vencimiento)>=365 then 'A' end as COD_UNI_PLZ_AMRT

	,		valor_emision_um	as IMP_INI_MO
	,		0					as IMP_CUO_MO
	,		valor_emision_um	as IMP_CUO_INI_MO
	,		1					as NUM_CUO_PAC
	,		1					as NUM_CUO_PEND
	,		valor_colocacion_um	as IMP_PAGO_ML
	,		valor_emision_um    as IMP_PAGO_MO
	,		5					as IND_CAN_ANT
	,		'N'					AS IND_TAS_PREDEF
	,		0					as TAS_PREDEF
	,		valor_colocacion_um	as IMP_INI_ML
	,		0					as TAS_INT_ORIGEN
	,		0					as COD_PORTAFOLIO
	,		''					as DES_PORTAFOLIO
	,		null				as COD_NEMOTECNICO
	,CASE entidad_cartera	WHEN 1 THEN  'TR'	-- Trading
							WHEN 2 THEN  'PLP'	-- Portfolio LP
							WHEN 3 THEN  'ET'	-- Estructuración
							WHEN 4 THEN  'BL'	-- BALANCE
							WHEN 9 THEN  'PR'	-- PROPIETARIO
							WHEN 10 THEN 'PLO'	-- PORTFOLIO LO 180
							WHEN 13 THEN 'MT'	-- MM TASA   -- REVISAR
							WHEN 14 THEN 'MF'	-- MM FX -- REVISAR
							WHEN 16 THEN 'BGF'	-- Balance Gestion Financiera -- REVISAR
							ELSE		 'BGL'	-- Balance Gestion Liquidez -- REVISAR
							END as COD_CARTERA_FINANCI
	,case when libro_deskmanager = 1 then 'N' else 'B' end as COD_TIP_LIBRO

	,		null				as NUM_DOC
	,		null				as NUM_OPE_ANT
	,		0					as T_FLUJO
	from MDPasivo..MOVIMIENTO_PASIVO
	INNER JOIN BacParamSuda..CLIENTE ON Clrut=rut_cliente AND Clcodigo=codigo_cliente
	INNER JOIN BacParamSuda.dbo.moneda ON mncodmon = moneda_emision
	where  fecha_vencimiento  between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO

	INSERT INTO #TMP_DETALLE_PSV
	select	0						as NRO_DOCUMENTO
	,		c.numero_operacion		as NRO_OPERACION
	,		c.numero_correlativo	as NRO_CORRELATIVO
	,		@FECHA_PROC_FILTRO		as FEC_DATA
	,		c.entidad_cartera		as COD_ENTIDAD
	,		'PSV'					as COD_PRODUCTO
	,		c.codigo_instrumento	as COD_SUBPRODU
	,		c.numero_operacion		as NUM_CUENTA
	,		c.numero_correlativo	as NUM_SECUENCIA_CTO
	,		case ltrim(rtrim(mnnemo)) 
										when 'UF' then 'CLP'
										when 'DO' then 'USD'
										else substring(mnnemo,1,4)
										end
			as moneda1
	,		case when c.moneda_emision in (998,997) then 'UF' else null end		as moneda2
	,		rtrim(ltrim(CONVERT(varchar,c.rut_cliente))) + '-' + ISNULL(cldv,'0')	as rutcli
	,		'2230'																as COD_CENTRO_CONT
	,		''																	as COD_OFI_COMERCIAL
	,		case when operador='' then 'ADMINISTRA' else operador end			as COD_GESTOR_PROD
	,		case	when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<=90 then 'M'
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=91 and datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<=179 then 'M' 					
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=180 and datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<=364 then 'S' 					
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=365 then 'A' end as COD_BASE_TAS_INT
	,		'1'		as COD_BCA_INT
	,		'C'		as COD_COMPOS_INT
	,		'V'		as COD_MOD_PAGO
	,		'1'		as COD_MET_AMRT
	,		0		as COD_CUR_REF
	,		'F'		as COD_TIP_TAS
	,		0		as TAS_INT
	,		0		as TAS_DIF_INC_REF
	,		c.fecha_colocacion	as FEC_ALTA_CTO
	,		c.fecha_colocacion	as FEC_INI_GEST
	,		'1900-01-01'		as FEC_CAN_ANT
	,		c.fecha_colocacion	as FEC_ULT_LIQ
	,		c.fecha_colocacion	as FEC_PRX_LIQ
	,		c.fecha_colocacion	as FEC_ULT_REV
	,		c.fecha_colocacion	as FEC_PRX_REV
	,		c.fecha_vencimiento	as FEC_VEN
	,		case	when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<31 then 1
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=31 and datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<365 then
							case when ROUND(datediff(day,c.fecha_colocacion,c.fecha_vencimiento)/30,0,0)>=12 then 3 else 2 end 
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=365 then 3 end as FRE_PAGO_INT

	,		case	when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<31 then 'D'
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=31 and datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<365 then
							case when ROUND(datediff(day,c.fecha_colocacion,c.fecha_vencimiento)/30,0,0)>=12 then 'A' else 'M' end 
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=365 then 'A' end as COD_UNI_FRE_PAGO_INT

	,		case	when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<31 then 1
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=31 and datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<365 then
							case when ROUND(datediff(day,c.fecha_colocacion,c.fecha_vencimiento)/30,0,0)>=12 then 3 else 2 end 
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=365 then 3 end as FRE_REV_INT

	,		case	when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<31 then 'D'
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=31 and datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<365 then
							case when ROUND(datediff(day,c.fecha_colocacion,c.fecha_vencimiento)/30,0,0)>=12 then 'A' else 'M' end 
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=365 then 'A' end as COD_UNI_FRE_REV_INT

	,		datediff(day,c.fecha_colocacion,c.fecha_vencimiento) as PLZ_CONTRACTUAL		

	,		case	when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<31 then datediff(day,c.fecha_colocacion,c.fecha_vencimiento)
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=31 and datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<365 then
							case when ROUND(datediff(day,c.fecha_colocacion,c.fecha_vencimiento)/30,0,0)>=12 then 1 else round(datediff(day,c.fecha_colocacion,c.fecha_vencimiento)/30,0,0) end 
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=365 then round(datediff(day,c.fecha_colocacion,c.fecha_vencimiento)/365,0,0) end as PLZ_AMRT

	,		case	when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<31 then 'D'
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=31 and datediff(day,c.fecha_colocacion,c.fecha_vencimiento)<365 then
							case when ROUND(datediff(day,c.fecha_colocacion,c.fecha_vencimiento)/30,0,0)>=12 then 'A' else 'M' end 
					when datediff(day,c.fecha_colocacion,c.fecha_vencimiento)>=365 then 'A' end as COD_UNI_PLZ_AMRT

	,		c.valor_emision_um	as IMP_INI_MO
	,		0					as IMP_CUO_MO
	,		c.valor_emision_um	as IMP_CUO_INI_MO
	,		1					as NUM_CUO_PAC
	,		1					as NUM_CUO_PEND
	,		c.valor_colocacion_um	as IMP_PAGO_ML
	,		c.valor_emision_um    as IMP_PAGO_MO
	,		5					as IND_CAN_ANT
	,		'N'					AS IND_TAS_PREDEF
	,		0					as TAS_PREDEF
	,		c.valor_colocacion_um	as IMP_INI_ML
	,		0					as TAS_INT_ORIGEN
	,		0					as COD_PORTAFOLIO
	,		''					as DES_PORTAFOLIO
	,		null				as COD_NEMOTECNICO
	,CASE c.entidad_cartera	WHEN 1 THEN  'TR'	-- Trading
							WHEN 2 THEN  'PLP'	-- Portfolio LP
							WHEN 3 THEN  'ET'	-- Estructuración
							WHEN 4 THEN  'BL'	-- BALANCE
							WHEN 9 THEN  'PR'	-- PROPIETARIO
							WHEN 10 THEN 'PLO'	-- PORTFOLIO LO 180
							WHEN 13 THEN 'MT'	-- MM TASA   -- REVISAR
							WHEN 14 THEN 'MF'	-- MM FX -- REVISAR
							WHEN 16 THEN 'BGF'	-- Balance Gestion Financiera -- REVISAR
							ELSE		 'BGL'	-- Balance Gestion Liquidez -- REVISAR
							END as COD_CARTERA_FINANCI
	,case when c.libro_deskmanager = 1 then 'N' else 'B' end as COD_TIP_LIBRO
	,		null				as NUM_DOC
	,		null				as NUM_OPE_ANT
	,		0					as T_FLUJO
	from MDPasivo..CARTERA_PASIVO c
	inner join MDPasivo..MOVIMIENTO_PASIVO m on m.codigo_instrumento=c.codigo_instrumento and m.numero_operacion=c.numero_operacion and m.numero_correlativo=c.numero_correlativo
	INNER JOIN BacParamSuda.dbo.moneda ON mncodmon = c.moneda_emision
	INNER JOIN BacParamSuda..CLIENTE ON Clrut=c.rut_cliente AND Clcodigo=c.codigo_cliente

--select * from #TMP_DETALLE_PSV

	SELECT	DISTINCT
			 NRO_DOCUMENTO --	= NUM_CUENTA
			,NRO_OPERACION--	= NUM_CUENTA
			,NRO_CORRELATIVO--	= NUM_SECUENCIA_CTO
			,FEC_DATA = convert(date,FEC_DATA)			
			,COD_ENTIDAD = '1769'			
			,COD_PRODUCTO	= 'PSV'	
			,COD_SUBPRODU		
			,NUM_CUENTA			
			,NUM_SECUENCIA_CTO = REPLICATE('0', 4 - LEN(NUM_SECUENCIA_CTO)) + CONVERT(CHAR, NUM_SECUENCIA_CTO)
			,COD_DIVISA			
			,COD_REAJUSTE	   = (case when cod_divisa='UFR' then 'UF' when cod_divisa='UF' then 'UF' else null end)
			,IDF_PERS_ODS		
			,COD_CENTRO_CONT		
			,COD_OFI_COMERCIAL	
			,COD_GESTOR_PROD		
			,COD_BASE_TAS_INT	
			,COD_BCA_INT			
			,COD_COMPOS_INT		
			,COD_MOD_PAGO		
			,COD_MET_AMRT		
			,COD_CUR_REF = 0	
			,COD_TIP_TAS			
			,TAS_INT				
			,TAS_DIF_INC_REF	= TAS_INT	
			,FEC_ALTA_CTO = CONVERT(DATE,FEC_ALTA_CTO)	
			,FEC_INI_GEST		
			,FEC_CAN_ANT = CONVERT(DATE, '1900/01/01')
			,FEC_ULT_LIQ			
			,FEC_PRX_LIQ			
			,FEC_ULT_REV			
			,FEC_PRX_REV			
			,FEC_VEN				
			,FRE_PAGO_INT		
			,COD_UNI_FRE_PAGO_INT
			,FRE_REV_INT			
			,COD_UNI_FRE_REV_INT	
			,PLZ_CONTRACTUAL		
			,PLZ_AMRT			
			,COD_UNI_PLZ_AMRT	
			,IMP_INI_MO			
			,IMP_CUO_MO				= imp_cuo_ini_mo	
			,IMP_CUO_INI_MO		
			,NUM_CUO_PAC			
			,NUM_CUO_PEND		
			,IMP_PAGO_ML			
			,IMP_PAGO_MO			
			,IND_CAN_ANT				= 5		
			,IND_TAS_PREDEF		
			,TAS_PREDEF			
			,LTRIM(RTRIM(IMP_INI_ML))	AS IMP_INI_ML		
			,TAS_INT_ORIGEN				= 0.0
			,COD_PORTAFOLIO		
			,SUBSTRING(DES_PORTAFOLIO,1,20)	 AS DES_PORTAFOLIO	
			,COD_NEMOTECNICO		
			,COD_CARTERA_FINANCI	
			,COD_TIP_LIBRO
			,NUM_DOC		= NUM_CUENTA
			,NUM_OPE_ANT	= NULL
			,TFLUJO = 0
	FROM #TMP_DETALLE_PSV



	SET NOCOUNT OFF  

END
GO
