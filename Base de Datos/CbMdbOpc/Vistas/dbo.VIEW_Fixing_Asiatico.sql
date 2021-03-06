USE [CbMdbOpc]
GO
/****** Object:  View [dbo].[VIEW_Fixing_Asiatico]    Script Date: 16-05-2022 10:16:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create view [dbo].[VIEW_Fixing_Asiatico]
as
	SELECT
		  Fijaciones.[Origen]
		, Fijaciones.[Número]
		, Fijaciones.[Tipo]
		, Fijaciones.[C/V]
		, Fijaciones.[Operador]
		, Fijaciones.[Nombre Cliente]
		, Fijaciones.[Inicio]
		, Fijaciones.[Vencimiento]
		, Fijaciones.[Spread]
		, Fijaciones.[Nocional]
		, Fijaciones.[Modalidad]
		, Fijaciones.[TipoFix]
		, Fijaciones.[FechaFijación]
		, Fijaciones.[ValorFijación]
	FROM
	(
		select
			'Vencida' AS 'Origen'
			, enc.CaNumContrato AS 'Número'
			, o.OpcEstDsc AS 'Tipo'
			, enc.CaCVEstructura 'C/V'
			, enc.CaOperador AS 'Operador'
			, cliente.Clnombre AS 'Nombre Cliente'
			, det.CaFechaInicioOpc AS 'Inicio' --convert(varchar,det.CaFechaInicioOpc,105) AS 'Inicio'
			, det.CaFechaVcto AS 'Vencimiento' --convert(varchar,det.CaFechaVcto,105) AS 'Vencimiento'
			, CONVERT(money,det.CaPorcStrike,0) AS 'Spread'
			, CONVERT(money,det.CaMontoMon1,0) AS 'Nocional'
			, det.CaModalidad AS 'Modalidad'
			, case when CaPesoFij < 0 then 'Entrada' else 'Salida' end AS 'TipoFix'
			, fix.CaFixFecha AS 'FechaFijación' --convert(varchar,fix.CaFixFecha,105) AS 'FechaFijación'
			, fix.CaFijacion AS 'ValorFijación'
			, fix.CaFixFecha --para ordenar

		from CaVenEncContrato enc, OpcionEstructura o, BacParamSudaCLIENTE cliente
		,CaVenDetContrato	det
		, CaVenFixing fix

		where o.OpcEstCod = enc.CaCodEstructura AND enc.CaRutCliente = cliente.Clrut
		AND enc.CaNumContrato = det.CaNumContrato
		AND det.CaNumContrato = fix.CaNumContrato
		AND (enc.CaCodEstructura = 13 OR det.CaTipoPayOff = 02)
		AND enc.CaEstado = ''

		UNION


		select 
			'Vigente' AS 'Origen'
			, enc.CaNumContrato AS 'Número'
			, o.OpcEstDsc AS 'Tipo'
			, enc.CaCVEstructura 'C/V'
			, enc.CaOperador AS 'Operador'
			, cliente.Clnombre AS 'Nombre Cliente'
			, det.CaFechaInicioOpc AS 'Inicio' --convert(varchar,det.CaFechaInicioOpc,105) AS 'Inicio'
			, det.CaFechaVcto AS 'Vencimiento' --convert(varchar,det.CaFechaVcto,105) AS 'Vencimiento'
			, CONVERT(money,det.CaPorcStrike,0) AS 'Spread'
			, CONVERT(money,det.CaMontoMon1,0) AS 'Nocional'
			, det.CaModalidad AS 'Modalidad'
			, case when CaPesoFij < 0 then 'Entrada' else 'Salida' end AS 'TipoFix'
			, fix.CaFixFecha AS 'FechaFijación' --convert(varchar,fix.CaFixFecha,105) AS 'FechaFijación'
			, fix.CaFijacion AS 'ValorFijación'
			, fix.CaFixFecha --para ordenar

		from CaEncContrato enc, OpcionEstructura o, BacParamSudaCLIENTE cliente
		,CaDetContrato	det
		, CaFixing fix

		where o.OpcEstCod = enc.CaCodEstructura AND enc.CaRutCliente = cliente.Clrut
		AND enc.CaNumContrato = det.CaNumContrato
		AND det.CaNumContrato = fix.CaNumContrato
		AND (enc.CaCodEstructura = 13 OR det.CaTipoPayOff = 02)
		AND enc.CaEstado = ''
	 )
	 AS Fijaciones
GO
