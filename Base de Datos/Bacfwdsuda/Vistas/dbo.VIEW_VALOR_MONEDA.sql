USE [Bacfwdsuda]
GO
/****** Object:  View [dbo].[VIEW_VALOR_MONEDA]    Script Date: 13-05-2022 10:34:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE VIEW [dbo].[VIEW_VALOR_MONEDA]
AS
   SELECT
         vmcodigo,
  vmvalor,
  vmptacmp,
  vmptavta,
  vmfecha,
  vmtipo,
  vmparidad,
  vmparmer,
  vmposini,
  vmprecoi,
  vmparini,
  vmprecoc,
  vmparidc,
  vmposic,
  vmpreco,
  vmpreve,
  vmpmeco,
  vmpmeve,
  vmtotco,
  vmtotve,
  vmutili,
  vmparco,
  vmparve,
  vmorden,
  vmctacmb,
  vmcmbini,
  vmreval,
  vmarbit,
  vmparmer1,
  vmnumstgo
   FROM BACPARAMSUDA..VALOR_MONEDA

GO
