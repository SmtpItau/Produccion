USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_OPERACIONES_RF_VP_SERIADO]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_DETALLE_OPERACIONES_RF_VP_SERIADO '20181031'
CREATE PROCEDURE [dbo].[SP_DETALLE_OPERACIONES_RF_VP_SERIADO]
(
	@FECHA DATE = NULL
)
AS
BEGIN
SET NOCOUNT ON
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ DETALLE OPERACIONES RF_VP_SERIADO
--MODIFICACION	: 01-08-2018	DUPLICADOS
--MODIFICACION	: 16-10-2018	FEC_CAN_ANT

--DECLARE @FECHA DATE

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


/*************************************************************************************************************/
/*	EXTRACCION DE DATOS DE CARTERA VI NO SERIADA.															 */
/*************************************************************************************************************/
SELECT
/*1*/		 NRO_DOCUMENTO			= vp.numdocu																					---NUMERIC(20)
/*2*/		,NRO_OPERACION			= vp.numoper														--vp.numdocu																					---NUMERIC(20)
/*3*/		,NRO_CORRELATIVO		= vp.correla																					---NUMERIC(20)		DEFAULT(1)
/*4*/		,FEC_DATA				= @FECHA_PROC_FILTRO																			---DATE				DEFAULT('1900-01-01')
/*5*/		,COD_ENTIDAD			= '1769'																						---VARCHAR(4)
/*6*/		,COD_PRODUCTO			= 'BTR'																							---VARCHAR(4)
/*7*/		,COD_SUBPRODU			= 'VP'																							---VARCHAR(4)
/*8*/		,NUM_CUENTA				= vp.numdocu--vp.numoper																					---VARCHAR(12)
/*9*/		,NUM_SECUENCIA_CTO		= vp.correla																					---NUMERIC(4)		DEFAULT 1
/*10*/		,COD_DIVISA				= case	m.mnnemo 
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
														bactradersuda.dbo.mdmo with(nolock) where monumdocu = vp.numdocu),'RNAVARRETE')--VARCHAR(15)
/*16*/		,COD_BASE_TAS_INT		= (case	
										when s.sebasemi = 0 then 'M'
										when s.sebasemi = 30 then 'M'
										when s.sebasemi in (360, 365)  then 'A'
										else 'A'
										end)
/*17*/		,COD_BCA_INT			=(case 
										when s.sebasemi = 30 then '1'
										when s.sebasemi = 360 then '2'
										when s.sebasemi > 360 then '6'
										when s.sebasemi = 0 then '3' 
										else '7' end)
/*18*/		,COD_COMPOS_INT			= 'C'																								---CHAR(1)
/*19*/		,COD_MOD_PAGO			= 'V'																								---CHAR(1)
/*20*/		,COD_MET_AMRT			= '1'																								---VARCHAR(4)
/*21*/		,COD_CUR_REF			= 0																									---VARCHAR(5)
/*22*/		,COD_TIP_TAS			= 'F'																								---VARCHAR(2) --CASE WHEN tipo_tasa IN (1, 2, 5)  THEN 'F' ELSE 'V' END
/*23*/		,TAS_INT				= (case when vp.tasacontrato = 0 then vp.tircomp	else vp.tasacontrato end)						---NUMERIC(8,5)
/*24*/		,TAS_DIF_INC_REF		= (case when vp.tasacontrato = 0 then vp.tircomp	else vp.tasacontrato end)						---NUMERIC(8,5)
/*25*/		,FEC_ALTA_CTO			= vp.feccomp																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*26*/		,FEC_INI_GEST			= vp.feccomp																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*27*/		,FEC_CAN_ANT			= '1900-01-01'--vp.ventafechareal																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*28*/		,FEC_ULT_LIQ			= vp.feccomp -- '1900-01-01'--vp.fecucup				--(fecha corte ult. cupon +- fecha valuta si es que aplica)				---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*29*/		,FEC_PRX_LIQ			= vp.fecvenc -- '1900-01-01'--vp.fecpcup				--(fecha corte prox. cupon)												---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*30*/		,FEC_ULT_REV			= vp.feccomp				--(fecha de compra cupon) 												---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*31*/		,FEC_PRX_REV			= vp.fecvenc																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*32*/		,FEC_VEN				= vp.fecvenc																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*33*/		,FRE_PAGO_INT			= (case 
										when datediff(day,vp.feccomp,vp.fecvenc) <31 then 1		
										when datediff(day,vp.feccomp,vp.fecvenc) >=31 and  datediff(day,vp.feccomp,vp.fecvenc)<365 then 2
										when datediff(day,vp.feccomp,vp.fecvenc) >=365 then 3
										end)																													---NUMERIC(5)
/*34*/		,COD_UNI_FRE_PAGO_INT	= (case 
										when datediff(day,vp.feccomp,vp.fecvenc) <31 then 'D'		
										when datediff(day,vp.feccomp,vp.fecvenc) >=31 and  datediff(day,vp.feccomp,vp.fecvenc)<365 then 'M'
										when datediff(day,vp.feccomp,vp.fecvenc) >=365 then 'A'
										end)																								---CHAR(1)
/*35*/		,FRE_REV_INT			= (case 
										when datediff(day,vp.feccomp,vp.fecvenc) <31 then 1		
										when datediff(day,vp.feccomp,vp.fecvenc) >=31 and  datediff(day,vp.feccomp,vp.fecvenc)<365 then 2
										when datediff(day,vp.feccomp,vp.fecvenc) >=365 then 3
										end) 
/*36*/		,COD_UNI_FRE_REV_INT	= (case 
										when datediff(day,vp.feccomp,vp.fecvenc) <31 then 'D'		
										when datediff(day,vp.feccomp,vp.fecvenc) >=31 and  datediff(day,vp.feccomp,vp.fecvenc)<365 then 'M'
										when datediff(day,vp.feccomp,vp.fecvenc) >=365 then 'A'
										end) ---CHAR(1)
/*37*/		,PLZ_CONTRACTUAL		= datediff(day,vp.feccomp,vp.fecvenc)																								---NUMERIC(5)
/*38*/		,PLZ_AMRT				= (case 
										when datediff(day,vp.feccomp,vp.fecvenc) <=30 then 
											datediff(day,vp.feccomp,vp.fecvenc) 		
										when datediff(day,vp.feccomp,vp.fecvenc) >30 and  datediff(day,vp.feccomp,vp.fecvenc)<365 then 
											case 
												when datediff(month,vp.feccomp,vp.fecvenc)>=12 then 1
												else datediff(month,vp.feccomp,vp.fecvenc)
												end													
										when datediff(day,vp.feccomp,vp.fecvenc) >=365 then 
											datediff(year,vp.feccomp,vp.fecvenc)
										end)
/*39*/		,COD_UNI_PLZ_AMRT		= (case 
										when datediff(day,vp.feccomp,vp.fecvenc) <31 then 'D'		
										when datediff(day,vp.feccomp,vp.fecvenc) >=31 and  datediff(day,vp.feccomp,vp.fecvenc)<365 then 
											case
												when datediff(month,vp.feccomp,vp.fecvenc) >= 12 then 'A'
												else 'M'
												end
										when datediff(day,vp.feccomp,vp.fecvenc) >=365 then 'A'
										end) 																				--CHAR(1)
/*40*/		,IMP_INI_MO				= vp.nominal																			--NUMERIC(20,4)
/*41*/		,IMP_CUO_MO				= 
(case 
when s.sepervcup - (select max(cpnumucup) from bactradersuda.dbo.mdcp with(nolock) where cpinstser=vp.instser) >0 
then (select top 1 value from dbo.Fx_RNT_RF_VALUES(
										vp.mascara
										,'VP'
										,vp.nominal
										,null --vi.vinumucup
										,vp.numdocu
										,vp.feccomp
										,vp.fecvenc
										,vp.fecucup
										,vp.fecpcup,null
										) where concept = 'imp_cuo_mo' )	
else 0 end)																											--NUMERIC(20,2)
/*42*/		,IMP_CUO_INI_MO			= 																			--NUMERIC(20,2)
(select top 1 value from dbo.Fx_RNT_RF_VALUES(
										vp.mascara
										,'VP'
										,vp.nominal
										,null --vi.vinumucup
										,vp.numdocu
										,vp.feccomp
										,vp.fecvenc
										,vp.fecucup
										,vp.fecpcup,null
										) where concept = 'imp_cuo_ini_mo' )	
/*43*/		,NUM_CUO_PAC			= s.sepervcup																			--NUMERIC(5)		DEFAULT(1)
/*44*/		,NUM_CUO_PEND			= 
(case 
 when s.sepervcup - isnull((select max(cpnumucup) from bactradersuda.dbo.mdcp with(nolock) where cpinstser=vp.instser),0) <=0 then 0
 else s.sepervcup - isnull((select max(cpnumucup) from bactradersuda.dbo.mdcp with(nolock) where cpinstser=vp.instser),0)
 end)	--NUMERIC(5)		DEFAULT(1)
/*45*/		,IMP_PAGO_ML			= vp.ventavalor																			--NUMERIC(20,4)
/*46*/		,IMP_PAGO_MO			= (vp.ventavalor)/tc.vmvalor 															--NUMERIC(20,4)
-- MGM Cambio en el Indicador de Cancelacion
/*47*/		,IND_CAN_ANT			= 5--NULL --(case when convert(date,vp.ventafechareal)='1900-01-01' then 1 else 5 end)																					--CHAR(1)
-- MGM 30-07-2018
/*48*/		,IND_TAS_PREDEF			= (case when vp.tasemis<>0 then 'S' else 'N' end)										--CHAR(1)
/*49*/		,TAS_PREDEF				= vp.tasemis																			--NUMERIC(8,5)
/*50*/		,IMP_INI_ML				= vp.ventavalor																			--NUMERIC(20,4)
/*51*/		,TAS_INT_ORIGEN			= 0.0000 																				--NUMERIC(8,5)
/*52*/		,COD_PORTAFOLIO			= vp.tipo_cartera																		--VARCHAR(10)
/*53*/		,DES_PORTAFOLIO			= (substring((select ltrim(rtrim(tbglosa)) 
										from bactradersuda.dbo.view_tabla_general_detalle with(nolock)
										where tbcodigo1=vp.tipo_cartera and tbcateg=204),1,20))								--VARCHAR(20)
/*54*/		,COD_NEMOTECNICO		= vp.instser 																			--VARCHAR(20)
/*55*/		,COD_CARTERA_FINANCI	= CASE vp.cartera 
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
										END																					--CHAR(8) 
/*56*/		,COD_TIP_LIBRO			= 'B' --(case when cp.id_libro = 1 then 'N' else 'B' end)								--VARCHAR(1)
/*57*/		,NUM_DOC				= vp.numdocu																			--VARCHAR(12)
/*58*/		,NUM_OPE_ANT			= null																					--VARCHAR(12)
/*59*/		,T_FLUJO				= 0																						--INT DEFAULT 0
FROM 
			BACTRADERSUDA.DBO.MDVP	AS VP	WITH(NOLOCK)
LEFT JOIN   BacParamSuda.dbo.Serie as s	with(nolock)
			on (case when s.secodigo=20 then semascara else seserie end) = 
				(case when vp.codigo=20 then mascara else instser end)
LEFT JOIN	BacParamSuda.dbo.Cliente AS CL WITH(NOLOCK)
			ON 
				vp.rutcli = cl.clrut
			and vp.codcli = cl.clcodigo
Left Join	BacParamSuda.dbo.Moneda as m	with(nolock)
			on s.semonemi = m.mncodmon
inner join ##rent_valor_tc_contable as tc
			on tc.vmcodigo = s.semonemi
WHERE
	vp.nominal>0 
and vp.seriado  in ('S')
and vp.ventafechareal between @fecha_ini_filtro and @fecha_proc_filtro

END
GO
