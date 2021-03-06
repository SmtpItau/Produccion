USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacInformacionBasica_LeeMonedas]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_BacInformacionBasica_LeeMonedas]
AS
BEGIN

   SET NOCOUNT ON
   SET DATEFORMAT dmy

   SELECT mncodmon
      ,   mnglosa
      ,   mnnemo
      ,   mnsimbol
   INTO #TEMP_MONEDA
   FROM MONEDA
   WHERE mncodmon IN (999, 998, 13)
         AND ESTADO<>'A'

   SET NOCOUNT OFF

   SELECT * FROM #TEMP_MONEDA   ORDER BY mnglosa


END






GO
