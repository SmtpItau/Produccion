USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_NGINE_LEER_SISTEMA_CNT]    Script Date: 13-05-2022 10:53:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_NGINE_LEER_SISTEMA_CNT]
AS BEGIN
 
SET NOCOUNT ON
	SELECT
		id_sistema, 
		nombre_sistema,
		operativo FROM SISTEMA_CNT
	WHERE 
		operativo='S' 
		AND gestion ='N'
		AND id_sistema in ('BTR','BEX','PCS') 
	ORDER BY nombre_sistema
SET NOCOUNT OFF
END
GO
