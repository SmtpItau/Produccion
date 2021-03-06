USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_CARGAOPERADORES]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE PROCEDURE [dbo].[SP_CARGAOPERADORES]
AS
SET NOCOUNT ON
SELECT usuario,
CASE 
	WHEN PATINDEX('%-%',nombre) > 0 THEN RTRIM(SUBSTRING(nombre,1,PATINDEX('%-%',nombre)-1)) 
	ELSE nombre 
END AS 'nomUsuario'
FROM USUARIO
WHERE UPPER(tipo_usuario)='TRADER'
ORDER BY usuario
SET NOCOUNT OFF



GO
