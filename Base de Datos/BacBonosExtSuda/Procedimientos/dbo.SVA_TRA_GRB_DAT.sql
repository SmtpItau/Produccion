USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_TRA_GRB_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_TRA_GRB_DAT] 
(	
			@numdocu		char(12)	,
			@codigo_carterasuper	char(1)		,
			@tirmerc		numeric(19,7)	,	
			@pvpmerc		numeric(19,7)	,	
			@valmerc		numeric(19,7)	
)
as
begin

	set nocount on

	declare	@ajuste	numeric(19,4)	

	select 	@ajuste = (@valmerc - rsvalcomu)
	from 	text_rsu 
	where 	rsnumdocu = @numdocu and rscartera = '333'

	insert into text_tsp_ctr (
			trfectraspaso	,
			cprutcart	,
			cpnumdocu	,
			cod_familia 	,
			cod_nemo  	,
			id_instrum	,
		 	cpfecemi 	,
			cpfecven 	,
			tptir_ant 	,
			tppvp_ant	,
			tpval_ant	,
			tptir_nue	,
			tppvp_nue  	,
			tpval_nue	,
			ajuste 		,
			moneda 		)
	
	select 	(select acfecproc from text_arc_ctl_dri)	,
		cprutcart		,
		@numdocu		,
		cod_familia		,
		cod_nemo		,
		id_instrum		,
		cpfecemi		,
		cpfecven		,
		cptircomp		,
		cppvpcomp		,
		cpvptirc		,
		@tirmerc		,
		@pvpmerc		,
		@valmerc		,
		@ajuste			,
		cpmonemi	
	from 	text_ctr_inv
	where 	cpnumdocu = @numdocu


	update 	text_ctr_inv set
		codigo_carterasuper 	= @codigo_carterasuper			,
		cptircomp		= @tirmerc				,
		cppvpcomp		= @pvpmerc				,
		cpvalcomu		= @valmerc				,
		cpvptirc		= @valmerc				,
		cpfectraspaso  		= (select acfecproc from text_arc_ctl_dri)	,
		cpajuste_traspaso	= @ajuste				
	where 	cpnumdocu 		= @numdocu


	update 	text_arc_ctl_dri
	set 	acsw_dv = 0

	select 'SI'


	set nocount off

end

GO
