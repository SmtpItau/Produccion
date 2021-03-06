USE [CbMdbOpc]
GO
/****** Object:  View [dbo].[VIEW_Encabezado]    Script Date: 16-05-2022 10:16:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create view [dbo].[VIEW_Encabezado]
as
--ASVG_20140312
--Vista para facilitar queries
	select
		  Encabezado.[Origen]
		, Encabezado.[Número]
		, Encabezado.[FechaContrato]
		, Encabezado.[C/V]
		, Encabezado.[Tipo]
		, Encabezado.[Operador]
		, Encabezado.[Nombre]
		, Encabezado.[Utilidad Distribución]
		, Encabezado.[MtM]
	from
	(
		select
			case when UltimaTransaccion.MoEstado = 'N' then 'Anticipada' else 'Vencida' end AS 'Origen' --1317
			, enc.CaNumContrato AS 'Número'
			, enc.CaFechaContrato AS 'FechaContrato'
			, enc.CaCVEstructura AS 'C/V'
			, oe.OpcEstDsc AS 'Tipo'
			, enc.CaOperador AS 'Operador'
			--, enc.CaRutCliente AS 'Rut'
			, cli.Clnombre AS 'Nombre'
			, enc.CaResultadoVentasML AS 'Utilidad Distribución'
			, enc.CaVr AS 'MtM'
		from CbMdbOpc..CaVenEncContrato enc, CbMdbOpc..OpcionEstructura oe, BacParamSuda..CLIENTE cli
			, (	select MoHisEncContrato.MoNumContrato, MoEstado, MoTipoTransaccion
				from MoHisEncContrato, (select MoNumContrato, max(MoNumFolio) as UltimoFolio from MoHisEncContrato group by MoNumContrato) as UltimoHis
				where MoHisEncContrato.MoNumFolio = UltimoHis.UltimoFolio
				) as UltimaTransaccion
		where enc.CaCodEstructura = oe.OpcEstCod AND enc.CaEstado = ''
		 AND enc.CaRutCliente = cli.Clrut AND enc.CaCodigo = cli.Clcodigo
		 AND enc.CaNumContrato = UltimaTransaccion.MoNumContrato

		UNION

		select
			'Vigente' AS 'Origen'
			, enc.CaNumContrato AS 'Número'
			, enc.CaFechaContrato AS 'FechaContrato'
			, enc.CaCVEstructura AS 'C/V'
			, oe.OpcEstDsc AS 'Tipo'
			, enc.CaOperador AS 'Operador'
			--, enc.CaRutCliente AS 'Rut'
			, cli.Clnombre AS 'Nombre'
			, enc.CaResultadoVentasML AS 'Utilidad Distribución'
			, enc.CaVr AS 'MtM'
		from CbMdbOpc..CaEncContrato enc, CbMdbOpc..OpcionEstructura oe, BacParamSuda..CLIENTE cli
		where enc.CaCodEstructura = oe.OpcEstCod AND enc.CaEstado = ''
		 AND enc.CaRutCliente = cli.Clrut AND enc.CaCodigo = cli.Clcodigo
	)
	AS Encabezado
GO
