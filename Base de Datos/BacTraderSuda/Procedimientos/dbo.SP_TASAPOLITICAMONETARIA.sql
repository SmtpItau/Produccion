USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TASAPOLITICAMONETARIA]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SP_TASAPOLITICAMONETARIA]
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @dFecha DATETIME

    SELECT @dFecha = MAX(vmfecha) FROM bacparamsuda..valor_moneda WHERE vmcodigo = 807 AND vmvalor <> 0
  
    SELECT vmvalor FROM bacparamsuda..valor_moneda WHERE vmcodigo = 807 AND vmvalor <> 0 AND vmfecha = @dFecha

    SET NOCOUNT OFF

END

GO
