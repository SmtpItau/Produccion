USE [Reportes]
GO
/****** Object:  StoredProcedure [dbo].[SP_ADM_REPORTE_PASIVOS_34A_2]    Script Date: 16-05-2022 10:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_ADM_REPORTE_PASIVOS_34A_2]
(
	@FechaProceso  datetime
)
as 
begin

declare @ValorUF	  as float
--set @FechaProceso = (select acfecproc from BacTraderSuda..MDAC with(nolock))
set @ValorUF	  = (select vmvalor from BacParamSuda..VALOR_MONEDA with(nolock) where vmcodigo = 998 AND vmfecha = @FechaProceso )


select	Folio			= cp.numero_operacion
	,	Correlativo		= cp.numero_correlativo
	,	Serie			= cp.nombre_serie
	,	Fecha			= fb.fecha_vencimiento
	,	Div				= fb.numero_cupon
	,	Amort			= fb.amortizacion
	,	Interes			= fb.interes
	,	Saldo			= fb.saldo
	,	Flujo			= isnull((abs( fb.amortizacion) + abs(fb.interes)), 0)--fb.flujo
	,	TirDiario		= CAST(ROUND(POWER((1.0+cp.tasa_colocacion/100), (1.0/365))-1.0, 11) AS FLOAT)

	----------------------------------
	,	Plazo			= CASE WHEN fb.fecha_vencimiento  >= @FechaProceso 
									then  DATEDIFF(DAY, @FechaProceso, fb.fecha_vencimiento)
									else ''
									END
	,	Variacion	= CASE WHEN fb.fecha_vencimiento >= @FechaProceso
									THEN 								
										CASE WHEN POWER((1+(CAST(ROUND(POWER((1.0+cp.tasa_colocacion/100), (1.0/365))-1.0, 11) AS FLOAT))),DATEDIFF(DAY, @FechaProceso, fb.fecha_vencimiento)) = 0 THEN 0 ELSE isnull((abs( fb.amortizacion) + abs(fb.interes)), 0)/POWER((1+(CAST(ROUND(POWER((1.0+cp.tasa_colocacion/100), (1.0/365))-1.0, 11) AS FLOAT))),DATEDIFF(DAY, @FechaProceso, fb.fecha_vencimiento)) END
									else 0
									END

	,	Campo1			= CASE WHEN fb.fecha_vencimiento >= @FechaProceso
									THEN cp.nominal * @ValorUF * (CASE WHEN POWER((1+(CAST(ROUND(POWER((1.0+cp.tasa_colocacion/100), (1.0/365))-1.0, 11) AS FLOAT))),DATEDIFF(DAY, @FechaProceso, fb.fecha_vencimiento)) = 0 THEN 0 ELSE (isnull((abs( fb.amortizacion) + abs(fb.interes)), 0)/POWER((1+(CAST(ROUND(POWER((1.0+cp.tasa_colocacion/100), (1.0/365))-1.0, 11) AS FLOAT))),DATEDIFF(DAY, @FechaProceso, fb.fecha_vencimiento))) END)
									ELSE 0
									END

	,	Campo2			= CASE WHEN fb.fecha_vencimiento >= @FechaProceso
									THEN  (CASE WHEN (POWER((1+(CAST(ROUND(POWER((1.0+cp.tasa_colocacion/100), (1.0/365))-1.0, 11) AS FLOAT))),DATEDIFF(DAY, @FechaProceso, fb.fecha_vencimiento))) = 0 THEN 0 ELSE (fb.interes/POWER((1+(CAST(ROUND(POWER((1.0+cp.tasa_colocacion/100), (1.0/365))-1.0, 11) AS FLOAT))),DATEDIFF(DAY, @FechaProceso, fb.fecha_vencimiento))) END) * CP.nominal * @ValorUF
									ELSE 0
									END
	--,	Id				= cp.codigo_instrumento
from		MdPasivo.dbo.CARTERA_PASIVO cp	with(nolock) ----> solo 2 en cartera
inner  join MDPasivo..FLUJO_BONOS fb with(nolock) ----->26 de cortes
			on cp.nombre_serie			= fb.nombre_serie
inner join	MDPasivo..SERIE_PASIVO sp with(nolock)
			on  sp.codigo_instrumento	= cp.codigo_instrumento
			and sp.nombre_serie			= cp.nombre_serie
			and sp.bono_subordinado		= 'S'

left join (select	vmvalor
				,	vmfecha	
			 from BacParamSuda..VALOR_MONEDA with(nolock) 
			 where vmcodigo = 998 
		) vm on vm.vmfecha =  cp.fecha_colocacion

where cp.codigo_instrumento = 15
ORDER BY Folio, Correlativo, Div

END
GO
