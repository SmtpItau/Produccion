USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_ALCO_TRAE_GLOSA_LIMITE]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROC [dbo].[SP_ALCO_TRAE_GLOSA_LIMITE] 
(
			@Codigo_Grupo Integer 
		,	@Codigo_limite Integer 
)
AS 
BEGIN

	SELECT Descripcion 
	from View_tipo_limite
	WHERE Codigo_Grupo_Limite = @Codigo_Grupo AND Codigo_Limite = @Codigo_limite

END

GO
