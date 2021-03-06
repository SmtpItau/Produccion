USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENT_CUADRO_PAGO_FWD]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RENT_CUADRO_PAGO_FWD]
(
	@FECHA DATE = NULL
)
AS
BEGIN
SET NOCOUNT ON 
SET DATEFORMAT YMD


/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/
DECLARE @FECHA_PROC_FILTRO	DATE
DECLARE @FECHA_INI_FILTRO	DATE
--DECLARE @FECHA DATE
--SET @FECHA = '20160728'

IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 acfecproc FROM Bacfwdsuda.dbo.mfac WITH(NOLOCK)) 
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END
SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')

;WITH CTE_DATA_FWD
AS
(select distinct
	 
	 h.canumoper		as nro_operacion
	,null				as nro_documento
	,1					as correlativo	
	,h.cafecvcto		as fec_vec_flujo
	,h.cafecproc		as fec_proceso
	,h.catipoper		as tipo_operacion
	,h.camtomon1	
	,h.camtomon2	
	,h.var_moneda1
	,h.var_moneda2
	,h.cautilsaldo
	,h.caperdsaldo
	,h.cacodpos1  --> codigo producto
	,'venc'				as status
from 
			Bacfwdsuda.dbo.mfcah as h with(nolock)
inner join
	(
		select canumoper from Bacfwdsuda.dbo.mfcah with(nolock)
		where 
			cafecvcto between @fecha_ini_filtro and @fecha_proc_filtro
			and ltrim(rtrim(caestado)) not in('A','P')
	 ) as T1 
on h.canumoper = t1.canumoper
--order by h.canumoper desc
union
/* cartera vigente */
select distinct	 
	 canumoper								as nro_operacion
	,null									as nro_documento
	,(case 
		when caAntCorrela = 0 then 1
		when caAntCorrela is null then 1
		else caAntCorrela    
		end)								as correlativo
	,cafecvcto								as fec_vec_flujo
	,cafechaProceso							as fec_proceso
	,catipoper								as tipo_operacion			
	,camtomon1
	,camtomon2
	,var_moneda1
	,var_moneda2
	,cautilsaldo
	,caperdsaldo
	,cacodpos1  --> codigo producto
	,'vig'				as status
from Bacfwdsuda.dbo.mfcares with(nolock)
where CaFechaProceso = @FECHA_PROC_FILTRO
AND LTRIM(RTRIM(CAESTADO)) NOT IN ('A','P') --> A:anulado, P:pendiente
--order by canumoper desc
)
select distinct
	 nro_operacion			
	,nro_documento				as nro_documento
	,correlativo				as correlativo
	,fec_vec_flujo				
	,@FECHA_PROC_FILTRO			as fec_proceso
	,camtomon1					as sdo_amr_mon_origen
	,cautilsaldo				as sdo_amr_mon_local
	,3							as tpo_sdo
	,'BFW'						as id_sistema
	,1							as t_flujo					
from CTE_DATA_FWD
END
GO
