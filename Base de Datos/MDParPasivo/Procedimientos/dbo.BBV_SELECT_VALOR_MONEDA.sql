USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[BBV_SELECT_VALOR_MONEDA]    Script Date: 16-05-2022 11:09:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[BBV_SELECT_VALOR_MONEDA]
AS
select vmcodigo,vmvalor,vmptacmp,vmptavta,vmfecha,vmparidad,vmposini,vmposic,vmtotco,vmtotve
  from VALOR_MONEDA
GO
