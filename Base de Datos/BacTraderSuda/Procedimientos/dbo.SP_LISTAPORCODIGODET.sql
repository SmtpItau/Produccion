USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAPORCODIGODET]    Script Date: 13-05-2022 11:31:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_LISTAPORCODIGODET]
/*
JBH, 04-11-2009  Retorna un valor o listado de datos de TABLA_GENERAL_DETALLE
Si @Codigo viene vacío lista todos los registros, en caso contrario solo aquel que calza.
*/
@Categoria 	NUMERIC(5),
@Codigo	CHAR(6)=''
AS
SET NOCOUNT ON
IF	RTRIM(LTRIM(@Codigo)) = ''
	SELECT 	tbglosa, tbcodigo1
	FROM 	bacparamsuda.dbo.TABLA_GENERAL_DETALLE 
	WHERE	tbcateg = @Categoria
	ORDER BY tbcodigo1
ELSE
	SELECT 	tbglosa, tbcodigo1
	FROM 	bacparamsuda.dbo.TABLA_GENERAL_DETALLE 
	WHERE	tbcateg = @Categoria
	AND	tbcodigo1 = @Codigo
	ORDER BY tbcodigo1
SET NOCOUNT OFF


GO
