USE [BacCamSuda]
GO
/****** Object:  View [dbo].[view_cliente_bolsa]    Script Date: 11-05-2022 16:45:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO



CREATE VIEW [dbo].[view_cliente_bolsa]
AS 
	SELECT 	'rut'     = clrut	,
		'codigo'  = clcodigo	,
		'cliente' = bolsa	,
		'nombre'  = nombredata
	FROM 	bacparamsuda..sinacofi 
	WHERE 	bolsa    <> ''	








GO
