USE [MDPasivo]
GO
/****** Object:  StoredProcedure [dbo].[SP_CON_EJECUTIVO]    Script Date: 16-05-2022 11:18:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO


CREATE PROC [dbo].[SP_CON_EJECUTIVO](@iArea CHAR(5),
                                 @iEntidad NUMERIC(10),
                                 @iCodigo  NUMERIC(10))
AS
BEGIN

	SET NOCOUNT ON	
        SET DATEFORMAT dmy

	SELECT Rut_Ejecutivo,Codigo_Ejecutivo,Nombre_Ejecutivo
	FROM EJECUTIVO
        WHERE Area_Ejecutivo= @iarea
        AND  Codigo_Entidad = @iCodigo
        AND  Rut_Entidad = @iEntidad
	ORDER BY Nombre_ejecutivo


END



GO
