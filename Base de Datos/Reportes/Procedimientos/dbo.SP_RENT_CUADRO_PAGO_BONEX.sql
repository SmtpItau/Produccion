USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENT_CUADRO_PAGO_BONEX]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_RENT_CUADRO_PAGO_BONEX]
(
	@FECHA DATE = NULL
)
AS
BEGIN
SET NOCOUNT OFF
SET DATEFORMAT YMD
/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: INTERFAZ CUADRO PAGO, BONEX
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 17-03-2017
*/

/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/


DECLARE @FECHA_PROC_FILTRO DATE
DECLARE @FECHA_INI_FILTRO DATE
--DECLARE @FECHA DATE
--SET @FECHA = '2016-07-31'
IF @FECHA IS NULL BEGIN
    SET @FECHA_PROC_FILTRO = (select top 1 acfecproc from BacBonosExtSuda.dbo.text_arc_ctl_dri with(nolock))
END ELSE BEGIN
    SET @FECHA_PROC_FILTRO = @FECHA --(SELECT TOP 1 acfecproc FROM Bacfwdsuda.dbo.mfac WITH(NOLOCK))
END
SET @FECHA_INI_FILTRO = CONVERT(DATE, CONVERT(VARCHAR, YEAR(@FECHA_PROC_FILTRO))+'-'+CONVERT(VARCHAR, MONTH(@FECHA_PROC_FILTRO))+'-01')


;with CTE_PAGO_BONEX
AS
(

--cartera vigente (seriada)
SELECT 
   c.cpnumdocu									as nro_operacion
  ,c.cpnumdocu									as nro_documento
  ,c.cpcorrelativo								as correlativo  
  ,isnull(d.fecha_vcto_cupon,c.cpfecven)		as fec_vec_flujo --> deberia ser fecha de vencimiento por cartera y no por tb de desarrollo?..
  ,@FECHA_PROC_FILTRO							as fec_proceso
  ,c.cpnominal									as nominal
  ,c.cpvptirc									as valor_presente
  ,c.cod_familia
  --,d.num_cupon								as numero_cupon
-- ,c.cpfecven
-- ,c.cpcorrelativo
-- ,c.cpnumdocu
-- ,c.cpnumpcup
-- ,c.cpnumucup
-- ,c.cod_familia
-- ,c.cod_nemo
-- ,c.id_instrum
-- ,c.cpmonemi
-- ,c.cpnominal
-- ,c.cpvptirc
-- ,c.cpinteres
-- ,c.tipo_inversion
-- ,d.num_cupon
-- ,d.fecha_vcto_cupon
-- ,d.fecha_vcto
from		
			BacBonosExtSuda.dbo.text_ctr_inv as c with(nolock)
left join	BacBonosExtSuda.dbo.text_dsa	 as d with(nolock)
			on 
				c.cod_nemo		= d.cod_nemo
			and c.cod_familia	= d.Cod_familia
			and c.cod_familia	= 2000
			and c.cpnumucup >= d.num_cupon
where 
	c.cpnominal>0
and c.cpfecven >=@FECHA_PROC_FILTRO
union
-- cartera vigente (no seriada)
SELECT 
   c.cpnumdocu				as nro_operacion
  ,c.cpnumdocu				as nro_documento
  ,c.cpcorrelativo			as correlativo  
  ,c.cpfecven				as fec_vec_flujo --> deberia ser fecha de vencimiento por cartera y no por tb de desarrollo?..
  ,@FECHA_PROC_FILTRO		as fec_proceso
  ,c.cpnominal				as nominal
  ,c.cpvptirc				as valor_presente
  ,c.cod_familia
from		
			BacBonosExtSuda.dbo.text_ctr_inv as c with(nolock)						
where 
	c.cpnominal>0
and c.cpfecven >=@FECHA_PROC_FILTRO
and c.cod_familia=2001
union
select 
	 rs.rsnumoper			as nro_operacion
	,rs.rsnumdocu			as nro_documento
	,rs.rscorrelativo		as correlativo
	,rs.rsfecvcto			as fec_vec_flujo
	,rs.rsfecpro			as fec_proceso
	,rs.rsnominal			as nominal
	,rs.rsvppresen			as valor_presente --?
	,rs.cod_familia
from 
    BacBonosExtSuda.dbo.text_rsu as rs with(nolock)
where 
    rs.rsfecpro between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
    and rs.rstipoper = 'DEV'	
union
select 
	 mvt.monumoper			as nro_operacion
	,mvt.monumdocu			as nro_documento
	,mvt.mocorrelativo		as correlativo
	,mvt.mofecven			as fec_vec_flujo
	,mvt.mofecpro			as fec_proceso
	,mvt.monominal			as nominal
	,mvt.movpresen			as valor_presente
	,mvt.cod_familia
from 
    BacBonosExtSuda.dbo.text_mvt_dri as mvt with(nolock)
where         
    mvt.mofecpro between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO 
and mvt.motipoper in ('CP')
and mvt.mostatreg not in ('A','P','R')
--mvt.mofecpago between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
--and mvt.motipoper in ('CP','VP')
)
select distinct 
	nro_operacion
	,nro_documento
	,correlativo
	,fec_vec_flujo
	,@FECHA_PROC_FILTRO
	,nominal
	,valor_presente
	,3					as TPO_SALDO
	,'BEX'				as id_sistema
	, 0					as tipo_flujo
from CTE_PAGO_BONEX

/*
-- bonex = rf, codfamilia = 2001, CD -> nemo, sin desarrollo.
nemotecnico de bonex
text_dsa --> desarrollo, 
2000 -> son todos seriados.
*/
/*


select top 10000 * from 
BacBonosExtSuda.dbo.text_rsu

select distinct
     rs.rsnumoper
    ,rs.rsnumdocu
    ,rs.rscorrelativo
    ,'BEX'					as id_sistema
    ,null					as cod_subprodu    
	,rs.rsmonemi
    ,rs.rsrutcli
    ,rs.rscodcli
    ,rs.rsfecemis
    ,rs.rsfecvcto
    ,'VENC/CANC'			as status_v
    --,*
from 
    BacBonosExtSuda.dbo.text_rsu as rs with(nolock)
where 
    rs.rsfecpro between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
    and rs.rstipoper = 'DEV'
union
select distinct
     mvt.monumoper
    ,mvt.monumdocu
    ,mvt.mocorrelativo
    ,'BEX'						as id_sistema
    ,(case mvt.motipoper 
			when 'CP' then 'CPX' 
			when 'VP' then 'VPX'
			else '-1'
	   end) as cod_subprodu
    ,mvt.momonemi
    ,mvt.morutcli
    ,mvt.mocodcli
    ,mvt.mofecemi
    ,mvt.mofecven
    ,'VENC/CANC'		  as status_v
from 
    BacBonosExtSuda.dbo.text_mvt_dri as mvt with(nolock)
where         
    mvt.mofecpro between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
    --mvt.mofecpago between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
and mvt.motipoper in ('CP','VP')
and mvt.mostatreg not in ('A','P','R')



--select * from bacparamsuda.dbo.PRODUCTO
--where id_sistema='BEX'


select 
	top 10
* 
from 
    BacBonosExtSuda.dbo.text_rsu as rs with(nolock)

	*/


END
GO
