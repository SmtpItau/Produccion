USE [BacCamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_Func_Feriados_Contables]    Script Date: 11-05-2022 16:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE function [dbo].[Fx_Func_Feriados_Contables]
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

	declare @PzaChile	int;	set @PzaChile	= 6
	declare @PzaEEUU	int;	set @PzaEEUU	= 225
	declare @iFound		int;	set @iFound		= 1


	if Datepart(Weekday, @dFecha ) = 6
	begin
		set @dFecha = Dateadd( Day, @nDias + 2, @dFecha )
	end else
	begin
		set @dFecha = Dateadd( Day, @nDias, @dFecha )
	end

	while @iFound = 1
	begin

		set	@iFound	=(	select	case	when	Datepart(Weekday, @dFecha ) = 7	then 1
										when	Datepart(Weekday, @dFecha ) = 1	then 1
										when	Sum(Feriados.EsFeriado) > 0		then 1 
										else	0
									end
						from	
							(	select	EsFeriado = case when CharIndex( FeriadosMn.Dia, FeriadosMn.Dias ) > 0 then 1 else 0 end
								from	(	select	Dias	=	case	when Month( @dFecha ) = 1	then feEne
																		when Month( @dFecha ) = 2	then feFeb
																		when Month( @dFecha ) = 3	then feMar
																		when Month( @dFecha ) = 4	then feAbr
																		when Month( @dFecha ) = 5	then feMay
																		when Month( @dFecha ) = 6	then feJun
																		when Month( @dFecha ) = 7	then feJul
																		when Month( @dFecha ) = 8	then feAgo
																		when Month( @dFecha ) = 9	then feSep
																		when Month( @dFecha ) = 10	then feOct
																		when Month( @dFecha ) = 11	then feNov
																		when Month( @dFecha ) = 12	then feDic 
																	end
												,	Dia		=	Convert(Char(2), case	when Day( @dFecha ) < 10 then '0' + ltrim(rtrim( Day( @dFecha ) )) 
																						else								ltrim(rtrim( Day( @dFecha ) ))
																					end )
											from	BacParamSuda.dbo.Feriado 
											where	feAno	= Year(@dFecha) 
											and		fePlaza	= @PzaChile
										)	FeriadosMn
								union

								select	EsFeriado = case when CharIndex( FeriadosMx.Dia, FeriadosMx.Dias ) > 0 then 1 else 0 end
								from	(	select	Dias	=	case	when Month( @dFecha ) = 1	then feEne
																		when Month( @dFecha ) = 2	then feFeb
																		when Month( @dFecha ) = 3	then feMar
																		when Month( @dFecha ) = 4	then feAbr
																		when Month( @dFecha ) = 5	then feMay
																		when Month( @dFecha ) = 6	then feJun
																		when Month( @dFecha ) = 7	then feJul
																		when Month( @dFecha ) = 8	then feAgo
																		when Month( @dFecha ) = 9	then feSep
																		when Month( @dFecha ) = 10	then feOct
																		when Month( @dFecha ) = 11	then feNov
																		when Month( @dFecha ) = 12	then feDic 
																	end
												,	Dia		=	Convert(Char(2), case	when Day( @dFecha ) < 10 then '0' + ltrim(rtrim( Day( @dFecha ) )) 
																						else								ltrim(rtrim( Day( @dFecha ) ))
																					end )
											from	BacParamSuda.dbo.Feriado 
											where	feAno	= Year(@dFecha) 
											and		fePlaza	= case when @iOnlyMn = 1 then @PzaChile else @PzaEEUU end
										)	FeriadosMx

								)	Feriados
							)
		
		if @iFound = 1	--> Feriado, Suma un día mas.
			set @dFecha	= Dateadd( Day, 1, @dFecha)

	end	--> While @iFound = 1

	return @dFecha

end
GO
