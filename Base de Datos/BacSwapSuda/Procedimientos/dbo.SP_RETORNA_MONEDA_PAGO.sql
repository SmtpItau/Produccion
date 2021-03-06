USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_RETORNA_MONEDA_PAGO]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RETORNA_MONEDA_PAGO]
   (   @cSistema   CHAR(3)
   ,   @iMoneda    INTEGER
   )
AS 
BEGIN

   SET NOCOUNT ON

   SELECT DISTINCT 
          mncodmon
   ,      mnglosa
   ,      mnnemo
   ,      1
   ,      CONVERT(CHAR(28),LTRIM(RTRIM(mnnemo)) + REPLICATE(' ',3-LEN(LTRIM(RTRIM(mnnemo)))) + ' - ' + LTRIM(RTRIM(mnglosa)))
   FROM   BacParamSuda..MONEDA_FORMA_DE_PAGO 
          INNER JOIN BacParamSuda..MONEDA ON mfmonpag = mncodmon
   WHERE  mfsistema = @cSistema -- and mfcodmon = @iMoneda MAP 20081023 Para no limitar las monedas a elegir
          and mncodmon not in ( 998, 994, 995,  14, 7, 6 )
   order by mncodmon desc
END
GO
