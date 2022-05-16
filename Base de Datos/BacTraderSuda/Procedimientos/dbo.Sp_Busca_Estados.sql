USE [BacTraderSuda]
GO
/****** Object:  StoredProcedure [dbo].[Sp_Busca_Estados]    Script Date: 13-05-2022 11:31:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
 
CREATE PROCEDURE  [dbo].[Sp_Busca_Estados]
AS
BEGIN

	SELECT 	Descripcion,codigo_estado_de_Informacion 
	FROM 	dbo.ESTADO_DE_INFORMACION 
	ORDER 
	BY 	CODIGO_ESTADO_DE_INFORMACION	

END
-- Base de Datos --
GO
