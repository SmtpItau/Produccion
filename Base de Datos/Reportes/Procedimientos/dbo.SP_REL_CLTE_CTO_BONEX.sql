USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_REL_CLTE_CTO_BONEX]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_REL_CLTE_CTO_BONEX]
(
	@FECHA DATE = NULL	
)
AS 
BEGIN
	SET NOCOUNT ON
	SET DATEFORMAT YMD
/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: INTERFAZ RELACION CLIENTE CONTRATO, BONEX
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 23-03-2017
*/

/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/

DECLARE @FECHA_PROC_FILTRO DATE
DECLARE @FECHA_INI_FILTRO DATE
-- DECLARE @FECHA DATE
-- SET @FECHA = '2016-07-31'
IF @FECHA IS NULL BEGIN
    SET @FECHA_PROC_FILTRO = (select top 1 acfecproc from BacBonosExtSuda.dbo.text_arc_ctl_dri with(nolock))
END ELSE BEGIN
    SET @FECHA_PROC_FILTRO = @FECHA --(SELECT TOP 1 acfecproc FROM Bacfwdsuda.dbo.mfac WITH(NOLOCK))
END
SET @FECHA_INI_FILTRO = CONVERT(DATE, CONVERT(VARCHAR, YEAR(@FECHA_PROC_FILTRO))+'-'+CONVERT(VARCHAR, MONTH(@FECHA_PROC_FILTRO))+'-01')

/*******************************************************
		TABLA TEMPORAL CON RESULTADOS
********************************************************/

CREATE TABLE #TMP_RESULTADOS
(
	NUM_DOCUMENTO		NUMERIC(20, 0),
	NUM_OPERACION		NUMERIC(20, 0),
	NUM_CORRELATIVO		NUMERIC(20, 0),
	ID_SISTEMA			VARCHAR(5),
	COD_SUBPRODU		VARCHAR(15),
	MONEDA				NUMERIC(20, 0),
	RUTCLIENTE			NUMERIC(20, 0),
	COD_CLIENTE			NUMERIC(20, 0),
	FECHA_CONTRATO		DATE,
	FECHA_VENC			DATE,
	[STATUS]			VARCHAR(20) 
)

-- CARTERA VIGENTE
	insert into #tmp_resultados
	select	
			ca.cpnumdocu			as nro_operacion
		,	ca.cpnumdocu			as nro_documento
		,	ca.cpcorrelativo		as num_correlativo
		,	'BEX'				as id_sistema		
		,	'CPX'				as cod_subprodu		-- se asume CPX, tabla cartera... confirmar.
		,	ca.cpmonemi			as moneda			--> moneda emision
		,	ca.cprutcli			as rutcli 
		,	ca.cpcodcli			as cod_cliente
		,	ca.cpfecneg			as fecha_contrato
		,   ca.cpfecven			as fecha_venc
		,	'vigente'				as [status]			
	--	,	ca.cpnominal			
	--	,	ca.cpfecneg			--> fecha negociacion?
	--	,	ca.cpfecpago			--> fecha pago ?

	from	bacbonosextsuda.dbo.text_ctr_inv ca
	where	ca.cpnominal > 0
	and		ca.cpfecven	 > @FECHA_PROC_FILTRO	--( select acfecproc from text_arc_ctl_dri with(nolock))
	order 
	by		ca.cpnumdocu
		,	ca.cpcorrelativo
		,	ca.cpfecneg
		,	ca.cpfecpago



-- MOV. DE COMPRA
	insert into #tmp_resultados
	select	
			mv.monumoper			    as num_operacion
		,	mv.monumdocu			    as num_documento
		,	mv.mocorrelativo		    as correlatvio
		,	'BEX'				    as id_sistema
		--,	mv.motipoper			    as cod_subprodu
		,	'CPX'--mv.motipoper		    as cod_subprodu
		,	mv.momonemi			    as moneda
		--,	mv.mofecpro			    as fecha_proceso
		--,	mv.motipoper			    as tipo_operacion
		,	mv.morutcli			    as rutcliente
		,	mv.mocodcli			    as codigo_cliente
		,   mv.mofecneg			    as fecha_contrato
		,	mv.mofecven			    as fecha_venc
		,	'vigente'				    as [status]			--> se asume vigente.

	from	bacbonosextsuda.dbo.text_mvt_dri mv with(nolock)
	--where	mv.mofecpro	 between '20170101' and '20170430'
	where	mv.mofecpro	 between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
	and		mv.motipoper = 'CP'

	-- MOV DE VENTA
	insert into #tmp_resultados
	select
			mv.monumoper			    as num_operacion
		,	mv.monumdocu			    as num_documento
		,	mv.mocorrelativo		    as correlativo
		,	'BEX'				    as id_sistema
		,	'VPX'				    as cod_subprodu	
		--	mv.motipoper			    as cod_subprodu
		,	mv.momonemi			    as moneda
		,	mv.morutcli			    as rut_cliente
		,	mv.mocodcli			    as codigo_cliente
		,	mv.mofecneg			    as fecha_contrato
		,	mv.mofecven			    as fecha_venc
		,	'vigente'				    as [status]			--> se asume vigente
		--	mv.mofecpro
	from	bacbonosextsuda.dbo.text_mvt_dri mv with(nolock)
	--where	mv.mofecpro	 between '20170401' and '20170430'
	where	mv.mofecpro	 between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
	and		mv.motipoper = 'VP'


	--vencimiento instrumentos
	insert into #tmp_resultados
	select			
			num_operacion			 = tr.rsnumoper	
		,	num_documento			 = tr.rsnumdocu
		,	correlativo				 = tr.rscorrelativo
		,	id_sistema				 = 'BEX'
		--,	cod_subprodu			 = tr.rstipoper 	
		,	cod_subprodu			 = 'CPX'
		,	moneda					 = tr.rsmonemi
		,	rutcliente				 = tr.rsrutcli
		,	codigo_cliente			 = tr.rscodcli
		,	fecha_contrato			 = tr.rsfecneg
		,	fecha_venc				 = tr.rsfecvcto
		,	[status]				 = 'vencido'
		--,	Nominal					 = tr.rsnominal
		--,	Tipo					 = tr.rstipoper 			
	from	bacbonosextsuda.dbo.text_rsu tr		with(nolock)	
	--where	tr.rsfecvcto	 between '20170401' and '20170430'
	where	tr.rsfecvcto	 between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
	and		tr.rstipoper	= 'DEV'
	group
	by	
			tr.rsnumoper	
		,	tr.rsnumdocu
		,	tr.rscorrelativo
		--,	tr.rsnominal
		,	tr.rstipoper		
		,	tr.rsmonemi
		,	tr.rsrutcli
		,	tr.rscodcli
		,	tr.rsfecneg
		,	tr.rsfecvcto

	-- vencimiento cupones del mes
	insert into #tmp_resultados
 	select	
			num_operacion	  = tr.rsnumoper
		,	num_documento	  = tr.rsnumdocu
		,	correlativo	  = tr.rscorrelativo
		,	id_sistema	  = 'BEX'
		--,	cod_subprodu	  = tr.rstipoper
		,	cod_subprodu	  = 'CPX'
		,	moneda		  = tr.rsmonemi
		,	rutcliente	  = tr.rsrutcli
		,	codigo_cliente	  = tr.rscodcli
		,	fecha_venc	  = tr.rsfecucup	
		,	fecha_contrato	  = tr.rsfecneg
		,	[status]		  = 'vencido'
		--,	Nominal		  = tr.rsnominal
		--,	Tipo			  = tr.rstipoper
	from	bacbonosextsuda.dbo.text_rsu tr	with(nolock)
	where	tr.rsfecvcto between @FECHA_INI_FILTRO and @FECHA_PROC_FILTRO
	and		tr.rstipoper	= 'VCP'
	group
	by
			tr.rsnumoper
		,	tr.rsnumdocu
		,	tr.rscorrelativo
		--,	tr.rsnominal
		,	tr.rstipoper
		,	tr.rsmonemi
		,	tr.rsrutcli
		,	tr.rscodcli
		,	tr.rsfecucup
		,	tr.rsfecneg

	SELECT DISTINCT 
	NUM_DOCUMENTO,
	NUM_OPERACION,	
	NUM_CORRELATIVO,
	ID_SISTEMA,
	COD_SUBPRODU,
	MONEDA,
	RUTCLIENTE,
	COD_CLIENTE,		
	@FECHA_PROC_FILTRO	   AS FECHA_PROCESO,
	FECHA_CONTRATO,
	FECHA_VENC,
	[STATUS],
	0						AS TIPO_FLUJO	 
	FROM #TMP_RESULTADOS;

	DROP TABLE #TMP_RESULTADOS;
END
GO
