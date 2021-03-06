USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_INTERFAZ_PARIDADESMENSUALESBCCH]    Script Date: 13-05-2022 11:31:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_INTERFAZ_PARIDADESMENSUALESBCCH]
	(	@dFechaProceso		DATETIME	)
AS
BEGIN

	SET NOCOUNT ON

	select	Año		= LTRIM(RTRIM( substring( ltrim(rtrim( year(ParMes.Fecha) )), 1,4) ))
		,	Mes		= case	when month(ParMes.Fecha)	< 9 then '0' +	ltrim(rtrim( month(ParMes.Fecha) ))
							else										ltrim(rtrim( month(ParMes.Fecha) ))
						end
		,	Dia		= case	when day(ParMes.Fecha)		< 9 then '0' +	ltrim(rtrim( day(ParMes.Fecha)	 ))
							else										ltrim(rtrim( day(ParMes.Fecha)	 ))
						end
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
					where	vmfecha	= @dFechaProceso
				)	pos		On pos.Nemo	= mon.mnnemo
		)	ParMes
		order 
		by		cantidad desc

END
GO
