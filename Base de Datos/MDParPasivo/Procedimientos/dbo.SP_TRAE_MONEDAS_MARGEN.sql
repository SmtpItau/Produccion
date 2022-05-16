USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_MONEDAS_MARGEN]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TRAE_MONEDAS_MARGEN]
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   SELECT 
            mnnemo
         ,  mncodmon 
         ,  mnsimbol
         ,  mnglosa

   FROM MONEDA
   WHERE  mnlocal=1   AND ESTADO<>'A'

   ORDER BY mnsimbol 
END


GO
