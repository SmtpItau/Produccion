USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_REL_CLTE_CTO_RF]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REL_CLTE_CTO_RF]
(
	@FECHA DATE = NULL	
)
AS
BEGIN
SET NOCOUNT ON 
SET DATEFORMAT YMD
/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: INTERFAZ RELACION CLIENTE CONTRATO, RENTAFIJA
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 24-03-2017
*/

/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/
DECLARE @FECHA_PROC_FILTRO	DATE
DECLARE @FECHA_INI_FILTRO	DATE
-- DECLARE @FECHA DATE	   
-- SET @FECHA = '20150520'

IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 acfecproc FROM BacTraderSuda.dbo.MDAC WITH(NOLOCK)) 
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END
SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')


/* MONEDAS PARA CP*/
select 
	IdMonedaemision  = ser.semonemi
	,NemoMonedaEmision = mon.mnnemo
	,cp.*
	into #TMP_MONEDAS
from 
(
	 select cpnumdocu,cpcodigo, cpinstser, cpmascara, cpnominal, cptircomp,
	 cpfiltro = (case when cpcodigo = 20 then cpmascara else cpinstser end)
	 from   BacTraderSuda.dbo.mdcp with(nolock)
)	as	cp 
inner join 
(
	select semonemi, semascara, seserie, secodigo
    ,SeFiltro = case when secodigo = 20 then semascara else seserie end  
     from   BacParamsuda.dbo.serie with(nolock)
      --where  semascara like 'bcir%'
) as	ser
	on ser.SeFiltro = cp.cpfiltro
left join 
  (      
	select mncodmon, mnnemo from bacparamsuda.dbo.moneda with(nolock)
 ) as    mon          
	On mon.mncodmon = ser.semonemi 
where  --cpinstser like  'bcir%' and 
cpnominal > 0
order by cp.cpnumdocu


/****************************************************
	TEMPORAL DE RESULTADOS
*****************************************************/
CREATE TABLE #TMP_RESULTADOS
(
	 NUM_OPERACION		NUMERIC(20,0)
	,NUM_DOCUMENTO		NUMERIC(20,0)
	,NUM_CORRELATIVO	NUMERIC(20,0)
	,ID_SISTEMA		VARCHAR(5)
	,COD_SUBPRODU		VARCHAR(15)
	,MONEDA			NUMERIC(20,0)
	,RUTCLIENTE		NUMERIC(20,0)
	,COD_CLIENTE		NUMERIC(20,0)
	,FECHA_CONTRATO	DATETIME
	,FECHA_VENC		DATETIME
	,STATUS_OPE		VARCHAR(20)	
)

/****************************************************
	EXTRACCIO DE DATOS
*****************************************************/

/****************************************************
	CARTERA CP
*****************************************************/		
	-- CARTERA CP SERIADA
	INSERT INTO #TMP_RESULTADOS
	select distinct
		 null								as num_operacion
		,cp.cpnumdocu						as num_documento
		,cp.cpcorrela						as correlativo
		,'BTR'								as id_sistema
		,'CP'								as cod_subprodu		
		,m.IdMonedaemision					as moneda
		,cp.cprutcli						as rutcliente
		,cp.cpcodcli						as cod_cliente		
		,cp.cpfecemi						as fecha_emision
		,cp.cpfecven						as fecha_vence		
		,'VIGENTE'							as status_v
	from	
				BacTraderSuda.dbo.mdcp	as cp with(nolock)	
	left join	#TMP_MONEDAS			as m with(nolock)
				on cp.cpnumdocu			= m.cpnumdocu
				and cp.cpmascara		= m.cpmascara
				and cp.cpcodigo			= m.cpcodigo
	where 
		cp.cpnominal>0
	and cp.cpseriado in('S')

	-- CARTERA CP NO SERIADA
	INSERT INTO #TMP_RESULTADOS
	select distinct
		 null								as num_operacion
		,cp.cpnumdocu						as num_documento
		,cp.cpcorrela						as correlativo
		,'BTR'							as id_sistema
		,'CP'							as cod_subprodu		
		,ns.nsmonemi						as moneda
		,cp.cprutcli						as rutcliente
		,cp.cpcodcli						as cod_cliente		
		,cp.cpfecemi						as fecha_emision
		,cp.cpfecven						as fecha_vence		
		,'VIGENTE'							as status_v
	from	
			  BacTraderSuda.dbo.mdcp	as cp with(nolock)	
	left join BacParamSuda.dbo.noserie	as ns with(nolock) 
			  on   ns.nsnumdocu = cp.cpnumdocu
			  and  ns.nscorrela	= cp.cpcorrela
	where 
		cp.cpnominal>0
	and cp.cpseriado in('N')

/****************************************************
	CARTERA VI
*****************************************************/
	INSERT INTO #TMP_RESULTADOS
	-- CARTERA VI
	select distinct
		 vi.vinumoper		 
		,vi.vinumdocu	
		,vi.vicorrela
		,'BTR'				 as id_sistema
		,'VI'				 as cod_subprodu
		,vi.vimonemi		 as moneda 		
		,vi.virutcli
		,vi.vicodcli		
		--,vi.vifecucup
		--,vi.vifeccomp
		,vi.vifecemi
		,vi.vifecven
		--,vi.viseriado
		--,vi.viinstser
		--,vi.vimascara
		,'VIGENTE'	 	
	from BacTraderSuda.dbo.mdvi as vi with(NOLOCK)
	where 
			vi.vinominal>0
		and vi.viseriado in ('S','N')		

/****************************************************
	CARTERA CI
*****************************************************/
	INSERT INTO #TMP_RESULTADOS
	-- CARTERA CI
	select distinct   
		 null							as num_documento
		,ci.cinumdocu					as num_operacion
		,ci.cicorrela
		,'BTR'							as id_sistema
		,'CI'							as cod_subprodu
		,ci.cimonemi
		--,(case ci.ciseriado
		--	when 'S' then s.semonemi
		--	when 'N' then ns.nsmonemi
		--	else null
		--  end) as moneda
		,ci.cirutcli
		,ci.cicodcli		
		--,ci.cifeccomp
		--,ci.cifecucup		
		,ci.cifecemi
		,ci.cifecven	
		--,ci.ciseriado
		--,ci.ciinstser
		--,ci.cimascara
		,'VIGENTE'						 as status_v
	from
			BacTraderSuda.dbo.mdci as ci WITH(NOLOCK)
	--left join BacParamSuda.dbo.serie	as s  with(nolock)
	--		  on	ltrim(rtrim(s.seserie)  )=ltrim(rtrim(ci.ciinstser))
	--		  and	ltrim(rtrim(s.semascara))=ltrim(rtrim(ci.cimascara))		
	--left join BacParamSuda.dbo.noserie	as ns with(nolock) 
	--		  on   ns.nsnumdocu = ci.cinumdocu
	--		  and  ns.nscorrela	= ci.cicorrela
	where 
		ci.cinominal>0
	and ci.ciseriado in ('S','N')
	--and UPPER(ci.cimascara) not in ('ICAP','ICOL')

	
/****************************************************
	CARTERA CANCELADA O VENCIDA
*****************************************************/	
insert into #tmp_resultados
select distinct
	  rs.rsnumoper
	 ,rs.rsnumdocu
	 ,rs.rscorrela
	 ,'BTR'				as id_sistema
	 ,rs.rstipopero
	 ,rs.rsmonemi
	 ,rs.rsrutcli
	 ,rs.rscodcli
	 ,rs.rsfecemis
	 ,rs.rsfecvcto
	 ,'VENC/CANC'		as status_v

from   BacTraderSuda.dbo.mdrs as rs with(nolock)
where  rs.rsfecha   between @fecha_ini_filtro and @fecha_proc_filtro
and          rs.rstipoper    = 'VC'
and          rs.rsinstser    NOT IN('ICOL','ICAP')
and          rs.rscartera    = 111  --> vencimento de cupon

insert into #TMP_RESULTADOS
select distinct
	  rs.rsnumoper
	 ,rs.rsnumdocu
	 ,rs.rscorrela
	 ,'BTR'				as id_sistema
	 ,rs.rsinstser
	 ,rs.rsmonemi
	 ,rs.rsrutcli
	 ,rs.rscodcli
	 ,rs.rsfecemis
	 ,rs.rsfecvcto
	 ,'VENC/CANC'		as status_v
from   BacTraderSuda.dbo.mdrs as rs with(nolock)
where  rs.rsfecha	between @fecha_ini_filtro and @fecha_proc_filtro
       and          rs.rstipoper    = 'VC'
       and          rs.rsinstser    IN('ICOL','ICAP')
       and          rs.rscartera    = 130  --> Cartera Interbancaria con el Central


insert into #tmp_resultados
select distinct
		 monumoper
		,monumdocu
		,mocorrela
		,'BTR'
		,motipoper
		,momonemi
		,morutcli
		,mocodcli
		,mofecemi
		,mofecven
		--,mofecpro
		--,mofecpcup
		--,motipoper					
		,'CANC/VENC' as status_v		
		/*
		,Descripcion = (case
						 when motipopero = 'cp' then 'vencimiento de pacto comprado Propio'
                         when motipopero = 'ci' then 'vencimiento de pacto comprado con pacto'
                        end)
		*/
 from   
		BacTradersuda.dbo.mdmo
 where  
		motipoper in('RC', 'RV', 'RCA', 'RVA')
  and   mofecpro     between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO 
 union 
 select distinct
		 monumoper
		,monumdocu
		,mocorrela
		,'BTR'
		,motipoper
		,momonemi
		,morutcli
		,mocodcli
		,mofecemi
		,mofecven
		--,mofecpro
		--,mofecpcup
		--,motipopero					
		,'CANC/VENC' as status_v	    
	   /*
	   ,Descripcion = (case
						when motipopero = 'cp' then 'vencimiento de pacto comprado Propio'
                        when motipopero = 'ci' then 'vencimiento de pacto comprado con pacto'
                        end)
		*/
 from   BacTradersuda.dbo.mdmh 
 where  motipoper in('RC', 'RV', 'RCA', 'RVA')
 and          mofecpro     between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO 
 
 

 /****************************************************
	DEVOLUCION DE REGISTROS
*****************************************************/	
select distinct
NUM_OPERACION,		    --> en interface final, se toma este como nro_operacion
NUM_DOCUMENTO,		    --> en interface final, se toma este como nro_documento
NUM_CORRELATIVO,
ID_SISTEMA,
LTRIM(RTRIM(COD_SUBPRODU)) AS COD_SUBPRODU,
MONEDA,
RUTCLIENTE,
COD_CLIENTE,
@FECHA_PROC_FILTRO	       AS FECHA_PROCESO,
FECHA_CONTRATO,
FECHA_VENC,
STATUS_OPE,
0					  AS T_FLUJO
from #TMP_RESULTADOS

DROP TABLE #TMP_RESULTADOS
DROP TABLE #TMP_MONEDAS


END 
GO
