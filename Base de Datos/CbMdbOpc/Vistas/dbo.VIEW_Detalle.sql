USE [CbMdbOpc]
GO
/****** Object:  View [dbo].[VIEW_Detalle]    Script Date: 16-05-2022 10:16:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create view [dbo].[VIEW_Detalle]
as
--ASVG_20140312
--Vista para facilitar queries
--No considera múltiples nocionales de Butterfly
--No considera múltiples vencimientos de Strip Asiático
--No considera operaciones con 3 o 4 precios
	select
		  Detalle.[Origen]
		, Detalle.[Número]
		, Detalle.[CallPut]
		, Detalle.[Inicio]
		, Detalle.[Anticipo]
		, Detalle.[Vencimiento]
		, Detalle.[Nocional]
		, Detalle.[Modalidad]
		, Detalle.[Strike]
		, Detalle.[Spread]
		, Detalle.[Strike2]
		, Detalle.[Spot]
		, Detalle.[SpotFwd]
	from
	(
		select
			'Vencida' AS 'Origen'
			, det.CaNumContrato AS 'Número'
			, det.CaCallPut AS 'CallPut'
			, det.CaFechaInicioOpc AS 'Inicio'
			, det.CaFechaPagoEjer AS 'Anticipo'
			, det.CaFechaVcto AS 'Vencimiento'
			, det.CaMontoMon1 AS 'Nocional'
			, COALESCE(cota.CaModalidad, det.CaModalidad) AS 'Modalidad'
			, det.CaStrike AS 'Strike'
			, COALESCE(cota.CaStrike, det2.CaStrike) AS 'Strike2'
			, det.CaPorcStrike AS 'Spread'
			, det.CaSpotDet AS 'Spot'
			, det.CaFwd_teo AS 'SpotFwd'
		FROM CbMdbOpc..CaVenDetContrato det LEFT OUTER JOIN CbMdbOpc..CaVenDetContrato det2
		ON (det.CaNumContrato = det2.CaNumContrato AND det2.CaNumEstructura = 2)
		LEFT OUTER JOIN CbMdbOpc..CaVenDetContrato cota
		ON (det.CaNumContrato = cota.CaNumContrato AND cota.CaNumEstructura = 3)
		where det.CaNumEstructura = 1 --AND det2.CaNumEstructura = 2 AND cota.CaNumEstructura = 3

		UNION

		select
			'Vigente' AS 'Origen'
			, det.CaNumContrato AS 'Número'
			, det.CaCallPut AS 'CallPut'
			, det.CaFechaInicioOpc AS 'Inicio'
			, null AS 'Anticipo' -->Faltaría Ejercicio Forward Americano
			, det.CaFechaVcto AS 'Vencimiento'
			, det.CaMontoMon1 AS 'Nocional'
			, COALESCE(cota.CaModalidad, det.CaModalidad) AS 'Modalidad'
			, det.CaStrike AS 'Strike'
			, COALESCE(cota.CaStrike, det2.CaStrike) AS 'Strike2'
			, det.CaPorcStrike AS 'Spread'
			, det.CaSpotDet AS 'Spot'
			, det.CaFwd_teo AS 'SpotFwd'
		FROM CbMdbOpc..CaDetContrato det LEFT OUTER JOIN CbMdbOpc..CaDetContrato det2
		ON (det.CaNumContrato = det2.CaNumContrato AND det2.CaNumEstructura = 2)
		LEFT OUTER JOIN CbMdbOpc..CaDetContrato cota
		ON (det.CaNumContrato = cota.CaNumContrato AND cota.CaNumEstructura = 3)
		where det.CaNumEstructura = 1 --AND det2.CaNumEstructura = 2 AND cota.CaNumEstructura = 3
	)
	AS Detalle
GO
