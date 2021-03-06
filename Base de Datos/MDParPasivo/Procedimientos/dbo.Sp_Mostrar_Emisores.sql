USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Mostrar_Emisores]    Script Date: 16-05-2022 11:09:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE PROCEDURE [dbo].[Sp_Mostrar_Emisores]
	( @codigo_emisores CHAR(3)='')
AS
BEGIN

   SET DATEFORMAT dmy

	IF @codigo_emisores ='' BEGIN
	   SELECT codigo_tipo,descripcion,glosa FROM TIPO_EMISOR ORDER BY descripcion
	END
	ELSE BEGIN
	   SELECT codigo_tipo, descripcion,glosa FROM TIPO_EMISOR
		WHERE codigo_tipo = @codigo_emisores
			ORDER BY descripcion
	END
END



GO
