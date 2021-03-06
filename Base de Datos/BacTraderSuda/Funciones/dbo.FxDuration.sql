USE [BacTraderSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FxDuration]    Script Date: 13-05-2022 11:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[FxDuration]
	(	@dFecha			datetime
	,	@NumOper		numeric(9)
	,	@NumDocu		numeric(9)
	,	@Correla		numeric(9)
	,	@Seriado		char(1)
	,	@dFechaInicio	datetime
	,	@dFechaTermino	datetime
	)	returns		float
as
begin

	declare @nDuration	float
		set @nDuration	= 0.0

	if exists( select 1 from	BacTraderSuda.dbo.Mdrs
						where	(rsfecha	>= @dFechaInicio	-->	@dFecha 
							and  rsfecha	<= @dFechaTermino	--> rsfecvtop
								)
						and		rstipoper	= 'DEV'
						and		rscartera	= 114
						and		rsnumoper	= @NumOper
						and		rsnumdocu	= @NumDocu
						and		rscorrela	= @Correla )
	begin

		declare @xFecha		datetime
			set @xFecha		= ( select min( rsfecha )	from	BacTraderSuda.dbo.Mdrs 
														where	(rsfecha	>= @dFechaInicio	-->	@dFecha 
															and  rsfecha	<= @dFechaTermino	--> rsfecvtop
																)
														and		rstipoper	= 'DEV'
														and		rscartera	= 114
														and		rsnumoper	= @NumOper
														and		rsnumdocu	= @NumDocu
														and		rscorrela	= @Correla
							 )

			set @nDuration	= isnull((select top 1 CASE WHEN @Seriado = 'N' THEN DATEDIFF(DAY, rsfecinip, rsfecvtop) / 365.0
														ELSE rsdurat
													END
										from	BacTraderSuda.dbo.Mdrs 
										where	rsfecha		= @xFecha
										and		rstipoper	= 'DEV'
										and		rscartera	= 114
										and		rsnumoper	= @NumOper
										and		rsnumdocu	= @NumDocu
										and		rscorrela	= @Correla
									), 0.0)	
	
	end else
	begin
		set @nDuration = DATEDIFF(DAY, @dFechaInicio, @dFechaTermino) / 365.0

	end

	return @nDuration

end
GO
