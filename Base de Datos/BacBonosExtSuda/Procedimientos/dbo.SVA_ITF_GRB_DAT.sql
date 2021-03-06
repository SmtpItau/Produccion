USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVA_ITF_GRB_DAT]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SVA_ITF_GRB_DAT]
(
 	@numdocu	char(12)	,
        @familia	numeric(4)	,
	@instrumento	char(20)	,
	@vcto		datetime	,
	@cuenta_bech	char(15)	,
	@cuenta_sbif	numeric(4)	,
	@Codigo_Instrum Numeric(10)	
)
as
begin
	set nocount on
	if exists( select * from text_itf_bct	where numdocu = @numdocu and instrumento = @instrumento ) begin
		update 	text_itf_bct set
			cuenta_bech	= @cuenta_bech	,
			cuenta_sbif	= @cuenta_sbif  	
		where 	numdocu 	= @numdocu 
		and 	instrumento 	= @instrumento 
		select 'SI'
	end
	else begin
		insert 	into text_itf_bct 
			(	numdocu		,
				familia		,
				instrumento	,
				vcto		,
				cuenta_bech	,
				cuenta_sbif	
			--	cod_instrum	
						)
		values	(	@numdocu	,
				@familia	,
				@instrumento	,
				@vcto		,
				@cuenta_bech	,
				@cuenta_sbif	
			--	@Codigo_Instrum 
						)			
		select 'SI'
	end 
	set nocount off
end

GO
