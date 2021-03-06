USE [BacBonosExtSuda]
GO
/****** Object:  StoredProcedure [dbo].[SP_EXITE_CURVA_FECHA_PROCESO]    Script Date: 11-05-2022 16:29:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SP_EXITE_CURVA_FECHA_PROCESO]
			(@acfecproc DATETIME
			,@cCurvaPrincipal VARCHAR(20))

AS
BEGIN 

	DECLARE @Existe NUMERIC(9)
	
	SELECT @Existe = COUNT(*)
	FROM BacParamSuda.dbo.CURVAS   
	WHERE FechaGeneracion = @acfecproc   
	AND  CodigoCurva  = @cCurvaPrincipal
	
	IF @Existe <> 0
	BEGIN
		SELECT 1
	END
	ELSE
	BEGIN
		SELECT 0
	END
	
	
	
END
GO
