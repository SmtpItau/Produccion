USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_IMPUESTO]    Script Date: 13-05-2022 10:37:57 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO

CREATE PROCEDURE [dbo].[SP_LEER_IMPUESTO]
AS
BEGIN

	SET NOCOUNT ON
	
	SELECT 	tbvalor
	FROM	tabla_general_detalle
	WHERE 	tbcateg = 1005

	SET NOCOUNT OFF

END
GO
