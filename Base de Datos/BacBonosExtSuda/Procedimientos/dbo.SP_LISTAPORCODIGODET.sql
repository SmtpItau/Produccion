USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LISTAPORCODIGODET]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SP_LISTAPORCODIGODET]
(
@Categoria 	NUMERIC(5),
@Codigo	CHAR(6)=''
)
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
