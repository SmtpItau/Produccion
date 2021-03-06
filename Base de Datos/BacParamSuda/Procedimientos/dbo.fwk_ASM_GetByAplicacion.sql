USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[fwk_ASM_GetByAplicacion]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[fwk_ASM_GetByAplicacion] 
(@IdAplicacion NVARCHAR(30))
--WITH ENCRYPTION
AS
	/*

Ensambldos por aplicacion

@Autor : Gabriel Ponce (gbrel)
@Fecha : Julio - 2009
@Example: EXEC fwk_ASM_GetByAplicacion 'FFMM'

*/

BEGIN
	SELECT FWK_APLICACIONES_ENSAMBLADOS.id_aplicacion
	      ,FWK_ENSAMBLADOS.id_file
	      ,FWK_ENSAMBLADOS.version
	      ,FWK_ENSAMBLADOS.descripcion
	      ,FWK_ENSAMBLADOS.created_ticks
	       --, DATALENGTH(FWK_ENSAMBLADOS.data) as tamano
	FROM   FWK_APLICACIONES_ENSAMBLADOS
	       INNER JOIN FWK_ENSAMBLADOS
	            ON  FWK_APLICACIONES_ENSAMBLADOS.id_file = FWK_ENSAMBLADOS.id_file
	WHERE  FWK_APLICACIONES_ENSAMBLADOS.id_aplicacion = @IdAplicacion
END
GO
