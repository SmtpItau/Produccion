USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDOS_OPERACIONALES_RF_NAC]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_SALDOS_OPERACIONALES_RF_NAC]
(
	@FECHA DATE=NULL
	,@OPCION INT = 0
)
AS
BEGIN
/*
	INTERFAP SALDOS OPERACIONALES RENTA FIJA NACIONAL Y GARANTIAS 
	RSILVA.
*/
SET NOCOUNT ON
SET DATEFORMAT YMD


IF OBJECT_ID('TEMPDB..##CARTERA_RF_NAC') IS NOT NULL BEGIN	
	DROP TABLE ##CARTERA_RF_NAC
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

CREATE TABLE ##CARTERA_RF_NAC
(
/*A*/	 	fecha_valorizacion			date
/*B*/	,	codigo_carterasuper			varchar(1)
/*C*/	,	rmnumdocu					numeric(10)
/*D*/	,	rmcorrela					numeric(10)
/*E*/	,	rut_emisor					numeric(10)
/*F*/	,	emnombre					varchar(100)
/*G*/	,	inserie						varchar(20)
/*H*/	,	rminstser					varchar(20)
/*I*/	,	mnnemo						varchar(5)
/*J*/	,	valor_nominal				numeric(19,4)
/*K*/	,	tasa_compra					numeric(19,4)
/*L*/	,	tasa_mercado				numeric(19,4)
/*M*/	,	rsvalcomp					numeric(19,4)
/*N*/	,	rsvppresen					numeric(19,4)
/*O*/	,	rsvppresenx					numeric(19,4)
/*P*/	,	rsinteres_acum				numeric(19,4)
/*Q*/	,	rsinteres					numeric(19,4)
/*R*/	,	rsreajuste_acum				numeric(19,4)
/*S*/	,	rsreajuste					numeric(19,4)
/*T*/	,	valor_mercado				numeric(19,4)
/*U*/	,	diferencia_mercado			numeric(19,4)
/*V*/	,	tmfecemi					date
/*W*/	,	tmfecven					date
/*X*/	,	emtipo						varchar(3)
/*Y*/	,	rsfecucup					date
/*Z*/	,	rsfecpcup					date
/*Z1*/	,	cod_nemo					numeric(10)
/*Z2*/	,	cod_subprodu				varchar(10)
/*Z3*/	,   origen						varchar(5)
----------------------------------------------------------------------
/*AA*/	,	valor_compra				numeric(19,4) default(0)
/*AB*/	,	valor_presente				numeric(19,4) default(0)
/*AC*/	,	interes_acum				numeric(19,4) default(0)
/*AD*/	,	reajuste_acum				numeric(19,4) default(0)
/*AE*/	,	filtro						varchar(100)  default null
/*AF*/	,	valido_vp					numeric(19,4) default(0)
/*AG*/	,	valido_vm					numeric(19,4) default(0)
/*AH*/	,	ajuste_compra				numeric(19,4) default(0)
/*AI*/	,	ajuste_interes				numeric(19,4) default(0)
)


INSERT INTO ##CARTERA_RF_NAC (
/*A*/	 	fecha_valorizacion		
/*B*/	,	codigo_carterasuper		
/*C*/	,	rmnumdocu				
/*D*/	,	rmcorrela				
/*E*/	,	rut_emisor				
/*F*/	,	emnombre				
/*G*/	,	inserie					
/*H*/	,	rminstser				
/*I*/	,	mnnemo					
/*J*/	,	valor_nominal			
/*K*/	,	tasa_compra				
/*L*/	,	tasa_mercado			
/*M*/	,	rsvalcomp				
/*N*/	,	rsvppresen				
/*O*/	,	rsvppresenx				
/*P*/	,	rsinteres_acum			
/*Q*/	,	rsinteres				
/*R*/	,	rsreajuste_acum			
/*S*/	,	rsreajuste				
/*T*/	,	valor_mercado			
/*U*/	,	diferencia_mercado		
/*V*/	,	tmfecemi				
/*W*/	,	tmfecven				
/*X*/	,	emtipo					
/*Y*/	,	rsfecucup				
/*Z*/	,	rsfecpcup				
/*Z1*/  ,	cod_nemo
/*Z2*/	,	cod_subprodu
/*Z3*/	,	origen
)
SELECT 
/*A*/  VALORIZACION_MERCADO.fecha_valorizacion
/*B*/  ,MDRS.codigo_carterasuper
/*C*/  ,VALORIZACION_MERCADO.rmnumdocu
/*D*/  ,VALORIZACION_MERCADO.rmcorrela
/*E*/  ,VALORIZACION_MERCADO.rut_emisor
/*F*/  ,VIEW_EMISOR.emnombre
/*G*/  ,VIEW_INSTRUMENTO.inserie
/*H*/  ,VALORIZACION_MERCADO.rminstser
/*I*/  ,VIEW_MONEDA.mnnemo
/*J*/  ,VALORIZACION_MERCADO.valor_nominal
/*K*/  ,VALORIZACION_MERCADO.tasa_compra
/*L*/  ,VALORIZACION_MERCADO.tasa_mercado
/*M*/  ,MDRS.rsvalcomp
/*N*/  ,MDRS.rsvppresen
/*O*/  ,MDRS.rsvppresenx
/*P*/  ,MDRS.rsinteres_acum
/*Q*/  ,MDRS.rsinteres
/*R*/  ,MDRS.rsreajuste_acum
/*S*/  ,MDRS.rsreajuste
/*T*/  ,VALORIZACION_MERCADO.valor_mercado
/*U*/  ,VALORIZACION_MERCADO.diferencia_mercado
/*V*/  ,VALORIZACION_MERCADO.tmfecemi
/*W*/  ,VALORIZACION_MERCADO.tmfecven
/*X*/  ,VIEW_EMISOR.emtipo
/*Y*/  ,MDRS.rsfecucup
/*Z*/  ,MDRS.rsfecpcup
/*Z1*/ ,VIEW_MONEDA.mncodmon
/*Z2*/ ,MDRS.rstipopero
/*Z3*/ ,'NAC'
FROM 
bactradersuda.dbo.MDRS MDRS,
bactradersuda.dbo.VALORIZACION_MERCADO VALORIZACION_MERCADO,
bactradersuda.dbo.VIEW_EMISOR VIEW_EMISOR,
bactradersuda.dbo.VIEW_INSTRUMENTO VIEW_INSTRUMENTO,
bactradersuda.dbo.VIEW_MONEDA VIEW_MONEDA
WHERE 
VALORIZACION_MERCADO.rmcodigo = VIEW_INSTRUMENTO.incodigo 
AND VALORIZACION_MERCADO.rut_emisor = VIEW_EMISOR.emrut 
AND VALORIZACION_MERCADO.moneda_emision = VIEW_MONEDA.mncodmon
AND VALORIZACION_MERCADO.rmnumdocu = MDRS.rsnumdocu 
AND MDRS.rsnumoper = VALORIZACION_MERCADO.rmnumoper 
AND VALORIZACION_MERCADO.rmcorrela = MDRS.rscorrela 
AND ((MDRS.rstipoper='dev') AND 
(VALORIZACION_MERCADO.fecha_valorizacion=@FECHA_PROC_FILTRO) AND
(VALORIZACION_MERCADO.id_sistema='BTR') AND
(MDRS.rsfecha=@FECHA_AUX) AND
(MDRS.rscartera Not In (115)) AND
(VALORIZACION_MERCADO.tipo_operacion<>'CG') OR (MDRS.rstipoper='dvp') AND
(VALORIZACION_MERCADO.fecha_valorizacion=@FECHA_PROC_FILTRO) AND
(VALORIZACION_MERCADO.id_sistema='BTR') AND
(MDRS.rsfecha=@FECHA_AUX) AND
(MDRS.rscartera Not In (115)))
--ORDER BY VALORIZACION_MERCADO.rmnumdocu asc
UNION
SELECT 
/*A*/		VALORIZACION_MERCADO.fecha_valorizacion
/*B*/	,	MDRS.codigo_carterasuper
/*C*/	,	VALORIZACION_MERCADO.rmnumdocu
/*D*/	,	VALORIZACION_MERCADO.rmcorrela
/*E*/	,	VALORIZACION_MERCADO.rut_emisor
/*F*/	,	VIEW_EMISOR.emnombre
/*G*/	,	VIEW_INSTRUMENTO.inserie
/*H*/	,	VALORIZACION_MERCADO.rminstser
/*I*/	,	VIEW_MONEDA.mnnemo
/*J*/	,	VALORIZACION_MERCADO.valor_nominal
/*K*/	,	VALORIZACION_MERCADO.tasa_compra
/*L*/	,	VALORIZACION_MERCADO.tasa_mercado
/*M*/	,	MDRS.rsvalcomp
/*N*/	,	MDRS.rsvppresen
/*O*/	,	MDRS.rsvppresenx
/*P*/	,	MDRS.rsinteres_acum
/*Q*/	,	MDRS.rsinteres
/*R*/	,	MDRS.rsreajuste_acum
/*S*/	,	MDRS.rsreajuste
/*T*/	,	VALORIZACION_MERCADO.valor_mercado
/*U*/	,	VALORIZACION_MERCADO.diferencia_mercado
/*V*/	,	VALORIZACION_MERCADO.tmfecemi
/*W*/	,	VALORIZACION_MERCADO.tmfecven
/*X*/	,	VIEW_EMISOR.emtipo
/*Y*/	,	MDRS.rsfecucup
/*Z*/	,	MDRS.rsfecpcup
/*Z1*/	,	VIEW_MONEDA.mncodmon
/*Z2*/	,	MDRS.rstipopero
/*Z3*/	,	'GRT'
FROM bactradersuda.dbo.MDRS MDRS
,	bactradersuda.dbo.VALORIZACION_MERCADO VALORIZACION_MERCADO
,	bactradersuda.dbo.VIEW_EMISOR VIEW_EMISOR
,	bactradersuda.dbo.VIEW_INSTRUMENTO VIEW_INSTRUMENTO
,	bactradersuda.dbo.VIEW_MONEDA VIEW_MONEDA
WHERE 
VALORIZACION_MERCADO.rmcodigo = VIEW_INSTRUMENTO.incodigo
AND	VALORIZACION_MERCADO.rut_emisor = VIEW_EMISOR.emrut
AND	VALORIZACION_MERCADO.moneda_emision = VIEW_MONEDA.mncodmon
AND	VALORIZACION_MERCADO.rmnumdocu = MDRS.rsnumdocu
AND	VALORIZACION_MERCADO.rmcorrela = MDRS.rscorrela
AND	VALORIZACION_MERCADO.rmnumoper = MDRS.rsnumoper
AND	((MDRS.RSTIPOPER='DEV')
AND	(VALORIZACION_MERCADO.fecha_valorizacion=@FECHA_PROC_FILTRO)
AND	(VALORIZACION_MERCADO.id_sistema='BTR')
AND	(MDRS.rsfecha=@FECHA_AUX)
AND	(MDRS.rscartera='159')
AND	(VALORIZACION_MERCADO.TIPO_OPERACION='CG') OR (MDRS.RSTIPOPER='DVP')
AND	(VALORIZACION_MERCADO.FECHA_VALORIZACION=@FECHA_PROC_FILTRO)
AND	(VALORIZACION_MERCADO.ID_SISTEMA='BTR')
AND	(MDRS.RSFECHA=@FECHA_AUX))
ORDER BY VALORIZACION_MERCADO.rmnumdocu


/*
 actualizacion de datos y generacion de filtro.
*/
declare @cartera		varchar(1)
declare @inserie		varchar(20)
declare @rut			numeric(10)
declare @emtipo			varchar(3)
declare @nemo			varchar(5)
declare @dif_mercado	numeric(19,4)
declare @aux_filter		varchar(200)
declare @num_docu		numeric(10)
declare @correlativo	numeric(10)

declare cur_cartera cursor 
for
select codigo_carterasuper,inserie,rut_emisor,emtipo,mnnemo,diferencia_mercado,rmnumdocu,rmcorrela
from ##CARTERA_RF_NAC

open cur_cartera 
fetch next from cur_cartera 
into @cartera,@inserie,@rut,@emtipo,@nemo,@dif_mercado,@num_docu,@correlativo
while @@FETCH_STATUS = 0 begin
	-- generacion de filtro	
	declare @sign varchar(1) 
	declare @body_filter varchar(100)
	set @sign = (case when @dif_mercado >=0 then '+' else '-' end)
	set @body_filter = 
		(case 
			when ltrim(rtrim(@inserie))='LCHR' then 
				(case when @rut = 97023000 then 'CORP' else  'OTROS' end)
			when ltrim(rtrim(@inserie))='BONOS' then
				(case when ltrim(rtrim(@emtipo)) = '2' then 'BCO' else 'EMP' end)
			else ''
		 end)
	
	set @aux_filter = ltrim(rtrim(@cartera)) + ltrim(rtrim(@inserie)) + ltrim(rtrim(@body_filter)) + ltrim(rtrim(@nemo)) + @sign+convert(varchar,@rut)
	

	-- actualizacion y relleno de datos.
	-- AH: ajuste_compra , AI=ajuste_interes
	update ##CARTERA_RF_NAC
	set 
		filtro = @aux_filter
		
		--AA = =M+AH
		,valor_compra = rsvalcomp + ajuste_compra

		--AB = si (fecha_valoriazion = fecha_cartera) => rsvppresenx : rsvppresen
		/* ,valor_presente = (case when @FECHA_VALORIZACION = @FECHA_PROC_FILTRO then rsvppresenx else rsvppresen end) */
		,valor_presente = 
			(case 
				when @fin_especial='true' and @fin_semana='true' then rsvppresenx
				when @fin_especial='false' and @fin_semana = 'true' then rsvppresenx
				else rsvppresen 
			end)

		
		-- AC=SI($B$1=$B$2;P5;(P5-Q5))+AI5
		/*,interes_acum = (case when @FECHA_VALORIZACION = @FECHA_PROC_FILTRO 
				then rsinteres_acum + ajuste_interes
				else (rsinteres_acum - rsinteres) + ajuste_interes end)
		*/
		,interes_acum = 
				(case 
					when @fin_especial ='true' and @fin_semana = 'true' then (rsinteres_acum - rsinteres) + ajuste_interes 
					when @fin_especial = 'false' and @fin_semana = 'true ' then (rsinteres_acum - rsinteres) + ajuste_interes 
					else rsinteres_acum + ajuste_interes
				 end)
		-- AD = +R5
		,reajuste_acum = 
			(case ltrim(rtrim(origen))
				when 'NAC' then rsreajuste_acum
				when 'GRT' then
					(
						case 
						when @fin_especial ='true' and @fin_semana = 'true'   then rsreajuste_acum
						when @fin_especial = 'false' and @fin_semana = 'true' then rsreajuste_acum
						else rsreajuste_acum -rsreajuste
						end
					)
				end)
		
		--AF =(AA+AC+AD)-AB
		,valido_vp = (valor_compra + interes_acum + reajuste_acum) - valor_presente	
		
		--AG =(AA+AC+AD+U)-T
		,valido_vm = (valor_compra + interes_acum + reajuste_acum + diferencia_mercado) - valor_mercado			
	where 
		rmnumdocu = @num_docu
	and rmcorrela = @correlativo
	and ltrim(rtrim(inserie)) = ltrim(rtrim(@inserie))
	
fetch next from cur_cartera 
into @cartera,@inserie,@rut,@emtipo,@nemo,@dif_mercado,@num_docu,@correlativo
end
close cur_cartera
deallocate cur_cartera


IF @OPCION<>0 BEGIN
	SELECT * FROM ##CARTERA_RF_NAC
END


END
GO
