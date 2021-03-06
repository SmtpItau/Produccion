USE [BacParamSuda]
GO
/****** Object:  View [dbo].[TBL_HEDGE_FWD]    Script Date: 13-05-2022 10:59:00 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE VIEW [dbo].[TBL_HEDGE_FWD]
AS
SELECT MFCARES.CaFechaProceso
, MFCARES.canumoper
, MFCARES.cafecha
, MFCARES.catipoper
, MFCARES.catipmoda
, VIEW_MONEDA.mnnemo mnnemo1
, VIEW_MONEDA_1.mnnemo mnnemo2
, MFCARES.camtomon1
, MFCARES.camtomon2
, MFCARES.capremon1
, MFCARES.catipcam
, MFCARES.cafecvcto
, MFCARES.camarktomarket
, MFCARES.cacodpos1
, MFCARES.caoperador
, MFCARES.ValorRazonableActivo
, MFCARES.ValorRazonablePasivo
, MFCARES.fRes_Obtenido
, MFCARES.catasaufclp
, MFCARES.catasadolar
, MFCARES.fVal_Obtenido
FROM Bacfwdsuda.dbo.MFCARES MFCARES
, Bacfwdsuda.dbo.VIEW_MONEDA VIEW_MONEDA
, Bacfwdsuda.dbo.VIEW_MONEDA VIEW_MONEDA_1
WHERE MFCARES.cacodmon1 = VIEW_MONEDA.mncodmon 
AND MFCARES.cacodmon2 = VIEW_MONEDA_1.mncodmon 
AND ((MFCARES.CaFechaProceso='20100811'))


GO
