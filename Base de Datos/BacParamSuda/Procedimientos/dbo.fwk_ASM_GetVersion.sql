USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_ASM_GetVersion]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_ASM_GetVersion] 
(@IdAplicacion NVARCHAR(30) ,@IdFile NVARCHAR(100))
--WITH ENCRYPTION
AS
	/*
Version del ensamblado

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_ASM_GetVersion 'FFMM', 'Common.Toolbox.dll'

*/

BEGIN
	SELECT FWK_ENSAMBLADOS.version
	FROM   FWK_ENSAMBLADOS
	       INNER JOIN FWK_APLICACIONES_ENSAMBLADOS
	            ON  FWK_ENSAMBLADOS.id_file = FWK_APLICACIONES_ENSAMBLADOS.id_file
	WHERE  FWK_APLICACIONES_ENSAMBLADOS.id_aplicacion = @IdAplicacion
	       AND FWK_APLICACIONES_ENSAMBLADOS.id_file = @IdFile
END
GO
