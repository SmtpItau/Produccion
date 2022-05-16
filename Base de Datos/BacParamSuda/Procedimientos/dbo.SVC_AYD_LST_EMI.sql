USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SVC_AYD_LST_EMI]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROCEDURE [dbo].[SVC_AYD_LST_EMI]
AS
BEGIN

	SELECT	emrut
	,	emcodigo
	,	emdv
	,	emnombre
	,	emgeneric
	,	emdirecc
	,	emcomuna
	,	emtipo
	,	emglosa
	,	embonos
	,	clasificacion1
	,	clasificacion2
	,	tipo_corto1
	,	tipo_largo1
	,	tipo_corto2
	,	tipo_largo2
	FROM	EMISOR
	ORDER
	BY	emnombre

/*	SELECT	*
	FROM	text_emi_itl
	order by NOM_EMI
*/

END
GO
