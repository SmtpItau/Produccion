USE [BacSwapSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_MONEDAS_SISTEMA]    Script Date: 13-05-2022 11:02:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_MONEDAS_SISTEMA]
   (   @cSistema   CHAR(3)   )
AS
BEGIN

   SET NOCOUNT ON

   SELECT DISTINCT 
          mncodmon
   ,      mnglosa
   ,      mnnemo
   ,      mpestado
   ,      CONVERT(CHAR(28),LTRIM(RTRIM(mnnemo)) + REPLICATE(' ',3-LEN(LTRIM(RTRIM(mnnemo)))) + ' - ' + LTRIM(RTRIM(mnglosa)))
   FROM   BacParamSuda..PRODUCTO_MONEDA
          INNER JOIN BacParamSuda..MONEDA ON mncodmon = mpcodigo
   WHERE  mpsistema  = 'PCS'
   ORDER BY mnglosa

END
GO
