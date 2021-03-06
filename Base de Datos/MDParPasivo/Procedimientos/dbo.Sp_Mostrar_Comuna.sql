USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Comuna]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Mostrar_Comuna]
		(
		@Codigo_CIUDAD CHAR(5) = ' '
		)
AS BEGIN	
SET DATEFORMAT dmy
SET NOCOUNT ON
   IF @Codigo_CIUDAD = ' '
	BEGIN
	   SELECT codigo_comuna, codigo_ciudad, nombre FROM COMUNA ORDER BY nombre	
	END
  ELSE
	BEGIN
	   SELECT codigo_comuna, codigo_ciudad, nombre FROM COMUNA	
		WHERE Codigo_CIUDAD = CONVERT(NUMERIC(5),@Codigo_CIUDAD)
			ORDER BY nombre
	END
SET NOCOUNT OFF
END





GO
