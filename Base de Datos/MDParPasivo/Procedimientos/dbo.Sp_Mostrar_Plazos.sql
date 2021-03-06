USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Plazos]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Mostrar_Plazos]
	( @codigo_plazo CHAR(3)='')
AS
BEGIN

   SET DATEFORMAT dmy

	IF @codigo_plazo ='' BEGIN
	   SELECT codigo_plazo, descripcion FROM PLAZO_PACTO ORDER BY descripcion
	END
	ELSE BEGIN
	   SELECT codigo_plazo, descripcion FROM PLAZO_PACTO
		WHERE codigo_plazo = @codigo_plazo
			ORDER BY descripcion
	END
END



GO
