USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Corresponsales_CmbPais]    Script Date: 16-05-2022 11:09:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO





CREATE PROCEDURE [dbo].[Sp_Corresponsales_CmbPais]
AS
BEGIN
   SET NOCOUNT ON
   SET DATEFORMAT dmy

   SELECT nombre 
        , codigo_pais

   FROM  PAIS
   ORDER BY nombre
	
SET NOCOUNT OFF
END




GO
