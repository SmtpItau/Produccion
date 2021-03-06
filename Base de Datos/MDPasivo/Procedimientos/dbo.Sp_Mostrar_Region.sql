USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Region]    Script Date: 16-05-2022 11:18:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Mostrar_Region]
	(   @Codigo_Pais   CHAR(5) = ' '  )
AS
BEGIN

   SET DATEFORMAT dmy
   SET NOCOUNT ON

   IF @Codigo_Pais = ' '
   BEGIN

	SELECT codigo_region, codigo_pais, nombre
	FROM REGION
	ORDER BY nombre

   END ELSE BEGIN

	SELECT codigo_region, codigo_pais, nombre
	FROM REGION
	WHERE @Codigo_Pais = codigo_pais
	ORDER BY nombre

   END

END


GO
