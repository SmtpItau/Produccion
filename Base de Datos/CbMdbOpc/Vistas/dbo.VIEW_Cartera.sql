USE [CbMdbOpc]
GO
/****** Object:  View [dbo].[VIEW_Cartera]    Script Date: 16-05-2022 10:16:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create view [dbo].[VIEW_Cartera]
as
--ASVG_20140312
--Vista para facilitar queries

	select
		  Cartera.*
	from
	(
		select
			  Encabezado.[Origen]
			--, Encabezado.[Número]
			, Encabezado.[C/V]
			, Encabezado.[Tipo]
			, Encabezado.[Operador]
			, Encabezado.[Nombre]
			, Encabezado.[Utilidad Distribución]
			, Encabezado.[MtM]
			, Detalle.[Número]
			, Detalle.[CallPut]
			, Encabezado.[FechaContrato]
			, Detalle.[Inicio]
			, Detalle.[Anticipo]
			, Detalle.[Vencimiento]
			, Detalle.[Nocional]
			, Detalle.[Modalidad]
			, Detalle.[Strike]
			, Detalle.[Spread]
			, Detalle.[Spot]
			, Detalle.[SpotFwd]
			, Detalle.[Strike2]
		from view_encabezado Encabezado, view_detalle Detalle
		where Encabezado.[Número] = Detalle.[Número]
	) AS Cartera
GO
