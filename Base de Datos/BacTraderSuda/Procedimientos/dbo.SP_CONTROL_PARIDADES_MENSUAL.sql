USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CONTROL_PARIDADES_MENSUAL]    Script Date: 13-05-2022 11:31:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_CONTROL_PARIDADES_MENSUAL]
AS
BEGIN

	SET NOCOUNT ON

	DECLARE @iFinMes	INT
		SET @iFinMes	= 0

	SELECT	@iFinMes	= CASE WHEN MONTH( ACFECPRO ) <> MONTH( ACFECPRX ) THEN 1 ELSE 0 END
	FROM	BACCAMSUDA.DBO.MEAC WITH(NOLOCK)

	IF @iFinMes = 1
	BEGIN

		if not exists(	select	Dia		= case	when day(ParMes.Fecha)		< 9 then '0' +	ltrim(rtrim( day(ParMes.Fecha)	 ))
												else										ltrim(rtrim( day(ParMes.Fecha)	 ))
											end
							,	Mes		= case	when month(ParMes.Fecha)	< 9 then '0' +	ltrim(rtrim( month(ParMes.Fecha) ))
												else										ltrim(rtrim( month(ParMes.Fecha) ))
											end
							,	Año		= substring( ltrim(rtrim( year(ParMes.Fecha) )), 3,2)
							,	Moneda	= ParMes.nemo
							,	Paridad	= convert(numeric(11,6), ParMes.Paridad)
							,	Filas	= ParMes.cantidad
						from
							(	select	Fecha		= pos.fecha
									,	Nemo		= mon.mnnemo
									,	Paridad		= convert(numeric(21,4), pos.valor)
									,	cantidad	= row_number () over ( order by mon.mnnemo desc)
								from
									(	select	mnnemo, mncodmon, mnglosa
										from	bacparamsuda.dbo.moneda with(nolock)
										where	mnmx = 'C'
									)	mon
									inner join
									(	select	Fecha	= vmfecha
											,	Nemo	= vmcodigo
											,	valor	= vmparmes
										from	bacparamsuda.dbo.posicion_spt with(nolock)
										where	vmfecha	= ( SELECT ACFECPRO FROM BACCAMSUDA.DBO.MEAC WITH(NOLOCK) )
									)	pos		On pos.Nemo	= mon.mnnemo
							)	ParMes
						)
		begin
			select -1, 'Hoy es el último día hábil del mes, debe ingresar las paridades mensuales del bcch.'
			return -1
		end

		if exists(	select	Dia		= case	when day(ParMes.Fecha)		< 9 then '0' +	ltrim(rtrim( day(ParMes.Fecha)	 ))
											else										ltrim(rtrim( day(ParMes.Fecha)	 ))
										end
						,	Mes		= case	when month(ParMes.Fecha)	< 9 then '0' +	ltrim(rtrim( month(ParMes.Fecha) ))
											else										ltrim(rtrim( month(ParMes.Fecha) ))
										end
						,	Año		= substring( ltrim(rtrim( year(ParMes.Fecha) )), 3,2)
						,	Moneda	= ParMes.nemo
						,	Paridad	= convert(numeric(11,6), ParMes.Paridad)
						,	Filas	= ParMes.cantidad
					from
						(	select	Fecha		= pos.fecha
								,	Nemo		= mon.mnnemo
								,	Paridad		= convert(numeric(21,4), pos.valor)
								,	cantidad	= row_number () over ( order by mon.mnnemo desc)
							from
								(	select	mnnemo, mncodmon, mnglosa
									from	bacparamsuda.dbo.moneda with(nolock)
									where	mnmx = 'C'
								)	mon
								inner join
								(	select	Fecha	= vmfecha
										,	Nemo	= vmcodigo
										,	valor	= vmparmes
									from	bacparamsuda.dbo.posicion_spt with(nolock)
									where	vmfecha	= ( SELECT ACFECPRO FROM BACCAMSUDA.DBO.MEAC WITH(NOLOCK) )
								)	pos		On pos.Nemo	= mon.mnnemo
						)	ParMes
					where	ParMes.Paridad	= 0.0
				)
		begin
			select -1, 'Existen Paridades Mensuales de Fin de Mes en Cero'
			return -1
		end

	END

	SELECT 0, 'OK'
	RETURN 0

END
GO
