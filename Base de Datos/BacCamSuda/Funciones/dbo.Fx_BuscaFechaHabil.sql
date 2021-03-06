USE [BacCamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_BuscaFechaHabil]    Script Date: 11-05-2022 16:35:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[Fx_BuscaFechaHabil]
	(	@Fecha		Datetime
	,	@Dias		Int
	,	@Plaza		Int
	)	Returns		Datetime
as
begin

	--		Variable Para la Salida
	declare @Fecha_Habil	Datetime;		Set @Fecha_Habil	= @Fecha

	declare @Mes			Int
	declare @Campo			Char(50)
	declare @Ano			Int
	declare @Feriado		Char(1)	;		Set @Feriado		= 'S'
	declare @NroDia			Int		;		Set @NroDia			= case when @Dias < 0 then -1 else 1 end
	declare @iContador		Int		;		Set @iContador		= 0

	If @Dias = 0
	Begin
		Return @Fecha_Habil
	End

	while @Feriado = 'S'
	begin
		Set @Fecha_habil	= dateadd(	day,	@Nrodia, @Fecha_Habil)
		Set @Mes			= datepart(	month,	@Fecha_Habil)
		Set @Ano			= datepart(	year ,	@Fecha_Habil)

		Set @Campo			= (	Select case when @Mes = '01' then FeEne
											when @Mes = '02' then FeFeb
											when @Mes = '03' then FeMar
											when @Mes = '04' then FeAbr
											when @Mes = '05' then FeMay
											when @Mes = '06' then FeJun
											when @Mes = '07' then FeJul
											when @Mes = '08' then FeAgo
											when @Mes = '09' then FeSep
											when @Mes = '10' then FeOct
											when @Mes = '11' then FeNov
											when @Mes = '12' then FeDic
										end	
								from	BacParamSuda.dbo.Feriado
								where	FeAno		= @Ano
								and		FePlaza		= @Plaza
								)

		if charindex(substring(convert(char(10), @Fecha_Habil, 103), 1, 2), @Campo) = 0
		begin    
			Set @iContador = @iContador + 1
			if  @iContador = ABS(@dias)
			begin
				Set @feriado = 'N'
			end
		end
	end

	return @Fecha_Habil

end
GO
