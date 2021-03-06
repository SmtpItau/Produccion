USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_RENT_CUADRO_PAGO_SWAP]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_RENT_CUADRO_PAGO_SWAP]
(
	@FECHA DATE = NULL
)
AS
BEGIN
SET NOCOUNT ON
SET DATEFORMAT YMD
/* 
	PROYECTO	: RENTABILIDAD
	DESCRIPCION	: INTERFAZ CUADRO PAGO, SWAP
	AUTOR		: RODRIGO SILVA RAMIREZ  
	FECHA		: 17-03-2017
*/

/*******************************************************
		DECLARACION DE VARIABLES
********************************************************/
DECLARE @FECHA_PROC_FILTRO	DATE
DECLARE @FECHA_INI_FILTRO	DATE
-- DECLARE @FECHA DATE
-- SET @FECHA='20160802'

IF @FECHA IS NULL BEGIN
	SET @FECHA_PROC_FILTRO = (SELECT TOP 1 FECHAPROC FROM BACSWAPSUDA.DBO.SWAPGENERAL WITH(NOLOCK)) 
END ELSE
BEGIN
	SET @FECHA_PROC_FILTRO = @FECHA --(SELECT TOP 1 FECHAPROC FROM BACSWAPSUDA.DBO.SWAPGENERAL WITH(NOLOCK)) 
END		
SET @FECHA_INI_FILTRO = CONVERT(DATE,CONVERT(VARCHAR,YEAR(@FECHA_PROC_FILTRO)) + '-' + CONVERT(VARCHAR,MONTH(@FECHA_PROC_FILTRO)) + '-01')


;WITH cuadro_pago
as
(
/* cartera vigente */
SELECT distinct
 numero_operacion	
,numero_flujo		
,tipo_swap
,tipo_flujo
,fecha_vence_flujo 
,compra_capital
,compra_saldo
,compra_amortiza
,venta_saldo
,venta_capital
,venta_amortiza
,(case tipo_swap
		when 1 then	 2 --'ST'
		when 2 then  1 --'SM'
		when 3 then  3 --'FR'
		when 4 then  3 --'SP'
end) as tpo_sdo_amrt
,estado
,estado_flujo
FROM 
	BacSwapSuda.dbo.CARTERARES	  WITH(NOLOCK)
where 
	Fecha_Proceso=@FECHA_PROC_FILTRO
and estado<>'C'
union
select distinct
 h.numero_operacion
,h.numero_flujo
,h.tipo_swap
,h.tipo_flujo
,h.fecha_vence_flujo 
,h.compra_capital
,h.compra_saldo
,h.compra_amortiza
,h.venta_saldo
,h.venta_capital
,h.venta_amortiza
,(case h.tipo_swap
		when 1 then	 2 --'ST'
		when 2 then  1 --'SM'
		when 3 then  3 --'FR'
		when 4 then  3 --'SP'
end) as tpo_sdo_amrt
,h.estado
,h.estado_flujo
from 
			BacSwapSuda.dbo.CarteraHis as h with(nolock)
inner join (select distinct numero_operacion
			from BacSwapSuda.dbo.carterares with(nolock)
			where estado<>'C'
			and Fecha_Proceso = @FECHA_PROC_FILTRO
			) as t
on h.numero_operacion = t.numero_operacion
)
select distinct
	 numero_operacion							as nro_operacion
	,null										as nro_dcto	
	,numero_flujo								as nro_correlativo
	,convert(date,fecha_vence_flujo)			as fec_vec_flujo
	,@fecha_proc_filtro							as fec_proceso
	,(case tipo_flujo
		when 1 then compra_saldo
		when 2 then venta_saldo
	  end)										as sdo_amrt_mon_origen
	 ,(case tipo_flujo
		when 1 then compra_amortiza
		when 2 then venta_amortiza
		end)									as sdo_amrt_mon_local
	,tpo_sdo_amrt
	,'PCS'										as id_sistema
	,tipo_flujo
from cuadro_pago
order by 
nro_operacion desc, nro_correlativo asc

END
GO
