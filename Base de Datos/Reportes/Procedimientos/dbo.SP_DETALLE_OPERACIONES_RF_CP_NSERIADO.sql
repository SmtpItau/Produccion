USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_DETALLE_OPERACIONES_RF_CP_NSERIADO]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_DETALLE_OPERACIONES_RF_CP_NSERIADO
CREATE PROCEDURE [dbo].[SP_DETALLE_OPERACIONES_RF_CP_NSERIADO]
(
	@FECHA DATE = NULL
)
AS 
BEGIN
--	SONDA		: RENTABILIDAD
--	DESCRIPCION	: INTERFAZ DETALLE OPERACIONES
--	MODIFICACION: 27-06-2018	CAMPOS TASA, IND_CAN_ANT
--	MODIFICACION: 19-10-2018	agregar nro operacion


SET NOCOUNT ON

--DECLARE @FECHA DATE
DECLARE @FECHA_PROC_FILTRO	DATE
DECLARE @FECHA_INI_FILTRO	DATE


IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT acfecproc FROM BacTraderSuda..MDAC with (nolock) ) 
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA 
END
SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')
	 


IF OBJECT_ID('TEMPDB..#TMP_RF_CP_NSERIE') IS NOT NULL BEGIN
	DROP TABLE #TMP_RF_CP_NSERIE
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
/*1*/		 NRO_DOCUMENTO			=cp.cpnumdocu
/*2*/		,NRO_OPERACION			=cp.cpnumdocu
/*3*/		,NRO_CORRELATIVO		=cp.cpcorrela
/*4*/		,FEC_DATA				=@FECHA_PROC_FILTRO
/*5*/		,COD_ENTIDAD			='1769'	
/*6*/		,COD_PRODUCTO			='BTR'
/*7*/		,COD_SUBPRODU			='CP'
/*8*/		,NUM_CUENTA				=cp.cpnumdocu
/*9*/		,NUM_SECUENCIA_CTO		=cp.cpcorrela
/*10*/		,COD_DIVISA				=(case m.mnnemo
												when 'UF' then 'CLP'
												when 'DO' then 'USD'
												else m.mnnemo
											end)
/*11*/		,COD_REAJUSTE			=(case m.mnnemo
												when 'UF' then 'UF'
												else null
											end)
/*12*/		,IDF_PERS_ODS			= convert(varchar,CL.clrut) + '-' + ltrim(rtrim(cl.cldv))											
/*13*/		,COD_CENTRO_CONT		= '2230'																							
/*14*/		,COD_OFI_COMERCIAL		= ''																								
/*15*/		,COD_GESTOR_PROD		= isnull((select top 1 (case 
														when mousuario is null then 'RNVARRETE'
														when ltrim(rtrim(mousuario))='' then 'RNAVARRETE' 
														else ltrim(rtrim(mousuario))
														end) as mousuario from 
														bactradersuda.dbo.mdmo with(nolock) where monumdocu = cp.cpnumdocu),'RNAVARRETE')

/*16*/		,COD_BASE_TAS_INT		=(case
										when ns.nsbasemi = 0 then 'M'
										when ns.nsbasemi = 30 then 'M'
										when ns.nsbasemi in(360,365) then 'A'
										end)
/*17*/		,COD_BCA_INT			=(case 
										when ns.nsbasemi = 30 then '1'
										when ns.nsbasemi = 360 then '2'
										when ns.nsbasemi > 360 then '6'
										when ns.nsbasemi = 0 then '3' 
										else '7' end)
/*18*/		,COD_COMPOS_INT			='C'
/*19*/		,COD_MOD_PAGO			='V'
/*20*/		,COD_MET_AMRT			='1'
/*21*/		,COD_CUR_REF			=0
/*22*/		,COD_TIP_TAS			='X'
/*23*/		,TAS_INT				=(case when cp.Tasa_Contrato = 0 then cp.cptircomp else cp.Tasa_Contrato end)
/*24*/		,TAS_DIF_INC_REF		=(case when cp.Tasa_Contrato = 0 then cp.cptircomp else cp.Tasa_Contrato end)
/*25*/		,FEC_ALTA_CTO			=cp.cpfeccomp
/*26*/		,FEC_INI_GEST			=cp.cpfeccomp
/*27*/		,FEC_CAN_ANT			='1900-01-01'
/*28*/		,FEC_ULT_LIQ			=cp.cpfeccomp
/*29*/		,FEC_PRX_LIQ			=cp.cpfecven
/*30*/		,FEC_ULT_REV			=cp.cpfeccomp
/*31*/		,FEC_PRX_REV			=cp.cpfecven
/*32*/		,FEC_VEN				=cp.cpfecven
/*33*/		,FRE_PAGO_INT			=(case 
										when datediff(day,cp.cpfeccomp,cp.cpfecven) <31 then 1		
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=31 and  datediff(day,cp.cpfeccomp,cp.cpfecven)<365 then 2
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=365 then 3
										end)											
/*34*/		,COD_UNI_FRE_PAGO_INT	=(case 
										when datediff(day,cp.cpfeccomp,cp.cpfecven) <31 then 'D'		
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=31 and  datediff(day,cp.cpfeccomp,cp.cpfecven)<365 then 'M'
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=365 then 'A'
										end)	
/*35*/		,FRE_REV_INT			=(case 
										when datediff(day,cp.cpfeccomp,cp.cpfecven) <31 then 1		
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=31 and  datediff(day,cp.cpfeccomp,cp.cpfecven)<365 then 2
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=365 then 3
										end)	
/*36*/		,COD_UNI_FRE_REV_INT	=(case 
										when datediff(day,cp.cpfeccomp,cp.cpfecven) <31 then 'D'		
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=31 and  datediff(day,cp.cpfeccomp,cp.cpfecven)<365 then 'M'
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=365 then 'A'
										end)	
/*37*/		,PLZ_CONTRACTUAL		=datediff(day,cp.cpfeccomp,cp.cpfecven)
/*38*/		,PLZ_AMRT				=(case 
										when datediff(day,cp.cpfeccomp,cp.cpfecven) <31 then datediff(day,cp.cpfeccomp,cp.cpfecven)		
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=31 and  datediff(day,cp.cpfeccomp,cp.cpfecven)<365 then datediff(month,cp.cpfeccomp,cp.cpfecven)
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=365 then datediff(year,cp.cpfeccomp,cp.cpfecven)
										end)	
/*39*/		,COD_UNI_PLZ_AMRT		=(case 
										when datediff(day,cp.cpfeccomp,cp.cpfecven) <31 then 'D'		
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=31 and  datediff(day,cp.cpfeccomp,cp.cpfecven)<365 then 'M'
										when datediff(day,cp.cpfeccomp,cp.cpfecven) >=365 then 'A'
										end)	

----------------------------------------------
/*40*/		,IMP_INI_MO				=cp.cpnominal
/*41*/		,IMP_CUO_MO				=0
/*42*/		,IMP_CUO_INI_MO			=cp.cpnominal
----------------------------------------------
/*43*/		,NUM_CUO_PAC			=1
--- revisar cuotas pendientes para no seriados ( en teoria como es una sola operacion no deberian existir cuotas pendientes.)
/*44*/		,NUM_CUO_PEND			=(case when cp.cpfecven > @FECHA_PROC_FILTRO then 1 else 0 end)
/*45*/		,IMP_PAGO_ML			=cp.cpvptirc
/*46*/		,IMP_PAGO_MO			=cp.cpcapitalc + cp.cpinteresc + cp.cpreajustc /tc.vmvalor								  										  
------------------------------------------------
-- MGM Cambio en el Indicador de Cancelacion
/*47*/		,IND_CAN_ANT			= 5--NULL
-- MGM 30-07-2018
/*48*/		,IND_TAS_PREDEF			= (case when cp.cptasest<>0 then 'S' else 'N' end)
/*49*/		,TAS_PREDEF				= cp.cptasest

/*50*/		,IMP_INI_ML				=cp.cpnominal  * tc.vmvalor
/*51*/		,TAS_INT_ORIGEN			=0.0000
/*52*/		,COD_PORTAFOLIO			=cp.cptipcart
/*53*/		,DES_PORTAFOLIO			= (select substring((select ltrim(rtrim(tbglosa)) 
										from bactradersuda.dbo.view_tabla_general_detalle with(nolock)
										where tbcodigo1=cp.cptipcart and tbcateg=204),1,20))	
/*54*/		,COD_NEMOTECNICO		=cp.cpinstser
/*55*/		,COD_CARTERA_FINANCI	= (CASE cp.tipo_cartera_financiera 
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
											END)
/*56*/		,COD_TIP_LIBRO			=(case when cp.id_libro = 1 then 'N' else 'B' end)
/*57*/		,NUM_DOC				=cp.cpnumdocu
/*58*/		,NUM_OPE_ANT			=cp.cpnumdocuo
/*59*/		,T_FLUJO				=0
			,cp.cptircomp
			,cp.Tasa_Contrato
			,ns.nstasemi
------------------------------------------
into #TMP_RF_CP_NSERIE
from 
			BacTraderSuda.dbo.mdcp		as cp	with(nolock)
left join	BacParamSuda.dbo.NoSerie  as ns	with(nolock)
on		cp.cpnumdocu = ns.nsnumdocu
		and cp.cpcorrela = ns.nscorrela
left join	BacParamSuda.dbo.Cliente	as cl	with(nolock)
on
		cp.cprutcli = cl.clrut
		and cp.cpcodcli = cl.clcodigo
left join	BacParamSuda.dbo.Moneda	as m	with(nolock)
on
		ns.nsmonemi = m.mncodmon
inner join ##RENT_VALOR_TC_CONTABLE as tc	
on		ns.nsmonemi = tc.vmcodigo
where cpseriado = 'N'
and cpnominal>0

--------------------------------------------------------------------
declare 
	@codigo int
	,@inst_variable varchar(1)	= 'N'
	,@tip_tasa		varchar(3)	= '0'
	,@t_tasa		varchar(1)  
	,@mascara		varchar(15)
	,@nInTasb		int
	,@dias			int
	,@cpfecven		date
	,@numdocu		numeric(10)
	,@correla		numeric(10)
declare cur_tipo_tasa cursor 
for
select distinct
cpmascara
,cpcodigo
,datediff(day,@fecha_proc_filtro,cpfecven)
,cpfecven
,cpnumdocu
,cpcorrela
from 
bactradersuda.dbo.mdcp with(nolock)

open cur_tipo_tasa 
fetch next from cur_tipo_tasa
into @mascara,@codigo,@dias,@cpfecven,@numdocu,@correla

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
	end else if @inst_variable='S' begin
		select @t_tasa = 'V'		
	end

	update #TMP_RF_CP_NSERIE
	set 
		COD_TIP_TAS = @t_tasa
		,TAS_DIF_INC_REF = (
			case @t_tasa 
				when 'F' then
					(case when Tasa_Contrato= 0 then cptircomp else Tasa_Contrato end)
				when 'V' then
					(case when Tasa_Contrato = 0 then cptircomp else Tasa_Contrato end) - nstasemi
			end)
	where 
			NUM_DOC = @numdocu
		and NRO_CORRELATIVO = @correla
	 
	fetch next from cur_tipo_tasa
	into @mascara,@codigo,@dias,@cpfecven,@numdocu,@correla
end
close cur_tipo_tasa
deallocate cur_tipo_tasa


/*************************************************************************************************************/
/*	SALIDA CON DATOS PARA INTERFAZ.																			 */
/*************************************************************************************************************/
select 
/*1*/		 NRO_DOCUMENTO			
/*2*/		,NRO_OPERACION			
/*3*/		,NRO_CORRELATIVO		
/*4*/		,FEC_DATA				
/*5*/		,COD_ENTIDAD			
/*6*/		,COD_PRODUCTO			
/*7*/		,COD_SUBPRODU			
/*8*/		,NUM_CUENTA				
/*9*/		,NUM_SECUENCIA_CTO		
/*10*/		,COD_DIVISA				
/*11*/		,COD_REAJUSTE			
/*12*/		,IDF_PERS_ODS			
/*13*/		,COD_CENTRO_CONT		
/*14*/		,COD_OFI_COMERCIAL		
/*15*/		,COD_GESTOR_PROD		
/*16*/		,COD_BASE_TAS_INT		
/*17*/		,COD_BCA_INT			
/*18*/		,COD_COMPOS_INT			
/*19*/		,COD_MOD_PAGO			
/*20*/		,COD_MET_AMRT			
/*21*/		,COD_CUR_REF			
/*22*/		,COD_TIP_TAS			
/*23*/		,TAS_INT				
/*24*/		,TAS_DIF_INC_REF		
/*25*/		,FEC_ALTA_CTO			
/*26*/		,FEC_INI_GEST			
/*27*/		,FEC_CAN_ANT			
/*28*/		,FEC_ULT_LIQ			
/*29*/		,FEC_PRX_LIQ			
/*30*/		,FEC_ULT_REV			
/*31*/		,FEC_PRX_REV			
/*32*/		,FEC_VEN				
/*33*/		,FRE_PAGO_INT			
/*34*/		,COD_UNI_FRE_PAGO_INT	
/*35*/		,FRE_REV_INT			
/*36*/		,COD_UNI_FRE_REV_INT	
/*37*/		,PLZ_CONTRACTUAL		
/*38*/		,PLZ_AMRT				
/*39*/		,COD_UNI_PLZ_AMRT		
--------------------------------------------------
/*40*/		,IMP_INI_MO				
/*41*/		,IMP_CUO_MO				
/*42*/		,IMP_CUO_INI_MO			
/*43*/		,NUM_CUO_PAC			
/*44*/		,NUM_CUO_PEND			
/*45*/		,IMP_PAGO_ML			
/*46*/		,IMP_PAGO_MO			

-------------------------------------------------
/*47*/		,IND_CAN_ANT			
/*48*/		,IND_TAS_PREDEF			
/*49*/		,TAS_PREDEF				
/*50*/		,IMP_INI_ML				
/*51*/		,TAS_INT_ORIGEN			
/*52*/		,COD_PORTAFOLIO			
/*53*/		,DES_PORTAFOLIO			
/*54*/		,COD_NEMOTECNICO		
/*55*/		,COD_CARTERA_FINANCI	
/*56*/		,COD_TIP_LIBRO			
/*57*/		,NUM_DOC				
/*58*/		,NUM_OPE_ANT			
/*59*/		,T_FLUJO				
-------------------------------------------
FROM #TMP_RF_CP_NSERIE

DROP TABLE #TMP_RF_CP_NSERIE
END
GO
