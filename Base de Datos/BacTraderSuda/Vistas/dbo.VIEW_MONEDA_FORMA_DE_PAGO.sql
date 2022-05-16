USE [BacTraderSuda]
GO
/****** Object:  View [dbo].[VIEW_MONEDA_FORMA_DE_PAGO]    Script Date: 16-05-2022 10:13:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_MONEDA_FORMA_DE_PAGO]
AS 
SELECT	mfcodmon,
	mfcodfor,
	mfmonpag,
	mfsistema,
	mfestado
FROM  bacparamsuda..MONEDA_FORMA_DE_PAGO

GO
