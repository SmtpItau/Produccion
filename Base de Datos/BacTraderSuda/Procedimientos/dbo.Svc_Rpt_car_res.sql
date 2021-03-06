USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Svc_Rpt_car_res]    Script Date: 16-05-2022 12:48:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO




create procedure [dbo].[Svc_Rpt_car_res]
			(	@FecProc	DATETIME 	,
				@NUM_SUCU1	FLOAT		,
				@NUM_SUCU2	FLOAT		,
				@tipo_cartera	CHAR(1)		)
as
begin
	declare @cartera VARchar(10)

	if @tipo_cartera = 'T' begin
		select @cartera = 'NORMAL'
	end
	else begin
		select @cartera = 'PERMANENTE'
	end

	set 	nocount on
	create	table #cartera
		( 	Unidad		char(50)	not null default ' ' 	, --1
			Familia		char(40)	not null default ' ' 	, --2
			moneda		char(3)		not null default ' ' 	, --3
			t_nominal	numeric(25,4)	not null default 0 	, --4
			t_valpresen	numeric(25,4)	not null default 0 	, --5
			t_valmerc	numeric(25,4)	not null default 0 	, --6
			t_interes	numeric(25,4)	not null default 0 	, --7
			t_Int_acum	numeric(25,4)	not null default 0 	, --8
			Titulo		char(70)	not null default ' ' 	, --9
			sw		numeric(1)	not null default 0 	) --10


	insert 	into #cartera
	select
	ISNULL ((select ofi_nom from ttab_ofi where 	sucursal = ofi_cod ), ' ' ),
		(select Descrip_familia from text_fml_inm where cod_familia = a.cod_familia)	,
		(select mnnemo from VIEW_moneda where MNCODMON = rsmonemi)		,	 
		'nominal'	=SUM(rsnominal) 	,
		'valor_presente'=sum(rsvppresen)	,
		'valor_meracdo'	=sum(CASE WHEN rsvalmerc <> 0 THEN rsvalmerc ELSE rsvppresen END),
		'interes'	=sum(rsinteres)		,
		'interes_acum'	=sum(rsinteres_acum)	,
		'RESUMEN DE CARTERA VIGENTE ' + @cartera + ' AL ' + convert(char(10),convert(datetime, @fecproc),103),
		1					
	from 	text_rsu a
	where	rscartera = '333'
	and	rsfecpro = @Fecproc
	and 	codigo_carterasuper = @tipo_cartera
	AND	CONVERT(NUMERIC(03),sucursal) >= @NUM_SUCU1
	AND	CONVERT(NUMERIC(03),sucursal) <= @NUM_SUCU2
	group by  sucursal,cod_familia,rsmonemi


	insert 	into #cartera
	select
	ISNULL(	(select	ofi_nom from ttab_ofi	where 	sucursal = ofi_cod), ' ' )		,
		'Total unidad'				,	 
		(select mnnemo from VIEW_moneda where MNCODMON = rsmonemi)		,
		'nominal'	=SUM(rsnominal) 	,
		'valor_presente'=sum(rsvppresen)	,
		'valor_meracdo'	=sum(CASE WHEN rsvalmerc <> 0 THEN rsvalmerc ELSE rsvppresen END)		,
		'interes'	=sum(rsinteres)		,
		'interes_acum'	=sum(rsinteres_acum)	,
		'RESUMEN DE CARTERA VIGENTE ' + @cartera + ' AL ' + convert(char(10),convert(datetime, @fecproc),103),
		1					
	from 	text_rsu a
	where	rscartera = '333'
	and	rsfecpro = @Fecproc
	and 	codigo_carterasuper = @tipo_cartera
	AND	CONVERT(NUMERIC(03),sucursal) >= @NUM_SUCU1
	AND	CONVERT(NUMERIC(03),sucursal) <= @NUM_SUCU2
	group by  sucursal,rsmonemi


	if not exists(select * from #cartera) begin
		insert into #Cartera
			(titulo,sw)
		values	('RESUMEN DE CARTERA VIGENTE ' + @cartera + ' AL ' + convert(char(10),convert(datetime, @fecproc),103),0)
	end 

	select * from #cartera

	set 	nocount off
end







-- Svc_Rpt_car_res '20020709' , 0 , 9999 , 'T'




GO
