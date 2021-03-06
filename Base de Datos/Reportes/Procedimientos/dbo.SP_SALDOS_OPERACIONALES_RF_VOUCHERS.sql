USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDOS_OPERACIONALES_RF_VOUCHERS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_SALDOS_OPERACIONALES_RF_VOUCHERS]
(
	@FECHA DATE=NULL
	,@OPCION INT = 0
)
AS
BEGIN
/*
	INTERFAP SALDOS OPERACIONALES RENTA FIJA VOUCHERS
*/

SET NOCOUNT ON
SET DATEFORMAT YMD


IF OBJECT_ID('TEMPDB..##CARTERA_RF_VOUCHER') IS NOT NULL BEGIN	
	DROP TABLE ##CARTERA_RF_VOUCHER
END 

declare @fecha_proc_filtro date
declare @fecha_ini_filtro	date 


if @FECHA is null begin
	set @fecha_proc_filtro = (select top 1 acfecproc from BacTraderSuda.dbo.mdac with(nolock))
	set @fecha = @fecha_proc_filtro
end else begin
	set @fecha_proc_filtro = @fecha
end
set @fecha_ini_filtro = convert(date,convert(varchar,year(@fecha_proc_filtro)) + '-' + convert(varchar,month(@fecha_proc_filtro)) + '-01')

declare @fecha_aux			date
declare @fin_especial		bit = 'false'
declare @fin_semana			bit = 'false'

/********************************************************/
/* verificacion fin de mes especial y fecha				*/
/********************************************************/
--set @fecha_proc_filtro = '2017-07-31'

exec BacTraderSuda.dbo.SP_TRAENEXTHABIL @fecha_proc_filtro,6,@fecha_aux output

if datepart(weekday,@fecha_proc_filtro) in (6,1,7) begin
	set @fin_semana = 'true'	
end
if @fin_semana = 'true' begin
	if month(@fecha_proc_filtro)<>month(@fecha_aux) begin
		set @fin_especial = 'true'
	end 
end
-- verificacion. 
/*
select 
	(case @fin_semana when 'true' then 'true' else 'false' end) as [fin de semana],
	(case @fin_especial when 'true' then 'true' else 'false' end) as [fin de mes especial],
	datename(weekday,@fecha_proc_filtro) as [dia proceso],
	datename(weekday,@fecha_aux)	as [dia sig. habil]
*/


CREATE TABLE ##CARTERA_RF_VOUCHER
(		
/*A*/	numero_voucher_d				NUMERIC(10),			--NUMERIC(10),	
/*B*/	correlativo_d					NUMERIC(10),			--NUMERIC(10),	
/*C*/	cuenta							VARCHAR(20),			--VARCHAR(20),	
/*D*/	tipo_monto						VARCHAR(1),				--VARCHAR(10),	
/*E*/	monto							FLOAT,					--float,			
/*F*/	moneda							VARCHAR(6),				--VARCHAR(10),	
/*G*/	numero_voucher					NUMERIC(10),			--NUMERIC(10),	
/*H*/	fecha_ingreso					DATE,					--DATE,			
/*I*/	glosa							VARCHAR(70),			--VARCHAR(100),	
/*J*/	tipo_voucher					VARCHAR(1),				--VARCHAR(10),	
/*K*/	tipo_operacion					VARCHAR(5),				--VARCHAR(10),	
/*L*/	operacion						NUMERIC(10),			--NUMERIC(10),	
/*M*/	correlativo						NUMERIC(10),			--NUMERIC(10),	
/*N*/	instser							VARCHAR(12),			--VARCHAR(20),	
/*O*/	documento						numeric(10),				--VARCHAR(10),	
/*P*/	codigo_producto					VARCHAR(7),				--VARCHAR(10),	
/*Q*/	id_sistema						VARCHAR(3),				--VARCHAR(10),	
/*R*/	fpagoentre						VARCHAR(6),				--VARCHAR(10),	
/*S*/	fpago							VARCHAR(6),				--VARCHAR(10),	
/*T*/	plazo							NUMERIC(10),			--NUMERIC(10),	
/*U*/	condicion_pacto					VARCHAR(4),				--VARCHAR(10),	
/*V*/	clasificacion_cliente			VARCHAR(6),				--VARCHAR(10),	
/*W*/	fecha_ingreso_2					DATE,					--DATE,			
/*X*/	tipopero						VARCHAR(10) default(null),
/*Y*/	criterio						VARCHAR(20)				--VARCHAR(20)		

)

INSERT INTO ##CARTERA_RF_VOUCHER
SELECT			
/*A*/	BAC_CNT_DETALLE_VOUCHER.Numero_Voucher, 
/*B*/	BAC_CNT_DETALLE_VOUCHER.Correlativo, 
/*C*/	BAC_CNT_DETALLE_VOUCHER.Cuenta, 
/*D*/	BAC_CNT_DETALLE_VOUCHER.Tipo_Monto, 
/*E*/	BAC_CNT_DETALLE_VOUCHER.Monto, 
/*F*/	BAC_CNT_DETALLE_VOUCHER.moneda, 
/*G*/	BAC_CNT_VOUCHER.Numero_Voucher, 
/*H*/	BAC_CNT_VOUCHER.Fecha_Ingreso, 
/*I*/	BAC_CNT_VOUCHER.Glosa, 
/*J*/	BAC_CNT_VOUCHER.Tipo_Voucher, 
/*K*/	BAC_CNT_VOUCHER.Tipo_Operacion, 
/*L*/	BAC_CNT_VOUCHER.Operacion, 
/*M*/	BAC_CNT_VOUCHER.Correlativo, 
/*N*/	BAC_CNT_VOUCHER.instser, 
/*O*/	BAC_CNT_VOUCHER.Documento, 
/*P*/	BAC_CNT_VOUCHER.codigo_producto, 
/*Q*/	BAC_CNT_VOUCHER.id_sistema, 
/*R*/	BAC_CNT_VOUCHER.fpagoentre, 
/*S*/	BAC_CNT_VOUCHER.fpago, 
/*T*/	BAC_CNT_VOUCHER.plazo, 
/*U*/	BAC_CNT_VOUCHER.condicion_pacto, 
/*V*/	BAC_CNT_VOUCHER.clasificacion_cliente, 
/*W*/	BAC_CNT_VOUCHER.Fecha_Ingreso,
--/*X*/	null,
/*X*/	(case 
			when BAC_CNT_VOUCHER.Tipo_Operacion_Original = 'IB' then BAC_CNT_VOUCHER.codigo_producto
			when BAC_CNT_VOUCHER.Tipo_Operacion_Original = 'CG' and BAC_CNT_VOUCHER.Tipo_Operacion = 'TMCP' then 'CP'
			else BAC_CNT_VOUCHER.Tipo_Operacion_Original 
		 end),
/*Y*/	LTRIM(RTRIM(CONVERT(VARCHAR(20),BAC_CNT_DETALLE_VOUCHER.Cuenta))) + LTRIM(RTRIM(BAC_CNT_DETALLE_VOUCHER.Tipo_Monto))
FROM 
Reportes.dbo.cnt_aux_det_rentabilidad_rf	BAC_CNT_DETALLE_VOUCHER
,Reportes.dbo.cnt_aux_rentabilidad_rf		BAC_CNT_VOUCHER
--bactradersuda.dbo.BAC_CNT_DETALLE_VOUCHER BAC_CNT_DETALLE_VOUCHER, 
--bactradersuda.dbo.BAC_CNT_VOUCHER BAC_CNT_VOUCHER
WHERE 
BAC_CNT_VOUCHER.Numero_Voucher = BAC_CNT_DETALLE_VOUCHER.Numero_Voucher
AND	((BAC_CNT_VOUCHER.Fecha_Ingreso=@FECHA_PROC_FILTRO))

/*
update ##CARTERA_RF_VOUCHER
set tipopero = 
	case ltrim(rtrim(tipo_operacion))
		when 'TMCP' then 'CP'		--tasa mercado
		when 'DICO' then 'ICOL'		--devengo interfanfarrio colocacion
		when 'DICA' then 'ICAP'	    --devengo interfanfarrio captacion
		when 'RVPM' then 'VP'
		when 'RCPM' then 'CP'
		when 'DVCP' then 'CP'
		when 'DVCI' then 'CI'
		when 'DVVI' then 'VI'
		
		--- REVISAR...
		when 'GLIQ' then 'CP'
		when 'REVO' then 'CP'
		when 'GNPV' then 'CP'
		when 'VICO' then 'VI'
		WHEN 'RV'	then 'VP'
		when 'RC'	then 'CP'
		else ltrim(rtrim(tipo_operacion)) --'N#A'
    end	
*/




IF @OPCION<>0 BEGIN
	SELECT * FROM ##CARTERA_RF_VOUCHER
END
END
GO
