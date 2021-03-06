USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Plaza]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[Sp_Mostrar_Plaza]
	( @Codigo_PAIS CHAR(5)=' ')
AS BEGIN	
SET DATEFORMAT dmy
SET NOCOUNT ON
   IF @Codigo_PAIS = ' ' 
	BEGIN
	   SELECT codigo_plaza, codigo_pais, nombre, glosa  FROM PLAZA ORDER BY nombre
	END
  ELSE
	BEGIN
	   SELECT codigo_plaza, codigo_pais, nombre, glosa FROM PLAZA
		WHERE codigo_pais = CONVERT(NUMERIC(5),@Codigo_PAIS)
			ORDER BY nombre
	END
SET NOCOUNT OFF
END





GO
