USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacRiePais_BuscaRiesgoPais]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Sp_BacRiePais_BuscaRiesgoPais] 
AS
BEGIN

	SET DATEFORMAT DMY
	SET NOCOUNT ON


   SELECT   codigo_pais
   ,	    nombre 
   FROM     RIESGO_PAIS 
   ORDER BY codigo_pais	

END




GO
