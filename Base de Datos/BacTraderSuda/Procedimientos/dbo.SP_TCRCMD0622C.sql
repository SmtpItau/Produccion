USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TCRCMD0622C]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create procedure [dbo].[SP_TCRCMD0622C]
	(	@modcal		integer				,
		@dfeccal	datetime			,
		@ncodigo	integer				,
		@cmascara	char (12)			,
		@nmonemi	integer				,
		@dfecemi	datetime			,
		@dfecven	datetime			,
		@ftasemi	float				,
		@fbasemi	float				,
		@ftasest	float				,
		@fnominal	float		OUTPUT	,
		@ftir		float		OUTPUT	,
		@fpvp		float		OUTPUT	,
		@fmt		float		OUTPUT	,
		@fmtum		float		OUTPUT	,
		@fmt_cien	float		OUTPUT	,
		@fvan		float		OUTPUT	,
		@fvpar		float		OUTPUT	,
		@nnumucup	integer		OUTPUT	,
		@dfecucup	datetime	OUTPUT	,
		@fintucup	float		OUTPUT	,
		@famoucup	float		OUTPUT	,
		@fsalucup	float		OUTPUT	,
		@nnumpcup	integer		OUTPUT	,
		@dfecpcup	datetime	OUTPUT	,
		@fintpcup	float		OUTPUT	,
		@famopcup	float		OUTPUT	,
		@fsalpcup	integer		OUTPUT  ,
		@fdurat		float		OUTPUT	,
		@fconvx		float		OUTPUT	,
		@fdurmo		float		OUTPUT
	)
as
begin

	declare @nvalmon	numeric (18,10)
	select	@fpvp		= 0.0 ,
			@fmt_cien	= 0.0

	if @modcal=1 or @modcal=4
		return

	if @dfeccal<@dfecemi
		return

	if @dfeccal>@dfecven
		select @dfeccal = @dfecven

	--	Modificacion a Tipo de Cambio de Representacion Contable  
	select @nvalmon = 0.0
	if @nmonemi = 999 or @nmonemi = 13
		select @nvalmon = 1
	else
		if @nmonemi = 994
			select tipo_cambio from bacparamsuda.dbo.valor_moneda_contable where fecha = @dfeccal and codigo_moneda = @nmonemi
 
	if @modcal = 2
	begin
		select	@fpvp	= 0.0 
			,	@fvpar	= 0.0
		select	@fvan	= power((1.0+(@ftir/100.0)),(datediff(day,@dfeccal,@dfecven)/@fbasemi))
		select	@fmt	= @fnominal/@fvan
		select	@fmtum	= round(@fmt,4)
		select	@fmt	= round(@fmtum*@nvalmon,0)
	end

	if @modcal=3
	begin
		select	@fmt	= @fmt/@nvalmon 
			,	@fpvp	= 0.0  
			,	@fvpar	= 0.0

		select	@ftir	= round((power((@fnominal/@fmt),(@fbasemi/datediff(day,@dfeccal,@dfecven)))-1.0)*100.0,2)
		select	@fvan	= (@fmt/@fnominal)*100.0
		select	@fmtum	= @fmt
		select	@fmt	= round(@fmt*@nvalmon,0)
	end

	select @fdurat = round(datediff(day,@dfeccal,@dfecven)/365.0,8)
	select @fdurmo = round(@fdurat / (1.0+(@ftir/100.0)),2)
	select @fconvx = round(power(@fdurat,2) / power(1.0+(@ftir/100.0)*@fdurat,2), 2)

	if @dfeccal < @dfecven
		select	@nnumucup = 0.0			,
				@dfecucup = @dfecemi	,
				@famoucup = 0.0			,
				@fintucup = 0.0			,
				@nnumucup = 1			,
				@dfecucup = @dfecven	,
				@dfecpcup = @dfecven	,
				@famoucup = 100.0		,
				@fintucup = 0.0			,
				@fsalucup = 0.0
	else
		select	@nnumucup = 1			,
				@dfecucup = @dfecven	,
				@dfecpcup = @dfecven	,
				@famoucup = 100.0		,
				@fintucup = 0.0			,
				@fsalucup = 0.0
	return

end
GO
