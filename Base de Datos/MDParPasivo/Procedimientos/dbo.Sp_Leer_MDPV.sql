USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Leer_MDPV]    Script Date: 16-05-2022 11:09:34 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROC [dbo].[Sp_Leer_MDPV]
AS
BEGIN
  


   	SET DATEFORMAT DMY
	SET NOCOUNT ON

      SELECT 	 pvcodigo   	,	
		 pvserie    	,
        	 pvporcentaje	
	FROM 	 PORCENTAJE_VARIACION
	ORDER BY pvserie
 END
 


GO
