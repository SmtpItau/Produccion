USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_MONEDA_FORMA_DE_PAGO]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_MONEDA_FORMA_DE_PAGO]
AS
   SELECT 
        mfsistema,
 mfcodmon,
 mfmonpag,
 mfcodfor,
 mfestado
   FROM BACPARAMSUDA..MONEDA_FORMA_DE_PAGO

GO
