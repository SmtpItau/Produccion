USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENT_CUADRO_PAGO_RF]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RENT_CUADRO_PAGO_RF]
(
	@FECHA DATE = NULL
)
AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT YMD
/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: INTERFAZ CUADRO PAGO, RENTAFIJA (CARTERA PROPIA)
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 17-03-2017
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



;with CTE_DATA_RF
AS
(
-- letras hipotecarias
select 
 cp.cpcorrela								--> correlativo
,cp.cpnumucup								--> ultimo cupon
,cp.cpnumdocu								--> nro documento
,null		 		as nro_operacion		--> nro operacion
,cp.cprutcart								--> rut cartera
,cp.cprutcli								--> rut cliente
,cp.cpinstser								--> serie instrumento
,cp.cpmascara								--> mascara
,cp.cpfecven								--> fecha vencimiento
,cp.cpfecemi								--> fecha emision
,cp.cpnominal								--> nominal
,cp.cpvptirc								--> valor presente
,td.tdcupon									--> nro cupon
from 
		   BacTraderSuda.dbo.mdcp as cp with(nolock)
left join  BacParamSuda.dbo.SERIE as s	 with(nolock)
			 on	 ltrim(rtrim(s.seserie))	=	ltrim(rtrim(cp.cpinstser)) 
			 and ltrim(rtrim(s.semascara))	=	ltrim(rtrim(cp.cpmascara))			
inner join  BacTraderSuda.dbo.VIEW_TABLA_DESARROLLO as td with(nolock)
	on substring(cp.cpinstser,1,6) = td.tdmascara
	and cp.cpnumucup >= td.tdcupon
where 
	cp.cpseriado = 'S'
and cp.cpnominal>0
and cp.cpcodigo=20
and cp.cpfecven >= @FECHA_PROC_FILTRO
--order by cp.cpnumdocu desc,td.tdcupon asc
union
select 
 cp.cpcorrela							--> correlativo
,cp.cpnumucup							--> ultimo cupon
,cp.cpnumdocu							--> nro documento
,null		 	as nro_operacion		--> nro operacion
,cp.cprutcart							--> rut cartera
,cp.cprutcli							--> rut cliente
,cp.cpinstser							--> serie instrumento
,cp.cpmascara							--> mascara
,cp.cpfecven							--> fecha vencimiento
,cp.cpfecemi							--> fecha emision
,cp.cpnominal							--> nominal
,cp.cpvptirc							--> valor presente
,td.tdcupon								--> nro cupon
from 
		   BacTraderSuda.dbo.mdcp as cp with(nolock)
left join  BacParamSuda.dbo.SERIE as s	 with(nolock)
			 on	 ltrim(rtrim(s.seserie))	=	ltrim(rtrim(cp.cpinstser)) 
			 and ltrim(rtrim(s.semascara))	=	ltrim(rtrim(cp.cpmascara))			
inner join  BacTraderSuda.dbo.VIEW_TABLA_DESARROLLO as td with(nolock)
	on substring(cp.cpinstser,1,6) = td.tdmascara 
	and cp.cpnumucup >= td.tdcupon
where 
	cp.cpseriado = 'S'
and cp.cpnominal>0
and cp.cpcodigo<>20
and cp.cpfecven >= @FECHA_PROC_FILTRO
--order by cp.cpnumdocu desc,td.tdcupon asc
union
select distinct
	  rs.rscorrela
	 ,rs.rsnumpcup
	 ,rs.rsnumdocu
	 ,rs.rsnumoper
	 ,rs.rsrutcart
	 ,rs.rsrutcli
	 ,rs.rsinstser
	 ,rs.rsmascara
	 ,rs.rsfecvcto
	 ,rs.rsfecemis
	 ,rs.rsnominal
	 ,rs.rsvppresen
	 ,rs.rsnumucup
from		BacTraderSuda.dbo.mdrs as rs with(nolock)
--left join	BacParamSuda.dbo.serie as s  with(nolock)
--			on	ltrim(rtrim(s.seserie)) = ltrim(rtrim(rs.rsinstser))
--			and ltrim(rtrim(s.semascara)) = ltrim(rtrim(rs.rsmascara))
--left join  BacTraderSuda.dbo.VIEW_TABLA_DESARROLLO as td with(nolock)
--			on substring(rs.rsinstser,1,6) = td.tdmascara
--			and rs.rsnumucup>=td.tdcupon
where  
		rs.rsfecha   between  @fecha_ini_filtro  and  @fecha_proc_filtro

and          rs.rstipoper    = 'VC'
and          rs.rsinstser    NOT IN('ICOL','ICAP')
--and		 rs.rscodigo	<> 20
and          rs.rscartera    = 111  --> vencimento de cupon
--order by rs.rsnumdocu desc
)
SELECT --distinct 
	 cpnumdocu					as nro_documento
	,nro_operacion				as nro_operacion	
	,cpcorrela					as correlativo
	,cpfecven					as fec_vec_flujo
	,@fecha_proc_filtro			as fec_proceso
	,cpnominal					as sdo_amrt_mon_origen
	,cpvptirc					as sdo_amrt_mon_local
	,3							as tpo_saldo
	,'BTR'						as id_sistema
	,0							as t_flujo
FROM CTE_DATA_RF
ORDER BY cpnumdocu desc,tdcupon asc


END
GO
