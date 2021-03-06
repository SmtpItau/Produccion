USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_SALDOS_OPERACIONALES_RF_PACTOS]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_SALDOS_OPERACIONALES_RF_PACTOS]
(
	@FECHA DATE=NULL
	,@OPCION INT = 0
)
AS
BEGIN
/*
	INTERFAP SALDOS OPERACIONALES RENTA FIJA PACTOS. 
	RSILVA.
*/
SET NOCOUNT ON
SET DATEFORMAT YMD

--DECLARE @FECHA DATE,@OPCION INT
--SET @FECHA = '2017-07-31'
--SET @OPCION = 1


IF OBJECT_ID('TEMPDB..##CARTERA_RF_PACTOS') IS NOT NULL BEGIN	
	DROP TABLE ##CARTERA_RF_PACTOS
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

CREATE TABLE ##CARTERA_RF_PACTOS
(
		idreg				int identity (1,1),
		rstipopero			varchar(5),
		cod_nemo			int,
		rscorrela			int,			
/*A*/	rsfecha				date,
/*B*/	rsfecinip			date,
/*C*/	rsrutcli			numeric(10),
/*D*/	clnombre			varchar(100),
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

)


INSERT INTO ##CARTERA_RF_PACTOS
SELECT 
		mdrs.rstipopero,
		view_moneda.mncodmon,
		mdrs.rscorrela,
/*A*/	MDRS.rsfecha, 
/*B*/	MDRS.rsfecinip, 
/*C*/	MDRS.rsrutcli, 
/*D*/	VIEW_CLIENTE.Clnombre, 
/*E*/	MDRS.rsnumoper, 
/*F*/	MDRS.rsnumdocu, 
/*G*/	VIEW_MONEDA.mnnemo, 
/*H*/	VIEW_INSTRUMENTO.inserie, 
/*I*/	MDRS.rsrutemis, 
/*J*/	MDRS.rsinstser, 
/*K*/	MDRS.rsnominal, 
/*L*/	MDRS.rsvalinip, 
/*M*/	MDRS.rstaspact, 
/*N*/	MDRS.rsfecvtop, 
/*O*/	MDRS.rscartera, 
/*P*/	VIEW_CLIENTE.Cltipcli,
/*Q*/	datediff(DD,MDRS.rsfecinip,@fecha_aux),
--+		(L*(M/100)/360*Q)
/*R*/	(MDRS.rsvalinip*(MDRS.rstaspact/100)/360*(datediff(DD,MDRS.rsfecinip,@fecha_aux)))		,
/*S*/	(case 
				when MDRS.rsfecvtop>@fecha_aux then 'c'
				else 'v'
		  end),
		 -- =SI(P>2;"t";"f")
/*T*/	(case 
			when view_cliente.cltipcli>2 then 't'
			else 'f'
		end),
/*U*/	null
FROM bactradersuda.dbo.MDRS MDRS, 
bactradersuda.dbo.VIEW_CLIENTE VIEW_CLIENTE, 
bactradersuda.dbo.VIEW_INSTRUMENTO VIEW_INSTRUMENTO, 
bactradersuda.dbo.VIEW_MONEDA VIEW_MONEDA
WHERE MDRS.rsrutcli = VIEW_CLIENTE.Clrut
AND	MDRS.rscodcli = VIEW_CLIENTE.Clcodigo
AND	MDRS.rsmonpact = VIEW_MONEDA.mncodmon
AND	MDRS.rscodigo = VIEW_INSTRUMENTO.incodigo
AND	((MDRS.rsfecha>@fecha_aux)

----------------------------------------------------------------------------------------------
---- AND	((MDRS.rsfecha between @fecha_ini_filtro and @fecha_proc_filtro)			--- para debug
----------------------------------------------------------------------------------------------

AND	(MDRS.rstipoper='dev')
AND	(MDRS.rscartera In ('112','115'))
AND	(MDRS.rsrutcli<>97029000))
ORDER BY MDRS.rsinstser


declare @idreg int,@inserie varchar(20),@rscartera varchar(5),@mnemo varchar(5),@considerar varchar(1),@cli varchar(1)

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


if @opcion<>0 begin
	select * from ##CARTERA_RF_PACTOS
	--where rsfecha <='2017-10-17'

end


END
GO
