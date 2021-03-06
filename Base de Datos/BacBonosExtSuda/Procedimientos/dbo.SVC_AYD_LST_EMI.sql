USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_AYD_LST_EMI]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SVC_AYD_LST_EMI]
AS
BEGIN

	SELECT	rut_emi
		,	codigo
		,	digito_ver 
		,	nom_emi = SUBSTRING(nom_emi, 1, 40)
		,	clasificacion1
		,	clasificacion2
		,	tipo_corto1
		,	tipo_largo1
		,	tipo_corto2
		,	tipo_largo2
	FROM	text_emi_itl
	order 
	by		NOM_EMI
END



GO
