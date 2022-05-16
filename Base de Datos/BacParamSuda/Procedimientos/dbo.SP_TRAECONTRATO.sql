USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_TRAECONTRATO]    Script Date: 13-05-2022 10:53:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_TRAECONTRATO]	(	@Sistema	CHAR(5) = ''	)
AS
BEGIN

	SELECT	Codigo
	,	Descripcion
	FROM	TBL_DCTOS_CONTRATOS_DERIVADOS
	WHERE	SISTEMA = @Sistema	or @sistema = ''
	ORDER 
	BY	Indice_Orden 
END

GO
