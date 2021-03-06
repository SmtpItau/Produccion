USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEESISTEMASMODOOPERACIONCPT]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEESISTEMASMODOOPERACIONCPT]
AS
BEGIN
	SET NOCOUNT ON
	CREATE TABLE #SistemaTmp(
		idsistema	CHAR(3),
		nombre 		VARCHAR(30)
		)
	INSERT INTO #SistemaTmp
	VALUES('*','>>> TODOS <<<')

	INSERT INTO #SistemaTmp
	SELECT id_sistema, nombre_sistema
	FROM Bacparamsuda..SISTEMA_CNT
	WHERE operativo = 'S' AND gestion = 'N'
	ORDER BY nombre_sistema
	SELECT nombre, idsistema FROM #SistemaTmp
	DROP TABLE #SistemaTmp
	SET NOCOUNT OFF
END

GO
