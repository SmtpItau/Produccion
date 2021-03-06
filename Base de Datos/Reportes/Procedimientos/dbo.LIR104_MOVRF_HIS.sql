USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[LIR104_MOVRF_HIS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--LIR104_MOVRF_HIS '20190101','20190831'
CREATE PROCEDURE [dbo].[LIR104_MOVRF_HIS](	@FECHA1	DATETIME,	@FECHA2	DATETIME )
AS 

BEGIN			
SET NOCOUNT ON

	DECLARE @FECHA_proc	DATETIME
	DECLARE @FECHA_prox	DATETIME
	DECLARE @FECHA_cal	DATETIME
	DECLARE @Tipo_proc	varchar(8)
	
	select @FECHA_proc=acfecproc,@FECHA_prox=acfecprox from BacTraderSuda.dbo.mdac with(nolock)
	
	set @FECHA_cal=DATEADD(day,1,@FECHA_proc)

	if @FECHA_prox=@FECHA_cal
	begin
		set @Tipo_proc='normal'
	end	
	else
	begin
		if 	month(@FECHA_prox)=month(@FECHA_cal) and month(@FECHA_prox)=month(@FECHA_proc)
		begin
			set @Tipo_proc='normal'
		end	
		if month(@FECHA_prox)<>month(@FECHA_cal)
		begin
			set @Tipo_proc='especial'
		end
	end		


CREATE TABLE #SALIDA  
	(	FECHA_OPERACION				DATETIME
	,	CODIGO_OPERACION			VARCHAR(10)
	,	GLOSA_CODIGO_OPERACION		VARCHAR(50)
	,	NEMOTECNICO					VARCHAR(30)
	,	TIPO						VARCHAR(10)
	,	FECHA_EMISION				DATETIME
	,	SERIE						VARCHAR(20)
	,	FOLIO_OPERACION				NUMERIC(9)
	,	VALOR_OPERACION_MO			NUMERIC(21,4)
	,	VALOR_OPERACION_CLP			NUMERIC(21,4)	
	,	CAPITAL_MO					NUMERIC(21,4)
	,	INTERESESMO					NUMERIC(21,4)
	,	FECHA_COMPRA				DATETIME
	,	FOLIO_COMPRA				NUMERIC(9)
	,	VALORCOMPRAMO				NUMERIC(21,4)
	,	VALORCOMPRA_CLP				NUMERIC(21,4)
	,	INTERES_CLP					NUMERIC(21,4)
	,	REAJUSTE					NUMERIC(21,4)
	,	CTACONTABLEINVERSION		VARCHAR(20)
	,	CTACONTABLEINTERES			VARCHAR(20)
	,	CTACONTABLEREAJUSTE			VARCHAR(20)
	,	CTACONTABLERESULTADO		VARCHAR(20)	
	,	CANTIDADDIAS				NUMERIC(9))
--	,	CodigoInst					NUMERIC(9)
--	,	Correla						NUMERIC(9))


CREATE TABLE ##CARTERA_RF_NAC
(
/*A*/	 	fecha_valorizacion			date
/*B*/	,	codigo_carterasuper			varchar(1)
/*C*/	,	rmnumoper					numeric(10)
/*C*/	,	rmnumdocu					numeric(10)
/*D*/	,	rmcorrela					numeric(10)
/*E*/	,	rut_emisor					numeric(10)
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
        ,   rsfeccomp					date
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
/*AI*/	,	cant_dias					numeric(9) default(0)
)


CREATE TABLE ##CARTERA_RF_PACTOS
(
		idreg				int identity (1,1),
		rstipopero			varchar(5),
		cod_nemo			int,
		rscorrela			int,			
/*A*/	rsfecha				date,
/*B*/	rsfecinip			date,
/*C*/	rsrutcli			numeric(10),
/*E*/	rsnumoper			numeric(10),
/*F*/	rsnumdocu			numeric(10),
/*G*/	mnnemo				varchar(5),
/*H*/	inserie				varchar(20),
/*I*/	rsutemis			numeric(10),
/*J*/	rsinstser			varchar(20),
/*K*/	nominal 			numeric(19,4),
/*L*/	rsvalinip			numeric(19,4),
/*M*/	rstaspact			numeric(19,4),
/*N*/	rsfecvtop			date,
/*O*/	rscartera			varchar(10),
/*P*/	cltipcli			numeric(5),
/*Q*/	DIAS				numeric(5),
/*R*/	DEVENGO				numeric(19,4),
/*S*/	Considerar			VARCHAR(1),
/*T*/	cli					VARCHAR(1),
/*U*/	Filtro				VARCHAR(20),
	    cant_dias			numeric(09),
)

CREATE TABLE ##CARTERA_RF_ICOL_TRD
(
		rsnumoper			numeric,
		rsnumdocu			numeric,
		rscorrela			numeric,
		rstipopero			varchar(5),
		cod_nemo			numeric,
		tipo				varchar(10),
/*E*/	serie				varchar(20),
/*F*/	nemo				varchar(10),
/*G*/	rsvppresen			numeric(19,4),
/*H*/	rsfecinip			date,
/*I*/	rstasemi			numeric(19,4),
/*J*/	rsbasemi			numeric(19,4),
/*K*/	ds_corridos		    numeric(19,4) default (0),
/*L*/	interes_acum		numeric(19,4) default (0),
		cant_dias			numeric(09) default (0),
)

CREATE TABLE ##CARTERA_RF_ICOL
(
		rsnumoper			numeric,
		rsnumdocu			numeric,
		rscorrela			numeric,
		rstipopero			varchar(5),
		cod_nemo			numeric,
		tipo				varchar(10),
/*N*/	serie				varchar(20),
/*O*/	nemo				varchar(10),
/*P*/	rsfecinip			date,
/*Q*/	rsvalcomp			numeric(19,4),
/*R*/	rstasemi			numeric(19,4),
/*S*/	rsbasemi			numeric(19,4),
/*T*/	ds_corridos		    numeric(19,4) default (0),
/*U*/	interes_acum		numeric(19,4) default (0),
/*V*/	criterio			varchar(100),
		cant_dias			numeric(09) default (0)
)

CREATE TABLE ##CARTERA_RF_ICAP_BE
(
		rsnumoper			numeric,
		rsnumdocu			numeric,
		rscorrela			numeric,
		rstipopero			varchar(5),
		cod_nemo			numeric,
		tipo				varchar(10),
	
/*X*/	serie				varchar(20),
/*Y*/	nemo				varchar(5),
/*Z*/	rsvalcomp			numeric(19,4),
/*AA*/	rsvppresen			numeric(19,4),
/*AB*/	rsfecinip			date,
/*AC*/	rstasemi			numeric(19,4),
/*AD*/	rsbasemi			numeric(19,4),
/*AE*/	ds_corridos		    numeric(19,4) default (0),
/*AF*/	interes_acum		numeric(19,4) default (0),
/*AG*/	criterio			varchar(100),
		cant_dias			numeric(09) default (0)
)

CREATE TABLE ##CARTERA_RF_ICAP
(
		rsnumoper			numeric,
		rsnumdocu			numeric,
		rscorrela			numeric,
		rstipopero			varchar(5),
		cod_nemo			numeric,
		tipo				varchar(10),
	
/*AI*/	serie				varchar(20),
/*AJ*/	nemo				varchar(5),
/*AK*/	rsfecinip			date,

/*AL*/	rsvalcomp			numeric(19,4),
/*AM*/	rsvppresen			numeric(19,4),
/*AN*/	rstir				numeric(19,4),

/*AO*/	rsbasemi			numeric(19,4),
/*AP*/	rsreajuste_acumcp	numeric(19,4),
/*AQ*/	ds_corridos		    numeric(19,4) default (0),

/*AR*/	ints				numeric(19,4) default (0),
/*AS*/	criteriop			varchar(100),
/*AT*/	criterio2			varchar(100),
		cant_dias			numeric(09) default (0)
)


CREATE TABLE ##CARTERA_RF_RDBCCH
(
		rsnumoper			numeric,
		rsnumdocu			numeric,
		rscorrela			numeric,
		rstipopero			varchar(5),
		cod_nemo			numeric,
		tipo				varchar(10),
		rsfecinip			date,
/*AV*/	serie				varchar(20),
/*AW*/	nemo				varchar(5),
/*AX*/	rsvalcomp			numeric(19,4),
/*AY*/	rsinteres			numeric(19,4),
/*AZ*/	rsinteres_acum		numeric(19,4),
/*BA*/	rsreajuste			numeric(19,4),
/*BB*/	rsreajuste_acum		numeric(19,4),
		cant_dias			numeric(09) default (0)
)

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
/*Y*/	criterio						VARCHAR(20),				--VARCHAR(20)		
		cant_dias			numeric(09) default (0)
)

/*******************************************************
		EXTRACCION DE DATOS 
********************************************************/
CREATE TABLE ##TMP_RESULTADO_RF 
(
 NRO_OPERACION			NUMERIC(20)		DEFAULT(0)
,NRO_DOCUMENTO			NUMERIC(20)
,NRO_CORRELATIVO		NUMERIC(20)
,SERIE		          	VARCHAR(30)		
,INSTRUMENTO          	VARCHAR(30)		
,VALOR_COMPRA	       	NUMERIC(20,4)	
,VALOR_PRESENTE	       	NUMERIC(20,4)	
,FEC_COMP				DATE
,FEC_EMI				DATE
,COD_CTA_CONT          	VARCHAR(20)		
,COD_DIVISA            	VARCHAR(10)		
,FEC_DATA              	DATE			
,COD_ENTIDAD           	VARCHAR(4)		DEFAULT('1769')
,COD_PRODUCTO          	VARCHAR(4)		DEFAULT('BTR')
,COD_SUBPRODU          	VARCHAR(4)		
,IMP_SDO_CONT_MO       	NUMERIC(20,4)	
,IMP_SDO_CONT_ML       	NUMERIC(20,4)	
,CANT_DIAS       		NUMERIC(09)	
,CONTABILIZAR			VARCHAR(30)
)


/*******************************************************
--PROCESO PROCESO
********************************************************/

--CARGA RENTA FIJA NACIONAL

INSERT INTO ##CARTERA_RF_NAC (
/*A*/	 	fecha_valorizacion		
/*B*/	,	codigo_carterasuper		
		,   rmnumoper
/*C*/	,	rmnumdocu				
/*D*/	,	rmcorrela				
/*E*/	,	rut_emisor				
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
        ,   rsfeccomp
/*V*/	,	tmfecemi				
/*W*/	,	tmfecven				
/*X*/	,	emtipo					
/*Y*/	,	rsfecucup				
/*Z*/	,	rsfecpcup				
/*Z1*/  ,	cod_nemo
/*Z2*/	,	cod_subprodu
/*Z3*/	,	origen
		,	cant_dias
)
SELECT 
/*A*/  v.fecha_valorizacion
/*B*/  ,r.codigo_carterasuper
	   ,v.rmnumoper
/*C*/  ,v.rmnumdocu
/*D*/  ,v.rmcorrela
/*E*/  ,v.rut_emisor
/*G*/  ,i.inserie
/*H*/  ,v.rminstser
/*I*/  ,m.mnnemo
/*J*/  ,v.valor_nominal
/*K*/  ,v.tasa_compra
/*L*/  ,v.tasa_mercado
/*M*/  ,r.rsvalcomp
/*N*/  ,r.rsvppresen
/*O*/  ,r.rsvppresenx
/*P*/  ,r.rsinteres_acum
/*Q*/  ,r.rsinteres
/*R*/  ,r.rsreajuste_acum
/*S*/  ,r.rsreajuste
/*T*/  ,v.valor_mercado
/*U*/  ,v.diferencia_mercado
	   ,r.rsfeccomp
/*V*/  ,v.tmfecemi
/*W*/  ,v.tmfecven
/*X*/  ,e.emtipo
/*Y*/  ,r.rsfecucup
/*Z*/  ,r.rsfecpcup
/*Z1*/ ,m.mncodmon
/*Z2*/ ,r.rstipopero
/*Z3*/ ,'NAC'
	   ,DATEDIFF(day,r.rsfecha,bactradersuda.dbo.Fx_Buscar_Fecha_Habil(r.rsfecha,1,6))
FROM	bactradersuda.dbo.MDRS r
INNER JOIN bactradersuda.dbo.VALORIZACION_MERCADO v on v.rmnumdocu = r.rsnumdocu and v.rmnumoper = r.rsnumoper and v.rmcorrela = r.rscorrela 
                                                    AND v.id_sistema='BTR' and v.fecha_valorizacion=r.rsfecha
inner join bactradersuda.dbo.VIEW_EMISOR e on e.emrut = v.rut_emisor 
inner join bactradersuda.dbo.VIEW_INSTRUMENTO i on i.incodigo = v.rmcodigo
inner join bactradersuda.dbo.VIEW_MONEDA m on m.mncodmon = v.moneda_emision 
WHERE r.rsfecha BETWEEN @FECHA1 AND @FECHA2
AND r.rsrutcart=97023000
and r.rstipoper='DEV'
and r.rscartera Not In (115,159)

UNION
SELECT 
/*A*/		v.fecha_valorizacion
/*B*/	,	r.codigo_carterasuper
        ,   v.rmnumoper
/*C*/	,	v.rmnumdocu
/*D*/	,	v.rmcorrela
/*E*/	,	v.rut_emisor
/*G*/	,	i.inserie
/*H*/	,	v.rminstser
/*I*/	,	m.mnnemo
/*J*/	,	v.valor_nominal
/*K*/	,	v.tasa_compra
/*L*/	,	v.tasa_mercado
/*M*/	,	r.rsvalcomp
/*N*/	,	r.rsvppresen
/*O*/	,	r.rsvppresenx
/*P*/	,	r.rsinteres_acum
/*Q*/	,	r.rsinteres
/*R*/	,	r.rsreajuste_acum
/*S*/	,	r.rsreajuste
/*T*/	,	v.valor_mercado
/*U*/	,	v.diferencia_mercado
	    ,   r.rsfeccomp
/*V*/	,	v.tmfecemi
/*W*/	,	v.tmfecven
/*X*/   ,   e.emtipo
/*Y*/	,	r.rsfecucup
/*Z*/	,	r.rsfecpcup
/*Z1*/	,	m.mncodmon
/*Z2*/	,	r.rstipopero
/*Z3*/	,	'GRT'
	    ,    DATEDIFF(day,r.rsfecha,bactradersuda.dbo.Fx_Buscar_Fecha_Habil(r.rsfecha,1,6))
FROM	bactradersuda.dbo.MDRS r
INNER JOIN bactradersuda.dbo.VALORIZACION_MERCADO v on v.rmnumdocu = r.rsnumdocu and v.rmnumoper = r.rsnumoper and v.rmcorrela = r.rscorrela 
                                                    AND v.id_sistema='BTR' and v.fecha_valorizacion=r.rsfecha
inner join bactradersuda.dbo.VIEW_EMISOR e on e.emrut = v.rut_emisor 
inner join bactradersuda.dbo.VIEW_INSTRUMENTO i on i.incodigo = v.rmcodigo
inner join bactradersuda.dbo.VIEW_MONEDA m on m.mncodmon = v.moneda_emision 
WHERE r.rsfecha BETWEEN @FECHA1 AND @FECHA2
AND r.rsrutcart=97023000
and r.rstipoper='DEV'
and r.rscartera=159


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
				when @Tipo_proc='especial' then rsvppresenx
				else rsvppresen 
			end)
		
		-- AC=SI($B$1=$B$2;P5;(P5-Q5))+AI5
		/*,interes_acum = (case when @FECHA_VALORIZACION = @FECHA_PROC_FILTRO 
				then rsinteres_acum + ajuste_interes
				else (rsinteres_acum - rsinteres) + ajuste_interes end)
		*/
		,interes_acum = 
				(case 
					when @Tipo_proc='especial' then (rsinteres_acum - rsinteres) + ajuste_interes 
					else rsinteres_acum + ajuste_interes
				 end)
		-- AD = +R5
		,reajuste_acum = 
			(case ltrim(rtrim(origen))
				when 'NAC' then rsreajuste_acum
				when 'GRT' then
					(
						case 
						when @Tipo_proc='especial'  then rsreajuste_acum
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


INSERT INTO ##CARTERA_RF_PACTOS
SELECT 
		r.rstipopero,
		m.mncodmon,
		r.rscorrela,
/*A*/	r.rsfecha, 
/*B*/	r.rsfecinip, 
/*C*/	r.rsrutcli, 
/*E*/	r.rsnumoper, 
/*F*/	r.rsnumdocu, 
/*G*/	m.mnnemo, 
/*H*/	i.inserie, 
/*I*/	r.rsrutemis, 
/*J*/	r.rsinstser, 
/*K*/	r.rsnominal, 
/*L*/	r.rsvalinip, 
/*M*/	r.rstaspact, 
/*N*/	r.rsfecvtop, 
/*O*/	r.rscartera, 
/*P*/	c.Cltipcli,
/*Q*/	datediff(DD,r.rsfecinip,@FECHA2),
/*R*/	(r.rsvalinip*(r.rstaspact/100)/360*(datediff(DD,r.rsfecinip,@FECHA2)))		,
/*S*/	(case 
				when r.rsfecvtop>@FECHA2 then 'c'
				else 'v'
		  end),
/*T*/	(case 
			when c.cltipcli>2 then 't'
			else 'f'
		end),
/*U*/	null,
	    DATEDIFF(day,r.rsfecha,bactradersuda.dbo.Fx_Buscar_Fecha_Habil(r.rsfecha,1,6))
FROM bactradersuda.dbo.MDRS r
inner join bactradersuda.dbo.VIEW_CLIENTE c on c.Clrut=r.rsrutcli and c.Clcodigo=r.rscodcli
inner join bactradersuda.dbo.VIEW_INSTRUMENTO i on i.incodigo=r.rscodigo 
inner join bactradersuda.dbo.VIEW_MONEDA m on m.mncodmon=r.rsmonpact
WHERE r.rsfecha BETWEEN @FECHA1 AND @FECHA2
AND	r.rstipoper='DEV'
AND r.rscartera In ('112','115')
AND	r.rsrutcli<>97029000
ORDER BY r.rsinstser


declare @idreg		int
declare @rscartera	varchar(5)
declare @mnemo		varchar(5)
declare @considerar varchar(1)
declare @cli		varchar(1)

declare cur_cartera cursor for

select idreg,inserie,rscartera,mnnemo,considerar,cli from ##CARTERA_RF_PACTOS

open cur_cartera
fetch next from cur_cartera
into @idreg,@inserie,@rscartera,@mnemo,@considerar,@cli 
while @@fetch_status = 0 begin
	declare 
	 @aux_01 varchar(100)
	,@aux_02 varchar(100)
	,@aux_03 varchar(100)
	,@filter varchar(100)
	--  ;(O&G&S&T&H)
	set @aux_01 = 
		ltrim(rtrim(@rscartera)) + 
		ltrim(rtrim(@mnemo)) + 
		ltrim(rtrim(@considerar)) + 
		ltrim(rtrim(@cli)) + 
		ltrim(rtrim(@inserie))

	set @aux_02 = 
		ltrim(rtrim(@rscartera)) + 
		ltrim(rtrim(@mnemo)) + 
		ltrim(rtrim(@considerar)) + 
		ltrim(rtrim(@cli))  

--=SI(O="115";(O&G&S&T&SI(H="BONOS";"EncajeBonos";SI(H="DPR";"EncajeBonos";SI(H="PDBC";"BC";H))));(O&G&S&T&H))
--O rscartera
--G mnnemo
--S considerar
--T cli
--H inserie

	set @aux_03 = 
		(case @inserie 
			when 'BONOS' then 'EncajeBonos'
			when 'DPR'	 then 'EncajeBonos'
			when 'PDBC'	 then 'BC'
			else @inserie
		 end)
	set @filter = 
		case when @rscartera = '115' then @aux_02 + @aux_03
		else @aux_01
		end
	update ##CARTERA_RF_PACTOS
	set Filtro = @filter
	where idreg = @idreg

	fetch next from cur_cartera
	into @idreg,@inserie,@rscartera,@mnemo,@considerar,@cli 
end
close cur_cartera
deallocate cur_cartera


create index idx_001_pactos on ##CARTERA_RF_PACTOS (rstipopero,rsrutcli,rsnumoper,rsnumdocu,inserie,rsinstser)


/*COLOCACIONES TRADING*/
/* e-j */
INSERT INTO ##CARTERA_RF_ICOL_TRD
SELECT	r.rsnumoper					-- ajuste de campos para temporal
,		r.rsnumdocu					-- ajuste de campos para temporal
,		r.rscorrela					-- ajuste de campos para temporal
,		r.rstipopero				-- ajuste de campos para temporal
,		m.mncodmon					-- ajuste de campos para temporal
,		'ICOL'						-- ajuste de campos para temporal
,/*E*/	i.inserie 
,/*F*/	m.mnnemo 
,/*G*/	r.rsvppresen 
,/*H*/	r.rsfecinip 
,/*I*/	r.rstasemi 
,/*J*/	r.rsbasemi
,/*K*/  datediff(dd,@fecha1,r.rsfecinip)
,/*L*/	rsvppresen*rstasemi/100/rsbasemi*datediff(dd,@fecha1,r.rsfecinip)
,	    DATEDIFF(day,r.rsfecha,bactradersuda.dbo.Fx_Buscar_Fecha_Habil(r.rsfecha,1,6))
FROM bactradersuda.dbo.MDRS r
inner join bactradersuda.dbo.VIEW_INSTRUMENTO i on i.incodigo=r.rscodigo and i.inserie='ICOL'
inner join bactradersuda.dbo.VIEW_MONEDA m on m.mncodmon=r.rsmonemi
WHERE r.rsfecha BETWEEN @FECHA1 AND @FECHA2
AND	r.rstipoper='DEV'
AND	r.rscartera='121'
AND	r.codigo_carterasuper='T'


/* N-V*/
/*COLOCACION INTERFANCARIAS*/
INSERT INTO ##CARTERA_RF_ICOL
SELECT	r.rsnumoper					-- ajuste de campos para temporal
,		r.rsnumdocu					-- ajuste de campos para temporal
,		r.rscorrela					-- ajuste de campos para temporal
,		r.rstipopero				-- ajuste de campos para temporal
,		m.mncodmon					-- ajuste de campos para temporal
,		'ICOL'						-- ajuste de campos para temporal
,/*N*/	i.inserie
,/*O*/	m.mnnemo
,/*P*/	r.rsfecinip
,/*Q*/	r.rsvalcomp
,/*R*/	r.rstasemi
,/*S*/	r.rsbasemi
,/*T*/	datediff(dd,@fecha1,r.rsfecinip)
,/*U*/	r.rsvalcomp*r.rstasemi/100/r.rsbasemi*datediff(dd,@fecha1,r.rsfecinip)
,/*V*/	ltrim(rtrim(i.inserie))+ltrim(rtrim(m.mnnemo))
,	    DATEDIFF(day,r.rsfecha,bactradersuda.dbo.Fx_Buscar_Fecha_Habil(r.rsfecha,1,6))
FROM bactradersuda.dbo.MDRS r
inner join bactradersuda.dbo.VIEW_INSTRUMENTO i on i.incodigo=r.rscodigo and i.inserie='ICOL'
inner join bactradersuda.dbo.VIEW_MONEDA m on m.mncodmon=r.rsmonemi
WHERE r.rsfecha BETWEEN @FECHA1 AND @FECHA2
AND	r.rstipoper='DEV'
AND	r.rscartera='121'
AND	r.codigo_carterasuper='P'

/*X-AD*/
INSERT INTO ##CARTERA_RF_ICAP_BE
SELECT	r.rsnumoper					-- ajuste de campos para temporal
,		r.rsnumdocu					-- ajuste de campos para temporal
,		r.rscorrela					-- ajuste de campos para temporal
,		r.rstipopero				-- ajuste de campos para temporal
,		m.mncodmon					-- ajuste de campos para temporal
,		'ICAP'						-- ajuste de campos para temporal
,/*X*/	i.inserie 
,/*Y*/	m.mnnemo 
,/*Z*/	r.rsvalcomp 
,/*AA*/	r.rsvppresen 
,/*AB*/	r.rsfecinip 
,/*AC*/	r.rstasemi 
,/*AD*/	r.rsbasemi
,/*AE*/	datediff(dd,@fecha1,r.rsfecinip)
,/*AF*/	r.rsvalcomp*r.rstasemi/100/r.rsbasemi*datediff(dd,@fecha1,r.rsfecinip)
,/*AG*/	ltrim(rtrim(i.inserie))+ltrim(rtrim(m.mnnemo))
,	    DATEDIFF(day,r.rsfecha,bactradersuda.dbo.Fx_Buscar_Fecha_Habil(r.rsfecha,1,6))
FROM bactradersuda.dbo.MDRS r
inner join bactradersuda.dbo.VIEW_INSTRUMENTO i on i.incodigo=r.rscodigo and i.inserie='ICAP'
inner join bactradersuda.dbo.VIEW_MONEDA m on m.mncodmon=r.rsmonemi
WHERE r.rsfecha BETWEEN @FECHA1 AND @FECHA2
AND	r.rstipoper='DEV'
AND	r.rscartera='121'
--AND	r.codigo_carterasuper='P'
AND	r.rsrutcli=97030000


/* CAPTACIONES INTERBANCARIAS AI-AP*/
INSERT INTO ##CARTERA_RF_ICAP
SELECT	r.rsnumoper					-- ajuste de campos para temporal
,		r.rsnumdocu					-- ajuste de campos para temporal
,		r.rscorrela					-- ajuste de campos para temporal
,		r.rstipopero				-- ajuste de campos para temporal
,		m.mncodmon					-- ajuste de campos para temporal
,		'ICAP'						-- ajuste de campos para temporal
,/*AI*/	i.inserie 
,/*AJ*/	m.mnnemo 
,/*AK*/	r.rsfecinip 
,/*AL*/	r.rsvalcomp 
,/*AM*/	r.rsvppresen 
,/*AN*/	r.rstir 
,/*AO*/	r.rsbasemi 
,/*AP*/	r.rsreajuste_acumcp
,/*AQ*/	datediff(dd,@fecha1,r.rsfecinip)
,/*AR*/	r.rsvalcomp*r.rstir/100/r.rsbasemi*datediff(dd,@fecha1,r.rsfecinip)
,/*AS*/	ltrim(rtrim(i.inserie))+ltrim(rtrim(m.mnnemo))
,/*AT*/  (case 
			when mnnemo<>'CLP' then inserie+'MX'
			else '-'
		 end)
,	    DATEDIFF(day,r.rsfecha,bactradersuda.dbo.Fx_Buscar_Fecha_Habil(r.rsfecha,1,6))
FROM bactradersuda.dbo.MDRS r
inner join bactradersuda.dbo.VIEW_INSTRUMENTO i on i.incodigo=r.rscodigo and i.inserie='ICAP'
inner join bactradersuda.dbo.VIEW_MONEDA m on m.mncodmon=r.rsmonemi
WHERE r.rsfecha BETWEEN @FECHA1 AND @FECHA2
AND	r.rstipoper='DEV'
--AND	r.rscartera='121'
AND	r.rsrutcli<>97030000
ORDER BY m.mnnemo

INSERT INTO ##CARTERA_RF_RDBCCH
SELECT	r.rsnumoper					-- ajuste de campos para temporal
,		r.rsnumdocu					-- ajuste de campos para temporal
,		r.rscorrela					-- ajuste de campos para temporal
,		r.rstipopero				-- ajuste de campos para temporal
,		m.mncodmon			-- ajuste de campos para temporal
,		'ICOL'							-- ajuste de campos para temporal
,		r.rsfecinip
,/*AV*/	i.INSERIE 
,/*AW*/	m.MNNEMO 
,/*AX*/	r.RSVALCOMP 
,/*AY*/	r.RSINTERES 
,/*AZ*/	r.RSINTERES_ACUM 
,/*BA*/	r.RSREAJUSTE 
,/*BB*/	r.RSREAJUSTE_ACUM
,	    DATEDIFF(day,r.rsfecha,bactradersuda.dbo.Fx_Buscar_Fecha_Habil(r.rsfecha,1,6))
FROM bactradersuda.dbo.MDRS r
inner join bactradersuda.dbo.VIEW_INSTRUMENTO i on i.incodigo=r.rscodigo and i.inserie='ICOL'
inner join bactradersuda.dbo.VIEW_MONEDA m on m.mncodmon=r.rsmonemi
WHERE r.rsfecha BETWEEN @FECHA1 AND @FECHA2
AND	r.rstipoper='DEV'
AND	r.rscartera='130'
AND	r.codigo_carterasuper='P'


--select 'ojo',* from ##CARTERA_RF_PACTOS

/*
	SELECT CONCEPTO = 'ICOL TRADING', * FROM ##CARTERA_RF_ICOL_TRD
	SELECT CONCEPTO = 'ICOL OTROS', * FROM ##CARTERA_RF_ICOL
	SELECT CONCEPTO = 'ICAP BANCO ESTADO', * FROM ##CARTERA_RF_ICAP_BE
	SELECT CONCEPTO = 'ICAP OTROS', * FROM ##CARTERA_RF_ICAP
	SELECT CONCEPTO = 'ICOL REDESCUENTO BANCO CENTRAL', * from ##CARTERA_RF_RDBCCH
*/

INSERT INTO ##CARTERA_RF_VOUCHER
SELECT			
/*A*/	d.Numero_Voucher 
,/*B*/	d.Correlativo 
,/*C*/	d.Cuenta 
,/*D*/	d.Tipo_Monto 
,/*E*/	d.Monto 
,/*F*/	d.moneda 
,/*G*/	v.Numero_Voucher 
,/*H*/	v.Fecha_Ingreso 
,/*I*/	v.Glosa 
,/*J*/	v.Tipo_Voucher 
,/*K*/	v.Tipo_Operacion 
,/*L*/	v.Operacion 
,/*M*/	v.Correlativo 
,/*N*/	v.instser 
,/*O*/	v.Documento 
,/*P*/	v.codigo_producto 
,/*Q*/	v.id_sistema 
,/*R*/	v.fpagoentre 
,/*S*/	v.fpago 
,/*T*/	v.plazo 
,/*U*/	v.condicion_pacto 
,/*V*/	v.clasificacion_cliente 
,/*W*/	v.Fecha_Ingreso
,/*X*/	(case 
			when v.Tipo_Operacion_Original = 'IB' then v.codigo_producto
			when v.Tipo_Operacion_Original = 'CG' and v.Tipo_Operacion = 'TMCP' then 'CP'
			else v.Tipo_Operacion_Original 
		 end)
,/*Y*/	LTRIM(RTRIM(CONVERT(VARCHAR(20),d.Cuenta))) + LTRIM(RTRIM(d.Tipo_Monto))
,	    DATEDIFF(day,v.fecha_ingreso,bactradersuda.dbo.Fx_Buscar_Fecha_Habil(v.fecha_ingreso,1,6))
FROM Reportes.dbo.cnt_aux_det_rentabilidad_rf d
inner join Reportes.dbo.cnt_aux_rentabilidad_rf v on v.Numero_Voucher = d.Numero_Voucher
WHERE v.Fecha_Ingreso BETWEEN @FECHA1 AND @FECHA2



/**************************************************************************************************************
	VARIABLES GLOBALES PARA TODOS LOS PRODUCTOS DE RF NAC, EXT, INTERFANFARIOS
***************************************************************************************************************/

DECLARE @CUENTA			VARCHAR(20)
DECLARE @CRITERIO		VARCHAR(100)
DECLARE @ADD_FILTER		VARCHAR(100)
DECLARE @INSTRUMENTO	VARCHAR(100)
DECLARE @CAMPO			VARCHAR(100)
DECLARE @TABLA			VARCHAR(100)
DECLARE @AUX_SQL		NVARCHAR(MAX)
DECLARE @FLAG			VARCHAR(10)

DECLARE @SQLCMD NVARCHAR(MAX)
SET @SQLCMD=''

/**************************************************************************************************************
	GENERACION DE DATOS PARA EL RESULTADO DE LA INTERFAZ RENTA FIJA NACIONAL Y GARANTIAS.	
***************************************************************************************************************/
DECLARE CUR_CUENTAS CURSOR FOR 
SELECT CUENTA,CRITERIO_01,CAMPO,CRITERIO_07,CRITERIO_10
FROM REPORTES.DBO.RNT_ARCH_CDRA_CONT
WHERE SISTEMA='BTR'
AND PRODUCTO='BTR'
AND LTRIM(RTRIM(CUENTA))<>''
AND CRITERIO_01 IS NOT NULL
AND CRITERIO_07 IS NOT NULL
AND CRITERIO_10 IS NOT NULL


OPEN CUR_CUENTAS 
FETCH NEXT FROM CUR_CUENTAS INTO @CUENTA,@CRITERIO,@CAMPO,@INSTRUMENTO,@ADD_FILTER
WHILE @@FETCH_STATUS=0 BEGIN
	SET @SQLCMD =
	N'
	INSERT INTO ##TMP_RESULTADO_RF (NRO_DOCUMENTO,NRO_OPERACION,NRO_CORRELATIVO,SERIE,INSTRUMENTO,VALOR_COMPRA,VALOR_PRESENTE,FEC_COMP,FEC_EMI,CANT_DIAS,COD_DIVISA,COD_SUBPRODU,COD_CTA_CONT,IMP_SDO_CONT_MO)
	SELECT DISTINCT
		 rmnumdocu
		,rmnumoper
		,rmcorrela
		,inserie
		,rminstser
		,valor_compra
		,valor_presente
		,rsfeccomp
		,tmfecemi
		,cant_dias
		,cod_nemo		= (case cod_nemo when 994 then 13 else cod_nemo end)
		,cod_subprodu			
		,cod_cta_cont	= ' + @CUENTA + '
		,' + @CAMPO	+
	    '
		FROM ##CARTERA_RF_NAC
		WHERE LTRIM(RTRIM(FILTRO)) LIKE ''' + LTRIM(RTRIM(@CRITERIO)) + '''
		' + @ADD_FILTER
	
	-- PRINT @SQLCMD
	EXEC SP_EXECUTESQL @SQLCMD	
	
	FETCH NEXT FROM CUR_CUENTAS INTO @CUENTA,@CRITERIO,@CAMPO,@INSTRUMENTO,@ADD_FILTER
END
CLOSE CUR_CUENTAS
DEALLOCATE CUR_CUENTAS


/**************************************************************************************************************
	GENERACION DE DATOS PARA EL RESULTADO DE LA INTERFAZ RENTA FIJA ICAP,ICOL, VOUCHER, PACTOS.
***************************************************************************************************************/
DECLARE CUR_CUENTAS CURSOR FOR 
SELECT CUENTA,CRITERIO_01,CAMPO,FAMILIA
FROM REPORTES.DBO.RNT_ARCH_CDRA_CONT
WHERE SISTEMA='BTR'
AND FAMILIA <>'BTR'
AND PRODUCTO ='BTR'
ORDER BY FAMILIA

OPEN CUR_CUENTAS 
FETCH NEXT FROM CUR_CUENTAS INTO @CUENTA,@CRITERIO,@CAMPO,@TABLA
WHILE @@FETCH_STATUS=0 BEGIN	
	SET @FLAG = REPLACE(@TABLA,'##CARTERA_RF_','') 

	SET @CUENTA		= LTRIM(RTRIM(@CUENTA))
	SET @CRITERIO	= LTRIM(RTRIM(@CRITERIO))
	SET @CAMPO		= LTRIM(RTRIM(@CAMPO))
	SET @TABLA= LTRIM(RTRIM(@TABLA))
		
	SET @AUX_SQL = N'INSERT INTO ##TMP_RESULTADO_RF (NRO_DOCUMENTO,NRO_OPERACION,NRO_CORRELATIVO,SERIE,INSTRUMENTO,FEC_COMP,FEC_EMI,CANT_DIAS,COD_DIVISA,COD_PRODUCTO,COD_SUBPRODU,COD_CTA_CONT,IMP_SDO_CONT_MO) '
	
	SET @SQLCMD = 
	CASE @FLAG
		WHEN 'ICOL_TRD'	THEN ''	
		WHEN 'ICOL'		THEN 
			@AUX_SQL + 
			N'
			SELECT DISTINCT
				rsnumdocu
				,rsnumoper
				,rscorrela
				,serie
				,nemo
				,rsfecinip
				,rsfecinip
				,cant_dias
				,cod_nemo
				,''BTR'' --''ICOL''
				,tipo
				,'+ @CUENTA +'
				,'+ @CAMPO +'
			FROM ' + @TABLA + '
			WHERE ltrim(rtrim(criterio)) like ''' + @CRITERIO +'''
				
				'		
								
		WHEN 'ICAP_BE'	THEN 
			@AUX_SQL +
			N'
			SELECT DISTINCT
				rsnumdocu
				,rsnumoper
				,rscorrela
				,serie
				,nemo
				,rsfecinip
				,rsfecinip
				,cant_dias
				,cod_nemo
				,''BTR'' --''ICAP''
				,tipo
				,' + @CUENTA +'
				,' + @CAMPO  +'
			FROM ' + @TABLA + '
			WHERE LTRIM(RTRIM(CRITERIO)) LIKE ''' + @CRITERIO + '''

			'
		WHEN 'ICAP'		THEN 
			@AUX_SQL +
			N'
			SELECT DISTINCT
				rsnumdocu
				,rsnumoper
				,rscorrela
				,serie
				,nemo
				,rsfecinip
				,rsfecinip
				,cant_dias
				,cod_nemo
				,''BTR'' --''ICAP''
				,tipo
				,' + @CUENTA + '
				,' + @CAMPO + '
			FROM ' + @TABLA + '
			WHERE LTRIM(RTRIM(CRITERIO2)) LIKE ''' + @CRITERIO + '''
			'
		WHEN 'RDBCCH'	THEN 
			@AUX_SQL +
			N'
			SELECT DISTINCT
				rsnumdocu
				,rsnumoper
				,rscorrela
				,''ICOL''
				,''ICOL''
				,rsfecinip
				,rsfecinip
				,cant_dias
				,cod_nemo
				,''BTR'' --''RDBCCH''
				,tipo
				,' + @CUENTA + '
				,' + @CAMPO + '
			FROM ' + @TABLA 
			--+ '	WHERE LTRIM(RTRIM()) LIKE ''' + @CRITERIO + ''' '

		WHEN 'PACTOS'	THEN 	
			@AUX_SQL +
			N'
			SELECT DISTINCT
				rsnumdocu
				,rsnumoper
				,rscorrela
				,inserie
				,inserie
				,rsfecinip
				,rsfecinip
				,cant_dias
				,cod_nemo
				,''BTR'' --''PACTOS''
				,rstipopero
				,' + @CUENTA + '
				,' + @CAMPO + '
			FROM ' + @TABLA +
			'	WHERE UPPER(LTRIM(RTRIM(FILTRO))) LIKE ''' + UPPER(@CRITERIO) + ''' '

		WHEN 'VOUCHER'	THEN 
			@AUX_SQL +
			N'
			SELECT DISTINCT
				 documento
				,operacion
				,correlativo
				,instser
				,instser
				,isnull(fecha_ingreso,''19000101'')
				,isnull(fecha_ingreso,''19000101'')
				,isnull(cant_dias,''0'')
				,moneda
				,''VOU'' --''VOUCHER''
				,tipopero
				,' + @CUENTA + '
				,' + @CAMPO + '
			FROM ' + @TABLA +
			'	WHERE UPPER(LTRIM(RTRIM(CRITERIO))) = ''' + UPPER(@CRITERIO) + '''  '			

	END
--	PRINT 	@SQLCMD	
	EXEC SP_EXECUTESQL @SQLCMD	
	
	FETCH NEXT FROM CUR_CUENTAS INTO @CUENTA,@CRITERIO,@CAMPO,@TABLA
END
CLOSE CUR_CUENTAS
DEALLOCATE CUR_CUENTAS


UPDATE p
	set p.CONTABILIZAR=r.CAMPO
FROM ##TMP_RESULTADO_RF p
inner join REPORTES.DBO.RNT_ARCH_CDRA_CONT r on r.CUENTA=p.COD_CTA_CONT and r.SISTEMA='BTR'


--select 'ojo2',* FROM ##TMP_RESULTADO_RF p

		INSERT into #SALIDA
		select 
				@FECHA1					
		,		COD_SUBPRODU
		,		p.DESCRIPCION			
		,		INSTRUMENTO				
		,		CASE WHEN IMP_SDO_CONT_MO>0 THEN '+' ELSE '-' END
		,		FEC_EMI 
		,		SERIE				
		,		NRO_OPERACION
		,		VALOR_COMPRA				
		,		IMP_SDO_CONT_MO
		,		VALOR_PRESENTE						
		,		0.0						
		,		FEC_COMP

		,		NRO_DOCUMENTO
		,		0.0					
		,		0.0					
		,		0.0						
		,		0.0						
		,	    space(20)
		,		space(20)				
		,		space(20)				
		,		COD_CTA_CONT				
		,		CANT_DIAS
		from ##TMP_RESULTADO_RF
		INNER JOIN BACPARAMSUDA.DBO.PRODUCTO p	ON P.CODIGO_PRODUCTO=COD_SUBPRODU AND P.ID_SISTEMA='BTR'
		where CONTABILIZAR='diferencia_mercado'
--		and COD_SUBPRODU='CP'
 

		INSERT into #SALIDA
		select 
				@FECHA1					
		,		COD_SUBPRODU
		,		p.DESCRIPCION			
		,		INSTRUMENTO				
		,		CASE WHEN IMP_SDO_CONT_MO>0 THEN '+' ELSE '-' END
		,		FEC_EMI 
		,		SERIE				
		,		NRO_OPERACION
		,		VALOR_COMPRA				
		,		IMP_SDO_CONT_MO
		,		VALOR_PRESENTE						
		,		IMP_SDO_CONT_MO						
		,		FEC_COMP

		,		NRO_DOCUMENTO
		,		0.0					
		,		0.0					
		,		IMP_SDO_CONT_MO						
		,		0.0						
		,	    space(20)
		,		COD_CTA_CONT				
		,		space(20)				
		,		space(20)				
		,		CANT_DIAS
		from ##TMP_RESULTADO_RF
		INNER JOIN BACPARAMSUDA.DBO.PRODUCTO p	ON P.CODIGO_PRODUCTO=COD_SUBPRODU AND P.ID_SISTEMA='BTR'
		where CONTABILIZAR='interes_acum'
--		and COD_SUBPRODU='CP'

		INSERT into #SALIDA
		select 
				@FECHA1					
		,		COD_SUBPRODU
		,		p.DESCRIPCION			
		,		INSTRUMENTO				
		,		CASE WHEN IMP_SDO_CONT_MO>0 THEN '+' ELSE '-' END
		,		FEC_EMI 
		,		SERIE				
		,		NRO_OPERACION
		,		VALOR_COMPRA				
		,		IMP_SDO_CONT_MO
		,		VALOR_PRESENTE						
		,		IMP_SDO_CONT_MO						
		,		FEC_COMP

		,		NRO_DOCUMENTO
		,		0.0					
		,		0.0					
		,		0.0
		,		IMP_SDO_CONT_MO						
		,	    space(20)
		,		space(20)
		,		COD_CTA_CONT				
		,		space(20)				
		,		CANT_DIAS
		from ##TMP_RESULTADO_RF
		INNER JOIN BACPARAMSUDA.DBO.PRODUCTO p	ON P.CODIGO_PRODUCTO=COD_SUBPRODU AND P.ID_SISTEMA='BTR'
		where CONTABILIZAR='reajuste_acum'
--		and COD_SUBPRODU='CP'

		INSERT into #SALIDA
		select 
				@FECHA1					
		,		COD_SUBPRODU
		,		p.DESCRIPCION			
		,		INSTRUMENTO				
		,		CASE WHEN IMP_SDO_CONT_MO>0 THEN '+' ELSE '-' END
		,		FEC_EMI 
		,		SERIE				
		,		NRO_OPERACION
		,		VALOR_COMPRA				
		,		IMP_SDO_CONT_MO
		,		VALOR_PRESENTE						
		,		IMP_SDO_CONT_MO						
		,		FEC_COMP

		,		NRO_DOCUMENTO
		,		IMP_SDO_CONT_MO					
		,		IMP_SDO_CONT_MO					
		,		0.0
		,		0.0						
		,	    COD_CTA_CONT
		,		space(20)
		,		space(20)
		,		space(20)				
		,		CANT_DIAS
		from ##TMP_RESULTADO_RF
		INNER JOIN BACPARAMSUDA.DBO.PRODUCTO p	ON P.CODIGO_PRODUCTO=COD_SUBPRODU AND P.ID_SISTEMA='BTR'
		where CONTABILIZAR='valor_compra'
--		and COD_SUBPRODU='CP'



/*
devengo
diferencia_mercado
interes_acum
reajuste_acum
rsinteres_acum-rsinteres
rsvalcomp 
rsvalinip
valor_compra
*/

select * from #SALIDA


drop table ##CARTERA_RF_NAC
drop table ##CARTERA_RF_PACTOS
drop TABLE ##CARTERA_RF_ICOL_TRD
drop TABLE ##CARTERA_RF_ICOL
drop TABLE ##CARTERA_RF_ICAP_BE
drop TABLE ##CARTERA_RF_ICAP
drop TABLE ##CARTERA_RF_RDBCCH
drop table ##CARTERA_RF_VOUCHER
drop table ##TMP_RESULTADO_RF


END

GO
