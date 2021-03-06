USE [BacTraderSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[Fx_P40_Fecha]    Script Date: 13-05-2022 11:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create function [dbo].[Fx_P40_Fecha]
	(	@nCodigo		int
	,	@cSerie			varchar(20)
	,	@dFechaCupon	datetime
	,	@nNominal		numeric(21,4)
	,	@dFecEmision	datetime
	)	returns			datetime
as
begin

	declare @xFecha		datetime

	if @nCodigo = 20
	begin
		declare @nPerCupon   int
			set @nPerCupon   = ISNULL((SELECT sepervcup FROM BacParamSuda.dbo.SERIE WHERE semascara = SUBSTRING(@cSerie, 1, 6) ), 3)

		select	@xFecha		=	Max(Fecha.tdfecven)
		from	(	select	tdfecven	= Dateadd(Month, tdcupon * @nPerCupon,	@dFecEmision)
					from	BacParamSuda.dbo.TABLA_DESARROLLO
					where	tdmascara	= SUBSTRING(@cSerie, 1, 6)
				)	Fecha
		where	Fecha.tdfecven	<= @dFechaCupon

	end

	if @nCodigo <> 20
	begin
		declare @cSeriado	char(1)
			set	@cSeriado	= isnull((	select	top 1 inmdse
										from	BacParamSuda.dbo.Instrumento 
										where	incodigo = @nCodigo
									), 'N')

		select	@xFecha		=	Max(Fecha.tdfecven)
		from	(	select	tdfecven	= case when @cSeriado = 'S' then tdfecven else isnull(Dateadd(Month, tdcupon * 3, @dFecEmision), @dFecEmision) end
					from	BacParamSuda.dbo.TABLA_DESARROLLO
					where	tdmascara	= @cSerie
				)	Fecha
		where	Fecha.tdfecven	<= @dFechaCupon

		set	@xFecha	= case when @xFecha is null then @dFecEmision else @xFecha end

	end

	return @xFecha
end
GO
