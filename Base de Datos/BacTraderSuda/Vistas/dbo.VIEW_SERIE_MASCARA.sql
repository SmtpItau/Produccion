USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_SERIE_MASCARA]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_SERIE_MASCARA]
AS 
SELECT
secodigo,
semascara,
seserie,
serutemi,
sefecemi,
sefecven,
setasemi,
setera,
sebasemi,
semonemi,
secupones,
sediavcup,
sepervcup,
setipvcup,
seplazo,
setipamort,
senumamort,
seffijos,
sebascup,
sedecs,
secorte,
setotalemitido,
primer_vcto_variable,
primer_vencimiento,
tipo_letra
FROM bacparamsuda..serie --(index=serie_mascara)

GO
