USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_CONTROL_FINANCIERO]    Script Date: 16-05-2022 10:13:03 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_CONTROL_FINANCIERO]
AS 
SELECT capitalyreserva ,
capitalbasico  ,
monedacontrol  ,
valormoneda  ,
numerotraspaso  ,
porcenconriesgo  ,
porcensinriesgo  ,
porceninvext  ,
montoconriesgo  ,
montosinriesgo  ,
invexttotal  ,
invextocupado  ,
invextdisponible ,
invextexceso  ,
primertramo  ,
segundotramo  ,
tercertramo  ,
margeninstitucion ,
totalcarteraLchr ,
totalporfolio  ,
cajapesos  ,
cajabcch  ,
totalinversiones
FROM bacparamsuda..CONTROL_FINANCIERO

GO
