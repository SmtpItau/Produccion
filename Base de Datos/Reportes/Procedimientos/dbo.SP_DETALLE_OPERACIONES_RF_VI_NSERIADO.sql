USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_OPERACIONES_RF_VI_NSERIADO]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_DETALLE_OPERACIONES_RF_VI_NSERIADO
CREATE PROCEDURE [dbo].[SP_DETALLE_OPERACIONES_RF_VI_NSERIADO]
(
	@FECHA		 DATE = NULL
)
AS 
BEGIN 	
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ DETALLE OPERACIONES RF_VI_NSERIADO
--MODIFICACION	: 01-08-2018	DUPLICADOS
--MODIFICACION	: 16-10-2018	FEC_CAN_ANT

SET NOCOUNT ON 
-- DECLARE @FECHA DATE
DECLARE @FECHA_PROC_FILTRO	DATE
DECLARE @FECHA_INI_FILTRO	DATE


IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT acfecproc FROM BacTraderSuda..MDAC with (nolock) ) 
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA 
END
SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')
	 

IF OBJECT_ID('TEMPDB..#TMP_MONEDAS') IS NOT NULL BEGIN
	DROP TABLE #TMP_MONEDAS
END

/********************************************************************************************/
/*			CARGA DE VALORES DE MONEDA CONTABLE												*/
/********************************************************************************************/
IF OBJECT_ID('TEMPDB..##RENT_VALOR_TC_CONTABLE') IS NOT NULL BEGIN
	DROP TABLE ##RENT_VALOR_TC_CONTABLE
END

EXEC REPORTES.DBO.SP_RENT_VALOR_TC_CONTABLE @FECHA=@FECHA
/********************************************************************************************/
/*******************************************************
		EXTRACCION DE DATOS  (VENTAS CON PACTOS?)
********************************************************/
SELECT		DISTINCT
/*1*/		 NRO_DOCUMENTO			= vi.vinumdocu																					---NUMERIC(20)
/*2*/		,NRO_OPERACION			= vi.vinumoper																					--vi.vinumdocu																					---NUMERIC(20)
/*3*/		,NRO_CORRELATIVO		= vi.vicorrela																					---NUMERIC(20)		DEFAULT(1)
/*4*/		,FEC_DATA				= @FECHA_PROC_FILTRO																			---DATE				DEFAULT('1900-01-01')
/*5*/		,COD_ENTIDAD			= '1769'																						---VARCHAR(4)
/*6*/		,COD_PRODUCTO			= 'BTR'																							---VARCHAR(4)
/*7*/		,COD_SUBPRODU			= 'VI'																							---VARCHAR(4)
/*8*/		,NUM_CUENTA				= vi.vinumoper																					---VARCHAR(12)
/*9*/		,NUM_SECUENCIA_CTO		= vi.vicorrela																					---NUMERIC(4)		DEFAULT 1
/*10*/		,COD_DIVISA				= case m.mnnemo
										when 'UF' then 'CLP'
										when 'DO' then 'USD'
										else m.mnnemo
										end																							---VARCHAR(4)
/*11*/		,COD_REAJUSTE			= case m.mnnemo
										when 'UF' then 'UF'											
										else null
										end																								---VARCHAR(3)
/*12*/		,IDF_PERS_ODS			= convert(varchar,CL.clrut) + '-' + ltrim(rtrim(cl.cldv))											---VARCHAR(25)
/*13*/		,COD_CENTRO_CONT		= '2230'																							---VARCHAR(4)		DEFAULT('2230')
/*14*/		,COD_OFI_COMERCIAL		= ''																								---VARCHAR(5)		DEFAULT('001  ')
/*15*/		,COD_GESTOR_PROD		= isnull((select top 1 (case 
														when mousuario is null then 'RNVARRETE'
														when ltrim(rtrim(mousuario))='' then 'RNAVARRETE' 
														else ltrim(rtrim(mousuario))
														end) as mousuario from 
														bactradersuda.dbo.mdmo with(nolock) where monumdocu = vi.vinumdocu),'RNAVARRETE')--VARCHAR(15)
/*16*/		,COD_BASE_TAS_INT		= (case	
										when ns.nsbasemi = 0 then 'M'
										when ns.nsbasemi = 30 then 'M'
										when ns.nsbasemi in (360, 365)  then 'A'
										else 'A'
										end)
/*17*/		,COD_BCA_INT			=(case 
										when ns.nsbasemi = 30 then '1'
										when ns.nsbasemi = 360 then '2'
										when ns.nsbasemi > 360 then '6'
										when ns.nsbasemi = 0 then '3' 
										else '7' 
										end)
/*18*/		,COD_COMPOS_INT			= 'C'																								---CHAR(1)
/*19*/		,COD_MOD_PAGO			= 'V'																								---CHAR(1)
/*20*/		,COD_MET_AMRT			= '1'																								---VARCHAR(4)
/*21*/		,COD_CUR_REF			= 0																									---VARCHAR(5)
/*22*/		,COD_TIP_TAS			= 'F' --m.codtipotasa																						---VARCHAR(2) --CASE WHEN tipo_tasa IN (1, 2, 5)  THEN 'F' ELSE 'V' END
/*23*/		,TAS_INT				= (case when vi.tasa_contrato = 0 then vi.vitircomp	else vi.tasa_contrato end)						---NUMERIC(8,5)
/*24*/		,TAS_DIF_INC_REF		= (case when vi.tasa_contrato = 0 then vi.vitircomp	else vi.tasa_contrato end)
/*25*/		,FEC_ALTA_CTO			= vi.vifeccomp																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*26*/		,FEC_INI_GEST			= vi.vifeccomp																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*27*/		,FEC_CAN_ANT			= '1900-01-01'																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*28*/		,FEC_ULT_LIQ			= vi.vifecucup				--(fecha corte ult. cupon +- fecha valuta si es que aplica)				---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*29*/		,FEC_PRX_LIQ			= vi.vifecpcup				--(fecha corte prox. cupon)												---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*30*/		,FEC_ULT_REV			= vi.vifeccomp				--(fecha de compra cupon) 												---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*31*/		,FEC_PRX_REV			= vi.vifecven																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*32*/		,FEC_VEN				= vi.vifecven																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*33*/		,FRE_PAGO_INT			=(case 
										when datediff(day,vi.vifecinip,vi.vifecven) <31 then 1		
										when datediff(day,vi.vifecinip,vi.vifecven) >=31 and  datediff(day,vi.vifeccomp,vi.vifecven)<365 then 2
										when datediff(day,vi.vifecinip,vi.vifecven) >=365 then 3
										end)																						---NUMERIC(5)
/*34*/		,COD_UNI_FRE_PAGO_INT	= (case 
										when datediff(day,vi.vifecinip,vi.vifecven) <31 then 'D'		
										when datediff(day,vi.vifecinip,vi.vifecven) >=31 and  datediff(day,vi.vifecinip,vi.vifecven)<365 then 'M'
										when datediff(day,vi.vifecinip,vi.vifecven) >=365 then 'A'
										end)																								---CHAR(1)			
/*35*/		,FRE_REV_INT			= (case 
										when datediff(day,vi.vifecinip,vi.vifecven) <31 then 1		
										when datediff(day,vi.vifecinip,vi.vifecven) >=31 and  datediff(day,vi.vifecinip,vi.vifecven)<365 then 2
										when datediff(day,vi.vifecinip,vi.vifecven) >=365 then 3
										end) 
/*36*/		,COD_UNI_FRE_REV_INT	= (case 
										when datediff(day,vi.vifecinip,vi.vifecven) <31 then 'D'		
										when datediff(day,vi.vifecinip,vi.vifecven) >=31 and  datediff(day,vi.vifecinip,vi.vifecven)<365 then 'M'
										when datediff(day,vi.vifecinip,vi.vifecven) >=365 then 'A'
										end) ---CHAR(1)
/*37*/		,PLZ_CONTRACTUAL		= datediff(day,vi.vifecinip,vi.vifecven)																								---NUMERIC(5)
/*38*/		,PLZ_AMRT				= (case 
										when datediff(day,vi.vifecinip,vi.vifecven) <31 then   datediff(day,vi.vifecinip,vi.vifecven)		
										when datediff(day,vi.vifecinip,vi.vifecven) >=31 and   datediff(day,vi.vifecinip,vi.vifecven)<365 then datediff(month,vi.vifecinip,vi.vifecven)
										when datediff(day,vi.vifecinip,vi.vifecven) >=365 then datediff(year,vi.vifecinip,vi.vifecven)
										end)										
/*39*/		,COD_UNI_PLZ_AMRT		= (case 
										when datediff(day,vi.vifecinip,vi.vifecven) <31 then 'D'		
										when datediff(day,vi.vifecinip,vi.vifecven) >=31 and  datediff(day,vi.vifecinip,vi.vifecven)<365 then 'M'
										when datediff(day,vi.vifecinip,vi.vifecven) >=365 then 'A'
										end) 																							---CHAR(1)
/*40*/		,IMP_INI_MO				= vi.vinominal																						---NUMERIC(20,4)
/*41*/		,IMP_CUO_MO				= 0		--vi.viinteresvi -- vi.vinominal/m.cuotas_pactadas											---NUMERIC(20,2)


/*42*/		,IMP_CUO_INI_MO			= vi.vinominal																						---NUMERIC(20,2)
/*43*/		,NUM_CUO_PAC			= 1 --m.cuotas_pactadas																					---NUMERIC(5)		DEFAULT(1)
/*44*/		,NUM_CUO_PEND			= 0 --m.cuotas_pendientes																				---NUMERIC(5)		DEFAULT(1)
/*45*/		,IMP_PAGO_ML			= vi.vivptirc																						--NUMERIC(20,4)
/*46*/		,IMP_PAGO_MO			= (vi.vicapitalvi  + vi.viinteresvi+vi.vireajustvi)/tc.vmvalor									--NUMERIC(20,4)
-- MGM Cambio en el Indicador de Cancelacion
/*47*/		,IND_CAN_ANT			= 5--NULL --CASE WHEN vi.vitipoper in ('RCA', 'RVA') THEN 1 ELSE NULL END																								---CHAR(1)
-- MGM 30-07-2018
/*48*/		,IND_TAS_PREDEF			= (case when vi.vitasest<>0 then 'S' else 'N' end)													---CHAR(1)
/*49*/		,TAS_PREDEF				= vi.vitasest																						---NUMERIC(8,5)
/*50*/		,IMP_INI_ML				= vi.vivptirc																						---NUMERIC(20,4)
/*51*/		,TAS_INT_ORIGEN			= 0.0000 --m.int_origen																						---NUMERIC(8,5)
/*52*/		,COD_PORTAFOLIO			= vi.tipo_cartera_financiera --vi.vitipcart																						---VARCHAR(10)
/*53*/		,DES_PORTAFOLIO			= (substring((select ltrim(rtrim(tbglosa)) 
										from bactradersuda.dbo.view_tabla_general_detalle with(nolock)
										where tbcodigo1=vi.Tipo_Cartera_Financiera and tbcateg=204),1,20))											---VARCHAR(20)
/*54*/		,COD_NEMOTECNICO		= vi.viinstser 																						---VARCHAR(20)
/*55*/		,COD_CARTERA_FINANCI	= CASE vi.tipo_cartera_financiera 
										WHEN 1 THEN  'TR'	-- Trading
										WHEN 2 THEN  'PLP'	-- Portfolio LP
										WHEN 3 THEN  'ET'	-- Estructuración
										WHEN 4 THEN  'BL'	-- BALANCE
										WHEN 9 THEN  'PR'	-- PROPIETARIO
										WHEN 10 THEN 'PLO'	-- PORTFOLIO LO 180
										WHEN 13 THEN 'MT'	-- MM TASA   -- REVISAR
										WHEN 14 THEN 'MF'	-- MM FX -- REVISAR
										WHEN 16 THEN 'BGF'	-- Balance Gestion Financiera -- REVISAR
										ELSE		 'BGL'	-- Balance Gestion Liquidez -- REVISAR
										END																								---CHAR(8) 
/*56*/		,COD_TIP_LIBRO			= (case when vi.id_libro = 1 then 'N' else 'B' end)													---VARCHAR(1)
/*57*/		,NUM_DOC				= vi.vinumdocu																						---VARCHAR(12)
/*58*/		,NUM_OPE_ANT			= null --vi.vinumdocuo																				---VARCHAR(12)
/*59*/		,T_FLUJO				= 0																									---INT DEFAULT 0

FROM 
			BacTraderSuda.dbo.mdvi	AS vi	WITH(NOLOCK)
left join	BacParamSuda.dbo.NoSerie  as ns	with(nolock)
on			vi.vinumdocu = ns.nsnumdocu
		and vi.vicorrela = ns.nscorrela
left join	BacParamSuda.dbo.Cliente	as cl	with(nolock)
on
			vi.virutcli = cl.clrut
		and vi.vicodcli = cl.clcodigo
left join	BacParamSuda.dbo.Moneda	as m	with(nolock)
on
		ns.nsmonemi = m.mncodmon
inner join ##RENT_VALOR_TC_CONTABLE as tc	
on		ns.nsmonemi = tc.vmcodigo

WHERE
	vi.vinominal>0 
and vi.viseriado  in ('N')

END
GO
