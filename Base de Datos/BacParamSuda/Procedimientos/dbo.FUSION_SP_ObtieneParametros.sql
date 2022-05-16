USE [BacParamSuda]
GO
/****** Object:  StoredProcedure [dbo].[FUSION_SP_ObtieneParametros]    Script Date: 13-05-2022 10:53:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FUSION_SP_ObtieneParametros](@id INT,@codigo INT)
AS
BEGIN

IF @codigo = 0

    --  Obtiene Datos de Tabla General Detalle.
	SELECT    codigo, descripcion
	FROM      dbo.FUSION_ParametrosCargaArchivos
	WHERE id = @id  

ELSE 
	SELECT    codigo, descripcion
	FROM      dbo.FUSION_ParametrosCargaArchivos
	WHERE id = @id AND codigo = @codigo


END
GO
