USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_RANGO_TASASMAXCONV]    Script Date: 13-05-2022 11:31:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAE_RANGO_TASASMAXCONV]
            ( @xCodigo NUMERIC(5))
AS
BEGIN
   SELECT  moneda ,
  rango ,
  plazo ,
  tasmax  
   FROM BAC_LIMITES_TASAMAXCONV
   WHERE Moneda = @xCodigo       
   ORDER BY Rango
END

GO
