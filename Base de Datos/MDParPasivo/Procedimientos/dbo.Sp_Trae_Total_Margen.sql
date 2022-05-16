USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Total_Margen]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Trae_Total_Margen]
                 (
                  @rut  numeric (9)
                  )
AS
BEGIN
SET DATEFORMAT dmy
SET NOCOUNT ON

SELECT 
      TOTALOCUPADO
FROM MARGEN_INVERSION_INSTRUMENTO
WHERE rut_cartera=@rut
END








GO
