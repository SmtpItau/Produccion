USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Ciudad]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Mostrar_Ciudad]
			( @Codigo_Region CHAR(5)='')
AS
BEGIN

   SET DATEFORMAT dmy

   IF @Codigo_Region = '' 
	BEGIN
	   SELECT codigo_ciudad, codigo_region, nombre FROM CIUDAD ORDER BY nombre
	END
   ELSE
	BEGIN
	   SELECT codigo_ciudad, codigo_region, nombre FROM CIUDAD 
		WHERE codigo_region = CONVERT(NUMERIC(5),@Codigo_Region)
		ORDER BY nombre
	END
END




GO
