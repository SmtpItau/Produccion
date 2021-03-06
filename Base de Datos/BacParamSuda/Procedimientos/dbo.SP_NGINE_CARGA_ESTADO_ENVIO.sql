USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NGINE_CARGA_ESTADO_ENVIO]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_NGINE_CARGA_ESTADO_ENVIO]
	(@tbcateg NUMERIC(4)
	)
AS
BEGIN
	-- 9926 = Pendiente envio
	-- 9927 = Envio
	-- 9928 = Anulacion

	SELECT
		tbcodigo1,tbglosa,nemo 
	FROM
		bacparamsuda..TABLA_GENERAL_DETALLE 
	WHERE
		tbcateg = @tbcateg
	ORDER BY TBCODIGO1
END
GO
