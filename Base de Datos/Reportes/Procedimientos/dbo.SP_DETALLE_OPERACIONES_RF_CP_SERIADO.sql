USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_OPERACIONES_RF_CP_SERIADO]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_DETALLE_OPERACIONES_RF_CP_SERIADO 
CREATE PROCEDURE [dbo].[SP_DETALLE_OPERACIONES_RF_CP_SERIADO]
(
	@FECHA		 DATE = NULL
)
AS 
BEGIN 	

SET NOCOUNT ON

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

/* MONEDAS PARA CP*/
select 
	IdMonedaemision				= ser.semonemi
	,NemoMonedaEmision			= mon.mnnemo
	,int_origen					= 0 --ser.setasemi	
	,plz_amrt					= ser.sepervcup
	,ser.setipvcup
	,ser.seplazo
	,ser.setipamort
	,cuotas_pactadas			= ser.secupones
	,cuotas_pendientes			= abs(ser.secupones - cp.cpnumucup)			--> revisar logica.
	,base_emision				= ser.sebasemi
	,cp.*
	,codtipotasa				='000'
	,tip_cambio					= vc.vmvalor
	into #TMP_MONEDAS
from 
(
	 select cpnumdocu,cpcorrela,cpcodigo, cpinstser, cpmascara, cpnominal, cptircomp,tasa_contrato,cpnumucup,cpfecven
	 ,cpfiltro = (case when cpcodigo = 20 then cpmascara else cpinstser end)
	 from   BacTraderSuda.dbo.mdcp with(nolock)
)	as	cp 
inner join 
(
	select semonemi, semascara, seserie, secodigo,setasemi,setipvcup,sepervcup,seplazo,setipamort,secupones,sebasemi
    ,SeFiltro = case when secodigo = 20 then semascara else seserie end  
     from   BacParamsuda.dbo.serie with(nolock)      
) as	ser
	on ser.SeFiltro = cp.cpfiltro
left join 
  (      
	select mncodmon, mnnemo from bacparamsuda.dbo.moneda with(nolock)
 ) as    mon          
	On mon.mncodmon = ser.semonemi 
left join  ##RENT_VALOR_TC_CONTABLE as vc
	ON ser.semonemi = vc.vmcodigo
where  
cpnominal > 0
order by cp.cpnumdocu



/*************************************************************************************************************/
/*CURSOR PARA ACTUALIZAR DATOS DE LA TABLA TMP_MONEDAS														*/
/*************************************************************************************************************/
declare 
	@codigo int
	,@inst_variable varchar(1)	= 'N'
	,@tip_tasa		varchar(3)	= '0'
	,@t_tasa		varchar(1)  
	,@mascara		varchar(15)
	,@nInTasb		int
	,@dias			int
	,@cpfecven		date

declare cur_tipo_tasa cursor for
select distinct 
cpmascara
,cpcodigo
,datediff(day,@fecha_proc_filtro,cpfecven)
,cpfecven
from #tmp_monedas

open cur_tipo_tasa
fetch next from cur_tipo_tasa 
into 
@mascara,@codigo,@dias,@cpfecven
while @@fetch_status= 0 begin
	set @nIntasb   = (select intasest from BacParamSuda.dbo.instrumento with(nolock) where incodigo = @codigo) 
	set @inst_variable  = 'N'
	set @tip_tasa       = '0'

	if @nIntasb > 0  begin   
		if (@codigo = 1 OR @codigo =2 OR @codigo =5 OR substring(@mascara,1,8) = 'BCAPS-A1' ) begin 
			set @inst_variable = 'S'
			set @tip_tasa = 
					(case 
						when substring(@mascara,1,3) = 'PCD' OR substring(@mascara,1,3) ='PTF' then '2' 
						when substring(@mascara,1,8) = 'BCAPS-A1'  then '3'
						else '9' 
					end)
		end  
	end 

	if @inst_variable= 'N' begin -- tasa fija..
		select @t_tasa = 'F'
		set @tip_tasa = (
			case 
				when @dias<30						then '101'
				when @dias>=30		and @dias<90	then '102'
				when @dias>=90		and	@dias<180	then '103'
				when @dias>=180		and @dias<365	then '104'
				when @dias>=365		and @dias<1095	then '105'
				when @dias>=1905	 				then '106'
			end)

	end else if @inst_variable='S' begin
		select @t_tasa = 'V'
		set @tip_tasa ='2' + 
		(case 
				when datediff(day,@fecha_proc_filtro,@cpfecven)<30														then substring(@tip_tasa,1,1) + '1'
				when datediff(day,@fecha_proc_filtro,@cpfecven)>=30  and datediff(day,@fecha_proc_filtro,@cpfecven)	<90 then substring(@tip_tasa,1,1) + '2'
				when datediff(day,@fecha_proc_filtro,@cpfecven)>=90  and datediff(month,@fecha_proc_filtro,@cpfecven)<6	then substring(@tip_tasa,1,1) + '3'
				when datediff(year,@fecha_proc_filtro,@cpfecven)>=6  and datediff(year,@fecha_proc_filtro,@cpfecven) <1	then substring(@tip_tasa,1,1) + '4'
				when datediff(month,@fecha_proc_filtro,@cpfecven)>=1 and datediff(year,@fecha_proc_filtro,@cpfecven) <3	then substring(@tip_tasa,1,1) + '5'
				when datediff(year,@fecha_proc_filtro,@cpfecven)>=3														then substring(@tip_tasa,1,1) + '6'
			end)
	end

	update #tmp_monedas 
	---set codtipotasa = isnull(@tip_tasa,'---')
	set codtipotasa = isnull(@t_tasa,'---')
	where cpfiltro = @mascara
	 
	fetch next from cur_tipo_tasa
	into @mascara,@codigo,@dias,@cpfecven
end
close cur_tipo_tasa
deallocate cur_tipo_tasa

/*************************************************************************************************************/
/*	EXTRACCION DE DATOS DE CARTERA PROPIA SERIADA.															 */
/*************************************************************************************************************/
SELECT
/*1*/		 NRO_DOCUMENTO			= cp.cpnumdocu																					---NUMERIC(20)
/*2*/		,NRO_OPERACION			= cp.cpnumdocu													--cp.cpnumdocu																					---NUMERIC(20)
/*3*/		,NRO_CORRELATIVO		= cp.cpcorrela																					---NUMERIC(20)		DEFAULT(1)
/*4*/		,FEC_DATA				= @FECHA_PROC_FILTRO																			---DATE				DEFAULT('1900-01-01')
/*5*/		,COD_ENTIDAD			= '1769'																						---VARCHAR(4)
/*6*/		,COD_PRODUCTO			= 'BTR'																							---VARCHAR(4)
/*7*/		,COD_SUBPRODU			= 'CP'																							---VARCHAR(4)
/*8*/		,NUM_CUENTA				= cp.cpnumdocu																					---VARCHAR(12)
/*9*/		,NUM_SECUENCIA_CTO		= cp.cpcorrela																					---NUMERIC(4)		DEFAULT 1
/*10*/		,COD_DIVISA				= case M.NemoMonedaEmision 
										when 'UF' then 'CLP'
										when 'DO' then 'USD'
										else M.NemoMonedaEmision
										end																							---VARCHAR(4)
/*11*/		,COD_REAJUSTE			= case M.NemoMonedaEmision
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
														bactradersuda.dbo.mdmo with(nolock) where monumdocu = cp.cpnumdocu),'RNAVARRETE')--VARCHAR(15)
/*16*/		,COD_BASE_TAS_INT		= (case	
										when m.base_emision = 0 then 'M'
										when m.base_emision = 30 then 'M'
										when m.base_emision in (360, 365)  then 'A'
										else 'A'
										end)
/*17*/		,COD_BCA_INT			=(case 
										when m.base_emision = 30 then '1'
										when m.base_emision = 360 then '2'
										when m.base_emision > 360 then '6'
										when m.base_emision = 0 then '3' 
										else '7' end)
/*18*/		,COD_COMPOS_INT			= 'C'																								---CHAR(1)
/*19*/		,COD_MOD_PAGO			= 'V'																								---CHAR(1)
/*20*/		,COD_MET_AMRT			= '1'																								---VARCHAR(4)
/*21*/		,COD_CUR_REF			= 0																									---VARCHAR(5)
/*22*/		,COD_TIP_TAS			= m.codtipotasa																						---VARCHAR(2) --CASE WHEN tipo_tasa IN (1, 2, 5)  THEN 'F' ELSE 'V' END
/*23*/		,TAS_INT				= (case when cp.tasa_contrato = 0 then cp.cptircomp	else cp.tasa_contrato end)						---NUMERIC(8,5)
/*24*/		,TAS_DIF_INC_REF		= (case m.codtipotasa
										when 'F' then 
											(case when cp.tasa_contrato = 0 then cp.cptircomp	else cp.tasa_contrato end)
										when 'V' then 
											(case when cp.tasa_contrato = 0 then cp.cptircomp	else cp.tasa_contrato end) - m.int_origen		---NUMERIC(8,5)
										end)
/*25*/		,FEC_ALTA_CTO			= cp.cpfeccomp																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*26*/		,FEC_INI_GEST			= cp.cpfeccomp																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*27*/		,FEC_CAN_ANT			= '1900-01-01'																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*28*/		,FEC_ULT_LIQ			= cp.cpfecucup				--(fecha corte ult. cupon +- fecha valuta si es que aplica)				---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*29*/		,FEC_PRX_LIQ			= cp.cpfecpcup				--(fecha corte prox. cupon)												---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*30*/		,FEC_ULT_REV			= cp.cpfeccomp				--(fecha de compra cupon) 												---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*31*/		,FEC_PRX_REV			= cp.cpfecven																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*32*/		,FEC_VEN				= cp.cpfecven																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*33*/		,FRE_PAGO_INT			= (case m.setipvcup	
											when 'D' then 1																			
											when 'M' then 2
										when 'A' then 3											
											else 3										
											end)																						---NUMERIC(5)
/*34*/		,COD_UNI_FRE_PAGO_INT	= (case 
										when datediff(day,cp.cpfeccomp,cp.cpfecven) <31 then 'D'		
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=31 and  datediff(day,cp.cpfeccomp,cp.cpfecven)<365 then 'M'
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=365 then 'A'
										end)																								---CHAR(1)
/*35*/		,FRE_REV_INT			= (case 
										when datediff(day,cp.cpfeccomp,cp.cpfecven) <31 then 1		
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=31 and  datediff(day,cp.cpfeccomp,cp.cpfecven)<365 then 2
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=365 then 3
										end) 
/*36*/		,COD_UNI_FRE_REV_INT	= (case 
										when datediff(day,cp.cpfeccomp,cp.cpfecven) <31 then 'D'		
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=31 and  datediff(day,cp.cpfeccomp,cp.cpfecven)<365 then 'M'
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=365 then 'A'
										end) ---CHAR(1)
/*37*/		,PLZ_CONTRACTUAL		= datediff(day,cp.cpfeccomp,cp.cpfecven)																								---NUMERIC(5)
/*38*/		,PLZ_AMRT				= m.plz_amrt																						---NUMERIC(5)
/*39*/		,COD_UNI_PLZ_AMRT		= (case 
										when datediff(day,cp.cpfeccomp,cp.cpfecven) <31 then 'D'		
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=31 and  datediff(day,cp.cpfeccomp,cp.cpfecven)<365 then 'M'
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=365 then 'A'
										end) 																							---CHAR(1)
/*40*/		,IMP_INI_MO				= cp.cpnominal																						---NUMERIC(20,4)
/*41*/		,IMP_CUO_MO				= (select top 1 value from dbo.Fx_RNT_RF_VALUES(
											cp.cpmascara
											,'CP'
											,cp.cpnominal
											,cp.cpnumucup
											,cp.cpnumdocu
											,cp.cpfeccomp
											,cp.cpfecven
											,cp.cpfecucup
											,cp.cpfecpcup,null
											) where concept = 'imp_cuo_mo' )															--cp.cpnominal/m.cuotas_pactadas ---NUMERIC(20,2)

/*42*/		,IMP_CUO_INI_MO			= (select top 1 value from dbo.Fx_RNT_RF_VALUES(
											cp.cpmascara
											,'CP'
											,cp.cpnominal
											,cp.cpnumucup
											,cp.cpnumdocu
											,cp.cpfeccomp
											,cp.cpfecven
											,cp.cpfecucup
											,cp.cpfecpcup,null
											) where concept = 'imp_cuo_ini_mo' )															--cp.cpnominal	---NUMERIC(20,2)
/*43*/		,NUM_CUO_PAC			= m.cuotas_pactadas																					---NUMERIC(5)		DEFAULT(1)
/*44*/		,NUM_CUO_PEND			= m.cuotas_pendientes																				---NUMERIC(5)		DEFAULT(1)


/*45*/		,IMP_PAGO_ML			= cp.cpvptirc																						--NUMERIC(20,4)
/*46*/		,IMP_PAGO_MO			= (cp.cpcapitalc  + cp.cpinteresc+cp.cpreajustc)/m.tip_cambio										--NUMERIC(20,4)
-- MGM Cambio en el Indicador de Cancelacion
/*47*/		,IND_CAN_ANT			= 5--NULL																								---CHAR(1)
-- MGM 30-07-2018
/*48*/		,IND_TAS_PREDEF			= (case when cp.cptasest<>0 then 'S' else 'N' end)													---CHAR(1)
/*49*/		,TAS_PREDEF				= cp.cptasest																						---NUMERIC(8,5)
/*50*/		,IMP_INI_ML				= case when cp.cpvptirc=0 then cp.cpvalvenc else cp.cpvptirc end									---NUMERIC(20,4)
/*51*/		,TAS_INT_ORIGEN			= m.int_origen																					---NUMERIC(8,5)
/*52*/		,COD_PORTAFOLIO			= cp.cptipcart																						---VARCHAR(10)
/*53*/		,DES_PORTAFOLIO			= (substring((select ltrim(rtrim(tbglosa)) 
										from bactradersuda.dbo.view_tabla_general_detalle with(nolock)
										where tbcodigo1=cp.cptipcart and tbcateg=204),1,20))											---VARCHAR(20)
/*54*/		,COD_NEMOTECNICO		= cp.cpinstser 																						---VARCHAR(20)
/*55*/		,COD_CARTERA_FINANCI	= CASE cp.tipo_cartera_financiera 
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
/*56*/		,COD_TIP_LIBRO			= (case when cp.id_libro = 1 then 'N' else 'B' end)													---VARCHAR(1)
/*57*/		,NUM_DOC				= cp.cpnumdocu																						---VARCHAR(12)
/*58*/		,NUM_OPE_ANT			= cp.cpnumdocuo																						---VARCHAR(12)
/*59*/		,T_FLUJO				= 0																									---INT DEFAULT 0
FROM BACTRADERSUDA.DBO.MDCP	AS CP	WITH(NOLOCK)
inner JOIN #TMP_MONEDAS AS M	WITH(NOLOCK) ON	cp.cpnumdocu = m.cpnumdocu and cp.cpcorrela=m.cpcorrela and cp.cpmascara = m.cpmascara and cp.cpcodigo = m.cpcodigo
inner JOIN BacParamSuda.dbo.Cliente AS CL WITH(NOLOCK) ON cp.cprutcli = cl.clrut and cp.cpcodcli = cl.clcodigo
WHERE CP.cpnominal>0 
and CP.cpseriado  in ('S')


END
GO
