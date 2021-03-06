USE [MDParPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMatrizAtribuciones_GrabaInstrumentos]    Script Date: 16-05-2022 11:09:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_BacMatrizAtribuciones_GrabaInstrumentos]
		       (
			@Control		CHAR(10),
			@usuario		CHAR(15),
			@codigo_producto	CHAR(5),
			@incodigo		CHAR(5),
			@plazo_desde		NUMERIC(5,0),
			@plazo_hasta		NUMERIC(5,0),
			@montoinicio		NUMERIC(19,4),
			@montofinal		NUMERIC(19,4)
			)	

AS 
BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy
	
	INSERT INTO MATRIZ_ATRIBUCION_INSTRUMENTO

		       (
			codigo_control,
			usuario,
			codigo_producto,
			incodigo,
			plazo_desde,
			plazo_hasta,
			montoinicio,
			montofinal
			)

		VALUES
		       (
			@Control,
			@usuario,
			@codigo_producto,
			@incodigo,
			@plazo_desde,
			@plazo_hasta,
			@montoinicio,
			@montofinal
			)

        
	SET NOCOUNT OFF

END












GO
