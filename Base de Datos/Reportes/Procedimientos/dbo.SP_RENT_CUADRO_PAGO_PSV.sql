USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENT_CUADRO_PAGO_PSV]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--SP_RENT_CUADRO_PAGO_PSV
CREATE PROCEDURE [dbo].[SP_RENT_CUADRO_PAGO_PSV]
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

IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (select top 1 Fecha_Proceso from MDParPasivo..DATOS_GENERALES WITH(NOLOCK)) 
END ELSE BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA
END
SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')


;WITH CTE_DATA_PSV 
AS
(
	select distinct
	 h.numero_operacion		as nro_operacion
	,0						as nro_documento
	,h.numero_correlativo	as correlativo	
	,h.fecha_vencimiento	as fec_vec_flujo
	,h.fecha_cartera		as fec_proceso
	,'C'					as tipo_operacion
	,h.nominal_pesos
	,h.valor_emision_pesos		
	,h.presente_emision
	,h.valor_emision_um
	,h.saldo_flujo_emision
	,h.valor_colocacion_clp
	,1					as codigo_producto
	,'venc'				as status
	from MDPasivo..CARTERA_PASIVO_HISTORICA as h with(nolock)
	inner join ( select numero_operacion from MDPasivo..CARTERA_PASIVO_HISTORICA with(nolock) 
				     where fecha_vencimiento between @fecha_ini_filtro and @fecha_proc_filtro ) as t1 
					 on t1.numero_operacion = h.numero_operacion
	union
	/* cartera vigente */
	select distinct	 
	 numero_operacion						as nro_operacion
	,0										as nro_documento
	,numero_correlativo						as correlativo	
	,fecha_vencimiento						as fec_vec_flujo
	,@FECHA_PROC_FILTRO						as fec_proceso
	,'C'									as tipo_operacion
	,nominal_pesos
	,valor_emision_pesos		
	,presente_emision
	,valor_emision_um
	,saldo_flujo_emision
	,valor_colocacion_clp
	,1					as codigo_producto
	,'vig'				as status
	from MDPasivo..CARTERA_PASIVO with(nolock)
)

	select distinct
	 nro_operacion			
	,nro_documento				as nro_documento
	,correlativo				as correlativo
	,fec_vec_flujo				
	,@FECHA_PROC_FILTRO			as fec_proceso
	,nominal_pesos				as sdo_amr_mon_origen
	,saldo_flujo_emision		as sdo_amr_mon_local
	,3							as tpo_sdo
	,'PSV'						as id_sistema
	,1							as t_flujo					
	from CTE_DATA_PSV

END
GO
