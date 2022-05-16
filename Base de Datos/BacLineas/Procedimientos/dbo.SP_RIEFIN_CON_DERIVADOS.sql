USE [BacLineas]
GO
/****** Object:  StoredProcedure [dbo].[SP_RIEFIN_CON_DERIVADOS]    Script Date: 13-05-2022 10:37:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_RIEFIN_CON_DERIVADOS]
AS
BEGIN
	SET NOCOUNT ON	
	
	SELECT	AG.Id_Sistema 
	,		SI.nombre_sistema
	FROM	TBL_AGRPROD AG
			INNER JOIN BACPARAMSUDA..SISTEMA_CNT SI ON AG.id_sistema = SI.id_sistema
	WHERE	AG.id_grupo = 'DRV'
	
	SET NOCOUNT OFF
END
GO
