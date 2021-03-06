USE [BacParamSuda]
GO
/****** Object:  UserDefinedFunction [dbo].[FxGlProducto]    Script Date: 13-05-2022 10:49:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[FxGlProducto] 
	(	@cModulo	VARCHAR(5)
	,	@cProducto	VARCHAR(15)	
	)	RETURNS VARCHAR(255)
AS
BEGIN

	DECLARE @cDescripcion	VARCHAR(50)

	SELECT	@cDescripcion	= descripcion
	FROM	BacParamSuda.dbo.PRODUCTO
	WHERE	id_sistema		= @cModulo
	AND		codigo_producto	= CASE	WHEN @cModulo = 'PCS' AND @cProducto = 1 THEN 'ST' 
									WHEN @cModulo = 'PCS' AND @cProducto = 2 THEN 'SM'
									WHEN @cModulo = 'PCS' AND @cProducto = 3 THEN 'FR'
									WHEN @cModulo = 'PCS' AND @cProducto = 4 THEN 'SP'
									ELSE LTRIM(RTRIM( @cProducto ))
							  END

	RETURN @cDescripcion

END
GO
