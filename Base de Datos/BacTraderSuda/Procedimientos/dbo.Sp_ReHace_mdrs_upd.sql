USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_ReHace_mdrs_upd]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create procedure [dbo].[Sp_ReHace_mdrs_upd]
	(	@acfecproc	datetime
	,	@acfecprox	datetime
	,	@crscartera	varchar(5)
	,	@crstipoper	varchar(5)
	,	@Actualizar	char(1)	= 'N'
	)
as
begin 

	set nocount on

	/*
		DROP TABLE DBO.MDRS_REPROCESO_TEST
		DROP TABLE DBO.MDCP_REPROCESO_TEST
	 
		SELECT	*
		INTO	DBO.MDRS_REPROCESO_TEST
		FROM	MDRS
		WHERE	rsfecha >= '2016-04-01'
		
		SELECT	*
		INTO	DBO.MDCP_REPROCESO_TEST
		FROM	MDCP
		WHERE	CPNOMINAL > 0
	*/
	
	if not exists ( select 1 from sys.sysobjects where type = 'U' and name = 'tmp_chkinstser_regulariza' )
	begin
		create table dbo.tmp_chkinstser_regulariza
			( Error int, Mascara varchar(12), Codigo int, Serie varchar(12), RutEmis numeric(9), Monemi int, TasEmi float
			, BasEmi numeric(3), FecEmi datetime, FecVen datetime, RefNomi char(1), Genemi char(10), NemMon	char(5)
			, Corte	numeric(19,4), Seriado char(1), lesemi char(6), FecPro char(10)
			)
	end

	select	rsfecha
		,	rsnumdocu,	rscorrela, rsnumoper
		,	rscartera,	rstipoper
		,	rsinstser,	rscodigo
		,	rstir,		rsnominal,		 rsvppresen, rsvppresenx
		,	rsinteres,  rsinteres_acum,  rsintermes, rsinterescp,  rsinteres_acumcp
		,	rsreajuste, rsreajuste_acum, rsreajumes, rsreajustecp, rsreajuste_acumcp
		,   rsfeccomp
		,	rsvalcomp
		,	rsvalcomu
		,	Registro		= row_number () over (order by rsnumdocu, rscorrela)
		,	xValorPresente	= convert(float, 0.0)
		,	xValorPresenteX	= convert(float, 0.0)
		,	xInteres		= convert(float, 0.0)
		,	xRsValComp		= convert(float, 0.0)
		,	xRsValComu		= convert(float, 0.0)
		,	rsfecemis
		,	xReajuste		= convert(float, 0.0)
		,	xTir			= convert(float, 0.0)
		,	cpnominal		= cpnominal
		,	cpvalcomp		= cpvalcomp
		,	cpvalcomu		= cpvalcomu 
		,	cpvptirc		= cpvptirc 
		,	cptircomp		= cptircomp
		,	xcpvalcomp		= convert(float, 0.0)
		,	xcpvalcomu		= convert(float, 0.0)
		,	xcpvptirc		= convert(float, 0.0)
	into	#tmp_mdrs
--	from	BacTraderSuda.dbo.mdrs r with(nolock)
	from	BacTraderSuda.dbo.MDRS_REPROCESO_TEST
			inner join BacTraderSuda.dbo.Mdcp	 On cpnumdocu	= rsnumdocu
												and cpcorrela	= rscorrela
	where	rsfecha		= @acfecprox
	and	(	rscartera	= @crscartera or @crscartera = '' )
	and	(	rstipoper	= @crstipoper or @crstipoper = '' )
	and	not
		(	rsinstser	= 'BCAPS-F'	  )
--	and		rsnumdocu   = 98561


	declare @nFila			numeric(9);		set @nFila			= (select min(Registro) from #tmp_mdrs )
	declare @nFilas			numeric(9);		set @nFilas			= (select max(Registro) from #tmp_mdrs )
	declare @rsnumdocu		numeric(9);		set @rsnumdocu		= 0 
	declare @rscorrela		numeric(9);		set @rscorrela		= 0
	declare @rsnumoper		numeric(9);		set @rsnumoper		= 0
	declare @rscartera		char(5);		set @rscartera		= ''
	declare @rstipoper		varchar(5);		set @rstipoper		= '' 
	declare @nModo			int;			set @nModo			= 2
	declare	@cFeccal		char(10);		set @cFeccal		= convert(char(10),@acfecproc, 112)
	declare @nCodigo		int;			set @nCodigo		= 0
	declare @cMascara		char(12);		set @cMascara		= ''
	declare @nMonemi		int;			set @nMonemi		= 0
	declare @cFecemi		char(10);		set @cFecemi		= ''
	declare @cFecven		char(10);		set @cFecven		= ''
	declare @fTasemi		float;			set @fTasemi		= 0.0
	declare @fBasemi		float;			set @fBasemi		= 0.0
	declare @fTasest		float;			set @fTasest		= 0.0
	declare @fNominal		float;			set @fNominal		= 0.0
	declare @fTir			float;			set @fTir			= 0.0
	declare @fPvp			float;			set @fPvp			= 0.0
	declare @fMT			float;			set @fMT			= 0.0
	declare @fMTum			float;			set @fMTum			= 0.0
	declare @frsvppresen	float;			set @frsvppresen	= 0.0 
	declare @frsvppresenx	float;			set @frsvppresenx	= 0.0
	declare @frsvalcomp		float;			set @frsvalcomp		= 0.0
	declare @frsvalcomu		float;			set @frsvalcomu		= 0.0
	declare @fTasMer		float;			set @fTasMer		= 0.0
	
	declare @nTasaMercado	float;			set @nTasaMercado	= 0.0 
	declare @nValMercado	float;			set @nValmercado	= 0.0
	declare @nDifMercado	float;			set @nDifMercado	= 0.0 
	
	declare @fValcomu		 float 
	declare @rsInteres		 float;
	declare @rsReajuste		 float;
	declare @rsInteres_acum	 float;
	declare @rsReajuste_acum float;
	declare @rsInteres_Mes	 float;
	declare @rsReajuste_Mes	 float;

	declare @fValmon_Hoy	 float;
	declare @fValmon_Man	 float;
	declare @dFecComp		 datetime
	declare @fIpc_cp		 float;

	declare @fcpnominal		 float
	declare @fcpvalcomp		 float
	declare @fcpvalcomu		 float
	declare @fcpvptirc		 float
	declare @fcptircomp		 float

	while ( @nFila <= @nFilas)
	begin

		select	@cMascara		 = rsinstser
			,	@fNominal		 = rsnominal
			,	@fTir			 = rstir
			,	@fPvp			 = 0.0
			,	@fMT			 = rsvppresenx
			,	@rsnumdocu		 = rsnumdocu 
			,	@rscorrela		 = rscorrela
			,	@rsnumoper		 = rsnumoper
			,	@rscartera		 = rscartera
			,	@rstipoper		 = rstipoper
			,	@dFecComp		 = rsfeccomp
			,	@frsvalcomp		 = rsvalcomp
			,	@frsvalcomu		 = rsvalcomu
			,	@rsInteres		 = 0.0
			,	@rsReajuste		 = rsreajuste
			,	@rsInteres_acum	 = 0.0
			,	@rsReajuste_acum = 0.0
			,	@rsInteres_Mes	 = 0.0
			,	@rsReajuste_Mes	 = 0.0
			,	@cFecemi		 = convert(char(10),rsfecemis, 112)

			,	@fcpnominal		 = cpnominal 
			,	@fcpvalcomp		 = 0.0
			,	@fcpvalcomu		 = 0.0
			,	@fcpvptirc		 = 0.0
			,	@fcptircomp		 = cptircomp
		from	#tmp_mdrs
		where	Registro		 = @nFila 

		delete dbo.tmp_chkinstser_regulariza

		insert into dbo.tmp_chkinstser_regulariza
		execute dbo.SP_CHKINSTSER_upd @cMascara

		select	@nCodigo	= Codigo
			,	@cMascara	= Mascara
			,	@nMonemi	= Monemi
			,	@cFecven	= convert(char(10),FecVen, 112)
			,	@fTasemi	= TasEmi
			,	@fBasemi	= BasEmi
			,	@fTasest	= 0.0
		from	dbo.tmp_chkinstser_regulariza 

		--	valor de compra
		set	@frsvalcomp		= 0.0
		set @frsvalcomu		= 0.0
		set @fMT			= 0
		set @cFeccal		= convert(char(10), '2016-04-01', 112)

		Execute dbo.SP_VALORIZAR_CLIENT_upd 
											@nModo
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
										,	@fMTum		output

		set	@frsvalcomp		= @fMT
		set @frsvalcomu		= @fMTum
		--	valor de compra

		--	valor presente 
		set @frsvppresen	= 0.0
		set @fMT			= 0
		set @cFeccal		= convert(char(10), @acfecproc, 112)

		Execute dbo.SP_VALORIZAR_CLIENT_upd 
											@nModo
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
										,	@fMTum		output
		set @frsvppresen	= @fMT
		
		--	valor presente proximo
		set @fMT			= 0
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
										,	@fMTum		output

		set @frsvppresenx	= @fMT
		--	valor presente proximo


		--	reajustes
        if ( @nMonemi <> 999 and @nMonemi <> 13 )
        begin
            if @nCodigo <> 800
            begin
                select  @fValmon_Hoy = vmvalor from VIEW_VALOR_MONEDA where vmcodigo = @nMonemi AND vmfecha = @acfecproc
                select  @fValmon_Man = vmvalor from VIEW_VALOR_MONEDA where vmcodigo = @nMonemi AND vmfecha = @acfecprox
				set     @rsReajuste  = round((@fValmon_Man - @fValmon_Hoy) * @frsvalcomu, 4)
            end else
            begin
				set		@rsReajuste  = 0.0 --> @rsReajuste
            end
        end

		--	intereses
		set @rsInteres = @frsvppresenx - @frsvppresen - @rsReajuste

		--	actualizacion
		update	#tmp_mdrs
			set	xTir			= @fTir
			,	xValorPresente	= @frsvppresen
			,	xValorPresenteX	= @frsvppresenx
			,	xInteres		= @rsInteres
			,	xRsValComp		= @frsvalcomp
			,	xRsValComu		= @frsvalcomu
			,	xReajuste		= @rsReajuste
		where	Registro		= @nFila



		--	mdcp valcomp
		set  @fcpvalcomp		= 0.0
		set  @fcpvalcomu		= 0.0
		set  @fcpvptirc			= 0.0

		set  @fMT			= 0
		set  @cFeccal		= convert(char(10), '2016-04-01', 112)

		Execute dbo.SP_VALORIZAR_CLIENT_upd 
											@nModo
										,	@cFeccal
										,	@nCodigo
										,	@cMascara
										,	@nMonemi
										,	@cFecemi
										,	@cFecven
										,	@fTasemi
										,	@fBasemi
										,	@fTasest 
										,	@fcpnominal
										,	@fcptircomp
										,	@fPvp
										,	@fMT		output
										,	@fMTum		output

		set	@fcpvalcomp		= @fMT
		set @fcpvalcomu		= @fMTum
		--	mdcp valcomp

		--	mdcp proximo
		set @fMT			= 0
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
										,	@fcpnominal
										,	@fcptircomp
										,	@fPvp
										,	@fMT		output
										,	@fMTum		output

		set @fcpvptirc	= @fMT
		--	mdcp proximo
/*	
		select	@fTir,			@fcptircomp
			,	@fNominal,		@fcpnominal
			,	@frsvalcomp,	@fcpvalcomp
			,	@frsvalcomu,	@fcpvalcomu
			,	@frsvppresenx,	@fcpvptirc
*/
	
		--	actualizacion
		update	#tmp_mdrs
			set	xcpvalcomp		= @fcpvalcomp
			,	xcpvalcomu		= @fcpvalcomu
			,	xcpvptirc		= @fcpvptirc
		where	Registro		= @nFila
		--	actualizacion
		
		set @nFila = @nFila + 1
	end 

	if (@Actualizar = 'S')
	begin
 		UPDATE	BacTraderSuda.dbo.MDRS_REPROCESO_TEST
			SET	rsvppresen			= #tmp_mdrs.xValorPresente
			,	rsvppresenx			= #tmp_mdrs.xValorPresenteX
			,	rsvalcomp			= #tmp_mdrs.xRsValComp
			,	rsvalcomu			= #tmp_mdrs.xRsValComu
			,	rsinteres			= #tmp_mdrs.xInteres
			,	rsreajuste			= #tmp_mdrs.xReajuste
			,	rstir				= #tmp_mdrs.xTir
		FROM	#tmp_mdrs
		WHERE	#tmp_mdrs.rsfecha	= BacTraderSuda.dbo.MDRS_REPROCESO_TEST.rsfecha
		and		#tmp_mdrs.rsnumdocu	= BacTraderSuda.dbo.MDRS_REPROCESO_TEST.rsnumdocu
		and		#tmp_mdrs.rscorrela	= BacTraderSuda.dbo.MDRS_REPROCESO_TEST.rscorrela
		and		#tmp_mdrs.rsnumoper	= BacTraderSuda.dbo.MDRS_REPROCESO_TEST.rsnumoper
		and		#tmp_mdrs.rscartera	= BacTraderSuda.dbo.MDRS_REPROCESO_TEST.rscartera
		and		#tmp_mdrs.rstipoper	= BacTraderSuda.dbo.MDRS_REPROCESO_TEST.rstipoper
		
		if @crscartera = 111
			UPDATE	BacTraderSuda.DBO.MDCP_REPROCESO_TEST
				SET	cpvalcomp			= xcpvalcomp
				,	cpvalcomu			= xcpvalcomu
				,	cpvptirc			= xcpvptirc
			FROM	#tmp_mdrs
			WHERE	#tmp_mdrs.rsfecha	= '2016-05-09'
			and		#tmp_mdrs.rsnumdocu	= BacTraderSuda.DBO.MDCP_REPROCESO_TEST.cpnumdocu
			and		#tmp_mdrs.rscorrela	= BacTraderSuda.DBO.MDCP_REPROCESO_TEST.cpcorrela
		
	end

		select	rsfecha
			,	rsnumdocu
			,	rscorrela
			,	rsnumoper
			,	rscartera
			,	rstipoper
			,	rsinstser
			,	rsnominal
			,	rstir
			,	rsvppresen
			,	xValorPresente
			,	rsvppresenx
			,	xValorPresenteX
			,	rsvalcomp
			,	xRsValComp
			,	rsvalcomu
			,	xRsValComu
			,	rsreajuste 
			,	rsinteres
			,	xInteres

			,	cpvalcomp
			,	xcpvalcomp
			
			,	cpvalcomu
			,	xcpvalcomu
			
			,	cpvptirc
			,	xcpvptirc
		from	#tmp_mdrs

end
GO
