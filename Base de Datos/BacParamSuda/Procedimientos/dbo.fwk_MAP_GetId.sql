USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_MAP_GetId]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_MAP_GetId] 
(@IdAplicacion NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*
Genera un identificador para el sitio

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_MAP_GetId 'GPB'

*/

BEGIN
	SELECT ISNULL(MAX(id_site) ,0) + 1
	FROM   FWK_SITEMAP
	WHERE  id_aplicacion = @IdAplicacion
END
GO
