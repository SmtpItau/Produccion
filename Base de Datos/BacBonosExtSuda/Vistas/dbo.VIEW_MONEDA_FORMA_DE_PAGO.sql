USE [BacBonosExtSuda]
GO
/****** Object:  View [dbo].[VIEW_MONEDA_FORMA_DE_PAGO]    Script Date: 11-05-2022 16:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[VIEW_MONEDA_FORMA_DE_PAGO]
AS
select 
mfcodmon,
mfcodfor,
mfmonpag,
mfsistema,
mfestado 
from bacparamsuda..MONEDA_FORMA_DE_PAGO



GO
