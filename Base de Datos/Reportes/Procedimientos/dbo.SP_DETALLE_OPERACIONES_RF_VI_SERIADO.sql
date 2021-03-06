USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_OPERACIONES_RF_VI_SERIADO]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_DETALLE_OPERACIONES_RF_VI_SERIADO
CREATE PROCEDURE [dbo].[SP_DETALLE_OPERACIONES_RF_VI_SERIADO]
(
	@FECHA		 DATE = NULL
)
AS 
BEGIN 	
--SONDA			: RENTABILIDAD
--DESCRIPCION	: INTERFAZ DETALLE OPERACIONES RF_VI_SERIADO
--MODIFICACION	: 01-08-2018	DUPLICADOS
--MODIFICACION	: 16-10-2018	FEC_CAN_ANT

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

select 
	IdMonedaemision				= ser.semonemi
	,NemoMonedaEmision			= mon.mnnemo
	,int_origen					= 0 -- ser.setasemi	
	,plz_amrt					= ser.sepervcup
	,ser.setipvcup
	,ser.seplazo
	,ser.setipamort
	,cuotas_pactadas			= ser.secupones
	,cuotas_pendientes			= abs(ser.secupones - cp.vinumucupc)			--> revisar logica.
	,base_emision				= ser.sebasemi
	,cp.*
	,codtipotasa				='000'
	,tip_cambio					= vc.vmvalor
	into #TMP_MONEDAS

	--select top 100 * from BacTraderSuda.dbo.mdvi
	--where vinominal>0
	--and viseriado='S'
	
from 
(
	 select vinumdocu,vicodigo,viinstser,vimascara,vinominal,vitircomp,tasa_contrato,vinumucupc,vifecven
	 ,cpfiltro = (case when vicodigo=20 then vimascara else viinstser end) 
	 from BacTraderSuda.dbo.mdvi with(nolock) 
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
cp.vinominal > 0
order by cp.vinumdocu





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
 vimascara
,vicodigo
,datediff(day,@fecha_proc_filtro,vifecven)
,vifecven
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
														bactradersuda.dbo.mdmo with(nolock) where monumdocu = vi.vinumdocu),'RNAVARRETE')--VARCHAR(15)
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
										else '7'
										end)
/*18*/		,COD_COMPOS_INT			= 'C'																								---CHAR(1)
/*19*/		,COD_MOD_PAGO			= 'V'																								---CHAR(1)
/*20*/		,COD_MET_AMRT			= '1'																								---VARCHAR(4)
/*21*/		,COD_CUR_REF			= 0																									---VARCHAR(5)
/*22*/		,COD_TIP_TAS			= m.codtipotasa																						---VARCHAR(2) --CASE WHEN tipo_tasa IN (1, 2, 5)  THEN 'F' ELSE 'V' END
/*23*/		,TAS_INT				= (case when vi.tasa_contrato = 0 then vi.vitircomp	else vi.tasa_contrato end)						---NUMERIC(8,5)
/*24*/		,TAS_DIF_INC_REF		= (case m.codtipotasa
										 when 'F' then 
											(case when vi.tasa_contrato = 0 then vi.vitircomp	else vi.tasa_contrato end)
										 when 'V' then 
											(case when vi.tasa_contrato = 0 then vi.vitircomp	else vi.tasa_contrato end) - m.int_origen		---NUMERIC(8,5)
										 end)
/*25*/		,FEC_ALTA_CTO			= vi.vifeccomp																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*26*/		,FEC_INI_GEST			= vi.vifeccomp																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*27*/		,FEC_CAN_ANT			= '1900-01-01'																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*28*/		,FEC_ULT_LIQ			= vi.vifecucup				--(fecha corte ult. cupon +- fecha valuta si es que aplica)				---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*29*/		,FEC_PRX_LIQ			= vi.vifecpcup				--(fecha corte prox. cupon)												---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*30*/		,FEC_ULT_REV			= vi.vifeccomp				--(fecha de compra cupon) 												---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*31*/		,FEC_PRX_REV			= vi.vifecven																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*32*/		,FEC_VEN				= vi.vifecven																						---DATE			DEFAULT('1900-01-01')--NUMERIC(8)
/*33*/		,FRE_PAGO_INT			= (case m.setipvcup	
											when 'D' then 1																			
											when 'M' then 2
										when 'A' then 3											
											else 3										
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
/*38*/		,PLZ_AMRT				= m.plz_amrt																						---NUMERIC(5)
/*39*/		,COD_UNI_PLZ_AMRT		= (case 
										when datediff(day,vi.vifecinip,vi.vifecven) <31 then 'D'		
										when datediff(day,vi.vifecinip,vi.vifecven) >=31 and  datediff(day,vi.vifecinip,vi.vifecven)<365 then 'M'
										when datediff(day,vi.vifecinip,vi.vifecven) >=365 then 'A'
										end) 																							---CHAR(1)
/*40*/		,IMP_INI_MO				= vi.vinominal																						---NUMERIC(20,4)
/*41*/		,IMP_CUO_MO				= 0		--vi.viinteresvi -- vi.vinominal/m.cuotas_pactadas											---NUMERIC(20,2)


--/*42*/	,IMP_CUO_INI_MO			= vi.vinominal																						---NUMERIC(20,2)
/*42*/		,IMP_CUO_INI_MO			= (select top 1 value from dbo.Fx_RNT_RF_VALUES(
											 vi.vimascara
											,'VI'
											,vi.vinominal
											,null --vi.vinumucup
											,vi.vinumdocu
											,vi.vifeccomp
											,vi.vifecven
											,vi.vifecucup
											,vi.vifecpcup,null
											) where concept = 'imp_cuo_ini_mo' )	
/*43*/		,NUM_CUO_PAC			= m.cuotas_pactadas																					---NUMERIC(5)		DEFAULT(1)
/*44*/		,NUM_CUO_PEND			= m.cuotas_pendientes																				---NUMERIC(5)		DEFAULT(1)


/*45*/		,IMP_PAGO_ML			= vi.vivptirc																						--NUMERIC(20,4)
/*46*/		,IMP_PAGO_MO			= (vi.vicapitalvi  + vi.viinteresvi+vi.vireajustvi)/m.tip_cambio									--NUMERIC(20,4)
-- MGM Cambio en el Indicador de Cancelacion
/*47*/		,IND_CAN_ANT			= 5--NULL--CASE WHEN vi.vitipoper in ('RCA', 'RVA') THEN 1 ELSE NULL END																							---CHAR(1)
-- MGM 30-07-2018
/*48*/		,IND_TAS_PREDEF			= (case when vi.vitasest<>0 then 'S' else 'N' end)													---CHAR(1)
/*49*/		,TAS_PREDEF				= vi.vitasest																						---NUMERIC(8,5)
/*50*/		,IMP_INI_ML				= vi.vivptirc																						---NUMERIC(20,4)
/*51*/		,TAS_INT_ORIGEN			= m.int_origen																						---NUMERIC(8,5)
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
			BACTRADERSUDA.DBO.MDVI	AS VI	WITH(NOLOCK)
LEFT JOIN	#TMP_MONEDAS			AS M	WITH(NOLOCK)
			ON	vi.vinumdocu	= m.vinumdocu
			and vi.vimascara	= m.vimascara
			and vi.vicodigo		= m.vicodigo
LEFT JOIN	BacParamSuda.dbo.Cliente AS CL WITH(NOLOCK)
			ON 
				vi.virutcli = cl.clrut
			and vi.vicodcli = cl.clcodigo
WHERE
	vi.vinominal>0 
and vi.viseriado  in ('S')

END
GO
