USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Trae_Margen_Inversion]    Script Date: 16-05-2022 11:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_Trae_Margen_Inversion]
AS
BEGIN

SET DATEFORMAT dmy
SET NOCOUNT ON

SELECT 
      


          rut_cartera
      ,   id_sistema
      ,   instrumento= (SELECT inserie FROM INSTRUMENTO WHERE instrumento= incodigo)
      ,   codigo_moneda=(SELECT mnsimbol FROM MONEDA WHERE codigo_moneda=mncodmon AND ESTADO<>'A')
      ,   rut_emisor =(SELECT emgeneric FROM EMISOR WHERE rut_emisor=emrut)
      ,   porcentaje_asignado
      ,   porcentaje_adicional
      ,   porcentaje_utilizado
      ,   totalasignado
      ,   totaladicional
      ,   totalocupado
      ,   totaldisponible
      ,   totalexceso   
         
 FROM MARGEN_INVERSION_INSTRUMENTO
 ORDER BY instrumento
END


GO
