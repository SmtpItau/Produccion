USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_TABLA_DESARROLLO_MASCARA]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_TABLA_DESARROLLO_MASCARA]
AS
select
tdmascara,
tdcupon,
tdfecven,
tdinteres,
tdamort,
tdflujo,
tdsaldo
FROM BACPARAMSUDA..TABLA_DESARROLLO --(INDEX=td_serie_cupon)

GO
