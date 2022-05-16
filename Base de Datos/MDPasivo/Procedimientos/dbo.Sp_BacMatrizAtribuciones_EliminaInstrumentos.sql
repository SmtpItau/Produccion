USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[Sp_BacMatrizAtribuciones_EliminaInstrumentos]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[Sp_BacMatrizAtribuciones_EliminaInstrumentos]
		       (
			@control		CHAR(10)			
			)	

AS 

BEGIN

	SET NOCOUNT ON
        SET DATEFORMAT dmy

	DELETE FROM MATRIZ_ATRIBUCION_INSTRUMENTO
	WHERE codigo_control = @Control

	SET NOCOUNT OFF

END



GO
