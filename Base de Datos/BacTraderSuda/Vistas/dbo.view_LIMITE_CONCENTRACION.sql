USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[view_LIMITE_CONCENTRACION]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

create view [dbo].[view_LIMITE_CONCENTRACION]
as
select	Codigo_Limite		,
	Incodigo		,
	Rut_Emisor		,
	Outstanding		,
	Outstanding_Filial	,
	Outstandig_Total	,
	Monto_Emision		,
	Porc_Limite		,
	Monto_Limite		,
	Disponible                                            

from BacParamSuda..LIMITE_CONCENTRACION

GO
