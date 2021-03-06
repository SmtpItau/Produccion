USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_RPT_CTL_OPE]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVC_RPT_CTL_OPE]
			(	@nemo		char(20)	,
				@fecvcto	char(08) 	,	--DATETIME	,
				@numdocu	char(12)	,
				@fec_pro	char(08) 	)	 --DATETIME	,)
as
begin

DECLARE	@NombreEntidad   char(50),	
	@DireccEntidad   char(50)

select	@NombreEntidad  = rcnombre, @DireccEntidad = rcdirecc from view_entidad


	set nocount on

	DECLARE	@I		INTEGER		,
		@E		INTEGER		,
		@fecha 		datetime	,
		@cupon		numeric(3)	,
		@fecpro		datetime	,
		@fecpro2	char(8)		,
		@fecpago	datetime	,
		@dias		char(1)		

	select 	@fecpro  = acfecproc 	,
		@fecpro2 = acfecproc 
	from 	text_arc_ctl_dri

	select 	@cupon = num_cupones,
		@dias = dias_reales
	from text_ser where cod_nemo = @nemo and fecha_vcto = @fecvcto

	create 	table 	#cartola (	
		instrumento	char(20)	not null default ' '	, --1
		fec_vcto	datetime	not null default ' '	, --2
		dias		numeric(4)	not null default 0	, --3
		cupon		numeric(3)	not null default 0	, --4
		divisas		numeric(19,4)	not null default 0	, --5
		vcto_cupon	datetime	not null default ' '	, --6
		inte		numeric(19,4)	not null default 0	, --7
		amor		numeric(19,4)	not null default 0	, --8
		saldo		numeric(19,4)	not null default 0	, --9
		fluj		numeric(19,4)	not null default 0	, --10
		orden		numeric(3)	not null default 0	, --11
		estado		char(7)		not null default ' '	, --12
		titulo		char(50)	not null default ' '	, --13
		numdocu		NUMERIC(10)	not null default 0	, --14
		NombreEntidad   char(50)	NOT NULL DEFAULT ' '	, --15
		DireccEntidad   char(50)	NOT NULL DEFAULT ' '	) --16

	insert 	into 	#cartola
		select	cod_nemo	,--1
			fecha_vcto	,--2
			0		,--3
			num_cupon	,--4
			0		,--5
			fecha_vcto_cupon,--6
			interes 	,--7
			amortizacion	,--8
			0		,--9 
			flujo		,--10
			0		,--11
			' '		,--12
			'INFORME CARTOLA DE OPERACIÓN AL ' + CONVERT(CHAR(10),CONVERT(DATETIME,@FECpro2),103),--13
			@numdocu 	,--14
			@NombreEntidad 	,--15
			@DireccEntidad	 --16

	from 	text_dsa
		where	cod_nemo = @nemo
		and 	fecha_vcto = @fecvcto
		order by fecha_vcto
	
	declare @nominal	float,
		@nominal2	float

	select  @nominal = rsnominal / 100,
		@nominal2 = rsnominal 	
        from 	text_rsu
	where	rsfecvcto = @fecvcto
	and	cod_nemo = @nemo

	select 	@fecha = rsfeccomp
	from 	text_rsu
	where	rsfecvcto = @fecvcto
	and	cod_nemo = @nemo

	update 	#cartola set
		inte = inte * @nominal,
		fluj = fluj * @nominal,
		amor =  @nominal2,
		saldo = @nominal2

	insert into #cartola
		select 	cod_nemo 	,--1
			rsfecvcto	,--2
			0		,--3
			0		,--4
			0 - rsvppresen	,--5
			rsfeccomp	,--6
			rsinteres	,--7
			0		,--8
			@nominal	,--9
			(0 - rsvppresen) + rsinteres, --10
			0		,	      --11
			' '		,             --12
			'INFORME CARTOLA DE OPERACIÓN AL ' + CONVERT(CHAR(10),CONVERT(DATETIME,@FECpro2),103),   --13
			@numdocu	,	      --14
			@NombreEntidad 	,	      --15
			@DireccEntidad		      --16

		from 	text_rsu
		where	cod_nemo = @nemo
		and 	rsfecvcto = @fecvcto 
		and 	@numdocu = rsnumdocu
		and 	rscartera = 333
		and 	@fec_pro = rsfecpro

	UPDATE #cartola SET AMOR = @nominal
	where cupon = @cupon

/*	update 	#cartola set
		cupon = 0
	from	#cartola
	where 	vcto_cupon < @fecha */

------------------------------------------------------------------------------------
	if @dias = 'F' begin
		update 	a  set 
			dias = (datediff(month, a.vcto_cupon, b.vcto_cupon )* 30)
		from 	#cartola  a, #cartola b
		where	a.vcto_cupon < b.vcto_cupon
	end
	else begin
		update 	a  set 
			dias = datediff(day, a.vcto_cupon, b.vcto_cupon )
		from 	#cartola  a, #cartola b
		where	a.vcto_cupon < b.vcto_cupon
	end

------------------------------------------------------------------------------------
	update  #cartola set estado = 'VIGENTE'
	where   vcto_cupon > @fecpro
	and	cupon != 0

	update  #cartola set estado = 'VENCIDO'
	where   vcto_cupon < @fecpro
	and	cupon != 0

------------------------------------------------------------------------------------

	select 	@fecpago = vcto_cupon from #cartola where cupon = 0
	
	update  #cartola set 	fluj = 0,
				amor = 0,
				saldo = 0,
				inte = 0,				
				estado = ' '

 	where   @fecpago > vcto_cupon 


---SELECT * FROM #cartola


	select 	a.*, b.*
 	from 	#cartola a, text_rsu b
	where 	b.rscartera = '333' 
	and	b.rsnumdocu = @numdocu
	and 	rsfecpro = @fec_pro
	order by 
	vcto_cupon

	set nocount off	
end

GO
