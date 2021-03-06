USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENT_CUADRO_PAGO_OPT]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_RENT_CUADRO_PAGO_OPT]
(
	@FECHA DATE = NULL
)
AS 
BEGIN
SET NOCOUNT ON
SET DATEFORMAT YMD

/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: INTERFAZ CUADRO PAGO, OPCIONES.
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 23-03-2017
*/

/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/

DECLARE @FECHA_PROC_FILTRO DATE
DECLARE @FECHA_INI_FILTRO DATE
--DECLARE @FECHA DATE
--SET @FECHA = '2016-07-31'
IF @FECHA IS NULL BEGIN
    SET @FECHA_PROC_FILTRO = (select top 1 fechaproc from CbMdbOpc.dbo.OpcionesGeneral   with(nolock))
END ELSE BEGIN
    SET @FECHA_PROC_FILTRO = @FECHA 
END
SET @FECHA_INI_FILTRO = CONVERT(DATE, CONVERT(VARCHAR, YEAR(@FECHA_PROC_FILTRO))+'-'+CONVERT(VARCHAR, MONTH(@FECHA_PROC_FILTRO))+'-01')


/*******************************************************
		EXTRACCION DE DATOS
********************************************************/
;with CTE_OPCIONES
AS
(
	--vigente y futuras
	select distinct
	 h.CaNumFolio			as nro_documento
	,h.CaNumContrato		as nro_operacion
	,d.CaNumEstructura		as correlativo
	,@FECHA_PROC_FILTRO		as fec_contable
	,d.CaFechaVcto			as fec_venc_flujo
	,d.CaMontoMon1			as sdo_amrt_mo
	,d.CaMontoMon2			as sdo_amrt_ml
	,3						as tpo_sdo_amrt
	,'OPT'					as id_sistema
	,'vig'					as status
	From 
				CbMdbOpc.dbo.CaResEncContrato	as H	with(nolock)
	inner join 	CbMdbOpc.dbo.CaResDetContrato	as D	with(nolock)
				on H.CaNumContrato	= D.CaNumContrato
				and ltrim(rtrim(H.CaEstado))='' 
				and H.CaEncFechaRespaldo = @FECHA_PROC_FILTRO
				and d.CaFechaVcto	>=@FECHA_PROC_FILTRO
	union
	select distinct * from 
	(
	-- cartera vencida
	select distinct
	 h.CaNumFolio			as nro_documento
	,h.CaNumContrato		as nro_operacion
	,d.CaNumEstructura		as correlativo
	,@FECHA_PROC_FILTRO		as fec_contable
	,d.CaFechaVcto			as fec_venc_flujo
	,d.CaMontoMon1			as sdo_amrt_mo
	,d.CaMontoMon2			as sdo_amrt_ml
	,3						as tpo_sdo_amrt
	,'OPT'					as id_sistema
	,'ven'					as status	
	from cbmdbopc.dbo.cavenenccontrato as h with(nolock)
		inner join cbmdbopc.dbo.cavendetcontrato as d with(nolock)
		on h.canumcontrato = d.canumcontrato
	where 
		d.cafechavcto between @fecha_ini_filtro and @fecha_proc_filtro
	and ltrim(rtrim(h.caestado))=''
	union
	-- cartera anticipada 
	SELECT DISTINCT 
		 th.MoNumFolio			as nro_documento
		,th.MoNumContrato		as nro_operacion
		,td.MoNumEstructura		as correlativo
		,@FECHA_PROC_FILTRO		as fec_contable
		,td.MoFechaVcto			as fec_venc_flujo
		,td.MoMontoMon1			as sdo_amrt_mo
		,td.MoMontoMon2			as sdo_amrt_ml
		,3						as tpo_sdo_amrt
		,'OPT'					as id_sistema
		,'ANT'					as status	
	FROM			cbmdbopc.dbo.mohisenccontrato as th with(nolock)	
		inner join	cbmdbopc.dbo.mohisdetcontrato as td with(nolock) 
		on th.monumfolio = td.monumfolio
	where 
		td.mofechavcto between @fecha_ini_filtro and @fecha_proc_filtro
	and th.motipotransaccion = 'ANTICIPA'
	) as cartera_cancelada
) 
select distinct 
nro_documento
,nro_operacion
,correlativo
,fec_venc_flujo
,fec_contable
,sdo_amrt_mo
,sdo_amrt_ml
,tpo_sdo_amrt
,id_sistema
,0				as tipo_flujo
from CTE_OPCIONES


/*
-- PARA APRENDIZAJE...
Select 
	oe.OpcEstCod
	,oe.OpcEstDsc
	,os.ConOpcEstDsc
	,s.Subyacente
	,s.SubyacenteDescripcion
	,bm.BenchMarkCod
	,bm.BenchMarkDescripcion
	,ot.OpcTipCod
	,ot.OpcTipDsc	
	,pt.PayOffTipCod
	,pt.PayOffTipDsc	
	,om.*	
	,h.*	
	,d.*
From 
			CbMdbOpc.dbo.CaResEncContrato	as H	with(nolock)
inner join 	CbMdbOpc.dbo.CaResDetContrato	as D	with(nolock)
			on H.CaNumContrato	= D.CaNumContrato
			and ltrim(rtrim(H.CaEstado))='' 
			and H.CaEncFechaRespaldo >= @FECHA_PROC_FILTRO
left join	CbMdbOpc.dbo.OpcionEstructura	as OE	with(nolock)
			on oe.OpcEstCod		= h.CaCodEstructura	
left join	CbMdbOpc.dbo.ConOpcEstado		as OS	with(nolock)
			on h.CaEstado		= os.ConOpcEstCod
left join   CbMdbOpc.dbo.Subyacente			as	S	with(nolock)
			on d.CaSubyacente	= s.Subyacente
left join	CbMdbOpc.dbo.BenchMark			as BM	with(nolock)
			on d.CaBenchComp	= bm.BenchMarkCod
left join	CbMdbOpc.dbo.OpcionTipo			as OT	with(nolock)
			on d.CaTipoOpc		= ot.OpcTipCod
left join	CbMdbOpc.dbo.PayOffTipo			as PT	with(nolock)
			on d.CaTipoPayOff	= pt.PayOffTipCod
left join	CbMdbOpc.dbo.OpcionParMonedas	as OM	with(nolock)
			on d.CaParStrike	= om.OpcParMdaCod
*/
END
GO
