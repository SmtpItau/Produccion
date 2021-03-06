USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Revaloriza_Cartera_Mdrs]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[Sp_Revaloriza_Cartera_Mdrs]
	(	@acfecproc	datetime
	,	@acfecprox	datetime
	,	@crscartera	varchar(5)
	,	@crstipoper	varchar(5)
	)
as
begin 

	set nocount on

	if not exists ( select 1 from sys.sysobjects where type = 'U' and name = 'tmp_chkinstser_regulariza' )
	begin
		create table dbo.tmp_chkinstser_regulariza
			( Error int, Mascara varchar(12), Codigo int, Serie varchar(12), RutEmis numeric(9), Monemi int, TasEmi float
			, BasEmi numeric(3), FecEmi datetime, FecVen datetime, RefNomi char(1), Genemi char(10), NemMon	char(5)
			, Corte	numeric(19,4), Seriado char(1), lesemi char(6), FecPro char(10)
			)
	end

	select	rsfecha			= mdrs.rsfecha
		,	rscartera		= mdrs.rscartera
		,	rstipoper		= mdrs.rstipoper
		,	rsfecucup		= mdrs.rsfecucup
		,	rsfecpcup		= mdrs.rsfecpcup
		,	rsnumdocu		= mdrs.rsnumdocu
		,	rscorrela		= mdrs.rscorrela
		,	rsinstser		= mdrs.rsinstser
		,	rsfeccomp		= mdrs.rsfeccomp
		,	rsvalcomp		= mdrs.rsvalcomp
		,	rsvalcomu		= mdrs.rsvalcomu
		,	rsnominal		= mdrs.rsnominal
		,	rstir			= mdrs.rstir
		,	rsvppresen		= mdrs.rsvppresen
		,	rsvppresenx		= mdrs.rsvppresenx
		,	rsinteres		= mdrs.rsinteres
		,	rsreajuste		= mdrs.rsreajuste
		,	rsinteres_acum	= mdrs.rsinteres_acum
		,	rsreajuste_acum	= mdrs.rsreajuste_acum

		,	Registro		= row_number () over (order by rsnumdocu, rscorrela)
		,	xValcomp		= convert(float, 0.0)
		,	xValcomu		= convert(float, 0.0)
		,	xValorPresente	= convert(float, 0.0)
		,	xValorPresenteX	= convert(float, 0.0)
		,	xInteres		= convert(float, 0.0)
	into	#tmp_mdrs
	from	BacTraderSuda.dbo.mdrs_AjustePPA mdrs with(nolock)
			inner join
			(	select	cpnumdocu, cpcorrela
				from	BacTraderSuda.dbo.mdcp with(nolock)
				where	cpnumdocu <> cpnumdocuo
			)	mdcp	On	mdcp.cpnumdocu	= mdrs.rsnumdocu
						and	mdcp.cpcorrela	= mdrs.rscorrela
	where	mdrs.rsfecha	>= '2016-04-27'
	and		mdrs.rstipoper	 = 'DEV'
	and		mdrs.rscartera	 = 111
	order
	by		mdrs.rsnumdocu
		,	mdrs.rscorrela
		,	mdrs.rsfecha 


	declare @nFila				numeric(9);		set @nFila			= ( select min(Registro) from #tmp_mdrs );
	declare @nFilas				numeric(9);		set @nFilas			= ( select max(Registro) from #tmp_mdrs );

	declare @rsnumdocu			numeric(9);		set @rsnumdocu		= 0;
	declare @rscorrela			numeric(9);		set @rscorrela		= 0;
	declare @rscartera			char(5);		set @rscartera		= '';
	declare @rstipoper			varchar(5);		set @rstipoper		= ''; 

	declare @nModo				int;			set @nModo			= 2;
	declare	@cFeccal			char(10);		set @cFeccal		= convert(char(10),@acfecproc, 112);
	declare @nCodigo			int;			set @nCodigo		= 0;
	declare @cMascara			char(12);		set @cMascara		= '';
	declare @nMonemi			int;			set @nMonemi		= 0;
	declare @cFecemi			char(10);		set @cFecemi		= '';
	declare @cFecven			char(10);		set @cFecven		= ''; 
	declare @fTasemi			float;			set @fTasemi		= 0.0;
	declare @fBasemi			float;			set @fBasemi		= 0.0; 
	declare @fTasest			float;			set @fTasest		= 0.0;
	declare @fNominal			float;			set @fNominal		= 0.0;
	declare @fTir				float;			set @fTir			= 0.0;
	declare @fPvp				float;			set @fPvp			= 0.0;
	declare @fMT				float;			set @fMT			= 0.0;
	declare @fMTUM				float;			set @fMTUM			= 0.0;
	
	declare @fvalcomp			float;			set @fvalcomp		= 0.0;
	declare @fvalcomu			float;			set @fvalcomu		= 0.0;
	declare @fvppresen			float;			set @fvppresen		= 0.0; 
	declare @fvppresenx			float;			set @fvppresenx		= 0.0;
	
	declare @rsInteres			float;
	declare @rsReajuste			float;
	declare @rsInteres_acum		float;
	declare @rsReajuste_acum	float;
	declare @rsInteres_Mes		float;
	declare @rsReajuste_Mes		float;

	declare @fValmon_Hoy		float;
	declare @fValmon_Man		float;
	declare @dFecComp			datetime
	declare @fIpc_cp			float;


	while ( @nFila <= @nFilas)
	begin

		select	@rsnumdocu			= rsnumdocu 
			,	@rscorrela			= rscorrela
			,	@rscartera			= rscartera
			,	@rstipoper			= rstipoper

			,	@cMascara			= rsinstser
			,	@fNominal			= rsnominal
			,	@fTir				= rstir

			,	@dFecComp			= rsfecucup	-->	rsfeccomp
			,	@fvalcomp			= 0.0
			,	@fValcomu			= 0.0
			,	@fvppresen			= 0.0
			,	@fvppresenx			= 0.0

			,	@rsInteres			= 0.0
			,	@rsReajuste			= rsreajuste
			,	@rsInteres_acum		= 0.0
			,	@rsReajuste_acum	= 0.0
			,	@rsInteres_Mes		= 0.0
			,	@rsReajuste_Mes		= 0.0
		from	#tmp_mdrs
		where	Registro			= @nFila 

		delete dbo.tmp_chkinstser_regulariza

		insert into dbo.tmp_chkinstser_regulariza
		execute dbo.SP_CHKINSTSER_upd @cMascara

		select	@nCodigo	= Codigo
			,	@cMascara	= Mascara
			,	@nMonemi	= Monemi
			,	@cFecemi	= convert(char(10),FecEmi,112)
			,	@cFecven	= convert(char(10),FecVen, 112)
			,	@fTasemi	= TasEmi
			,	@fBasemi	= BasEmi
			,	@fTasest	= 0.0
		from	dbo.tmp_chkinstser_regulariza 

		
		-->		Valorizacion a Valor de Compra
		set @cFeccal		= convert(char(10), @dFecComp, 112)

		Execute dbo.SP_VALORIZAR_CLIENT_upd @nModo
										,	@cFeccal
										,	@nCodigo
										,	@cMascara
										,	@nMonemi
										,	@cFecemi
										,	@cFecven
										,	@fTasemi
										,	@fBasemi
										,	@fTasest 
										,	@fNominal
										,	@fTir
										,	@fPvp
										,	@fMT		output
										,	@fMTUM		output

		set @fvalcomp	= @fMT 
		set @fValcomu	= @fMTUM
		-->		Valorizacion a Valor de Compra

		-->		Valorizacion a Fecha de Proceso
		set @cFeccal		= convert(char(10), @acfecproc, 112) 

		Execute dbo.SP_VALORIZAR_CLIENT_upd @nModo
										,	@cFeccal
										,	@nCodigo
										,	@cMascara
										,	@nMonemi
										,	@cFecemi
										,	@cFecven
										,	@fTasemi
										,	@fBasemi
										,	@fTasest 
										,	@fNominal
										,	@fTir
										,	@fPvp
										,	@fMT		output
										,	@fMTUM		output
		set	@fvppresen = @fMT
		-->		Valorizacion a Fecha de Proceso
		
		-->		Valorizacion a Fecha de Proximo - Proceso
		set @cFeccal		= convert(char(10), @acfecprox, 112)

		Execute dbo.SP_VALORIZAR_CLIENT_upd @nModo
										,	@cFeccal
										,	@nCodigo
										,	@cMascara
										,	@nMonemi
										,	@cFecemi
										,	@cFecven
										,	@fTasemi
										,	@fBasemi
										,	@fTasest 
										,	@fNominal
										,	@fTir
										,	@fPvp
										,	@fMT		output
										,	@fMTUM		output
		set @fvppresenx = @fMT
		-->		Valorizacion a Fecha de Proximo - Proceso


		if ( @nMonemi <> 999 and @nMonemi <> 13 )
		begin
			if @nCodigo <> 800
			begin
				select  @fValmon_Hoy = vmvalor from VIEW_VALOR_MONEDA where vmcodigo = @nMonemi AND vmfecha = @acfecproc
				select  @fValmon_Man = vmvalor from VIEW_VALOR_MONEDA where vmcodigo = @nMonemi AND vmfecha = @acfecprox
				set		@rsReajuste	 = round((@fValmon_Man - @fValmon_Hoy) * @fValcomu, 4)
			end else
			begin
				set		@rsReajuste	 = @rsReajuste
			end
		end

		set @rsInteres = @fvppresenx - @fvppresen - @rsReajuste

		update	#tmp_mdrs
			set	xValcomp		= @fvalcomp
			,	xValcomu		= @fvalcomu
			,	xValorPresente	= @fvppresen
			,	xValorPresenteX	= @fvppresenx
			,	xInteres		= @rsInteres
		where	Registro		= @nFila

		set @nFila = @nFila + 1
	end

	select	rsfecha
		,	rscartera
		,	rstipoper
		,	rsfecucup
		,	rsfecpcup
		,	rsnumdocu
		,	rscorrela
		,	rsinstser
		,	rsfeccomp
		,	rsvalcomp
		,	rsvalcomu
		,	rsnominal
		,	rstir
		,	rsvppresen
		,	rsvppresenx
		,	rsinteres
		,	rsreajuste
		,	rsinteres_acum
		,	rsreajuste_acum
		,	xValcomp
		,	xValcomu
		,	xValorPresente
		,	xValorPresenteX
		,	xInteres
		,	Registro
	from	#tmp_mdrs
	order 
	by		Registro

			
end

GO
