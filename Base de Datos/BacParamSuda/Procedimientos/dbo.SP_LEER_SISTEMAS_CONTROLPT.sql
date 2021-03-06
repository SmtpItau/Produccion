USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_LEER_SISTEMAS_CONTROLPT]    Script Date: 13-05-2022 10:53:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_LEER_SISTEMAS_CONTROLPT]
AS
BEGIN
	SET NOCOUNT ON
	SELECT id_sistema, nombre_sistema 
	FROM SISTEMA_CNT 
    	WHERE operativo = 'S' 
	AND gestion   = 'N'
	AND id_sistema IN ('BCC','BEX','BFW','BTR','PCS')
	ORDER BY nombre_sistema
END 
GO
