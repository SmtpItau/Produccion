USE [BacTraderSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_P40_Nominal]    Script Date: 13-05-2022 11:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_P40_Nominal]
	(	@nCodigo		int
	,	@cSerie			varchar(20)
	,	@dFechaCupon	datetime
	,	@nNominal		numeric(21,4)
	,	@dFecEmision	datetime
	)	returns			numeric(19,4)
as
begin

	declare @xNominal	numeric(21,4)
		set @xNominal	= 0.0

	if @nCodigo  = 20
	begin
		declare @nPerCupon   int
			set @nPerCupon   = ISNULL((SELECT sepervcup FROM BacParamSuda.dbo.SERIE WHERE semascara = SUBSTRING(@cSerie, 1, 6) ), 3)

		select	@xNominal		= (@nNominal * Saldo.tdsaldo) / 100.0
		from	(	select	tdmascara
						,	tdcupon
						,	tdfecven	= Dateadd(Month, tdcupon * @nPerCupon,	@dFecEmision)
						,	tdsaldo		= case when tdsaldo = 0 then tdamort else tdsaldo end
					from	BacParamSuda.dbo.TABLA_DESARROLLO
					where	tdmascara	= SUBSTRING(@cSerie, 1, 6)
				)	Saldo
		where	Saldo.tdfecven	= @dFechaCupon
	end

	if @nCodigo <> 20
	begin
		select	@xNominal	=	case	when tdsaldo = 0   then (@nNominal	* tdamort) / 100.0    
										when tdsaldo > 100 then (@nNominal)
										else                    (@nNominal	* tdsaldo) / 100.0    
									end
		from	BacParamSuda.dbo.Tabla_Desarrollo
		where	tdmascara	= @cSerie
		and		tdfecven	= @dFechaCupon

		set @xNominal = case when @xNominal = 0 then @nNominal else @xNominal end
	end

	return @xNominal
end
GO
