USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[LEE_TASAS_MONEDA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[LEE_TASAS_MONEDA]
   (   @iCodMoneda   INTEGER   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT DISTINCT
           Codigo_Moneda
   ,       MnNemo
   ,       Codigo_Tasa
   ,       TbGlosa
   FROM    BacParamSuda..TASAS_MONEDA
           LEFT JOIN BacParamSuda..MONEDA                ON Codigo_Moneda = mncodmon
           LEFT JOIN BacParamSuda..TABLA_GENERAL_DETALLE ON Tbcateg = 1042 and Codigo_Tasa = Tbcodigo1
  WHERE    Codigo_Moneda = @iCodMoneda

END
GO
