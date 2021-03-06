USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_SOS_Feriados]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_SOS_Feriados]
	(	@dFecha		datetime
	,	@nDias		int
	,	@iOnlyMn	int
	)	returns		datetime
as
begin

	if @nDias = 0
	begin
		return @dFecha
	end 

	declare @iFound			int;		set @iFound			= 1
	declare @PzaChile		int;		set @PzaChile		= 6
	declare @PzaEEUU		int;		set @PzaEEUU		= 225
	declare @nVueltas		int;		set @nVueltas		= 0
	declare @dFecLiquida	datetime;	set @dFecLiquida	= @dFecha

	while (1 = 1)	--	@nDias >= @nVueltas
	begin

		set @dFecLiquida = dateadd( day, 1, @dFecLiquida)

		set	@iFound	=	(	select	case	when	Datepart(Weekday, @dFecLiquida ) = 7	then 1
											when	Datepart(Weekday, @dFecLiquida ) = 1	then 1
											when	Sum(Feriados.EsFeriado) > 0				then 1
											else	0	
										end
							from	
								(	select	EsFeriado = case when CharIndex( FeriadosMn.Dia, FeriadosMn.Dias ) > 0 then 1 else 0 end
									from	(select	Dias	=	case	when Month( @dFecLiquida ) = 1	then feEne
																		when Month( @dFecLiquida ) = 2	then feFeb
																		when Month( @dFecLiquida ) = 3	then feMar
																		when Month( @dFecLiquida ) = 4	then feAbr
																		when Month( @dFecLiquida ) = 5	then feMay
																		when Month( @dFecLiquida ) = 6	then feJun
																		when Month( @dFecLiquida ) = 7	then feJul
																		when Month( @dFecLiquida ) = 8	then feAgo
																		when Month( @dFecLiquida ) = 9	then feSep
																		when Month( @dFecLiquida ) = 10	then feOct
																		when Month( @dFecLiquida ) = 11	then feNov
																		when Month( @dFecLiquida ) = 12	then feDic 
																	end
												,	Dia		=	Convert(Char(2), case	when Day( @dFecLiquida ) < 10 then '0' + ltrim(rtrim( Day( @dFecLiquida ) )) 
																						else								ltrim(rtrim( Day( @dFecLiquida ) ))
																					end )
												from	BacParamSuda.dbo.Feriado	with(nolock) 
												where	feAno	= Year(@dFecLiquida) 
												and		fePlaza	= @PzaChile
											)	FeriadosMn
								union

								select	EsFeriado = case when CharIndex( FeriadosMx.Dia, FeriadosMx.Dias ) > 0 then 1 else 0 end
								from	(	select	Dias	=	case	when Month( @dFecLiquida ) = 1	then feEne
																		when Month( @dFecLiquida ) = 2	then feFeb
																		when Month( @dFecLiquida ) = 3	then feMar
																		when Month( @dFecLiquida ) = 4	then feAbr
																		when Month( @dFecLiquida ) = 5	then feMay
																		when Month( @dFecLiquida ) = 6	then feJun
																		when Month( @dFecLiquida ) = 7	then feJul
																		when Month( @dFecLiquida ) = 8	then feAgo
																		when Month( @dFecLiquida ) = 9	then feSep
																		when Month( @dFecLiquida ) = 10	then feOct
																		when Month( @dFecLiquida ) = 11	then feNov
																		when Month( @dFecLiquida ) = 12	then feDic 
																	end
												,	Dia		=	Convert(Char(2), case	when Day( @dFecLiquida ) < 10 then '0' + ltrim(rtrim( Day( @dFecLiquida ) )) 
																						else ltrim(rtrim( Day( @dFecLiquida ) ))
																					end )
											from	BacParamSuda.dbo.Feriado	with(nolock)
											where	feAno	= Year(@dFecLiquida) 
											and		fePlaza	= case when @iOnlyMn = 1 then @PzaChile else @PzaEEUU end
										)	FeriadosMx
								)	Feriados
							)

		if @iFound = 0	  --> Habil, Suma un día mas.
			set @nVueltas = @nVueltas + 1

		if @nVueltas = @nDias
			break

	end

	return  @dFecLiquida

end

GO
