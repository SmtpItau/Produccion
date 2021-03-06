USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_CLASCLTE_APLICAN_CONTROL_PT]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_CLASCLTE_APLICAN_CONTROL_PT]
AS
BEGIN
	SET NOCOUNT ON

	SELECT	clas.tbcodigo1,
			clas.tbglosa,
			ISNULL(apli.aplicaControl,'N') AS 'aplicaControl'
	FROM	BacParamsuda..TABLA_GENERAL_DETALLE clas
	LEFT JOIN BacParamsuda..TBL_CLASCLTE_APLICAN_CONTROLPT apli
			ON apli.tipoCliente = clas.tbcodigo1
	WHERE	clas.tbcateg = 72
	ORDER BY CONVERT(integer,clas.tbcodigo1)
END
GO
