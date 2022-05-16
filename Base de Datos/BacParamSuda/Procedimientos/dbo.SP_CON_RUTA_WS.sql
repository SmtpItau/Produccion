USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_RUTA_WS]    Script Date: 13-05-2022 10:53:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_CON_RUTA_WS] (
	@CodCategoria as int 
)
AS
BEGIN
	SET NOCOUNT ON;
	SELECT	tbglosa
	FROM	TABLA_GENERAL_DETALLE
	WHERE  tbcateg = @CodCategoria
	ORDER BY tbcodigo1
END

GO
