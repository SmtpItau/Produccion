USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAE_EMISOR_MARGEN]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_TRAE_EMISOR_MARGEN]
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

   SELECT 
            emcodigo
         ,  emrut
         ,  CONVERT(CHAR(10),emgeneric)
         ,  emnombre

   FROM EMISOR
   ORDER BY emgeneric
END

GO
