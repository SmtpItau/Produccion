USE [CbMdbOpc]
GO
/****** Object:  View [dbo].[VIEW_Informe_Cartera]    Script Date: 16-05-2022 10:16:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE view [dbo].[VIEW_Informe_Cartera]
as
--ASVG_20140318
--Vista para Informe_Cartera_SAO a MarketMaking (Pablo Huidobro - Tomás Salgado)
--Se utiliza directamente desde planilla Informe_Cartera_SAO.xlsx
--Llama a VIEW_Cartera

	select
	   [Origen]
	 , [FechaContrato]
	 , [Inicio]
	 , [Anticipo]
	 , [Vencimiento]
	 , [Número]
	 , [Nombre]
	 , CONVERT(money,[Nocional],0) AS 'Nocional'
	 , [C/V]
	 , CASE WHEN [Tipo] = 'Vanilla' then [CallPut] else [Tipo] end AS 'Tipo'
	 , [Modalidad] --- Modalidad (Compensado/Entrega Física)
	 , CONVERT(money,[Spot],0) AS 'Spot Inicio' --- Spot Inicio
	 , CONVERT(money,[SpotFwd],0) AS 'Spot Forward' --- Para calcular puntos Forward.
	 , CONVERT(money,[Strike],0) AS 'Strike/Fwd' --- Precio Forward/Strike
	 , [Strike2] AS 'Strike2/Cota' --- Cota
	 , FijacionEntrada.FijacionEntrada AS 'FijacionEntrada'
	 , FijacionSalida.FijacionSalida AS 'FijacionSalida'
	 , CONVERT(money,comp.Caja,0) AS [Compensación] --- Compensación realizada con el cliente
	 , CONVERT(money,[Utilidad Distribución],0) AS 'Utilidad Distribución' --- Utilidad original de la operación.
	 , [MtM] AS 'Último MtM'
	 , [Operador]
	from
		view_cartera
		LEFT OUTER JOIN
			 (
			  select CaNumContrato,sum(CaCajMtoMon1) AS 'Caja' from CaCaja where CaCajOrigen = 'PV' AND CaCajModalidad = 'C' group by CaNumContrato
			  UNION
			  select CaNumContrato,sum(CaCajMtoMon1) AS 'Caja' from CaVenCaja where CaCajOrigen = 'PV' AND CaCajModalidad = 'C' group by CaNumContrato
			 ) as comp
		ON VIEW_Cartera.Número = comp.CaNumContrato
		LEFT OUTER JOIN
			(
			 select CaNumContrato, AVG(CaFijacion) as FijacionSalida
			 from CaFixing where CaPesoFij > 0
			 group by CaNumContrato, CaPesoFij
			 UNION
			 select CaNumContrato, AVG(CaFijacion) as FijacionSalida
			 from CaVenFixing where CaPesoFij > 0
			 group by CaNumContrato, CaPesoFij
			) as FijacionSalida
		ON VIEW_Cartera.Número = FijacionSalida.CaNumContrato
		LEFT OUTER JOIN
		--supuesto: no hay entrada sin salida.
			(
			 select CaNumContrato, AVG(CaFijacion) as FijacionEntrada
			 from CaFixing where CaPesoFij < 0
			 group by CaNumContrato, CaPesoFij
			 UNION
			 select CaNumContrato, AVG(CaFijacion) as FijacionEntrada
			 from CaVenFixing where CaPesoFij < 0
			 group by CaNumContrato, CaPesoFij
			) as FijacionEntrada
		ON VIEW_Cartera.Número = FijacionEntrada.CaNumContrato

GO
